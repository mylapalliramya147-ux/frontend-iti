<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Labs ITI Report</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/xlsx.full.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<script>
// Server-rendered values (source of truth). Fallbacks let the page also work
// when opened directly with ?itiCode=XXXX for testing.
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';
(function(){
    function qp(n){ var m = new RegExp('[?&]' + n + '=([^&]*)').exec(location.search); return m ? decodeURIComponent(m[1]) : ''; }
    if(!insCode){ insCode = qp('itiCode') || ''; }
    if(!/\/$/.test(baseUrl || '')){ baseUrl = (baseUrl || '') + '/'; }
})();
</script>
<style>
#reporttable th{ position: sticky; top: 0px; background-color: black; color: white; }
.item-photo{ max-width: 90px; max-height: 70px; }
</style>
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border:1px solid black;width:100%;border-radius:2px;">
<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div align="center" style="text-decoration:underline;color:fuchsia;">AVAILABLE LABS INFORMATION</div>
<div class="container-fluid mt-2">
<button class="btn btn-info btn-sm" onclick="return downloadExcel(false);">DOWNLOAD EXCEL WITHOUT ITEM PHOTO</button>
<button class="btn btn-info btn-sm" onclick="return downloadExcel(true);">DOWNLOAD EXCEL WITH ITEM PHOTO</button>
<div id="emptydatamsg" class="text-center fw-bold mt-3" style="display:none;">No records found.</div>
<div id="reportmeta" class="text-muted small mt-2" style="display:none;"></div>
<table class="table table-bordered mt-2" id="reporttable" style="display:none;">
<thead id="reportthead"></thead>
<tbody id="reportbody"></tbody>
</table>
</div>
<script src="${pageContext.request.contextPath}/js/labsReportJs.js"></script>
</body>
</html>
