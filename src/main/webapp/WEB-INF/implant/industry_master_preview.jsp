<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Industry Master Preview</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<!-- ITIAP uses server sessions, NOT the JWT the original page used -->
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

    loadIndustries();

});

function esc(v) {
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

function loadIndustries() {
    $("#tabledata").empty();
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/industry-master',
        cache: false, timeout: 600000,
        success: function(rows){
            if (!rows || !rows.length) {
                $("#tabledata").append('<tr><td colspan="6" style="text-align:center;padding:15px;font-weight:bold;">No industry master data found.</td></tr>');
                return;
            }
            rows.forEach(function(ind, i){
                $("#tabledata").append('<tr>'
                    + '<td>' + (i + 1) + '</td>'
                    + '<td>' + esc(ind.industryId) + '</td>'
                    + '<td>' + esc(ind.industryName) + '</td>'
                    + '<td>' + esc(ind.industryType) + '</td>'
                    + '<td>' + esc(ind.industryAddress) + '</td>'
                    + '<td style="white-space:nowrap;">'
                    + '<button class="btn btn-primary btn-sm me-1" style="display:inline-flex;align-items:center;" onclick="return editIndustry(' + ind.industryId + ');"><i class="fas fa-pen"></i> Edit</button>'
                    + '<button class="btn btn-danger btn-sm" style="display:inline-flex;align-items:center;" onclick="return deleteIndustry(' + ind.industryId + ', ' + i + ');"><i class="fas fa-trash"></i> Delete</button>'
                    + '</td>'
                    + '</tr>');
            });
        },
        error: function(){
            $("#tabledata").append('<tr><td colspan="6" style="text-align:center;color:red;padding:15px;">Error loading industry master data.</td></tr>');
        }
    });
    return false;
}

function editIndustry(industryId){
    window.location.href = '${pageContext.request.contextPath}/implant/industrymaster/edit?industryId=' + industryId;
    return false;
}

function deleteIndustry(industryId, rowIndex){
    if (!confirm("Delete this industry from the master? This cannot be undone.")) return false;
    $.ajax({
        type: 'delete', url: baseUrl + 'api/implant/industry-master/' + industryId, timeout: 600000,
        success: function(){
            $("#tabledata tr").eq(rowIndex).remove();
        },
        error: function(xhr){
            var msg = "Error deleting industry";
            try {
                var resp = typeof xhr.responseText === 'string' ? JSON.parse(xhr.responseText) : xhr.responseJSON;
                if (resp && resp.message) msg = resp.message;
            } catch(e) { /* keep default */ }
            alert(msg);
        }
    });
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
    <table class="table table-bordered" id="reporttable">
        <thead>
            <tr>
                <td style="background-color: black; color: white;">S.NO</td>
                <td style="background-color: black; color: white;">ID</td>
                <td style="background-color: black; color: white;">NAME</td>
                <td style="background-color: black; color: white;">TYPE</td>
                <td style="background-color: black; color: white;">ADDRESS</td>
                <td style="background-color: black; color: white;">ACTIONS</td>
            </tr>
        </thead>
        <tbody id="tabledata"></tbody>
    </table>
</div>
</body>
</html>