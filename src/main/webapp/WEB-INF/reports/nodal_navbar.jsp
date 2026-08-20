<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Modern Dashboard Navigation (Shared Component) -->
<nav class="nodal-dashboard-navbar no-print">
    <div class="container-fluid d-flex justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/authHome" class="nodal-dashboard-link ${activeTab == 'home' ? 'active' : ''}">
            <i class="fas fa-home me-1"></i> Home
        </a>
        <a href="${pageContext.request.contextPath}/reports/state-dashboard" class="nodal-dashboard-link ${activeTab == 'api_dashboard' ? 'active' : ''}">State Dashboard</a>
        <a href="${pageContext.request.contextPath}/reports/phase-wise" class="nodal-dashboard-link ${activeTab == 'phase_wise' ? 'active' : ''}">Phase-Wise</a>
        <a href="${pageContext.request.contextPath}/reports/today-schedule" class="nodal-dashboard-link ${activeTab == 'today_schedule' ? 'active' : ''}">Today Schedule</a>
        <a href="${pageContext.request.contextPath}/reports/trade-wise-report" class="nodal-dashboard-link ${activeTab == 'trade_wise' ? 'active' : ''}">Trade-Wise</a>
        <a href="${pageContext.request.contextPath}/reports/applicant-report-state-wise" class="nodal-dashboard-link ${activeTab == 'applicant_state' ? 'active' : ''}">Applicant Report</a>
        <a href="${pageContext.request.contextPath}/reports/open-seats" class="nodal-dashboard-link ${activeTab == 'open_seats' ? 'active' : ''}">Open Seats</a>
        <a href="${pageContext.request.contextPath}/reports/trade-duration-seats" class="nodal-dashboard-link ${activeTab == 'trade_duration' ? 'active' : ''}">Trade Duration</a>
        <a href="${pageContext.request.contextPath}/reports/govt-pvt-seats" class="nodal-dashboard-link ${activeTab == 'govt_pvt' ? 'active' : ''}">Govt/Pvt Seats</a>
        <a href="${pageContext.request.contextPath}/reports/student-details" class="nodal-dashboard-link ${activeTab == 'student_details' ? 'active' : ''}">Student Details</a>
        <a href="${pageContext.request.contextPath}/reports/district-wise-application-count" class="nodal-dashboard-link ${activeTab == 'district_app_count' ? 'active' : ''}">District App Count</a>
        <a href="${pageContext.request.contextPath}/logout" class="nodal-dashboard-link ms-auto logout-link" onclick="clearAuthCookie()">
            <i class="fas fa-sign-out-alt me-1"></i> Log out
        </a>
    </div>
</nav>
