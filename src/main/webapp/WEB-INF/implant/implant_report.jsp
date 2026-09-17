<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ITI IN-PLANT Report</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/xlsx.full.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<!-- ITIAP uses server sessions, NOT the JWT the original page used -->
<script>
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';
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

    loadIndustries();
    loadReport();

});

var allRows = [];

function loadIndustries() {
    $.ajax({
        type: 'get',
        url: baseUrl + 'api/implant/industries?itiCode=' + encodeURIComponent(insCode),
        cache: false, timeout: 600000,
        success: function(response){
            $("#industryId").empty();
            $("#industryId").append('<option value="">-ALL INDUSTRIES-</option>');
            if (response && response.length > 0) {
                response.forEach(function(ind){
                    $("#industryId").append('<option value="' + esc(ind[1]) + '">' + ind[1] + '</option>');
                });
            }
        }
    });
}

function loadReport() {
    $.ajax({
        type: 'get',
        url: baseUrl + 'api/implant/report?itiCode=' + encodeURIComponent(insCode),
        cache: false, timeout: 600000,
        success: function(response){
            allRows = response || [];
            renderTable(allRows);
        },
        error: function(){
            $("#emptydatamsg").html('Error loading report. Please try again.').show();
        }
    });
}

function esc(v) {
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}
function renderTable(rows) {
    $("#tablebody").empty();
    if (!rows.length) {
        $("#emptydatamsg").show();
        $("#reporttable").hide();
        return;
    }
    $("#emptydatamsg").hide();
    $("#reporttable").show();
    rows.forEach(function(r, i){
        $("#tablebody").append('<tr>'
            + '<td>' + (i + 1) + '</td>'
            + '<td>' + esc(r.implantId) + '</td>'
            + '<td>' + esc(r.industryName) + '</td>'
            + '<td>' + esc(r.facultyName) + '</td>'
            + '<td>' + esc(r.tradeName) + '</td>'
            + '<td>' + esc(r.industryAddress) + '</td>'
            + '<td>' + esc(r.hrNo) + '</td>'
            + '<td>' + esc(r.fromDate) + '</td>'
            + '<td>' + esc(r.toDate) + '</td>'
            + '<td>' + esc(r.noOfDays) + '</td>'
            + '<td>' + esc(r.noOfStudents) + '</td>'
            + '<td>' + esc(r.stateName) + '</td>'
            + '<td>' + esc(r.districtName) + '</td>'
            + '<td>' + esc(r.location) + '</td>'
            + '<td>' + esc(r.description) + '</td>'
            + '</tr>');
    });
}

function filterData() {
    var indName = $("#industryId").val();
    if (!indName) { renderTable(allRows); return false; }
    renderTable(allRows.filter(function(r){
        return String(r.industryName) === String(indName);
    }));
    return false;
}

function fnExcelReport() {
    var table = document.getElementById('reporttable');
    if (!table || $("#tablebody tr").length === 0) return false;
    var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, 'ITI_IMPLANT_REPORT.xlsx');
    return false;
}
</script>
</head>
<body>

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">

<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div class="container-fluid border p-2 mt-2 shadow-lg" style="border-radius: 5px;">
    <div align="center" style="text-decoration: underline;color: fuchsia;">IN-PLANT TRAININGS REPORT</div>
    <div align="center" style="color: red;" id="emptydatamsg">-------------------NO DATA FOUND FOR SHOWING-------------------</div>
    <div class="row m-1" id="inputrow">
        <div class="col-4"></div>
        <div class="col-4">
            <label for="industryId">INDUSTRY</label>
            <select id="industryId" class="form-control" onchange="return filterData();"></select>
        </div>
        <div class="col-2"></div>
        <div class="col-2"><button onclick="return fnExcelReport();" class="btn btn-info btn-sm mt-4">DOWNLOAD EXCEL</button></div>
    </div>
    <table class="table table-bordered" id="reporttable" style="display:none;">
        <thead>
            <tr>
                <td style="background-color: black;color: white;" rowspan="2">S.NO</td>
                <td style="background-color: black;color: white;" colspan="14" align="center"> IN-PLANT RELATED INFORMATION</td>
            </tr>
            <tr>
                <td style="background-color: black;color: white;">IN-PLANT ID</td>
                <td style="background-color: black;color: white;">INDUSTRY NAME</td>
                <td style="background-color: black;color: white;">FACULTY NAME</td>
                <td style="background-color: black;color: white;">IN-PLANT TRADE</td>
                <td style="background-color: black;color: white;">INDUSTRY ADDRESS</td>
                <td style="background-color: black;color: white;">HR CONTACT NUMBER</td>
                <td style="background-color: black;color: white;">FROM DATE</td>
                <td style="background-color: black;color: white;">TO DATE</td>
                <td style="background-color: black;color: white;">NO OF DAYS</td>
                <td style="background-color: black;color: white;">NO OF STUDENT U.T</td>
                <td style="background-color: black;color: white;">IN-PLANT STATE</td>
                <td style="background-color: black;color: white;">IN-PLANT DISTRICT</td>
                <td style="background-color: black;color: white;">LOCATION</td>
                <td style="background-color: black;color: white;">DESCRIPTION</td>
            </tr>
        </thead>
        <tbody id="tablebody"></tbody>
    </table>
</div>
</body>
</html>