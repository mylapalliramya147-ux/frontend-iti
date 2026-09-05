<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plcmt Year Wise Count Report</title>
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
#table th,#reporttable th{ position: sticky; top: 0px; background-color: black; color: white; }
</style>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

    loadYearwiseReport();

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
<div class="container" id='containertable'>
            <div align="center">
                <h3 class="h3 text-danger">Year Wise Placement Report</h3>
                <input type="button" value="Excel Download" id="fnExcelReport" class="btn btn-warning btn-sm" onclick="fnExcelReport('table')"/><br>
            </div>
            <table class="table table-bordered table-striped bg-info" id='table'>
                <thead>
                    <tr>
                        <th>S.NO</th>
                        <th>PASS YEAR</th>
                        <th>NO.of CAMPUS PLACEMENT</th>
                        <th>NO.of DIRECT PLACEMENT</th>
                        <th>NO.of APPRENTICESHIP</th>
                        <th>NO.of DIRECT APPRENTICESHIP</th>
                        <th>NO.of HIGHER EDUCATION</th>
                        <th>NO.of SELF EMPLOYMENT</th>
                        <th>TOTAL</th>
                    </tr>
                </thead>
                <tbody id="tbodyyy">

                </tbody>
            </table>

        </div>



        <div class="container-fluid" id="datadiv" style="display: none;">
            <div align="center">
                <h3 class="h3 text-danger">Year Wise Placement Report</h3>
                <span id="datainfo" style="color: blue;"></span><br>
                <input type="button" value="Excel Download" id="fnExcelReport" class="btn btn-warning btn-sm" onclick="fnExcelReport('reporttable')"/><br>
                <div class="text-center" id="spinnersdiv" style="display: none;">
                    <h1 class="h1 text-danger">Data is Loading Please wait.........</h1>
                </div>
                <button  style="margin-top: 5px;color: black;background-color: orange;"  class="btn btn-sm" onclick="return reload()">GO BACK</button>
            </div>

            <table class="table table-bordered" id="reporttable">
                <thead id="reportthead">
                    <tr>
                        <th>S.NO</th>
                        <th>DIST NAME</th>
                        <th>NO.of CAMPUS PLACEMENT</th>
                        <th>NO.of DIRECT PLACEMENT</th>
                        <th>NO.of APPRENTICESHIP</th>
                        <th>NO.of DIRECT APPRENTICESHIP</th>
                        <th>NO.of HIGHER EDUCATION</th>
                        <th>NO.of SELF EMPLOYMENT</th>
                        <th>TOTAL</th>
                    </tr>
                </thead>
                <tbody id="reportbody"></tbody>
            </table>
        </div>

<script>
var API = baseUrl + 'api/placements';

function loadYearwiseReport() {
    fetch(API + '/yearwise/report')
        .then(function (r) { return r.json(); })
        .then(function (data) { renderYears(data || []); })
        .catch(function (err) { alert('Error loading yearwise report: ' + err.message); });
}

function renderYears(rows) {
    var tbody = document.getElementById('tbodyyy');
    tbody.innerHTML = '';
    if (!rows.length) { tbody.innerHTML = '<tr><td colspan="9" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>'; return; }
    rows.forEach(function (row, i) {
        var yr = row.year || '-';
        var tr = document.createElement('tr');
        tr.innerHTML = '<td>' + (i + 1) + '</td>'
            + '<td><a href="javascript:void(0)" onclick="loadYearDetails(\'' + yr + '\')" style="font-weight:bold;">' + yr + '</a></td>'
            + '<td>' + (row.campusPlacement || 0) + '</td>'
            + '<td>' + (row.directPlacement || 0) + '</td>'
            + '<td>' + (row.apprenticeship || 0) + '</td>'
            + '<td>' + (row.directApprenticeship || 0) + '</td>'
            + '<td>' + (row.higherEducation || 0) + '</td>'
            + '<td>' + (row.selfEmployment || 0) + '</td>'
            + '<td>' + (row.total || 0) + '</td>';
        tbody.appendChild(tr);
    });
}

function loadYearDetails(year) {
    if (!year || year === '-') return;
    document.getElementById('containertable').style.display = 'none';
    document.getElementById('datadiv').style.display = 'block';
    document.getElementById('spinnersdiv').style.display = 'block';
    document.getElementById('reportbody').innerHTML = '';
    document.getElementById('datainfo').innerText = 'DISTRICT WISE DATA FOR PLACEMENT YEAR ' + year;
    fetch(API + '/yearwise/details?year=' + encodeURIComponent(year))
        .then(function (r) { return r.json(); })
        .then(function (data) {
            renderDetails(data || []);
            document.getElementById('spinnersdiv').style.display = 'none';
        })
        .catch(function (err) {
            document.getElementById('spinnersdiv').style.display = 'none';
            alert('Error loading year details: ' + err.message);
        });
    return false;
}

function renderDetails(rows) {
    var tbody = document.getElementById('reportbody');
    tbody.innerHTML = '';
    if (!rows.length) { tbody.innerHTML = '<tr><td colspan="9" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>'; return; }
    rows.forEach(function (row, i) {
        var tr = document.createElement('tr');
        tr.innerHTML = '<td>' + (i + 1) + '</td>'
            + '<td style="text-align:left;">' + (row.distName || '-') + '</td>'
            + '<td>' + (row.campusPlacement || 0) + '</td>'
            + '<td>' + (row.directPlacement || 0) + '</td>'
            + '<td>' + (row.apprenticeship || 0) + '</td>'
            + '<td>' + (row.directApprenticeship || 0) + '</td>'
            + '<td>' + (row.higherEducation || 0) + '</td>'
            + '<td>' + (row.selfEmployment || 0) + '</td>'
            + '<td>' + (row.total || 0) + '</td>';
        tbody.appendChild(tr);
    });
}

function reload() {
    /* GO BACK: return to the year-wise summary view */
    document.getElementById('datadiv').style.display = 'none';
    document.getElementById('containertable').style.display = 'block';
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
