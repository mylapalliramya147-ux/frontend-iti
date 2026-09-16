<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>:: ITI ::</title>
<link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

</head>

<body class="portal-page">

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
            <a href="${pageContext.request.contextPath}/reports/itilist">ITI LIST</a>
        </div>
    </li>
    <li>
        <a>STRIVE</a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/reports/aboutstrive">ABOUT STRIVE</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/disclosuremanagement">Disclosure Management</a></li>
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

<!-- ================= LOGIN FORM ================= -->
<form name="LoginForm" method="post" action="${pageContext.request.contextPath}/iti/login.do" onsubmit="submit1()" style="padding: 0 30px; box-sizing: border-box;">
<table width="100%" border="0" style="border-collapse:collapse;">
<tr>
<td width="30%">
    <table border="0" style="float:right; margin-top: -20px; margin-left: 10px; max-width: 100%; padding-bottom: 100px; border: 3px solid red; background-color:#e4eeb9;">
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
                    <center><h1>Welcome to ITI MIS</h1></center>
                    <% String err = request.getParameter("error"); if (err != null) { %>
                    <center>
                        <font color="red"><b>
                        <%= "captcha".equals(err) ? "Invalid captcha, please try again."
                          : "invalid".equals(err) ? "Invalid username or password."
                          : "inactive".equals(err) ? "Your account is inactive. Contact administrator."
                          : "session".equals(err) ? "Please login to continue."
                          : "Login service unavailable, please try again later." %>
                        </b></font>
                    </center>
                    <% } %>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="right">
                        <tbody><tr>
                            <center><img align="center" src="${pageContext.request.contextPath}/images/ap.png" alt="ANDHRA PRADESH" style="max-width:280px;" /></center>
                        </tr>
                    </tbody></table>
                </div>
            </div>
        </td></tr>
    </table>
</td>

<td width="25%">
    <br/>
    <table style="float:right; top: 0; max-width: 100%; border: 3px solid red; background-color:#e4eeb9;">
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
                <input type="text" autocomplete="off" id="captcha" name="captcha" tabindex="3" maxlength="4" required
                       onblur="validateFreeSpace(this.value, this, 'Please Enter The Letters Shown In Picture')" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td align="center">
                <span id="captchaRef" title="Get a new captcha" style="cursor:pointer; display:inline-block; vertical-align:middle;">
                    <svg width="28" height="24" viewBox="0 0 24 24" fill="#1a6bb5" xmlns="http://www.w3.org/2000/svg">
                        <path d="M17.65 6.35A7.958 7.958 0 0012 4c-4.42 0-7.99 3.58-8 8h3a5 5 0 018.54-3.54L13 11h7V4l-2.35 2.35z"/>
                        <path d="M6.35 17.65A7.958 7.958 0 0012 20c4.42 0 7.99-3.58 8-8h-3a5 5 0 01-8.54 3.54L11 13H4v7l2.35-2.35z"/>
                    </svg>
                </span>
                <img src="${pageContext.request.contextPath}/captcha" id="captchaImage" border="0" width="135px" height="30px" />
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
</td>
</tr>
</table>
</form>

<!-- ================= SCRIPTS ================= -->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/md5.js"></script>

<script>
function submit1() {
    // Send the password as-is; the backend handles authentication.
}

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

function blinker() {
    $('.blinking').fadeOut(500);
    $('.blinking').fadeIn(500);
}
setInterval(blinker, 1000);

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

</body>
</html>