<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IN-PLANT Dist Report</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/xlsx.full.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<script>
var jwtToken = '';
var insCode = '<c:out value="${sessionScope.insCode}" default=""/>';
var roleId = '<c:out value="${sessionScope.roleId}" default=""/>';
var baseUrl = '${backendBaseUrl}/';
</script>
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border:1px solid black;width:100%;border-radius:2px;">
<%@ include file="../portal_navbar.jsp" %>
<br>
<div class="container-fluid border p-2 mt-2 shadow-lg" style="border-radius:5px;">
    <div align="center" style="text-decoration:underline;color:fuchsia;">IN-PLANT TRAININGS REPORT</div>
    <div class="row m-1">
        <div class="col-4">
            <label for="iticode">ITI</label>
            <select id="iticode" class="form-control" onchange="return filterData();"><option value="">-ALL-</option></select>
        </div>
        <div class="col-4">
            <label for="industryId">INDUSTRY</label>
            <select id="industryId" class="form-control" onchange="return filterData();"><option value="">-ALL-</option></select>
        </div>
        <div class="col-2"></div>
        <div class="col-2"><button onclick="return fnExcelReport('reporttable');" class="btn btn-info btn-sm mt-4">DOWNLOAD EXCEL</button></div>
    </div>
    <table class="table table-bordered" id="reporttable">
        <thead>
            <tr>
                <td style="background-color:black;color:white;" rowspan="2">S.NO</td>
                <td style="background-color:black;color:white;" rowspan="2">ITI</td>
                <td style="background-color:black;color:white;" colspan="14" align="center">IN-PLANT RELATED INFORMATION</td>
            </tr>
            <tr>
                <td style="background-color:black;color:white;">IN-PLANT ID</td>
                <td style="background-color:black;color:white;">INDUSTRY NAME</td>
                <td style="background-color:black;color:white;">FACULTY NAME</td>
                <td style="background-color:black;color:white;">IN-PLANT TRADE</td>
                <td style="background-color:black;color:white;">INDUSTRY ADDRESS</td>
                <td style="background-color:black;color:white;">HR CONTACT NUMBER</td>
                <td style="background-color:black;color:white;">FROM DATE</td>
                <td style="background-color:black;color:white;">TO DATE</td>
                <td style="background-color:black;color:white;">NO OF DAYS</td>
                <td style="background-color:black;color:white;">NO OF STUDENT U.T</td>
                <td style="background-color:black;color:white;">IN-PLANT STATE</td>
                <td style="background-color:black;color:white;">IN-PLANT DISTRICT</td>
                <td style="background-color:black;color:white;">LOCATION</td>
                <td style="background-color:black;color:white;">DESCRIPTION</td>
            </tr>
        </thead>
        <tbody id="tablebody"></tbody>
    </table>
</div>

<script>
$(document).ready(function(){
    var username = '<c:out value="${sessionScope.username}" default=""/>';
    var insName = '<c:out value="${sessionScope.itiName}" default=""/>';
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;
    loadItis();
});

function loadItis(){
    $.ajax({
        type:'get', url: baseUrl + 'api/implant/district/itis?distCode=' + encodeURIComponent(insCode),
        cache:false, timeout:600000,
        success: function(response){
            if(response && response.length > 0){
                response.forEach(function(item){
                    $("#iticode").append('<option value="'+item[0]+'">'+item[1]+'</option>');
                });
            }
            filterData();
        }, error: function(){ filterData(); }
    });
}

function loadIndustries(itiCode){
    $("#industryId").empty();
    $("#industryId").append('<option value="">-ALL-</option>');
    if(!itiCode) return;
    $.ajax({
        type:'get', url: baseUrl + 'api/implant/industries?itiCode=' + encodeURIComponent(itiCode),
        cache:false, timeout:600000,
        success: function(response){
            if(response && response.length > 0){
                response.forEach(function(item){
                    $("#industryId").append('<option value="'+item[0]+'">'+item[1]+'</option>');
                });
            }
        }
    });
}

function filterData(){
    var itiCode = $("#iticode").val();
    var industryId = $("#industryId").val();
    if(event && event.target && event.target.id === 'iticode'){
        loadIndustries(itiCode);
    }
    $("#tablebody").empty();
    $.ajax({
        type:'get', url: baseUrl + 'api/implant/district/report?itiCode=' + encodeURIComponent(itiCode || '') + '&industryId=' + encodeURIComponent(industryId || ''),
        cache:false, timeout:600000,
        success: function(response){
            if(response && response.length > 0){
                var count = 0;
                response.forEach(function(r){
                    count++;
                    $("#tablebody").append('<tr>'
                        + '<td>' + count + '</td>'
                        + '<td>' + (r.itiName || '') + '</td>'
                        + '<td>' + (r.implantId || '') + '</td>'
                        + '<td>' + (r.industryName || '') + '</td>'
                        + '<td>' + (r.facultyName || '') + '</td>'
                        + '<td>' + (r.tradeName || '') + '</td>'
                        + '<td>' + (r.industryAddress || '') + '</td>'
                        + '<td>' + (r.hrNo || '') + '</td>'
                        + '<td>' + (r.fromDate || '') + '</td>'
                        + '<td>' + (r.toDate || '') + '</td>'
                        + '<td>' + (r.noOfDays || '') + '</td>'
                        + '<td>' + (r.noOfStudents || '') + '</td>'
                        + '<td>' + (r.stateName || '') + '</td>'
                        + '<td>' + (r.districtName || '') + '</td>'
                        + '<td>' + (r.location || '') + '</td>'
                        + '<td>' + (r.description || '') + '</td>'
                        + '</tr>');
                });
            }
        }, error: function(xhr){
            $("#tablebody").append("<tr><td colspan='16' style='color:red;'>Error loading data: " + xhr.status + "</td></tr>");
        }
    });
    return false;
}

function fnExcelReport(tableId){
    var table = document.getElementById(tableId);
    var wb = XLSX.utils.table_to_book(table, { sheet:"Sheet1" });
    XLSX.writeFile(wb, 'InPlant_Dist_Report.xlsx');
    return false;
}
</script>
</body>
</html>
