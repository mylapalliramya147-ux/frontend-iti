<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>:: ITI - Admin Dashboard ::</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/images/iti.png" />
    <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/images/iti.png" />
    <style>
        body { margin: 0; font-family: Verdana, Arial, sans-serif; background: #fff; }
        #footer {
            position: fixed;
            bottom: 0px;
            width: 100%;
            height: 25px;
            padding-top: 8px;
            text-align: center;
            background-color: #0E4878;
            border-top: 1px #000000 solid;
            font-size: 12px;
            font-family: arial, verdana;
            color: #ffffff;
        }
        #footer a { color: white; }
        .login-info { text-align: center; padding: 40px 10px 60px; }
    </style>
    <style>
        body { margin:0; font-family:Verdana, Arial, sans-serif; background:#fff; }
        #footer { position:fixed; bottom:0; width:100%; padding:8px; text-align:center; background:#0E4878; font-size:12px; color:#fff; }
        #footer a { color:#fff; }
        .login-info { text-align:center; padding:40px 10px 60px; }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
</head>
<body>
    <center><img src="${pageContext.request.contextPath}/images/gen.jpg" width="100%" alt="Banner" /></center>
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
        <li class="welcome-tag">Welcome, ${fullName}<br>Admin</li>
    </ul>
    <div class="login-info">
        <p><font color="#400040" size="4"><strong>You login in to our application ${loginCount} times</strong></font></p>
        <c:forEach var="dt" items="${lastLogins}" varStatus="st">
            <font color="#660000">${st.count}</font> <font color="#CC0000">Login Date:</font> <font color="#330000">${dt}</font><br>
        </c:forEach>
    </div>
    <div id="footer">2013 @ All Rights Reserved - <a href="http://www.ap.nic.in">National Informatics Center</a></div>
</body>
</html>