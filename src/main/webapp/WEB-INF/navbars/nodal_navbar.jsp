<%@ page language="java" pageEncoding="UTF-8" %>
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
                <li><a href="${pageContext.request.contextPath}/reports/api-dashboard-state">API Dashboard (State)</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/phase-wise-admissions-details">Phase Wise Admissions Details</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/today-schedule-itis">Today Schedule ITIs</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/trade-wise-report">Trade Wise Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/applicant-report-dist-wise">Applicant Report Dist Wise</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/dist-iti-trade-wise-seats-abstract">DIST/ITI/Trade Wise Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/duration-wise-trade-seats-abstract">Duration Wise Trade Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/govt-or-pvt-dist-wise-seats-abstract">Govt or Pvt Dist Wise Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/student-reg-details">Student Reg Details</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/students-not-admitted">Students Not Admitted</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/verification-report">Verification Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/caste-wise-admissions-abstract">Caste Wise Admissions Abstract</a></li>
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
