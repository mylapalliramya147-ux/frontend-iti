<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Seat Matrix</title>
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
  .result-wrap { width:96%; margin:10px auto 60px; font-family:Verdana,Arial,sans-serif; }
  .vac-head { text-align:center; color:blue; font-size:18px; font-weight:bold; margin:14px 0 2px; }
  .vac-sub { text-align:center; font-size:14px; font-weight:bold; margin:0 0 10px; }
  .vac-sub span { color:blue; }
  .res-table { border-collapse:collapse; margin:0 auto; font-size:13px; background:#fff; }
  .res-table th, .res-table td { border:1px solid #7a7a7a; padding:5px 10px; }
  .res-table th { background:#f2f2f2; }
  .note { width:70%; margin:12px auto; font-size:12px; color:#333; background:#fef9e7; border:1px solid #d4ac0d; padding:8px 10px; }
  .meta { text-align:center; font-size:11px; color:#666; margin-top:8px; }
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
<div class="page-title">Seat Matrix</div>
<div class="req-note">* Denotes Required Field</div>
<div class="seat-box">
  <table>
    <tr>
      <td class="label">Select ITI :</td>
      <td><select id="itiSel"><option value="">--select--</option></select><span class="err" id="itiError"></span></td>
    </tr>
    <tr>
      <td class="label">Select Trade :</td>
      <td><select id="tradeSel"><option value="">--select--</option></select><span class="err" id="tradeError"></span></td>
    </tr>
    <tr>
      <td class="label">Select Year :</td>
      <td><select id="yearSel"><option value="">--select--</option><option>2020</option><option>2021</option><option>2022</option><option>2023</option><option>2024</option><option selected>2025</option><option>2026</option></select><span class="err" id="yearError"></span></td>
    </tr>
    <tr>
      <td></td>
      <td><input type="button" id="goBtn" class="submit-btn" value="Get Seat Matrix" onclick="getSeatMatrix();" /></td>
    </tr>
  </table>
</div>
<div id="resultArea" class="result-wrap"><p style="color:red;font-size:13px;">Data will appear here</p></div>
<div id="footer">2013 @ All Rights Reserved&nbsp;&nbsp; Designed by&nbsp;&nbsp; National Informatics Center <a href="http://www.ap.nic.in">National Informatics Center</a>&nbsp;&nbsp;&nbsp;&nbsp; <a href="#">Disclaimer</a></div>
<script>var CTX = '${pageContext.request.contextPath}';</script>
<script>
function esc(s){ if(s===null||s===undefined) return ''; return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
function opt(v,t){ return '<option value="'+esc(v)+'">'+esc(t)+'</option>'; }
function setErr(id,m){ document.getElementById(id).innerHTML = m||''; }
function loadItis(){
  var sel = document.getElementById('itiSel');
  fetch(CTX + '/SeatMatrix/api/district/32/itis').then(function(r){ return r.json(); }).then(function(list){
    if(!Array.isArray(list) || list.length===0) throw 0;
    var h = opt('','--select--');
    list.forEach(function(x){ h += opt(x.itiCode, x.itiCode + ' - ' + x.itiName); });
    sel.innerHTML = h;
  }).catch(function(){
    fetch(CTX + '/SeatMatrix/api/itis/32').then(function(r){ return r.json(); }).then(function(nm){
      var h = opt('','--select--');
      (Array.isArray(nm)?nm:[]).forEach(function(n){ h += opt(n,n); });
      sel.innerHTML = h;
    }).catch(function(){});
  });
}
function loadTrades(itiCode){
  var sel = document.getElementById('tradeSel');
  sel.innerHTML = opt('','--select--');
  if(!itiCode) return;
  fetch(CTX + '/SeatMatrix/api/iti/' + encodeURIComponent(itiCode) + '/trades')
    .then(function(r){ return r.json(); }).then(function(list){
      if(!Array.isArray(list) || list.length===0) return;
      var h = opt('','--select--');
      list.forEach(function(t){ h += opt(t.tradeShort, (t.tradeName||t.tradeShort) + ' (' + t.tradeShort + ')'); });
      sel.innerHTML = h;
    }).catch(function(){});
}
document.getElementById('itiSel').addEventListener('change', function(){ loadTrades(this.value); });
loadItis();
</script>
<script>
function getSeatMatrix(){
  var iti = document.getElementById('itiSel').value;
  var trade = document.getElementById('tradeSel').value;
  var year = document.getElementById('yearSel').value;
  setErr('itiError', iti ? '' : 'ITI is required.');
  setErr('tradeError', trade ? '' : 'Trade is required.');
  setErr('yearError', year ? '' : 'Year is required.');
  if(!iti || !trade || !year) return;
  var btn = document.getElementById('goBtn');
  var area = document.getElementById('resultArea');
  btn.disabled = true; btn.value = 'Loading...';
  area.innerHTML = '<p>Loading seat matrix...</p>';
  fetch(CTX + '/SeatMatrix/api/vacant-seats/' + encodeURIComponent(iti) + '/' + encodeURIComponent(trade))
    .then(function(r){ return r.json(); })
    .then(function(resp){ renderResult(resp, iti, trade, year); })
    .catch(function(){ area.innerHTML = '<p style="color:red;">Backend unavailable. Please try again later.</p>'; })
    .finally(function(){ btn.disabled = false; btn.value = 'Get Seat Matrix'; });
}
function renderResult(resp, iti, trade, year){
  var list = Array.isArray(resp) ? resp : (resp && Array.isArray(resp.data) ? resp.data : []);
  var area = document.getElementById('resultArea');
  if(!list || list.length===0){
    area.innerHTML = '<p style="color:red;">No seat data found for ITI=' + esc(iti) + ', Trade=' + esc(trade) + ', Year=' + esc(year) + '.</p>';
    return;
  }
  var row = list[0];
  var h = '<div class="vac-head">Seat Matrix Vacancy Position</div>';
  h += '<div class="vac-sub">for ITI: <span>' + esc(row.itiCode||iti) + '</span> , trade:<span>' + esc(row.tradeName||trade) + ' (' + esc(row.tradeShort||trade) + ')</span> , Year:<span>' + esc(year) + '</span></div>';
  h += '<table class="res-table"><tr><th>#</th><th>Total Strength</th><th>Strength Fill</th><th>Strength Vacant</th></tr>';
  h += '<tr><td>1</td><td>' + esc(row.strength) + '</td><td>' + esc(row.strengthFill) + '</td><td>' + esc(row.strengthVacant) + '</td></tr></table>';
  h += '<div class="note"><b>Note:</b> backend GET /admission/vacant-seats/{itiCode}/{tradeShort} returns one aggregated row '
    + 'with no year parameter, so Year ' + esc(year) + ' is display-only. '
    + 'The legacy 25-row category breakup (IM/OC/PH/SC/SP/ST/EWS/BC-A..E/EX-S/OC-W/.../EX-SW) is not in the response.</div>';
  h += '<div class="meta">Source: GET /admission/vacant-seats/' + esc(iti) + '/' + esc(trade) + '</div>';
  area.innerHTML = h;
}
</script>
</body>
</html>
