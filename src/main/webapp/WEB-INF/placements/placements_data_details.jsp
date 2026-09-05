<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plcmt Data Details Report</title>
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
#reporttable th{ position: sticky; top: 0px; background-color: black; color: white; }
</style>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

    $("#spinnerdiv").hide();

    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/ssdp/years',
        cache: false,
        timeout: 600000,
        success: function(response){
            $("#year").empty();
            $("#year").append('<option value="" selected disabled>Select Year</option>');
            response.forEach(function(a){
                $("#year").append('<option value="' + a + '">' + a + '</option>');
            });
        }
    });

});

function getData(){
    var year = $("#year").val();
    var itiType = $("#itiType").val();
    if (!year) { alert('Please select Passed Year'); return false; }
    if (!itiType) { alert('Please select ITI Type'); return false; }

    $("#spinnerdiv").show();
    $("#reportwrapper").show();
    $("#tablebody").empty();

    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/datadetails/report?year=' + encodeURIComponent(year)
           + '&itiType=' + encodeURIComponent(itiType),
        cache: false,
        timeout: 600000,
        success: function(response){
            $("#spinnerdiv").hide();
            $("#tablebody").empty();
            var count = 0;
            response.forEach(function(bean){
                count = count + 1;
                $("#tablebody").append('<tr>'
                    + '<td>' + count + '</td>'
                    + '<td style="text-align:left;">' + (bean.district || '-') + '</td>'
                    + '<td style="text-align:left;">' + (bean.iti || '-') + '</td>'
                    + '<td>' + (bean.misCode || '-') + '</td>'
                    + '<td>' + (bean.admitted1Year || 0) + '</td>'
                    + '<td>' + (bean.admitted2Year || 0) + '</td>'
                    + '<td>' + (bean.totalAppeared || 0) + '</td>'
                    + '<td>' + (bean.campusDirect || 0) + '</td>'
                    + '<td>' + (bean.apprenticeshipOA || 0) + '</td>'
                    + '<td>' + (bean.selfEmployment || 0) + '</td>'
                    + '<td>' + (bean.higherEducation || 0) + '</td>'
                    + '<td>' + (bean.totalPlacements || 0) + '</td>'
                    + '</tr>');
            });
            if (!response.length) {
                $("#tablebody").append('<tr><td colspan="12" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>');
            }
        },
        error: function(xhr, status, error){
            $("#spinnerdiv").hide();
            alert('Error loading report: ' + error);
        }
    });
    return false;
}

function fnExcelReport(a) {
    var table = document.getElementById(a);
    var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, 'Report.xlsx');
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
<div class="container border p-2 mt-2 shadow-lg">
        <div align="center" style="text-decoration: underline; color: fuchsia;">Plcmt Current Year Plus Seniors Report</div>
        <div class="row">
<div class="col-md-3">
<label for="year">Passed Year :</label> <select id="year"
class="form-control">
<option value="" selected disabled>Select Year</option>
</select>
</div>

<div class="col-md-3">
<label for="itiType">ITI Type :</label> <select id="itiType"
class="form-control">
<option value="" selected disabled>Select ITI Type</option>
<option value="G">Govt</option>
<option value="P">Pvt</option>
<option value="All">ALL</option>
</select>
</div>

<div class="col-md-3">
<button class="btn btn-sm btn-success mt-4"
onclick="return getData();">GET DATA</button>
</div>

</div>
    </div>
    

    <div class="container-fluid border p-2 mt-2 shadow-lg" id="reportwrapper" style="display: none;">
<div class="container-fluid" id="datadiv">
<div align="center" style="text-decoration: underline;color: fuchsia;">PLACEMENT CURRENT PLUS SENIORS DATA REPORT</div>
    
    <button onclick="fnExcelReport('reporttable');" class="btn btn-info btn-sm">DOWNLOAD EXCEL</button>
    
        <div align="center" style="text-decoration: underline; color: fuchsia;" id="spinnerdiv" style="display: none;">
            <span>Data is Loading...</span>
            <div class="spinner-border" role="status"></div>
        </div>

        <table class="table table-bordered" id="reporttable">
            <thead>
                <tr>
                    <th>S.NO</th>
                    <th>DISTRICT</th>
                    <th>ITI</th>
                    <th>MIS CODE</th>
                    <th id="admitted1YearHeader">ADMITTED ONE YEAR</th>
                    <th id="admitted2YearHeader">ADMITTED TWO YEARS</th>
                    <th>TOTAL APPEARED</th>
                    <th>CAMPUS PLACEMENT(Job)+DIRECT PLACEMENT(OJ)</th>
                    <th>APPRENTICESHIP+DIRECT APPRENTICESHIP(OA)</th>
                    <th>Self Employment</th>
                    <th>Higher Education</th>
                    <th>Total Placements</th>
                </tr>
            </thead>
            <tbody id="tablebody"></tbody>
        </table>
        
    </div>
    </div>
    
    
</body>
</html>
