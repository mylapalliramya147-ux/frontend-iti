<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set
    var="backendBaseUrl"
    value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}"
    scope="page"
/>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>12 & 24 Months ITIWise Report</title>

    <!-- Bootstrap -->
    <link
        href="${pageContext.request.contextPath}/css/bootstrap.min.css"
        rel="stylesheet"
    >

    <!-- Font Awesome -->
    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/fontawesome.all.min.css"
    >

    <!-- jQuery -->
    <script
        src="${pageContext.request.contextPath}/js/jquery.min.js">
    </script>

    <!-- Bootstrap JS -->
    <script
        src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js">
    </script>

    <!-- XLSX -->
    <script
        src="${pageContext.request.contextPath}/js/xlsx.full.min.js">
    </script>


    <script>

        var username = '<c:out value="${sessionScope.username}" default="" />';
        var insCode  = '<c:out value="${sessionScope.insCode}" default="" />';
        var baseUrl  = '${backendBaseUrl}/';


        $(document).ready(function () {
            if (username) {
                document.getElementById('userinfo').innerHTML =
                    "<i class='fas fa-user'></i> " + username +
                    " | <i class='fas fa-id-badge'></i> " + insCode;
            }
        });

    </script>

</head>

<body>

    <!-- Banner Image -->
    <img
        alt="banner"
        src="${pageContext.request.contextPath}/images/gen.jpg"
        class="img-fluid border border-dark rounded-1"
        style="width: 100%;"
    >

    <!-- Navbar -->
    <%@ include file="../portal_navbar.jsp" %>

<div class="container border p-2 mt-2 shadow-lg">
    <div align="center">
        <a
            href="${pageContext.request.contextPath}/implant/twoyearwisereport"
            style="text-decoration: underline; color: fuchsia;"
        >Inplant Two Years Report</a>
    </div>
    <div class="row">
        <div class="col-md-3">
            <label for="year">Current Year :</label>
            <select id="year" class="form-control">
                <option value="" selected disabled>Select Year</option>
                <option value="2026" selected>2026</option>
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
                <option value="G">Govt</option>
                <option value="P">Pvt</option>
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
function esc(v){return v==null?'':String(v).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;').replace(/'/g,'&#39;');}
function getData(){
    var y=$('#year').val(), t=$('#itiType').val();
    if(!y||!t){alert('Please select Current Year and ITI Type.');return false;}
    $('#spinnerdiv').show();$('#reporttable,#emptydatamsg').hide();$('#tablebody').empty();
    $.ajax({
        type:'GET',
        url:baseUrl+'api/implant/twelve-24-months-itiwise-report?year='+encodeURIComponent(y)+'&itiType='+encodeURIComponent(t),
        success:function(d){
            $('#spinnerdiv').hide();
            if(!d||!d.length){$('#emptydatamsg').show();return;}
            var h='';
            d.forEach(function(r,i){
                h+='<tr>'+
                    '<td>'+(i+1)+'</td>'+
                    '<td>'+esc(r.districtName||r.district_name||r.dist_name||'')+'</td>'+
                    '<td>'+esc(r.itiName||r.iti_name||'')+'</td>'+
                    '<td>'+esc(r.itiCode||r.iti_code||'')+'</td>'+
                    '<td>'+(r.traineeAdmitted||r.trainee_admitted||0)+'</td>'+
                    '<td>'+(r.completed||0)+'</td>'+
                    '<td>'+(r.underTraining||r.under_training||0)+'</td>'+
                    '<td>'+(r.balance||0)+'</td>'+
                '</tr>';
            });
            $('#tablebody').html(h);$('#reporttable').show();
        },
        error:function(x){
            $('#spinnerdiv').hide();
            var msg='Failed to load data.';
            if(x.responseJSON&&x.responseJSON.message)msg=x.responseJSON.message;
            alert(msg);
        }
    });
    return false;
}
function fnExcelReport(tid){
    var y=$('#year').val()||'ALL';
    var t=$('#itiType').val()==='G'?'Govt':($('#itiType').val()==='P'?'Pvt':'ALL');
    var wb=XLSX.utils.table_to_book(document.getElementById(tid),{sheet:'Report'});
    XLSX.writeFile(wb,'Inplant_12_24_Months_ITIWise_Report_'+y+'_'+t+'.xlsx');
    return false;
}
</script>
</body>
</html>