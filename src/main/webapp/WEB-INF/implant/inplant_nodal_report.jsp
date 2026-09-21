<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IN-PLANT Nodal Report</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/xlsx.full.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<script>
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';
</script>
<style>
#reporttable th{ position: sticky; top: 0px; background-color: black; color: white; }
</style>
<script>
var allRows = [];

$(document).ready(function(){
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode;
    loadReport();
});

function esc(v) { if (v === null || v === undefined) return ''; return $('<div/>').text(String(v)).html(); }

function loadReport() {
    $("#spinnerdiv").show();
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/nodal-report',
        cache: false, timeout: 600000,
        success: function(rows){
            allRows = rows || [];
            buildFilters();
            renderTable(allRows);
            $("#spinnerdiv").hide();
        },
        error: function(){
            $("#spinnerdiv").hide();
            $("#tablebody").append('<tr><td colspan="17" style="text-align:center;color:red;padding:15px;">Error loading report.</td></tr>');
        }
    });
}

function buildFilters() {
    var dists = {}, itis = {}, inds = {};
    allRows.forEach(function(r){
        var d = r.districtName || '';
        var i = r.itiName || '';
        var n = r.industryName || '';
        if (d) dists[d] = true;
        if (i) itis[i] = true;
        if (n) inds[n] = true;
    });
    Object.keys(dists).sort().forEach(function(d){
        $("#distcode").append('<option value="' + esc(d) + '">' + esc(d) + '</option>');
    });
    Object.keys(itis).sort().forEach(function(i){
        $("#iticode").append('<option value="' + esc(i) + '">' + esc(i) + '</option>');
    });
    Object.keys(inds).sort().forEach(function(n){
        $("#industryId").append('<option value="' + esc(n) + '">' + esc(n) + '</option>');
    });
}
function renderTable(rows) {
    $("#tablebody").empty();
    if (!rows.length) {
        $("#tablebody").append('<tr><td colspan="17" style="text-align:center;padding:15px;font-weight:bold;">NO DATA FOUND.</td></tr>');
        return;
    }
    rows.forEach(function(r, i){
        $("#tablebody").append('<tr>'
            + '<td>' + (i + 1) + '</td>'
            + '<td>' + esc(r.districtName) + '</td>'
            + '<td>' + esc(r.itiName) + '</td>'
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

function filterData(trigger) {
    var dist = $("#distcode").val();
    var iti = $("#iticode").val();
    var ind = $("#industryId").val();
    var filtered = allRows.filter(function(r){
        if (dist && (r.districtName || '') !== dist) return false;
        if (iti && (r.itiName || '') !== iti) return false;
        if (ind && (r.industryName || '') !== ind) return false;
        return true;
    });
    renderTable(filtered);
    return false;
}

function fnExcelReport() {
    var table = document.getElementById('reporttable');
    if (!table || $("#tablebody tr").length === 0) return false;
    var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, 'INPLANT_NODAL_REPORT.xlsx');
    return false;
}
</script>
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">
<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div class="container-fluid">
    <div align="center" style="text-decoration: underline;color: fuchsia;">IN-PLANT TRAININGS REPORT</div>
    <div class="text-center" id="spinnerdiv">
        <span>Data is Loading...</span>
        <div class="spinner-border" role="status"></div>
    </div>
    <div class="row mb-1">
        <div class="col-2"><label for="distcode">District</label>
            <select id="distcode" class="form-control" onchange="return filterData('changedistcode');"><option value="">-ALL-</option></select></div>
        <div class="col-3"><label for="iticode">ITI</label>
            <select id="iticode" class="form-control" onchange="return filterData('changeiticode');"><option value="">-ALL-</option></select></div>
        <div class="col-3"><label for="industryId">INDUSTRY</label>
            <select id="industryId" class="form-control" onchange="return filterData('industryId');"><option value="">-ALL-</option></select></div>
        <div class="col-2"></div>
        <div class="col-2"><button onclick="return fnExcelReport();" class="btn btn-info btn-sm mt-4">DOWNLOAD EXCEL</button></div>
    </div>
    <table class="table table-bordered" id="reporttable">
        <thead>
            <tr>
                <td style="background-color: black;color: white;" rowspan="2">S.NO</td>
                <td style="background-color: black;color: white;" rowspan="2">DISTRICT</td>
                <td style="background-color: black;color: white;" rowspan="2">ITI</td>
                <td style="background-color: black;color: white;" colspan="14" align="center">IN-PLANT RELATED INFORMATION</td>
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