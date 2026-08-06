<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .iti-dashboard-navbar {
        background: #003366;
        padding: 10px 0;
        margin-bottom: 20px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    .iti-dashboard-link {
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
    .iti-dashboard-link:hover {
        color: white;
        background: rgba(255, 255, 255, 0.1);
        text-decoration: none;
    }
    .iti-dashboard-link.active {
        color: white;
        background: #1a4a72;
        border-bottom: 3px solid #ffcc00;
    }
</style>

<nav class="iti-dashboard-navbar no-print">
    <div class="container-fluid d-flex justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/authHome" class="iti-dashboard-link">
            <i class="fas fa-home me-1"></i> Home
        </a>
        <a href="${pageContext.request.contextPath}/applicant-report-by-phase" class="iti-dashboard-link ${activeTab eq 'applicant_phase' ? 'active' : ''}">Applicant Report</a>
        <a href="${pageContext.request.contextPath}/iti-wise-status-view" class="iti-dashboard-link ${activeTab eq 'iti_status' ? 'active' : ''}">Admission Status</a>
        <a href="${pageContext.request.contextPath}/iti-student-list-view" class="iti-dashboard-link ${activeTab eq 'student_list' ? 'active' : ''}">Student List</a>
        
        <a href="${pageContext.request.contextPath}/logout" class="iti-dashboard-link ms-auto" onclick="clearAuthCookie()">
            <i class="fas fa-sign-out-alt me-1"></i> Log out
        </a>
    </div>
</nav>
