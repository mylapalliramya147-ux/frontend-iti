<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .state-dashboard-navbar {
        background: #003366;
        padding: 10px 0;
        margin-bottom: 20px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    .state-dashboard-link {
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
    .state-dashboard-link:hover {
        color: white;
        background: rgba(255, 255, 255, 0.1);
        text-decoration: none;
    }
    .state-dashboard-link.active {
        color: white;
        background: #1a4a72;
        border-bottom: 3px solid #ffcc00;
    }
</style>

<nav class="state-dashboard-navbar no-print">
    <div class="container-fluid d-flex justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/authHome" class="state-dashboard-link">
            <i class="fas fa-home me-1"></i> Home
        </a>
        <a href="${pageContext.request.contextPath}/reports/Jdgetdasboardreport" class="state-dashboard-link ${activeTab == 'state_dashboard' ? 'active' : ''}">Api Dashboard</a>
        <a href="${pageContext.request.contextPath}/reports/PhaseWiseAdmissionReport" class="state-dashboard-link ${activeTab == 'phase_wise' ? 'active' : ''}">Phase Wise Admissions Details</a>
        <a href="${pageContext.request.contextPath}/reports/AdmissionScheduleITI" class="state-dashboard-link ${activeTab == 'today_schedule' ? 'active' : ''}">Today Schedule ITIs</a>
        <a href="${pageContext.request.contextPath}/reports/Dist_wise_open_seats" class="state-dashboard-link ${activeTab == 'open_seats' ? 'active' : ''}">DIST/ITI/Trade Wise Seats Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/trade_seats_abstract_duration_wise" class="state-dashboard-link ${activeTab == 'trade_duration' ? 'active' : ''}">Duration Wise Trade Seats Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/govt_pvt_dist_seats_abstract" class="state-dashboard-link ${activeTab == 'govt_pvt' ? 'active' : ''}">Govt or Pvt Dist Wise Seats Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/District_Wise_Application_count" class="state-dashboard-link ${activeTab == 'district_app_count' ? 'active' : ''}">Verification Report</a>
        <a href="${pageContext.request.contextPath}/reports/DSC_List_secondphase" class="state-dashboard-link ${activeTab == 'dsc_list' ? 'active' : ''}">DSC List</a>
        <a href="${pageContext.request.contextPath}/reports/statewidecastewiseabstractinter" class="state-dashboard-link ${activeTab == 'caste_wise' ? 'active' : ''}">Caste Wise Admissions Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/district_schedule" class="state-dashboard-link ${activeTab == 'district_schedule' ? 'active' : ''}">District Schedule</a>
        <a href="${pageContext.request.contextPath}/reports/Shift_Unit_Report" class="state-dashboard-link ${activeTab == 'shift_unit' ? 'active' : ''}">Shift Unit Report</a>
        <a href="${pageContext.request.contextPath}/reports/Govt_Pvt_admitted_seats_abstract" class="state-dashboard-link ${activeTab == 'iti_admissions' ? 'active' : ''}">Admitted Seats Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/RolesReport" class="state-dashboard-link ${activeTab == 'all_resources' ? 'active' : ''}">All Resource Role</a>
        <a href="${pageContext.request.contextPath}/reports/Seats_Abstract_Strength_filled_Interface" class="state-dashboard-link ${activeTab == 'strength_filled' ? 'active' : ''}">DistWise Admitted Seats Abstract</a>
        <a href="${pageContext.request.contextPath}/reports/tradewise_admission_report" class="state-dashboard-link ${activeTab == 'admission_report' ? 'active' : ''}">Trade/Dist Wise Admission Report</a>
        <a href="${pageContext.request.contextPath}/reports/tradewise_vacant_position" class="state-dashboard-link ${activeTab == 'trade_vacant' ? 'active' : ''}">TradeWise Vacant Position</a>

        <a href="${pageContext.request.contextPath}/logout" class="state-dashboard-link ms-auto" onclick="clearAuthCookie()">
            <i class="fas fa-sign-out-alt me-1"></i> Log out
        </a>
    </div>
</nav>
