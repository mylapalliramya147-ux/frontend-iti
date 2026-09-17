<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- ===================================================================
     STATE / ADMIN dashboard navbar (roleId 2, and the fallback for any
     other logged-in roleId, index-style #menu-bar).

     Included by (2 files):
       - reports/header.jsp            (roleId 2 + <c:otherwise> fallback
                                        branch, served inside every
                                        role-aware reports/* page)
       - jsp/authHome_admin.jsp        (State/Admin dashboard home)

     NOTE: the "c" taglib above is declared but currently unused in this
     file - the same markup was copied verbatim from the matching
     authHome_*.jsp. Keep or drop as you prefer; it is harmless.
     =================================================================== --%>
<ul id="menu-bar">
        <li><a href="${pageContext.request.contextPath}/authHome">Home</a></li>
        <li><a href="#">ITI Services</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/jsp/Password_change.jsp">Change User Password</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/Dget_Iti_Code_Interface.jsp">DGET ITI CODE</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/Register_new_user.jsp">New User Creation</a></li>
            </ul>
        </li>
        <li><a href="#">ITI Reports</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/reports/students-not-admitted">Students Not Admitted</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/api-dashboard-state">API Dashboard (State)</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/phase-wise-admissions-details">Phase Wise Admissions Details</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/today-schedule-itis">Today Schedule ITIs</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/dist-iti-trade-wise-seats-abstract">DIST/ITI/Trade Wise Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/duration-wise-trade-seats-abstract">Duration Wise Trade Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/govt-or-pvt-dist-wise-seats-abstract">Govt or Pvt Dist Wise Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/verification-report">Verification Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/dsc-list">DSC List</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/caste-wise-admissions-abstract">Caste Wise Admissions Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/district-schedule">District Schedule</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/shift-unit-report">Shift Unit Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/admitted-seats-abstract">Admitted Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/all-resource-role">All Resource Role</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/distwise-admitted-seats-abstract">DistWise Admitted Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/trade-dist-wise-admission-report">Trade/Dist Wise Admission Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/tradewise-vacant-position">TradeWise Vacant Position</a></li>
            </ul>
        </li>
        <li><a href="#">Admissions</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/jsp/StatusMaster.jsp">Freeze / UnFreeze</a></li>
            </ul>
        </li>
        <li><a href="#">SCVT Exams</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/jsp/SCVTExamInitialization.jsp">SCVT Exam Initialization</a></li>
            </ul>
        </li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        <c:if test="${not empty sessionScope.username}"><li class="welcome-tag">Welcome, ${fullName}<br>Admin</li></c:if>
    </ul>
