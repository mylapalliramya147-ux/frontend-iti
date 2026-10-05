<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Call Letter</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
  .page-title { text-align:center; font-family:Verdana,Arial,sans-serif; font-size:22px; margin:18px 0 12px; color:#000; }
  .call-box { width:520px; margin:0 auto 60px; border:1px solid #7a7a7a; background:#fff; }
  .call-box table { width:100%; border-collapse:collapse; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .call-box td { border:1px solid #7a7a7a; padding:6px 8px; }
  .call-box td.label { width:42%; background:#f2f2f2; font-weight:bold; }
  .call-box select, .call-box input[type=text] { width:96%; padding:4px; font-size:13px; }
  .call-box .btn-row td { text-align:center; background:#fff; }
  .submit-btn { background-color:#4CAF50; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; }
  .submit-btn:disabled { opacity:.55; cursor:default; }
  .reset-btn { background-color:#c0392b; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; margin-left:8px; }
  .err { color:red; font-size:12px; display:block; }
  .res-wrap { width:92%; margin:0 auto 60px; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .res-head { text-align:center; color:blue; font-size:18px; font-weight:bold; margin:14px 0 8px; }
  .res-table { border-collapse:collapse; margin:0 auto; font-size:12px; background:#fff; width:100%; }
  .res-table th, .res-table td { border:1px solid #7a7a7a; padding:5px 8px; }
  .res-table th { background:#e4eeb9; }
  .meta { text-align:center; font-size:11px; color:#666; margin-top:8px; }
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
  <div class="page-title">CALL LETTER GENERATION</div>
  <div class="call-box">
    <table>
      <tr>
        <td class="label">From Rank :</td>
        <td><input type="text" id="fromRank" maxlength="6" /><span class="err" id="fromRankError"></span></td>
      </tr>
      <tr>
        <td class="label">To Rank :</td>
        <td><input type="text" id="toRank" maxlength="6" /><span class="err" id="toRankError"></span></td>
      </tr>
      <tr>
        <td class="label">Caste :</td>
        <td><select id="casteSel"><option value="">-select-</option><option value="OC">OC</option><option value="BC-A">BC-A</option><option value="BC-B">BC-B</option><option value="BC-C">BC-C</option><option value="BC-D">BC-D</option><option value="BC-E">BC-E</option><option value="SC">SC</option><option value="ST">ST</option><option value="EWS">EWS</option><option value="Minority">Minority</option></select><span class="err" id="casteError"></span></td>
      </tr>
      <tr class="btn-row"><td colspan="2"><input type="button" class="submit-btn" id="goBtn" value="Submit" onclick="getCallLetter();" /><input type="button" class="reset-btn" value="Reset" onclick="resetCallLetter();" /></td></tr>
    </table>
  </div>
</div>
<div id="screen2" style="display:none;">
  <div class="res-head">Call Letter Details</div>
  <div class="res-wrap"><div id="resultArea"></div>
  <div style="text-align:center;margin-top:10px;"><input type="button" class="reset-btn" value="Reset" onclick="resetCallLetter();" /></div></div>
</div>
<div id="footer">2013 @ All Rights Reserved&nbsp;&nbsp;Designed by&nbsp;&nbsp;National Informatics Center</div>
<script>
var CTX = "${pageContext.request.contextPath}";
function esc(v){ if(v===null||v===undefined) return ""; return String(v).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"); }
function val(id){ return document.getElementById(id).value.trim(); }
function setErr(id,msg){ document.getElementById(id).innerHTML = msg ? esc(msg) : ""; }
function getCallLetter(){
  var f = val("fromRank"), t = val("toRank"), c = val("casteSel");
  var fErr = "", tErr = "";
  if(!f) fErr = "From Rank is required.";
  else if(!/^\d+$/.test(f)) fErr = "From Rank must be a valid numeric rank.";
  if(!t) tErr = "To Rank is required.";
  else if(!/^\d+$/.test(t)) tErr = "To Rank must be a valid numeric rank.";
  if(fErr === "" && tErr === "" && parseInt(f,10) > parseInt(t,10)) tErr = "From Rank must not be greater than To Rank.";
  setErr("fromRankError", fErr);
  setErr("toRankError", tErr);
  setErr("casteError", c ? "" : "Caste is required.");
  if(fErr || tErr || !c) return;
  var btn = document.getElementById("goBtn");
  var area = document.getElementById("resultArea");
  btn.disabled = true; btn.value = "Loading...";
  area.innerHTML = "<p>Loading call letter records...</p>";
  document.getElementById("screen1").style.display = "none";
  document.getElementById("screen2").style.display = "block";
  var url = CTX + "/CallLetterView/api/call-letter?fromRank=" + encodeURIComponent(f) + "&toRank=" + encodeURIComponent(t) + "&caste=" + encodeURIComponent(c);
  fetch(url)
    .then(function(r){ return r.json().then(function(b){ return {s: r.status, b: b}; }); })
    .then(function(x){ renderResult(x, f, t, c); })
    .catch(function(){ area.innerHTML = '<p style="color:red;">Backend unavailable. Please try again later.</p>'; })
    .finally(function(){ btn.disabled = false; btn.value = "Submit"; });
}
function renderResult(x, f, t, c){
  var area = document.getElementById("resultArea");
  if(x.s >= 400){
    var em = (x.b && (x.b.error || x.b.message)) ? (x.b.error || x.b.message) : ("HTTP " + x.s);
    area.innerHTML = '<p style="color:red;">Error: ' + esc(em) + '</p>';
    return;
  }
  var list = Array.isArray(x.b) ? x.b : (x.b && Array.isArray(x.b.data) ? x.b.data : []);
  if(!list || list.length===0){
    area.innerHTML = '<p style="color:red;">No call letter records found for the selected rank range and caste (From Rank=' + esc(f) + ', To Rank=' + esc(t) + ', Caste=' + esc(c) + ').</p>';
    return;
  }
  var h = "<table class='res-table'><tr><th>#</th><th>Rank</th><th>Caste</th><th>Registration ID</th><th>Candidate Name</th><th>ITI Code</th><th>Qualification</th><th>Phase</th><th>Year</th><th>Transaction Number</th><th>Temp PK</th></tr>";
  list.forEach(function(r, i){
    h += "<tr><td>" + (i+1) + "</td><td>" + esc(r.rank) + "</td><td>" + esc(r.caste) + "</td><td>" + esc(r.regid) + "</td><td>" + esc(r.name) + "</td><td>" + esc(r.itiCode) + "</td><td>" + esc(r.qualification) + "</td><td>" + esc(r.phase) + "</td><td>" + esc(r.year) + "</td><td>" + esc(r.trno) + "</td><td>" + esc(r.tempPk) + "</td></tr>";
  });
  h += "</table><div class='meta'>Source: GET /admission/call-letter rank + caste (one call per rank, merged)</div>";
  area.innerHTML = h;
}
function resetCallLetter(){
  document.getElementById("fromRank").value = "";
  document.getElementById("toRank").value = "";
  document.getElementById("casteSel").value = "";
  setErr("fromRankError",""); setErr("toRankError",""); setErr("casteError","");
  document.getElementById("resultArea").innerHTML = "";
  document.getElementById("screen2").style.display = "none";
  document.getElementById("screen1").style.display = "block";
}
</script>
</body>
</html>
