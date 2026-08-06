<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Reports - Test Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        .report-btn { margin: 5px; min-width: 280px; text-align: left; }
        .section-title { color: #003366; font-weight: 700; margin-top: 25px; margin-bottom: 10px; border-bottom: 2px solid #003366; padding-bottom: 5px; }
        .badge-role { font-size: 0.7rem; margin-left: 5px; }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>All Reports (25 Reports from AboutITIProject.txt)</h2>
            <a href="${pageContext.request.contextPath}/reports/api-docs" class="btn btn-primary" target="_blank">Swagger UI</a>
        </div>
        <p class="text-muted">Base URL: <code>${backendApiUrl}</code></p>

        <div class="row">
            <div class="col-md-6">
                <div class="section-title">ITI Login Reports (Role 4)</div>
                <a href="${pageContext.request.contextPath}/reports/api-dashboard" class="btn btn-outline-info report-btn">1. API Dashboard</a>
                <a href="${pageContext.request.contextPath}/reports/applicant-report-by-phase" class="btn btn-outline-info report-btn">2. Applicant Report</a>
                <a href="${pageContext.request.contextPath}/reports/admission-report" class="btn btn-outline-info report-btn">3. Admission Report</a>
                <a href="${pageContext.request.contextPath}/reports/district-dsc-full" class="btn btn-outline-info report-btn">4. DSC List</a>

                <div class="section-title">District Login Reports (Role 3)</div>
                <a href="${pageContext.request.contextPath}/reports/district-caste-wise" class="btn btn-outline-success report-btn">5. Caste Wise Admissions Abstract</a>
                <a href="${pageContext.request.contextPath}/reports/district-applicant-report" class="btn btn-outline-success report-btn">6. Applicant Address With Mobile</a>
                <a href="${pageContext.request.contextPath}/reports/api-dashboard" class="btn btn-outline-success report-btn">7. API Dashboard (District)</a>
                <a href="${pageContext.request.contextPath}/reports/district-verified-count" class="btn btn-outline-success report-btn">8. Verification Report</a>

                <div class="section-title">Nodal / State Login Reports (Role 10, 1)</div>
                <a href="${pageContext.request.contextPath}/reports/state-dashboard" class="btn btn-outline-warning report-btn">9. API Dashboard</a>
                <a href="${pageContext.request.contextPath}/reports/phase-wise-report" class="btn btn-outline-warning report-btn">10. Phase Wise Admissions Details</a>
                <a href="${pageContext.request.contextPath}/reports/today-schedule" class="btn btn-outline-warning report-btn">11. Today Schedule ITIs</a>
                <a href="${pageContext.request.contextPath}/reports/trade-wise-report" class="btn btn-outline-warning report-btn">12. Trade Wise Report</a>
                <a href="${pageContext.request.contextPath}/reports/applicant-report-state-wise" class="btn btn-outline-warning report-btn">13. Applicant Report Dist Wise</a>
                <a href="${pageContext.request.contextPath}/reports/open-seats-report" class="btn btn-outline-warning report-btn">14. DIST/ITI/Trade Wise Seats Abstract</a>
                <a href="${pageContext.request.contextPath}/reports/trade-duration-seats" class="btn btn-outline-warning report-btn">15. Duration Wise Trade Seats Abstract</a>
                <a href="${pageContext.request.contextPath}/reports/govt-pvt-seats" class="btn btn-outline-warning report-btn">16. Govt or Pvt Dist Wise Seats Abstract</a>
                <a href="${pageContext.request.contextPath}/reports/student-registration-details" class="btn btn-outline-warning report-btn">17. STUDENT REG DETAILS</a>
                <a href="${pageContext.request.contextPath}/reports/verification-report" class="btn btn-outline-warning report-btn">18. Verification Report</a>
            </div>

            <div class="col-md-6">
                <div class="section-title">Admin / Secretariat Reports (Role 1)</div>
                <a href="${pageContext.request.contextPath}/reports/district-schedule" class="btn btn-outline-primary report-btn">19. District Schedule</a>
                <a href="${pageContext.request.contextPath}/reports/district-permitted-shift" class="btn btn-outline-primary report-btn">20. Shift Unit Report</a>
                <a href="${pageContext.request.contextPath}/reports/open-seats" class="btn btn-outline-primary report-btn">21. Admitted Seats Abstract</a>
                <a href="${pageContext.request.contextPath}/reports/all-resource-roles" class="btn btn-outline-primary report-btn">22. All Resource Role</a>
                <a href="${pageContext.request.contextPath}/reports/strength-filled-seats" class="btn btn-outline-primary report-btn">23. DistWise Admitted Seats Abstract</a>
                <a href="${pageContext.request.contextPath}/reports/admission-report" class="btn btn-outline-primary report-btn">24. Trade/Dist Wise Admission Report</a>
                <a href="${pageContext.request.contextPath}/reports/trade-vacant-positions" class="btn btn-outline-primary report-btn">25. TradeWise Vacant Position</a>

                <div class="section-title">Public Pages</div>
                <a href="${pageContext.request.contextPath}/reports/about-strive" class="btn btn-outline-secondary report-btn">26. About STRIVE</a>
                <a href="${pageContext.request.contextPath}/reports/disclosure-management" class="btn btn-outline-secondary report-btn">27. Disclosure Management</a>
                <a href="${pageContext.request.contextPath}/reports/trade-display/districts" class="btn btn-outline-secondary report-btn">28. Trade Display Districts</a>
            </div>
        </div>
    </div>
</body>
</html>
