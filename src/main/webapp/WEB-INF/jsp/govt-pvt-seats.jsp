<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Wise Open Seats Abstract | ITI Admissions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=12">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
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
    
    <c:set var="activeTab" value="open_seats" />
    <%@ include file="nodal_navbar.jsp" %>
    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Open Seats Abstract — College Wise Details</h2>
    </div>
    <div class="container mt-4 mb-5">
        <div class="no-print d-flex justify-content-center gap-3 mb-4">
            <button class="nodal-download-btn-black shadow-sm" style="padding: 12px 35px !important; font-size: 0.85rem !important;" onclick="exportTableToExcel('resultsTable', 'College_Wise_Open_Seats')">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
        </div>

        <div class="nodal-report-card shadow-lg" style="max-width: 1100px; margin: 0 auto;">
            <div class="nodal-card-header-dashboard">
                <i class="fas fa-university me-2"></i> COLLEGE WISE OPEN SEATS ABSTRACT FOR THE YEAR: ${year}
            </div>
            <div class="p-0">
                <table class="nodal-table mb-0" id="resultsTable">
                    <thead>
                        <tr>
                            <th style="width: 80px;">SNO</th>
                            <th style="width: 120px;">ITI CODE</th>
                            <th style="text-align: center;">COLLEGE NAME</th>
                            <th style="width: 150px;">NO.OF SEATS</th>
                            <th style="width: 150px;">FILL</th>
                            <th style="width: 150px;">VACANT</th>
                        </tr>
                    </thead>
                    <tbody style="font-size: 1.05rem;">
                        <c:forEach items="${reportData}" var="row" varStatus="loop">
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="font-weight: 600; color: #64748b;">${loop.index + 1}</td>
                                <td style="font-weight: 800; color: #1e293b;">\${row.iti_code}</td>
                                <td class="text-start" style="padding-left: 20px; font-weight: 800; color: #003366;">
                                    \${row.iti_name}
                                </td>
                                <td style="font-weight: 800; color: #1a4a72;">\${row.no_of_seats}</td>
                                <td style="font-weight: 800; color: #1a4a72;">\${row.fill}</td>
                                <td style="font-weight: 900;" class="\${row.vacant < 0 ? 'text-danger' : 'text-success'}">\${row.vacant}</td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty reportData}">
                            <tr>
                                <td colspan="6" style="text-align: center; padding: 40px; color: #666;">
                                    <i class="fas fa-info-circle me-2"></i> No records found for the selected criteria.
                                </td>
                            </tr>
                        </c:if>

                        <c:if test="${not empty totals}">
                            <tfoot class="nodal-total-row">
                                <tr style="font-size: 1.1rem; border-top: 2px solid #003366;">
                                    <td colspan="3" style="text-align: center; padding: 15px; font-weight: 900;">GRAND TOTAL</td>
                                    <td style="font-weight: 900; color: #003366;">${totals.no_of_seats}</td>
                                    <td style="font-weight: 900; color: #003366;">${totals.fill}</td>
                                    <td style="font-weight: 900; color: #003366;">${totals.vacant}</td>
                                </tr>
                            </tfoot>
                        </c:if>
                    </tbody>

                </table>
            </div>
        </div>

        <div class="row no-print" style="margin-top: 50px; text-align: center;">
            <div class="d-flex justify-content-center">
                <button class="nodal-btn-primary" style="width: auto; padding: 12px 50px; border-radius: 8px;" 
                        onclick="window.location.href='${pageContext.request.contextPath}/nodal-report/reports/open-seats-abstract?year=${year}'">
                    <i class="fas fa-arrow-left me-2"></i> BACK TO DISTRICTS LIST
                </button>
            </div>
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
            a.download = filename ? filename + '.xls' : 'excel_data.xls';
            a.click();
            URL.revokeObjectURL(url);
        }
    







</script>
</body>
</html>
