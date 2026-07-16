<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unified Reports Dashboard | Official Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .nodal-dashboard-container {
            padding: 40px 20px;
            background: #f0f4f8;
            min-height: 80vh;
        }
        .report-group-title {
            color: #003366;
            font-weight: 800;
            border-left: 5px solid #003366;
            padding-left: 15px;
            margin-bottom: 30px;
            font-size: 1.5rem;
        }
        .report-card-link {
            text-decoration: none;
            color: inherit;
            display: block;
            transition: all 0.3s ease;
            height: 100%;
        }
        .report-card-link:hover {
            transform: translateY(-5px);
        }
        .report-card-official {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #e1e8f0;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .report-card-official i {
            font-size: 2.5rem;
            color: #003366;
            margin-bottom: 15px;
        }
        .report-card-official h5 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 700;
            color: #2d3748;
        }
        .report-card-official p {
            font-size: 0.9rem;
            color: #718096;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <%@ include file="nodal_navbar.jsp" %>

    <div class="nodal-dashboard-container">
        <div class="container">
            
            <!-- DISTRICT REPORTS SECTION -->
            <div class="mb-5">
                <h3 class="report-group-title"><i class="fas fa-map-marked-alt me-2"></i> District Level Reports</h3>
                <div class="row g-4">
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/reports/district-dsc-full" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-file-contract"></i>
                                <h5>DSC Full Report</h5>
                                <p>Detailed seat matrix & admissions</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/reports/district-applicant-report" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-users-cog"></i>
                                <h5>Applicant Report</h5>
                                <p>Phase-wise district applicants</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/reports/district-iti-wise-year" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-building"></i>
                                <h5>ITI Wise Status</h5>
                                <p>Consolidated ITI verification status</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/reports/district-caste-wise" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-id-card"></i>
                                <h5>Caste Wise</h5>
                                <p>Category-based admission metrics</p>
                            </div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- ITI REPORTS SECTION -->
            <div class="mb-5">
                <h3 class="report-group-title"><i class="fas fa-university me-2"></i> Institute Level Reports</h3>
                <div class="row g-4">
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/reports/admission-report" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-user-check"></i>
                                <h5>Admission Report</h5>
                                <p>Trade-wise admission metrics</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/reports/iti-wise-status-view" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-tasks"></i>
                                <h5>Admission Status</h5>
                                <p>Live verification & SID progress</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/reports/iti-student-list-view" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-list-ol"></i>
                                <h5>Student List</h5>
                                <p>Complete student roster with details</p>
                            </div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- VERIFIED & PERMITTED REPORTS -->
            <div class="mb-5">
                <h3 class="report-group-title"><i class="fas fa-shield-alt me-2"></i> Verification & Shift Reports</h3>
                <div class="row g-4">
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/reports/district-verified-count" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-check-circle"></i>
                                <h5>Verified Count</h5>
                                <p>District verification status</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/reports/district-permitted-shift" class="report-card-link">
                            <div class="report-card-official">
                                <i class="fas fa-exchange-alt"></i>
                                <h5>Permitted Shift</h5>
                                <p>Permitted shift units</p>
                            </div>
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
