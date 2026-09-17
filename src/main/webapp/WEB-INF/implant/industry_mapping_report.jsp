<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Industry ITI Mapping Report</title>
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
<script>
var allRows = [];

$(document).ready(function(){
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode;
    loadData();
});

function esc(v) { if (v === null || v === undefined) return ''; return $('<div/>').text(String(v)).html(); }

function loadData() {
    $("#tabledata").empty();
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping-report',
        cache: false, timeout: 600000,
        success: function(rows){
            allRows = rows || [];
            buildFilters();
            renderTable(allRows);
        },
        error: function(){
            $("#tabledata").append('<tr><td colspan="7" style="text-align:center;color:red;padding:15px;">Error loading data.</td></tr>');
        }
    });
    return false;
}

function buildFilters() {
    var dists = {}, itis = {}, inds = {};
    allRows.forEach(function(r){
        if (r.dist_name) dists[r.dist_name] = true;
        if (r.iti_name) itis[r.iti_name] = true;
        if (r.industry_name) inds[r.industry_name] = true;
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
    $("#tabledata").empty();
    if (!rows.length) {
        $("#tabledata").append('<tr><td colspan="7" style="text-align:center;padding:15px;font-weight:bold;">NO DATA FOUND.</td></tr>');
        return;
    }
    rows.forEach(function(r, i){
        $("#tabledata").append('<tr>'
            + '<td>' + (i + 1) + '</td>'
            + '<td>' + esc(r.slno) + '</td>'
            + '<td>' + esc(r.dist_name) + '</td>'
            + '<td>' + esc(r.iti_name) + '</td>'
            + '<td>' + esc(r.industry_name) + '</td>'
            + '<td>' + esc(r.industry_type) + '</td>'
            + '<td>' + esc(r.trade_name) + '</td>'
            + '</tr>');
    });
}

function filterData() {
    var dist = $("#distcode").val();
    var iti = $("#iticode").val();
    var ind = $("#industryId").val();
    var filtered = allRows.filter(function(r){
        if (dist && (r.dist_name || '') !== dist) return false;
        if (iti && (r.iti_name || '') !== iti) return false;
        if (ind && (r.industry_name || '') !== ind) return false;
        return true;
    });
    renderTable(filtered);
    return false;
}

function fnExcelReport() {
    var table = document.getElementById('reporttable');
    if (!table || $("#tabledata tr").length === 0) return false;
    var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, 'INDUSTRY_ITI_MAPPING_REPORT.xlsx');
    return false;
}
</script>
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">
<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div class="container border p-2 mt-2 shadow-lg" style="border-radius: 5px;">
    <div align="center" style="text-decoration: underline;color: fuchsia;">ITI-Industry Mapping Details</div>
    <div class="row mb-1">
        <div class="col-2"><label for="distcode">District</label>
            <select id="distcode" class="form-control" onchange="return filterData();"><option value="">-SELECT-</option></select></div>
        <div class="col-3"><label for="iticode">ITI</label>
            <select id="iticode" class="form-control" onchange="return filterData();"><option value="">-SELECT-</option></select></div>
        <div class="col-3"><label for="industryId">INDUSTRY</label>
            <select id="industryId" class="form-control" onchange="return filterData();"><option value="">-SELECT-</option></select></div>
        <div class="col-2"></div>
        <div class="col-2"><button onclick="return fnExcelReport();" class="btn btn-info btn-sm mt-4">DOWNLOAD EXCEL</button></div>
    </div>
    <table class="table table-bordered" id="reporttable">
        <thead>
            <tr>
                <td style="color: white;background-color: black;">S.NO</td>
                <td style="color: white;background-color: black;">ID</td>
                <td style="color: white;background-color: black;">DISTRICT</td>
                <td style="color: white;background-color: black;">ITI</td>
                <td style="color: white;background-color: black;">INDUSTRY</td>
                <td style="color: white;background-color: black;">TYPE</td>
                <td style="color: white;background-color: black;">TRADE</td>
            </tr>
        </thead>
        <tbody id="tabledata"></tbody>
    </table>
</div>
</body>
</html>