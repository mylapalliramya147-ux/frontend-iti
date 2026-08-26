<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>:: ITI ::</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <style>
        body { margin:0; font-family: Verdana, Arial, sans-serif; background:#fff; }
        #menu-bar { width:100%; margin:0; padding:0; height:45px; box-shadow:2px 2px 2px #666;
            background:#e4eeb9; position:relative; z-index:999; display:flex; align-items:center; }
        #menu-bar ul { list-style:none; margin:0; padding:0; display:flex; }
        #menu-bar > ul { width:100%; }
        #menu-bar li { position:relative; }
        #menu-bar a { font-weight:bold; font-size:14px; color:#000; text-decoration:none;
            display:block; padding:12px 20px; background:#e4eeb9; }
        #menu-bar li:hover > a { color:#fff; background:#4a7ebb; }
        #menu-bar li ul { display:none; position:absolute; top:44px; left:0; min-width:260px;
            background:#ffd21c; box-shadow:2px 2px 3px #222; z-index:9999; flex-direction:column; }
        #menu-bar li:hover > ul { display:block; }
        #menu-bar li ul a { font-size:13px; padding:10px 15px; background:#ffd21c; color:#555; font-weight:normal; }
        #menu-bar li ul a:hover { background:#87ceeb; color:#000; }
        .welcome-tag { margin-left:auto; padding-right:15px; color:blue; font-size:11px; text-align:left; line-height:1.5; }
        #footer { position:fixed; bottom:0; width:100%; height:25px; padding-top:8px; text-align:center;
            background:#0E4878; border-top:1px #000 solid; font-size:12px; color:#fff; }
        #footer a { color:#fff; }
        .login-info { text-align:center; padding:40px 10px 60px; }
    </style>
</head>
<body>

<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
</center>

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
        </ul>
    </li>

    <li><a href="#">Admissions</a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/DgtPermittedShift">DGT Permitted Shifts Units Report</a></li>
            <li><a href="${pageContext.request.contextPath}/PrintAdmissionSlip">Print Admission Slip</a></li>
            <li><a href="${pageContext.request.contextPath}/DSC_List_secondphase">DSC List</a></li>
            <li><a href="${pageContext.request.contextPath}/AdmissionPhase1">Schedule Entry</a></li>
        </ul>
    </li>

    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>

    <li class="welcome-tag">
        Welcome, ${username}<br>
        ${itiName}
    </li>
</ul>

<div class="login-info">
    <p>
        <font color="#400040" size="4" face="Courier New"><strong>You login in to our application ${loginCount} times</strong></font><br>
        <font color="#0000FF"><strong>Your Last Five login Details are :</strong></font><br>
    </p>
    <strong>
        <c:forEach var="dt" items="${lastLogins}" varStatus="st">
            <font color="#660000">${st.count}</font>
            <font color="#CC0000">Login Date and Time :</font>
            <font color="#330000">${dt}</font><br><br>
        </c:forEach>
    </strong>
</div>

<div id="footer">
    2013 @ All Rights Reserved &nbsp;&nbsp; Designed by &nbsp;
    <a href="http://www.ap.nic.in">National Informatics Center</a> &nbsp;&nbsp;
    <a href="${pageContext.request.contextPath}/reports/disclaimer">Disclaimer</a>
</div>

</body>
</html>
