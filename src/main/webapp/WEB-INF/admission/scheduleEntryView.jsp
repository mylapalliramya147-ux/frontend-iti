<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Schedule Entry</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
  .page-title { text-align:center; font-family:Verdana,Arial,sans-serif; font-size:22px; margin:18px 0 12px; color:#000; }
  .sched-box { width:520px; margin:0 auto 60px; border:1px solid #7a7a7a; background:#fff; }
  .sched-box table { width:100%; border-collapse:collapse; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .sched-box td { border:1px solid #7a7a7a; padding:6px 8px; }
  .sched-box td.label { width:42%; background:#f2f2f2; font-weight:bold; }
  .sched-box select, .sched-box input[type=text] { width:96%; padding:4px; font-size:13px; }
  .sched-box .btn-row td { text-align:center; background:#fff; }
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
  <div class="page-title">Schedule Entry for Phase</div>
  <div class="sched-box">
    <table>
      <tr>
        <td class="label">Qualification :</td>
        <td><select id="qualSel"><option value="">-select-</option><option value="all">All</option><option value="8th">8th pass</option><option value="10th">10th</option><option value="inter">Intermediate</option></select><span class="err" id="qualError"></span></td>
      </tr>
      <tr>
        <td class="label">Reservation :</td>
        <td><select id="casteSel"><option value="">-select-</option><option value="all">All</option><option value="OC">OC</option><option value="BC-A">BC-A</option><option value="BC-B">BC-B</option><option value="BC-C">BC-C</option><option value="BC-D">BC-D</option><option value="BC-E">BC-E</option><option value="SC">SC</option><option value="ST">ST</option><option value="EWS">EWS</option><option value="Minority">Minority</option></select><span class="err" id="casteError"></span></td>
      </tr>
      <tr>
        <td class="label">Present Phase :</td>
        <td><select id="phaseSel"><option value="">-select-</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option></select><span class="err" id="phaseError"></span></td>
      </tr>
      <tr>
        <td class="label">Year :</td>
        <td><input type="text" id="yearInp" value="2025" maxlength="4" /><span class="err" id="yearError"></span></td>
      </tr>
      <tr class="btn-row"><td colspan="2"><input type="button" id="goBtn" class="submit-btn" value="Submit" onclick="submitSchedule();" /><input type="button" class="reset-btn" value="Reset" onclick="resetSchedule();" /></td></tr>
    </table>
  </div>
</div>

<div id="screen2" class="res-wrap" style="display:none;">
  <div class="res-head">Schedule Entry Details</div>
  <div id="resultArea"></div>
  <div style="text-align:center;margin:10px 0 60px;"><input type="button" class="reset-btn" value="Reset" onclick="resetSchedule();" /></div>
</div>

<div id="footer">2013 @ All Rights Reserved&nbsp;&nbsp; Designed by&nbsp;&nbsp; National Informatics Center <a href="http://www.ap.nic.in">National Informatics Center</a>&nbsp;&nbsp;&nbsp;&nbsp; <a href="#">Disclaimer</a></div>
<script>
var CTX = '${pageContext.request.contextPath}';
function esc(s){ if(s===null||s===undefined) return ''; return String(s).replace(/[&<>"]/g, function(c){
  return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]; }); }
function setErr(id,m){ document.getElementById(id).innerHTML = m ? esc(m) : ''; }
function val(id){ return document.getElementById(id).value.trim(); }
function submitSchedule(){
  var q = val('qualSel'), c = val('casteSel'), p = val('phaseSel'), y = val('yearInp');
  setErr('qualError', q ? '' : 'Qualification is required.');
  setErr('casteError', c ? '' : 'Reservation is required.');
  setErr('phaseError', p ? '' : 'Present Phase is required.');
  var yErr = '';
  if(!y) yErr = 'Year is required.';
  else if(!/^\d{4}$/.test(y)) yErr = 'Enter a valid year (e.g. 2025).';
  setErr('yearError', yErr);
  if(!q || !c || !p || yErr) return;
  var btn = document.getElementById('goBtn');
  var area = document.getElementById('resultArea');
  btn.disabled = true; btn.value = 'Loading...';
  area.innerHTML = '<p>Loading schedule entries...</p>';
  document.getElementById('screen1').style.display = 'none';
  document.getElementById('screen2').style.display = 'block';
  var url = CTX + '/ScheduleEntryView/api/schedule-entry'
    + '?qualification=' + encodeURIComponent(q)
    + '&caste=' + encodeURIComponent(c)
    + '&phase=' + encodeURIComponent(p)
    + '&year=' + encodeURIComponent(y);
  fetch(url)
    .then(function(r){ return r.json().then(function(b){ return {s: r.status, b: b}; }); })
    .then(function(x){ renderResult(x, q, c, p, y); })
    .catch(function(){ area.innerHTML = '<p style="color:red;">Backend unavailable. Please try again later.</p>'; })
    .finally(function(){ btn.disabled = false; btn.value = 'Submit'; });
}
function renderResult(x, q, c, p, y){
  var area = document.getElementById('resultArea');
  if(x.s >= 400){
    var em = (x.b && (x.b.error || x.b.message)) ? (x.b.error || x.b.message) : ('HTTP ' + x.s);
    area.innerHTML = '<p style="color:red;">Error: ' + esc(em) + '</p>';
    return;
  }
  var list = Array.isArray(x.b) ? x.b : (x.b && Array.isArray(x.b.data) ? x.b.data : []);
  if(!list || list.length===0){
    area.innerHTML = '<p style="color:red;">No schedule entries found for Qualification=' + esc(q)
      + ', Reservation=' + esc(c) + ', Phase=' + esc(p) + ', Year=' + esc(y) + '.</p>';
    return;
  }
  var h = '<table class="res-table"><tr><th>#</th><th>ITI Code</th><th>Qualification</th>'
    + '<th>Merit From</th><th>Merit To</th><th>Calendar Date</th><th>Calendar Time</th>'
    + '<th>District Code</th><th>Caste / Reservation</th><th>Transaction Number</th>'
    + '<th>Temp PK</th><th>Phase</th><th>Year</th></tr>';
  list.forEach(function(r, i){
    h += '<tr><td>' + (i+1) + '</td>'
      + '<td>' + esc(r.itiCode) + '</td>'
      + '<td>' + esc(r.minqul) + '</td>'
      + '<td>' + esc(r.meritFrom) + '</td>'
      + '<td>' + esc(r.meritTo) + '</td>'
      + '<td>' + esc(r.calDate) + '</td>'
      + '<td>' + esc(r.calTime) + '</td>'
      + '<td>' + esc(r.distCode) + '</td>'
      + '<td>' + esc(r.caste) + '</td>'
      + '<td>' + esc(r.trno) + '</td>'
      + '<td>' + esc(r.tempPk) + '</td>'
      + '<td>' + esc(r.phase) + '</td>'
      + '<td>' + esc(r.year) + '</td></tr>';
  });
  h += '</table>';
  h += '<div class="meta">Source: GET /admission/schedule-entry</div>';
  area.innerHTML = h;
}
function resetSchedule(){
  document.getElementById('qualSel').value = '';
  document.getElementById('casteSel').value = '';
  document.getElementById('phaseSel').value = '';
  document.getElementById('yearInp').value = '2025';
  setErr('qualError',''); setErr('casteError',''); setErr('phaseError',''); setErr('yearError','');
  document.getElementById('resultArea').innerHTML = '';
  document.getElementById('screen2').style.display = 'none';
  document.getElementById('screen1').style.display = 'block';
}
</script>
</body>
</html>
