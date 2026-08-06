<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .district-dashboard-navbar {
        background: #003366;
        padding: 10px 0;
        margin-bottom: 20px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    .district-dashboard-link {
        color: rgba(255, 255, 255, 0.8);
        text-decoration: none;
        padding: 8px 15px;
        margin: 0 5px;
        font-weight: 600;
        font-size: 0.9rem;
        border-radius: 4px;
        transition: all 0.3s ease;
        display: inline-block;
    }
    .district-dashboard-link:hover {
        color: white;
        background: rgba(255, 255, 255, 0.1);
        text-decoration: none;
    }
    .district-dashboard-link.active {
        color: white;
        background: #1a4a72;
        border-bottom: 3px solid #ffcc00;
    }
</style>

<nav class="district-dashboard-navbar no-print">
    <div class="container-fluid d-flex justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/authHome" class="district-dashboard-link">
            <i class="fas fa-home me-1"></i> Home
        </a>
        <a href="${pageContext.request.contextPath}/district-dsc-full" class="district-dashboard-link ${activeTab eq 'dsc_full' ? 'active' : ''}">DSC Full</a>
        <a href="${pageContext.request.contextPath}/district-applicant-report" class="district-dashboard-link ${activeTab eq 'dist_applicant' ? 'active' : ''}">Applicant Report</a>
        <a href="${pageContext.request.contextPath}/district-iti-wise-year" class="district-dashboard-link ${activeTab eq 'iti_wise_year' ? 'active' : ''}">ITI Wise Status</a>
        <a href="${pageContext.request.contextPath}/district-caste-wise" class="district-dashboard-link ${activeTab eq 'caste_wise' ? 'active' : ''}">Caste Wise</a>
        <a href="${pageContext.request.contextPath}/district-verified-count" class="district-dashboard-link ${activeTab eq 'verified_count' ? 'active' : ''}">Verified Count</a>
        <a href="${pageContext.request.contextPath}/district-permitted-shift" class="district-dashboard-link ${activeTab eq 'permitted_shift' ? 'active' : ''}">Permitted Shift</a>
        
        <a href="${pageContext.request.contextPath}/logout" class="district-dashboard-link ms-auto" onclick="clearAuthCookie()">
            <i class="fas fa-sign-out-alt me-1"></i> Log out
        </a>
    </div>
</nav>
