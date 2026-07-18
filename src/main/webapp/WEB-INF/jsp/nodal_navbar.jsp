<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Modern Dashboard Navigation (Shared Component) -->
<nav class="nodal-dashboard-navbar no-print">
    <div class="container-fluid d-flex justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/authHome" class="nodal-dashboard-link ${activeTab eq 'home' ? 'active' : ''}">
            <i class="fas fa-home me-1"></i> Home
        </a>
        <a href="${pageContext.request.contextPath}/nodal-report/dashboard" class="nodal-dashboard-link ${activeTab eq 'api_dashboard' ? 'active' : ''}">API Dashboard</a>
        <a href="${pageContext.request.contextPath}/nodal-report/phase-wise" class="nodal-dashboard-link ${activeTab eq 'phase_wise' ? 'active' : ''}">Phase-Wise</a>
        <a href="${pageContext.request.contextPath}/nodal-report/admission-report" class="nodal-dashboard-link ${activeTab eq 'admission_report' ? 'active' : ''}">Admission</a>
        <a href="${pageContext.request.contextPath}/nodal-report/nodal_selection" class="nodal-dashboard-link ${activeTab eq 'nodal_report' ? 'active' : ''}">Nodal Reports</a>
        <a href="${pageContext.request.contextPath}/nodal-report/iti_admissions_report" class="nodal-dashboard-link ${activeTab eq 'iti_admissions' ? 'active' : ''}">ITI Admissions</a>
        <a href="${pageContext.request.contextPath}/nodal-report/open-seats-report" class="nodal-dashboard-link ${activeTab eq 'open_seats' ? 'active' : ''}">Open Seats</a>
        <a href="${pageContext.request.contextPath}/nodal-report/trade-duration-report" class="nodal-dashboard-link ${activeTab eq 'trade_duration' ? 'active' : ''}">Trade Duration</a>
        <a href="${pageContext.request.contextPath}/nodal-report/candidate-details" class="nodal-dashboard-link ${activeTab eq 'candidate_details' ? 'active' : ''}">Candidate Info</a>
        

        <a href="${pageContext.request.contextPath}/logout" class="nodal-dashboard-link ms-auto logout-link" onclick="clearAuthCookie()">
            <i class="fas fa-sign-out-alt me-1"></i> Log out
        </a>
    </div>
</nav>
