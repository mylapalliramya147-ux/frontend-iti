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
        .slno-col { width: 60px; }
        .district-col { text-align: left; }
    </style>
</head>
<body>
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>

    <br>
    <div align="center">
        <font size="4" color="blue" id="pageTitle">Phase Wise Admissions Details</font>
    </div>
    <br>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Loading report...</p>
    </div>

    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        <div class="text-right px-4 mb-3" id="downloadSection" style="display: none;">
            <input type="button" value="Excel Download" class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="tableToExcel('tot', 'PhaseWiseAdmissions')">
        </div>
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="tot" style="min-width: 1000px;">
                    <thead>
                        <tr>
                            <th class="slno-col">Sl No</th>
                            <th class="district-col">District Name</th>
                            <th class="num">Phase I</th>
                            <th class="num">Phase II</th>
                            <th class="num">Phase III</th>
                            <th class="num">Phase IV</th>
                            <th class="num">Phase V</th>
                            <th class="num">Total</th>
                            <th class="num">Today</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                    <tfoot id="tableFoot"></tfoot>
                </table>
            </div>
        </div>
    </div>

    <div id="footer">
        2013 @ All Rights Reserved &nbsp;&nbsp; Designed by &nbsp; National Informatics Center
        <font color="white"><a href="http://www.ap.nic.in" title="">National Informatics Center </a></font>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <font color="white"><a href="disclaimer.jsp">Disclaimer</a></font>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        function tableToExcel(tableID, name = '') {
            var table = document.getElementById(tableID);
            var html = table.outerHTML;
            var blob = new Blob(['\ufeff', html], { type: "application/vnd.ms-excel" });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = name + '.xls';
            a.click();
            URL.revokeObjectURL(url);
        }

        function formatDate(date) {
            const d = new Date(date);
            const day = String(d.getDate()).padStart(2, '0');
            const month = String(d.getMonth() + 1).padStart(2, '0');
            const year = d.getFullYear();
            return day + '-' + month + '-' + year;
        }

        document.addEventListener('DOMContentLoaded', function() {
            fetch('${backendApiUrl}/current-admission-phase')
                .then(r => r.json())
                .then(config => {
                    const year = config.year || String(new Date().getFullYear());
                    document.getElementById('pageTitle').innerText = 'Phase Wise Admissions Details - Year ' + year;
                    loadReport(year);
                })
                .catch(err => {
                    console.error('Failed to load current phase:', err);
                    document.getElementById('pageTitle').innerText = 'Phase Wise Admissions Details';
                    loadReport(String(new Date().getFullYear()));
                });
        });

        function loadReport(year) {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('reportView').style.display = 'none';

            fetch('${backendApiUrl}/phase-wise?year=' + encodeURIComponent(year), { method: 'GET' })
            .then(response => response.json())
            .then(response => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                document.getElementById('downloadSection').style.display = 'block';

                const tbody = document.getElementById('tableBody');
                const tfoot = document.getElementById('tableFoot');
                tbody.innerHTML = ''; tfoot.innerHTML = '';

                const data = response.data || [];
                if (data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="9" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                    return;
                }

                let totals = { phaseI: 0, phaseII: 0, phaseIII: 0, phaseIV: 0, phaseV: 0, total: 0, today: 0 };

                data.forEach((row, index) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (index + 1) + '</td>' +
                        '<td class="district-col">' + (row.distName || '-') + '</td>' +
                        '<td class="num">' + (row.phaseI || 0) + '</td>' +
                        '<td class="num">' + (row.phaseII || 0) + '</td>' +
                        '<td class="num">' + (row.phaseIII || 0) + '</td>' +
                        '<td class="num">' + (row.phaseIV || 0) + '</td>' +
                        '<td class="num">' + (row.phaseV || 0) + '</td>' +
                        '<td class="num">' + (row.total || 0) + '</td>' +
                        '<td class="num">' + (row.today || 0) + '</td>';
                    tbody.appendChild(tr);

                    totals.phaseI += row.phaseI || 0; totals.phaseII += row.phaseII || 0; totals.phaseIII += row.phaseIII || 0;
                    totals.phaseIV += row.phaseIV || 0; totals.phaseV += row.phaseV || 0; totals.total += row.total || 0; totals.today += row.today || 0;
                });

                const ft = document.createElement('tr');
                ft.style.fontWeight = '800';
                ft.style.backgroundColor = '#e2e8f0';
                ft.innerHTML = '<td colspan="2" style="text-align: right; padding-right: 20px;">Total</td>' +
                    '<td class="num">' + totals.phaseI + '</td>' +
                    '<td class="num">' + totals.phaseII + '</td>' +
                    '<td class="num">' + totals.phaseIII + '</td>' +
                    '<td class="num">' + totals.phaseIV + '</td>' +
                    '<td class="num">' + totals.phaseV + '</td>' +
                    '<td class="num">' + totals.total + '</td>' +
                    '<td class="num">' + totals.today + '</td>';
                tfoot.appendChild(ft);
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html>
