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
        .reports-dashboard {
            padding: 40px 20px;
            background: #f0f4f8;
            min-height: 80vh;
        }
        .report-section-title {
            color: #003366;
            font-weight: 800;
            border-left: 5px solid #003366;
            padding-left: 15px;
            margin-bottom: 25px;
            margin-top: 30px;
            font-size: 1.4rem;
        }
        .report-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #e1e8f0;
            height: 100%;
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        .report-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            color: inherit;
        }
        .report-card i {
            font-size: 2rem;
            color: #003366;
            margin-bottom: 10px;
        }
        .report-card h5 {
            margin: 10px 0 5px 0;
            font-size: 1rem;
            font-weight: 700;
            color: #2d3748;
        }
        .report-card p {
            font-size: 0.85rem;
            color: #718096;
            margin: 0;
        }
        .api-badge {
            display: inline-block;
            background: #e2e8f0;
            color: #4a5568;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 0.75rem;
            margin-top: 5px;
            font-family: monospace;
        }
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
                    <a href="${pageContext.request.contextPath}/reports/unified-reports" class="btn btn-secondary">
                        <i class="fas fa-tachometer-alt me-2"></i>Main Dashboard
                    </a>
                </div>
            </div>

            <!-- ITI Level Reports -->
            <h3 class="report-section-title"><i class="fas fa-university me-2"></i> ITI Level Reports</h3>
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/iti-wise-status-view" class="report-card">
                        <i class="fas fa-building"></i>
                        <h5>ITI Wise Status</h5>
                        <p>Admission status by ITI</p>
                        <span class="api-badge">${backendApiUrl}/iti-wise-status</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/admission-report" class="report-card">
                        <i class="fas fa-user-check"></i>
                        <h5>Admission Report</h5>
                        <p>Trade-wise admissions</p>
                        <span class="api-badge">${backendApiUrl}/admission-report</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/iti-student-list-view" class="report-card">
                        <i class="fas fa-list-ol"></i>
                        <h5>Student List</h5>
                        <p>Complete student roster</p>
                    </a>
                </div>
            </div>

            <!-- District Level Reports -->
            <h3 class="report-section-title"><i class="fas fa-map-marked-alt me-2"></i> District Level Reports</h3>
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/district-dsc-full" class="report-card">
                        <i class="fas fa-file-contract"></i>
                        <h5>DSC Full Report</h5>
                        <p>District seat matrix</p>
                        <span class="api-badge">${backendApiUrl}/dsc-full</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/district-applicant-report" class="report-card">
                        <i class="fas fa-users-cog"></i>
                        <h5>Applicant Report</h5>
                        <p>Phase-wise applicants</p>
                        <span class="api-badge">${backendApiUrl}/applicant-report-by-phase</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/district-caste-wise" class="report-card">
                        <i class="fas fa-id-card"></i>
                        <h5>Caste Wise Report</h5>
                        <p>Category-wise admissions</p>
                        <span class="api-badge">${backendApiUrl}/caste-wise-admissions</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/district-verified-count" class="report-card">
                        <i class="fas fa-check-circle"></i>
                        <h5>Verified Count</h5>
                        <p>Verification status</p>
                        <span class="api-badge">${backendApiUrl}/verified-application-count</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/district-iti-wise-year" class="report-card">
                        <i class="fas fa-chart-line"></i>
                        <h5>ITI Wise Year Report</h5>
                        <p>ITI-wise status by year</p>
                        <span class="api-badge">${backendApiUrl}/iti-wise-status</span>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/reports/district-permitted-shift" class="report-card">
                        <i class="fas fa-exchange-alt"></i>
                        <h5>Permitted Shift</h5>
                        <p>Permitted shift units</p>
                        <span class="api-badge">${backendApiUrl}/permitted-shift-unit</span>
                    </a>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="mt-5 p-4 bg-white rounded shadow-sm">
                <h4 class="mb-3" style="color: #003366;">
                    <i class="fas fa-link me-2"></i>Quick Links
                </h4>
                <div class="row">
                    <div class="col-md-6">
                        <h6>Backend API Documentation:</h6>
                        <ul class="list-unstyled">
                            <li><a href="${pageContext.request.contextPath}/reports/api-docs" target="_blank" class="text-decoration-none">
                                <i class="fas fa-external-link-alt me-1"></i>Swagger UI (API Docs)
                            </a></li>
                        <li><a href="${backendApiUrl}" target="_blank" class="text-decoration-none">
                                <i class="fas fa-external-link-alt me-1"></i>Reports API Base URL
                            </a></li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h6>Frontend Pages:</h6>
                        <ul class="list-unstyled">
                            <li><a href="${pageContext.request.contextPath}/reports/unified-reports" class="text-decoration-none">
                                <i class="fas fa-tachometer-alt me-1"></i>Unified Reports Dashboard
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                                <i class="fas fa-home me-1"></i>Home Page
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>