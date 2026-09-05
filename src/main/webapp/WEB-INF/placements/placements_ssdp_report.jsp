<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>State Skill Development Plan Report</title>
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
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

    $("#spinnerdiv").hide();
    $("#datadiv").hide();

    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/ssdp/years',
        cache: false,
        timeout: 600000,
        success: function(response){
            $("#year").empty();
            $("#year").append('<option value="">-SELECT-</option>');
            response.forEach(function(a){
                $("#year").append('<option value="' + a + '">' + a + '</option>');
            });
        }
    });

});

function getData(){
    var year = $("#year").val();
    if (!year) { alert('Please select Year of Admission'); return false; }

    $("#spinnerdiv").show();
    $("#datadiv").hide();

    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/ssdp/report?year=' + encodeURIComponent(year),
        cache: false,
        timeout: 600000,
        success: function(response){
            $("#datadiv").show();
            $("#tabledata").empty();
            var count = 0;
            response.forEach(function(bean){
                count = count + 1;
                $("#tabledata").append('<tr>'
                    + '<td>' + count + '</td>'
                    + '<td style="text-align:left;">' + (bean.tradeName || '-') + '</td>'
                    + '<td>' + (bean.itiCount || 0) + '</td>'
                    + '<td>' + (bean.totalStrength || 0) + '</td>'
                    + '<td>' + (bean.totalMale || 0) + '</td>'
                    + '<td>' + (bean.totalFemale || 0) + '</td>'
                    + '<td>' + (bean.totalGender || 0) + '</td>'
                    + '<td>' + (bean.totalPlcmts || 0) + '</td>'
                    + '</tr>');
            });
            if (!response.length) {
                $("#tabledata").append('<tr><td colspan="8" style="text-align:center;padding:20px;font-weight:bold;">No records found.</td></tr>');
            }
            $("#spinnerdiv").hide();
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

<div class="container border p-2 mt-2 shadow-lg" id="formdiv">
<div align="center"
style="text-decoration: underline; color: fuchsia;">State Skill
Development Plan Report</div>

<div class="row">
<div class="col-md-3"></div>
<div class="col-md-3">
<label for="year">YEAR OF ADMISSION</label> <select id="year"
class="form-control">
<option value="">-SELECT-</option>
</select>
</div>
<div class="col-md-3">
<button class="btn btn-sm btn-success mt-4"
onclick="return getData();">GET DATA</button>
</div>
<div class="col-md-3"></div>
</div>
<br>

<div class="text-center" id="spinnerdiv">
<span>Data is Loading...</span>
<div class="spinner-border" role="status"></div>
</div>
<div id="datadiv">
<div class="col-2"><button onclick="return fnExcelReport('reporttable');" class="btn btn-info btn-sm mt-4">DOWNLOAD EXCEL</button></div>
<table class="table table-bordered" id="reporttable">
<thead>
<tr>
<td style="background-color: black; color: white;">S.NO</td>
<td style="background-color: black; color: white;">TRADE</td>
<td style="background-color: black; color: white;">NO OF ITIs
Included</td>
<td style="background-color: black; color: white;">TOTAL SEATS</td>
<td style="background-color: black; color: white;" colspan="3">TOTAL
ADMITTED SEATS</td>
<td style="background-color: black; color: white;">PLACED
SEATS</td>
</tr>
<tr>
<td style="background-color: black; color: white;" colspan="4"></td>
<td style="background-color: black; color: white;">MALE</td>
<td style="background-color: black; color: white;">FEMALE</td>
<td style="background-color: black; color: white;">TOTAL</td>
<td style="background-color: black; color: white;"></td>
</tr>
</thead>
<tbody id="tabledata"></tbody>
</table>
</div>
</div>

</body>
</html>
