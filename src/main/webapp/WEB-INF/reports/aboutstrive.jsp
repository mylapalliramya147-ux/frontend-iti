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
        
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="shortcut icon" type="image/ico" href="iti.png" />
<link rel="stylesheet" href="stylesheets/expe1011.css">
<script type="text/javascript" src="js1/jquery.min.js"></script>

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
  background: -moz-linear-gradient(top, #EB4954, #A19197);
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
 /*background: linear-gradient(top,  #EC95DD,  #BAA0B7) !important;*/
 /*background: -ms-linear-gradient(top,  #EC95DD,  #BAA0B7) !important;*/
 /*background: -webkit-gradient(linear, left top, left bottom, from(#EC95DD), to(#BAA0B7)) !important;*/
 /*background: -moz-linear-gradient(top,  #EC95DD,  #BAA0B7) !important;*/
  color: black !important;
  border-radius: 0;
  -webkit-border-radius: 0;
  -moz-border-radius: 0;
 /*text-shadow: 20px -12px 0px #FFBFD9;*/
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
 /*border: groove 4px #14B439;*/
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
   /*font-style: oblique;*/

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
</head>


<link rel="stylesheet" href="stylesheets/expe1011.css">

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

<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
</center>

<br><br>

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