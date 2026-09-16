<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Dashboard navbar copied verbatim from the matching authHome_*.jsp (index-style #menu-bar) --%>
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
                <li><a href="${pageContext.request.contextPath}/reports/students_not_admitted">Students Not Admitted </a></li>
                <li><a href="${pageContext.request.contextPath}/reports/Jdgetdasboardreport">Api Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/PhaseWiseAdmissionReport">Phase Wise Admission Details</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/AdmissionScheduleITI">Today Schedule ITIs</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/Dist_wise_open_seats">DIST/ITI/Trade Wise Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/trade_seats_abstract_duration_wise">Duration Wise Trade Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/govt_pvt_dist_seats_abstract">Govt or Pvt Dist Wise Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/District_Wise_Application_count">Verification Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/DSC_List_secondphase">DSC List</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/statewidecastewiseabstractinter">Caste Wise Admissions Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/district_schedule">District Schedule</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/Shift_Unit_Report">Shift Unit Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/Govt_Pvt_admitted_seats_abstract">Admitted Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/RolesReport">All Resource Roles</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/Seats_Abstract_Strength_filled_Interface">Dist Wise Admitted Seats Abstract</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/tradewise_admission_report">Trade/Dist Wise Admission Report</a></li>
                <li><a href="${pageContext.request.contextPath}/reports/tradewise_vacant_position">Trade Wise Vacant Position</a></li>
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
