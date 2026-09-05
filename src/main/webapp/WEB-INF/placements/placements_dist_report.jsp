<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plcmt Dist Report</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/siteScript.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- ITIAP uses server sessions, NOT the JWT the original page used -->
<script>
var roleId   = '<c:out value="${sessionScope.roleId}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';   /* e.g. http://localhost:5050/ */
</script>
<style>
#inp{ font-weight: bolder; }
#reportdiv{ display: none; margin-top: 15px; }
#reporttable th{ position: sticky; top: 0px; background-color: black; color: white; }
</style>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

    loadYears();
    loadItis();

});

function loadYears() {
    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/district/years?distCode=' + encodeURIComponent(insCode),
        cache: false,
        timeout: 600000,
        success: function(response){
            $("#plcmtYear").empty();
            $("#plcmtYear").append('<option value="">-ALL-</option>');
            response.forEach(function(y){ $("#plcmtYear").append('<option value="' + y + '">' + y + '</option>'); });
        }
    });
}

function loadItis() {
    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/district/itis?distCode=' + encodeURIComponent(insCode),
        cache: false,
        timeout: 600000,
        success: function(response){
            $("#iti_code").empty();
            $("#iti_code").append('<option value="">-ALL-</option>');
            response.forEach(function(iti){ $("#iti_code").append('<option value="' + iti.itiCode + '">' + (iti.itiName || iti.itiCode) + '</option>'); });
        }
    });
}

function doErrNull(id) {
    $("#" + id).html('');
    return false;
}

function getReport() {
    $("#ptypeErr").html('');
    var ptype = $("#ptype").val();
    var year = $("#plcmtYear").val();
    var itiCode = $("#iti_code").val();

    if (!ptype) { $("#ptypeErr").html('<span style="color:red;font-weight:bold;">Placement Type is required.</span>'); return false; }

    var qs = '?distCode=' + encodeURIComponent(insCode) + '&ptype=' + encodeURIComponent(ptype);
    if (year) qs += '&year=' + encodeURIComponent(year);
    if (itiCode) qs += '&itiCode=' + encodeURIComponent(itiCode);

    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/district/report' + qs,
        cache: false,
        timeout: 600000,
        success: function(response){
            renderReport(response || []);
            $("#reportdiv").show();
        },
        error: function(xhr, status, error){
            alert('Error loading report: ' + error);
        }
    });
    return false;
}

function renderReport(rows) {
    var thead = $("#reportthead");
    thead.html('');
    var tbody = $("#reportbody");
    tbody.html('');

    thead.append('<tr><th style="background-color:black;color:white;">S.NO</th><th style="background-color:black;color:white;">ITI CODE</th><th style="background-color:black;color:white;">ITI NAME</th><th style="background-color:black;color:white;">NO OF PLACEMENTS</th></tr>');

    if (!rows.length) {
        tbody.append('<tr><td colspan="4" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>');
        return;
    }
    rows.forEach(function(row, i){
        tbody.append('<tr>'
            + '<td>' + (i + 1) + '</td>'
            + '<td>' + (row.itiCode || '-') + '</td>'
            + '<td style="text-align:left;">' + (row.itiName || '-') + '</td>'
            + '<td>' + (row.total || 0) + '</td>'
            + '</tr>');
    });
}

function fnExcelReport() {
    var table = document.getElementById('reporttable');
    if (!table) return false;
    var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, 'DIST_REPORT.xlsx');
    return false;
}
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
<div align="center" >
            <h5 class="h5 text-primary" style="font-weight: bolder;">DISTRICT LEVEL PLACEMENT DETAILS</h5>
        </div>
        
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <label class="form-label" id="inp">Placement Type</label>
                     <select name="ptype" class="form-control" id="ptype" onchange="return doErrNull('ptypeErr');">
                    <option value="">-SELECT-</option>
                    <option value="Job">CAMPUS PLACEMENT(Job)</option>
                    <option value="OJ">DIRECT PLACEMENT(Other than Job)</option>
                    <option value="Apprenticeship">Apprenticeship</option>
                    <option value="OA">DIRECT APPRENTICESHIP(Other than Apprenticeship)</option>
                    <option value="HigherEducation">Higher Education</option>
                    <option value="SelfEmployment">Self Employment</option>
                </select>
                    <span id="ptypeErr"></span>
                </div>
                <div class="col-lg-4">
                    <label class="form-label" id="inp">Placement Year</label>
                    <select id="plcmtYear" class="form-control"></select>
                </div>
                <div class="col-lg-4">
                    <label class="form-label" id="inp">ITI Name</label>
                    <select name="iti_code" id="iti_code" class="form-control">
                        <option value="">-ALL-</option>
                    </select>
                </div>
            </div>
             <div class="row">
                 <div class="col-lg-5"></div>
                <div class="col-lg-2">
                     <label class="form-label"> </label>
                     <button class="btn btn-success form-control" onclick="return getReport()">GET DATA</button>
                </div>
                 <div class="col-lg-5"></div>
            </div>
        </div>
        
        <div class="container-fluid" id="reportdiv">
                <input type="button" value="Excel Download" id="fnExcelReport" class="btn btn-warning btn-sm" onclick="fnExcelReport();"/><br>
                
                <table class="table table-bordered" id="reporttable">
                    <thead id="reportthead"></thead>
                    <tbody id="reportbody"></tbody>
                </table>
        </div>
</body>
</html>
