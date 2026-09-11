<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>:: ITI ::</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
            <style>
#menu-bar {
  width: 100%;
  margin: 0px 0px 0px 0px;
  padding: 0px 0px 0px 0px;
  height: 30px;
  line-height: 100%;
  border-radius: 0px;
  -webkit-border-radius: 24px;
  -moz-border-radius: 24px;
  box-shadow: 2px 2px 2px #666666;
  -webkit-box-shadow: 2px 2px 2px #666666;
  -moz-box-shadow: 2px 2px 2px #666666;
  background: #e4eeb9;
  position:relative;
  z-index:999;
}
#menu-bar li {
  margin: 0px 0px 6px 0px;
  padding: 0px 6px 0px 6px;
  float: left;
  position: relative;
  list-style: none;
}
#menu-bar a {
  font-weight: bold;
  font-family: verdana;
  font-size: 14px;
  color: #000000;
  background: #e4eeb9;
  text-decoration: none;
  display: block;
  padding: 6px 20px 6px 20px;
  margin: 0;
  margin-bottom: 6px;
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
}
#menu-bar li ul li a {
  margin: 0;
}
#menu-bar .active a, #menu-bar li:hover > a {
  background:blue;
  background: lightblue;
  background: -ms-linear-gradient(top,  #EB4954,  #A19197);
  background: -webkit-gradient(linear, left top, left bottom, from(#EB4954), to(#A19197));
  background: -moz-linear-gradient(top,  #EB4954,  #A19197);
  color: white;
  -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
  -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
  box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
}
#menu-bar ul li:hover a, #menu-bar li:hover li a {
  background: lightgoldenrodyellow;
  color: #000000;
  -box-shadow: none;
  -webkit-box-shadow: none;
  -moz-box-shadow: none;
}
#menu-bar ul a:hover {
  background: lightblue!important;
  color: black !important;
  border-radius: 0;
  -webkit-border-radius: 0;
  -moz-border-radius: 0;
}
#menu-bar li:hover > ul {
  display: block;
}
#menu-bar ul {
  background: linear-gradient(top,  #FFD21C,  #CF7688);
  background: -ms-linear-gradient(top,  #FFD21C,  #CF7688);
  background: -webkit-gradient(linear, left top, left bottom, from(#FFD21C), to(#CF7688));
  background: -moz-linear-gradient(top,  #FFD21C,  #CF7688);
  display: none;
  margin: 0;
  padding: 0;
  width: 300px;
  position: absolute;
  top: 30px;
  left: 0;
  border-radius: 0px;
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
  -webkit-box-shadow: 2px 2px 3px #222222;
  -moz-box-shadow: 2px 2px 3px #222222;
  box-shadow: 2px 2px 3px #222222;
}
#menu-bar ul li {
  float: none;
  margin: 0;
  padding: 0;
}
#menu-bar ul a {
  padding:10px 0px 10px 15px;
  background: gold;
  color:grey;
  font-size:13px;
  font-style:normal;
  font-family:verdana;
  font-weight: normal;
  text-shadow: 2px 2px 3px #FFFFFF;
}
#menu-bar ul li:first-child > a {
  border-top-left-radius: 10px;
  -webkit-border-top-left-radius: 10px;
  -moz-border-radius-topleft: 10px;
  border-top-right-radius: 10px;
  -webkit-border-top-right-radius: 10px;
  -moz-border-radius-topright: 10px;
}
#menu-bar ul li:last-child > a {
  border-bottom-left-radius: 10px;
  -webkit-border-bottom-left-radius: 10px;
  -moz-border-radius-bottomleft: 10px;
  border-bottom-right-radius: 10px;
  -webkit-border-bottom-right-radius: 10px;
  -moz-border-radius-bottomright: 10px;
}
#menu-bar:after {
  content: ".";
  display: block;
  clear: both;
  visibility: hidden;
  line-height: 0;
  height: 0;
}
#menu-bar {
  display: inline-block;
}
  html[xmlns] #menu-bar {
  display: block;
}
* html #menu-bar {
  height: 1%;
}
        body { margin:0; font-family: Verdana, Arial, sans-serif; background:#fff; }
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
            <li><a href="${pageContext.request.contextPath}/reports/DSC_List_secondphase">DSC List</a></li>
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
