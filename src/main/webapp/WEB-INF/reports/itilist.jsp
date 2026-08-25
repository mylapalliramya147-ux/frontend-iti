<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <title>ITI List</title>
         
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
    <a href="login.jsp">
        Home
    </a>
</li>

<li class="dropdown">
    <a href="javascript:void(0)">ITI Profile</a>
    <div class="dropdown-content">
        <a href="trade_display1.jsp">
            ITI Profile
        </a>
        <a href="itilist.jsp">ITI LIST</a>
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
<a href="https://itiadmissions.ap.gov.in/placementsfe/"
target="_blank">
PLACEMENTS / IN-PLANT TRAINING
</a>
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

<br><br>

<!-- ================= ITI LIST FORM ================= -->

<form method="get" action="">
    <p>&nbsp;</p>
<h2 align="center" class="style1">
    <strong>List of Government and Private ITIs</strong>
</h2>

<table width="50%" align="center" bgcolor="#cbd6b2" cellpadding="8" cellspacing="0">
    <tr bgcolor="#4ab131">
        <td colspan="3" align="center" style="color:white;font-weight:bold;">
            ITI List
        </td>
    </tr>

<tr>
    <td align="right" width="35%">
        <b>Select ITI Type :</b>
    </td>

    <td align="left" width="35%">
        <select name="govt" style="width:180px;">
            <option value="">-- Select --</option>
              <option value="A" selected>
                All
            </option>
            <option value="G" >
                Government
            </option>
            <option value="P" >
                Private
            </option>
        </select>
    </td>

    <td align="left" width="30%">
        <input type="submit" value="Proceed">
    </td>
</tr>

</table>

</form>

<br>

<!-- ================= ITI LIST TABLE ================= -->

<table border="1" width="90%" align="center">

<tr bgcolor="#4ab131" style="color:white;">

<th>SL.No</th>
<th>DIstrict Name</th>
<th>NIC ITI Code</th>
<th>NCVT Code</th>
<th>ITI Name</th>

</tr>

<tr>
<td>1</td>
<td>Alluri Sitaramaraju</td>
<td>1368</td>
<td>GU28000520</td>
<td>GOVT ITI Narava</td>
</tr>

<tr>
<td>2</td>
<td>Alluri Sitaramaraju</td>
<td>1305</td>
<td>GR28000244</td>
<td>GOVT. R. I.T.I. ARAKU</td>
</tr>

<tr>
<td>3</td>
<td>Alluri Sitaramaraju</td>
<td>1306</td>
<td>GR28000176</td>
<td>GOVT. R. I.T.I. UPPER SILERU</td>
</tr>

<tr>
<td>4</td>
<td>Anakapalli</td>
<td>1310</td>
<td>PR28000274</td>
<td>ADITYA, PRIVATE I.T.I, PAYAKARAOPETA</td>
</tr>

<tr>
<td>5</td>
<td>Anakapalli</td>
<td>1309</td>
<td>PR28000276</td>
<td>A.S.S.N., PRIVATE I.T.I., ANAKAPALLI</td>
</tr>

<tr>
<td>6</td>
<td>Anakapalli</td>
<td>1354</td>
<td>PR28000455</td>
<td>Bhagavatula Charitable Trust Private ITI, Haripuram</td>
</tr>

<tr>
<td>7</td>
<td>Anakapalli</td>
<td>1362</td>
<td>PR28000462</td>
<td>Chaitanya Private ITI, Parawada, VSP</td>
</tr>

<tr>
<td>8</td>
<td>Anakapalli</td>
<td>2470</td>
<td>PR28000542</td>
<td>Dilshaj Pvt. ITI.,Rolugunta</td>
</tr>

<tr>
<td>9</td>
<td>Anakapalli</td>
<td>1355</td>
<td>PR28000454</td>
<td>DMK Private ITI, Sabbavaram</td>
</tr>

<tr>
<td>10</td>
<td>Anakapalli</td>
<td>1304</td>
<td>GR28000341</td>
<td>GOVT. I.T.I. NARSIPATNAM</td>
</tr>

</table>

<br><br>

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
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="white"><a href="disclaimer.jsp">Disclaimer</a></font>
</div>

</body>
</html>