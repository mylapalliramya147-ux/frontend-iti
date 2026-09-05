<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>State Report</title>
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
#statetable th,#reporttable th{ position: sticky; top: 0px; background-color: black; color: white; }
</style>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

    loadStateReport();

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
<br>
<div class="container-fluid">
            <div id="statediv">
                <div align="center">
                    <h5 class="h5 text-info" style="font-weight: bolder;text-decoration: underline;">STATE LEVEL PLACEMENT DETAILS</h5>
                </div>
                <div align="right">
                    <button class="btn btn-info" onclick="return fnExcelReport('statetable')">EXCEL DOWNLOAD</button>
                </div>
                <table class="table table-bordered" id="statetable">
                    <thead>
                        <tr>
                            <th>S.NO</th>
                            <th>DIST NAME</th>
                            <th>CAMPUS PLACEMENT</th>
                            <th>DIRECT PLACEMENT</th>
                            <th>APPRENTICESHIP</th>
                            <th>DIRECT APPRENTICESHIP</th>
                            <th>SELF EMPLOYMENT</th>
                            <th>HIGHER EDUCATION</th>
                            <th>TOTAL</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyyy"></tbody>
                </table>
            </div>
        </div>
        <div class="container-fluid">
            <div id="distdiv" style="display: none;">
                <div align="center"><h5 class="h5 text-info" style="font-weight: bolder;text-decoration: underline;">DIST LEVEL REPORT - <b> <span id="distname"></span></b></h5></div>
                <div align="center"><h5 class="h5 text-info" style="font-weight: bolder;text-decoration: underline;">PLACEMENT TYPE - <b> <span id="ptypename"></span></b></h5></div>

                <input type="hidden" id="distcodee" />
                <div class="row">
                    <div class="col-lg-4">
                        <label class="form-label">ITI Name</label>
                        <select id="iticode" class="form-control" onchange="return filterData()">
                        </select>
                    </div>
                    <div class="col-lg-4">
                        <label class="form-label">Placement Year</label>
                        <select id="plcmtYear" class="form-control" onchange="return filterData()">
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <label class="form-label"> </label>
                        <button class="btn btn-success form-control" style="margin-top: 5px;"
                                onclick="return filterData()">SORT DATA</button>
                    </div>
                    <div class="col-lg-2">
                        <label class="form-label"> </label>
                        <button class="btn btn-warning form-control" style="margin-top: 5px;"
                                onclick="return reload()">GO BACK</button>
                    </div>
                </div>
                <br>
                <div align="right">
                    <button class="btn btn-info" onclick="return fnExcelReport('reporttable')">EXCEL DOWNLOAD</button>
                </div>
                <table class="table table-bordered" id="reporttable">
                    <thead id="reportthead">
                        <tr>
                            <th>S.NO</th>
                            <th>ITI NAME</th>
                            <th>PLACEMENT YEAR</th>
                            <th>CAMPUS PLACEMENT</th>
                            <th>DIRECT PLACEMENT</th>
                            <th>APPRENTICESHIP</th>
                            <th>DIRECT APPRENTICESHIP</th>
                            <th>SELF EMPLOYMENT</th>
                            <th>HIGHER EDUCATION</th>
                            <th>TOTAL</th>
                        </tr>
                    </thead>
                    <tbody id="reportbody"></tbody>
                </table>
            </div>
        </div>

<script>
var API = baseUrl + 'api/placements';
var distRows = [];

function loadStateReport() {
    fetch(API + '/state/report')
        .then(function (r) { return r.json(); })
        .then(function (data) { renderState(data || []); })
        .catch(function (err) { alert('Error loading state report: ' + err.message); });
}

function renderState(rows) {
    var tbody = document.getElementById('tbodyyy');
    tbody.innerHTML = '';
    if (!rows.length) { tbody.innerHTML = '<tr><td colspan="9" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>'; return; }
    rows.forEach(function (row, i) {
        var tr = document.createElement('tr');
        tr.innerHTML = '<td>' + (i + 1) + '</td>'
            + '<td><a href="javascript:void(0)" onclick="loadDistReport(\'' + (row.distCode || '') + '\', \'' + String(row.distName || '').replace(/'/g, "\\'") + '\')" style="font-weight:bold;">' + (row.distName || '-') + '</a></td>'
            + '<td>' + (row.campusPlacement || 0) + '</td>'
            + '<td>' + (row.directPlacement || 0) + '</td>'
            + '<td>' + (row.apprenticeship || 0) + '</td>'
            + '<td>' + (row.directApprenticeship || 0) + '</td>'
            + '<td>' + (row.selfEmployment || 0) + '</td>'
            + '<td>' + (row.higherEducation || 0) + '</td>'
            + '<td>' + (row.total || 0) + '</td>';
        tbody.appendChild(tr);
    });
}

function loadDistReport(distCode, distName) {
    if (!distCode) return;
    fetch(API + '/state/district?distCode=' + encodeURIComponent(distCode))
        .then(function (r) { return r.json(); })
        .then(function (data) {
            distRows = data || [];
            document.getElementById('distcodee').value = distCode;
            document.getElementById('distname').innerText = distName || distCode;
            document.getElementById('ptypename').innerText = 'ALL';
            populateItiFilter();
            populateYearFilter();
            document.getElementById('iticode').value = '';
            document.getElementById('plcmtYear').value = '';
            renderDist(distRows);
            document.getElementById('statediv').style.display = 'none';
            document.getElementById('distdiv').style.display = 'block';
        })
        .catch(function (err) { alert('Error loading district report: ' + err.message); });
    return false;
}

function populateItiFilter() {
    var sel = document.getElementById('iticode');
    sel.innerHTML = '<option value="">-ALL ITIs-</option>';
    var seen = {};
    distRows.forEach(function (row) {
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

function populateYearFilter() {
    var sel = document.getElementById('plcmtYear');
    sel.innerHTML = '<option value="">-ALL YEARS-</option>';
    var seen = {};
    distRows.forEach(function (row) {
        var yr = row.year || '';
        if (yr && !seen[yr]) {
            seen[yr] = true;
            var opt = document.createElement('option');
            opt.value = yr;
            opt.text = yr;
            sel.appendChild(opt);
        }
    });
}

function filterData() {
    var iticode = document.getElementById('iticode').value;
    var year = document.getElementById('plcmtYear').value;
    document.getElementById('ptypename').innerText = 'ALL';
    var rows = distRows.filter(function (row) {
        if (iticode && (row.itiName || '-') !== iticode) return false;
        if (year && String(row.year || '') !== year) return false;
        return true;
    });
    renderDist(rows);
    return false;
}

function renderDist(rows) {
    var tbody = document.getElementById('reportbody');
    tbody.innerHTML = '';
    if (!rows.length) { tbody.innerHTML = '<tr><td colspan="10" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>'; return; }
    rows.forEach(function (row, i) {
        var tr = document.createElement('tr');
        tr.innerHTML = '<td>' + (i + 1) + '</td>'
            + '<td style="text-align:left;">' + (row.itiName || '-') + '</td>'
            + '<td>' + (row.year || '-') + '</td>'
            + '<td>' + (row.campusPlacement || 0) + '</td>'
            + '<td>' + (row.directPlacement || 0) + '</td>'
            + '<td>' + (row.apprenticeship || 0) + '</td>'
            + '<td>' + (row.directApprenticeship || 0) + '</td>'
            + '<td>' + (row.selfEmployment || 0) + '</td>'
            + '<td>' + (row.higherEducation || 0) + '</td>'
            + '<td>' + (row.total || 0) + '</td>';
        tbody.appendChild(tr);
    });
}

function reload() {
    /* GO BACK: return to the state-level view */
    document.getElementById('distdiv').style.display = 'none';
    document.getElementById('statediv').style.display = 'block';
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
