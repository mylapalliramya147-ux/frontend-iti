<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Industry Master Report</title>
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
        type: 'get', url: baseUrl + 'api/implant/industry-master',
        cache: false, timeout: 600000,
        success: function(rows){
            if (!rows || !rows.length) {
                $("#tabledata").append('<tr><td colspan="5" style="text-align:center;padding:15px;font-weight:bold;">No data found.</td></tr>');
                return;
            }
            rows.forEach(function(ind, i){
                $("#tabledata").append('<tr>'
                    + '<td>' + (i + 1) + '</td>'
                    + '<td>' + esc(ind.industryId) + '</td>'
                    + '<td>' + esc(ind.industryName) + '</td>'
                    + '<td>' + esc(ind.industryType) + '</td>'
                    + '<td>' + esc(ind.industryAddress) + '</td>'
                    + '</tr>');
            });
        },
        error: function(){
            $("#tabledata").append('<tr><td colspan="5" style="text-align:center;color:red;padding:15px;">Error loading data.</td></tr>');
        }
    });
    return false;
}

function fnExcelReport() {
    var table = document.getElementById('reporttable');
    if (!table || $("#tabledata tr").length === 0) return false;
    var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, 'INDUSTRY_MASTER_REPORT.xlsx');
    return false;
}
</script>
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">
<%@ include file="../portal_navbar.jsp" %>
<br>
<div class="container border p-2 mt-2 shadow-lg" style="border-radius: 5px;">
    <div align="center" style="text-decoration: underline;color: fuchsia;">AVAILABLE INDUSTRY MASTER DATA</div>
    <div class="col-2">
        <input type="button" value="DOWNLOAD EXCEL" onclick="return fnExcelReport();" class="btn btn-info btn-sm mt-4"/>
    </div>
    <table class="table table-bordered" id="reporttable">
        <thead>
            <tr>
                <td style="background-color: black;color: white;">S.NO</td>
                <td style="background-color: black;color: white;">ID</td>
                <td style="background-color: black;color: white;">NAME</td>
                <td style="background-color: black;color: white;">TYPE</td>
                <td style="background-color: black;color: white;">ADDRESS</td>
            </tr>
        </thead>
        <tbody id="tabledata"></tbody>
    </table>
</div>
</body>
</html>