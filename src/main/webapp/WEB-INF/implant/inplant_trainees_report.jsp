<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IN-PLANT Trainees Report</title>
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
    loadCounts();
});

function esc(v) { if (v === null || v === undefined) return ''; return $('<div/>').text(String(v)).html(); }

function loadCounts() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/trainees/counts',
        cache: false, timeout: 600000,
        success: function(c){
            $("#noOfItis").text(c.itis);
            $("#noOfIndustries").text(c.industries);
            $("#noOfTrades").text(c.trades);
            $("#noOfTrainees").text(c.trainees);
        },
        error: function(){ $("#noOfTrainees").text('Error loading counts'); }
    });
}

function getReportItis() { loadList('itis', 'ITIs'); return false; }
function getReportIndustries() { loadList('industries', 'Industries'); return false; }
function getReportTrades() { loadList('trades', 'Trades'); return false; }

function loadList(type, heading) {
    $("#dataHeading").text('LIST OF ' + heading);
    $("#datadiv").empty();
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/trainees?type=' + type,
        cache: false, timeout: 600000,
        success: function(rows){
            if (!rows || !rows.length) {
                $("#datadiv").html('<div align="center" style="padding:10px;font-weight:bold;">No data.</div>');
                return;
            }
            var html = '<table class="table table-bordered"><thead><tr><td style="background-color:black;color:white;">S.NO</td><td style="background-color:black;color:white;">NAME</td></tr></thead><tbody>';
            rows.forEach(function(r, i){
                var name = r.iti_name || r.industry_name || r.trade_name || r.iti_code || r.trade_short || '';
                html += '<tr><td>' + (i + 1) + '</td><td>' + esc(name) + '</td></tr>';
            });
            html += '</tbody></table>';
            $("#datadiv").html(html);
        },
        error: function(){ $("#datadiv").html('<div align="center" style="color:red;padding:10px;">Error loading list.</div>'); }
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
    <div align="center" style="text-decoration: underline;color: fuchsia;">IN-PLANT TRAINEES REPORT</div>
    <div id="countdiv">
        <div class="row">
            <div class="col-md-3 border shadow-lg text-center">
                <label for="noOfItis">No of ITIs</label><br>
                <a href="javascript:getReportItis();"><span style="font-weight: bolder;" id="noOfItis"></span></a>
            </div>
            <div class="col-md-3 border shadow-lg text-center">
                <label for="noOfIndustries">No of Industries</label><br>
                <a href="javascript:getReportIndustries();"><span style="font-weight: bolder;" id="noOfIndustries"></span></a>
            </div>
            <div class="col-md-3 border shadow-lg text-center">
                <label for="noOfTrades">No of Trades</label><br>
                <a href="javascript:getReportTrades();"><span style="font-weight: bolder;" id="noOfTrades"></span></a>
            </div>
            <div class="col-md-3 border shadow-lg text-center">
                <label for="noOfTrainees">No of Trainees</label><br>
                <span style="font-weight: bolder;color: blue;" id="noOfTrainees"></span>
            </div>
        </div>
    </div>
    <div align="center" style="text-decoration: underline;color: fuchsia;" id="dataHeading"></div>
    <div id="datadiv"></div>
</div>
</body>
</html>