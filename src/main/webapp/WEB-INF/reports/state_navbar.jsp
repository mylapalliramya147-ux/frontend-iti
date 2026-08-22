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
        <a href="${pageContext.request.contextPath}/reports/state-dashboard" class="state-dashboard-link ${activeTab == 'state_dashboard' ? 'active' : ''}">State Dashboard</a>
        <a href="${pageContext.request.contextPath}/reports/district-schedule" class="state-dashboard-link ${activeTab == 'district_schedule' ? 'active' : ''}">District Schedule</a>
        <a href="${pageContext.request.contextPath}/reports/district-permitted-shift-view" class="state-dashboard-link ${activeTab == 'shift_unit' ? 'active' : ''}">Shift/Unit Report</a>
        <a href="${pageContext.request.contextPath}/reports/iti-admissions" class="state-dashboard-link ${activeTab == 'iti_admissions' ? 'active' : ''}">ITI Admissions</a>
        <a href="${pageContext.request.contextPath}/reports/all-resource-roles" class="state-dashboard-link ${activeTab == 'all_resources' ? 'active' : ''}">All Resource Roles</a>
        <a href="${pageContext.request.contextPath}/reports/strength-filled-seats" class="state-dashboard-link ${activeTab == 'strength_filled' ? 'active' : ''}">Strength & Fill</a>
        <a href="${pageContext.request.contextPath}/reports/trade-vacant-positions" class="state-dashboard-link ${activeTab == 'trade_vacant' ? 'active' : ''}">Trade Vacant</a>
        <a href="${pageContext.request.contextPath}/reports/admission_report" class="state-dashboard-link ${activeTab == 'admission_report' ? 'active' : ''}">Admission Report</a>

        <a href="${pageContext.request.contextPath}/logout" class="state-dashboard-link ms-auto" onclick="clearAuthCookie()">
            <i class="fas fa-sign-out-alt me-1"></i> Log out
        </a>
    </div>
</nav>
