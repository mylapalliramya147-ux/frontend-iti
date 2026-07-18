<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admissions Abstract | ITI Admissions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
</head>
    <style>
        /* DASHBOARD UI OVERRIDES */
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
        .nodal-page-title-dashboard {
            text-align: center;
            padding: 30px 0;
            color: #003366;
            font-weight: 800;
            background: #f8fbff;
            border-bottom: 1px solid #e1ecf8;
            margin-bottom: 40px;
        }
        .nodal-page-title-dashboard h2 {
            margin: 0;
            font-size: 1.6rem;
            letter-spacing: 0.5px;
        }
        .nodal-report-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1);
        }
        .nodal-card-header-dashboard {
            background: linear-gradient(135deg, #003366 0%, #1a4a72 100%);
            color: white;
            padding: 22px 30px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .nodal-card-header-dashboard i {
            width: 38px;
            height: 38px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    
    <c:set var="activeTab" value="phase_wise" />
    <%@ include file="nodal_navbar.jsp" %>

    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Admissions Abstract — Phase Wise Summary (As on <span id="currentDate"></span>)</h2>
    </div>

    <div class="container-fluid px-5 py-4">
        <!-- Action Buttons -->
        <div class="no-print d-flex justify-content-center mb-4">
            <button class="nodal-download-btn-black shadow-sm" style="padding: 12px 35px !important; font-size: 0.85rem !important;" onclick="exportTableToExcel('phaseTable', 'Phase_Abstract_Report')">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
        </div>

        <!-- Report Card -->
        <div class="nodal-report-card shadow-lg">
            <div class="nodal-card-header-dashboard">
                <i class="fas fa-chart-pie me-2"></i> PHASE WISE ADMISSIONS — YEAR: ${year}
            </div>
            
            <div class="table-responsive">
                <table class="nodal-table table-bordered mb-0" id="phaseTable">
                    <thead>
                        <tr>
                            <th style="width: 50px;">SLNO</th>
                            <th>DISTRICT NAME</th>
                            <th>PHASE I</th>
                            <th>PHASE II</th>
                            <th>PHASE III</th>
                            <th>PHASE IV</th>
                            <th>PHASE V</th>
                            <th>TOTAL</th>
                            <th>TODAY</th>
                        </tr>
                    </thead>
                    <tbody style="font-size: 1.05rem;">
                        <c:if test="${empty districts}">
                            <tr>
                                <td colspan="9" class="py-4 text-center text-muted fw-bold">No data available for the selected year.</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${districts}" var="dist" varStatus="loop">
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="font-weight: 600;">${loop.index + 1}</td>
                                <td class="text-start" style="padding-left: 20px; color: #800000; font-weight: 800;">${dist.dist_name}</td>
                                <td style="font-weight: 700;">${dist.phase_i > 0 ? dist.phase_i : '-'}</td>
                                <td style="font-weight: 700;">${dist.phase_ii > 0 ? dist.phase_ii : '-'}</td>
                                <td style="font-weight: 700;">${dist.phase_iii > 0 ? dist.phase_iii : '-'}</td>
                                <td style="font-weight: 700;">${dist.phase_iv > 0 ? dist.phase_iv : '-'}</td>
                                <td style="font-weight: 700;">${dist.phase_v > 0 ? dist.phase_v : '-'}</td>
                                <td style="font-weight: 800; color: #003366;">${dist.total}</td>
                                <td style="font-weight: 800; color: #dc2626;">${dist.today}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    
                    <c:if test="${not empty totals}">
                        <tfoot class="nodal-total-row">
                            <tr style="font-size: 1.1rem; border-top: 2px solid #003366;">
                                <td colspan="2" style="text-align: center; padding: 15px; font-weight: 900;">GRAND TOTAL</td>
                                <td style="font-weight: 900;">${totals.phase_i}</td>
                                <td style="font-weight: 900;">${totals.phase_ii}</td>
                                <td style="font-weight: 900;">${totals.phase_iii}</td>
                                <td style="font-weight: 900;">${totals.phase_iv}</td>
                                <td style="font-weight: 900;">${totals.phase_v}</td>
                                <td style="font-weight: 900; color: #003366;">${totals.total}</td>
                                <td style="font-weight: 900; color: #dc2626;">${totals.today}</td>
                            </tr>
                        </tfoot>
                    </c:if>
                </table>
            </div>

            <!-- Error Notification -->
            <c:if test="${not empty error}">
                <div style="padding: 24px; text-align: center; color: #E53E3E; background-color: #FED7D7; font-weight: 600;">
                    ${error}
                </div>
            </c:if>
        </div>

        <!-- Back Button -->
        <div class="row no-print mt-5">
            <div class="col-12 text-center">
                <button class="nodal-btn-primary" style="width: auto; padding: 12px 50px; border-radius: 8px;" 
                        onclick="window.location.href='${pageContext.request.contextPath}/nodal-report/phase-wise'">
                    <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
                </button>
            </div>
        </div>
    </div>

    <script>







        // Insert short current date dynamically like in screenshot
        document.addEventListener('DOMContentLoaded', () => {
            const dateSpan = document.getElementById('currentDate');
            if (dateSpan) {
                const d = new Date();
                const day = String(d.getDate()).padStart(2, '0');
                const month = String(d.getMonth() + 1).padStart(2, '0');
                const year = d.getFullYear();
                dateSpan.textContent = day + '-' + month + '-' + year;
            }
        });

        function exportTableToExcel(tableID, filename = ''){
            var tableSelect = document.getElementById(tableID);
            var html = tableSelect.outerHTML;
            var blob = new Blob(['\ufeff', html], {
                type: "application/vnd.ms-excel"
            });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = filename ? filename + '.xls' : 'excel_data.xls';
            a.click();
            URL.revokeObjectURL(url);
        }
    






</script>
</body>
</html>
