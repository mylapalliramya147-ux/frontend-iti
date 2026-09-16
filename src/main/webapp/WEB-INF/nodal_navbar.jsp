<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Index-style #menu-bar for Nodal role --%>
<ul id="menu-bar" class="no-print">
    <li>
        <a href="${pageContext.request.contextPath}/authHome"><i class="fas fa-home"></i> Home</a>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Reports</a>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/reports/Jdgetdasboardreport" class="${activeTab == 'api_dashboard' ? 'active' : ''}">Api Dashboard</a>
            <a href="${pageContext.request.contextPath}/reports/PhaseWiseAdmissionReport" class="${activeTab == 'phase_wise' ? 'active' : ''}">Phase Wise Admissions Details</a>
            <a href="${pageContext.request.contextPath}/reports/AdmissionScheduleITI" class="${activeTab == 'today_schedule' ? 'active' : ''}">Today Schedule ITIs</a>
            <a href="${pageContext.request.contextPath}/reports/admissiongenderwise" class="${activeTab == 'trade_wise' ? 'active' : ''}">Trade Wise Report</a>
            <a href="${pageContext.request.contextPath}/reports/Applicant_Report_StateWise" class="${activeTab == 'applicant_state' ? 'active' : ''}">Applicant Report Dist Wise</a>
            <a href="${pageContext.request.contextPath}/reports/Dist_wise_open_seats" class="${activeTab == 'open_seats' ? 'active' : ''}">DIST/ITI/Trade Wise Seats Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/trade_seats_abstract_duration_wise" class="${activeTab == 'trade_duration' ? 'active' : ''}">Duration Wise Trade Seats Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/govt_pvt_dist_seats_abstract" class="${activeTab == 'govt_pvt' ? 'active' : ''}">Govt or Pvt Dist Wise Seats Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/std_reg_details_report" class="${activeTab == 'student_details' ? 'active' : ''}">STUDENT REG DETAILS</a>
            <a href="${pageContext.request.contextPath}/reports/District_Wise_Application_count" class="${activeTab == 'district_app_count' ? 'active' : ''}">Verification Report</a>
        </div>
    </li>
    <li>
        <a href="${pageContext.request.contextPath}/logout" onclick="clearAuthCookie()"><i class="fas fa-sign-out-alt"></i> Log out</a>
    </li>
</ul>
