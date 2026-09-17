<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Industry Master</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<!-- ITIAP uses server sessions, NOT the JWT the original page used -->
<script>
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';
var industryId = '<c:out value="${param.industryId}" default=""/>';
</script>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode;

    if (!industryId) {
        $("#servermsg").html("<span style='color:red;'>No industry selected. Go back and click Edit on a row.</span>");
        return;
    }
    loadIndustry();

});

function esc(v) {
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

function loadIndustry() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/industry-master/' + encodeURIComponent(industryId),
        cache: false, timeout: 600000,
        success: function(ind){
            $("#industryName").val(ind.industryName || '');
            $("#industryType").val(ind.industryType || '');
            $("#industryAddress").val(ind.industryAddress || '');
        },
        error: function(){ $("#servermsg").html("<span style='color:red;'>Error loading industry details.</span>"); }
    });
}

function saveIndustry(){
    $("#servermsg").html('');
    var industryName = $("#industryName").val().trim();
    var industryType = $("#industryType").val();

    if (!industryName) { $("#servermsg").html("<span style='color:red;'>Industry Name is required.</span>"); return false; }
    if (!industryType) { $("#servermsg").html("<span style='color:red;'>Please select Industry Type.</span>"); return false; }

    $.ajax({
        type: 'put',
        url: baseUrl + 'api/implant/industry-master/' + encodeURIComponent(industryId),
        contentType: 'application/json',
        data: JSON.stringify({ industryName: industryName, industryType: industryType,
                               industryAddress: $("#industryAddress").val(), editBy: insCode }),
        timeout: 600000,
        success: function(response){
            $("#servermsg").html("<span style='color:green;'>" + esc(response.message || "Industry details updated successfully!") + "</span>");
            setTimeout(function(){ window.location.href = '${pageContext.request.contextPath}/implant/industrymaster'; }, 1200);
        },
        error: function(xhr){
            var msg = "Failed to update industry";
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
</head>
<body>

<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div class="container border p-2 mt-2 shadow-lg" style="border-radius: 5px;">
    <div align="center" style="text-decoration: underline;color: fuchsia;">EDIT INDUSTRY ENTRY FORM</div>
    <div class="row">
        <div class="col-md-8">
            <label for="industryName">Industry Name</label>
            <input id="industryName" class="form-control" type="text"/>
        </div>
        <div class="col-md-4">
            <label for="industryType">Industry Type</label>
            <select id="industryType" class="form-control">
                <option value="">-SELECT-</option>
                <option value="Major">Major</option>
                <option value="Minor">Minor</option>
            </select>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label for="industryAddress">Industry Address</label>
            <textarea id="industryAddress" class="form-control" rows="3"></textarea>
        </div>
    </div>
    <div align="center">
        <button class="btn btn-success m-2" onclick="return saveIndustry();">SUBMIT</button>
        <a class="btn btn-secondary m-2" href="${pageContext.request.contextPath}/implant/industrymaster">CANCEL</a>
    </div>
    <div align="center" id="servermsg"></div>
</div>
</body>
</html>