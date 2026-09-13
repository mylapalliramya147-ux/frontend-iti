<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>:: ITI - Admin Dashboard ::</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/images/iti.png" />
    <style>
        #menu-bar { width:100%; margin:0; padding:0; height:45px; background:#e4eeb9; position:relative; z-index:999; }
        #menu-bar li { margin:0; padding:0 6px; float:left; position:relative; list-style:none; }
        #menu-bar a { font-weight:bold; font-family:verdana; font-size:14px; color:#000; background:#e4eeb9; text-decoration:none; display:block; padding:6px 20px; }
        #menu-bar .active a, #menu-bar li:hover > a { background:lightblue; color:white; }
        #menu-bar ul { display:none; margin:0; padding:0; width:300px; position:absolute; top:30px; left:0; background:lightgoldenrodyellow; border-radius:10px; }
        #menu-bar li:hover > ul { display:block; }
        #menu-bar ul li { float:none; margin:0; padding:0; }
        #menu-bar ul a { padding:10px 15px; background:gold; color:grey; font-size:13px; font-weight:normal; }
        body { margin:0; font-family:Verdana, Arial, sans-serif; background:#fff; }
        .welcome-tag { margin-left:auto; padding-right:15px; color:blue; font-size:11px; line-height:1.5; }
        #footer { position:fixed; bottom:0; width:100%; padding:8px; text-align:center; background:#0E4878; font-size:12px; color:#fff; }
        #footer a { color:#fff; }
        .login-info { text-align:center; padding:40px 10px 60px; }
    </style>
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
                <li><a href="${pageContext.request.contextPath}/jsp/Jdgetdasboardreport.jsp">API Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/PhaseWiseAdmissionReport.jsp">Phase Wise Admissions</a></li>
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