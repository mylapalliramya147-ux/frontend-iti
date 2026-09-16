<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Index-style #menu-bar for State role --%>
<ul id="menu-bar" class="no-print">
    <li>
        <a href="${pageContext.request.contextPath}/authHome"><i class="fas fa-home"></i> Home</a>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Dashboard / Reports</a>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/reports/Jdgetdasboardreport" class="${activeTab == 'state_dashboard' ? 'active' : ''}">Api Dashboard</a>
            <a href="${pageContext.request.contextPath}/reports/PhaseWiseAdmissionReport" class="${activeTab == 'phase_wise' ? 'active' : ''}">Phase Wise Admissions Details</a>
            <a href="${pageContext.request.contextPath}/reports/AdmissionScheduleITI" class="${activeTab == 'today_schedule' ? 'active' : ''}">Today Schedule ITIs</a>
            <a href="${pageContext.request.contextPath}/reports/District_Wise_Application_count" class="${activeTab == 'district_app_count' ? 'active' : ''}">Verification Report</a>
            <a href="${pageContext.request.contextPath}/reports/district_schedule" class="${activeTab == 'district_schedule' ? 'active' : ''}">District Schedule</a>
            <a href="${pageContext.request.contextPath}/reports/RolesReport" class="${activeTab == 'all_resources' ? 'active' : ''}">All Resource Role</a>
        </div>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Seat Reports</a>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/reports/Dist_wise_open_seats" class="${activeTab == 'open_seats' ? 'active' : ''}">DIST/ITI/Trade Wise Seats Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/trade_seats_abstract_duration_wise" class="${activeTab == 'trade_duration' ? 'active' : ''}">Duration Wise Trade Seats Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/govt_pvt_dist_seats_abstract" class="${activeTab == 'govt_pvt' ? 'active' : ''}">Govt or Pvt Dist Wise Seats Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/Govt_Pvt_admitted_seats_abstract" class="${activeTab == 'iti_admissions' ? 'active' : ''}">Admitted Seats Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/Seats_Abstract_Strength_filled_Interface" class="${activeTab == 'strength_filled' ? 'active' : ''}">DistWise Admitted Seats Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/tradewise_admission_report" class="${activeTab == 'admission_report' ? 'active' : ''}">Trade/Dist Wise Admission Report</a>
            <a href="${pageContext.request.contextPath}/reports/tradewise_vacant_position" class="${activeTab == 'trade_vacant' ? 'active' : ''}">TradeWise Vacant Position</a>
        </div>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Other Reports</a>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/reports/DSC_List_secondphase" class="${activeTab == 'dsc_list' ? 'active' : ''}">DSC List</a>
            <a href="${pageContext.request.contextPath}/reports/statewidecastewiseabstractinter" class="${activeTab == 'caste_wise' ? 'active' : ''}">Caste Wise Admissions Abstract</a>
            <a href="${pageContext.request.contextPath}/reports/Shift_Unit_Report" class="${activeTab == 'shift_unit' ? 'active' : ''}">Shift Unit Report</a>
        </div>
    </li>
    <li>
        <a href="${pageContext.request.contextPath}/logout" onclick="clearAuthCookie()"><i class="fas fa-sign-out-alt"></i> Log out</a>
    </li>
</ul>
