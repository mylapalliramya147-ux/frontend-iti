<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.sessionUser}"><c:redirect url="/?error=session"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ITI Login Success</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<!-- Chart.js v4 (CDN - not shipped locally); matches source's new Chart(ctx,{type:'pie'}) API -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<!-- SheetJS xlsx (CDN) - used by the above/below-20% Excel export -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<link href="${pageContext.request.contextPath}/css/all.min.css" rel="stylesheet">
<style>
.modal{position:fixed;z-index:1;padding-top:100px;left:0;top:0;width:100%;height:90%;overflow:auto;background-color:rgba(0,0,0,0.4);}
.close{color:black;float:right;font-size:40px;font-weight:bold;background-color:#ff6600;width:100px;margin-right:80px;}
.close:hover,.close:focus{color:#000;text-decoration:none;cursor:pointer;}
a>input[type=button]{border:none;background-color:#e4eeb9;color:black;font-weight:bolder;}
#custom{border:1px solid red;background-color:#e4eeb9;margin-bottom:20px;border-radius:10px;height:40px;}
.card{border:none;border-radius:8px;box-shadow:0 1px 4px rgba(0,0,0,.1);}
.card-body{padding:14px 16px;}
.card-title{font-size:16px;font-weight:700;margin-bottom:8px;}
.card-link{font-size:13px;margin:0 4px;text-decoration:none;}
#tabledata{margin-bottom:20px;}
#tabledata th,#tabledata td{border:1px solid #dee2e6;padding:6px 10px;font-size:13px;text-align:center;}
#tabledata th{background:#172233;color:#fff;}
</style>
<!-- Session-derived auth (ITIAP uses server sessions, NOT the JWT the original page used).
     The masterdata/** endpoints and masterdata/findByItiCode do not exist in the ITIAP
     Backend yet, so their JS callers below are stubbed / fail silently (no alerts). -->
<script>
var jwtToken = '';
var roleId   = '<c:out value="${sessionScope.roleId}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = "${backendBaseUrl}/";   /* e.g. http://localhost:5050/ */
</script>
<script>
$(document).ready(function(){
document.getElementById("userinfo").innerHTML =
"<i class='fas fa-user'></i> " + username +
" | <i class='fas fa-id-badge'></i> " + insCode +
" | <i class='fas fa-building'></i> " + insName;
});
</script>
</head>
<body>

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border:1px solid black;width:100%;border-radius:2px;">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container-fluid">
<a class="navbar-brand" href="${pageContext.request.contextPath}/placements/loginSuccess"><i class="fas fa-home"></i> Home</a>
<div class="text-white fw-bold">Welcome : <span id="userinfo"></span></div>
<div><a href="${pageContext.request.contextPath}/logout" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
</div>
</nav>

<div class="container p-2">
<c:if test="${sessionScope.roleId != '1' and sessionScope.roleId != '2'}">
<div class="row">
<div class="col-md-3 d-flex"><div class="card h-100 w-100"><div class="card-header"><i class="fas fa-cog"></i> SERVICES</div><div class="card-body" id="services"></div></div></div>
<div class="col-md-3 d-flex"><div class="card h-100 w-100"><div class="card-header"><i class="fas fa-flask"></i> LABS</div><div class="card-body" id="labcard"></div></div></div>
<div class="col-md-3 d-flex"><div class="card h-100 w-100"><div class="card-header"><i class="fas fa-industry"></i> IN-PLANT</div><div class="card-body" id="inplantcard"></div></div></div>
<div class="col-md-3 d-flex"><div class="card h-100 w-100"><div class="card-header"><i class="fas fa-briefcase"></i> PLACEMENTS</div><div class="card-body" id="plcmtscard"></div></div></div>
</div>
</c:if>

<!-- Aggregate stat charts are district/state level. ITI admin (role 4) and district (role 3) see only menu cards. -->
<c:if test="${sessionScope.roleId != '4' and sessionScope.roleId != '3' and sessionScope.roleId != '1' and sessionScope.roleId != '2'}">
<div class="row mt-3 g-2">
<div class="col d-flex"><div class="card h-100 w-100"><div class="card-header text-center text-primary text-decoration-underline" style="font-size:13px;"><i class="fas fa-chair"></i> GOVT &amp; PRIVATE ITIs</div><div class="card-body">
<div style="position:relative;height:170px;"><canvas id="dashBoardAllSeats"></canvas></div>
<span id="totaldashBoardAllSeats" class="card-link">Total Seats - --</span>
<span id="fillrationdashBoardAllSeats" class="card-link"><br>Fill Ratio - --%</span>
</div></div></div>
<div class="col d-flex"><div class="card h-100 w-100"><div class="card-header text-center text-primary text-decoration-underline" style="font-size:13px;"><i class="fas fa-building"></i> GOVERNMENT ITI's</div><div class="card-body">
<div style="position:relative;height:170px;"><canvas id="govtSeatsPieChart"></canvas></div>
<span id="totalseatsgovtitis" class="card-link">Total Seats - --</span>
<span id="fillrationgovtitis" class="card-link"><br>Fill Ratio - --%</span>
</div></div></div>
<div class="col d-flex"><div class="card h-100 w-100"><div class="card-header text-center text-primary text-decoration-underline" style="font-size:13px;"><i class="fas fa-hotel"></i> PRIVATE ITI's</div><div class="card-body">
<div style="position:relative;height:170px;"><canvas id="pvtSeatsPieChart"></canvas></div>
<span id="totalseatspvtitis" class="card-link">Total Seats - --</span>
<span id="fillrationpvtitis" class="card-link"><br>Fill Ratio - --%</span>
</div></div></div>
<div class="col d-flex"><div class="card h-100 w-100"><div class="card-header text-center text-primary text-decoration-underline" style="font-size:13px;"><i class="fas fa-thumbs-up"></i> &gt;= 20% ADMITTED ITIs</div><div class="card-body">
<div style="position:relative;height:170px;"><canvas id="above20PercentPieChart"></canvas></div>
<span id="above20StrengthFill" class="card-link">Total Seats - --</span>
<span id="above20FillRatio" class="card-link"><br>Fill Ratio - --%</span>
<span id="above20NoOfItis" class="card-link"><br>No Of ITIs : --</span>
</div></div></div>
<div class="col d-flex"><div class="card h-100 w-100"><div class="card-header text-center text-primary text-decoration-underline" style="font-size:13px;"><i class="fas fa-thumbs-down"></i> &lt;= 20% ADMITTED ITIs</div><div class="card-body">
<div style="position:relative;height:170px;"><canvas id="below20PercentPieChart"></canvas></div>
<span id="below20StrengthFill" class="card-link">Total Seats - --</span>
<span id="below20FillRatio" class="card-link"><br>Fill Ratio - --%</span>
<span id="below20NoOfItis" class="card-link"><br>No Of ITIs : --</span>
</div></div></div>
</div>

<div class="text-end mt-2"><button type="button" class="btn btn-sm btn-outline-primary" onclick="fnExcelReport('tabledata')"><i class="fas fa-file-excel"></i> Export to Excel</button></div>

<div id="spinnerdiv" class="text-center py-5"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>
<div id="spinnerdiv2" class="text-center py-5" style="display:none;"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>

<div id="datadiv" style="display:none;">
<div id="dataheading" class="h5 mb-3" style="color:blue;font-size:12px;text-decoration:underline;">Overview</div>
<table id="tabledata" class="table table-bordered"><thead><tr><th>S.No</th><th>District</th><th>ITI Name</th><th>Strength</th><th>Filled</th><th>Vacant</th><th>Fill Ratio</th></tr></thead><tbody></tbody></table>
</div>

</c:if>
</div>

<script>
// ============================================================================
// Dashboard scripts (faithful to the ITI placements source, ITIAP-adapted).
// The source calls masterdata/dashBoardData, masterdata/getAbove20PercentItisStats,
// masterdata/getBelow20PercentItisStats, masterdata/getAbove20PercentItis and
// masterdata/getBelow20PercentItis for these widgets. Those endpoints are not
// implemented in the ITIAP Backend yet, so their callers fail silently (console
// only, no alerts). When the endpoints are added these light up with no page changes.
// ============================================================================
$(function () {
function sbgCall(url, done) {
$.ajax({
type: 'GET',
url: baseUrl + url,
cache: false,
timeout: 600000,
headers: jwtToken ? { 'Authorization': jwtToken } : undefined,
success: done || function () {},
complete: function () { $("#spinnerdiv").hide(); },
error: function (xhr, st, err) { console.log('masterdata/' + url + ' not available:', err); }
});
}

function renderPieChart(data, chartId) {
var ctx = document.getElementById(chartId).getContext('2d');
var chartData = {
labels: ['Filled Seats-' + data.strength_fill, 'Vacant Seats-' + data.strength_vacant],
datasets: [{ data: [data.strength_fill, data.strength_vacant], backgroundColor: ['#36A2EB', '#FF6384'], hoverOffset: 4 }]
};
new Chart(ctx, {
type: 'pie',
data: chartData,
options: {
responsive: true,
maintainAspectRatio: false,
plugins: {
legend: { position: 'top' },
tooltip: {
callbacks: {
label: function (tooltipItem) {
var label = chartData.labels[tooltipItem.dataIndex] || '';
var value = chartData.datasets[0].data[tooltipItem.dataIndex];
return label + ': ' + value;
}
}
}
}
}
});
}

function getPieChartsTotal(response) {
var d = response.dashBoardAllSeats;
renderPieChart(d, 'dashBoardAllSeats');
$("#totaldashBoardAllSeats").empty();
$("#fillrationdashBoardAllSeats").empty();
$("#totaldashBoardAllSeats").append('Total Seats - ' + d.strength.toLocaleString("en-US"));
$("#fillrationdashBoardAllSeats").append('<br>Fill Ratio - ' + d.fill_ratio + '%');
}

function getPieChartsGovt(response) {
var d = response.dashBoardGovtSeats;
renderPieChart(d, 'govtSeatsPieChart');
$("#totalseatsgovtitis").empty();
$("#fillrationgovtitis").empty();
$("#totalseatsgovtitis").append('Total Seats - ' + d.strength.toLocaleString("en-US"));
$("#fillrationgovtitis").append('<br>Fill Ratio - ' + d.fill_ratio + '%');
}

function getPieChartsPvt(response) {
var d = response.dashBoardPvtSeats;
renderPieChart(d, 'pvtSeatsPieChart');
$("#totalseatspvtitis").empty();
$("#fillrationpvtitis").empty();
$("#totalseatspvtitis").append('Total Seats - ' + d.strength.toLocaleString("en-US"));
$("#fillrationpvtitis").append('<br>Fill Ratio - ' + d.fill_ratio + '%');
$("#spinnerdiv").hide();
}

function getPieChartsAbove20(response) {
renderPieChart(response, 'above20PercentPieChart');
$("#above20StrengthFill").empty();
$("#above20FillRatio").empty();
$("#above20NoOfItis").empty();
$("#above20StrengthFill").append('Total Seats - ' + response.strength.toLocaleString("en-US"));
$("#above20FillRatio").append('<br>Fill Ratio - ' + response.fill_ratio + '%');
$("#above20NoOfItis").append('<br><a href="javascript:above20NoOfItis()">No Of ITIs : ' + response.noOfItis + '</a>');
}

function getPieChartsBelow20(response) {
renderPieChart(response, 'below20PercentPieChart');
$("#below20StrengthFill").empty();
$("#below20FillRatio").empty();
$("#below20NoOfItis").empty();
$("#below20StrengthFill").append('Total Seats - ' + response.strength.toLocaleString("en-US"));
$("#below20FillRatio").append('<br>Fill Ratio - ' + response.fill_ratio + '%');
$("#below20NoOfItis").append('<br><a href="javascript:below20NoOfItis();">No Of ITIs : ' + response.noOfItis + '</a>');
}

function fetchDataAndRenderChart() {
sbgCall('masterdata/dashBoardData', function (response) {
getPieChartsTotal(response);
getPieChartsGovt(response);
getPieChartsPvt(response);
});
}

function fetchAbove20PercentData() { sbgCall('masterdata/getAbove20PercentItisStats', getPieChartsAbove20); }
function fetchBelow20PercentData() { sbgCall('masterdata/getBelow20PercentItisStats', getPieChartsBelow20); }

function renderDrillTable(data, heading) {
$("#datadiv").show();
$("#spinnerdiv2").show();
$("#dataheading").empty();
$("#dataheading").append('<h5 class="h5" style="color: blue; font-size: 12px;text-decoration: underline;">' + heading + '</h5>');
$("#tabledata tbody").empty();
var arr = data || [];
for (var i = 0; i < arr.length; i++) {
var bean = arr[i];
$("#tabledata tbody").append('<tr>'
+ '<td>' + (i + 1) + '</td>'
+ '<td>' + bean.dist_name + '</td>'
+ '<td>' + bean.iti_name + '</td>'
+ '<td>' + bean.strength + '</td>'
+ '<td>' + bean.strength_fill + '</td>'
+ '<td>' + bean.strength_vacant + '</td>'
+ '<td>' + bean.fill_ratio + '%</td>'
+ '</tr>');
}
$("#spinnerdiv2").hide();
}

window.below20NoOfItis = function () {
renderDrillTable(window.__belowTable, ' < 20% ADMITTED ITIs DATA ');
};

window.above20NoOfItis = function () {
renderDrillTable(window.__aboveTable, ' >= 20% ADMITTED ITIs DATA ');
};

window.__belowTable = [];
window.__aboveTable = [];
if (String(roleId).trim() !== '4' && String(roleId).trim() !== '3') {
	sbgCall('masterdata/getBelow20PercentItis', function (r) { window.__belowTable = r || []; });
	sbgCall('masterdata/getAbove20PercentItis', function (r) { window.__aboveTable = r || []; });
}

window.fnExcelReport = function (a) {
var table = document.getElementById(a);
if (!table) return;
var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
XLSX.writeFile(wb, 'Report.xlsx');
};

$("#datadiv").hide();
if (String(roleId).trim() !== '4' && String(roleId).trim() !== '3') {
	fetchDataAndRenderChart();
	fetchAbove20PercentData();
	fetchBelow20PercentData();
}
});
</script>

<script>
// ============================================================================
// Role-based service menus (faithful to the source, ITIAP-adapted).
// The original page called masterdata/findByItiCode (JWT-authenticated) and then
// filled #services/#labcard/#inplantcard/#plcmtscard per roleId. In ITIAP there is
// no /masterdata/** route or JWT, so findByItiCode is stubbed to invoke its callback
// immediately with the session roleId. All feature links are href="#"
// (target buttons do nothing) per the instruction; Home/Logout stay functional.
// ============================================================================
$(function () {
window.findByItiCode = function (itiCode, success, error) {
if (typeof success === 'function') success({ govt: '' });
else if (typeof error === 'function') error({ message: 'stub' });
};

function link(text) {
return '<a href="#" class="card-link">' + text + '</a><br>';
}

var r = String(roleId || '').trim();

// Admin (roles 1 & 2) sees nothing - no stats, no menu cards.
if (r === '1' || r === '2') return;

if (r === '3') {
$("#services").empty();
$("#services").append('<h4 class="card-title text-danger">ITI Services</h4>');
$("#services").append('1. ' + link('Change My Password'));
$("#services").append('2. ' + link('Private Students Data Entry'));
$("#services").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#services").append('1. ' + link('Iti Infrastructure Report'));
$("#labcard").empty();
$("#labcard").append('<h4 class="card-title text-danger">LABS</h4>');
$("#inplantcard").empty();
$("#inplantcard").append('<h4 class="card-title text-danger">IN-PLANT</h4>');
$("#inplantcard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#inplantcard").append('1. ' + link('In-Plant Report'));
$("#plcmtscard").empty();
$("#plcmtscard").append('<h4 class="card-title text-danger">PLACEMENTS</h4>');
$("#plcmtscard").append('<h6 class="card-title text-success">Services</h6>');
$("#plcmtscard").append('1. ' + link('Schedule Entry'));
$("#plcmtscard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#plcmtscard").append('2. ' + link('Dist Report'));
} else if (r === '4') {
$("#services").empty();
$("#services").append('<h4 class="card-title text-danger">ITI Services</h4>');
$("#services").append('<h6 class="card-title text-success">Services</h6>');
$("#services").append('1. ' + link('Change My Password'));
$("#services").append('2. ' + link('PRN & APAAR-ID'));
$("#services").append('3. ' + link('ITI INFRASTRUCTURE ENTRY'));
$("#services").append('4. ' + link('EMPLOYEE REGISTRATION'));
$("#services").append('5. ' + link('SELF REPORTING ON INFRA Both Pvt & Govt ITIs'));
$("#services").append('6. ' + link('ITI WISE EMPLOYEE DETAILS'));
$("#services").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#services").append('1. ' + link('PRN & APAAR-ID Report'));
$("#services").append('2. ' + link('ITI INFRASTRUCTURE Report'));
$("#services").append('3. ' + link('EMPLOYEE REGISTRATION Report'));
$("#services").append('4. ' + link('SELF REPORTING ON INFRA Both Pvt & Govt ITIs Report'));
$("#labcard").empty();
$("#labcard").append('<h4 class="card-title text-danger">LABS</h4>');
$("#labcard").append('<h6 class="card-title text-success">Services</h6>');
$("#labcard").append('1. ' + link('Lab Entry'));
$("#labcard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#labcard").append('2. ' + link('Lab Report'));
$("#inplantcard").empty();
$("#inplantcard").append('<h4 class="card-title text-danger">IN-PLANT</h4>');
$("#inplantcard").append('<h6 class="card-title text-success">Services</h6>');
$("#inplantcard").append('1. ' + link('In-Plant Training Entry'));
$("#inplantcard").append('2. ' + link('ITI - Industry Mapping Entry'));
$("#inplantcard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#inplantcard").append('3. ' + link('In-Plant Report'));
$("#plcmtscard").empty();
$("#plcmtscard").append('<h4 class="card-title text-danger">PLACEMENTS</h4>');
$("#plcmtscard").append('<h6 class="card-title text-success">Services</h6>');
$("#plcmtscard").append('1. ' + link('Placements Entry'));
$("#plcmtscard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#plcmtscard").append('2. ' + link('Placements ITI Report'));
} else if (r === '10') {
$("#services").empty();
$("#services").append('<h4 class="card-title text-danger">ITI Services</h4>');
$("#services").append('<h6 class="card-title text-success">Services</h6>');
$("#services").append('1. ' + link('Change My Password'));
$("#services").append('2. ' + link('New User Creation'));
$("#services").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#services").append('1. ' + link('Available Users'));
$("#services").append('2. ' + link('PRN & APAAR-ID Report'));
$("#services").append('3. ' + link('Iti Infrastructure Report'));
$("#services").append('4. ' + link('EMPLOYEE REGISTRATION Report'));
$("#services").append('5. ' + link('SELF REPORTING ON INFRA(Pvt ITIs) Report'));
$("#labcard").empty();
$("#labcard").append('<h4 class="card-title text-danger">LABS</h4>');
$("#labcard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#labcard").append('1. ' + link('Labs Report'));
$("#inplantcard").empty();
$("#inplantcard").append('<h4 class="card-title text-danger">IN-PLANT</h4>');
$("#inplantcard").append('<h6 class="card-title text-success">Services</h6>');
$("#inplantcard").append('1. ' + link('Industry Master Entry'));
$("#inplantcard").append('2. ' + link('Industry Master preview'));
$("#inplantcard").append('3. ' + link('ITI - Industry Mapping Entry'));
$("#inplantcard").append('4. ' + link('Industry Partner Details'));
$("#inplantcard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#inplantcard").append('5. ' + link('In-Plant Report'));
$("#inplantcard").append('6. ' + link('Industry Master Report'));
$("#inplantcard").append('7. ' + link('Industry - ITI Mapping Report'));
$("#inplantcard").append('8. ' + link('Trainees Report'));
$("#inplantcard").append('9. ' + link('Datewise Report'));
$("#inplantcard").append('10. ' + link('One Year &  ITIWise Report'));
$("#inplantcard").append('11. ' + link('Two Years Inplant Training Report'));
$("#inplantcard").append('12. ' + link('Industry Connected Trades Report'));
$("#inplantcard").append('13. ' + link('Industry Not Connected Trades Report'));
$("#inplantcard").append('14. ' + link('12 & 24 Months ITIWise Report'));
$("#inplantcard").append('15. ' + link('District Wise IN-PLANT Report'));
$("#plcmtscard").empty();
$("#plcmtscard").append('<h4 class="card-title text-danger">PLACEMENTS</h4>');
$("#plcmtscard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#plcmtscard").append('1. ' + link('Schedulewise Data'));
$("#plcmtscard").append('2. ' + link('Schedule Datewise Data'));
$("#plcmtscard").append('3. ' + link('State Report'));
$("#plcmtscard").append('4. ' + link('Yearwise Report'));
$("#plcmtscard").append('5. ' + link('State Skill Development Plan Report'));
$("#plcmtscard").append('6. ' + link('Placement Data Details Report'));
} else if (r === '11') {
$("#services").empty();
$("#services").append('<h4 class="card-title text-danger">ITI Services</h4>');
$("#services").append('1. ' + link('Change My Password'));
$("#services").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#services").append('1. ' + link('Iti Infrastructure Report'));
$("#services").append('2. ' + link('EMPLOYEE REGISTRATION Report'));
$("#labcard").empty();
$("#labcard").append('<h4 class="card-title text-danger">LABS</h4>');
$("#labcard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#labcard").append('1. ' + link('Labs Report'));
$("#inplantcard").empty();
$("#inplantcard").append('<h4 class="card-title text-danger">IN-PLANT</h4>');
$("#inplantcard").append('<h6 class="card-title text-success">Services</h6>');
$("#inplantcard").append('1. ' + link('Industry Partner Details'));
$("#inplantcard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#inplantcard").append('1. ' + link('In-Plant Report'));
$("#inplantcard").append('2. ' + link('Industry - ITI Mapping Report'));
$("#inplantcard").append('3. ' + link('Trainees Report'));
$("#inplantcard").append('4. ' + link('Industry Partner Details Report'));
$("#inplantcard").append('5. ' + link('One Year & ITIWise Report'));
$("#inplantcard").append('6. ' + link('Two Years Inplant Training Report'));
$("#inplantcard").append('7. ' + link('Datewise Report'));
$("#inplantcard").append('8. ' + link('Industry Connected Trades Report'));
$("#inplantcard").append('9. ' + link('Industry Not Connected Trades Report'));
$("#inplantcard").append('10. ' + link('12 & 24 Months ITIWise Report'));
$("#inplantcard").append('11. ' + link('District Wise IN-PLANT Report'));
$("#plcmtscard").empty();
$("#plcmtscard").append('<h4 class="card-title text-danger">PLACEMENTS</h4>');
$("#plcmtscard").append('<h6 class="card-title text-success mt-2">Reports</h6>');
$("#plcmtscard").append('1. ' + link('Schedulewise Data'));
$("#plcmtscard").append('2. ' + link('State Report'));
$("#plcmtscard").append('3. ' + link('Yearwise Report'));
$("#plcmtscard").append('4. ' + link('Schedule Datewise Data'));
$("#plcmtscard").append('5. ' + link('Placement Data Details Report'));
} else {
// Unknown role -> generic ITI-level menu (all stubs).
$("#services").empty();
$("#services").append('<h4 class="card-title text-danger">ITI Services</h4>');
$("#services").append('1. ' + link('Change My Password'));
$("#labcard").empty();
$("#labcard").append('<h4 class="card-title text-danger">LABS</h4>');
$("#inplantcard").empty();
$("#inplantcard").append('<h4 class="card-title text-danger">IN-PLANT</h4>');
$("#plcmtscard").empty();
$("#plcmtscard").append('<h4 class="card-title text-danger">PLACEMENTS</h4>');
}
});
</script>
</body>
</html>
