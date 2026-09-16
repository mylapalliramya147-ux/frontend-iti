<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Dashboard navbar copied verbatim from the matching authHome_*.jsp (index-style #menu-bar) --%>
<ul id="menu-bar">
        <li><a href="${pageContext.request.contextPath}/authHome">Home</a></li>
        <li><a href="#">ITI Services</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/jsp/Password_change.jsp">Change User Password</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/Registration.jsp">Add ITI Master</a></li>
            </ul>
        </li>
        <li><a href="#">ITI Reports</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/reports/Jdgetdasboardreport">API Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/PhaseWiseAdmissionReport">Phase Wise Admissions</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/AdmissionScheduleITI">Today Schedule ITIs</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/admissiongenderwise">Trade Wise Reports</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/Applicant_Report_StateWise">Applicant Report District Wise</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/Dist_wise_open_seats">DIST/ITI/Trade Wise Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/trade_seats_abstract_duration_wise">Duration Wise Trade Seats Abstract </a></li>
                <li><a href="${pageContext.request.contextPath}/reports/govt_pvt_dist_seats_abstract">Govt or Pvt Dist Wise Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/std_reg_details_report">Student Reg Deatails</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/students_not_admitted">Students Not Admitted</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/District_Wise_Application_count">Verification Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/statewidecastewiseabstractinter">Caste Wise Admissions Abstract</a></li>
            </ul>
        </li>
        <li><a href="#">Admissions</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/jsp/permitted_shift_unit_nodal_report.jsp">DGT Permitted Shifts Report</a></li>
            </ul>
        </li>
        <li><a href="#">SCVT Exams</a><ul></ul></li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        <c:if test="${not empty sessionScope.username}"><li class="welcome-tag">Welcome, ${fullName}<br>Nodal Officer</li></c:if>
    </ul>
