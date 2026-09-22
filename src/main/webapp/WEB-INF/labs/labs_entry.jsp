<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Labs Entry</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<script>
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';
</script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border:1px solid black;width:100%;border-radius:2px;">
<%@ include file="../navbars/portal_navbar.jsp" %>
<br>
<div class="container border p-3 mt-2 shadow-lg" style="border-radius:5px;background:#fff;">
<div align="center" style="text-decoration:underline;color:fuchsia;">LAB INFORMATION ENTRY FORM</div>
<div class="row mt-2">
<div class="col-md-6">
<label for="industryName">INDUSTRY NAME</label>
<input type="text" id="industryName" class="form-control" placeholder="Enter Industry Name"/>
</div>
<div class="col-md-6">
<label for="tradeShort">TRADE FOR LAB</label>
<select id="tradeShort" class="form-control"><option value="">-SELECT-</option></select>
</div>
</div>
<div class="row mt-2">
<div class="col-md-12">
<label for="description">DESCRIPTION</label>
<textarea id="description" class="form-control" rows="4"></textarea>
</div>
</div>
<div class="mt-3"><strong>EQUPMENT LIST PROVIDED BY THE INDUSTRY</strong></div>
<table class="table table-bordered mt-2">
<thead><tr><th>ITEM NAME</th><th>ITEM COST(in Lakhs)</th><th>ITEM PHOTO</th><th></th></tr></thead>
<tbody id="itemsBody">
<tr class="item-row">
<td><input type="text" class="form-control itemName" placeholder="Item Name"/></td>
<td><input type="text" class="form-control itemCost" placeholder="Item Cost"/></td>
<td><input type="file" class="form-control itemPhoto" accept="image/*"/></td>
<td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">Remove</button></td>
</tr>
</tbody>
</table>
<div class="text-end"><button type="button" class="btn btn-info" onclick="return addMoreRow();">Add More</button></div>
<div align="center" class="mt-2"><button class="btn btn-success" onclick="return submitLab();">Submit</button></div>
<div align="center" id="servermsg" class="mt-2"></div>
</div>
PLACEHOLDER_SCRIPT

<script src="${pageContext.request.contextPath}/js/labsEntryJs.js"></script>
<%@ include file="../footer.jsp" %>
</body>
</html>
