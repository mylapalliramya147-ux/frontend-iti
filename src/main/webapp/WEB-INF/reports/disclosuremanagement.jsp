<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Disclosure Management | ITI Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>Disclosure Management</h2></div>
    <div class="container mt-4">
        <div class="nodal-report-card shadow-lg" style="border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;">
                <i class="fas fa-shield-alt me-2"></i> Disclosure Management
            </div>
            <div class="p-5 bg-white rounded-bottom">
                <div class="no-print d-flex justify-content-center gap-3 mb-4">
                    <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="toggleITIs()">
                        <i class="fas fa-list me-2"></i>View STRIVE ITI List
                    </button>
                    <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                        <i class="fas fa-print me-2"></i>PRINT
                    </button>
                </div>

                <div class="report-view-wrapper">
                    <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
                        <div style="overflow-y: auto; max-height: 600px;">
                            <table class="table table-bordered mb-0 table-hover text-center report-table" style="min-width: 900px;">
                                <thead>
                                    <tr style="background: #0f2c4e;">
                                        <th style="width: 6%">SNO</th>
                                        <th style="width: 40%">Disclosures Management</th>
                                        <th style="width: 24%">Category Links</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td rowspan="3" class="num">1</td>
                                        <td rowspan="3">Approved Procurement Plan and updates</td>
                                        <td><a href="javascript:void(0);" onclick="toggleITIs()" class="text-decoration-none">Goods</a></td>
                                    </tr>
                                    <tr>
                                        <td>Services</td>
                                    </tr>
                                    <tr>
                                        <td>Works</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="3" class="num">2</td>
                                        <td rowspan="3">Invitation for Bids</td>
                                        <td><a href="javascript:void(0);" onclick="toggleITIs()" class="text-decoration-none">Goods</a></td>
                                    </tr>
                                    <tr>
                                        <td>Services</td>
                                    </tr>
                                    <tr>
                                        <td>Works</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="3" class="num">3</td>
                                        <td rowspan="3">Short list of consultants/Bidders</td>
                                        <td><a href="javascript:void(0);" onclick="toggleITIs()" class="text-decoration-none">Goods</a></td>
                                    </tr>
                                    <tr>
                                        <td>Services</td>
                                    </tr>
                                    <tr>
                                        <td>Works</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="3" class="num">4</td>
                                        <td rowspan="3">Contract Awards</td>
                                        <td><a href="javascript:void(0);" onclick="toggleITIs()" class="text-decoration-none">Goods</a></td>
                                    </tr>
                                    <tr>
                                        <td>Services</td>
                                    </tr>
                                    <tr>
                                        <td>Works</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="3" class="num">5</td>
                                        <td rowspan="3">Action taken reports &amp; Complaints</td>
                                        <td><a href="javascript:void(0);" onclick="toggleITIs()" class="text-decoration-none">Goods</a></td>
                                    </tr>
                                    <tr>
                                        <td>Services</td>
                                    </tr>
                                    <tr>
                                        <td>Works</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div style="display: none;" id="display_itis" class="mt-5">
                    <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
                        <div style="overflow-y: auto; max-height: 500px;">
                            <table class="table table-bordered mb-0 table-hover text-center report-table" style="min-width: 700px;">
                                <thead>
                                    <tr style="background: #0f2c4e;">
                                        <th colspan="3">LISTS OF STRIVE ITI'S in AP</th>
                                    </tr>
                                    <tr>
                                        <th>SNO</th>
                                        <th>ITI MIS CODE</th>
                                        <th>Name of the ITI</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty itiList}">
                                        <tr>
                                            <td class="num">1</td>
                                            <td>GR28000416</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/1Rajam.pdf" target="_blank" class="text-decoration-none">GOVT ITI RAJAM</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">2</td>
                                            <td>GR28000154</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/1Bobbili.pdf" target="_blank" class="text-decoration-none">GOVT ITI BOBBLI</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">3</td>
                                            <td>GU28000144</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/1Vizag(O).pdf" target="_blank" class="text-decoration-none">GOVT. ITI VISAKHAPATNAM</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">4</td>
                                            <td>GR28000238</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/2Kakinada.pdf" target="_blank" class="text-decoration-none">GOVT. ITI KAKINADA</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">5</td>
                                            <td>GR28000123</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/2Bhimavaram.pdf" target="_blank" class="text-decoration-none">GOVT. ITI BHIMAVARAM</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">6</td>
                                            <td>GR28000151</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/2Vijayawada.pdf" target="_blank" class="text-decoration-none">GOVT. ITI VIJAYAWADA</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">7</td>
                                            <td>GR28000206</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/3Tenali.pdf" target="_blank" class="text-decoration-none">GOVT. ITI TENALI</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">8</td>
                                            <td>GR28000155</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/3OngoleB.pdf" target="_blank" class="text-decoration-none">GOVT. ITI ONGOLE(B)</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">9</td>
                                            <td>GR28000270</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/3NelloreG.pdf" target="_blank" class="text-decoration-none">GOVT. ITI NELLORE(G)</a></td>
                                        </tr>
                                        <tr>
                                            <td class="num">10</td>
                                            <td>GR28000145</td>
                                            <td class="text-start"><a href="${pageContext.request.contextPath}/SPMU/Goods/3NelloreB.pdf" target="_blank" class="text-decoration-none">GOVT. ITI NELLORE(B)</a></td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${not empty itiList}">
                                        <c:forEach var="iti" items="${itiList}" varStatus="iterStat">
                                            <tr>
                                                <td class="num">${iterStat.count}</td>
                                                <td>${iti.misCode}</td>
                                                <td class="text-start">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(iti.pdfPath, '.jsp') or fn:startsWith(iti.pdfPath, 'http')}">
                                                            <a href="${iti.pdfPath}"
                                                               <c:if test="${fn:contains(iti.pdfPath, '.jsp')}">target="_self"</c:if>
                                                               <c:if test="${not fn:contains(iti.pdfPath, '.jsp')}">target="_blank"</c:if>
                                                               class="text-decoration-none">${iti.name}</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/SPMU/Goods/${iti.pdfPath}" target="_blank" class="text-decoration-none">${iti.name}</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-5">
                    <a href="${pageContext.request.contextPath}/reports/" class="btn btn-outline-secondary px-4 rounded-pill fw-bold">
                        <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleITIs() {
            const div = document.getElementById('display_itis');
            div.style.display = div.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</body>
</html>
