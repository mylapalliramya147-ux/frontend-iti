<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>STRIVE</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
    <style>
        #menu-bar {
            list-style: none;
            margin: 0;
            padding: 0;
            background-color: #E1F5A9;
            text-align: left;
            font-family: Arial, Helvetica, sans-serif;
            border-bottom: 2px solid #996633;
        }
        #menu-bar > li {
            display: inline-block;
            position: relative;
            margin: 0;
        }
        #menu-bar > li > a {
            display: block;
            padding: 10px 20px;
            color: #000000;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
        }
        #menu-bar > li > a:hover {
            background-color: #996633;
            color: #FFFFFF;
        }
        #menu-bar li ul {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #FFFFFF;
            list-style: none;
            margin: 0;
            padding: 0;
            min-width: 200px;
            z-index: 1000;
            border: 1px solid #996633;
        }
        #menu-bar li:hover ul {
            display: block;
        }
        #menu-bar li ul li {
            display: block;
        }
        #menu-bar li ul li a {
            display: block;
            padding: 8px 16px;
            color: #000000;
            text-decoration: none;
            font-size: 14px;
            border-bottom: 1px solid #E1F5A9;
        }
        #menu-bar li ul li a:hover {
            background-color: #E1F5A9;
            color: #000000;
        }
        .text1 {
            font-family: "book antiqua", "times new roman", times;
            font-size: 16px;
            line-height: 1.6;
            color: #000000;
            padding: 10px 20px;
            text-align: justify;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
</head>
<body>
<div style="text-align: center;">
    <img src="${pageContext.request.contextPath}/images/Banner.jpg" id="banner-id" style="width: 100%; height: auto;" alt="Banner">
</div>

<ul id="menu-bar">
    <li><a href="${pageContext.request.contextPath}/login">Home</a></li>
    <li>
        <a>STRIVE</a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/reports/about-strive">ABOUT STRIVE</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/disclosure-management">Disclosure Management</a></li>
        </ul>
    </li>
    <li><a href="https://itiadmissions.ap.gov.in/placementsfe/" target="_blank">PLACEMENTS / IN-PLANT TRAINING</a></li>
</ul>

<br><br>

<marquee onmouseover="this.stop();" onmouseout="this.start();" scrolldelay="100">
    <b>
        <font color="blue" size="5">
            <a href="#" target="_blank">
                ITI Admissions 2026 Phase -1 for Student Registrations, Apply for ITI and Verifications has started and will end on 02/07/2026 5PM.
            </a>
        </font>
    </b>
</marquee>

<br>
<h2 style="text-align: center;"><b><u>Skills Strengthening of Industrial Value Enhancement (STRIVE) Project in State of Andhra Pradesh</u></b></h2>

<div class="text1">
    <p>Objective of the scheme is to improve the relevance and efficiency of skills Training provided through Industrial Training Institutes (ITIs) and Apprenticeships, duly upgrading the infrastructure, equipment and machinery.</p>
    <p>STRIVE is a Central Sector Scheme with no State Contribution, assisted by World Bank.</p>
    <p>It is a 5 Year Project , closing by November 2022.</p>
    <p>STRIVE Scheme has four result areas.</p>
    
    <div style="padding-left: 20px;">
        <p>Result Area 1 - Improved Performance of ITIs</p>
        <p>Result Area 2 - Increased Capacities of State Governments to support ITIs and Apprenticeship Training</p>
        <p>Result Area 3 - Improved Teaching and Learning</p>
        <p>Result Area 4 - Improved and Broadened Apprenticeship Training.</p>
    </div>

    <p>15 Govt. ITIs have been selected under the scheme and Institute Management Committees are also constituted in these ITIs.</p>
    <p>Govt. of A.P have made an Agreement (Performance Based Fund Agreement) with Govt. of India in Feb 2019 accepting terms and Conditions of the Project.</p>
</div>

<br><br><br>

</body>
</html>