<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About STRIVE | ITI Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .about-content { line-height: 1.8; color: #2d3748; }
        .about-content h3 { color: #003366; font-weight: 700; margin-top: 30px; margin-bottom: 15px; }
        .about-content ul { padding-left: 20px; }
        .about-content li { margin-bottom: 8px; }
        .result-area { background: #f8fbff; border-radius: 10px; padding: 20px; margin: 15px 0; border: 1px solid #e1ecf8; }
        .result-area h4 { color: #003366; font-weight: 700; margin-bottom: 10px; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>About STRIVE</h2></div>
    <div class="container mt-4">
        <div class="nodal-report-card shadow-lg" style="border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;">
                <i class="fas fa-info-circle me-2"></i> About STRIVE Project
            </div>
            <div class="p-5 bg-white rounded-bottom about-content">
                <h3>Skills Strengthening of Industrial Value Enhancement (STRIVE) Project</h3>
                <p><strong>State:</strong> Andhra Pradesh</p>

                <p>Objective of the scheme is to improve the relevance and efficiency of skills Training provided through Industrial Training Institutes (ITIs) and Apprenticeships, duly upgrading the infrastructure, equipment and machinery.</p>

                <p><strong>STRIVE</strong> is a Central Sector Scheme with no State Contribution, assisted by World Bank.</p>

                <p><strong>Duration:</strong> It is a 5 Year Project, closing by November 2022.</p>

                <h3>STRIVE Scheme - Result Areas</h3>
                <div class="result-area">
                    <h4>Result Area 1 - Improved Performance of ITIs</h4>
                </div>
                <div class="result-area">
                    <h4>Result Area 2 - Increased Capacities of State Governments to support ITIs and Apprenticeship Training</h4>
                </div>
                <div class="result-area">
                    <h4>Result Area 3 - Improved Teaching and Learning</h4>
                </div>
                <div class="result-area">
                    <h4>Result Area 4 - Improved and Broadened Apprenticeship Training</h4>
                </div>

                <h3>Key Highlights</h3>
                <ul>
                    <li>15 Govt. ITIs have been selected under the scheme</li>
                    <li>Institute Management Committees are also constituted in these ITIs</li>
                    <li>Govt. of A.P made an Agreement (Performance Based Fund Agreement) with Govt. of India in Feb 2019 accepting terms and Conditions of the Project</li>
                </ul>

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
</body>
</html>
