<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI Admissions | Selection Report</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="../header.jsp" %>
    
    <c:set var="activeTab" value="home" />
    <%@ include file="nodal_navbar.jsp" %>

    
    <div class="container mb-5">
        <div class="nodal-page-title-dashboard bg-transparent border-0 mb-2">
            <h2 class="display-6 fw-bold" style="color: #003366;">Full DSC Admission Selection Report</h2>
            <div class="badge bg-primary px-3 py-2 mt-2">Session ${meta.session}</div>
        </div>

        <div class="card nodal-stat-card shadow-sm mb-4 mx-auto" style="border-left: 5px solid #ffd700; max-width: 1000px;">
            <div class="card-body py-3">
                <div class="row g-3">
                    <div class="col-md-6 border-end">
                        <label class="small text-muted text-uppercase fw-bold opacity-75">ITI Name</label>
                        <div class="h5 fw-bold mb-0" style="color: #003366;">${iti.iti_name}</div>
                    </div>
                    <div class="col-md-6">
                        <label class="small text-muted text-uppercase fw-bold opacity-75">Trade & Level</label>
                        <div class="h5 fw-bold mb-0" style="color: #003366;">${trade.trade_name} (${meta.admission_performed_in_level})</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn btn-light border bg-white text-dark shadow-sm fw-bold px-4 rounded-pill" onclick="window.history.back()" style="font-size: 0.9rem;">
                <i class="fas fa-arrow-left me-2"></i>BACK TO SELECTION
            </button>
            <button class="nodal-download-btn-black shadow-sm" style="padding: 12px 35px !important; font-size: 0.85rem !important;" onclick="exportTableToExcel('selectionTable', 'Full_DSC_Admission_Report')">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7; font-size: 0.9rem;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>

        <div class="nodal-report-card shadow-lg mx-auto" style="max-width: 1100px;">
            <div class="nodal-card-header-dashboard">
                <i class="fas fa-users me-2"></i> Selection Details - ${meta.session}
            </div>
            <div class="table-responsive">
                <table class="nodal-table table-bordered mb-0" id="selectionTable">
                    <thead>
                        <tr>
                            <th style="width: 70px;">SNO</th>
                            <th style="width: 100px;">RANK</th>
                            <th style="width: 150px;">ADMISSION #</th>
                            <th>CANDIDATE NAME</th>
                            <th>FATHER NAME</th>
                            <th style="width: 100px;">GENDER</th>
                            <th style="width: 120px;">DOB</th>
                            <th style="width: 100px;">CASTE</th>
                        </tr>
                    </thead>
                    <tbody style="font-size: 1.05rem;">
                        <c:forEach var="cat" items="${categories}">
                            <!-- Category Header -->
                            <tr class="table-light">
                                <td colspan="8" class="text-start py-3 px-4 fw-bold" style="background-color: #f8fafc; color: #003366; border-left: 5px solid #ffd700;">
                                    <span class="badge bg-navy me-2" style="background: #003366;">CATEGORY: ${cat.category_code}</span>
                                    <span class="ms-3">Strength: <span class="text-primary">${cat.strength}</span> | Filled: <span class="text-success">${cat.filled}</span> | Vacant: <span class="text-danger">${cat.vacant}</span></span>
                                </td>
                            </tr>
    
                            <!-- Candidates -->
                            <c:forEach var="cand" items="${cat.candidates}">
                                <tr>
                                    <td style="font-weight: 600;">${cand.slNo}</td>
                                    <td style="font-weight: 800; color: #1e293b;">${cand.rank}</td>
                                    <td style="font-weight: 600;">${cand.admission_number}</td>
                                    <td class="text-start px-4" style="color: #800000; font-weight: 800;">${cand.name}</td>
                                    <td class="text-start px-4" style="font-weight: 600;">${cand.father_name}</td>
                                    <td style="font-weight: 600;">${cand.gender.toUpperCase()}</td>
                                    <td style="font-weight: 600;">${cand.date_of_birth}</td>
                                    <td style="font-weight: 800;">${cand.caste}</td>
                                </tr>
                            </c:forEach>
    
                            <!-- Vacancy Rows -->
                            <c:forEach var="i" begin="1" end="${cat.vacant}">
                                <tr class="text-muted opacity-50">
                                    <td style="font-weight: 600;">${cat.filled + i}</td>
                                    <td colspan="7" class="text-center font-monospace py-3" style="letter-spacing: 2px;">-- VACANT --</td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script>
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
    </div>
</body>
</html>
