<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Admission Search</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
  .page-title { text-align:center; font-family:"Times New Roman",Times,serif; font-size:22px; margin:18px 0 14px; color:blue; text-decoration:underline; font-weight:bold; }
  .call-box { width:620px; max-width:94%; margin:0 auto 40px; border:1px solid #c00; background:#e6f4e6; }
  .call-box table { width:100%; border-collapse:collapse; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .call-box td { border:1px solid #9e9e9e; padding:5px 8px; }
  .call-box td.label { width:42%; background:#f2f2f2; font-weight:bold; font-family:"Times New Roman",Times,serif; }
  .call-box input[type=text] { width:96%; padding:4px; font-size:13px; }
  .call-box input[type=tel] { width:96%; padding:4px; font-size:13px; }
  .call-box select { width:96%; padding:4px; font-size:13px; }
  .call-box input[type=date] { width:96%; padding:4px; font-size:13px; }
  .call-box input[type=checkbox] { width:auto; }
  .call-box .btn-row td { text-align:center; background:#e6f4e6; }
  .submit-btn { background-color:#4CAF50; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; }
  .submit-btn:disabled { opacity:.55; cursor:default; }
  .reset-btn { background-color:#c0392b; border:none; color:#fff; padding:6px 42px; font-size:15px; font-weight:bold; cursor:pointer; margin-left:10px; }
  .err { color:red; font-size:12px; display:block; }
  .legend-note { font-size:11px; color:#555; font-style:italic; }
  .res-wrap { width:96%; margin:0 auto 40px; font-family:Verdana,Arial,sans-serif; font-size:13px; }
  .res-head { text-align:center; color:blue; font-size:18px; font-weight:bold; margin:14px 0 8px; }
  .res-scroll { overflow-x:auto; }
  .res-table { border-collapse:collapse; font-size:13px; background:#fff; width:100%; }
  .res-table th, .res-table td { border:1px solid #7a7a7a; padding:6px 9px; text-align:left; vertical-align:top; white-space:nowrap; }
  .res-table th { background:#e4eeb9; }
  .msg { text-align:center; font-size:14px; }
  .msg-err { color:red; }
  .msg-info { color:#333; }
  .act-row { text-align:center; margin:12px 0; }
  #footer { position:fixed; bottom:0; width:100%; padding:8px; text-align:center; background:#0E4878; font-size:12px; color:#fff; font-family:arial,verdana; }
  #footer a { color:#fff; }
  @media (max-width: 768px) {
    .call-box { width:100%; }
    .call-box td.label { width:38%; }
    .res-table th, .res-table td { font-size:12px; padding:4px 6px; white-space:normal; }
    .submit-btn, .reset-btn { padding:6px 26px; font-size:14px; }
  }
</style>
</head>
<body>
<br/>
<c:choose>
  <c:when test="${not empty sessionScope.roleId}"><%@ include file="/WEB-INF/reports/header.jsp" %></c:when>
  <c:otherwise><%@ include file="/WEB-INF/bannernew.jsp" %><%@ include file="/WEB-INF/navbars/openNavbar.jsp" %></c:otherwise>
</c:choose>

<div id="screen1">
  <div class="page-title">ITI Admissions Report Interface</div>
  <div class="call-box">
    <table>
      <tr>
        <td class="label">Admission Number :</td>
        <td><input type="text" id="admissionNumber" maxlength="20" /><span class="err" id="admissionNumberError"></span></td>
      </tr>
      <tr>
        <td class="label">Registration Number :</td>
        <td><input type="text" id="registrationNumber" maxlength="20" /><span class="err" id="registrationNumberError"></span></td>
      </tr>
      <tr>
        <td class="label">Name :</td>
        <td><input type="text" id="name" maxlength="100" /><span class="err" id="nameError"></span></td>
      </tr>
      <tr>
        <td class="label">Do You Want to Use Soundex :</td>
        <td>
          <select id="soundex">
            <option value="NO" selected="selected">NO</option>
            <option value="YES">YES</option>
          </select>
          <span class="legend-note">Not applied by the backend search API (original screen option).</span>
        </td>
      </tr>
      <tr>
        <td class="label">Father Name :</td>
        <td><input type="text" id="fatherName" maxlength="100" /><span class="err" id="fatherNameError"></span></td>
      </tr>
      <tr>
        <td class="label">Phone Number :</td>
        <td><input type="tel" id="phoneNumber" maxlength="15" /><span class="err" id="phoneNumberError"></span></td>
      </tr>
      <tr>
        <td class="label">Gender :</td>
        <td>
          <select id="gender">
            <option value=""></option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="label">Caste :</td>
        <td><input type="text" id="caste" maxlength="20" /><span class="err" id="casteError"></span></td>
      </tr>
      <tr>
        <td class="label">Res-Category :</td>
        <td><input type="text" id="reservationCategory" maxlength="20" /><span class="err" id="reservationCategoryError"></span></td>
      </tr>
      <tr>
        <td class="label">Year Of Admission :</td>
        <td><input type="text" id="yearOfAdmission" maxlength="4" /><span class="err" id="yearOfAdmissionError"></span></td>
      </tr>
      <tr>
        <td class="label">Date Of Admission :</td>
        <td><input type="date" id="dateOfAdmission" /><span class="err" id="dateOfAdmissionError"></span></td>
      </tr>
      <tr>
        <td class="label">Type Of Admission :</td>
        <td><input type="text" id="typeOfAdmission" maxlength="20" /><span class="err" id="typeOfAdmissionError"></span></td>
      </tr>
      <tr>
        <td class="label">Select Sem :</td>
        <td>
          <select id="currentSem">
            <option value=""></option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="label">District Code :</td>
        <td><input type="text" id="districtCode" maxlength="5" /><span class="err" id="districtCodeError"></span></td>
      </tr>
      <tr>
        <td class="label">Iti Code :</td>
        <td><input type="text" id="itiCode" maxlength="6" value="1603" /><span class="err" id="itiCodeError"></span></td>
      </tr>
      <tr>
        <td class="label">Trade Code :</td>
        <td><input type="text" id="tradeCode" maxlength="6" /><span class="err" id="tradeCodeError"></span></td>
      </tr>
      <tr>
        <td class="label">Phase :</td>
        <td><input type="text" id="phase" maxlength="3" /><span class="err" id="phaseError"></span></td>
      </tr>
      <tr>
        <td class="label">Select Table :</td>
        <td>
          <select id="selectTable">
            <option value="Iti Admissions" selected="selected">Iti Admissions</option>
          </select>
          <span class="legend-note">Not sent to the backend search API (original screen option).</span>
        </td>
      </tr>
      <tr>
        <td class="label">Do you want to include Exams Table Also :</td>
        <td><input type="checkbox" id="includeExamsTable" /> <label for="includeExamsTable">Include Exams Table</label>
          <span class="legend-note">Not supported by the backend search API (original screen option).</span>
        </td>
      </tr>
      <tr class="btn-row">
        <td colspan="2">
          <input type="button" class="submit-btn" id="goBtn" value="Submit" onclick="getAdmissionSearch();" />
          <input type="button" class="reset-btn" id="resetBtn" value="Reset" onclick="resetSearch();" />
        </td>
      </tr>
    </table>
  </div>
</div>

<div id="screen2" style="display:none;">
  <div class="res-head">Admission Search Results</div>
  <div class="res-wrap"><div id="resultArea"></div>
  <div class="act-row no-print"><input type="button" class="reset-btn" value="Back to Search" onclick="backToSearch();" /></div></div>
</div>

<div id="footer">2013 @ All Rights Reserved&nbsp;
  <a href="#">Privacy Policy</a> | <a href="#">Terms &amp; Conditions</a> |
  <a href="#">Refund &amp; Cancellation</a>
</div>

<script type="text/javascript">
var CTX = "${pageContext.request.contextPath}";
var FIELDS = ["admissionNumber","registrationNumber","name","fatherName","phoneNumber","gender","caste","reservationCategory","yearOfAdmission","dateOfAdmission","typeOfAdmission","currentSem","districtCode","itiCode","tradeCode","phase"];
var DEFAULTS = { "itiCode": "1603" };
function isDefault(id, v){ return DEFAULTS[id] !== undefined && v === DEFAULTS[id]; }
function esc(s){ return String(s).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"); }
function val(id){ var el=document.getElementById(id); return el?el.value:""; }
function setErr(id,msg){ var el=document.getElementById(id); if(el){ el.innerHTML=msg; } }
function clearErrors(){ for(var i=0;i<FIELDS.length;i++){ setErr(FIELDS[i]+"Error",""); } }
function txt(v){ if(v===null||v===undefined) return "N/A"; var s=String(v).trim(); return s===""?"N/A":s; }
function pick(o){ if(!o) return null; if(Array.isArray(o)) return o; if(o.content) return o.content; if(o.data) return o.data; return o; }

getAdmissionSearch = function(){
  clearErrors();
  var params = new URLSearchParams();
  var filled = 0;
  for(var i=0;i<FIELDS.length;i++){
    var v = (val(FIELDS[i]) || "").trim();
    if(v !== "" && !isDefault(FIELDS[i], v)){ params.append(FIELDS[i], v); filled++; }
  }
  if(filled < FIELDS.length){
    alert("Please fill in ALL search fields before submitting. (" + filled + " of " + FIELDS.length + " completed)");
    return;
  }
  var btn = document.getElementById("goBtn");
  var area = document.getElementById("resultArea");
  btn.disabled = true; btn.value = "Loading...";
  area.innerHTML = "<p class='msg msg-info'>Loading, please wait...</p>";
  document.getElementById("screen1").style.display = "none";
  document.getElementById("screen2").style.display = "block";
  var url = CTX + "/admissions/search/api/admission-search?" + params.toString();
  fetch(url)
    .then(function(r){ return r.json().then(function(b){ return {s:r.status, b:b}; }); })
    .then(function(x){ renderResults(x); })
    .catch(function(){ document.getElementById("resultArea").innerHTML = '<p class="msg msg-err">Unable to connect to the server. Please make sure the backend is running.</p>'; })
    .finally(function(){ btn.disabled = false; btn.value = "Submit"; });
};

function renderResults(x){
  var area = document.getElementById("resultArea");
  if(x.s >= 400){
    var em = (x.b && (x.b.error || x.b.message)) ? (x.b.error || x.b.message) : ("HTTP " + x.s);
    area.innerHTML = '<p class="msg msg-err">' + esc(em) + '</p>';
    return;
  }
  var recs = pick(x.b);
  if(!Array.isArray(recs)){ recs = []; }
  if(recs.length === 0){
    area.innerHTML = '<p class="msg msg-info">No admission records found for the selected criteria.</p>';
    return;
  }
  var cols = ["Admission No","Registration No","Name","Father Name","Phone","Gender","Caste","ITI Code","Trade Code","Adm Year","Adm Date","Phase"];
  var h = '<div class="res-scroll"><table class="res-table"><thead><tr>';
  for(var i=0;i<cols.length;i++){ h += '<th>' + cols[i] + '</th>'; }
  h += '</tr></thead><tbody>';
  for(var r=0;r<recs.length;r++){
    var rec = recs[r] || {};
    var d = rec.dateOfAdmission ? String(rec.dateOfAdmission).substring(0,10) : "";
    h += '<tr>';
    h += '<td>' + txt(rec.admissionNumber) + '</td>';
    h += '<td>' + txt(rec.registrationNumber) + '</td>';
    h += '<td>' + txt(rec.name) + '</td>';
    h += '<td>' + txt(rec.fatherName) + '</td>';
    h += '<td>' + txt(rec.phoneNumber) + '</td>';
    h += '<td>' + txt(rec.gender) + '</td>';
    h += '<td>' + txt(rec.caste) + '</td>';
    h += '<td>' + txt(rec.itiCode) + '</td>';
    h += '<td>' + txt(rec.tradeCode) + '</td>';
    h += '<td>' + txt(rec.yearOfAdmission) + '</td>';
    h += '<td>' + txt(d) + '</td>';
    h += '<td>' + txt(rec.phase) + '</td>';
    h += '</tr>';
  }
  h += '</tbody></table></div>';
  area.innerHTML = h;
}

function resetSearch(){
  for(var i=0;i<FIELDS.length;i++){ var el=document.getElementById(FIELDS[i]); if(el){ el.value=""; } }
  document.getElementById("soundex").value = "NO";
  document.getElementById("itiCode").value = "1603";
  document.getElementById("selectTable").value = "Iti Admissions";
  document.getElementById("includeExamsTable").checked = false;
  clearErrors();
  document.getElementById("resultArea").innerHTML = "";
  document.getElementById("screen2").style.display = "none";
  document.getElementById("screen1").style.display = "block";
  var btn = document.getElementById("goBtn");
  btn.disabled = false; btn.value = "Submit";
}

function backToSearch(){
  document.getElementById("resultArea").innerHTML = "";
  document.getElementById("screen2").style.display = "none";
  document.getElementById("screen1").style.display = "block";
}
</script>
</body>
</html>
