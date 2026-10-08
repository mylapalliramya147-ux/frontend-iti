<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: DSC List</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
  .page-title { text-align:center; font-family:Verdana,Arial,sans-serif; font-size:22px; margin:18px 0 12px; color:#000; }
  .dsc-box { width:560px; max-width:94%; margin:0 auto 60px; border:1px solid #7a7a7a; background:#fff; }
  .dsc-box table { width:100%; border-collapse:collapse; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .dsc-box td { border:1px solid #7a7a7a; padding:6px 8px; }
  .dsc-box td.label { width:44%; background:#f2f2f2; font-weight:bold; }
  .dsc-box select { width:96%; padding:4px; font-size:13px; }
  .dsc-box .btn-row td { text-align:center; background:#fff; }
  .submit-btn { background-color:#4CAF50; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; }
  .submit-btn:disabled { opacity:.55; cursor:default; }
  .reset-btn { background-color:#c0392b; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; margin-left:8px; }
  .err { color:red; font-size:12px; display:block; }
  .res-wrap { width:94%; margin:0 auto 60px; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .res-head { text-align:center; color:blue; font-size:18px; font-weight:bold; margin:14px 0 8px; }
  .res-sub { text-align:center; font-size:13px; font-weight:bold; margin:0 0 10px; }
  .res-sub span { color:blue; }
  .res-table { border-collapse:collapse; margin:0 auto; font-size:12px; background:#fff; width:100%; }
  .res-table th, .res-table td { border:1px solid #7a7a7a; padding:5px 8px; }
  .res-table th { background:#e4eeb9; }
  .meta { text-align:center; font-size:11px; color:#666; margin-top:8px; }
  .act-row { text-align:center; margin:12px 0; }
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
  <div class="page-title">DSC List</div>
  <div class="dsc-box">
    <table>
      <tr>
        <td class="label">ITI Name :</td>
        <td><select id="itiSel"><option value="">--select--</option></select><span class="err" id="itiError"></span></td>
      </tr>
      <tr>
        <td class="label">Trade :</td>
        <td><select id="tradeSel"><option value="">--select--</option></select><span class="err" id="tradeError"></span></td>
      </tr>
      <tr>
        <td class="label">Phase :</td>
        <td><select id="phaseSel"><option value="">--select--</option></select><span class="err" id="phaseError"></span></td>
      </tr>
      <tr>
        <td class="label">Year :</td>
        <td><select id="yearSel"><option value="">--select--</option></select><span class="err" id="yearError"></span></td>
      </tr>
      <tr>
        <td class="label">Admission Performed in Level :</td>
        <td><select id="levelSel"><option value="">--select--</option><option value="DIST">DIST</option></select><span class="err" id="levelError"></span></td>
      </tr>
      <tr class="btn-row"><td colspan="2"><input type="button" class="submit-btn" id="goBtn" value="SUBMIT" onclick="getDscList();" /><input type="button" class="reset-btn" value="RESET" onclick="resetDscList();" /></td></tr>
    </table>
  </div>
</div>
<div id="screen2" style="display:none;">
  <div class="res-head">Admissions Selection List</div>
  <div class="res-sub" id="reportMeta"></div>
  <div class="res-wrap"><div id="resultArea"></div>
  <div class="act-row no-print"><input type="button" class="reset-btn" value="Back" onclick="backToSelection();" /> <input type="button" class="submit-btn" value="Print" onclick="window.print();" /></div></div>
</div>
<div id="footer">2013 @ All Rights Reserved&nbsp;&nbsp; Designed by&nbsp;&nbsp; National Informatics Center <a href="http://www.ap.nic.in">National Informatics Center</a>&nbsp;&nbsp;&nbsp;&nbsp; <a href="#">Disclaimer</a></div>
<script>
var CTX = '${pageContext.request.contextPath}';
var SESSION_INS_CODE = '<c:out value="${sessionScope.insCode}" />';
var SESSION_ITI_NAME = '<c:out value="${sessionScope.itiName}" />';
</script>
<script>
function esc(v){ if(v===null||v===undefined) return ""; return String(v).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"); }
function opt(v,t){ return '<option value="'+esc(v)+'">'+esc(t)+'</option>'; }
function val(id){ return document.getElementById(id).value.trim(); }
function setErr(id,msg){ document.getElementById(id).innerHTML = msg ? esc(msg) : ""; }
function setSel(id,opts,keep){ var s=document.getElementById(id); var cur=keep?s.value:""; var h=opt('','--select--'); opts.forEach(function(o){ h+=opt(o.v,o.t); }); s.innerHTML=h; if(keep&&cur){ s.value=cur; } }
function setLoading(id,msg){ document.getElementById(id).innerHTML='<option value="">'+esc(msg)+'</option>'; }
function optList(rows, codeKeys, nameKeys){
  var out = [];
  (rows || []).forEach(function(r){
    if (r === null || r === undefined) return;
    if (typeof r === 'string') { out.push({ v: r, t: r }); return; }
    var code = null, name = null, i, j;
    for (i = 0; i < codeKeys.length; i++) {
      if (r[codeKeys[i]] !== null && r[codeKeys[i]] !== undefined && String(r[codeKeys[i]]) !== '') { code = String(r[codeKeys[i]]); break; }
    }
    for (j = 0; j < nameKeys.length; j++) {
      if (r[nameKeys[j]] !== null && r[nameKeys[j]] !== undefined && String(r[nameKeys[j]]) !== '') { name = String(r[nameKeys[j]]); break; }
    }
    if (code === null || code === '') return;
    out.push({ v: code, t: name !== null ? (code + ' - ' + name) : code });
  });
  return out;
}
function unwrapList(b){
  if (Array.isArray(b)) return b;
  if (b && Array.isArray(b.data)) return b.data;
  if (b && Array.isArray(b.content)) return b.content;
  return [];
}
</script>
<script>
function loadDropdowns(){
  setLoading('itiSel', 'Loading ITIs...');
  setLoading('tradeSel', 'Loading trades...');
  setLoading('phaseSel', 'Loading phases...');
  setLoading('yearSel', 'Loading years...');
  fetch(CTX + '/admissions/dsc-list/api/dsc-options')
    .then(function(r){ return r.json().then(function(b){ return { s: r.status, b: b }; }); })
    .then(function(x){
      var body = x.b || {};
      var itiRows = body.itis ? body.itis : unwrapList(body);
      var tradeRows = body.trades ? body.trades : [];
      var itiOpts = optList(itiRows, ['iti_code', 'itiCode', 'nicItiCode'], ['iti_name', 'itiName']);
      var tradeOpts = optList(tradeRows, ['trade_code', 'tradeCode', 'tradeShort'], ['trade_name', 'tradeName']);
      setSel('itiSel', itiOpts, true);
      setSel('tradeSel', tradeOpts, true);
      var ins = (typeof SESSION_INS_CODE === 'string') ? SESSION_INS_CODE.trim() : '';
      if (ins) {
        var found = false;
        for (var k = 0; k < itiOpts.length; k++) { if (itiOpts[k].v === ins) { found = true; break; } }
        if (found) { document.getElementById('itiSel').value = ins; }
      }
      if (x.s >= 400 && itiOpts.length === 0 && tradeOpts.length === 0) {
        var em = (body && (body.error || body.message)) ? (body.error || body.message) : ('HTTP ' + x.s);
        setErr('itiError', 'Unable to load dropdowns: ' + em);
      } else {
        if (itiOpts.length === 0) setErr('itiError', 'No ITIs returned by the backend.');
        if (tradeOpts.length === 0) setErr('tradeError', 'No trades returned by the backend.');
      }
    })
    .catch(function(){ setErr('itiError', 'Unable to load dropdowns. Backend unavailable.'); });
  loadPhasesYears();
}
function loadPhasesYears(){
  fetch(CTX + '/admissions/dsc-list/api/phases')
    .then(function(r){ return r.json(); })
    .then(function(b){ applyPhasesYears(unwrapList(b)); })
    .catch(function(){ applyPhasesYears([]); });
}
function applyPhasesYears(rows){
  var years = [], phases = [], i;
  for (i = 0; i < rows.length; i++) {
    var r = rows[i] || {};
    if (r.year !== null && r.year !== undefined && String(r.year) !== '' && years.indexOf(String(r.year)) < 0) years.push(String(r.year));
    if (r.phase !== null && r.phase !== undefined && String(r.phase) !== '' && phases.indexOf(String(r.phase)) < 0) phases.push(String(r.phase));
  }
  years.sort().reverse();
  phases.sort(function(a, c){ return parseInt(a, 10) - parseInt(c, 10); });
  if (years.length === 0) years = [String(new Date().getFullYear())];
  if (phases.length === 0) phases = ['1'];
  var yo = [], po = [];
  for (i = 0; i < years.length; i++) yo.push({ v: years[i], t: years[i] });
  for (i = 0; i < phases.length; i++) po.push({ v: phases[i], t: 'Phase ' + phases[i] });
  setSel('yearSel', yo, true);
  setSel('phaseSel', po, true);
  fetch(CTX + '/admissions/dsc-list/api/current-phase')
    .then(function(r){ return r.json(); })
    .then(function(c){
      if (!c) return;
      if (c.year !== null && c.year !== undefined && String(c.year) !== '') document.getElementById('yearSel').value = String(c.year);
      if (c.phase !== null && c.phase !== undefined && String(c.phase) !== '') document.getElementById('phaseSel').value = String(c.phase);
    })
    .catch(function(){});
}
loadDropdowns();
</script>
<script>
function fmtDate(v){ if(!v) return ""; try { var d = new Date(v); if(isNaN(d.getTime())) return String(v); var dd=("0"+d.getDate()).slice(-2), mm=("0"+(d.getMonth()+1)).slice(-2); return dd+"/"+mm+"/"+d.getFullYear(); } catch(e){ return String(v); } }
function getDscList(){
  var iti = val('itiSel'), trade = val('tradeSel'), phase = val('phaseSel'), year = val('yearSel'), level = val('levelSel');
  setErr('itiError', iti ? '' : 'ITI Name is required.');
  setErr('tradeError', trade ? '' : 'Trade is required.');
  setErr('phaseError', phase ? '' : 'Phase is required.');
  setErr('yearError', year ? '' : 'Year is required.');
  setErr('levelError', level ? '' : 'Admission Performed in Level is required.');
  if(!iti || !trade || !phase || !year || !level) return;
  var btn = document.getElementById('goBtn');
  var area = document.getElementById('resultArea');
  btn.disabled = true; btn.value = 'Loading...';
  area.innerHTML = '<p>Loading DSC list...</p>';
  document.getElementById('screen1').style.display = 'none';
  document.getElementById('screen2').style.display = 'block';
  var url = CTX + '/admissions/dsc-list/api/dsc-list?itiCode=' + encodeURIComponent(iti) + '&tradeCode=' + encodeURIComponent(trade) + '&phase=' + encodeURIComponent(phase) + '&year=' + encodeURIComponent(year) + '&admissionLevel=' + encodeURIComponent(level);
  fetch(url)
    .then(function(r){ return r.json().then(function(b){ return { s: r.status, b: b }; }); })
    .then(function(x){ renderResult(x, iti, trade, phase, year, level); })
    .catch(function(){ document.getElementById('resultArea').innerHTML = '<p style="color:red;">Unable to fetch DSC list. Please try again.</p>'; })
    .finally(function(){ btn.disabled = false; btn.value = 'SUBMIT'; });
}
function renderResult(x, iti, trade, phase, year, level){
  var area = document.getElementById('resultArea');
  var meta = document.getElementById('reportMeta');
  var itiEl = document.getElementById('itiSel');
  var tradeEl = document.getElementById('tradeSel');
  meta.innerHTML = 'Session / Year: <span>' + esc(year) + '</span> &nbsp; Phase: <span>' + esc(phase) + '</span>';
  meta.innerHTML += ' &nbsp; ITI: <span>' + esc(itiEl.options[itiEl.selectedIndex].text) + '</span>';
  meta.innerHTML += ' &nbsp; Trade: <span>' + esc(tradeEl.options[tradeEl.selectedIndex].text) + '</span>';
  if(x.s === 400){ area.innerHTML = '<p style="color:red;">' + esc(msgOf(x.b, 'Invalid request. Please verify the selected criteria.')) + '</p>'; return; }
  if(x.s === 404){ area.innerHTML = '<p style="color:red;">' + esc(msgOf(x.b, 'No records found for the selected criteria.')) + '</p>'; return; }
  if(x.s === 500){ area.innerHTML = '<p style="color:red;">' + esc(msgOf(x.b, 'Backend error while generating DSC list. Please try again.')) + '</p>'; return; }
  if(x.s >= 400){ area.innerHTML = '<p style="color:red;">' + esc(msgOf(x.b, 'HTTP ' + x.s)) + '</p>'; return; }
  var list = Array.isArray(x.b) ? x.b : ((x.b && Array.isArray(x.b.data)) ? x.b.data : null);
  if(list === null){ area.innerHTML = '<p style="color:red;">Unexpected backend response. Please try again.</p>'; return; }
  if(list.length === 0){ area.innerHTML = '<p style="color:red;">No records found.</p>'; return; }
  var h = "<table class='res-table'><tr><th>Sl No</th><th>Rank</th><th>Admission Number</th>";
  h += "<th>Name</th><th>Father Name</th><th>Gender</th><th>Date of Birth</th><th>Caste</th></tr>";
  list.forEach(function(r, i){
    r = r || {};
    var sl = (r.slNo !== null && r.slNo !== undefined && String(r.slNo) !== '') ? r.slNo : (i + 1);
    var rank = (r.rank !== null && r.rank !== undefined && String(r.rank) !== '') ? r.rank : '';
    var adm = r.admissionNumber || r.admission_number || r.admNum || '';
    var fn = r.fatherName || r.father_name || r.fname || '';
    var dob = fmtDate(r.dateOfBirth || r.date_of_birth || r.dob);
    h += "<tr><td>" + esc(sl) + "</td><td>" + esc(rank) + "</td><td>" + esc(adm) + "</td>";
    h += "<td>" + esc(r.name) + "</td><td>" + esc(fn) + "</td><td>" + esc(r.gender) + "</td>";
    h += "<td>" + esc(dob) + "</td><td>" + esc(r.caste) + "</td></tr>";
  });
  h += "</table><div class='meta'>Source: GET /admission/dsc-list</div>";
  area.innerHTML = h;
}
function msgOf(b, fb){
  if (typeof b === 'string') { try { var p = JSON.parse(b); if (p && (p.error || p.message)) return p.error || p.message; } catch(e){} return b; }
  if (b && (b.error || b.message)) return b.error || b.message;
  return fb;
}
function resetDscList(){
  document.getElementById('itiSel').selectedIndex = 0;
  document.getElementById('tradeSel').selectedIndex = 0;
  document.getElementById('phaseSel').selectedIndex = 0;
  document.getElementById('yearSel').selectedIndex = 0;
  document.getElementById('levelSel').selectedIndex = 0;
  setErr('itiError',''); setErr('tradeError',''); setErr('phaseError',''); setErr('yearError',''); setErr('levelError','');
  document.getElementById('resultArea').innerHTML = '';
  document.getElementById('reportMeta').innerHTML = '';
  document.getElementById('screen2').style.display = 'none';
  document.getElementById('screen1').style.display = 'block';
}
function backToSelection(){
  document.getElementById('screen2').style.display = 'none';
  document.getElementById('screen1').style.display = 'block';
}
</script>
</body>
</html>