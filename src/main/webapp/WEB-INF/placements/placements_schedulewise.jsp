<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plcmt Scheduleswise Data</title>
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
#distwise th{
    background-color: black;
    color: white;
}
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
<br>
<div class="container">
           <div style="margin-bottom: 15px;">
    <label for="yearSelect"><b>Select Year:</b></label>
    <select id="yearSelect" class="form-select" style="width: 150px; display: inline-block;">
        <option value="">--Select--</option>
        <option value="2022">2022</option>
        <option value="2023">2023</option>
        <option value="2024">2024</option>
        <option value="2025">2025</option>
    </select>
    <button onclick="loadScheduleData()" class="btn btn-success" style="margin-left: 10px;">Search</button>
</div>

            <div id="distwisediv" style="display: none;">
                <div align="right">
                    <span style="font-weight: bolder;color: #28921f;margin-right: 350px;">PLACEMENTS SCHEDULES DISTRICT WISE DATA</span>
                    <button onclick="downloadExcel('distwise')" class="btn btn-primary">Download Excel</button>
                </div>
                <table class="table table-striped table-bordered" id="distwise">
                    <thead>
                        <tr>
                            <th>S.NO</th>
                            <th>DIST NAME</th>
                            <th>NO OF JOB SCHEDULES</th>
                            <th>NO OF APPRENTICESHIP SCHEDULES</th>
                            <th>TOTAL SCHEDULES</th>
                        </tr>
                    </thead>
                    <tbody id="distwisedata">

                    </tbody>
                </table>
            </div>
        </div>

<script>
var API = baseUrl + 'api/placements';

function loadScheduleData() {
    var year = document.getElementById('yearSelect').value;
    if (!year) { alert('Please select a year'); return; }
    document.getElementById('distwisediv').style.display = 'none';
    fetch(API + '/schedulewise/districts?year=' + encodeURIComponent(year))
        .then(function (r) { return r.json(); })
        .then(function (data) {
            renderDistricts(data || []);
            document.getElementById('distwisediv').style.display = 'block';
        })
        .catch(function (err) {
            document.getElementById('distwisediv').style.display = 'block';
            alert('Error loading district data: ' + err.message);
        });
}

function renderDistricts(rows) {
    var tbody = document.getElementById('distwisedata');
    tbody.innerHTML = '';
    if (!rows.length) { tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>'; return; }
    rows.forEach(function (row, i) {
        var tr = document.createElement('tr');
        tr.innerHTML = '<td>' + (i + 1) + '</td>'
            + '<td style="text-align:left;">' + (row.distName || '-') + '</td>'
            + '<td>' + (row.jobSchedules || 0) + '</td>'
            + '<td>' + (row.apprenticeshipSchedules || 0) + '</td>'
            + '<td>' + (row.totalSchedules || 0) + '</td>';
        tbody.appendChild(tr);
    });
}

function downloadExcel(tableId) {
    var table = document.getElementById(tableId);
    if (!table) return;
    var wb = XLSX.utils.table_to_book(table, { sheet: 'Sheet1' });
    XLSX.writeFile(wb, tableId + '.xlsx');
}
</script>
</body>
</html>
