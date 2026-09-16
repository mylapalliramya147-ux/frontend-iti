<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Index-style #menu-bar for District role --%>
<ul id="menu-bar" class="no-print">
    <li>
        <a href="${pageContext.request.contextPath}/authHome"><i class="fas fa-home"></i> Home</a>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Reports</a>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/reports/dsc-full" class="${activeTab == 'dsc_full' ? 'active' : ''}">DSC Full</a>
            <a href="${pageContext.request.contextPath}/reports/applicant-report-by-phase" class="${activeTab == 'applicant_phase' ? 'active' : ''}">Applicant Report</a>
            <a href="${pageContext.request.contextPath}/reports/caste-wise-admissions" class="${activeTab == 'caste_wise' ? 'active' : ''}">Caste Wise</a>
            <a href="${pageContext.request.contextPath}/reports/applicant-mobile-address" class="${activeTab == 'applicant_mobile' ? 'active' : ''}">Applicant Mobile</a>
            <a href="${pageContext.request.contextPath}/reports/verified-application-count" class="${activeTab == 'verified_count' ? 'active' : ''}">Verified Count</a>
            <a href="${pageContext.request.contextPath}/reports/api-dashboard" class="${activeTab == 'api_dashboard' ? 'active' : ''}">API Dashboard</a>
        </div>
    </li>
    <li>
        <a href="${pageContext.request.contextPath}/logout" onclick="clearAuthCookie()"><i class="fas fa-sign-out-alt"></i> Log out</a>
    </li>
</ul>
