<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plcmt Iti Report</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/siteScript.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script>
var roleId   = '<c:out value="${sessionScope.roleId}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';   /* e.g. http://localhost:5050/ */
</script>
<script>
$(document).ready(function(){
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;
    loadYears();
    $("#reportdiv").hide();
});

function loadYears() {
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/iti/years?itiCode=' + encodeURIComponent(insCode),
        cache:false, timeout:600000,
        success: function(response){
            $("#plcmtYear").empty();
            $("#plcmtYear").append('<option value="">-ALL-</option>');
            response.forEach(function(y){ $("#plcmtYear").append('<option value="'+y+'">'+y+'</option>'); });
        }
    });
}

function doErrNull(id){ $("#"+id).html(''); return false; }

function getData(){
    $("#ptypeErr").html('');
    var ptype = $("#ptype").val();
    var year = $("#plcmtYear").val();
    if(!ptype){ $("#ptypeErr").html('<span style="color:red;font-weight:bold;">Placement Type is required.</span>'); return false; }
    var qs = '?itiCode='+encodeURIComponent(insCode)+'&ptype='+encodeURIComponent(ptype);
    if(year) qs += '&year='+encodeURIComponent(year);
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/iti/report' + qs, cache:false, timeout:600000,
        success: function(response){
            renderReport(response || []);
            $("#reportdiv").show();
        },
        error: function(xhr, status, error){ alert('Error loading report: '+error); }
    });
    return false;
}

function renderReport(rows){
    var thead = $("#reportthead"); thead.html('');
    var tbody = $("#reportbody"); tbody.html('');
    thead.append('<tr><th style="background-color:black;color:white;">S.NO</th><th style="background-color:black;color:white;">DISTRICT</th><th style="background-color:black;color:white;">NO OF PLACEMENTS</th></tr>');
    if(!rows.length){ tbody.append('<tr><td colspan="3" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>'); return; }
    rows.forEach(function(row,i){
        tbody.append('<tr><td>'+(i+1)+'</td><td style="text-align:left;">'+(row.distName||'-')+'</td><td>'+(row.total||0)+'</td></tr>');
    });
}

function fnExcelReport(){
    var table = document.getElementById('reporttable');
    if(!table) return false;
    var wb = XLSX.utils.table_to_book(table, {sheet:"Sheet1"});
    XLSX.writeFile(wb, 'ITI_REPORT.xlsx');
    return false;
}
</script>
<style>
#reporttable th{ position: sticky; top: 0px; background-color: black; color: white; }
</style>
</head>
<body>

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/placements/loginSuccess"><i class="fas fa-home"></i> Home</a>
    <div class="text-white fw-bold">Welcome : <span id="userinfo"></span></div>
    <div><a href="${pageContext.request.contextPath}/logout" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
</div>
</nav>
<br>
<div align="center" style="color: blue;"><h5>Placement Details - ITI Level</h5></div>

        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <label class="form-label">Placement Type</label>
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
                    <label class="form-label">Placement Year</label>
                    <select id="plcmtYear" class="form-control"></select>
                </div>
                <div class="col-lg-2">
                     <label class="form-label"> </label>
                     <button class="btn btn-success form-control" style="margin-top: 7px;" onclick="return getData()">GET DATA</button>
                </div>
            </div>
        </div>

            <br>

            <div class="container-fluid" id="reportdiv">
                <input type="button" value="Excel Download" id="fnExcelReport" class="btn btn-warning btn-sm" onclick="fnExcelReport();"/><br>
                <table class="table table-bordered" id="reporttable">
                    <thead id="reportthead"></thead>
                    <tbody id="reportbody"></tbody>
            </table>
        </div>
</body>
</html>
