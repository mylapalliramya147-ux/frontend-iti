<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>:: ITI :: Student Registration</title>

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
  
/*border: solid 1px #6D6D6D*/
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
 /*font-style: oblique;*/
  font-size: 14px;
  color: #000000;
    background: #e4eeb9;
  text-decoration: none;
  display: block;
  padding: 6px 20px 6px 20px;
  margin: 0;
  margin-bottom: 6px;
 /*border-radius: 10px;*/
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
 /*text-shadow: 0px 0px 0px #000000;*/
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
 /*text-shadow: 3px 2px 3px #FFFFFF;*/
}
#menu-bar ul li:hover a, #menu-bar li:hover li a {
  background: lightgoldenrodyellow;
 /*border: none;*/
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
            
            $(function() {
                $('#ssc_regno').keyup(function() {
                    this.value = this.value.toLocaleUpperCase();
                });
             });
             
            function NumericsOnly(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
                return true;
            }

            function limitText(el, n) { if (el.value.length > n) el.value = el.value.substring(0, n); }

            function validate() {
                
                //captcha
                var captcha = document.getElementById("captcha").value;
                if(captcha === null || captcha === ""){
                    document.getElementById("captcha").focus();
                    alert("plese eneter Captcha"); return false;
                }
                //ssc_board
                var ssc_board = document.getElementById("ssc_board").value;
                if(ssc_board === null || ssc_board === ""){
                    document.getElementById("ssc_board").focus();
                    alert("plese eneter SSC/8th Board"); return false;
                }
                //ssc_regno
                var ssc_regno = document.getElementById("ssc_regno").value;
                if(ssc_regno === null || ssc_regno === ""){
                    document.getElementById("ssc_regno").focus();
                    alert("plese eneter SSC/8th Hall Ticket Number"); return false;
                }
                //passed_year
                var passed_year = document.getElementById("passed_year").value;
                if(passed_year === null || passed_year === ""){
                    document.getElementById("passed_year").focus();
                    alert("plese eneter Year Of Passing"); return false;
                }
                //ssc_type
                var ssc_type = document.getElementById("ssc_type").value;
                if(ssc_type === null || ssc_type === ""){
                    document.getElementById("ssc_type").focus();
                    alert("plese eneter Result Type"); return false;
                }
                
            return true;   
            }
            function getDate() {

                var passed_year = $('#passed_year').val();

                var d = new Date();
                var n = d.getFullYear();

                if (passed_year > n) {
                    alert("Year Of Passing cannot be greater than " + n + "");
                    $('#passed_year').val('');
                    $('#passed_year').focus();

                    return false;
                }
                return true;
            }    
            
            
        </script>
 
        <script type="text/javascript">
                $(document).ready(function () {
                    $.ajaxSetup({
                        cache: false
                    });
                     
                $("#captchaRef").click(function () {
                        var timestamp = (new Date()).getTime();
                        var newSrc = $("#captchaImage").attr("src").split("?");
                        newSrc = newSrc[0] + "?" + timestamp;
                        $("#captchaImage").attr("src", newSrc);
                        $("#captchaImage").slideDown("fast");

                    });
                });

                $(document).ready(function () {
                    $('#captcha').keypress(function (ev) {
                        if (ev.keyCode === 13) 
                            $('#mysubmit').click();
                    });
                });
            
        </script>
        <script type="text/javascript">
            var SESSION_YEAR = '2026';

            // Proceed: validate -> check captcha -> POST /api/student/save -> show RegId
            function submitRegistration() {
                if (!validate()) return false;
                if (!getDate()) return false;

                var enteredCaptcha = document.getElementById("captcha").value.trim().toUpperCase();
                $.get('${pageContext.request.contextPath}/captcha/text', function (serverCaptcha) {
                    if (enteredCaptcha !== String(serverCaptcha).trim().toUpperCase()) {
                        alert("Captcha does not match. Please try again.");
                        $("#captchaRef").click();
                        document.getElementById("captcha").value = "";
                        document.getElementById("captcha").focus();
                        return;
                    }
                    var payload = {
                        sscBoard: document.getElementById("ssc_board").value,
                        sscRegNo: document.getElementById("ssc_regno").value.trim(),
                        sscYear:  document.getElementById("passed_year").value,
                        sscType:  document.getElementById("ssc_type").value,
                        year:     SESSION_YEAR
                    };
                    $.ajax({
                        url: '${backendBaseUrl}/api/student/save',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(payload),
                        success: function (student) {
                            $('#regResult').html(
                                '<div style="background-color:#d4edda;border:2px solid #28a745;padding:20px;margin:10px auto;width:60%;">'
                                + '<h3 style="color:#155724;">Registration Successful!</h3>'
                                + '<p style="font-size:18px;color:#155724;">Your Registration ID is: <b>' + student.regid + '</b></p>'
                                + '<p style="color:#155724;">Please note down your Registration ID. '
                                + 'You will need it for the application, edit and all further steps.</p>'
                                + '<p><a href="${pageContext.request.contextPath}/student-apply">Click here to proceed to Step 2 - Application to apply for ITI</a></p>'
                                + '</div>');
                            document.getElementById("regFormDiv").style.display = "none";
                            window.scrollTo(0, 0);
                        },
                        error: function (xhr) {
                            var msg = 'Registration failed. Please try again.';
                            if (xhr.responseJSON && xhr.responseJSON.message) msg = xhr.responseJSON.message;
                            $('#regResult').html('<div style="background-color:#f8d7da;border:2px solid #dc3545;padding:15px;margin:10px auto;width:60%;color:#721c24;"><b>Error:</b> ' + msg + '</div>');
                        }
                    });
                });
                return false;
            }
        </script>

        <style>
             #submit,#submit1,#reset{
                font-weight: bolder;
                border: none;
                width: 25%;
                border-radius: 4px;
            }
            #submit{ background-color: lightgreen; } 
            #submit1{ background-color: lightsalmon; width: 25%; }
            #reset{ background-color: tomato; }
            #captchaRef{
                background-color: #00c6fb; 
                size: auto;
                border-radius: 4px;
                border: none; 
                font-weight: bolder;
            }
            table{ 
                width: 60%; 
                height: 30%;
                background-color: #cbd6b2;
                border: 2px solid black;
            }
            #heading{ 
                color: black; 
                text-align: center; 
                font-size: larger; 
                background-color: #cbd6b2; 
                 
            }
            .container{ background-color: #00c6fb;}
            td{ padding-bottom: 10px; padding-left: 10px; font-weight: bolder; }  
        </style>
        
    <body>
        
<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%">
</center>

<div id="regResult"></div>

<div id="regFormDiv">
        <form name="open_Application_Step1_form" method="post" action="#" onsubmit="return submitRegistration()">
            <h2 style="background-color: lightgreen" align="center"  class="style4">
                Registration Form for Admission into the Industrial Training Institute for the session 
                2026(Phase-6)</h2>
            
            <table align="center">
                <tr bgcolor="#3399ff">
                    <td colspan="3" id="heading"><u>Registration Form-Step1</u></td>
                    
                </tr>
                <tr>
                    <td>SSC/8th Board<font color="red">*</font></td>
                    <td><select name="ssc_board" id="ssc_board">
                            <option value="">--Select Board Here--</option>
                            <option value='28' >Andhra Pradesh State Board (SSC)</option><option value='35' >Andman & Nicobar Islands State Board</option><option value='54' >AP-OSC</option><option value='53' >AP-OSSC</option><option value='12' >Arunachal Pradesh State Board</option><option value='18' >Assam State Board</option><option value='10' >Bihar State Board</option><option value='51' >CBSE</option><option value='4 ' >Chandigarh State Board</option><option value='22' >Chhattisgarh State Board</option><option value='26' >Dadra & Nagar Haveli State Board</option><option value='25' >Daman & Diu State Board</option><option value='7 ' >Delhi State Board</option><option value='30' >Goa State Board</option><option value='24' >Gujarat State Board</option><option value='6 ' >Haryana State Board</option><option value='2 ' >Himachal Pradesh State Board</option><option value='52' >ICSE</option><option value='1 ' >Jammu & Kashmir State Board</option><option value='20' >Jharkhand State Board</option><option value='29' >Karnataka State Board</option><option value='32' >Kerala State Board</option><option value='31' >Lakshadweep State Board</option><option value='23' >Madhya Pradesh State Board</option><option value='27' >Maharashtra State Board</option><option value='14' >Manipur State Board</option><option value='17' >Meghalaya State Board</option><option value='15' >Mizoram State Board</option><option value='13' >Nagaland State Board</option><option value='21' >Orissa State Board</option><option value='60' >Other</option><option value='34' >Pondicherry State Board</option><option value='3 ' >Punjab State Board</option><option value='8 ' >Rajasthan State Board</option><option value='11' >Sikkim State Board</option><option value='33' >Tamil nadu State Board</option><option value='36' >Telangana</option><option value='16' >Tripura State Board</option><option value='5 ' >Uttarakhand State Board</option><option value='9 ' >Utter Pradesh State Board</option><option value='19' >West Bengal State Board</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>SSC/8th Hall Ticket Number<font color="red">*</font></td>
                    <td><input type="text"  name="ssc_regno" id="ssc_regno" pattern='[0-9A-Z]{6,15}' title="number should be 6 to 15 digits" maxlength="15" onkeydown="limitText(this, 15);" /></td>
                </tr>
                <tr>
                    <td>Year Of Passing<font color="red">*</font></td>
                    <td><input type="text" name="passed_year" maxlength="4" value="" onkeydown="limitText(this,15);" onkeypress="return NumericsOnly(event);" onchange="return getDate();" id="passed_year"></td>
                </tr>
                <tr>
                    <td>Result Type<font color="red">*</font></td>
                    <td colspan="2">
                        <select name="ssc_type" id="ssc_type"><option value="" selected="selected">--Select--</option>
                            <option value="sscg">GPA</option>
                            <option value="sscm">Marks</option></select> </td>
                </tr>
                <tr>
                    <td><label for="email">Captcha<font color="red">*</font></label></td>
                    <td><input type="text" autocomplete="off" id="captcha"  name="captcha" maxlength="4" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <button type="button" id='captchaRef' style="padding:5px 10px;cursor:pointer;">&#8635; New Captcha</button>
                    <img src="${pageContext.request.contextPath}/captcha" id='captchaImage'  border="0" width="135px" height="30px"></td>

                    </td> 
                     
                </tr>
                <tr>
                    <td align="right"><a href="${pageContext.request.contextPath}/"><input type="button" name="back"   id="submit1"  value="Home"/></a></td>
                    <td> 
                        <input type="submit" name="Submit" id='mysubmit' value="Proceed"/>
                        
                        <input type="reset" name="Reset"   id="reset"/>
                    </td>
                    <td></td>
                </tr>
               
                 
                <tr>
                    <div align="center" style="color:red;">   </div>
                </tr>
            </table>  
                
  
        </form><br> 
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


    </body>
</html>