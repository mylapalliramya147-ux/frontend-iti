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

    <!-- Search Form -->
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
                        <option value='' <c:if test="${empty param.dist_code}">selected</c:if>>--select--</option>
                        <option value='25' <c:if test="${param.dist_code eq '25'}">selected</c:if>>Alluri Sitaramaraju</option>
                        <option value='24' <c:if test="${param.dist_code eq '24'}">selected</c:if>>Anakapalli</option>
                        <option value='22' <c:if test="${param.dist_code eq '22'}">selected</c:if>>Anantapur</option>
                        <option value='33' <c:if test="${param.dist_code eq '33'}">selected</c:if>>Annamayya</option>
                        <option value='32' <c:if test="${param.dist_code eq '32'}">selected</c:if>>Bapatla</option>
                        <option value='23' <c:if test="${param.dist_code eq '23'}">selected</c:if>>Chittoor</option>
                        <option value='14' <c:if test="${param.dist_code eq '14'}">selected</c:if>>East Godavari</option>
                        <option value='29' <c:if test="${param.dist_code eq '29'}">selected</c:if>>Eluru</option>
                        <option value='17' <c:if test="${param.dist_code eq '17'}">selected</c:if>>Guntur</option>
                        <option value='27' <c:if test="${param.dist_code eq '27'}">selected</c:if>>Kakinada</option>
                        <option value='28' <c:if test="${param.dist_code eq '28'}">selected</c:if>>Konaseema</option>
                        <option value='16' <c:if test="${param.dist_code eq '16'}">selected</c:if>>Krishna</option>
                        <option value='21' <c:if test="${param.dist_code eq '21'}">selected</c:if>>Kurnool</option>
                        <option value='38' <c:if test="${param.dist_code eq '38'}">selected</c:if>>Markapuram</option>
                        <option value='34' <c:if test="${param.dist_code eq '34'}">selected</c:if>>Nandyal</option>
                        <option value='19' <c:if test="${param.dist_code eq '19'}">selected</c:if>>Nellore</option>
                        <option value='30' <c:if test="${param.dist_code eq '30'}">selected</c:if>>NTR</option>
                        <option value='31' <c:if test="${param.dist_code eq '31'}">selected</c:if>>Palnadu</option>
                        <option value='26' <c:if test="${param.dist_code eq '26'}">selected</c:if>>Parvathipuram-Manyam</option>
                        <option value='37' <c:if test="${param.dist_code eq '37'}">selected</c:if>>Polavaram</option>
                        <option value='18' <c:if test="${param.dist_code eq '18'}">selected</c:if>>Prakasam</option>
                        <option value='11' <c:if test="${param.dist_code eq '11'}">selected</c:if>>Srikakulam</option>
                        <option value='35' <c:if test="${param.dist_code eq '35'}">selected</c:if>>Sri Satyasai</option>
                        <option value='36' <c:if test="${param.dist_code eq '36'}">selected</c:if>>Tirupati</option>
                        <option value='13' <c:if test="${param.dist_code eq '13'}">selected</c:if>>Visakhapatnam</option>
                        <option value='12' <c:if test="${param.dist_code eq '12'}">selected</c:if>>Vizianagaram</option>
                        <option value='15' <c:if test="${param.dist_code eq '15'}">selected</c:if>>West Godavari</option>
                        <option value='20' <c:if test="${param.dist_code eq '20'}">selected</c:if>>YSR</option>
                    </select> 
                </td>
            </tr>
            <tr>
                <td>GOVT/PVT</td>
                <td>
                    <select name="gov" id="gov">
                        <option value="" <c:if test="${empty param.gov}">selected</c:if>>----ALL----</option>
                        <option value="G" <c:if test="${param.gov eq 'G'}">selected</c:if>>GOVERNMENT</option>
                        <option value="P" <c:if test="${param.gov eq 'P'}">selected</c:if>>PRIVATE</option>
                    </select>
                </td>
            </tr>
            <tr bgcolor="green">
                <td colspan="2" align="center"><input type="submit" value="Submit" /></td>
            </tr>
        </table>
    </form>

    <!-- Results Section -->
    <h1 align="center"><strong> List of ITI's with Trades & Strengths in <span id="distNameHeading"></span> </strong></h1>
    <h2 align="center"><b> <font color="brown"> Click on ITI Name to view the ITI profile and staff details </font></b> </h2>

    <div id="loader" align="center" style="display: none; padding: 20px; font-weight: bold; color: blue;">
        Loading ITI records...
    </div>

    <table align="center" bgcolor="#ffffcc" id="tabcolor" border="1" style="min-width: 650px; border-collapse: collapse; margin-bottom: 15px;">
        <thead>
            <tr bgcolor="green">
                <td colspan="2">&nbsp;</td>
            </tr>
        </thead>
        <tbody id="itiTableBody">
            <tr>
                <td colspan="2" align="center" style="padding: 15px; font-weight: bold; color: #555;">Loading...</td>
            </tr>
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

    <script>
        const BACKEND_URL = "${backendApiUrl}";

        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const distCode = "${param.dist_code}" || urlParams.get('dist_code') || '';
            const govType = "${param.gov}" || urlParams.get('gov') || '';

            const distSelect = document.getElementById('dist_code');
            if (distCode) {
                distSelect.value = distCode;
                const distName = distSelect.options[distSelect.selectedIndex] ? distSelect.options[distSelect.selectedIndex].text : distCode;
                document.getElementById('distNameHeading').innerText = distName;
                fetchItiData(distCode, govType);
            } else {
                document.getElementById('distNameHeading').innerText = 'Selected District';
                document.getElementById('itiTableBody').innerHTML = '<tr><td colspan="2" align="center" style="padding: 15px; font-weight: bold;">Please select a district.</td></tr>';
            }
        });

        function fetchItiData(distCode, govType) {
            document.getElementById('loader').style.display = 'block';

            let url = BACKEND_URL + '/trade-display/itis?dist=' + encodeURIComponent(distCode);
            if (govType) {
                url += '&type=' + encodeURIComponent(govType);
            }

            fetch(url)
                .then(res => res.json())
                .then(resData => {
                    document.getElementById('loader').style.display = 'none';
                    const list = (resData && resData.data) ? resData.data : [];
                    const tbody = document.getElementById('itiTableBody');
                    tbody.innerHTML = '';

                    if (list.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="2" align="center" style="padding: 15px; font-weight: bold; color: red;">No ITI records found for the selected district.</td></tr>';
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
                    document.getElementById('itiTableBody').innerHTML = '<tr><td colspan="2" align="center" style="padding: 15px; font-weight: bold; color: red;">Error loading data: ' + err.message + '</td></tr>';
                });
        }
    </script>

    <%@ include file="../footer.jsp" %>
</body>
</html>
