<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Industry ITI Mapping</title>
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

    loadDistricts();
    loadMasters();

});

function esc(v) {
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

function loadDistricts() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/districts',
        cache: false, timeout: 600000,
        success: function(rows){
            (rows || []).forEach(function(d){
                $("#dist").append('<option value="' + esc(d.dist_code) + '">' + esc(d.dist_name) + '</option>');
            });
        },
        error: function(){ $("#servermsg").html("<span style='color:red;'>Error loading districts.</span>"); }
    });
}

function getnItis(distCode){
    $("#itiName").empty().append('<option value="">-SELECT-</option>');
    if (!distCode) return false;
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/itis?distCode=' + encodeURIComponent(distCode),
        cache: false, timeout: 600000,
        success: function(rows){
            (rows || []).forEach(function(iti){
                $("#itiName").append('<option value="' + iti.iti_code + '">' + esc(iti.iti_name) + '</option>');
            });
        },
        error: function(){ $("#servermsg").html("<span style='color:red;'>Error loading ITIs.</span>"); }
    });
    return false;
}

function loadMasters() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/masters',
        cache: false, timeout: 600000,
        success: function(response){
            (response.industries || []).forEach(function(ind){
                $("#industryName").append('<option value="' + ind.industry_id + '">' + esc(ind.industry_name) + '</option>');
            });
            (response.trades || []).forEach(function(trd){
                $("#tradeName").append('<option value="' + trd.trade_code + '">' + esc(trd.trade_name) + '</option>');
            });
        },
        error: function(){ $("#servermsg").html("<span style='color:red;'>Error loading industry/trade lists.</span>"); }
    });
}
function savedData(){
    $("#servermsg").html('');
    var distCode = $("#dist").val();
    var itiCode = $("#itiName").val();
    var industryId = $("#industryName").val();
    var tradeCode = $("#tradeName").val();

    if (!distCode) { $("#servermsg").html("<span style='color:red;'>Please select District Name.</span>"); return false; }
    if (!itiCode) { $("#servermsg").html("<span style='color:red;'>Please select ITI Name.</span>"); return false; }
    if (!industryId) { $("#servermsg").html("<span style='color:red;'>Please select Industry Name.</span>"); return false; }
    if (!tradeCode) { $("#servermsg").html("<span style='color:red;'>Please select Trade Name.</span>"); return false; }

    $.ajax({
        type: 'post',
        url: baseUrl + 'api/implant/mapping?itiCode=' + encodeURIComponent(itiCode),
        contentType: 'application/json',
        data: JSON.stringify({ industryId: parseInt(industryId), tradeCode: parseInt(tradeCode), entryBy: insCode }),
        timeout: 600000,
        success: function(response){
            $("#servermsg").html("<span style='color:green;'>" + esc(response.message || "Industry mapped to the ITI successfully!") + "</span>");
            $("#itiName").val(''); $("#industryName").val(''); $("#tradeName").val('');
        },
        error: function(xhr){
            var msg = "Failed to save mapping";
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

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">

<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div class="container border p-2 mt-2 shadow-lg" style="border-radius: 5px;">
    <div align="center" style="text-decoration: underline;color: fuchsia;">INDUSTRY - ITI MAPPING FORM</div>
    <div class="row">
        <div class="col-md-6">
            <label for="dist">District Name</label>
            <select class="form-control" id="dist" onchange="return getnItis(this.value);">
                <option value="">-SELECT-</option>
            </select>
        </div>
        <div class="col-md-6">
            <label for="itiName">ITI Name</label>
            <select class="form-control" id="itiName">
                <option value="">-SELECT-</option>
            </select>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-md-6">
            <label for="industryName">Industry Name</label>
            <select class="form-control" id="industryName">
                <option value="">-SELECT-</option>
            </select>
        </div>
        <div class="col-md-6">
            <label for="tradeName">Trade Name</label>
            <select class="form-control" id="tradeName">
                <option value="">-SELECT-</option>
            </select>
        </div>
    </div>
    <div align="center">
        <button class="btn btn-success m-1" onclick="return savedData();">SUBMIT</button>
    </div>
    <div align="center" id="servermsg"></div>
</div>
</body>
</html>