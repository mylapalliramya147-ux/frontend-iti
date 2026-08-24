<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI ::</title>
<link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js1/jquery.min.js"></script>

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
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>

/* ================= MENU CSS (Your Existing) ================= */

#menu-bar {
  width: 100%;
  height: 30px;
  box-shadow: 2px 2px 2px #666666;
  background: #e4eeb9;
  position:relative;
  z-index:999;
}

.dropdown { position: relative; display: inline-block; }

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
}

.dropdown-content a {
    padding: 12px 16px;
    display: block;
}

.dropdown:hover .dropdown-content { display: block; }

/* ================= POPUP CSS ================= */

.popup-overlay {
    display: none;
    position: fixed;
    z-index: 99999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.7);
}

.popup-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    padding: 8px;
    border-radius: 10px;
}

.popup-img {
    width: 500px;
    max-width: 90%;
    height: auto;
    cursor: pointer;
}

.close-btn {
    position: absolute;
    top: 5px;
    right: 12px;
    font-size: 30px;
    color: red;
    cursor: pointer;
}

</style>
</head>

<body>

<!-- ================= BANNER IMAGE ================= -->
<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
</center>
<br>

<!-- ================= MENU BAR ================= -->

<ul id="menu-bar">
<li>
    <a href="${pageContext.request.contextPath}/">Home</a>
</li>

<li class="dropdown">
    <a href="javascript:void(0)">ITI Profile</a>
    <div class="dropdown-content">
        <a href="${pageContext.request.contextPath}/reports/itiprofile">ITI Profile</a>
        <a href="${pageContext.request.contextPath}/reports/Jdgetdasboardreport">ITI LIST</a>
    </div>
</li>

<li>
<a>STRIVE</a>
<ul>
<li><a href="${pageContext.request.contextPath}/aboutstrive.jsp">ABOUT STRIVE</a></li>
<li><a href="${pageContext.request.contextPath}/disclosuremanagement.jsp">Disclosure Management</a></li>
</ul>
</li>

<li>
<a href="/placements">PLACEMENTS / IN-PLANT TRAINING</a>
</li>
</ul>

<br><br>

<!-- ================= MARQUEE ================= -->
<marquee onmouseover="this.stop();" onmouseout="this.start();" scrolldelay="100">
<b>
<font color="blue" size="5">
<a href="#" target="_blank"> ITI Admissions 2026 Phase -3 registrations, applications and verifications available in all GovtPvts ITIs on 15-08-2026 and 19-08-2026. </a>
</font>
</b>
</marquee>

<!-- ================= POPUP SCRIPT ================= -->
<script>
window.onload = function () {
    var popup = document.getElementById("airforcePopup");
    if (popup) {
        popup.style.display = "block";
        setTimeout(function () { closeAirforcePopup(); }, 10000);
    }
};
function closeAirforcePopup() {
    var popup = document.getElementById("airforcePopup");
    if (popup) {
        popup.style.display = "none";
    }
}
</script>

</body>

<!-- ================= LOGIN FORM ================= -->
<form name="LoginForm" method="post" action="${pageContext.request.contextPath}/iti/login.do" onsubmit="submit1()">
<table width="100%" border="0" style="border-collapse:collapse;">
<tr><td width="30%">
    <table border="0" style="float:right; margin-top: -20px; padding-bottom: 100px; border: 3px solid red; background-color:#e4eeb9;">
        <tr><td>
            <ul>
                <h2><span><font color="#660000"><b>Student Area</b></font></span></h2>
                <span><font color="#660000"><b>1:&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/open_application_entry.jsp"><font color="blue">Student Registration (Registration Only)</font></a></b></span><br><br>
                <span><font color="#660000"><b>2:&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/open_editview_form_phase2.jsp"><font color="blue">Application to apply for ITI</font></a></b></span><br><br>
                <h2>If Student is not Registered both Steps 1 and 2 are Mandatory for Applying to ITI</h2>
                <span><font color="#660000"><b>3:&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/open_edit_form.jsp"><font color="blue">Edit Registration</font></a></b></span><br><br>
                <span><font color="#660000"><b>4:&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/forgotregid.jsp"><font color="blue">Forgot Registration ID</font></a></b></span>
            </ul>
        </td></tr>
    </table>
</td>

<td width="45%"><br><br>
    <table border="0" align="center">
        <tr><td>
            <div id="content">
                <div class="box">
                    <center>
                        <font color="red"><b></b></font>
                    </center>
                    <center><h1>Welcome to ITI MIS</h1></center>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="right">
                        <tbody><tr>
                            <center><img align="center" src="${pageContext.request.contextPath}/js/img/states/ap.jpg" alt="ANDHRA PRADESH" /></center>
                        </tr>
                    </tbody></table>
                </div>
            </div>
        </td></tr>
    </table>
</td>

<td width="25%">
    <br/>
    <table style="float:right; top: 0; border: 3px solid red; background-color:#e4eeb9;">
        <tr><td colspan="2" align="center"><h2><font color="#660000"><b>For Officials</b></h2></td></tr>
        <tr><td colspan="2" align="center"><h2><font color="#660000"><b><u>Login Here</u></b></h2></td></tr>
        <tr>
            <td><font color="#27004F"><strong>User Name<font color="red">*</font>:</strong></font></td>
            <td><input id="uname" name="uname" minlength="2" type="text" autocomplete="off" autofocus tabindex="1" required/></td>
        </tr>
        <tr>
            <td><font color="#27004F"><strong>Password<font color="red">*</font></strong></font></td>
            <td>
                <input id="pwd" name="pwd" minlength="2" type="password" required autocomplete="off" autofocus tabindex="2"/>
                <input type="hidden" name="pwdd" id="pwdd"/>
            </td>
        </tr>
        <tr>
            <td><label for="email">Captcha<font color="red">*</font>&nbsp;&nbsp;</label></td>
            <td>
                <input type="text" autocomplete="off" id="captcha" name="captcha" tabindex="3" required
                       onblur="validateFreeSpace(this.value, this, 'Please Enter The Letters Shown In Picture')"
                       onkeypress="return (event);" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td align="center">
                <image src="${pageContext.request.contextPath}/images/refresh_png.png" alt="refresh" width="40" height="30" id="captchaRef"/>
                <img src="${pageContext.request.contextPath}/captcha.jsp" id="captchaImage" border="0" width="135px" height="30px" background="red" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td align="left">
                <input id="mysubmit" value="Login" tabindex="4" type="submit"/>
            </td>
        </tr>
        <tr>
            <td align="right"><font color="#000080" size="3"><b>No of Visitors :</b></font></td>
            <td align="left"><font color="#800000" size="4"><b></b></font></td>
        </tr>
    </table>
</td></tr>
</table>
</form>

<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/md5.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/style.css" />

<script>
function submit1() {
    var pwdd = $("#pwd").val();
    $("#pwdd").val(pwdd);
    var salt = 'abcd3765321028297260356xyznull';
    var pwd = document.getElementById("pwd").value;
    var temp = hex_md5(pwd);
    temp = hex_md5(temp);
    temp2 = hex_md5(salt);
    temp2 = temp2 + temp;
    document.getElementById("pwd").value = temp2;
}
</script>

<script>
var myIndex = 0;
carousel();
function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    myIndex++;
    if (myIndex > x.length) { myIndex = 1; }
    x[myIndex - 1].style.display = "block";
    setTimeout(carousel, 2000);
}
</script>

<script>
function blinker() {
    $('.blinking').fadeOut(500);
    $('.blinking').fadeIn(500);
}
setInterval(blinker, 1000);
</script>

<script type="text/javascript">
$(document).ready(function () {
    $("#captchaRef").click(function () {
        var timestamp = (new Date()).getTime();
        var newSrc = $("#captchaImage").attr("src").split("?");
        newSrc = newSrc[0] + "?" + timestamp;
        $("#captchaImage").attr("src", newSrc);
        $("#captchaImage").slideDown("fast");
    });
    $('#captcha').keypress(function (ev) {
        if (ev.keyCode === 13) $('#mysubmit').click();
    });
});
</script>

<style>
a:link { color: lightblue; background-color: transparent; text-decoration: underline; }
a:visited { color: blue; background-color: transparent; text-decoration: none; }
a:hover { color: red; background-color: transparent; text-decoration: underline; }
a:active { color: yellow; background-color: transparent; text-decoration: underline; }
input[type=submit] {
    background-color: #4CAF50; border: none; color: white; padding: 8px 30px;
    text-align: center; text-decoration: none; display: inline-block; font-size: 16px;
    margin: 4px 2px; transition-duration: 0.4s; cursor: pointer;
}
input[type=submit]:focus { background-color: orangered; }
input[type=button] {
    background-color: #4CAF50; border: none; color: white; padding: 8px 30px;
    text-align: center; text-decoration: none; display: inline-block; font-size: 16px;
    margin: 4px 2px; transition-duration: 0.4s; cursor: pointer;
}
input[type=button]:focus { background-color:orangered; }
input[type=text], input[type=password] {
    padding: 6px 8px; margin: 8px 0; border: 1px solid #555;
}
input[type=password]:focus, input[type=text]:focus { background-color: yellow; }
#mysubmit{ font-weight: bolder; color: black; font-size: 15px; border-radius: 10%; }
</style>

<style>
.modal {
    position: fixed; z-index: 1; padding-top: 100px; left: 0; top: 0;
    width: 100%; height: 90%; overflow: auto;
    background-color: rgb(0,0,0); background-color: rgba(0,0,0,0.4);
}
.close {
    color: black; float: right; font-size: 40px; font-weight: bold;
    background-color: #ff6600; width: 100px; margin-right: 80px;
}
.close:hover, .close:focus { color: #000; text-decoration: none; cursor: pointer; }
a > input[type=button] { border: none; background-color: #e4eeb9; color: black; font-weight: bolder; }
#custom{ border: 1px solid red; background-color: #e4eeb9; margin-bottom: 20px; border-radius: 10px; height: 40px; }
</style>

<script>
$(document).ready(function(){
    var modal = document.getElementById('myModal');
    var span = document.getElementsByClassName("close")[0];
    var image = document.getElementById("modalImage");
    if (span) span.onclick = function() { modal.style.display = "none"; }
    if (image) image.onclick = function() { modal.style.display = "none"; }
});
</script>
</html>
