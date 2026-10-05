<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Admission Update</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
  .page-title { text-align:center; font-family:Verdana,Arial,sans-serif; font-size:22px; margin:18px 0 12px; color:#000; }
  .call-box { width:520px; max-width:94%; margin:0 auto 60px; border:1px solid #7a7a7a; background:#fff; }
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
  .act-row { text-align:center; margin:12px 0; }
  .msg-err { color:red; text-align:center; }
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
<div id="screen1">
  <div class="page-title">Admission Update</div>
  <div class="call-box">
    <table>
      <tr>
        <td class="label">Admission Number :</td>
        <td><input type="text" id="admissionNumber" maxlength="30" placeholder="Enter Admission Number" /><span class="err" id="admissionNumberError"></span></td>
      </tr>
      <tr class="btn-row"><td colspan="2"><input type="button" class="submit-btn" id="goBtn" value="Submit" onclick="getAdmissionUpdate();" /></td></tr>
    </table>
  </div>
</div>
<div id="screen2" style="display:none;">
  <div class="res-head">Admission Update Details</div>
  <div class="res-wrap"><div id="resultArea"></div>
  <div class="act-row no-print"><input type="button" class="reset-btn" value="Back" onclick="backToSearch();" /></div></div>
</div>
<div id="footer">2013 @ All Rights Reserved&nbsp;&nbsp; Designed by&nbsp;&nbsp; National Informatics Center <a href="http://www.ap.nic.in">National Informatics Center</a>&nbsp;&nbsp;&nbsp;&nbsp; <a href="#">Disclaimer</a></div>

<script>
var CTX = '${pageContext.request.contextPath}';
function esc(v){ if(v===null||v===undefined) return ""; return String(v).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"); }
function val(id){ return document.getElementById(id).value.trim(); }
function setErr(id,msg){ document.getElementById(id).innerHTML = msg ? esc(msg) : ""; }
function txt(v){ if(v===null||v===undefined) return "N/A"; var s=String(v).trim(); return s==="" ? "N/A" : s; }
function pick(o){ if(!o) return null; if(o.data && typeof o.data==="object" && !Array.isArray(o.data)) return o.data; return o; }
function row(n,v){ return "<tr><th>"+n+"</th><td>"+esc(v||"")+"</td></tr>"; }
function fmtDate(v){ if(!v) return "N/A"; try { var d=new Date(v); if(isNaN(d.getTime())) return String(v); var dd=("0"+d.getDate()).slice(-2),mm=("0"+(d.getMonth()+1)).slice(-2); return dd+"/"+mm+"/"+d.getFullYear(); } catch(e){ return String(v); } }
function getAdmissionUpdate(){
  var a = val("admissionNumber");
  setErr("admissionNumberError", a ? "" : "Please enter Admission Number.");
  if(!a) return;
  var btn = document.getElementById("goBtn");
  var area = document.getElementById("resultArea");
  btn.disabled = true; btn.value = "Loading...";
  area.innerHTML = "<p>Loading admission details...</p>";
  document.getElementById("screen1").style.display = "none";
  document.getElementById("screen2").style.display = "block";
  var url = CTX + "/admissions/admission-update/api/admission-update?admissionNumber=" + encodeURIComponent(a);
  fetch(url)
    .then(function(r){ return r.json().then(function(b){ return {s: r.status, b: b}; }); })
    .then(function(x){ renderAdmissionUpdate(x, a); })
    .catch(function(){ document.getElementById("resultArea").innerHTML = '<p class="msg-err">Unable to connect to the server. Please make sure the backend is running.</p>'; })
    .finally(function(){ btn.disabled = false; btn.value = "Submit"; });
}
function renderAdmissionUpdate(x, a){
  var area = document.getElementById("resultArea");
  if(x.s === 400){ area.innerHTML = '<p class="msg-err">Please enter a valid Admission Number.</p>'; return; }
  if(x.s === 404){ area.innerHTML = '<p class="msg-err">Admission number not found.</p>'; return; }
  if(x.s >= 400){
    var em = (x.b && (x.b.error || x.b.message)) ? (x.b.error || x.b.message) : ("HTTP " + x.s);
    if(x.s === 502 && !em) em = "Unable to retrieve admission details. Please try again.";
    area.innerHTML = '<p class="msg-err">' + esc(em) + '</p>';
    return;
  }
  var d = pick(x.b);
  if(!d || (!d.admissionNumber && !d.admNum)){ area.innerHTML = '<p class="msg-err">Admission number not found.</p>'; return; }
  var h = "<table class='slip-table'>";
  h += row("Admission Number", txt(d.admissionNumber || d.admNum || a));
  h += row("Registration Id", txt(d.registrationId || d.regid));
  h += row("Name", txt(d.name));
  h += row("Father's Name", txt(d.fatherName));
  h += row("Mother's Name", txt(d.motherName));
  h += row("ITI Code", txt(d.itiCode));
  h += row("Trade Code", txt(d.tradeCode));
  h += row("Caste", txt(d.caste));
  h += row("Reservation Category", txt(d.reservationCategory));
  h += row("Year of Admission", txt(d.yearOfAdmission));
  h += row("District Code", txt(d.districtCode));
  h += row("Date of Birth", fmtDate(d.dateOfBirth));
  h += row("Date of Admission", fmtDate(d.dateOfAdmission));
  h += row("Phase", txt(d.phase));
  h += "</table>";
  area.innerHTML = h;
}
function backToSearch(){
  document.getElementById("admissionNumber").value = "";
  setErr("admissionNumberError","");
  document.getElementById("resultArea").innerHTML = "";
  document.getElementById("screen2").style.display = "none";
  document.getElementById("screen1").style.display = "block";
}
document.getElementById("admissionNumber").addEventListener("keydown", function(e){ if(e.key === "Enter"){ e.preventDefault(); getAdmissionUpdate(); } });
</script>
</body>
</html>
