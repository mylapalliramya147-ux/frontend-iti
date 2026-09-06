<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IN-PLANT Trainees Report</title>
<link href="${pageContext.request.contextPath}/bootstrap-5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/bootstrap-5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/siteScript.js"></script>
<script src="${pageContext.request.contextPath}/js/xlsx.full.min.js"></script>
<script>
var jwtToken = '<%= session.getAttribute("jwtToken") != null ? session.getAttribute("jwtToken") : "" %>';
var insCode = '<%= session.getAttribute("insCode") != null ? session.getAttribute("insCode") : "" %>';
var baseUrl = '${pageContext.request.contextPath}/';
</script>
</head>
<body>

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">

<script>
$(document).ready(function(){
    var username = '<%= session.getAttribute("username") != null ? session.getAttribute("username") : "" %>';
    var insName = '<%= session.getAttribute("insName") != null ? session.getAttribute("insName") : "" %>';
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;
});
</script>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/placements/loginSuccess">
        <i class="fas fa-home"></i> Home
    </a>
    <div class="text-white fw-bold">
        Welcome :
        <span id="userinfo"></span>
    </div>
    <div>
        <a href="${pageContext.request.contextPath}/placements/logout" class="btn btn-danger">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>
</nav>

<div class="container border p-2 mt-2 shadow-lg">
    <div align="center" style="text-decoration: underline; color: fuchsia;">Inplant Report</div>
    <div class="row">
        <div class="col-md-3">
            <label for="year">Year :</label>
            <select id="year" class="form-control">
                <option value="" selected disabled>Select Year</option>
                <option value="2026">2026</option>
                <option value="2025">2025</option>
                <option value="2024">2024</option>
                <option value="2023">2023</option>
                <option value="2022">2022</option>
                <option value="2021">2021</option>
                <option value="2020">2020</option>
                <option value="2019">2019</option>
                <option value="2018">2018</option>
                <option value="2017">2017</option>
                <option value="2016">2016</option>
            </select>
        </div>
        <div class="col-md-3">
            <label for="itiType">ITI Type :</label>
            <select id="itiType" class="form-control">
                <option value="" selected disabled>Select ITI Type</option>
                <option value="A">Aided</option>
                <option value="M">Minority</option>
                <option value="L">Local</option>
            </select>
        </div>
        <div class="col-md-3">
            <button class="btn btn-sm btn-success mt-4" onclick="return getData();">GET DATA</button>
        </div>
    </div>
</div>

<div class="container-fluid border p-2 mt-2 shadow-lg">
    <div align="center" style="text-decoration: underline;color: fuchsia;">IPT-INPLANT TRAINEE TRAINING REPORT</div>
    <button onclick="fnExcelReport('reporttable');" class="btn btn-info btn-sm">DOWNLOAD EXCEL</button>
    <div align="center" id="spinnerdiv" style="display: none;">
        <span>Data is Loading...</span>
        <div class="spinner-border" role="status"></div>
    </div>
    <table class="table table-bordered" id="reporttable" style="display:none;">
        <thead>
            <tr>
                <th>S.NO</th><th>DISTRICT</th><th>ITI</th><th>ITI CODE</th>
                <th>TRAINEE ADMITTED</th><th>COMPLETED</th><th>UNDER TRAINING</th><th>BALANCE</th>
            </tr>
        </thead>
        <tbody id="tablebody"></tbody>
    </table>
    <div align="center" id="emptydatamsg" style="display:none;color: red;">--- NO DATA FOUND ---</div>
</div>

<script>
function getData(){
    var y=$('#year').val(), t=$('#itiType').val();
    if(!y||!t){alert('Please select Year and ITI Type.');return false;}
    $('#spinnerdiv').show();$('#reporttable,#emptydatamsg').hide();
    $.ajax({type:'GET',url:baseUrl+'api/implant/yearwise-report?year='+y+'&itiType='+t,
    headers:{'Authorization':'Bearer '+jwtToken},
    success:function(d){$('#spinnerdiv').hide();if(!d||!d.length){$('#emptydatamsg').show();return;}
    var h='';d.forEach(function(r,i){h+='<tr><td>'+(i+1)+'</td><td>'+(r.district_name||'')+'</td><td>'+(r.iti_name||'')+'</td><td>'+(r.iti_code||'')+'</td><td>'+(r.trainee_admitted||0)+'</td><td>'+(r.completed||0)+'</td><td>'+(r.under_training||0)+'</td><td>'+(r.balance||0)+'</td></tr>';});
    $('#tablebody').html(h);$('#reporttable').show();},
    error:function(x){$('#spinnerdiv').hide();alert(x.responseJSON?x.responseJSON.message:'Failed');}});
    return false;}
function fnExcelReport(tid){var wb=XLSX.utils.table_to_book(document.getElementById(tid),{sheet:'Report'});XLSX.writeFile(wb,'Inplant_Yearwise_Report.xlsx');}
</script>
</body>
</html>