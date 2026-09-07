<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Modern Dashboard Navigation (Shared Component) -->
<nav class="nodal-dashboard-navbar no-print">
    <div class="container-fluid d-flex justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/authHome" class="nodal-dashboard-link ${activeTab == 'home' ? 'active' : ''}">
            <i class="fas fa-home me-1"></i> Home
        </a>
        <a href="${pageContext.request.contextPath}/reports/Jdgetdasboardreport" class="nodal-dashboard-link ${activeTab == 'api_dashboard' ? 'active' : ''}">Api Dashboard</a>
        <a href="${pageContext.request.contextPath}/reports/PhaseWiseAdmissionReport" class="nodal-dashboard-link ${activeTab == 'phase_wise' ? 'active' : ''}">Phase Wise Admissions Details</a>
        <a href="${pageContext.request.contextPath}/reports/AdmissionScheduleITI" class="nodal-dashboard-link ${activeTab == 'today_schedule' ? 'active' : ''}">Today Schedule ITIs</a>
        <a href="${pageContext.request.contextPath}/reports/admissiongenderwise" class="nodal-dashboard-link ${activeTab == 'trade_wise' ? 'active' : ''}">Trade Wise Report</a>
        <a href="${pageContext.request.contextPath}/reports/Applicant_Report_StateWise" class="nodal-dashboard-link ${activeTab == 'applicant_state' ? 'active' : ''}">Applicant Report Dist Wise</a>
        <a href="${pageContext.request.contextPath}/reports/Dist_wise_open_seats" class="nodal-dashboard-link ${activeTab == 'open_seats' ? 'active' : ''}">DIST/ITI/Trade Wise Seats Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/trade_seats_abstract_duration_wise" class="nodal-dashboard-link ${activeTab == 'trade_duration' ? 'active' : ''}">Duration Wise Trade Seats Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/govt_pvt_dist_seats_abstract" class="nodal-dashboard-link ${activeTab == 'govt_pvt' ? 'active' : ''}">Govt or Pvt Dist Wise Seats Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/std_reg_details_report" class="nodal-dashboard-link ${activeTab == 'student_details' ? 'active' : ''}">STUDENT REG DETAILS</a>
        <a href="${pageContext.request.contextPath}/reports/District_Wise_Application_count" class="nodal-dashboard-link ${activeTab == 'district_app_count' ? 'active' : ''}">Verification Report</a>
        <a href="${pageContext.request.contextPath}/logout" class="nodal-dashboard-link ms-auto logout-link" onclick="clearAuthCookie()">
            <i class="fas fa-sign-out-alt me-1"></i> Log out
        </a>
    </div>
</nav>
