<!DOCTYPE html>
<html>
    <head>
        
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
<link rel="shortcut icon" type="image/ico" href="iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
</head>

        <script src="jquery.min.js"></script>
    </head>

    <body>
        
<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
</center>

        





<head>

<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="shortcut icon" type="image/ico" href="iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

</head>


<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">

<style>

/* ================= MENU CSS (Your Existing) ================= */






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

<!-- ================= IMAGE POPUP ================= -->


<!-- ================= MENU BAR ================= -->

<%@ include file="../index_navbar.jsp" %>

<br><br>

<!-- ================= MARQUEE ================= -->





<marquee onmouseover="this.stop();"
          onmouseout="this.start();"
          scrolldelay="100">

<b>
<font color="blue" size="5">

<a href=""
   target="_blank">

 ITI Admissions 2026 Phase -3 registrations, applications and verifications available in  all GovtPvts ITIs on 15-08-2026 and 19-08-2026. 

</a>

</font>
</b>

</marquee>



<!-- ================= POPUP SCRIPT ================= -->

<script>

// Show popup on page load
window.onload = function () {

    document.getElementById(
        "airforcePopup"
    ).style.display = "block";

    // Auto close after 10 sec
    setTimeout(function () {

        closeAirforcePopup();

    }, 10000);
};

// Manual close
function closeAirforcePopup() {
    document.getElementById(
        "airforcePopup"
    ).style.display = "none";
}

</script>

</body>


        <p>&nbsp;</p>

        <form name="form1" method="GET" action="${pageContext.request.contextPath}/reports/trade_display2">
            <p align="center"  class="style4"> 
                <font color="blue" size="4">

                List of ITI's with Trades & Strengths Interface   </font>
            </p>




            <table align="center" border="1" id="AutoNumber1" bgcolor="#e4eeb9" >
                <tr bgcolor="green">

                <tr>
                    <td><span class="style52">Select District : </span></td>



                    <td width="148">
                        <select name="dist_code" class="style52" >
                            <option value='' selected>--select--</option><option value='25' >Alluri Sitaramaraju</option><option value='24' >Anakapalli</option><option value='22' >Anantapur</option><option value='33' >Annamayya</option><option value='32' >Bapatla</option><option value='23' >Chittoor</option><option value='14' >East Godavari</option><option value='29' >Eluru</option><option value='17' >Guntur</option><option value='27' >Kakinada</option><option value='28' >Konaseema</option><option value='16' >Krishna</option><option value='21' >Kurnool</option><option value='38' >Markapuram</option><option value='34' >Nandyal</option><option value='19' >Nellore</option><option value='30' >NTR</option><option value='31' >Palnadu</option><option value='26' >Parvathipuram-Manyam</option><option value='37' >Polavaram</option><option value='18' >Prakasam</option><option value='11' >Srikakulam</option><option value='35' >Sri Satyasai</option><option value='36' >Tirupati</option><option value='13' >Visakhapatnam</option><option value='12' >Vizianagaram</option><option value='15' >West Godavari</option><option value='20' >YSR</option>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td>GOVT/PVT</td>
                    <td> <select name="gov" >
                            <option value="">----ALL----</option>
                            <option value="G">GOVERNMENT</option>
                            <option value="P">PRIVATE</option>
                        </select></td>
                </tr>
                <tr bgcolor="green">
                    <td colspan="2" ><input type="submit" /></td>
                </tr>
            </table>
        </form>
    </body>
</html>