<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>:: ITI ::</title>
        <link rel="shortcut icon" type="image/ico" href="iti.png" />
        <link rel="stylesheet" href="stylesheets/expe1011.css">
        <script type="text/javascript" src="js1/jquery.min.js"></script>
        <style>
            #menu-bar {
                width: 100%;
                margin: 0px;
                padding: 0px;
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
                box-shadow: none;
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
                border-radius: 10px;
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
                border-top-right-radius: 10px;
            }
            #menu-bar ul li:last-child > a {
                border-bottom-left-radius: 10px;
                border-bottom-right-radius: 10px;
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
            .dropdown { position: relative; display: inline-block; }
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                z-index: 1000;
            }
            .dropdown-content a {
                padding: 12px 16px;
                display: block;
            }
            .dropdown:hover .dropdown-content { display: block; }
            #tabcolor { width: calc(100% - 40px); max-width: 1200px; margin: 0 auto; border-collapse: collapse; padding: 0 20px; }
            #tabcolor tr.bg-green td { background-color: green; color: white; padding: 8px; }
            #tabcolor tr.bg-green td[colspan="2"] { text-align: center; }
        </style>
    </head>
    <body>

        <script>
            var tableToExcel = (function() {
                var uri = 'data:application/vnd.ms-excel;base64,'
                        , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
                        , base64 = function(s) {
                            return window.btoa(unescape(encodeURIComponent(s)))
                        }
                        , format = function(s, c) {
                            return s.replace(/{(\w+)}/g, function(m, p) {
                                return c[p];
                            })
                        }
                return function(table, name) {
                    if (!table.nodeType)
                        table = document.getElementById(table)
                    var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
                    window.location.href = uri + base64(format(template, ctx))
                }
            })();
        </script>

        <center>
            <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
        </center>

        <ul id="menu-bar">
            <li>
                <a href="${pageContext.request.contextPath}/">Home</a>
            </li>
            <li class="dropdown">
                <a href="javascript:void(0)">ITI Profile</a>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/reports/itiprofile">ITI Profile</a>
                    <a href="${pageContext.request.contextPath}/reports/Jdgetdasboardreport">ITI LIST</a>
                </div>
            </li>
            <li>
                <a>STRIVE</a>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/aboutstrive.jsp">ABOUT STRIVE</a></li>
                    <li><a href="${pageContext.request.contextPath}/disclosuremanagement.jsp">Disclosure Management</a></li>
                </ul>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/placements">PLACEMENTS / IN-PLANT TRAINING</a>
            </li>
        </ul>

        <br><br>

        <marquee onmouseover="this.stop();" onmouseout="this.start();" scrolldelay="100">
            <b>
            <font color="blue" size="5">
                <a href="#" target="_blank"> ITI Admissions Phase registrations, applications, and verifications are open. </a>
            </font>
            </b>
        </marquee>

        <h1 align="center"><strong>List of ITI's with Trades & Strengths in ${param.dist_code}</strong></h1>
        <h2 align="center"><b><font color="brown">Click on ITI Name to view the ITI profile and staff details</font></b></h2>

        <div id="loader" style="display: none; text-align: center; padding: 20px;">
            <img src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..." style="width: 40px; height: 40px;" />
            <p>Loading ITI data...</p>
        </div>

        <table align="center" border="1" id="tabcolor" bgcolor="#e4eeb9" style="width: calc(100% - 40px); max-width: 1200px; margin: 20px auto;">
            <tbody id="itiTableBody">
                <tr class="bg-green"><td colspan="2">&nbsp;</td></tr>
                <tr><td colspan="2" style="text-align: center; padding: 20px; font-weight: bold;">Loading...</td></tr>
                <tr class="bg-green"><td colspan="2">&nbsp;</td></tr>
            </tbody>
        </table>

        <div align="center" id="excelBtn" style="display: none; margin-top: 15px;">
            <input type="button" onclick="tableToExcel('tabcolor', 'iti')" value="For Excel Sheet Download" />
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const urlParams = new URLSearchParams(window.location.search);
                const distCode = urlParams.get('dist_code') || '';
                const govType = urlParams.get('gov') || '';

                if (!distCode) {
                    const tbody = document.getElementById('itiTableBody');
                    const headerRow = tbody.querySelector('tr.bg-green:first-child');
                    const footerRow = tbody.querySelector('tr.bg-green:last-child');
                    tbody.innerHTML = '';
                    if (headerRow) tbody.appendChild(headerRow);
                    const noDistRow = document.createElement('tr');
                    noDistRow.innerHTML = '<td colspan="2" style="text-align: center; padding: 20px; font-weight: bold;">No district selected.</td>';
                    tbody.appendChild(noDistRow);
                    if (footerRow) tbody.appendChild(footerRow);
                    return;
                }

                document.getElementById('loader').style.display = 'block';

                let url = '${backendApiUrl}/trade-display/itis?dist=' + encodeURIComponent(distCode);
                if (govType && govType !== '') {
                    url += '&type=' + encodeURIComponent(govType);
                }

                fetch(url, { method: 'GET' })
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('loader').style.display = 'none';
                        document.getElementById('excelBtn').style.display = 'block';

                        const tbody = document.getElementById('itiTableBody');
                        const headerRow = tbody.querySelector('tr.bg-green:first-child');
                        const footerRow = tbody.querySelector('tr.bg-green:last-child');
                        tbody.innerHTML = '';

                        if (headerRow) tbody.appendChild(headerRow);

                        if (data.error) {
                            const errorRow = document.createElement('tr');
                            errorRow.innerHTML = '<td colspan="2" style="text-align: center; padding: 20px; font-weight: bold; color: red;">Error: ' + data.error + '</td>';
                            tbody.appendChild(errorRow);
                            if (footerRow) tbody.appendChild(footerRow);
                            return;
                        }

                        if (data.data && data.data.length > 0) {
                            data.data.forEach(row => {
                                const tr = document.createElement('tr');
                                let tradesHtml = '';
                                if (row.trades && row.trades.length > 0) {
                                    tradesHtml = '<ol style="margin: 0; padding-left: 20px;">';
                                    row.trades.forEach(trade => {
                                        tradesHtml += '<li style="margin-bottom: 4px;">' + (trade.tradeName || '-') + ' (' + (trade.strength || 0) + ')</li>';
                                    });
                                    tradesHtml += '</ol>';
                                } else {
                                    tradesHtml = '<p style="color: #999; font-style: italic; margin: 0;">No trades listed</p>';
                                }
                                const code = row.code || '';
                                const itiName = row.itiName || '-';

                                tr.innerHTML =
                                    '<td><a href="Iti_Registration_Report.jsp?iti_code=' +
                                    encodeURIComponent(code) +
                                    '">' + code + ' :- ' + itiName +
                                    '</a></td>' +
                                    '<td>' + tradesHtml + '</td>';
                                tbody.appendChild(tr);
                            });
                        } else {
                            const noDataRow = document.createElement('tr');
                            noDataRow.innerHTML = '<td colspan="2" style="text-align: center; padding: 20px; font-weight: bold;">No ITI records found for the selected district.</td>';
                            tbody.appendChild(noDataRow);
                        }

                        if (footerRow) tbody.appendChild(footerRow);
                    })
                    .catch(error => {
                        document.getElementById('loader').style.display = 'none';
                        const tbody = document.getElementById('itiTableBody');
                        const headerRow = tbody.querySelector('tr.bg-green:first-child');
                        const footerRow = tbody.querySelector('tr.bg-green:last-child');
                        tbody.innerHTML = '';
                        if (headerRow) tbody.appendChild(headerRow);
                        const errorRow = document.createElement('tr');
                        errorRow.innerHTML = '<td colspan="2" style="text-align: center; padding: 20px; font-weight: bold; color: red;">Error loading data: ' + error.message + '</td>';
                        tbody.appendChild(errorRow);
                        if (footerRow) tbody.appendChild(footerRow);
                        console.error('Error:', error);
                    });
            });
        </script>
    </body>
</html>