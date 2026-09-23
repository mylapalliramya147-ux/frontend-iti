<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>:: ITI  ::</title>
    <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/images/iti.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

    <script>
        var tableToExcel = (function() {
            var uri = 'data:application/vnd.ms-excel;base64,',
                template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
                base64 = function(s) {
                    return window.btoa(unescape(encodeURIComponent(s)))
                },
                format = function(s, c) {
                    return s.replace(/{(\w+)}/g, function(m, p) {
                        return c[p];
                    })
                };
            return function(table, name) {
                if (!table.nodeType)
                    table = document.getElementById(table);
                var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML};
                window.location.href = uri + base64(format(template, ctx));
            }
        })();
    </script>
</head>

<body>
    <!-- Top Banner -->
    <center>
        <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner">
    </center>

    <!-- Navigation Bar -->
    <%@ include file="../navbars/index_navbar.jsp" %>

    <br><br>

    <!-- Marquee -->
    <marquee onmouseover="this.stop();" onmouseout="this.start();" scrolldelay="100">
        <b>
            <font color="blue" size="5">
                <a href="" target="_blank">
                    ITI Admissions 2026 Phase -6 registrations, applications and verifications available in all GovtPvts ITIs on 17-09-2026 to 22-09-2026.
                </a>
            </font>
        </b>
    </marquee>

    <p>&nbsp;</p>

    <!-- Filter Form -->
    <form name="form1" id="form1" method="POST" action="${pageContext.request.contextPath}/reports/trade-display2">
        <p align="center" class="style4"> 
            <font color="blue" size="4">
                List of ITI's with Trades & Strengths Interface
            </font>
        </p>

        <table align="center" border="1" id="AutoNumber1" bgcolor="#e4eeb9">
            <tr>
                <td><span class="style52">Select District : </span></td>
                <td width="148">
                    <select name="dist_code" id="dist_code" class="style52">
                        <option value='' selected>--select--</option>
                        <option value='25'>Alluri Sitaramaraju</option>
                        <option value='24'>Anakapalli</option>
                        <option value='22'>Anantapur</option>
                        <option value='33'>Annamayya</option>
                        <option value='32'>Bapatla</option>
                        <option value='23'>Chittoor</option>
                        <option value='14'>East Godavari</option>
                        <option value='29'>Eluru</option>
                        <option value='17'>Guntur</option>
                        <option value='27'>Kakinada</option>
                        <option value='28'>Konaseema</option>
                        <option value='16'>Krishna</option>
                        <option value='21'>Kurnool</option>
                        <option value='38'>Markapuram</option>
                        <option value='34'>Nandyal</option>
                        <option value='19'>Nellore</option>
                        <option value='30'>NTR</option>
                        <option value='31'>Palnadu</option>
                        <option value='26'>Parvathipuram-Manyam</option>
                        <option value='37'>Polavaram</option>
                        <option value='18'>Prakasam</option>
                        <option value='11'>Srikakulam</option>
                        <option value='35'>Sri Satyasai</option>
                        <option value='36'>Tirupati</option>
                        <option value='13'>Visakhapatnam</option>
                        <option value='12'>Vizianagaram</option>
                        <option value='15'>West Godavari</option>
                        <option value='20'>YSR</option>
                    </select> 
                </td>
            </tr>
            <tr>
                <td>GOVT/PVT</td>
                <td>
                    <select name="gov" id="gov">
                        <option value="">----ALL----</option>
                        <option value="G">GOVERNMENT</option>
                        <option value="P">PRIVATE</option>
                    </select>
                </td>
            </tr>
            <tr bgcolor="green">
                <td colspan="2" align="center"><input type="submit" value="Submit" /></td>
            </tr>
        </table>
    </form>

    <!-- Results Section -->
    <div id="resultsSection" style="display: none; margin-top: 25px; margin-bottom: 50px;">
        <h1 align="center"><strong> List of ITI's with Trades & Strengths in <span id="distNameSpan"></span> </strong></h1>
        <h2 align="center"><b> <font color="brown"> Click on ITI Name to view the ITI profile and staff details </font></b> </h2>

        <div id="loader" align="center" style="display: none; padding: 20px; font-weight: bold; color: blue;">
            Loading ITI records...
        </div>

        <table align="center" bgcolor="#ffffcc" id="tabcolor" border="1" style="min-width: 650px; border-collapse: collapse;">
            <thead>
                <tr bgcolor="green">
                    <td colspan="2">&nbsp;</td>
                </tr>
            </thead>
            <tbody id="itiTableBody">
            </tbody>
            <tfoot>
                <tr bgcolor="green">
                    <td colspan="2">&nbsp;</td>
                </tr>
            </tfoot>
        </table>

        <div align="center" style="margin-top: 15px; margin-bottom: 25px;">
            <input type="button" align="center" onclick="tableToExcel('tabcolor', 'iti')" value="For Excel Sheet Download">
        </div>
    </div>

    <script>
        const BACKEND_URL = "${backendApiUrl}";

        function submitForm() {
            const distSelect = document.getElementById('dist_code');
            const distCode = distSelect.value;
            const distName = distSelect.options[distSelect.selectedIndex].text;
            const govType = document.getElementById('gov').value;

            if (!distCode) {
                alert('Please select a district.');
                return;
            }

            document.getElementById('distNameSpan').innerText = distName;
            document.getElementById('resultsSection').style.display = 'block';
            document.getElementById('loader').style.display = 'block';

            const tbody = document.getElementById('itiTableBody');
            tbody.innerHTML = '';

            let url = BACKEND_URL + '/trade-display/itis?dist=' + encodeURIComponent(distCode);
            if (govType) {
                url += '&type=' + encodeURIComponent(govType);
            }

            fetch(url)
                .then(res => res.json())
                .then(resData => {
                    document.getElementById('loader').style.display = 'none';
                    const list = (resData && resData.data) ? resData.data : [];

                    if (list.length === 0) {
                        const tr = document.createElement('tr');
                        tr.innerHTML = '<td colspan="2" align="center" style="padding: 15px; font-weight: bold; color: red;">No ITI records found for the selected district.</td>';
                        tbody.appendChild(tr);
                        return;
                    }

                    list.forEach(row => {
                        const tr = document.createElement('tr');
                        const code = row.code || '';
                        const name = row.itiName || '-';

                        let tradesHtml = '<ol>';
                        if (row.trades && row.trades.length > 0) {
                            row.trades.forEach(t => {
                                tradesHtml += '<li> ' + (t.tradeName || '-') + ' (' + (t.strength || 0) + ')</li>';
                            });
                        } else {
                            tradesHtml += '<li>No trades listed</li>';
                        }
                        tradesHtml += '</ol>';

                        tr.innerHTML = 
                            '<td>' +
                                '<a href="${pageContext.request.contextPath}/iti-details?itiCode=' + encodeURIComponent(code) + '">' +
                                    code + '  :-  ' + name +
                                '</a>' +
                                tradesHtml +
                            '</td>';

                        tbody.appendChild(tr);
                    });
                })
                .catch(err => {
                    document.getElementById('loader').style.display = 'none';
                    const tr = document.createElement('tr');
                    tr.innerHTML = '<td colspan="2" align="center" style="padding: 15px; font-weight: bold; color: red;">Error loading data: ' + err.message + '</td>';
                    tbody.appendChild(tr);
                });
        }

        // Auto-load if navigated with query params (e.g. ?dist_code=23&gov=G)
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const dist = urlParams.get('dist_code');
            const gov = urlParams.get('gov');
            if (dist) {
                document.getElementById('dist_code').value = dist;
                if (gov) document.getElementById('gov').value = gov;
                submitForm();
            }
        });
    </script>

    <%@ include file="../footer.jsp" %>
</body>
</html>