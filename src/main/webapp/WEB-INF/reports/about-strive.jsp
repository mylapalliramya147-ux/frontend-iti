<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <style>
            .text1{
                font-size: 20px;
                padding-left:65px;
            }
            .text2{
                font-size: 20px;
                padding-left:25px;
                line-height: 1.6;
            }
            p:before {
                content: ' \25BA';
            }

        </style>
        <script>

            function iti_display() {
                // alert("skljlsjfs");
                document.getElementById("dispaly_itis").style.display = "block";
            }

        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>STRIVE</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
        
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="shortcut icon" type="image/ico" href="iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
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

<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
</center>

<br><br>

<!-- ================= MENU BAR ================= -->

<%@ include file="../navbars/index_navbar.jsp" %>

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

<br>
<h2 align="center"><b><u>Skills Strengthening of Industrial Value Enhancement (STRIVE) Project  in State of Andhra Pradesh</u></b></h2>
<div class="text1">
    <p>Objective of the scheme is to improve the relevance and efficiency of skills Training provided through Industrial Training Institutes (ITIs) and Apprenticeships, duly upgrading the infrastructure, equipment and machinery.  </p>

    <p>STRIVE is a Central Sector Scheme with no State Contribution, assisted by World Bank.</p>

    <p>	   It is a 5 Year Project , closing by November 2022.</p>
    <p>	   STRIVE Scheme has four result areas. </p>
    <p>	  Result Area 1 - Improved Performance of ITIs </p>
    <p>	Result Area 2 - Increased Capacities of State Governments to support ITIs and Apprenticeship Training </p>
    <p>	 Result Area 3 - Improved Teaching and Learning  </p>
    <p>	Result Area 4 - Improved and Broadened Apprenticeship Training. </p>
    <p>	 15 Govt. ITIs have been selected under the scheme and Institute Management Committees are also constituted in these ITIs.</p>
    <p>	Govt. of A.P have made an Agreement (Performance Based Fund Agreement )  with Govt. of India in Feb 2019 accepting terms and Conditions of the Project.</p>


</div>
<br><br><br>
<!--<div class="text2">
<span><b>STEP-1:-</b> Display "Skills Strengthening of Industrial Value Enhancement (STRIVE) , by clicking on "Disclosures Management" is to be displayed.  </span><br>
<span><b>STEP-2:-</b> Clicking on "Disclosures  Managemen"  the following are to be displayed.</span><br>
<span style="padding-left:85px; "> 1) Approved Procurement Plan & updates  2) Invitation for Bids 3) Short list of consultants/Bidders 4) Contract Awards   5) Action taken </span><br>
    <span style="padding-left:85px; " >reports & Complaints</span><br>
<span><b>STEP-3:-</b> Upon clicking any item above, three items should be displayed as "(Goods, Services & Works) "</span><br>
<span><b>STEP-4:-</b> Upon clicking Goods or Services or Works (15 ITIs list and SPIU)as shown below, is to be displayed </span>
    
    
    </div>-->

</body>
</html>