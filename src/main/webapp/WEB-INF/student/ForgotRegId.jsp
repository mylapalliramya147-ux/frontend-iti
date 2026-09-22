<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en-GB">
    <head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

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
  background: block;
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

        <script type="text/javascript">
            function NumericsOnly(evt)
            {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if ((charCode > 31 && (charCode < 48 || charCode > 57)))
                {
                    alert("Enter Numbers");
                    return false;
                }
                return true;
            }

            function validate() {
                //captcha
                var captcha = document.getElementById("captcha").value;
                if(captcha === null || captcha === ""){
                    document.getElementById("captcha").focus();
                    alert("please enter capthca"); return false;
                }
                //ssc_regno
                var ssc_regno = document.getElementById("ssc_regno").value;
                if (ssc_regno === "" || ssc_regno === null) {
                    document.getElementById("ssc_regno").focus();
                    alert("SSC HallTicket Number is required"); return false; 
                }
                //dob
                var dob = document.getElementById("dob").value;
                if (dob === "" || dob === null) {
                    document.getElementById("dob").focus();
                    alert("Date of Birth is required"); return false;   
                }
                return true;
            }

        </script>
        <script type="text/javascript">
                $(document).ready(function () { $.ajaxSetup({ cache: false });
                $("#captchaRef").click(function () {
                        var timestamp = (new Date()).getTime();
                        var newSrc = $("#captchaImage").attr("src").split("?");
                        newSrc = newSrc[0] + "?" + timestamp;
                        $("#captchaImage").attr("src", newSrc);
                        $("#captchaImage").slideDown("fast");

                    });

                $(document).ready(function () {
                    $('#captcha').keypress(function (ev) {
                        //If user pressed Enter Key then trigger Submit click
                        if (ev.keyCode === 13)
                            $('#mysubmit').click();
                    });
                });
            
        </script>
            <script type="text/javascript">
                // Submit: captcha check -> look up by hall ticket -> verify DOB -> show RegId
                function fetchRegId() {
                    if (!validate()) return false;
                    var entered = document.getElementById("captcha").value.trim().toUpperCase();
                    $.get('${pageContext.request.contextPath}/captcha/text', function (serverCaptcha) {
                        if (entered !== String(serverCaptcha).trim().toUpperCase()) {
                            alert("Captcha does not match. Please try again.");
                            $("#captchaRef").click();
                            document.getElementById("captcha").value = "";
                            document.getElementById("captcha").focus();
                            return;
                        }
                        var hallticket = document.getElementById("ssc_regno").value.trim().toUpperCase();
                        var dob = document.getElementById("dob").value;
                        $.get('${backendBaseUrl}/api/student/hallticket/' + encodeURIComponent(hallticket), function (s) {
                            if (s.dob && String(s.dob).substring(0, 10) !== dob) {
                                alert("Date of Birth does not match this Hall Ticket Number.");
                                return;
                            }
                            $('#forgotResult').html(
                                '<div style="background-color:#d4edda;border:2px solid #28a745;padding:20px;margin:10px auto;width:60%;">'
                                + '<h3 style="color:#155724;">Registration ID Found!</h3>'
                                + '<p style="font-size:18px;color:#155724;">Your Registration ID is: <b>' + s.regid + '</b></p>'
                                + '<p style="color:#155724;">Hall Ticket: <b>' + s.sscRegNo + '</b>'
                                + (s.name ? ' &nbsp;|&nbsp; Name: <b>' + s.name + '</b>' : '')
                                + (s.sscYear ? ' &nbsp;|&nbsp; Year of Passing: <b>' + s.sscYear + '</b>' : '')
                                + '</p>'
                                + '<p><a href="${pageContext.request.contextPath}/student-edit-details">Click here to edit your registration</a> &nbsp;|&nbsp; '
                                + '<a href="${pageContext.request.contextPath}/student-apply">Apply for ITI</a></p>'
                                + '</div>');
                            document.getElementById("gateDiv").style.display = "none";
                            window.scrollTo(0, 0);
                        }).fail(function () {
                            alert("No registration found for Hall Ticket Number " + hallticket + ". Please register first (Step 1).");
                        });
                    });
                    return false;
                }
            </script>

        <style>
            td{
                padding-bottom: 10px;
                padding-left: 10px;
            }
            #submits,#submit{
                font-weight: bolder;
                border: none;
                width: 30%;
                border-radius: 4px;
            }
            #submits{
                color: white;
                background-color: seagreen;
            }
            #submit{
                color: white;
                 background-color: lightsalmon;
            }
            #captchaRef{
                background-color: #00c6fb; 
                size: auto;
                border-radius: 4px;
                border: none; 
                font-weight: bolder;
             }
             table{
                 border: 2px solid #000;
                width: 60%;
                height: 30%;
             }
             #heading{
                 font-weight: bolder;
                 color: black;
             }
        </style>
              
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
    </head>
    <body>
        
<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%">
</center>

<div id="forgotResult"></div>

<div id="gateDiv">
        <form name="ForgotRegidForm" method="post" action="#" onsubmit="return fetchRegId()">
            
            <h2 style="background-color: lightgreen" align="center"  class="style4" >
                Application Form for Admission into the Industrial Training Institute for the session 
                2026 </h2>
            <table align="center" bgcolor="#cbd6b2">
                <tr id="heading">
                <td></td>
                <td><u>Forgot Registration Form</u></td>
                </tr>
                <tr>
                    <td><b>SSC HallTicket Number<font color="red">*</font></b></td>
                    <td><input type="text" name="ssc_regno" maxlength="15" value="" onkeypress="return NumericsOnly(event);" id="ssc_regno"></td>
                </tr> 
                <tr>
                    <td><b>Date of Birth<font color="red">*</font></b></td>
                    <td> <input type="date" name="dob" value="" id="dob"> </td>      
                </tr> 
                <tr>
                    <td><label for="email"><b>Captcha<font color="red">*</font></b></label></td>
                    <td><input type="text" autocomplete="off" id="captcha"  name="captcha"   tabindex="3" maxlength="4"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><button type="button" id='captchaRef' style="padding:5px 10px;cursor:pointer;">&#8635; New Captcha</button> 
                        <img src="${pageContext.request.contextPath}/captcha" id='captchaImage'  border="0" width="135px" height="30px"></td>
                    
                </tr> 
                <tr> 
                    <td align="right"><a href="${pageContext.request.contextPath}/"><input type="button" value="Home"   id="submit" /></a></td>
                    <td> <input type="submit" value="Submit" id="submits"/> </td>
                 </tr> 
            </table>
 
    
</form>
</div>

<style>
    #footer{
        position:fixed;
        bottom:0px;
        width:100%;
        height:25px;
        padding-top: 8px;
        text-align: center;
        background-color: #0E4878;
        border-top: 1px #000000 solid;
        font-size: 12px;
        font-family: arial, verdana;
        color: #ffffff;
    }
</style>



<br><br>
<br><br>

<div id="footer">
    2013 @ All Rights Reserved &nbsp;&nbsp; Designed by &nbsp; National Informatics Center
    <font color="white"><a href="http://www.ap.nic.in" title="">National Informatics Center </a></font>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="white"><a href="${pageContext.request.contextPath}/">Disclaimer</a></font>

</div>


<%@ include file="../footer.jsp" %>
</body>
</html>