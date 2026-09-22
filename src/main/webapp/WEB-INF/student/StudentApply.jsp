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
                    var charCode = (evt.which) ? evt.which : event.keyCode

                    if ((charCode > 31 && (charCode < 48 || charCode > 57)))
                    {
                        alert("Enter Numbers");
                        return false;
                    }


                    return true;
                }

                function validate() {
                    var value = document.getElementById("regid").value;
                    if (value === "") {
                        alert("Registration Id is required");
                        return false;
                    }
                    return true;
                }

            </script>
            <script type="text/javascript">
                var CURRENT_REGID = null;
                var CURRENT_SSC_TYPE = null;

                // Gate submit: fetch the registration record and open the application form
                function fetchApplication() {
                    if (!validate()) return false;
                    var regid = document.getElementById("regid").value.trim();
                    var hallticket = document.getElementById("ssc_regno").value.trim().toUpperCase();
                    var dob = document.getElementById("dob").value;

                    $.get('${backendBaseUrl}/api/student/' + regid, function (s) {
                        if (hallticket !== "" && String(s.sscRegNo || '').toUpperCase() !== hallticket) {
                            alert("Hall Ticket Number does not match this Registration Id.");
                            return;
                        }
                        if (dob !== "" && s.dob && String(s.dob).substring(0, 10) !== dob) {
                            alert("Date of Birth does not match this Registration Id.");
                            return;
                        }
                        CURRENT_REGID = s.regid;
                        CURRENT_SSC_TYPE = s.sscType;
                        prefill(s);
                        document.getElementById("gateDiv").style.display = "none";
                        document.getElementById("applyDiv").style.display = "";
                        window.scrollTo(0, 0);
                    }).fail(function () {
                        alert("No registration found for Registration Id " + regid + ". Please register first (Step 1).");
                    });
                    return false;
                }

                function prefill(s) {
                    document.getElementById("prefillInfo").innerHTML =
                        '<b>Registration Id:</b> ' + s.regid + ' &nbsp;|&nbsp; <b>Hall Ticket:</b> ' + s.sscRegNo
                        + ' &nbsp;|&nbsp; <b>Board:</b> ' + s.sscBoard + ' &nbsp;|&nbsp; <b>Year:</b> ' + s.sscYear
                        + ' &nbsp;|&nbsp; <b>Result Type:</b> ' + (s.sscType === 'sscm' ? 'Marks' : 'GPA');
                    document.getElementById("name").value = s.name || '';
                    document.getElementById("fname").value = s.fname || '';
                    document.getElementById("mname").value = s.mname || '';
                    document.getElementById("gender").value = s.gender || '';
                    document.getElementById("appdob").value = s.dob ? String(s.dob).substring(0, 10) : '';
                    document.getElementById("adarno").value = s.adarno || '';
                    document.getElementById("phno").value = s.phno || '';
                    document.getElementById("email").value = s.email || '';
                    document.getElementById("addr").value = s.addr || '';
                    document.getElementById("pincode").value = s.pincode || '';
                    document.getElementById("local").value = s.local || '';
                    document.getElementById("interPassed").value = s.interPassed === true ? 'true' : (s.interPassed === false ? 'false' : '');
                    document.getElementById("interMarks").value = s.interMarks != null ? s.interMarks : '';
                    if (s.caste) $('#casteSelect').append('<option value="' + s.caste + '" selected>' + s.caste + '</option>');
                    if (s.subCaste) $('#subCasteSelect').append('<option value="' + s.subCaste + '" selected>' + s.subCaste + '</option>');
                    document.getElementById("ewsChk").checked = s.economicWeakerSection === true;
                    document.getElementById("phcChk").checked = s.phc === true;
                    document.getElementById("exsChk").checked = s.exservice === true;
                    // marks section per result type of this registration
                    if (s.sscType === 'sscm') {
                        document.getElementById("gpaRow").style.display = "none";
                        document.querySelectorAll('.gpaRow2').forEach(function (r) { r.style.display = "none"; });
                        document.getElementById("marksRow").style.display = "";
                        document.querySelectorAll('.marksRow2').forEach(function (r) { r.style.display = ""; });
                    } else {
                        document.getElementById("marksRow").style.display = "none";
                        document.querySelectorAll('.marksRow2').forEach(function (r) { r.style.display = "none"; });
                        document.getElementById("gpaRow").style.display = "";
                        document.querySelectorAll('.gpaRow2').forEach(function (r) { r.style.display = ""; });
                    }
                }

                function isAlphaKey(evt) {
                    var charCode = (evt.which) ? evt.which : event.keyCode;
                    if ((charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 123) && charCode !== 32 && charCode !== 8 && charCode !== 46) {
                        return false;
                    }
                    return true;
                }

                function val(id) { var v = document.getElementById(id).value.trim(); return v === "" ? null : v; }

                $(document).ready(function () { loadCastes(); });
            </script>
            <script type="text/javascript">
                function loadCastes() {
                    // Master list comes from public.caste_master (caste_code / caste_name).
                    // The codes (BC-A, SC-I, ...) are exactly what student_application.caste stores.
                    $.get('${backendBaseUrl}/api/student/castes', function (list) {
                        $.each(list, function (i, c) {
                            $('#casteSelect').append('<option value="' + c.casteCode + '">' + c.casteName + '</option>');
                        });
                    });
                }

                function loadSubCastes() {
                    var code = document.getElementById("casteSelect").value;
                    var sel = document.getElementById("subCasteSelect");
                    sel.innerHTML = '<option value="">--Select Sub Caste--</option>';
                    if (!code) { return; }
                    // Sub-caste master is the local reference (ids preserved from real
                    // applications; names land as the true master becomes available)
                    $.get('${backendBaseUrl}/api/student/subcastes/' + encodeURIComponent(code))
                        .done(function (list) {
                            (list || []).forEach(function (r) {
                                var label = (r.subCasteName && r.subCasteName !== '') ? r.subCasteName : ('Sub-caste ' + r.subCasteId);
                                var opt = document.createElement('option');
                                opt.value = r.subCasteId; opt.textContent = label + ' (' + r.subCasteId + ')';
                                sel.appendChild(opt);
                            });
                        });
                }

                $(document).on('change', '#casteSelect', loadSubCastes);

                function validateApplication() {
                    var req = [["name","Name"],["fname","Father's Name"],["gender","Gender"],["appdob","Date of Birth"],["phno","Mobile Number"],["addr","Address"],["local","Local/Non-Local"],["casteSelect","Caste"]];
                    for (var i = 0; i < req.length; i++) {
                        var el = document.getElementById(req[i][0]);
                        if (!el.value || !el.value.trim()) { alert("Please enter " + req[i][1] + "."); el.focus(); return false; }
                    }
                    if (!/^\d{10}$/.test(document.getElementById("phno").value.trim())) { alert("Mobile Number must be 10 digits."); return false; }
                    var ad = document.getElementById("adarno").value.trim();
                    if (ad !== "" && !/^\d{12}$/.test(ad)) { alert("Aadhaar must be 12 digits."); return false; }
                    var pin = document.getElementById("pincode").value.trim();
                    if (pin !== "" && !/^\d{6}$/.test(pin)) { alert("Pincode must be 6 digits."); return false; }
                    return true;
                }
            </script>
            <script type="text/javascript">
                // Final submit: PUT /api/student/update/{regid} + POST /api/student/marks/save
                function submitApplication() {
                    if (!validateApplication()) return false;
                    var payload = {
                        name: document.getElementById("name").value.trim(),
                        fname: document.getElementById("fname").value.trim(),
                        mname: document.getElementById("mname").value.trim(),
                        gender: document.getElementById("gender").value,
                        dob: document.getElementById("appdob").value,
                        adarno: document.getElementById("adarno").value.trim(),
                        phno: document.getElementById("phno").value.trim(),
                        email: document.getElementById("email").value.trim(),
                        addr: document.getElementById("addr").value.trim(),
                        pincode: document.getElementById("pincode").value.trim(),
                        caste: document.getElementById("casteSelect").value,
                        subCaste: document.getElementById("subCasteSelect").value,
                        local: document.getElementById("local").value,
                        economicWeakerSection: document.getElementById("ewsChk").checked,
                        phc: document.getElementById("phcChk").checked,
                        exservice: document.getElementById("exsChk").checked,
                        interPassed: document.getElementById("interPassed").value === "" ? null : document.getElementById("interPassed").value === 'true',
                        interMarks: document.getElementById("interMarks").value === "" ? null : parseInt(document.getElementById("interMarks").value, 10)
                    };
                    $.ajax({
                        url: '${backendBaseUrl}/api/student/update/' + CURRENT_REGID,
                        type: 'PUT', contentType: 'application/json',
                        data: JSON.stringify(payload),
                        success: function () {
                            // marks payload: only fields relevant to this registration's result type
                            var m = { regid: CURRENT_REGID, year: '2026' };
                            if (CURRENT_SSC_TYPE === 'sscm') {
                                m.sscFirstLangMarks = val("m_firstlang"); m.sscSecondLangMarks = val("m_secondlang");
                                m.sscEngMarks = val("m_english"); m.sscMathMarks = val("m_math");
                                m.sscSciMarks = val("m_science"); m.sscSocialMarks = val("m_social");
                                m.sscTotMarks = val("m_total");
                            } else {
                                m.sscFirstLangGpa = val("g_firstlang"); m.sscSecondLangGpa = val("g_secondlang");
                                m.sscEngGpa = val("g_english"); m.sscMathGpa = val("g_math");
                                m.sscSciGpa = val("g_science"); m.sscSocialGpa = val("g_social");
                                m.sscTotGpa = val("g_total");
                            }
                            $.ajax({
                                url: '${backendBaseUrl}/api/student/marks/save',
                                type: 'POST', contentType: 'application/json',
                                data: JSON.stringify(m),
                                success: function () {
                                    $('#applyResult').html('<div style="background-color:#d4edda;border:2px solid #28a745;padding:20px;margin:10px auto;width:70%;">'
                                        + '<h3 style="color:#155724;">Application Submitted Successfully!</h3>'
                                        + '<p style="color:#155724;">Your application details and marks have been saved for Registration Id <b>' + CURRENT_REGID + '</b>.</p>'
                                        + '<p><a href="${pageContext.request.contextPath}/">Back to Home</a></p></div>');
                                    document.getElementById("applyDiv").style.display = "none";
                                    window.scrollTo(0, 0);
                                },
                                error: function () { alert("Details saved but marks could not be saved. Please retry from Edit Registration."); }
                            });
                        },
                        error: function (xhr) {
                            alert("Failed to save application details. Please check the values and try again.");
                        }
                    });
                    return false;
                }
            </script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
    </head>
    <body>
        
<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%">
</center>

<div id="applyResult"></div>

<!-- ============ GATE: LOOK UP THE REGISTRATION ============ -->
<div id="gateDiv">
        <form name="EditForm_phase2" method="post" action="#" onsubmit="return fetchApplication()">
            <h2 style="background-color: lightgreen" align="center"  class="style4" >Application Form for Admission into the Industrial Training Institute for the session 2026(Phase-6) </h2>

            <div align="center"><b><font color="blue">Note:: Applicant has to register his/her details first by clicking <a href="${pageContext.request.contextPath}/student-registration">Student Registration</a> note your registration number, then click &quot;Apply for ITI&quot;<br><br></br> </font></b>
            </div> <br>

                <table width="50%" height="30%" align="center" bgcolor="#cbd6b2">
                    <tr bgcolor="#4ab131">
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>SSC HallTicket Number</td>
                        <td><input type="text" name="ssc_regno" value="" id="ssc_regno"></td>
                    </tr> 
                    <tr>
                        <td>Date of Birth</td>
                        <td> <input type="date" name="dob" value="" id="dob">
                        </td>      
                    </tr>
                    <tr>
                        <td>Registration Id<font color="red">*</font></td>
                        <td><input type="text" name="regid" maxlength="10" value="" onkeypress="return NumericsOnly(event);" id="regid"></td>
                    </tr>  
                    <tr colspan="4">
                        <td style="text-align: center" > 
                            <a href="${pageContext.request.contextPath}/"> <input type="button" name="back" id="submit" Style="width:100px;" value="Back to Home"/></a>
                            <input type="submit" value="Submit"></td>

                    </tr>
                    <tr bgcolor="#4ab131">
                        <td colspan="2">&nbsp;</td>
                    </tr>
                </table>
            </form>
</div>
<!-- ============ FULL APPLICATION FORM (opens after lookup) ============ -->
<div id="applyDiv" style="display:none;">
        <form name="ApplicationForm" method="post" action="#" onsubmit="return submitApplication()">
            <h2 style="background-color: lightgreen" align="center" class="style4">
                Application Form for Admission into the Industrial Training Institute for the session 2026(Phase-6)</h2>

            <p id="prefillInfo" style="text-align:center;background-color:#e4eeb9;padding:8px;border:1px solid #999;"></p>

            <table width="70%" align="center" bgcolor="#cbd6b2" style="border:2px solid black;">
                <tr bgcolor="#3399ff"><td colspan="2" id="heading"><u>Personal Details</u></td></tr>
                <tr><td>Name<font color="red">*</font></td><td><input type="text" id="name" maxlength="60" onkeypress="return isAlphaKey(event);"></td></tr>
                <tr><td>Father's Name<font color="red">*</font></td><td><input type="text" id="fname" maxlength="60"></td></tr>
                <tr><td>Mother's Name</td><td><input type="text" id="mname" maxlength="60"></td></tr>
                <tr><td>Gender<font color="red">*</font></td><td><select id="gender"><option value="">--Select--</option><option value="male">Male</option><option value="female">Female</option></select></td></tr>
                <tr><td>Date of Birth<font color="red">*</font></td><td><input type="date" id="appdob"></td></tr>
                <tr><td>Aadhaar Number</td><td><input type="text" id="adarno" maxlength="12" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr><td>Mobile Number<font color="red">*</font></td><td><input type="text" id="phno" maxlength="10" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr><td>Email</td><td><input type="text" id="email" maxlength="80"></td></tr>
                <tr><td>Address<font color="red">*</font></td><td><textarea id="addr" rows="3" cols="40"></textarea></td></tr>
                <tr><td>Pincode</td><td><input type="text" id="pincode" maxlength="6" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr><td>Caste<font color="red">*</font></td><td><select id="casteSelect" onchange="loadSubCastes();"><option value="">--Select Caste--</option></select></td></tr>
                <tr><td>Sub Caste</td><td><select id="subCasteSelect"><option value="">--Select Sub Caste--</option></select></td></tr>
                <tr><td>Local / Non-Local<font color="red">*</font></td><td><select id="local"><option value="">--Select--</option><option value="Local">Local</option><option value="NonLocal">Non-Local</option></select></td></tr>
                <tr><td>Economic Weaker Section</td><td><input type="checkbox" id="ewsChk"></td></tr>
                <tr><td>Physically Challenged</td><td><input type="checkbox" id="phcChk"></td></tr>
                <tr><td>Ex-Service Man</td><td><input type="checkbox" id="exsChk"></td></tr>
                <tr><td>Passed Intermediate?</td><td><select id="interPassed"><option value="">--Select--</option><option value="true">Yes</option><option value="false">No</option></select></td></tr>
                <tr><td>Inter Marks (if passed)</td><td><input type="text" id="interMarks" maxlength="4" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr id="gpaRow"><td colspan="2" style="background-color:#d9e6f7;"><b>SSC Marks - GPA (as per your registration)</b></td></tr>
                <tr class="gpaRow2"><td>First Language GPA</td><td><input type="text" id="g_firstlang" maxlength="3"></td></tr>
                <tr class="gpaRow2"><td>Second Language GPA</td><td><input type="text" id="g_secondlang" maxlength="3"></td></tr>
                <tr class="gpaRow2"><td>English GPA</td><td><input type="text" id="g_english" maxlength="3"></td></tr>
                <tr class="gpaRow2"><td>Mathematics GPA</td><td><input type="text" id="g_math" maxlength="3"></td></tr>
                <tr class="gpaRow2"><td>Science GPA</td><td><input type="text" id="g_science" maxlength="3"></td></tr>
                <tr class="gpaRow2"><td>Social GPA</td><td><input type="text" id="g_social" maxlength="3"></td></tr>
                <tr class="gpaRow2"><td>Total GPA</td><td><input type="text" id="g_total" maxlength="4"></td></tr>
                <tr id="marksRow" style="display:none;"><td colspan="2" style="background-color:#d9e6f7;"><b>SSC Marks - Marks system (as per your registration)</b></td></tr>
                <tr class="marksRow2" style="display:none;"><td>First Language Marks</td><td><input type="text" id="m_firstlang" maxlength="3" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr class="marksRow2" style="display:none;"><td>Second Language Marks</td><td><input type="text" id="m_secondlang" maxlength="3" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr class="marksRow2" style="display:none;"><td>English Marks</td><td><input type="text" id="m_english" maxlength="3" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr class="marksRow2" style="display:none;"><td>Mathematics Marks</td><td><input type="text" id="m_math" maxlength="3" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr class="marksRow2" style="display:none;"><td>Science Marks</td><td><input type="text" id="m_science" maxlength="3" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr class="marksRow2" style="display:none;"><td>Social Marks</td><td><input type="text" id="m_social" maxlength="3" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr class="marksRow2" style="display:none;"><td>Total Marks</td><td><input type="text" id="m_total" maxlength="4" onkeypress="return NumericsOnly(event);"></td></tr>
                <tr colspan="4">
                    <td style="text-align: center;" colspan="2"> 
                        <a href="${pageContext.request.contextPath}/"> <input type="button" name="back" id="submit" Style="width:100px;" value="Back to Home"/></a>
                        <input type="submit" value="Submit Application">
                    </td>
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