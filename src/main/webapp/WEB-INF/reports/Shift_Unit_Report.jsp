<!DOCTYPE html>
<html>
<head>
    <title> Shift & Unit Permitted Report</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
    <style>
    table {
        border-collapse: collapse;
        width: 80%;           /* Adjusted width */
        margin: 6px auto;
        font-weight: bold;    /* Makes all text bold */
        font-size: 10px;      /* Slightly smaller font for tighter layout */
    }

    th, td {
        border: 1px solid #ccc;
        padding: 4px 6px;    /* Reduced padding for smaller height */
        text-align: center;
         vertical-align: middle; /* Ensures text sits more tightly */
    }

    th {
        background-color: #4CAF50;
        color: white;
        font-size: 14px;
    }

    .link {
        color: blue;
        cursor: pointer;
        text-decoration: underline;
    }

    .section {
        margin: 10px auto;
        width: 60%;
        display: none;
        transition: max-height 0.4s ease-in-out;
        overflow: hidden;
    }

    .loader {
        display: none;
        text-align: center;
        margin: 10px auto;
    }

    .spinner {
        border: 4px solid #f3f3f3;
        border-top: 4px solid #4CAF50;
        border-radius: 50%;
        width: 30px;
        height: 30px;
        animation: spin 0.8s linear infinite;
        margin: auto;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>


    <script>
        function showLoader(id) {
            document.getElementById(id).style.display = 'block';
        }

        function hideLoader(id) {
            document.getElementById(id).style.display = 'none';
        }

        function showSection(id) {
            const section = document.getElementById(id);
            section.style.display = 'block';
            section.style.maxHeight = section.scrollHeight + "px";
        }

        function clearSection(id) {
            const section = document.getElementById(id);
            section.innerHTML = "";
            section.style.display = 'none';
        }

        function loadDistrictReport(distCode) {
            showLoader("districtLoader");
            clearSection("itiSection");

            fetch('districtReport.jsp?distCode=' + distCode)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('districtSection').innerHTML = html;
                    showSection("districtSection");
                })
                .catch(err => {
                    document.getElementById('districtSection').innerHTML = "<p style='color:red;'>Error loading district data</p>";
                })
                .finally(() => {
                    hideLoader("districtLoader");
                });
        }

        function loadITIReport(itiCode) {
            showLoader("itiLoader");

            fetch('itiReport.jsp?itiCode=' + itiCode)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('itiSection').innerHTML = html;
                    showSection("itiSection");
                })
                .catch(err => {
                    document.getElementById('itiSection').innerHTML = "<p style='color:red;'>Error loading ITI data</p>";
                })
                .finally(() => {
                    hideLoader("itiLoader");
                });
        }
    </script>
    
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
</head>
<body>

<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="shortcut icon" type="image/ico" href="iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

</head>


<center>
    <img src="js/img/gen.jpg" id="banner-id" width="100%"></img>
</center>





 

    <ul id="menu-bar" style="height: 45px;">
        
       
           <li> <a href="loginsuccess.jsp">Home</a> </li>
         
                <li>
                    <a href="#">ITI Services</a>
                    <ul>
                        <li><span class="top"></span><span class="bottom"></span></li>
                    <li><a href="Password_change.jsp"  title="null">Change Particular User Password </a></li><li><a href="Dget_Iti_Code_Interface.jsp"  title="null">DGET ITI CODE </a></li><li><a href="district_schedule.jsp"  title="null">District Schedule </a></li><li><a href="scrollupload_interface.jsp"  title="null">Scroll Update </a></li><li><a href="Shift_Unit_Report.jsp"  title="null">Shift Unit Report </a></li><li><a href="addsub.do"  title="Add subjects for relavent trades">Trade Name Change </a></li><li><a href="fileupload_interface.jsp"  title="null">Upload News And Updates </a></li><li><a href="Register_new_user.jsp"  title="null">NEW USER CREATION </a></li><li><a href="login_history.jsp"  title="It shows the Login history for your details b/w two given dates">Login History </a></li><li><a href="Registration.jsp"  title="Add New ITI for Master Table">Add ITI Master </a></li>
                    </ul>
                    
                </li>
        
                <li>
                    <a href="#">ITI Reports</a>
                    <ul>
                        <li><span class="top"></span><span class="bottom"></span></li>
                    <li><a href="Govt_Pvt_admitted_seats_abstract.jsp"  title="null">Admitted Seats Abstract </a></li><li><a href="Jdgetdasboardreport.jsp"  title="null">Api Dashboard </a></li><li><a href="Seats_Abstract_Strength_filled_Interface.jsp"  title="null">DistrictWise Admitted Seats Abstract </a></li><li><a href="PhaseWiseAdmissionReport.jsp"  title="null">Phase Wise Admissions Details </a></li><li><a href="AdmissionScheduleITI.jsp"  title="null">Today Schedule ITIs </a></li><li><a href="tradewise_admission_report.jsp"  title="null">Trade/District Wise Admission Report </a></li><li><a href="tradewise_vacant_position.jsp"  title="null">TradeWise Vacant Position </a></li><li><a href="Iti_Report.jsp"  title="null">Update ITI </a></li><li><a href="statewidecastewiseabstractinter.jsp"  title="null">Caste Wise Admissions Abstract </a></li><li><a href="AdmissionsReport3.jsp"  title="null">Admissions Report </a></li><li><a href="Dist_wise_open_seats.jsp"  title="null">District/ITI/Trade Wise Seats Abstract </a></li><li><a href="trade_seats_abstract_duration_wise.jsp"  title="null">Duration Wise Trade Seats Abstract </a></li><li><a href="govt_pvt_dist_seats_abstract.jsp"  title="null">Govt or Pvt Dist Wise Seats Abstract </a></li>
                    </ul>
                    
                </li>
        
                <li>
                    <a href="#">Admissions</a>
                    <ul>
                        <li><span class="top"></span><span class="bottom"></span></li>
                    <li><a href="permitted_shift_unit_nodal_report.jsp"  title="Permitted Shifts Units Report">DGT Permitted Shifts Units Report </a></li><li><a href="StatusMaster.jsp"  title="null">Freeze or UnFreeze  </a></li><li><a href="Iti_adm_interface.jsp"  title="null">Search </a></li><li><a href="District_Wise_Application_count.jsp"  title="Verification Report">Verification Report - Dist wise </a></li><li><a href="DSC_List_secondphase.jsp"  title="null">DSC List </a></li><li><a href="DeleteAdmission_interface.jsp"  title="null">DISCHARGE ADMISSION </a></li>
                    </ul>
                    
                </li>
        
                <li>
                    <a href="#">SCVT Exams</a>
                    <ul>
                        <li><span class="top"></span><span class="bottom"></span></li>
                    <li><a href="semester_consolidated_marks_statement.jsp"  title="null">Sem Certificate Printing </a></li><li><a href="SCVTExamInitialization.jsp"  title="SCVT Exam Initialization">SCVT Exam Initialization </a></li><li><a href="SCVTResult_Processing.jsp"  title="SCVT Result Processing">SCVT Result Processing </a></li><li><a href="scvt_certificate_interface.jsp"  title="SCVT Certificate ">SCVT Certificate  </a></li>
                    </ul>
                    
                </li>
        
          
            <li><a href="logout.jsp">Logout</a>
            <ul>
                <li><span class="top"></span><span class="bottom"></span></li>
                <a href="ChangePassword_Interface.jsp">Change Password  </a>
            </ul>
            </li>
            
            <li><span style="color: blue; font-size: 10px;" >
                        Welcome, LOGINADMIN<br>
                         Admin JD Exams,2
                    </span> </li>
    </ul>
     
    


<h2 align="center">1. Overall Report (by District)</h2>

<table align="center">
    <tr>
        <th>Sl. No</th>
        <th>District</th>
        <th>Total No of ITIs</th>
        <th>ITIs shift & unit entered</th>
        <th>ITIs shift & unit not entered</th>
    </tr>

    <tr>
        <td>1</td>
        <td><span class="link" onclick="loadDistrictReport('25')">Alluri Sitaramaraju</span></td>
        <td>3</td>
        <td>3</td>
        <td>0</td>
    </tr>

    <tr>
        <td>2</td>
        <td><span class="link" onclick="loadDistrictReport('24')">Anakapalli</span></td>
        <td>33</td>
        <td>33</td>
        <td>0</td>
    </tr>

    <tr>
        <td>3</td>
        <td><span class="link" onclick="loadDistrictReport('22')">Anantapur</span></td>
        <td>23</td>
        <td>23</td>
        <td>0</td>
    </tr>

    <tr>
        <td>4</td>
        <td><span class="link" onclick="loadDistrictReport('33')">Annamayya</span></td>
        <td>14</td>
        <td>14</td>
        <td>0</td>
    </tr>

    <tr>
        <td>5</td>
        <td><span class="link" onclick="loadDistrictReport('32')">Bapatla</span></td>
        <td>17</td>
        <td>17</td>
        <td>0</td>
    </tr>

    <tr>
        <td>6</td>
        <td><span class="link" onclick="loadDistrictReport('23')">Chittoor</span></td>
        <td>14</td>
        <td>14</td>
        <td>0</td>
    </tr>

    <tr>
        <td>7</td>
        <td><span class="link" onclick="loadDistrictReport('14')">East Godavari</span></td>
        <td>14</td>
        <td>14</td>
        <td>0</td>
    </tr>

    <tr>
        <td>8</td>
        <td><span class="link" onclick="loadDistrictReport('29')">Eluru</span></td>
        <td>19</td>
        <td>19</td>
        <td>0</td>
    </tr>

    <tr>
        <td>9</td>
        <td><span class="link" onclick="loadDistrictReport('17')">Guntur</span></td>
        <td>12</td>
        <td>12</td>
        <td>0</td>
    </tr>

    <tr>
        <td>10</td>
        <td><span class="link" onclick="loadDistrictReport('27')">Kakinada</span></td>
        <td>14</td>
        <td>14</td>
        <td>0</td>
    </tr>

    <tr>
        <td>11</td>
        <td><span class="link" onclick="loadDistrictReport('28')">Konaseema</span></td>
        <td>14</td>
        <td>14</td>
        <td>0</td>
    </tr>

    <tr>
        <td>12</td>
        <td><span class="link" onclick="loadDistrictReport('16')">Krishna</span></td>
        <td>19</td>
        <td>19</td>
        <td>0</td>
    </tr>

    <tr>
        <td>13</td>
        <td><span class="link" onclick="loadDistrictReport('21')">Kurnool</span></td>
        <td>18</td>
        <td>18</td>
        <td>0</td>
    </tr>

    <tr>
        <td>14</td>
        <td><span class="link" onclick="loadDistrictReport('38')">Markapuram</span></td>
        <td>25</td>
        <td>25</td>
        <td>0</td>
    </tr>

    <tr>
        <td>15</td>
        <td><span class="link" onclick="loadDistrictReport('34')">Nandyal</span></td>
        <td>21</td>
        <td>21</td>
        <td>0</td>
    </tr>

    <tr>
        <td>16</td>
        <td><span class="link" onclick="loadDistrictReport('19')">Nellore</span></td>
        <td>24</td>
        <td>23</td>
        <td>1</td>
    </tr>

    <tr>
        <td>17</td>
        <td><span class="link" onclick="loadDistrictReport('30')">NTR</span></td>
        <td>11</td>
        <td>11</td>
        <td>0</td>
    </tr>

    <tr>
        <td>18</td>
        <td><span class="link" onclick="loadDistrictReport('31')">Palnadu</span></td>
        <td>18</td>
        <td>18</td>
        <td>0</td>
    </tr>

    <tr>
        <td>19</td>
        <td><span class="link" onclick="loadDistrictReport('26')">Parvathipuram-Manyam</span></td>
        <td>7</td>
        <td>7</td>
        <td>0</td>
    </tr>

    <tr>
        <td>20</td>
        <td><span class="link" onclick="loadDistrictReport('37')">Polavaram</span></td>
        <td>1</td>
        <td>1</td>
        <td>0</td>
    </tr>

    <tr>
        <td>21</td>
        <td><span class="link" onclick="loadDistrictReport('18')">Prakasam</span></td>
        <td>19</td>
        <td>18</td>
        <td>1</td>
    </tr>

    <tr>
        <td>22</td>
        <td><span class="link" onclick="loadDistrictReport('11')">Srikakulam</span></td>
        <td>23</td>
        <td>23</td>
        <td>0</td>
    </tr>

    <tr>
        <td>23</td>
        <td><span class="link" onclick="loadDistrictReport('35')">Sri Satyasai</span></td>
        <td>15</td>
        <td>15</td>
        <td>0</td>
    </tr>

    <tr>
        <td>24</td>
        <td><span class="link" onclick="loadDistrictReport('36')">Tirupati</span></td>
        <td>25</td>
        <td>25</td>
        <td>0</td>
    </tr>

    <tr>
        <td>25</td>
        <td><span class="link" onclick="loadDistrictReport('13')">Visakhapatnam</span></td>
        <td>33</td>
        <td>33</td>
        <td>0</td>
    </tr>

    <tr>
        <td>26</td>
        <td><span class="link" onclick="loadDistrictReport('12')">Vizianagaram</span></td>
        <td>29</td>
        <td>29</td>
        <td>0</td>
    </tr>

    <tr>
        <td>27</td>
        <td><span class="link" onclick="loadDistrictReport('15')">West Godavari</span></td>
        <td>18</td>
        <td>18</td>
        <td>0</td>
    </tr>

    <tr>
        <td>28</td>
        <td><span class="link" onclick="loadDistrictReport('20')">YSR</span></td>
        <td>35</td>
        <td>35</td>
        <td>0</td>
    </tr>

</table>

<!-- Loader for district -->
<div id="districtLoader" class="loader"><div class="spinner"></div></div>
<div id="districtSection" class="section"></div>

<!-- Loader for ITI -->
<div id="itiLoader" class="loader"><div class="spinner"></div></div>
<div id="itiSection" class="section"></div>

</body>
</html>