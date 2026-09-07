<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>:: ITI ::</title>
    <link rel="shortcut icon" type="image/ico" href="iti.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        #menu-bar {
            width: 100%;
            margin: 0px 0px 0px 0px;
            padding: 0px 0px 0px 0px;
            height: 30px;
            line-height: 100%;
            border-radius: 0px;
            -webkit-border-radius: 24px;
            -moz-border-radius: 24px;
            box-shadow: 2px 2px 2px #666666;
            -webkit-box-shadow: 2px 2px 2px #666666;
            -moz-box-shadow: 2px 2px 2px #666666;
            background: #e4eeb9;
            position: relative;
            z-index: 999;
        }
        #menu-bar li {
            margin: 0px 0px 6px 0px;
            padding: 0px 6px 0px 6px;
            float: left;
            position: relative;
            list-style: none;
        }
        #menu-bar a {
            font-weight: bold;
            font-family: verdana;
            font-size: 14px;
            color: #000000;
            background: #e4eeb9;
            text-decoration: none;
            display: block;
            padding: 6px 20px 6px 20px;
            margin: 0;
            margin-bottom: 6px;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
        }
        #menu-bar li ul li a { margin: 0; }
        #menu-bar .active a, #menu-bar li:hover > a {
            background: blue;
            background: lightblue;
            background: -ms-linear-gradient(top, #EB4954, #A19197);
            background: -webkit-gradient(linear, left top, left bottom, from(#EB4954), to(#A19197));
            background: -moz-linear-gradient(top, #EB4954, #A19197);
            color: white;
            -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
            -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
            box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
        }
        #menu-bar ul li:hover a, #menu-bar li:hover li a {
            background: lightgoldenrodyellow;
            color: #000000;
            -box-shadow: none;
            -webkit-box-shadow: none;
            -moz-box-shadow: none;
        }
        #menu-bar ul a:hover {
            background: lightblue !important;
            color: black !important;
            border-radius: 0;
            -webkit-border-radius: 0;
            -moz-border-radius: 0;
        }
        #menu-bar li:hover > ul { display: block; }
        #menu-bar ul {
            background: block;
            background: linear-gradient(top, #FFD21C, #CF7688);
            background: -ms-linear-gradient(top, #FFD21C, #CF7688);
            background: -webkit-gradient(linear, left top, left bottom, from(#FFD21C), to(#CF7688));
            background: -moz-linear-gradient(top, #FFD21C, #CF7688);
            display: none;
            margin: 0;
            padding: 0;
            width: 300px;
            position: absolute;
            top: 30px;
            left: 0;
            border-radius: 0px;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            -webkit-box-shadow: 2px 2px 3px #222222;
            -moz-box-shadow: 2px 2px 3px #222222;
            box-shadow: 2px 2px 3px #222222;
        }
        #menu-bar ul li {
            float: none;
            margin: 0;
            padding: 0;
        }
        #menu-bar ul a {
            padding: 10px 0px 10px 15px;
            background: gold;
            color: grey;
            font-size: 13px;
            font-style: normal;
            font-family: verdana;
            font-weight: normal;
            text-shadow: 2px 2px 3px #FFFFFF;
        }
        #menu-bar ul li:first-child > a {
            border-top-left-radius: 10px;
            -webkit-border-top-left-radius: 10px;
            -moz-border-radius-topleft: 10px;
            border-top-right-radius: 10px;
            -webkit-border-top-right-radius: 10px;
            -moz-border-radius-topright: 10px;
        }
        #menu-bar ul li:last-child > a {
            border-bottom-left-radius: 10px;
            -webkit-border-bottom-left-radius: 10px;
            -moz-border-radius-bottomleft: 10px;
            border-bottom-right-radius: 10px;
            -webkit-border-bottom-right-radius: 10px;
            -moz-border-radius-bottomright: 10px;
        }
        #menu-bar:after {
            content: ".";
            display: block;
            clear: both;
            visibility: hidden;
            line-height: 0;
            height: 0;
        }
        #menu-bar { display: inline-block; }
        html[xmlns] #menu-bar { display: block; }
        * html #menu-bar { height: 1%; }
        #footer {
            position: fixed;
            bottom: 0px;
            width: 100%;
            height: 25px;
            padding-top: 8px;
            text-align: center;
            background-color: #0E4878;
            border-top: 1px #000000 solid;
            font-size: 12px;
            font-family: arial, verdana;
            color: #ffffff;
        }
        #disttable { float: left; margin-left: 2%; }
        #dist { float: left; margin-left: 3%; }
        #iti { float: left; margin-left: 3%; }
        .report-table th {
            font-size: 12px;
            padding: 12px 5px;
            background: #0f2c4e !important;
            color: white !important;
            text-transform: uppercase;
        }
        .report-table td {
            font-size: 13px;
            padding: 10px 5px;
            border-bottom: 1px solid #f0f0f0;
            font-weight: 500;
            color: #1e293b;
        }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .num { text-align: center; font-weight: 700 !important; }
    </style>
</head>
<body>
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>

    <br>
    <div align="center">
        <font size="4" color="blue" id="pageTitle">Applicant Report Dist Wise</font>
    </div>
    <br>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Loading report...</p>
    </div>

    <div id="root" style="display: none;">
        <div id="disttable">
            <font color="blue" size="4">DistrictWise Govt & Pvt</font>
            <input type="button" value="Excel Download" onclick="fnExcelReport('tabcolor', 'DistrictWise_GovtPvt')"/>
            <table align="center" border="1" id="tabcolor" bgcolor="#e4eeb9">
                <thead>
                    <tr style="color:white;background:#0057AF">
                        <td>Sno</td>
                        <td>District Name</td>
                        <td>Count</td>
                    </tr>
                </thead>
                <tbody id="tbodyAll"></tbody>
                <tfoot id="footAll"></tfoot>
            </table>
        </div>

        <div id="dist">
            <font color="blue" size="4">DistWise for Govt</font>
            <input type="button" value="Excel Download" onclick="fnExcelReport('govt', 'DistWise_Govt')"/>
            <table align="center" border="1" id="govt" bgcolor="#e4eeb9">
                <thead>
                    <tr style="color:white;background:#0057AF">
                        <td>Sno</td>
                        <td>District Name</td>
                        <td>Count</td>
                    </tr>
                </thead>
                <tbody id="tbodyGovt"></tbody>
                <tfoot id="footGovt"></tfoot>
            </table>
        </div>

        <div id="iti">
            <font color="blue" size="4">DistWise for Private</font>
            <input type="button" value="Excel Download" onclick="fnExcelReport('pvt', 'DistWise_Pvt')"/>
            <table align="center" border="1" id="pvt" bgcolor="#e4eeb9">
                <thead>
                    <tr style="color:white;background:#0057AF">
                        <td>Sno</td>
                        <td>District Name</td>
                        <td>Count</td>
                    </tr>
                </thead>
                <tbody id="tbodyPvt"></tbody>
                <tfoot id="footPvt"></tfoot>
            </table>
        </div>
    </div>

    <br><br><br><br>

    <div id="footer">
        2013 @ All Rights Reserved &nbsp;&nbsp; Designed by &nbsp; National Informatics Center
        <font color="white"><a href="http://www.ap.nic.in" title="">National Informatics Center </a></font>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <font color="white"><a href="disclaimer.jsp">Disclaimer</a></font>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        function fnExcelReport(tableId, fileName) {
            var tab = document.getElementById(tableId);
            var tab_text = "<table border='1px'><tr bgcolor='#87AFC6'>";
            for (var j = 0; j < tab.rows.length; j++) {
                tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
            }
            tab_text = tab_text + "</table>";
            tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");
            tab_text = tab_text.replace(/<img[^>]*>/gi, "");
            tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, "");
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");
            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
                txtArea1.document.open("txt/html", "replace");
                txtArea1.document.write(tab_text);
                txtArea1.document.close();
                txtArea1.focus();
                sa = txtArea1.document.execCommand("SaveAs", true, fileName + ".xls");
            } else {
                sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));
            }
            return sa;
        }

        function renderTable(tbodyId, footId, data, totalLabel) {
            const tbody = document.getElementById(tbodyId);
            const foot = document.getElementById(footId);
            tbody.innerHTML = '';
            foot.innerHTML = '';

            if (!data || data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="3" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                return;
            }

            let total = 0;
            data.forEach((row, index) => {
                const tr = document.createElement('tr');
                tr.innerHTML = '<td>' + (index + 1) + '</td><td style="text-align: left;">' + (row.distName || '-') + '</td><td class="num">' + (row.count || 0) + '</td>';
                tbody.appendChild(tr);
                total += row.count || 0;
            });

            const ft = document.createElement('tr');
            ft.style.fontWeight = '800';
            ft.style.backgroundColor = '#0057AF';
            ft.style.color = 'white';
            ft.innerHTML = '<td colspan="2" style="text-align: right; padding-right: 20px;">' + totalLabel + '</td><td class="num">' + total + '</td>';
            foot.appendChild(ft);
        }

        document.addEventListener('DOMContentLoaded', function() {
            fetch('${backendApiUrl}/current-admission-phase')
                .then(r => r.json())
                .then(config => {
                    const year = config.year || String(new Date().getFullYear());
                    const phase = config.phase || '';
                    document.getElementById('pageTitle').innerText = 'Total Applicant\'s Count in Phase ' + (phase || '');
                    loadReport(year, phase);
                })
                .catch(err => {
                    console.error('Failed to load current phase:', err);
                    document.getElementById('pageTitle').innerText = 'Total Applicant\'s Count in Phase';
                    loadReport(String(new Date().getFullYear()), '');
                });
        });

        function loadReport(year, phase) {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('root').style.display = 'none';

            const allPromise = fetch('${backendApiUrl}/applicant-count-district-wise?year=' + encodeURIComponent(year) + '&distCode=All&govt=All&phase=' + encodeURIComponent(phase)).then(r => r.json());
            const govtPromise = fetch('${backendApiUrl}/applicant-count-district-wise?year=' + encodeURIComponent(year) + '&distCode=All&govt=G&phase=' + encodeURIComponent(phase)).then(r => r.json());
            const pvtPromise = fetch('${backendApiUrl}/applicant-count-district-wise?year=' + encodeURIComponent(year) + '&distCode=All&govt=P&phase=' + encodeURIComponent(phase)).then(r => r.json());

            Promise.all([allPromise, govtPromise, pvtPromise])
                .then(([allRes, govtRes, pvtRes]) => {
                    document.getElementById('loader').style.display = 'none';
                    document.getElementById('root').style.display = 'block';

                    renderTable('tbodyAll', 'footAll', allRes.data || [], 'Total');
                    renderTable('tbodyGovt', 'footGovt', govtRes.data || [], 'Total');
                    renderTable('tbodyPvt', 'footPvt', pvtRes.data || [], 'Total');
                })
                .catch(error => {
                    document.getElementById('loader').style.display = 'none';
                    document.getElementById('root').style.display = 'block';
                    alert('Error loading data: ' + error.message);
                    console.error('Error:', error);
                });
        }
    </script>
</body>
</html>
