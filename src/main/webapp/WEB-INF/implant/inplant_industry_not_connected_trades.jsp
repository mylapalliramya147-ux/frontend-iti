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

    <title>Industry Not Connected Trades Report</title>

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

            document.getElementById("userinfo").innerHTML =
                "<i class='fas fa-user'></i> " +
                username +
                " | " +
                "<i class='fas fa-id-badge'></i> " +
                insCode;

            /* Load report data automatically on page load. */
            getData();

        });

    </script>


    <style>

        #reporttable th,
        #reporttable td {
            vertical-align: middle;
        }

        #reporttable thead th,
        #reporttable thead td {
            position: sticky;
            top: 0;
            background-color: black;
            color: white;
            z-index: 2;
        }

        #reporttable {
            width: 100%;
        }

    </style>

</head>


<body>

    <!-- Banner -->
    <img
        alt="banner"
        src="${pageContext.request.contextPath}/images/gen.jpg"
        style="
            border: 1px solid black;
            width: 100%;
            border-radius: 2px;
        "
    >


    <!-- Navigation Bar -->
    <%@ include file="../navbars/portal_navbar.jsp" %>


<div class="container-fluid border p-2 mt-2 shadow-lg">
    <div align="center" style="text-decoration: underline;color: fuchsia;">Industry Not Connected Trades Report</div>
    <button onclick="fnExcelReport();" class="btn btn-info btn-sm">DOWNLOAD EXCEL</button>
    <div align="center" id="spinnerdiv" style="display: none;">
        <span>Data is Loading...</span>
        <div class="spinner-border" role="status"></div>
    </div>
    <table class="table table-bordered" id="reporttable" style="display:none;">
        <thead>
            <tr>
                <th>S.No</th><th>District</th><th>ITI Code</th><th>ITI Name</th>
                <th>Trade</th><th>Total Trainees</th><th>Industry Name</th>
            </tr>
        </thead>
        <tbody id="tablebody"></tbody>
    </table>
    <div align="center" id="emptydatamsg" style="display:none;color: red;">--- NO DATA FOUND ---</div>
</div>

<script>
function esc(v){return v==null?'':String(v).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;').replace(/'/g,'&#39;');}
function getData(){
    $('#spinnerdiv').show();$('#reporttable,#emptydatamsg').hide();$('#tablebody').empty();
    $.ajax({
        type:'GET',
        url:baseUrl+'api/implant/industry-not-connected-trades',
        success:function(d){
            $('#spinnerdiv').hide();
            if(!d||!d.length){$('#emptydatamsg').show();return;}
            var h='';
            d.forEach(function(r,i){
                h+='<tr>'+
                    '<td>'+(i+1)+'</td>'+
                    '<td>'+esc(r.district_name)+'</td>'+
                    '<td>'+esc(r.iti_code)+'</td>'+
                    '<td>'+esc(r.iti_name)+'</td>'+
                    '<td>'+esc(r.trade_name)+'</td>'+
                    '<td>'+(r.total_trainees==null?0:r.total_trainees)+'</td>'+
                    '<td>'+esc(r.industry_name)+'</td>'+
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
    var wb=XLSX.utils.table_to_book(document.getElementById('reporttable'),{sheet:'Report'});
    XLSX.writeFile(wb,'INPLANT_INDUSTRY_NOT_CONNECTED_TRADES.xlsx');
    return false;
}
</script>
</body>
</html>
