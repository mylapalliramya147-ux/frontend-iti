<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Admission Image Upload</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
  .page-title { text-align:center; font-family:Verdana,Arial,sans-serif; font-size:22px; margin:18px 0 12px; color:#000; }
  .call-box { width:520px; max-width:94%; margin:0 auto 20px; border:1px solid #7a7a7a; background:#fff; }
  .call-box table { width:100%; border-collapse:collapse; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .call-box td { border:1px solid #7a7a7a; padding:6px 8px; }
  .call-box td.label { width:42%; background:#f2f2f2; font-weight:bold; }
  .call-box input[type=text] { width:96%; padding:4px; font-size:13px; }
  .call-box .btn-row td { text-align:center; background:#fff; }
  .submit-btn { background-color:#4CAF50; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; }
  .submit-btn:disabled { opacity:.55; cursor:default; }
  .reset-btn { background-color:#c0392b; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; margin-left:8px; }
  .err { color:red; font-size:12px; display:block; }
  .res-wrap { width:92%; margin:0 auto 60px; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .res-head { text-align:center; color:blue; font-size:18px; font-weight:bold; margin:14px 0 8px; }
  .slip-table { border-collapse:collapse; margin:0 auto; font-size:13px; background:#fff; width:100%; max-width:760px; }
  .slip-table th, .slip-table td { border:1px solid #7a7a7a; padding:6px 10px; text-align:left; vertical-align:top; }
  .slip-table th { background:#e4eeb9; width:44%; }
  .msg-err { color:red; text-align:center; }
  .loading { text-align:center; }
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
<div class="page-title">Admission Image Upload</div>
<div class="call-box">
<table>
<tr><td class="label">Admission Number :</td><td><input type="text" id="admissionNumber" maxlength="30" placeholder="Enter Admission Number" /><span class="err" id="admissionNumberError"></span></td></tr>
<tr><td class="label">SSC Hallticket Number :</td><td><input type="text" id="sscHallticketNumber" maxlength="30" placeholder="Enter SSC Hallticket Number" /><span class="err" id="sscHallticketNumberError"></span></td></tr>
<tr class="btn-row"><td colspan="2"><input type="button" class="submit-btn" id="goBtn" value="Proceed" onclick="verifyAdmissionImageUpload();" /><input type="button" class="reset-btn" id="resetBtn" value="Reset" onclick="resetAdmissionImageUpload();" /></td></tr>
</table>
</div>
<div class="res-wrap"><div id="resultArea"></div></div>
<div id="footer">2013 @ All Rights Reserved</div>
<script>
var CTX = '${pageContext.request.contextPath}';
function esc(v){ if(v===null||v===undefined) return ""; return String(v).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"); }
function val(id){ return document.getElementById(id).value.trim(); }
function setErr(id,msg){ document.getElementById(id).innerHTML = msg ? esc(msg) : ""; }
function txt(v){ if(v===null||v===undefined) return "N/A"; var s=String(v).trim(); return s==="" ? "N/A" : s; }
function pick(o){ if(!o) return null; if(o.data && typeof o.data==="object") return o.data; return o; }
function row(n,v){ return "<tr><th>"+n+"</th><td>"+esc(v||"")+"</td></tr>"; }
function verifyAdmissionImageUpload(){
  var a = val("admissionNumber"); var s = val("sscHallticketNumber");
  if(!a && !s){ setErr("admissionNumberError",""); setErr("sscHallticketNumberError",""); document.getElementById("resultArea").innerHTML = '<p class="msg-err">Please enter Admission Number and SSC Hallticket Number.</p>'; return; }
  setErr("admissionNumberError", a ? "" : "Please enter Admission Number.");
  setErr("sscHallticketNumberError", s ? "" : "Please enter SSC Hallticket Number.");
  if(!a || !s) return;
  var btn = document.getElementById("goBtn"); var area = document.getElementById("resultArea");
  btn.disabled = true; btn.value = "Loading...";
  area.innerHTML = '<p class="loading">Loading admission details...</p>';
  var url = CTX + "/admissions/admission-image-upload/api/admission-image-upload?admissionNumber=" + encodeURIComponent(a) + "&sscHallticketNumber=" + encodeURIComponent(s);
  fetch(url).then(function(r){ return r.json().then(function(b){ return {s: r.status, b: b}; }); }).then(function(x){ renderImgUp(x, a, s); }).catch(function(){ document.getElementById("resultArea").innerHTML = '<p class="msg-err">Unable to connect to the server. Please make sure the backend is running.</p>'; }).finally(function(){ btn.disabled = false; btn.value = "Proceed"; });
}
function renderImgUp(x, a, s){
  var area = document.getElementById("resultArea");
  if(x.s === 400){ area.innerHTML = '<p class="msg-err">Please enter valid admission details.</p>'; return; }
  if(x.s === 404){ area.innerHTML = '<p class="msg-err">Admission Number and SSC Hallticket Number do not match.</p>'; return; }
  if(x.s === 500){ area.innerHTML = '<p class="msg-err">Unable to verify admission details. Please try again.</p>'; return; }
  if(x.s >= 400){ var em = (x.b && (x.b.error || x.b.message)) ? (x.b.error || x.b.message) : ("HTTP " + x.s); area.innerHTML = '<p class="msg-err">' + esc(em) + '</p>'; return; }
  var d = pick(x.b);
  if(!d || (!d.admissionNumber && !d.registrationId && !d.name)){ area.innerHTML = '<p class="msg-err">Admission Number and SSC Hallticket Number do not match.</p>'; return; }
  var h = "<div class='res-head'>Admission Details</div><table class='slip-table'>";
  h += row("Admission Number", txt(d.admissionNumber || a));
  h += row("SSC Hallticket Number", txt(d.sscHallticketNumber || s));
  h += row("Registration Id", txt(d.registrationId));
  h += row("Name", txt(d.name));
  h += "</table>"; area.innerHTML = h;
}
function resetAdmissionImageUpload(){ document.getElementById("admissionNumber").value = ""; document.getElementById("sscHallticketNumber").value = ""; setErr("admissionNumberError",""); setErr("sscHallticketNumberError",""); document.getElementById("resultArea").innerHTML = ""; }
</script>
</body>
</html>
