<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Industry Partner Details</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<script>
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';
var pid      = '<c:out value="${param.pid}" default=""/>';
</script>
<script>
$(document).ready(function(){
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode;
    if (!pid) { $("#serverResp").html("<span style='color:red;'>No record selected.</span>"); return; }
    loadDistricts();
    loadDetails();
});

function esc(v) { if (v === null || v === undefined) return ''; return $('<div/>').text(String(v)).html(); }

function loadDistricts() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/districts', cache: false, timeout: 600000,
        success: function(rows){
            (rows || []).forEach(function(d){ $("#distCode").append('<option value="' + esc(d.dist_code) + '">' + esc(d.dist_name) + '</option>'); });
        }
    });
}

function loadDetails() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/industry-partner-details/' + encodeURIComponent(pid),
        cache: false, timeout: 600000,
        success: function(d){
            $("#distCode").val(d.distCode || '');
            loadItisForEdit(d.distCode, d.itiCode);
            $("#revisedLeadSector").val(d.revisedLeadSector || '');
            $("#proposedNewTrade").val(d.proposedNewTrade || '');
            $("#revisedLeadIndustryPartner").val(d.revisedLeadIndustryPartner || '');
        },
        error: function(){ $("#serverResp").html("<span style='color:red;'>Error loading details.</span>"); }
    });
}

function loadItisForEdit(distCode, selectedIti) {
    $("#itiCode").empty().append('<option value="">-SELECT-</option>');
    if (!distCode) return;
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/itis?distCode=' + encodeURIComponent(distCode),
        cache: false, timeout: 600000,
        success: function(rows){
            (rows || []).forEach(function(iti){
                $("#itiCode").append('<option value="' + iti.iti_code + '">' + esc(iti.iti_name) + '</option>');
            });
            if (selectedIti) $("#itiCode").val(String(selectedIti));
        }
    });
}

function getItis(distCode){
    $("#itiCode").empty().append('<option value="">-SELECT-</option>');
    if (!distCode) return false;
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/itis?distCode=' + encodeURIComponent(distCode),
        cache: false, timeout: 600000,
        success: function(rows){ (rows || []).forEach(function(iti){ $("#itiCode").append('<option value="' + iti.iti_code + '">' + esc(iti.iti_name) + '</option>'); }); }
    });
    return false;
}
function saveData(){
    $("#serverResp").html('');
    var distCode = $("#distCode").val();
    var itiCode = $("#itiCode").val();
    if (!distCode) { $("#serverResp").html("<span style='color:red;'>Please select District.</span>"); return false; }
    if (!itiCode) { $("#serverResp").html("<span style='color:red;'>Please select ITI.</span>"); return false; }
    $.ajax({
        type: 'put', url: baseUrl + 'api/implant/industry-partner-details/' + encodeURIComponent(pid),
        contentType: 'application/json',
        data: JSON.stringify({ distCode: distCode, itiCode: itiCode,
            revisedLeadSector: $("#revisedLeadSector").val(), proposedNewTrade: $("#proposedNewTrade").val(),
            revisedLeadIndustryPartner: $("#revisedLeadIndustryPartner").val(), entryBy: insCode }),
        timeout: 600000,
        success: function(){
            $("#serverResp").html("<span style='color:green;'>Updated successfully!</span>");
            setTimeout(function(){ window.location.href = '${pageContext.request.contextPath}/implant/partners'; }, 1200);
        },
        error: function(xhr){
            var msg = "Failed to update";
            try { var r = JSON.parse(xhr.responseText); if (r && r.message) msg = r.message; } catch(e) {}
            $("#serverResp").html("<span style='color:red;'>Error: " + esc(msg) + "</span>");
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
<div class="container">
    <div align="center" style="text-decoration: underline;color: fuchsia;">EDIT INDUSTRY PARTNER DETAILS</div>
    <div class="border p-2 mt-2 shadow-lg">
        <div class="row">
            <div class="col-md-6">
                <label for="distCode">DISTRICT</label>
                <select class="form-select" id="distCode" onchange="return getItis(this.value);"><option value="">-SELECT-</option></select>
            </div>
            <div class="col-md-6">
                <label for="itiCode">ITI</label>
                <select class="form-select" id="itiCode"><option value="">-SELECT-</option></select>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-md-6"><label for="revisedLeadSector">REVISED LEAD SECTOR</label>
                <input type="text" class="form-control" id="revisedLeadSector"/></div>
            <div class="col-md-6"><label for="proposedNewTrade">PROPOSED NEW TRADE</label>
                <input type="text" class="form-control" id="proposedNewTrade"/></div>
        </div>
        <div class="row mt-2">
            <div class="col-md-12"><label for="revisedLeadIndustryPartner">REVISED LEAD INDUSTRY PARTNER</label>
                <textarea rows="4" class="form-control" id="revisedLeadIndustryPartner"></textarea></div>
        </div>
        <div align="center" class="mt-1">
            <button class="btn btn-success" onclick="return saveData();">SUBMIT</button>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/implant/partners">CANCEL</a>
        </div>
        <div align="center" class="mt-1" id="serverResp"></div>
    </div>
</div>
</body>
</html>