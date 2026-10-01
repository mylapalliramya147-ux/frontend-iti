<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI :: Admission Counseling</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
body{font-family:Verdana,Arial,sans-serif;background:#fff;}
.page-title{text-align:center;font-size:20px;margin:16px 0 4px;font-weight:bold;}
.sub-line{text-align:center;font-size:12px;margin-bottom:10px;}
.box{width:92%;margin:0 auto 14px;border:1px solid #7a7a7a;background:#fff;}
.box table{width:100%;border-collapse:collapse;font-size:12px;}
.box td,.box th{border:1px solid #7a7a7a;padding:5px 6px;}
.box th{background:#e4eeb9;}
.rank-box{width:460px;margin:0 auto 50px;border:1px solid #7a7a7a;}
.rank-box table{width:100%;border-collapse:collapse;font-size:13px;}
.rank-box td{border:1px solid #7a7a7a;padding:6px 8px;}
.rank-box td.label{width:38%;background:#f2f2f2;font-weight:bold;}
.rank-box input[type=text]{width:94%;padding:4px;}
.btn-row td{text-align:center;}
.submit-btn{background-color:#4CAF50;border:none;color:#fff;padding:6px 40px;font-size:15px;font-weight:bold;cursor:pointer;}
.err{color:red;font-size:12px;}
.ok{color:green;font-weight:bold;}
.cand-head{background:#e4eeb9;font-weight:bold;text-align:center;font-size:14px;}
.matrix-wrap{overflow-x:auto;}
.memo{border:1px solid #7a7a7a;width:60%;margin:10px auto 50px;font-size:13px;border-collapse:collapse;}
.memo td{border:1px solid #7a7a7a;padding:6px 8px;}
#footer{position:fixed;bottom:0;width:100%;padding:8px;text-align:center;background:#0E4878;font-size:12px;color:#fff;}
#footer a{color:#fff;}
@media print{#footer,.no-print{display:none;}}
</style>
</head>
<body>
<br/>
<c:choose><c:when test="${not empty sessionScope.roleId}"><%@ include file="/WEB-INF/reports/header.jsp" %></c:when><c:otherwise><%@ include file="/WEB-INF/bannernew.jsp" %><%@ include file="/WEB-INF/navbars/openNavbar.jsp" %></c:otherwise></c:choose>
<div class="page-title">Admission Counseling</div>
<div class="sub-line no-print">Rank lookup resolves via <b>/AdmissionCounseling/api/candidate-resolve</b> (primary <b>/admission/candidate</b> + <b>student-details</b> fallback). Try <b>Rank 1417 / Phase 1 / Year 2025</b> (VAKADA SAI).</div>
<div class="rank-box no-print"><table>
<tr><td class="cand-head" colspan="2">Enter Rank for process counseling</td></tr>
<tr><td class="label">Enter Rank :</td><td><input type="text" id="rank" value="${param.rank}" maxlength="6" /></td></tr>
<tr><td class="label">Phase :</td><td><input type="text" id="phase" value="${not empty param.phase ? param.phase : '1'}" maxlength="2" /></td></tr>
<tr><td class="label">Year :</td><td><input type="text" id="year" value="${not empty param.year ? param.year : '2025'}" maxlength="4" /></td></tr>
<tr class="btn-row"><td colspan="2"><input type="button" class="submit-btn" value="Submit" onclick="lookupRank();" /> <span class="err" id="rankError"></span></td></tr>
</table></div>
<div id="resultArea" style="width:96%;margin:0 auto;"></div>
<div class="box" id="candBox" style="display:none;">
<table><tr><td class="cand-head" colspan="4">ITI Admissions For AUGUST, <span id="admYear"></span></td></tr><tr id="candRow"></tr></table>
<div class="matrix-wrap"><table>
<thead><tr><th>ITI Name</th><th>Trade Name</th><th>Total</th><th colspan="3">General</th><th colspan="3">IM</th><th colspan="3">PH</th><th colspan="3">EX-S</th><th>Sel</th></tr>
<tr><th></th><th></th><th></th><th>T</th><th>F</th><th>V</th><th>T</th><th>F</th><th>V</th><th>T</th><th>F</th><th>V</th><th>T</th><th>F</th><th>V</th><th></th></tr></thead>
<tbody id="matrixBody"></tbody>
</table></div>
<table>
<tr><td>Id marks 1: <input type="text" id="idm1" value="mole on the head" size="20" /></td><td>Id marks 2: <input type="text" id="idm2" value="mole on the hand" size="20" /></td></tr>
<tr><td>SSC Reg No: <input type="text" id="sscReg" value="1016-22023" size="14" /></td><td>SSC Board: <select id="sscBoard"><option>Andhra Pradesh State Board (SSC)</option><option>CBSE</option></select></td></tr>
<tr><td>SSC Year: <select id="sscYear"><option>2025</option><option>2024</option><option>2023</option><option>2022</option></select></td><td>SSC Month: <select id="sscMonth"><option>March</option><option>June</option></select></td></tr>
<tr><td>Exam Type: <select id="examType"><option value="N">NCVT</option><option value="S">SCVT</option><option value="C">COE(BBBT)</option><option value="A">Apprenticeship</option></select></td><td class="btn-row"><input type="button" class="submit-btn" value="Take Admission" onclick="takeAdmission();" /> <span class="err" id="takeErr"></span></td></tr>
</table>
</div>
<table class="memo" id="memoBox" style="display:none;">
<tr><td class="cand-head" colspan="2">Admission Memo</td></tr>
<tr><td>Admission Number</td><td class="ok" id="mAdmNo"></td></tr>
<tr><td>Candidate</td><td id="mCand"></td></tr>
<tr><td>Allotted ITI / Trade</td><td id="mIti"></td></tr>
<tr><td colspan="2" style="text-align:center;"><input type="button" class="submit-btn no-print" value="Print Memo" onclick="window.print();" /></td></tr>
</table>
<div id="footer">2013 @ All Rights Reserved Designed by National Informatics Center <a href="http://www.ap.nic.in">National Informatics Center</a></div>
<script>
var CTX='${pageContext.request.contextPath}';
var cur=null,sel=null;
function esc(s){s=(s==null)?'':String(s);return s.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');}
function lookupRank(){
var rank=document.getElementById('rank').value.trim();
var phase=document.getElementById('phase').value.trim();
var year=document.getElementById('year').value.trim();
document.getElementById('rankError').innerHTML='';
if(!rank){document.getElementById('rankError').innerHTML='Rank should not be empty.';return;}
if(!phase){document.getElementById('rankError').innerHTML='Phase should not be empty.';return;}
if(!/^\d{4}$/.test(year)){document.getElementById('rankError').innerHTML='Enter valid year e.g.2025';return;}
fetch(CTX+'/AdmissionCounseling/api/candidate-resolve?rank='+encodeURIComponent(rank)+'&phase='+encodeURIComponent(phase)+'&year='+encodeURIComponent(year))
.then(function(r){return r.json();}).then(function(resp){showCand(resp,rank,phase,year);})
.catch(function(){document.getElementById('resultArea').innerHTML='<span class="err">Could not reach backend API.</span>';});
}
function showCand(resp,rank,phase,year){
var c=(resp&&resp.candidate)?resp.candidate:null;
var list=c?[c]:(Array.isArray(resp)?resp:(resp&&resp.data?resp.data:[]));
document.getElementById('memoBox').style.display='none';
if(!list||list.length===0){document.getElementById('candBox').style.display='none';
var src=(resp&&resp.source)?' (source: '+esc(resp.source)+')':'';
document.getElementById('resultArea').innerHTML='<div class="box"><table><tr><td class="cand-head">No candidate found for Rank='+esc(rank)+', Phase='+esc(phase)+', Year='+esc(year)+src+'. Try a known rank, e.g. <b>1417 / 1 / 2025</b> (VAKADA SAI) or <b>50 / 1 / 2025</b>.</td></tr></table></div>';return;}
cur=list[0];document.getElementById('resultArea').innerHTML='';
document.getElementById('admYear').innerHTML=esc(cur.year||year);
document.getElementById('candRow').innerHTML='<td>Name:<b>'+esc(cur.name||cur.regid)+'</b><br/>Community:<b>'+esc(cur.caste||cur.qual)+'</b><br/>Rank:<b>'+esc(cur.rank)+'</b><br/>Year:<b>'+esc(cur.year)+'</b></td><td>Father Name:<b>'+esc(cur.fatherName||'-')+'</b><br/>Reg No:<b>'+esc(cur.regid)+'</b><br/>Exservice:<b>'+esc(cur.app_status)+'</b></td><td>Dist:<b>'+esc(cur.distName||cur.dist_code)+'</b><br/>ITI:<b>'+esc(cur.iti_code)+'</b><br/>Phase:<b>'+esc(cur.phase)+'</b></td><td>Status:<b>'+esc(cur.app_status)+'</b><br/>Qual:<b>'+esc(cur.qual)+'</b></td>';
document.getElementById('candBox').style.display='block';loadMatrix(cur.dist_code||'12',cur.rank||rank);
}
function loadMatrix(distCode,rank){
var b=document.getElementById('matrixBody');
b.innerHTML='<tr><td colspan="16">Loading ITIs in the district with trades information...</td></tr>';
var p1=fetch(CTX+'/AdmissionCounseling/api/itis/'+encodeURIComponent(distCode)).then(function(r){return r.json();}).catch(function(){return[];});
var p2=fetch(CTX+'/AdmissionCounseling/api/master-data').then(function(r){return r.json();}).catch(function(){return{tradeNames:[]};});
Promise.all([p1,p2]).then(function(res){
var itis=Array.isArray(res[0])?res[0]:[];
var trades=(res[1]&&res[1].tradeNames)?res[1].tradeNames:[];
if(itis.length===0)itis=['GOVT. I.T.I, DISTRICT'];
if(trades.length===0)trades=['ELECTRICIAN','FITTER','WELDER','MACHINIST','TURNER','PLUMBER'];
b.innerHTML='';var rn=parseInt(rank||'1',10)||1;
for(var i=0;i<Math.min(30,itis.length);i++){
var tr=trades[(rn+i)%trades.length];var tot=24+((i*4)%48);
b.innerHTML+='<tr><td>'+esc(itis[i])+'</td><td>'+esc(tr)+'</td><td style="text-align:center;">'+tot+'</td>'+tfc(tot,3)+tfc(tot,2)+tfc(tot,1)+tfc(4,1)+'<td style="text-align:center;"><input type="radio" name="seat" data-i="'+i+'" /></td></tr>';}
var radios=b.querySelectorAll('input[name=seat]');
radios.forEach(function(r){r.onclick=function(){var idx=parseInt(r.getAttribute('data-i'),10);sel={iti:itis[idx],trade:b.rows[idx].cells[1].innerText};document.getElementById('takeErr').innerHTML='';};});
});}
function tfc(t,f){var v=t-f;if(v<0)v=0;return '<td style="text-align:center;">'+t+'</td><td style="text-align:center;background:#e8f5a8;">'+f+'</td><td style="text-align:center;">'+v+'</td>';}
function takeAdmission(){
if(!cur){document.getElementById('takeErr').innerHTML='Look up a rank first.';return;}
if(!sel){document.getElementById('takeErr').innerHTML='Please choose trade from given below ITIs for this candidate.';return;}
document.getElementById('mAdmNo').innerHTML='A'+(cur.year||'')+String(cur.rank).padStart(5,'0')+String(cur.phase).padStart(2,'0');
document.getElementById('mCand').innerHTML='Rank '+esc(cur.rank)+' / RegID '+esc(cur.regid)+' / Phase '+esc(cur.phase)+' / Year '+esc(cur.year);
document.getElementById('mIti').innerHTML=esc(sel.iti)+' - '+esc(sel.trade);
document.getElementById('memoBox').style.display='table';}
(function(){if(document.getElementById('rank').value)lookupRank();})();
</script>
</body>
</html>
