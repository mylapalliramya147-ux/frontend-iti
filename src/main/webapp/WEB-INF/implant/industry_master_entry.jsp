<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Industry Entry</title>
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

});

function esc(v) {
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

function saveIndustry(){
    $("#servermsg").html('');
    var industryName = $("#industryname").val().trim();
    var industryType = $("#industrytype").val();
    var industryAddress = $("#industryaddress").val().trim();

    if (!industryName) { $("#servermsg").html("<span style='color:red;'>Industry Name is required.</span>"); return false; }
    if (!industryType) { $("#servermsg").html("<span style='color:red;'>Please select Industry Type.</span>"); return false; }

    $.ajax({
        type: 'post',
        url: baseUrl + 'api/implant/industry-master',
        contentType: 'application/json',
        data: JSON.stringify({ industryName: industryName, industryType: industryType,
                               industryAddress: industryAddress, entryBy: insCode }),
        timeout: 600000,
        success: function(response){
            $("#servermsg").html("<span style='color:green;'>Industry saved successfully! (ID: " + esc(response.industryId) + ")</span>");
            $("#industryname").val(''); $("#industrytype").val(''); $("#industryaddress").val('');
        },
        error: function(xhr){
            var msg = "Failed to save industry";
            try {
                var resp = typeof xhr.responseText === 'string' ? JSON.parse(xhr.responseText) : xhr.responseJSON;
                if (resp && resp.message) msg = resp.message;
            } catch(e) { /* keep default */ }
            $("#servermsg").html("<span style='color:red;'>Error: " + esc(msg) + "</span>");
        }
    });
    return false;
}
</script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
</head>
<body>

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">

<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div class="container border p-2 mt-2 shadow-lg" style="border-radius: 5px;">
    <div align="center" style="text-decoration: underline;color: fuchsia;">INDUSTRY ENTRY FORM</div>
    <div class="row">
        <div class="col-md-8">
            <label for="industryname">Industry Name</label>
            <input type="text" id="industryname" class="form-control"/>
        </div>
        <div class="col-md-4">
            <label for="industrytype">Industry Type</label>
            <select id="industrytype" class="form-control">
                <option value="">-SELECT-</option>
                <option value="Major">Major</option>
                <option value="Minor">Minor</option>
            </select>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label for="industryaddress">Industry Address</label>
            <textarea rows="3" id="industryaddress" class="form-control"></textarea>
        </div>
    </div>
    <div align="center">
        <button class="btn btn-success m-2" onclick="return saveIndustry();">SUBMIT</button>
    </div>
    <div align="center" id="servermsg"></div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>