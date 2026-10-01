<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Industry ITI Mapping ITI</title>
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
</script>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

    loadMasters();
    loadMappings();

});

var industries = [], trades = [];

function esc(v) {
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

function loadMasters() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/masters',
        cache: false, timeout: 600000,
        success: function(response){
            industries = response.industries || [];
            trades = response.trades || [];
            industries.forEach(function(ind){
                $("#industryName").append('<option value="' + ind.industry_id + '">' + esc(ind.industry_name) + '</option>');
            });
            trades.forEach(function(trd){
                $("#tradeName").append('<option value="' + trd.trade_code + '">' + esc(trd.trade_name) + '</option>');
            });
        },
        error: function(){ $("#servermsg").html("<span style='color:red;'>Error loading industry/trade lists.</span>"); }
    });
}

function loadMappings() {
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping?itiCode=' + encodeURIComponent(insCode),
        cache: false, timeout: 600000,
        success: function(response){ renderMappings(response || []); }
    });
}
function renderMappings(rows) {
    $("#industrydata").empty();
    if (!rows.length) {
        $("#industrydata").append('<tr><td colspan="5" style="text-align:center;padding:15px;font-weight:bold;">No industries mapped yet.</td></tr>');
        return;
    }
    rows.forEach(function(m){
        $("#industrydata").append('<tr>'
            + '<td>' + esc(m.industry_id) + '</td>'
            + '<td>' + esc(m.industry_name) + '</td>'
            + '<td>' + esc(m.industry_type) + '</td>'
            + '<td>' + esc(m.trade_name) + '</td>'
            + '<td style="white-space:nowrap;">'
            + '<button class="btn btn-primary btn-sm me-1" style="display:inline-flex;align-items:center;" onclick="return editMapping(' + m.slno + ');"><i class="fas fa-pen"></i> Edit</button>'
            + '<button class="btn btn-danger btn-sm" style="display:inline-flex;align-items:center;" onclick="return deleteMapping(' + m.slno + ');"><i class="fas fa-trash"></i> Delete</button>'
            + '</td>'
            + '</tr>');
    });
}

function savedData(){
    $("#servermsg").html('');
    var industryId = $("#industryName").val();
    var tradeCode = $("#tradeName").val();

    if (!industryId) { $("#servermsg").html("<span style='color:red;'>Please select Industry Name.</span>"); return false; }
    if (!tradeCode) { $("#servermsg").html("<span style='color:red;'>Please select Trade Name.</span>"); return false; }

    $.ajax({
        type: 'post',
        url: baseUrl + 'api/implant/mapping?itiCode=' + encodeURIComponent(insCode),
        contentType: 'application/json',
        data: JSON.stringify({ industryId: parseInt(industryId), tradeCode: parseInt(tradeCode), entryBy: insCode }),
        timeout: 600000,
        success: function(response){
            $("#servermsg").html("<span style='color:green;'>" + esc(response.message || "Industry mapped successfully!") + "</span>");
            $("#industryName").val(''); $("#tradeName").val('');
            loadMappings();
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

function editMapping(slno){
    window.location.href = '${pageContext.request.contextPath}/implant/mapping/edit?slno=' + slno;
    return false;
}

function deleteMapping(slno){
    if (!confirm("Delete this industry - trade mapping?")) return false;
    $.ajax({
        type: 'delete', url: baseUrl + 'api/implant/mapping/' + slno, timeout: 600000,
        success: function(response){
            $("#servermsg").html("<span style='color:green;'>Mapping deleted successfully.</span>");
            loadMappings();
        },
        error: function(){
            $("#servermsg").html("<span style='color:red;'>Error deleting mapping.</span>");
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
    <div align="center" style="text-decoration: underline;color: fuchsia;">INDUSTRY - ITI MAPPING FORM</div>
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
        <button class="btn btn-success m-1" onclick="return savedData();">SUBMIT</button>
    </div>
    <div align="center" id="servermsg"></div>
</div>
<div class="container border p-2 mt-2 shadow-lg" style="border-radius: 5px;">
    <div align="center" style="text-decoration: underline;color: fuchsia;">Available Industries for your ITI</div>
    <table class="table table-bordered">
        <thead>
            <tr>
                <td style="background-color: black;color: white;">INDUSTRY ID</td>
                <td style="background-color: black;color: white;">NAME</td>
                <td style="background-color: black;color: white;">TYPE</td>
                <td style="background-color: black;color: white;">TRADE</td>
                <td style="background-color: black;color: white;">ACTIONS</td>
            </tr>
        </thead>
        <tbody id="industrydata"></tbody>
    </table>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>