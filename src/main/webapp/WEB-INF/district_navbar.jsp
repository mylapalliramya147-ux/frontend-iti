<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Dashboard navbar copied verbatim from the matching authHome_*.jsp (index-style #menu-bar) --%>
<ul id="menu-bar">
        <li><a href="${pageContext.request.contextPath}/authHome">Home</a></li>
        <li><a href="#">ITI Services</a><ul></ul></li>
        <li><a href="#">ITI Reports</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/reports/Applicant_mobile_addr">Applicant Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/getDashboardreport_dist">API Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/statewidecastewiseabstractinter">Caste Wise Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/District_Wise_Application_count">Verification Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/DSC_List_secondphase">DSC List</a></li>
            </ul>
        </li>
        <li><a href="#">Admissions</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/reports/permitted_shift_unit_report">DGT Permitted Shifts Report</a></li>
                
                <li><a href="${pageContext.request.contextPath}/reports/DeleteAdmission_interface">Discharge Admission</a></li>
            </ul>
        </li>
        <li><a href="#">SCVT Exams</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/jsp/ScvtExams_RDD_DCP">SCVT Exam Verification</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/scvt_certificate_interface">SCVT Certificate</a></li>
            </ul>
        </li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        <c:if test="${not empty sessionScope.username}"><li class="welcome-tag">Welcome, ${fullName}<br>District</li></c:if>
    </ul>
