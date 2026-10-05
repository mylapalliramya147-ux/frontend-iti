<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Application Reprint</title>
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
  .print-btn { background-color:#0E4878; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; margin-left:8px; }
  .err { color:red; font-size:12px; display:block; }
  .res-wrap { width:92%; margin:0 auto 60px; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .res-head { text-align:center; color:blue; font-size:18px; font-weight:bold; margin:14px 0 8px; }
  .reg-strip { text-align:center; font-size:14px; font-weight:bold; margin:6px 0 12px; }
  .sec-title { background:#e4eeb9; border:1px solid #7a7a7a; border-bottom:none; font-weight:bold; padding:6px 10px; font-size:13px; }
  .slip-table { border-collapse:collapse; margin:0 auto 14px; font-size:13px; background:#fff; width:100%; max-width:760px; }
  .slip-table th, .slip-table td { border:1px solid #7a7a7a; padding:6px 10px; text-align:left; vertical-align:top; }
  .slip-table th { background:#e4eeb9; width:44%; }
  .act-row { text-align:center; margin:12px 0; }
  .msg-err { color:red; text-align:center; }
  .note-box { width:92%; max-width:760px; margin:12px auto; font-size:12px; color:#333; background:#fef9e7; border:1px solid #d4ac0d; padding:8px 10px; }
  @media print {
    #screen1, #footer, .act-row, .no-print { display:none !important; }
    #screen2 { display:block !important; }
    .res-wrap { width:100%; margin:0; }
  }
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
  <div class="page-title">Application Reprint</div>
  <div class="call-box">
    <table>
      <tr>
        <td class="label">Registration Id :</td>
        <td><input type="text" id="registrationId" placeholder="Enter Registration Id" /><span class="err" id="registrationIdError"></span></td>
      </tr>
      <tr class="btn-row"><td colspan="2"><input type="button" class="submit-btn" id="goBtn" value="Submit" onclick="getVerifiedApplication();" /></td></tr>
    </table>
  </div>
</div>
<div id="screen2" style="display:none;">
  <div class="res-head">Application Reprint</div>
  <div class="res-wrap"><div id="resultArea"></div>
  <div class="act-row no-print">
    <input type="button" class="print-btn" id="printBtn" value="Print Application" onclick="window.print();" style="display:none;" />
    <input type="button" class="reset-btn" value="Search Another" onclick="backToSearch();" />
  </div></div>
</div>
<div id="footer">2013 @ All Rights Reserved&nbsp;&nbsp; Designed by&nbsp;&nbsp; National Informatics Center <a href="http://www.ap.nic.in">National Informatics Center</a>&nbsp;&nbsp;&nbsp;&nbsp; <a href="#">Disclaimer</a></div>
<script>
var CTX = '${pageContext.request.contextPath}';
function esc(v){ if(v===null||v===undefined) return ""; return String(v).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"); }
function val(id){ return document.getElementById(id).value.trim(); }
function setErr(id,msg){ document.getElementById(id).innerHTML = msg ? esc(msg) : ""; }
function txt(v){ if(v===null||v===undefined) return "N/A"; var s=String(v).trim(); return s==="" ? "N/A" : s; }
function fmtDate(v){ if(!v) return "N/A"; try { var d=new Date(v); if(isNaN(d.getTime())) return String(v); var dd=("0"+d.getDate()).slice(-2),mm=("0"+(d.getMonth()+1)).slice(-2); return dd+"/"+mm+"/"+d.getFullYear(); } catch(e){ return String(v); } }
function fmtDateTime(v){ if(!v) return "N/A"; try { var d=new Date(String(v).replace(" ","T")); if(isNaN(d.getTime())) d=new Date(v); if(isNaN(d.getTime())) return String(v); var dd=("0"+d.getDate()).slice(-2),mm=("0"+(d.getMonth()+1)).slice(-2); return dd+"/"+mm+"/"+d.getFullYear(); } catch(e){ return String(v); } }
function pick(o){ if(!o) return null; if(o.data && typeof o.data==="object" && !Array.isArray(o.data)) return o.data; return o; }
function row(n,v){ return "<tr><th>"+n+"</th><td>"+esc(v||"")+"</td></tr>"; }
function yn(v){ if(v===true||v==="true"||v==="Y"||v==="y"||v==="Yes"||v==="YES"||v===1||v==="1") return "Yes"; if(v===false||v==="false"||v==="N"||v==="n"||v==="No"||v==="NO"||v===0||v==="0") return "No"; return "N/A"; }
function getVerifiedApplication(){
  var r = val("registrationId");
  if(!r){ setErr("registrationIdError", "Please enter Registration Id."); return; }
  if(!/^\d+$/.test(r)){ setErr("registrationIdError", "Please enter a valid Registration Id."); return; }
  setErr("registrationIdError", "");
  var btn = document.getElementById("goBtn");
  var area = document.getElementById("resultArea");
  btn.disabled = true; btn.value = "Loading...";
  area.innerHTML = "<p>Loading verified application details...</p>";
  document.getElementById("printBtn").style.display = "none";
  document.getElementById("screen1").style.display = "none";
  document.getElementById("screen2").style.display = "block";
  var url = CTX + "/admissions/reprint-verified-application/api/reprint-verified-application?registrationId=" + encodeURIComponent(r);
  fetch(url)
    .then(function(resp){ return resp.json().then(function(b){ return {s: resp.status, b: b}; }); })
    .then(function(x){ renderVerifiedResult(x, r); })
    .catch(function(){ document.getElementById("resultArea").innerHTML = '<p class="msg-err">Unable to connect to the server. Please make sure the backend is running.</p>'; })
    .finally(function(){ btn.disabled = false; btn.value = "Submit"; });
}
function renderVerifiedResult(x, r){
  var area = document.getElementById("resultArea");
  if(x.s === 400){ area.innerHTML = '<p class="msg-err">Please enter a valid Registration Id.</p>'; return; }
  if(x.s === 404){ area.innerHTML = '<p class="msg-err">Verified application not found.</p>'; return; }
  if(x.s >= 400){
    var em = (x.b && (x.b.error || x.b.message)) ? (x.b.error || x.b.message) : ("HTTP " + x.s);
    if(x.s === 502 && !em) em = "Unable to retrieve the verified application. Please try again.";
    area.innerHTML = '<p class="msg-err">' + esc(em) + '</p>';
    return;
  }
  var d = pick(x.b);
  if(!d || (d.regid===null && d.regid===undefined)){ area.innerHTML = '<p class="msg-err">Verified application not found.</p>'; return; }
  var regNo = d.regid || r;
  var st = (d.appStatus===null||d.appStatus===undefined||String(d.appStatus).trim()==="") ? "N/A" : String(d.appStatus).trim().toUpperCase();
  if(st==="A") st="APPROVED"; else if(st==="R") st="REJECTED"; else if(st==="N") st="NEW";
  var h = "<div class='reg-strip'>Registration Id: " + esc(regNo) + "</div>";
  h += "<div class='sec-title'>Qualification Details</div><table class='slip-table'>";
  h += row("Hall Ticket", txt(d.sscRegNo)) + row("Board", txt(d.sscBoard)) + row("Year of Pass", txt(d.sscYear));
  h += row("Verified Date", fmtDateTime(d.verifiedDate)) + row("Verified By", txt(d.userId));
  h += "</table>";
  h += "<div class='sec-title'>Personal Details</div><table class='slip-table'>";
  h += row("Name", txt(d.name)) + row("Father Name", txt(d.fname)) + row("Mother Name", txt(d.mname));
  h += row("D.O.B", fmtDate(d.dob)) + row("Gender", txt(d.gender)) + row("Address", txt(d.addr));
  h += row("Phone No", txt(d.phno)) + row("Aadhaar", txt(d.adarno));
  h += "</table>";
  h += "<div class='sec-title'>Reservation Details</div><table class='slip-table'>";
  h += row("Caste", txt(d.caste)) + row("Sub Caste", txt(d.subCaste)) + row("Local", txt(d.local));
  h += row("EWS", yn(d.economicWeakerSection)) + row("PHC", yn(d.phc)) + row("Ex-Service", yn(d.exservice));
  h += row("Application Status", st) + row("Phase", txt(d.phase)) + row("Transaction Number", txt(d.trno));
  h += "</table>";
  h += "<div class='note-box'>Reprint of the verified application as stored in the system. Verification acknowledgment does not guarantee admission; seat allocation is subject to merit, reservation and vacancy.</div>";
  area.innerHTML = h;
  document.getElementById("printBtn").style.display = "";
}
function backToSearch(){
  document.getElementById("registrationId").value = "";
  setErr("registrationIdError","");
  document.getElementById("resultArea").innerHTML = "";
  document.getElementById("printBtn").style.display = "none";
  document.getElementById("screen2").style.display = "none";
  document.getElementById("screen1").style.display = "block";
}
document.getElementById("registrationId").addEventListener("keydown", function(e){ if(e.key === "Enter"){ e.preventDefault(); getVerifiedApplication(); } });
</script>
</body>
</html>
