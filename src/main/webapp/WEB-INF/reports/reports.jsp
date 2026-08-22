<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports Dashboard | ITI Frontend</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .reports-dashboard { padding: 40px 20px; background: #f0f4f8; min-height: 80vh; }
        .report-section-title { color: #003366; font-weight: 800; border-left: 5px solid #003366; padding-left: 15px; margin-bottom: 25px; margin-top: 30px; font-size: 1.4rem; }
        .report-card { background: white; border-radius: 12px; padding: 20px; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e1e8f0; height: 100%; transition: all 0.3s ease; text-decoration: none; color: inherit; display: block; }
        .report-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); color: inherit; }
        .report-card i { font-size: 2rem; color: #003366; margin-bottom: 10px; }
        .report-card h5 { margin: 10px 0 5px 0; font-size: 1rem; font-weight: 700; color: #2d3748; }
        .report-card p { font-size: 0.85rem; color: #718096; margin: 0; }
        .api-badge { display: inline-block; background: #e2e8f0; color: #4a5568; padding: 2px 8px; border-radius: 4px; font-size: 0.75rem; margin-top: 5px; font-family: monospace; }
    </style>
</head>
<body>
    <div class="reports-dashboard">
        <div class="container">
            <div class="text-center mb-5">
                <h1 style="color: #003366; font-weight: 800;">ITI Reports Dashboard</h1>
                <p class="text-muted">Comprehensive reporting module</p>
                <div class="mt-3">
                    <a href="${backendBaseUrl}/swagger" target="_blank" class="btn btn-primary me-2">
                        <i class="fas fa-book-medical me-2"></i>Backend API Docs (Swagger)
                    </a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                        <i class="fas fa-home me-2"></i>Home Page
                    </a>
                </div>
            </div>

            <!-- ITI Level Reports (Role 4) -->
            <h3 class="report-section-title"><i class="fas fa-university me-2"></i> ITI Level Reports (Role 4)</h3>
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/getDashboardreport_iti" class="report-card">
                        <i class="fas fa-tachometer-alt"></i>
                        <h5>API Dashboard</h5>
                        <p>Admission status by ITI</p>
                        <span class="api-badge">${backendApiUrl}/iti-wise-status</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/Applicant_Report" class="report-card">
                        <i class="fas fa-user-check"></i>
                        <h5>Applicant Report</h5>
                        <p>Phase-wise applicant list</p>
                        <span class="api-badge">${backendApiUrl}/applicant-report-by-phase</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/api_report" class="report-card">
                        <i class="fas fa-clipboard-list"></i>
                        <h5>Admission Report</h5>
                        <p>Trade-wise admission stats</p>
                        <span class="api-badge">${backendApiUrl}/admission-report-iti</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/DSC_List_secondphase" class="report-card">
                        <i class="fas fa-file-contract"></i>
                        <h5>DSC List</h5>
                        <p>District seat matrix details</p>
                        <span class="api-badge">${backendApiUrl}/dsc-full</span>
                    </a>
                </div>
            </div>

            <!-- District Level Reports (Role 3) -->
            <h3 class="report-section-title"><i class="fas fa-map-marked-alt me-2"></i> District Level Reports (Role 3)</h3>
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/statewidecastewiseabstractinter" class="report-card">
                        <i class="fas fa-id-card"></i>
                        <h5>Caste Wise Admissions Abstract</h5>
                        <p>Category-wise admission counts</p>
                        <span class="api-badge">${backendApiUrl}/caste-wise-admissions</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/Applicant_mobile_addr" class="report-card">
                        <i class="fas fa-mobile-alt"></i>
                        <h5>Applicant Address With Mobile</h5>
                        <p>Applicant contact details</p>
                        <span class="api-badge">${backendApiUrl}/applicant-mobile-address</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/getDashboardreport_dist" class="report-card">
                        <i class="fas fa-chalkboard-teacher"></i>
                        <h5>API Dashboard (District)</h5>
                        <p>District-wide admission dashboard</p>
                        <span class="api-badge">${backendApiUrl}/api-dashboard</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/District_Wise_Application_count" class="report-card">
                        <i class="fas fa-check-circle"></i>
                        <h5>Verification Report</h5>
                        <p>Verification status by district</p>
                        <span class="api-badge">${backendApiUrl}/verified-application-count</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/DSC_List_secondphase" class="report-card">
                        <i class="fas fa-file-contract"></i>
                        <h5>DSC List</h5>
                        <p>District seat matrix details</p>
                        <span class="api-badge">${backendApiUrl}/dsc-full</span>
                    </a>
                </div>
            </div>

            <!-- Nodal Level Reports (Role 10) -->
            <h3 class="report-section-title"><i class="fas fa-layer-group me-2"></i> Nodal Level Reports (Role 10)</h3>
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/state-dashboard" class="report-card">
                        <i class="fas fa-tachometer-alt"></i>
                        <h5>State Dashboard</h5>
                        <p>ITI-wise strength dashboard</p>
                        <span class="api-badge">${backendApiUrl}/state-dashboard</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/phase-wise" class="report-card">
                        <i class="fas fa-clock"></i>
                        <h5>Phase Wise Admissions Details</h5>
                        <p>Admissions by phase</p>
                        <span class="api-badge">${backendApiUrl}/phase-wise</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/today-schedule" class="report-card">
                        <i class="fas fa-calendar-day"></i>
                        <h5>Today Schedule ITIs</h5>
                        <p>Today's admission schedule</p>
                        <span class="api-badge">${backendApiUrl}/today-schedule</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/trade-wise-report" class="report-card">
                        <i class="fas fa-cogs"></i>
                        <h5>Trade Wise Report</h5>
                        <p>Seats by trade</p>
                        <span class="api-badge">${backendApiUrl}/trade-wise-report</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/statewidecastewiseabstractinter" class="report-card">
                        <i class="fas fa-id-card"></i>
                        <h5>Caste Wise Admissions Abstract</h5>
                        <p>Category-wise admission counts</p>
                        <span class="api-badge">${backendApiUrl}/caste-wise-admissions</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/applicant-report-state-wise" class="report-card">
                        <i class="fas fa-users"></i>
                        <h5>Applicant Report Dist Wise</h5>
                        <p>District-wise applicants</p>
                        <span class="api-badge">${backendApiUrl}/applicant-report-state-wise</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/open-seats" class="report-card">
                        <i class="fas fa-door-open"></i>
                        <h5>DIST/ITI/Trade Wise Seats Abstract</h5>
                        <p>Open seats abstract</p>
                        <span class="api-badge">${backendApiUrl}/open-seats</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/trade-duration-seats" class="report-card">
                        <i class="fas fa-hourglass-half"></i>
                        <h5>Duration Wise Trade Seats Abstract</h5>
                        <p>Duration-wise seat report</p>
                        <span class="api-badge">${backendApiUrl}/trade-duration-seats</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/govt-pvt-seats" class="report-card">
                        <i class="fas fa-building"></i>
                        <h5>Govt or Pvt Dist Wise Seats Abstract</h5>
                        <p>Govt vs Private seats</p>
                        <span class="api-badge">${backendApiUrl}/govt-pvt-seats</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/student-details" class="report-card">
                        <i class="fas fa-user-graduate"></i>
                        <h5>Student Reg Details</h5>
                        <p>Student admission details</p>
                        <span class="api-badge">${backendApiUrl}/student-details</span>
                    </a>
                </div>
            </div>

            <!-- State Level Reports (Role 1) -->
            <h3 class="report-section-title"><i class="fas fa-map-marked-alt me-2"></i> State Level Reports (Role 1)</h3>
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/district-schedule" class="report-card">
                        <i class="fas fa-calendar-alt"></i>
                        <h5>District Schedule</h5>
                        <p>District-wise schedule</p>
                        <span class="api-badge">${backendApiUrl}/district-schedule</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                     <a href="${pageContext.request.contextPath}/reports/district-permitted-shift-view" class="report-card">
                        <i class="fas fa-exchange-alt"></i>
                        <h5>Shift Unit Report</h5>
                        <p>Permitted shift units</p>
                        <span class="api-badge">${backendApiUrl}/permitted-shift-unit</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/iti-admissions" class="report-card">
                        <i class="fas fa-school"></i>
                        <h5>Admitted Seats Abstract</h5>
                        <p>State-level ITI admissions</p>
                        <span class="api-badge">${backendApiUrl}/iti-admissions</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/all-resource-roles" class="report-card">
                        <i class="fas fa-server"></i>
                        <h5>All Resource Role</h5>
                        <p>Resource roles report</p>
                        <span class="api-badge">${backendApiUrl}/all-resource-roles</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/strength-filled-seats" class="report-card">
                        <i class="fas fa-bed"></i>
                        <h5>DistWise Admitted Seats Abstract</h5>
                        <p>Strength vs filled seats</p>
                        <span class="api-badge">${backendApiUrl}/strength-filled-seats</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/trade-vacant-positions" class="report-card">
                        <i class="fas fa-clipboard-check"></i>
                        <h5>TradeWise Vacant Position</h5>
                        <p>Vacant seats by trade</p>
                        <span class="api-badge">${backendApiUrl}/trade-vacant-positions</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                     <a href="${pageContext.request.contextPath}/reports/admission_report" class="report-card">
                        <i class="fas fa-chart-pie"></i>
                        <h5>Trade/Dist Wise Admission Report</h5>
                        <p>Admission summary report</p>
                        <span class="api-badge">${backendApiUrl}/admission-report</span>
                    </a>
                </div>
            </div>

            <!-- Public Pages -->
            <h3 class="report-section-title"><i class="fas fa-globe me-2"></i> Public Pages</h3>
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/itiprofile" class="report-card">
                        <i class="fas fa-university"></i>
                        <h5>ITI Profile</h5>
                        <p>ITI trades & strengths</p>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                     <a href="${pageContext.request.contextPath}/reports/aboutstrive" class="report-card">
                        <i class="fas fa-info-circle"></i>
                        <h5>About STRIVE</h5>
                        <p>About the project</p>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                     <a href="${pageContext.request.contextPath}/reports/disclosuremanagement" class="report-card">
                        <i class="fas fa-shield-alt"></i>
                        <h5>Disclosure Management</h5>
                        <p>Public disclosure info</p>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                     <a href="${pageContext.request.contextPath}/reports/swagger" class="report-card">
                        <i class="fas fa-book"></i>
                        <h5>API Documentation</h5>
                        <p>Swagger UI</p>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
