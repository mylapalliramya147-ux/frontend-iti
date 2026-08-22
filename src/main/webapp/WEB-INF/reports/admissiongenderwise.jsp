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
    </style>
</head>
<body>
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>

    <br>
    <div align="center">
        <font size="4" color="blue" id="pageTitle">Admission Report</font>
    </div>
    <br>

    <form method="get" action="${pageContext.request.contextPath}/reports/admissiongenderwise" id="filterForm">
        <table align="center" border="1" bgcolor="#e4eeb9">
            <tr>
                <td>
                    <label for="year">Select Year :</label>
                    <select name="year" id="year" required>
                        <option value="">Select Year</option>
                        <option value='' selected>--select--</option>
                        <option value='2019'>2019</option><option value='2020'>2020</option>
                        <option value='2021'>2021</option><option value='2022'>2022</option>
                        <option value='2023'>2023</option><option value='2024'>2024</option>
                        <option value='2025'>2025</option><option value='2026'>2026</option>
                    </select>
                    &nbsp;&nbsp;&nbsp;
                    <label for="cast_type">Select Cast Type :</label>
                    <select name="cast_type" id="cast_type">
                        <option value="">Select Cast</option>
                        <option value="OC">OC</option>
                        <option value="BC">BC</option>
                        <option value="SC">SC</option>
                        <option value="ST">ST</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="pwd">Select PWD :</label>
                    <input type="radio" name="pwd" value="t" id="pwd_yes"> Yes
                    <input type="radio" name="pwd" value="f" id="pwd_no"> No
                </td>
            </tr>
            <tr>
                <td align="center">
                    <input type="submit" name="submit" value="submit" style="background-color: #ff6666; color: black; font-weight: bold;"/>
                </td>
            </tr>
        </table>
    </form>

    <br>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Loading admission report...</p>
    </div>

    <div id="wrapper" style="display: none;">
        <div class="content">
            <div align="center">
                <table align="center" border="2" width="70%" id="tot" bgcolor="#e4eeb9">
                    <thead>
                        <p align="center" class="style4">
                            <font color="blue" size="4" id="yearTitle">For Year: 2026</font>
                        </p>
                        <tr>
                            <td><b>#</b></td>
                            <td><b>Trade Name</b></td>
                            <td><b>Boys</b></td>
                            <td><b>Girls</b></td>
                            <td><b>Total</b></td>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                    <tfoot id="tableFoot"></tfoot>
                </table>
            </div>
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
        function fnExcelReport() {
            var tab_text = "<table border='1px'><tr bgcolor='#87AFC6'>";
            var tab = document.getElementById('tot');
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
                sa = txtArea1.document.execCommand("SaveAs", true, "TradeWiseReport.xls");
            } else {
                sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));
            }
            return sa;
        }

        function printpage() {
            var printButton = document.getElementById("printpagebutton");
            var navmenu = document.getElementById("banner-id");
            var banner = document.getElementById("menu-bar");
            var foot = document.getElementById("footer");
            document.getElementById("tot").style.width = "100%";
            printButton.style.visibility = 'hidden';
            navmenu.style.display = 'none';
            banner.style.display = 'none';
            foot.style.display = 'none';
            window.print();
            printButton.style.visibility = 'visible';
            navmenu.style.display = 'block';
            banner.style.display = 'block';
            foot.style.display = 'block';
            document.getElementById("tot").style.width = "60%";
        }

        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const year = urlParams.get('year');
            const caste = urlParams.get('cast_type') || 'All';
            const pwd = urlParams.get('pwd') || 'All';

            if (year) {
                document.getElementById('year').value = year;
                document.getElementById('yearTitle').innerText = 'For Year: ' + year;
                loadReport(year, caste, pwd);
            }
        });

        document.getElementById('filterForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const year = document.getElementById('year').value;
            const caste = document.getElementById('cast_type').value || 'All';
            const pwd = document.querySelector('input[name="pwd"]:checked');
            const pwdVal = pwd ? (pwd.value === 't' ? 'Yes' : 'No') : 'All';

            if (!year) {
                alert('Please select a year');
                return;
            }

            const url = '${pageContext.request.contextPath}/reports/admissiongenderwise?year=' + encodeURIComponent(year) + '&cast_type=' + encodeURIComponent(caste) + '&pwd=' + encodeURIComponent(pwdVal);
            window.location.href = url;
        });

        function loadReport(year, caste, pwd) {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('wrapper').style.display = 'none';

            let apiUrl = '${backendApiUrl}/admission-report?year=' + encodeURIComponent(year);
            if (caste && caste !== 'All') {
                apiUrl += '&caste=' + encodeURIComponent(caste);
            }
            if (pwd && pwd !== 'All') {
                apiUrl += '&pwd=' + encodeURIComponent(pwd);
            }

            fetch(apiUrl, { method: 'GET' })
            .then(response => response.json())
            .then(response => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('wrapper').style.display = 'block';

                const tbody = document.getElementById('tableBody');
                const tfoot = document.getElementById('tableFoot');
                tbody.innerHTML = ''; tfoot.innerHTML = '';

                const data = response.data || [];
                if (data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                    return;
                }

                let totalBoys = 0, totalGirls = 0, grandTotal = 0;

                data.forEach((row, index) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (index + 1) + '</td>' +
                        '<td style="text-align: left;">' + (row.tradeName || '-') + '</td>' +
                        '<td class="num">' + (row.boys || 0) + '</td>' +
                        '<td class="num">' + (row.girls || 0) + '</td>' +
                        '<td class="num">' + (row.total || 0) + '</td>';
                    tbody.appendChild(tr);

                    totalBoys += row.boys || 0;
                    totalGirls += row.girls || 0;
                    grandTotal += row.total || 0;
                });

                const ft = document.createElement('tr');
                ft.style.fontWeight = '800';
                ft.style.backgroundColor = '#e2e8f0';
                ft.innerHTML = '<td colspan="2" style="text-align: right; padding-right: 20px;">Total</td>' +
                    '<td class="num">' + totalBoys + '</td>' +
                    '<td class="num">' + totalGirls + '</td>' +
                    '<td class="num">' + grandTotal + '</td>';
                tfoot.appendChild(ft);
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('wrapper').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html>
