<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INDUSTRY PARTNER DETAILS</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/xlsx.full.min.js"></script>
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
    loadData();

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
                $("#distCode").append('<option value="' + esc(d.dist_code) + '">' + esc(d.dist_name) + '</option>');
            });
        },
        error: function(){ $("#serverResp").html("<span style='color:red;'>Error loading districts.</span>"); }
    });
}

function getItis(distCode){
    $("#itiCode").empty().append('<option value="">-SELECT-</option>');
    if (!distCode) return false;
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/mapping/itis?distCode=' + encodeURIComponent(distCode),
        cache: false, timeout: 600000,
        success: function(rows){
            (rows || []).forEach(function(iti){
                $("#itiCode").append('<option value="' + iti.iti_code + '">' + esc(iti.iti_name) + '</option>');
            });
        },
        error: function(){ $("#serverResp").html("<span style='color:red;'>Error loading ITIs.</span>"); }
    });
    return false;
}

function loadData() {
    $("#tabledata").empty();
    $.ajax({
        type: 'get', url: baseUrl + 'api/implant/industry-partner-details',
        cache: false, timeout: 600000,
        success: function(rows){
            rows.forEach(function(r, i){
                $("#tabledata").append('<tr>'
                    + '<td>' + (i + 1) + '</td>'
                    + '<td>' + esc(r.distName || r.distCode) + '</td>'
                    + '<td>' + esc(r.itiName || r.itiCode) + '</td>'
                    + '<td>' + esc(r.revisedLeadSector) + '</td>'
                    + '<td>' + esc(r.proposedNewTrade) + '</td>'
                    + '<td>' + esc(r.revisedLeadIndustryPartner) + '</td>'
                    + '<td style="white-space:nowrap;">'
                    + '<button class="btn btn-primary btn-sm me-1" style="display:inline-flex;align-items:center;" onclick="return editDetails(' + r.pid + ');"><i class="fas fa-pen"></i> Edit</button>'
                    + '<button class="btn btn-danger btn-sm" style="display:inline-flex;align-items:center;" onclick="return deleteDetails(' + r.pid + ', ' + i + ');"><i class="fas fa-trash"></i> Delete</button>'
                    + '</td>'
                    + '</tr>');
            });
        },
        error: function(){
            $("#tabledata").append('<tr><td colspan="7" style="text-align:center;color:red;padding:15px;">Error loading details.</td></tr>');
        }
    });
    return false;
}
function editDetails(pid){
    window.location.href = '${pageContext.request.contextPath}/implant/partners/edit?pid=' + pid;
    return false;
}

function deleteDetails(pid, rowIndex){
    if (!confirm("Delete this industry partner detail? This cannot be undone.")) return false;
    $.ajax({
        type: 'delete', url: baseUrl + 'api/implant/industry-partner-details/' + pid, timeout: 600000,
        success: function(){ $("#tabledata tr").eq(rowIndex).remove(); },
        error: function(xhr){
            var msg = "Error deleting";
            try {
                var resp = typeof xhr.responseText === 'string' ? JSON.parse(xhr.responseText) : xhr.responseJSON;
                if (resp && resp.message) msg = resp.message;
            } catch(e) { /* keep default */ }
            alert(msg);
        }
    });
    return false;
}

function saveData(){
    $("#serverResp").html('');
    var distCode = $("#distCode").val();
    var itiCode = $("#itiCode").val();
    var rls = $("#revisedLeadSector").val().trim();
    var pnt = $("#proposedNewTrade").val().trim();
    var rlip = $("#revisedLeadIndustryPartner").val().trim();

    if (!distCode) { $("#serverResp").html("<span style='color:red;'>Please select District.</span>"); return false; }
    if (!itiCode) { $("#serverResp").html("<span style='color:red;'>Please select ITI.</span>"); return false; }

    $.ajax({
        type: 'post', url: baseUrl + 'api/implant/industry-partner-details',
        contentType: 'application/json',
        data: JSON.stringify({ distCode: distCode, itiCode: itiCode, revisedLeadSector: rls,
                               proposedNewTrade: pnt, revisedLeadIndustryPartner: rlip, entryBy: insCode }),
        timeout: 600000,
        success: function(){
            $("#serverResp").html("<span style='color:green;'>Industry partner details saved successfully!</span>");
            $("#revisedLeadSector").val(''); $("#proposedNewTrade").val(''); $("#revisedLeadIndustryPartner").val('');
            loadData();
        },
        error: function(xhr){
            var msg = "Failed to save";
            try {
                var resp = typeof xhr.responseText === 'string' ? JSON.parse(xhr.responseText) : xhr.responseJSON;
                if (resp && resp.message) msg = resp.message;
            } catch(e) { /* keep default */ }
            $("#serverResp").html("<span style='color:red;'>Error: " + esc(msg) + "</span>");
        }
    });
    return false;
}

function fnExcelReport2() {
    var table = document.getElementById('reporttable');
    if (!table || $("#tabledata tr").length === 0) return false;
    var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, 'INDUSTRY_PARTNER_DETAILS.xlsx');
    return false;
}
</script>
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">
<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div class="container">
    <div align="center" style="text-decoration: underline;color: fuchsia;">INDUSTRY PARTNER DETAILS</div>
    <div class="border p-2 mt-2 shadow-lg">
        <div align="center" style="text-decoration: underline;color: fuchsia;">ENTRY FORM</div>
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
            <div class="col-md-6">
                <label for="revisedLeadSector">REVISED LEAD SECTOR</label>
                <input type="text" class="form-control" id="revisedLeadSector"/>
            </div>
            <div class="col-md-6">
                <label for="proposedNewTrade">PROPOSED NEW TRADE</label>
                <input type="text" class="form-control" id="proposedNewTrade"/>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-md-12">
                <label for="revisedLeadIndustryPartner">REVISED LEAD INDUSTRY PARTNER</label>
                <textarea rows="4" class="form-control" id="revisedLeadIndustryPartner"></textarea>
            </div>
        </div>
        <div align="center" class="mt-1">
            <button class="btn btn-success" onclick="return saveData();">SUBMIT</button>
        </div>
        <div align="center" class="mt-1" id="serverResp"></div>
    </div>
</div>
<div align="center">
    <button onclick="return fnExcelReport2();" class="btn btn-info btn-sm m-1">DOWNLOAD EXCEL</button>
</div>
<div class="container border p-2 mt-2 shadow-lg">
    <div align="center" style="text-decoration: underline;color: fuchsia;">AVAILABLE INDUSTRY PARTNER DETAILS</div>
    <table class="table table-bordered" id="reporttable">
        <thead>
            <tr>
                <td style="background-color: black;color: white;">SNO</td>
                <td style="background-color: black;color: white;">DIST</td>
                <td style="background-color: black;color: white;">ITI</td>
                <td style="background-color: black;color: white;">REVISED LEAD SECTOR</td>
                <td style="background-color: black;color: white;">PROPOSED NEW TRADE</td>
                <td style="background-color: black;color: white;">REVISED LEAD INDUSTRY PARTNER</td>
                <td style="background-color: black;color: white;">ACTIONS</td>
            </tr>
        </thead>
        <tbody id="tabledata"></tbody>
    </table>
</div>
</body>
</html>
</div>