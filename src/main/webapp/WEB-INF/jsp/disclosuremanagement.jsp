<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>STRIVE</title>
    <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/iti.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css" />
    <style>
        #menu-bar {
            list-style: none;
            margin: 0;
            padding: 0;
            background-color: #E1F5A9;
            text-align: left;
            font-family: Arial, Helvetica, sans-serif;
            border-bottom: 2px solid #996633;
        }
        #menu-bar > li {
            display: inline-block;
            position: relative;
            margin: 0;
        }
        #menu-bar > li > a {
            display: block;
            padding: 10px 20px;
            color: #000000;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
        }
        #menu-bar > li > a:hover {
            background-color: #996633;
            color: #FFFFFF;
        }
        #menu-bar li ul {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #FFFFFF;
            list-style: none;
            margin: 0;
            padding: 0;
            min-width: 200px;
            z-index: 1000;
            border: 1px solid #996633;
        }
        #menu-bar li:hover ul {
            display: block;
        }
        #menu-bar li ul li {
            display: block;
        }
        #menu-bar li ul li a {
            display: block;
            padding: 8px 16px;
            color: #000000;
            text-decoration: none;
            font-size: 14px;
            border-bottom: 1px solid #E1F5A9;
        }
        #menu-bar li ul li a:hover {
            background-color: #E1F5A9;
            color: #000000;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        table th,
        table td {
            border: 1px solid #CCCCCC;
            padding: 6px 8px;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
</head>
<body>
    <div style="text-align: center;">
        <img src="${pageContext.request.contextPath}/images/Banner.jpg" id="banner-id" style="width:100%; height:auto;" alt="Banner" />
    </div>

    <ul id="menu-bar">
        <li><a href="${pageContext.request.contextPath}/login">Home</a></li>
        <li>
            <a href="javascript:void(0);">STRIVE</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/reports/about-strive">ABOUT STRIVE</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/disclosure-management">Disclosure Management</a></li>
            </ul>
        </li>
        <li>
            <a href="https://itiadmissions.ap.gov.in/placementsfe/" target="_blank">PLACEMENTS / IN-PLANT TRAINING</a>
        </li>
    </ul>

    <br /><br />

    <marquee onmouseover="this.stop();" onmouseout="this.start();" scrolldelay="100">
        <span style="font-weight: bold; color: blue; font-size: 20px;">
            <a href="#" target="_blank">
                <c:choose>
                    <c:when test="${not empty announcementText}">
                        ${announcementText}
                    </c:when>
                    <c:otherwise>
                        ITI Admissions 2026 Phase -1 for Student Registrations, Apply for ITI and Verifications has started and will end on 02/07/2026 5PM.
                    </c:otherwise>
                </c:choose>
            </a>
        </span>
    </marquee>

    <br />
    <h2 style="text-align: center; font-weight: bold; text-decoration: underline; color: #0057AF;">
        Skills Strengthening of Industrial Value Enhancement (STRIVE) Project in State of Andhra Pradesh
    </h2>
    <br />

    <table>
        <thead>
            <tr style="background:#0057AF; color:white;">
                <th style="text-align: center; width: 10%;">SNO</th>
                <th style="text-align: center; width: 60%;">Disclosures Management</th>
                <th style="text-align: center; width: 30%;">Category Links</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td rowspan="3" style="text-align: right;">1</td>
                <td rowspan="3">Approved Procurement Plan and updates</td>
                <td><a href="javascript:void(0);" onclick="iti_display();">Goods</a></td>
            </tr>
            <tr>
                <td>Services</td>
            </tr>
            <tr>
                <td>Works</td>
            </tr>
            
            <tr>
                <td rowspan="3" style="text-align: right;">2</td>
                <td rowspan="3">Invitation for Bids</td>
                <td><a href="javascript:void(0);" onclick="iti_display();">Goods</a></td>
            </tr>
            <tr>
                <td>Services</td>
            </tr>
            <tr>
                <td>Works</td>
            </tr>
            
            <tr>
                <td rowspan="3" style="text-align: right;">3</td>
                <td rowspan="3">Short list of consultants/Bidders</td>
                <td><a href="javascript:void(0);" onclick="iti_display();">Goods</a></td>
            </tr>
            <tr>
                <td>Services</td>
            </tr>
            <tr>
                <td>Works</td>
            </tr>
            
            <tr>
                <td rowspan="3" style="text-align: right;">4</td>
                <td rowspan="3">Contract Awards</td>
                <td><a href="javascript:void(0);" onclick="iti_display();">Goods</a></td>
            </tr>
            <tr>
                <td>Services</td>
            </tr>
            <tr>
                <td>Works</td>
            </tr>
            
            <tr>
                <td rowspan="3" style="text-align: right;">5</td>
                <td rowspan="3">Contract Awards</td>
                <td><a href="javascript:void(0);" onclick="iti_display();">Goods</a></td>
            </tr>
            <tr>
                <td>Action taken reports & Complaints</td>
            </tr>
            <tr>
                <td>Works</td>
            </tr>
        </tbody>
    </table>

    <br />

    <div style="display:none;" id="display_itis">
        <table>
            <thead>
                <tr style="background:#0057AF; color:white;">
                    <th colspan="3" style="text-align: center;">LISTS OF STRIVE ITI'S in AP</th>
                </tr>
                <tr style="background:#0057AF; color:white;">
                    <th style="text-align: center;">SNO</th>
                    <th style="text-align: center;">ITI MIS CODE</th>
                    <th style="text-align: center;">Name of the ITI</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty itiList}">
                    <c:forEach var="iti" items="${itiList}" varStatus="iterStat">
                        <tr>
                            <td style="text-align: center;">${iterStat.count}</td> 
                            <td>${iti.misCode}</td> 
                            <td>
                                <c:choose>
                                    <c:when test="${fn:contains(iti.pdfPath, '.jsp') or fn:startsWith(iti.pdfPath, 'http')}">
                                        <a href="${iti.pdfPath}" 
                                           <c:if test="${fn:contains(iti.pdfPath, '.jsp')}">target="_self"</c:if>
                                           <c:if test="${not fn:contains(iti.pdfPath, '.jsp')}">target="_blank"</c:if>>${iti.name}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/SPMU/Goods/${iti.pdfPath}" target="_blank">${iti.name}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td> 
                        </tr>
                    </c:forEach>
                </c:if>

                <c:if test="${empty itiList}">
                    <tr>
                        <td style="text-align: center;">1</td> 
                        <td>GR28000416</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/1Rajam.pdf" target="_blank">GOVT ITI RAJAM</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">2</td> 
                        <td>GR28000154</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/1Bobbili.pdf" target="_blank">GOVT ITI BOBBLLI</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">3</td> 
                        <td>GU28000144</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/1Vizag(O).pdf" target="_blank">GOVT.ITI VISKHAPATNM</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">4</td> 
                        <td>GR28000238</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/2KAKINADA.pdf" target="_blank">GOVT.ITI KAKINADA</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">5</td> 
                        <td>GR28000123</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/2Bhimavaram.pdf" target="_blank">GOVT.ITI BHIMAVARAM</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">6</td> 
                        <td>GR28000151</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/2Vijayawaa.pdf" target="_blank">GOVT.ITI VIJAYAWADA</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">7</td> 
                        <td>GR28000206</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/3Tenali.pdf" target="_blank">GOVT.ITI TENALI</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">8</td> 
                        <td>GR28000155</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/3Ongole(B).pdf" target="_blank">GOVT.ITI ONGOLE(B)</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">9</td> 
                        <td>GR28000270</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/3Nellore(G).pdf" target="_blank">GOVTITI NELLORE(G)</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">10</td> 
                        <td>GR28000145</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/3Nellore(B).pdf" target="_blank">GOVT.ITI NELLORE(B)</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">11</td> 
                        <td>GR28000308</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/3Tada.pdf" target="_blank">GOVT.ITI TADA</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">12</td> 
                        <td>GR28000041</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/4srisailem.pdf" target="_blank">GOVT.ITI SRISAILEM</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">13</td> 
                        <td>GR28000335</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/4CHITTOOR.pdf" target="_blank">GOVT.ITI CHITTOOR</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">14</td> 
                        <td>GR28000182</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/4Thirupathi.pdf" target="_blank">GOVT.ITI TIRUPATHI</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">15</td> 
                        <td>GR28000386</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU/Goods/4Chakrayapeta..pdf" target="_blank">GOVT.ITI CHKRYAPETA</a></td> 
                    </tr>
                    <tr>
                        <td style="text-align: center;">16</td> 
                        <td>State Project Implementation Unit (SPIU)</td> 
                        <td><a href="${pageContext.request.contextPath}/SPMU.jsp">Directorate of Employment and Training, Vijayawada</a></td> 
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <script>
        function iti_display() {
            var displayDiv = document.getElementById("display_itis");
            if(displayDiv) {
                displayDiv.style.display = "block";
                displayDiv.scrollIntoView({ behavior: 'smooth' });
            }
        }
    </script>
</body>
</html>