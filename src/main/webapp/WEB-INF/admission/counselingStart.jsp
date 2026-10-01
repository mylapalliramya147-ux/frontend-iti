<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Start Admission Process</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
  .page-title { text-align:center; font-family:Verdana,Arial,sans-serif; font-size:22px; margin:18px 0 12px; color:#000; }
  .counsel-box { width:520px; margin:0 auto 60px; border:1px solid #7a7a7a; background:#fff; }
  .counsel-box table { width:100%; border-collapse:collapse; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .counsel-box td { border:1px solid #7a7a7a; padding:6px 8px; }
  .counsel-box td.label { width:42%; background:#f2f2f2; font-weight:bold; }
  .counsel-box select, .counsel-box input[type=text] { width:96%; padding:4px; font-size:13px; }
  .counsel-box .btn-row td { text-align:center; background:#fff; }
  .submit-btn { background-color:#4CAF50; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; }
  .submit-btn:focus { background-color:orangered; }
  .err { color:red; font-size:12px; display:block; }
  #footer { position:fixed; bottom:0; width:100%; padding:8px; text-align:center; background:#0E4878; font-size:12px; color:#fff; font-family:arial,verdana; }
  #footer a { color:#fff; }
</style>
</head>
<body>
<br/>
<c:choose>
  <c:when test="${not empty sessionScope.roleId}"><%@ include file="/WEB-INF/reports/header.jsp" %></c:when>
  <c:otherwise><%@ include file="/WEB-INF/bannernew.jsp" %><%@ include file="/WEB-INF/navbars/openNavbar.jsp" %></c:otherwise>
</c:choose>

<div class="page-title">Start Admission Process Select all the following.</div>

<div class="counsel-box">
  <form id="startForm" action="${pageContext.request.contextPath}/AdmissionCounseling/Counseling" method="get" onsubmit="return validateStart();">
    <table>
      <tr>
        <td class="label">Caste :</td>
        <td><select name="caste" id="caste"><option value="">-select-</option><option value="all">All</option><option value="OC">OC</option><option value="BC-A">BC-A</option><option value="BC-B">BC-B</option><option value="BC-C">BC-C</option><option value="BC-D">BC-D</option><option value="BC-E">BC-E</option><option value="SC">SC</option><option value="ST">ST</option><option value="EWS">EWS</option><option value="Minority">Minority</option></select><span class="err" id="casteError"></span></td>
      </tr>
      <tr>
        <td class="label">Qualification :</td>
        <td><select name="qual" id="qual"><option value="">-select-</option><option value="all">All</option><option value="8th">8th pass</option><option value="10th">SSC pass</option><option value="inter">Intermediate</option></select><span class="err" id="qualError"></span></td>
      </tr>
      <tr>
        <td class="label">Admission Timings :</td>
        <td><select name="timing" id="timing"><option value="">-select-</option><option value="09:00-11:00">09:00 - 11:00</option><option value="11:00-13:00">11:00 - 13:00</option><option value="14:00-16:00">14:00 - 16:00</option><option value="16:00-18:00">16:00 - 18:00</option></select><span class="err" id="timingError"></span></td>
      </tr>
      <tr>
        <td class="label">Phase :</td>
        <td><select name="phase" id="phase"><option value="">-select-</option><option value="1" selected>1</option><option value="2">2</option><option value="3">3</option></select><span class="err" id="phaseError"></span></td>
      </tr>
      <tr>
        <td class="label">Year :</td>
        <td><input type="text" name="year" id="year" value="2025" maxlength="4" /><span class="err" id="yearError"></span></td>
      </tr>
      <tr class="btn-row"><td colspan="2"><input type="submit" class="submit-btn" value="Submit" /></td></tr>
    </table>
  </form>
</div>

<div id="footer">2013 @ All Rights Reserved&nbsp;&nbsp; Designed by&nbsp;&nbsp; National Informatics Center <a href="http://www.ap.nic.in">National Informatics Center</a>&nbsp;&nbsp;&nbsp;&nbsp; <a href="#">Disclaimer</a></div>

<script>
function validateStart(){
  var ok = true;
  [['caste','casteError'],['qual','qualError'],['timing','timingError'],['phase','phaseError'],['year','yearError']].forEach(function(p){
    var v = document.getElementById(p[0]).value;
    document.getElementById(p[1]).innerHTML = (!v) ? (p[0] + ' is required.') : '';
    if(!v) ok = false;
  });
  var y = document.getElementById('year').value;
  if(y && !/^\d{4}$/.test(y)){ document.getElementById('yearError').innerHTML = 'Enter a valid year (e.g. 2025).'; ok = false; }
  return ok;
}
</script>
</body>
</html>
