<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trade Duration Seats Abstract | ITI Admissions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <style>
        body {
            background-color: #e0effd !important;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* --- DASHBOARD NAVBAR --- */
        .nodal-dashboard-navbar {
            background: #002244;
            padding: 0;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 2.5rem;
        }
        .nodal-dashboard-link {
            padding: 18px 25px;
            color: rgba(255, 255, 255, 0.7) !important;
            text-decoration: none;
            font-size: 0.72rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.25s ease;
            border-bottom: 4px solid transparent;
        }
        .nodal-dashboard-link:hover {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.05);
        }
        .nodal-dashboard-link.active {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.1);
            border-bottom-color: #ffd700;
        }

        /* --- TITLE --- */
        .custom-page-title {
            color: #003366;
            font-weight: 800;
            text-align: center;
            margin: 40px 0 20px;
            font-size: 1.6rem;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.3;
        }

        /* --- BUTTONS --- */
        .btn-excel-grey {
            background-color: #f8fafc;
            color: #4b5563;
            font-weight: 800;
            padding: 10px 30px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            text-transform: uppercase;
            font-size: 0.8rem;
            transition: all 0.2s;
            margin-bottom: 30px;
        }
        .btn-excel-grey:hover {
            background-color: #f1f5f9;
            color: #1f2937;
            border-color: #9ca3af;
        }

        /* --- TABLE --- */
        .report-container {
            max-width: 1200px;
            margin: 0 auto;
            padding-bottom: 50px;
        }
        .nodal-report-card {
            border: 2px solid #003366;
            border-radius: 8px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 10px 25px rgba(0, 51, 102, 0.1);
        }
        .nodal-table {
            width: 100%;
            border-collapse: collapse;
        }
        .nodal-table th {
            background-color: #003366;
            color: #ffffff;
            font-weight: 800;
            text-transform: uppercase;
            font-size: 0.85rem;
            padding: 15px;
            border: 1px solid #1a4a72;
            text-align: center;
        }
        .nodal-table td {
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            text-align: center;
            font-size: 0.95rem;
        }
        
        .trade-code {
            font-weight: 700;
            color: #1e293b;
        }
        .trade-name {
            text-align: left !important;
            padding-left: 25px !important;
            font-weight: 800;
            color: #000000;
        }
        .stat-strength { font-weight: 700; color: #1e293b; }
        .stat-fill { font-weight: 700; color: #1a4a72; }
        .stat-vacant { font-weight: 700; color: #1e293b; }
        .stat-percentage { font-weight: 700; color: #1e293b; }

        .back-container {
            margin-top: 40px;
            text-align: center;
            padding-bottom: 60px;
        }
    </style>
</head>
<body>
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    
    <c:set var="activeTab" value="trade_duration" />
    <%@ include file="nodal_navbar.jsp" %>
    
    <div class="report-container">
        <h2 class="custom-page-title">
            <c:choose>
                <c:when test="${duration == 'All'}">All Durations</c:when>
                <c:otherwise>${duration} Months</c:otherwise>
            </c:choose> 
            Trade Seats Abstract In 
            <c:choose>
                <c:when test="${iti_type == 'A'}">All ITIs</c:when>
                <c:when test="${iti_type == 'G'}">Government ITIs</c:when>
                <c:when test="${iti_type == 'P'}">Private ITIs</c:when>
                <c:otherwise>${iti_type} ITIs</c:otherwise>
            </c:choose>
            for the year ${year}
        </h2>

        <div class="text-center no-print">
            <button class="btn-excel-grey" onclick="exportTableToExcel('tradeTable', 'Trade_Duration_Seats_Report')">
                EXCEL DOWNLOAD
            </button>
        </div>

        <div class="nodal-report-card">
            <table class="nodal-table" id="tradeTable">
                <thead>
                    <tr>
                        <th style="width: 10%;">TRADE CODE</th>
                        <th style="width: 45%;">TRADE NAME</th>
                        <th style="width: 10%;">STRENGTH</th>
                        <th style="width: 10%;">FILL</th>
                        <th style="width: 10%;">VACANT</th>
                        <th style="width: 15%;">FILL PERCENTAGE</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${reportData}" var="row">
                        <tr>
                            <td class="trade-code">${not empty row.trade_code ? row.trade_code : row.iti_code}</td>
                            <td class="trade-name">${not empty row.trade_name ? row.trade_name : row.iti_name}</td>
                            <td class="stat-strength">\${row.strength}</td>
                            <td class="stat-fill">\${row.fill}</td>
                            <td class="stat-vacant">\${row.vacant}</td>
                            <td class="stat-percentage">
                                <c:choose>
                                    <c:when test="${not empty row['fill percentage']}">${row['fill percentage']}</c:when>
                                    <c:otherwise>\${row.fill_percentage}</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty reportData}">
                        <tr>
                            <td colspan="6" class="text-center py-5">No records found for the selected criteria.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div class="back-container no-print">
            <button class="nodal-btn-primary" style="width: auto; padding: 12px 50px; border-radius: 8px;" 
                    onclick="window.location.href='${pageContext.request.contextPath}/nodal-report/trade-duration-report'">
                <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
            </button>
        </div>
    </div>

    <script>

        function exportTableToExcel(tableID, filename = '') {
            var tableSelect = document.getElementById(tableID);
            var html = tableSelect.outerHTML;
            var blob = new Blob(['\ufeff', html], {
                type: "application/vnd.ms-excel"
            });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = filename ? filename + '.xls' : 'Trade_Duration_Report.xls';
            a.click();
            URL.revokeObjectURL(url);
        }
    
</script>
</body>
</html>
