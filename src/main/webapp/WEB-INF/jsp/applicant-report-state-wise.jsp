<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nodal Report | ITI Admissions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <style>
        .reports-container {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 20px;
            padding: 0 10px;
        }
        .report-card {
            flex: 1;
            min-width: 320px;
            max-width: 400px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        .report-header {
            background: var(--primary-blue);
            color: white;
            padding: 10px;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .report-header h4 {
            margin: 0;
            font-size: 14px;
            text-transform: uppercase;
        }
        .excel-btn {
            background: #fff;
            color: #000;
            border: 1px solid #ccc;
            padding: 2px 8px;
            font-size: 11px;
            cursor: pointer;
            border-radius: 4px;
            font-weight: 600;
        }
        .table-wrapper {
            max-height: 500px;
            overflow-y: auto;
        }
        .report-table th {
            font-size: 12px;
            padding: 8px 5px;
            background: #F0F4F8;
            color: var(--navy);
            border-bottom: 2px solid #E2E8F0;
        }
        .report-table td {
            font-size: 12px;
            padding: 6px 5px;
        }
        .total-row td {
            background: var(--primary-blue) !important;
            color: white !important;
            font-weight: bold;
        }
        .main-header {
            text-align: center;
            margin: 20px 0;
            color: var(--primary-blue);
        }
        @media print {
            .no-print { display: none; }
        }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    
    <c:set var="activeTab" value="nodal_report" />
    <%@ include file="nodal_navbar.jsp" %>

    
    <div class="container-fluid px-4 py-4">
        <!-- Main Header -->
        <div class="text-center mb-3" style="color: #003366;">
            <h2 class="fw-bold fs-4 mb-2">Total Applicant's Count in Phase ${phase}</h2>
            <p class="mb-4 text-muted" style="font-size: 1.1rem;">Admission Year: ${year}</p>
        </div>

        <!-- Action Buttons -->
        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="nodal-btn-primary" style="width: auto; padding: 12px 50px; border-radius: 8px;" 
                    onclick="window.location.href='${pageContext.request.contextPath}/nodal-report/nodal_selection'">
                <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
            </button>
            <button class="nodal-download-btn-black shadow-sm" style="padding: 12px 35px !important; font-size: 0.85rem !important;" onclick="exportAllTables()">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7; font-size: 0.9rem;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>

        <!-- Three Column Report Tables -->
        <div class="row gx-4">
            
            <!-- Table 1: Govt & Pvt -->
            <div class="col-lg-4 mb-4">
                <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0; height: 500px; display: flex; flex-direction: column;">
                    <div class="px-3 py-2 text-center" style="background-color: #0f2c4e; color: white;">
                        <h6 class="mb-0 fw-bold" style="font-size: 0.95rem; text-transform: uppercase;">Districtwise Govt&Pvt</h6>
                    </div>
                    <div style="overflow-y: auto; flex-grow: 1;">
                        <table class="table table-bordered mb-0 table-hover text-center" id="table1" style="font-size: 0.95rem;">
                            <thead style="position: sticky; top: 0; z-index: 1; background-color: #f8f9fa;">
                                <tr>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; width: 60px;">SNO</th>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; text-align: center;">DISTRICT NAME</th>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; width: 80px;">COUNT</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${govt_pvt.districts}" var="dist" varStatus="status">
                                    <tr style="border-bottom: 1px solid #f0f0f0;">
                                        <td style="font-weight: 600; color: #64748b;">${status.index + 1}</td>
                                        <td style="color: #003366; font-weight: 800; text-align: left; padding-left: 15px;">${dist.dist_name}</td>
                                        <td style="font-weight: 800; color: #1e293b;">${dist.count}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="px-3 py-2 fw-bold text-center d-flex border-top" style="background-color: #0f2c4e; color: white;">
                        <div style="flex: 1; text-align: center; font-weight: 900;">Total</div>
                        <div style="width: 80px; font-weight: 900;">${govt_pvt.totals.count}</div>
                    </div>
                </div>
            </div>

            <!-- Table 2: Govt -->
            <div class="col-lg-4 mb-4">
                <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0; height: 500px; display: flex; flex-direction: column;">
                    <div class="px-3 py-2 text-center" style="background-color: #0f2c4e; color: white;">
                        <h6 class="mb-0 fw-bold" style="font-size: 0.95rem; text-transform: uppercase;">Distwise For Govt</h6>
                    </div>
                    <div style="overflow-y: auto; flex-grow: 1;">
                        <table class="table table-bordered mb-0 table-hover text-center" id="table2" style="font-size: 0.95rem;">
                            <thead style="position: sticky; top: 0; z-index: 1;">
                                <tr>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; width: 60px;">SNO</th>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; text-align: center;">DISTRICT NAME</th>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; width: 80px;">COUNT</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${govt.districts}" var="dist" varStatus="status">
                                    <tr style="border-bottom: 1px solid #f0f0f0;">
                                        <td style="font-weight: 600; color: #64748b;">${status.index + 1}</td>
                                        <td style="color: #003366; font-weight: 800; text-align: left; padding-left: 15px;">${dist.dist_name}</td>
                                        <td style="font-weight: 800; color: #1a4a72;">${dist.count}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="px-3 py-2 fw-bold text-center d-flex border-top" style="background-color: #0f2c4e; color: white;">
                        <div style="flex: 1; text-align: center; font-weight: 900;">Total</div>
                        <div style="width: 80px; font-weight: 900;">${govt.totals.count}</div>
                    </div>
                </div>
            </div>

            <!-- Table 3: Private -->
            <div class="col-lg-4 mb-4">
                <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0; height: 500px; display: flex; flex-direction: column;">
                    <div class="px-3 py-2 text-center" style="background-color: #0f2c4e; color: white;">
                        <h6 class="mb-0 fw-bold" style="font-size: 0.95rem; text-transform: uppercase;">Distwise For Private</h6>
                    </div>
                    <div style="overflow-y: auto; flex-grow: 1;">
                        <table class="table table-bordered mb-0 table-hover text-center" id="table3" style="font-size: 0.95rem;">
                            <thead style="position: sticky; top: 0; z-index: 1;">
                                <tr>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; width: 60px;">SNO</th>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; text-align: center;">DISTRICT NAME</th>
                                    <th class="py-2" style="background-color: #f4f6f9; color: #003366; width: 80px;">COUNT</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pvt.districts}" var="dist" varStatus="status">
                                    <tr style="border-bottom: 1px solid #f0f0f0;">
                                        <td style="font-weight: 600; color: #64748b;">${status.index + 1}</td>
                                        <td style="color: #003366; font-weight: 800; text-align: left; padding-left: 15px;">${dist.dist_name}</td>
                                        <td style="font-weight: 800; color: #1a4a72;">${dist.count}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="px-3 py-2 fw-bold text-center d-flex border-top" style="background-color: #0f2c4e; color: white;">
                        <div style="flex: 1; text-align: center; font-weight: 900;">Total</div>
                        <div style="width: 80px; font-weight: 900;">${pvt.totals.count}</div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/api.js"></script>
    <script>









        function exportAllTables() {
            const phase = '\${phase}';
            const year = '\${year}';
            let combinedHtml = `
                <html>
                <head>
                    <meta charset="UTF-8">
                    <style>
                        table { border-collapse: collapse; width: 100%; margin-bottom: 30px; font-family: sans-serif; }
                        th, td { border: 1px solid #000; padding: 10px; text-align: center; }
                        th { background-color: #f2f2f2; font-weight: bold; }
                        .report-header { background-color: #0f2c4e; color: white; padding: 15px; font-size: 18px; font-weight: bold; text-align: center; margin-top: 20px; }
                        .main-title { font-size: 24px; font-weight: bold; text-align: center; margin: 30px 0; color: #003366; }
                    </style>
                </head>
                <body>
                    <div class="main-title">Nodal Applicant Count Report - Phase \${phase} (\${year})</div>
                    
                    <div class="report-header">DISTRICTWISE GOVT & PVT</div>
                    \${document.getElementById('table1').outerHTML}
                    
                    <div class="report-header">DISTWISE FOR GOVT</div>
                    \${document.getElementById('table2').outerHTML}
                    
                    <div class="report-header">DISTWISE FOR PRIVATE</div>
                    \${document.getElementById('table3').outerHTML}
                </body>
                </html>
            `;
            var blob = new Blob(['\ufeff', combinedHtml], { type: "application/vnd.ms-excel" });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = 'Nodal_Applicant_Count_Report_Phase_' + phase + '.xls';
            a.click();
            URL.revokeObjectURL(url);
        }

        function exportTableToExcel(tableID, filename = ''){
            var tableSelect = document.getElementById(tableID);
            var html = tableSelect.outerHTML;
            var blob = new Blob(['\ufeff', html], { type: "application/vnd.ms-excel" });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = (filename || 'Report') + '.xls';
            a.click();
            URL.revokeObjectURL(url);
        }
    








</script>
</body>
</html>
