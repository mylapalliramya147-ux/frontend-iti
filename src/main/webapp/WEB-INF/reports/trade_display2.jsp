<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>:: ITI ::</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
        <link rel="shortcut icon" type="image/ico" href="iti.png" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <style>
            #tabcolor { width: calc(100% - 40px); max-width: 1200px; margin: 0 auto; border-collapse: collapse; padding: 0 20px; }
            #tabcolor tr.bg-green td { background-color: green; color: white; padding: 8px; }
            #tabcolor tr.bg-green td[colspan="2"] { text-align: center; }
        </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
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
                    <a href="${pageContext.request.contextPath}/reports/itilist">ITI LIST</a>
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