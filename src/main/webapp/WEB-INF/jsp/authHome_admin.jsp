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
    <%@ include file="../navbars/state_navbar.jsp" %>
    <div class="login-info">
        <p><font color="#400040" size="4"><strong>You login in to our application ${loginCount} times</strong></font></p>
        <c:forEach var="dt" items="${lastLogins}" varStatus="st">
            <font color="#660000">${st.count}</font> <font color="#CC0000">Login Date:</font> <font color="#330000">${dt}</font><br>
        </c:forEach>
    </div>
    <div id="footer">2013 @ All Rights Reserved - <a href="http://www.ap.nic.in">National Informatics Center</a></div>
</body>
</html>