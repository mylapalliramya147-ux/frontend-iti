<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plcmt Schedule Datewise Data</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/siteScript.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- ITIAP uses server sessions, NOT the JWT the original page used -->
<script>
var jwtToken = '';
var roleId   = '<c:out value="${sessionScope.roleId}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';   /* e.g. http://localhost:5050/ */
</script>
<style>
#scrollbar {
width: 100%;
height: 500px;
overflow-x: auto;
overflow-y: auto;
text-align: justify;
}
#reporttable th{ position: sticky; top: 0px; background-color: black; color: white; }
</style>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

});
</script>
</head>
<body>

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container-fluid">

    <!-- Home -->
    <a class="navbar-brand" href="${pageContext.request.contextPath}/placements/loginSuccess">
        <i class="fas fa-home"></i> Home
    </a>

    <!-- Welcome User Info -->
    <div class="text-white fw-bold">
        Welcome :
        <span id="userinfo"></span>
    </div>

    <!-- Logout -->
    <div>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

</div>
</nav>

<div class="container border p-2 mt-2 shadow-lg" id="formdiv">
<div align="center" style="text-decoration: underline;color: fuchsia;">SCHEDULE DATE WISE PLACEMENTS DATA</div>

<div class="row">
<div class="col-md-3">
<label for="fromDate">Schedule From Date</label>
<input type="date" id="fromDate" class="form-control"/>
</div>
<div class="col-md-3">
<label for="toDate">Schedule To Date</label>
<input type="date" id="toDate" class="form-control"/>
</div>
<div class="col-md-3">
<label for="ptype">Schedule Type</label>
<select id="ptype" class="form-control">
<option value="">-SELECT-</option>
<option value="Job">JOB</option>
<option value="Apprenticeship">APPRENTICESHIP</option>
</select>
</div>
<div class="col-md-3">
<button class="btn btn-sm btn-success mt-4" onclick="return getData();">GET DATA</button>
</div>
</div>

</div>

<div class="d-flex justify-content-center" id="loadmsg">
</div>
<div class="container-fluid p-2 mt-2 " id="reportdiv" style="display: none;">
<div align="center" style="text-decoration: underline;color: fuchsia;">FILTER DATA BASED ON BELOW OPTIONS</div>
<div class="row mb-1 border p-2 mt-2 shadow-lg">
<div class="col-3">
<label for="distcode">District</label> <select id="distcode"
class="form-control"
onchange="return filterData('changedistcode');">
</select>
</div>
<div class="col-3">
<label for="iticode">ITI</label> <select id="iticode"
class="form-control" onchange="return filterData('changeiticode');">
</select>
</div>
<div class="col-3">

</div>
<div class="col-3">
<div class="d-flex justify-content-center">
<button onclick="return fnExcelReport('reporttable');"
class="btn btn-success btn-sm mt-4">DOWNLOAD EXCEL</button>
<button onclick="return reloadpage();"
class="btn btn-info btn-sm mt-4">GO BACK</button>
</div>

</div>

</div>

<div id="tablediv">
<div id="scrollbar">
<table class="table table-bordered" id="reporttable">
<thead>
<tr>
<th>S.NO</th>
<th>SCHEDULE ID</th>
<th>SCHEDULE DATE</th>
<th>DISTRICT</th>
<th>ITI NAME</th>
<th>TYPE</th>
<th>DESCRIPTION</th>
<th>VACANCIES</th>
<th>ATTENDED</th>
<th>SELECTED</th>
<th>NO OF RECORDS</th>
</tr>
</thead>
<tbody id="reportdata">

</tbody>
</table>
</div>
</div>
</div>

<script>
var API = baseUrl + 'api/placements';
var allRows = [];

function getData() {
    var fromDate = document.getElementById('fromDate').value;
    var toDate = document.getElementById('toDate').value;
    var ptype = document.getElementById('ptype').value;
    if (!fromDate) { alert('Please select Schedule From Date'); return false; }
    if (!toDate) { alert('Please select Schedule To Date'); return false; }
    if (!ptype) { alert('Please select Schedule Type'); return false; }
    if (fromDate > toDate) { alert('From Date cannot be after To Date'); return false; }
    document.getElementById('formdiv').style.display = 'none';
    document.getElementById('loadmsg').innerHTML = '<div class="spinner-border text-primary mt-2" role="status"></div><p class="fw-bold mt-1">Loading data...</p>';
    document.getElementById('reportdiv').style.display = 'none';
    var qs = '?fromDate=' + encodeURIComponent(fromDate) + '&toDate=' + encodeURIComponent(toDate)
           + (ptype ? '&ptype=' + encodeURIComponent(ptype) : '');
    fetch(API + '/datewise/schedules' + qs)
        .then(function (r) { return r.json(); })
        .then(function (data) {
            allRows = data || [];
            populateDistFilter();
            populateItiFilter();
            renderTable(allRows);
            document.getElementById('loadmsg').innerHTML = '';
            document.getElementById('reportdiv').style.display = 'block';
        })
        .catch(function (err) {
            document.getElementById('loadmsg').innerHTML = '';
            alert('Error loading data: ' + err.message);
        });
    return false;
}

function populateDistFilter() {
    var sel = document.getElementById('distcode');
    sel.innerHTML = '<option value="">-ALL DISTRICTS-</option>';
    var seen = {};
    allRows.forEach(function (row) {
        var code = row.distCode || '';
        if (code && !seen[code]) {
            seen[code] = true;
            var opt = document.createElement('option');
            opt.value = code;
            opt.text = row.distName || code;
            sel.appendChild(opt);
        }
    });
}

function populateItiFilter() {
    var distcode = document.getElementById('distcode').value;
    var sel = document.getElementById('iticode');
    sel.innerHTML = '<option value="">-ALL ITIs-</option>';
    var seen = {};
    allRows.forEach(function (row) {
        if (distcode && (row.distCode || '') !== distcode) return;
        var name = row.itiName || '-';
        if (!seen[name]) {
            seen[name] = true;
            var opt = document.createElement('option');
            opt.value = name;
            opt.text = name;
            sel.appendChild(opt);
        }
    });
}

function filterData(changed) {
    if (changed === 'changedistcode') {
        populateItiFilter();
        document.getElementById('iticode').value = '';
    }
    renderTable(filteredRows());
    return false;
}

function filteredRows() {
    var distcode = document.getElementById('distcode').value;
    var iticode = document.getElementById('iticode').value;
    return allRows.filter(function (row) {
        if (distcode && (row.distCode || '') !== distcode) return false;
        if (iticode && (row.itiName || '-') !== iticode) return false;
        return true;
    });
}

function renderTable(rows) {
    var tbody = document.getElementById('reportdata');
    tbody.innerHTML = '';
    if (!rows.length) { tbody.innerHTML = '<tr><td colspan="11" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>'; return; }
    rows.forEach(function (row, i) {
        var tr = document.createElement('tr');
        tr.innerHTML = '<td>' + (i + 1) + '</td>'
            + '<td>' + (row.scheduleId || '-') + '</td>'
            + '<td>' + (row.date || '-') + '</td>'
            + '<td style="text-align:left;">' + (row.distName || '-') + '</td>'
            + '<td style="text-align:left;">' + (row.itiName || '-') + '</td>'
            + '<td>' + (row.type || '-') + '</td>'
            + '<td style="text-align:left;">' + (row.description || '-') + '</td>'
            + '<td>' + (row.vacancies || 0) + '</td>'
            + '<td>' + (row.attended || 0) + '</td>'
            + '<td>' + (row.selected || 0) + '</td>'
            + '<td>' + (row.recordsCount || 0) + '</td>';
        tbody.appendChild(tr);
    });
}

function reloadpage() {
    /* GO BACK: show the form again, hide the report */
    document.getElementById('reportdiv').style.display = 'none';
    document.getElementById('formdiv').style.display = 'block';
    return false;
}

function fnExcelReport(tableId) {
    var table = document.getElementById(tableId);
    if (!table) return false;
    var wb = XLSX.utils.table_to_book(table, { sheet: 'Sheet1' });
    XLSX.writeFile(wb, tableId + '.xlsx');
    return false;
}
</script>
</body>
</html>
