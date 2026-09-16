<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Dashboard navbar copied verbatim from the matching authHome_*.jsp (index-style #menu-bar) --%>
<ul id="menu-bar">
    <li><a href="${pageContext.request.contextPath}/authHome">Home</a></li>

    <li><a href="#">ITI Services</a>
        <ul></ul>
    </li>

            <li><a href="#">ITI Reports</a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/reports/getDashboardreport_iti">API Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/Applicant_Report">Applicant Report</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/api_report">Admission Report</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/DSC_List_secondphase">DSC List</a></li>
        </ul>
    </li>

            <li><a href="#">Admissions</a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/DgtPermittedShift">DGT Permitted Shifts Units Report</a></li>
            <li><a href="${pageContext.request.contextPath}/PrintAdmissionSlip">Print Admission Slip</a></li>
            <li><a href="${pageContext.request.contextPath}/AdmissionPhase1">Schedule Entry</a></li>
        </ul>
    </li>

    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>

    <c:if test="${not empty sessionScope.username}"><li class="welcome-tag">
        Welcome, ${username}<br>
        ${itiName}
    </li></c:if>
</ul>
