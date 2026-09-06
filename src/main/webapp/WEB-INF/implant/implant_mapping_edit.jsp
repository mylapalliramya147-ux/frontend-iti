<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Industries</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<!-- ITIAP uses server sessions, NOT the JWT the original page used -->
<script>
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';
var slno     = '<c:out value="${param.slno}" default=""/>';
</script>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

    if (!slno) {
        $("#servermsg").html("<span style='color:red;'>No mapping selected. Go back and click Edit on a row.</span>");
        return;
    }
    loadMastersAndMapping();

});

function esc(v) {
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

function loadMastersAndMapping() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/masters',
        cache: false, timeout: 600000,
        success: function(masters){
            $("#industryName").append('<option value="">-SELECT-</option>');
            (masters.industries || []).forEach(function(ind){
                $("#industryName").append('<option value="' + ind.industry_id + '">' + esc(ind.industry_name) + '</option>');
            });
            $("#tradeName").append('<option value="">-SELECT-</option>');
            (masters.trades || []).forEach(function(trd){
                $("#tradeName").append('<option value="' + trd.trade_code + '">' + esc(trd.trade_name) + '</option>');
            });
            loadMapping();
        },
        error: function(){ $("#servermsg").html("<span style='color:red;'>Error loading industry/trade lists.</span>"); }
    });
}

function loadMapping() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/' + encodeURIComponent(slno),
        cache: false, timeout: 600000,
        success: function(m){
            $("#industryName").val(String(m.industry_id));
            $("#tradeName").val(String(m.trade_code));
        },
        error: function(){ $("#servermsg").html("<span style='color:red;'>Error loading mapping details.</span>"); }
    });
}
function updateIndustry(){
    $("#servermsg").html('');
    var industryId = $("#industryName").val();
    var tradeCode = $("#tradeName").val();

    if (!industryId) { $("#servermsg").html("<span style='color:red;'>Please select Industry Name.</span>"); return false; }
    if (!tradeCode) { $("#servermsg").html("<span style='color:red;'>Please select Trade Name.</span>"); return false; }

    $.ajax({
        type: 'put',
        url: baseUrl + 'api/implant/mapping/' + encodeURIComponent(slno),
        contentType: 'application/json',
        data: JSON.stringify({ industryId: parseInt(industryId), tradeCode: parseInt(tradeCode), entryBy: insCode }),
        timeout: 600000,
        success: function(response){
            $("#servermsg").html("<span style='color:green;'>" + esc(response.message || "Industry details updated successfully!") + "</span>");
            setTimeout(function(){ window.location.href = '${pageContext.request.contextPath}/implant/mapping'; }, 1200);
        },
        error: function(xhr){
            var msg = "Failed to update mapping";
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

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/placements/loginSuccess">
        <i class="fas fa-home"></i> Home
    </a>
    <div class="text-white fw-bold">
        Welcome :
        <span id="userinfo"></span>
    </div>
    <div>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>
</nav>
<br>
<div class="container border p-2 mt-2 shadow-lg" style="border-radius: 5px;">
    <div align="center" style="text-decoration: underline;color: fuchsia;">EDIT INDUSTRY DETAILS FORM</div>
    <div class="row">
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
        <button class="btn btn-success m-2" onclick="return updateIndustry();">UPDATE</button>
        <a class="btn btn-secondary m-2" href="${pageContext.request.contextPath}/implant/mapping">CANCEL</a>
    </div>
    <div align="center" id="servermsg"></div>
</div>
</body>
</html>