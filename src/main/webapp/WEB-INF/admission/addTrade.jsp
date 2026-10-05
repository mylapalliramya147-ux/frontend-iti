<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Add Trade</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
  .page-title { font-family:Verdana,Arial,sans-serif; font-size:20px; margin:16px 0 2px 12px; color:#000; }
  .req-note { font-family:Verdana,Arial,sans-serif; font-size:12px; color:#c0392b; text-align:center; margin:0 0 6px; }
  .seat-box { width:58%; min-width:520px; margin:0 auto 18px 12px; border:1px solid #7a7a7a; background:#fff; }
  .seat-box table { width:100%; border-collapse:collapse; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .seat-box td { border-top:1px solid #ddd; border-bottom:1px solid #ddd; padding:8px; }
  .seat-box td.label { width:24%; font-weight:bold; }
  .seat-box select { width:96%; padding:4px; font-size:13px; }
  .submit-btn { background-color:#4CAF50; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; }
  .submit-btn:disabled { opacity:.55; cursor:default; }
  .err { color:red; font-size:12px; display:block; }
  .ok { color:green; font-size:12px; display:block; }
  .result-wrap { width:96%; margin:10px auto 60px; font-family:Verdana,Arial,sans-serif; }
  .vac-head { text-align:center; color:blue; font-size:18px; font-weight:bold; margin:14px 0 2px; }
  .vac-sub { text-align:center; font-size:14px; font-weight:bold; margin:0 0 10px; }
  .vac-sub span { color:blue; }
  .res-table { border-collapse:collapse; margin:0 auto; font-size:13px; background:#fff; }
  .res-table th, .res-table td { border:1px solid #7a7a7a; padding:5px 10px; }
  .res-table th { background:#f2f2f2; }
  .note { width:70%; margin:12px auto; font-size:12px; color:#333; background:#fef9e7; border:1px solid #d4ac0d; padding:8px 10px; }
  .meta { text-align:center; font-size:11px; color:#666; margin-top:8px; }
  .act-row { text-align:center; margin:12px 0; }
  #footer { position:fixed; bottom:0; width:100%; padding:8px; text-align:center; background:#0E4878; font-size:12px; color:#fff; }
  #footer a { color:#fff; }
</style>
</head>
<body>
<br/>
<c:choose>
  <c:when test="${not empty sessionScope.roleId}"><%@ include file="/WEB-INF/reports/header.jsp" %></c:when>
  <c:otherwise><%@ include file="/WEB-INF/bannernew.jsp" %><%@ include file="/WEB-INF/navbars/openNavbar.jsp" %></c:otherwise>
</c:choose>
<div class="page-title">Add Trade and Reservation Matrix in selected ITI</div>
<div class="req-note">* Denotes Required Field</div>
<div class="seat-box">
  <table>
    <tr>
      <td class="label">Select ITI * :</td>
      <td><select id="itiSel"><option value="">--select--</option></select><span class="err" id="itiError"></span></td>
    </tr>
    <tr>
      <td colspan="2" style="text-align:center;"><input type="button" id="goBtn" class="submit-btn" value="Submit" onclick="getTrades();" /></td>
    </tr>
  </table>
</div>
<div class="result-wrap" id="resultArea"></div>
<script>
var CTX = '${pageContext.request.contextPath}';
function esc(s){ if(s===null||s===undefined) return ''; return String(s).replace(/[&<>"]/g, function(c){ return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]; }); }
function setErr(id,m){ document.getElementById(id).innerHTML = esc(m); }
function opt(v,t){ return '<option value="' + esc(v) + '">' + esc(t) + '</option>'; }
function loadItis(){
  var sel = document.getElementById('itiSel');
  fetch(CTX + '/AddTrade/api/district/32/itis').then(function(r){ return r.json(); }).then(function(list){
    if(!Array.isArray(list) || list.length===0) throw 0;
    var h = opt('','--select--');
    list.forEach(function(x){ h += opt(x.itiCode, x.itiCode + ' - ' + x.itiName); });
    sel.innerHTML = h;
  }).catch(function(){
    fetch(CTX + '/AddTrade/api/itis/32').then(function(r){ return r.json(); }).then(function(nm){
      var h = opt('','--select--');
      (Array.isArray(nm)?nm:[]).forEach(function(n){ h += opt(n,n); });
      sel.innerHTML = h;
    }).catch(function(){});
  });
}
loadItis();
</script>
<script>
var curTrades = [];
function getTrades(){
  var iti = document.getElementById('itiSel').value;
  setErr('itiError', iti ? '' : 'ITI is required.');
  if(!iti) return;
  var btn = document.getElementById('goBtn');
  var area = document.getElementById('resultArea');
  btn.disabled = true; btn.value = 'Loading...';
  area.innerHTML = '<p>Loading trades...</p>';
  fetch(CTX + '/AddTrade/api/iti/' + encodeURIComponent(iti) + '/trades')
    .then(function(r){ return r.json(); })
    .then(function(resp){ renderTrades(resp, iti); })
    .catch(function(){ area.innerHTML = '<p style="color:red;">Backend unavailable. Please try again later.</p>'; })
    .finally(function(){ btn.disabled = false; btn.value = 'Submit'; });
}
function renderTrades(resp, iti){
  var list = Array.isArray(resp) ? resp : [];
  curTrades = list;
  var area = document.getElementById('resultArea');
  if(!list || list.length===0){
    area.innerHTML = '<p style="color:red;">No trades found for ITI=' + esc(iti) + '.</p>';
    return;
  }
  var h = '<div class="vac-head">All Trades for the ITI ' + esc(iti) + '</div>';
  h += '<div class="vac-sub">Selected ITI: <span>' + esc(iti) + '</span></div>';
  h += '<table class="res-table"><tr><th>Select</th><th>Trade Code</th><th>Trade</th><th>Strength</th><th>Filled</th><th>Vacant</th><th>Available for year 2026</th></tr>';
  list.forEach(function(t,i){
    h += '<tr><td style="text-align:center;"><input type="checkbox" name="tr" value="' + esc(t.tradeShort) + '" data-i="' + i + '" /></td>'
      + '<td>' + esc(t.tradeShort) + '</td><td>' + esc(t.tradeName) + '</td>'
      + '<td>' + esc(t.strength) + '</td><td>' + esc(t.strengthFill) + '</td><td>' + esc(t.strengthVacant) + '</td>'
      + '<td>Yes</td></tr>';
  });
  h += '</table>';
  h += '<div class="act-row"><input type="button" id="addBtn" class="submit-btn" value="Add Trade" onclick="addTradeGo();" />'
    + '&nbsp;<input type="button" id="apprBtn" class="submit-btn" value="Approve All" onclick="approveGo();" />'
    + '<span class="err" id="actErr"></span><span class="ok" id="actOk"></span></div>';
  h += '<div class="meta">Source: GET /admission/iti/' + esc(iti) + '/trades</div>';
  h += '<div class="note" id="detailBox" style="display:none;"></div>';
  area.innerHTML = h;
  var boxes = area.querySelectorAll('input[name=tr]');
  boxes.forEach(function(b){ b.onchange = function(){ showDetail(b); }; });
}
function selTrades(){
  var out = [];
  document.querySelectorAll('input[name=tr]:checked').forEach(function(b){ out.push(b.value); });
  return out;
}
function showDetail(box){
  var d = document.getElementById('detailBox');
  if(!box.checked || !d) return;
  var t = curTrades[parseInt(box.getAttribute('data-i'), 10)] || {};
  d.style.display = 'block';
  d.innerHTML = 'Trade ' + esc(t.tradeShort) + ' - ' + esc(t.tradeName)
    + ' | Strength ' + esc(t.strength) + ' | Filled ' + esc(t.strengthFill)
    + ' | Vacant ' + esc(t.strengthVacant) + ' | Unit ' + esc(t.unitStrength);
  fetch(CTX + '/AddTrade/api/trade/' + encodeURIComponent(box.value))
    .then(function(r){ return r.json(); }).then(function(list){
      var r0 = Array.isArray(list) ? list[0] : null;
      if(!r0) return;
      d.innerHTML += '<br/>Master: Code ' + esc(r0.tradeCode) + ' | Duration ' + esc(r0.durationYrs)
        + ' | MinQual ' + esc(r0.minQual) + ' | Eng ' + esc(r0.engNonEngg)
        + ' | Type ' + esc(r0.typeAdmission);
    }).catch(function(){});
}
function addTradeGo(){
  var iti = document.getElementById('itiSel').value;
  var sel = selTrades();
  setMsg('actErr', sel.length ? '' : 'Please select at least one trade to add.');
  setMsg('actOk', '');
  if(!sel.length) return;
  var btn = document.getElementById('addBtn');
  btn.disabled = true; btn.value = 'Adding...';
  fetch(CTX + '/AddTrade/api/iti/' + encodeURIComponent(iti) + '/trades', {
    method: 'POST', headers: {'Content-Type':'application/json'},
    body: JSON.stringify({itiCode: iti, trades: sel})
  }).then(function(r){ return r.json().then(function(b){ return {s: r.status, b: b}; }); })
  .then(function(x){
    var msg = (x.b && x.b.error) ? x.b.error : ('HTTP ' + x.s);
    setMsg('actErr', 'Add Trade not completed: ' + msg);
  }).catch(function(){ setMsg('actErr', 'Backend unavailable. Add Trade not completed.'); })
  .finally(function(){ btn.disabled = false; btn.value = 'Add Trade'; });
}
function approveGo(){
  var iti = document.getElementById('itiSel').value;
  setMsg('actErr', ''); setMsg('actOk', '');
  var btn = document.getElementById('apprBtn');
  btn.disabled = true; btn.value = 'Approving...';
  fetch(CTX + '/AddTrade/api/iti/' + encodeURIComponent(iti) + '/approve-all', {method: 'PUT'})
  .then(function(r){ return r.json().then(function(b){ return {s: r.status, b: b}; }); })
  .then(function(x){
    var msg = (x.b && x.b.error) ? x.b.error : ('HTTP ' + x.s);
    setMsg('actErr', 'Approve All not completed: ' + msg);
  }).catch(function(){ setMsg('actErr', 'Backend unavailable. Approve All not completed.'); })
  .finally(function(){ btn.disabled = false; btn.value = 'Approve All'; });
}
function setMsg(id,m){ var e = document.getElementById(id); if(e) e.innerHTML = esc(m); }
</script>
</body>
</html>
