<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details | Nodal Reports</title>
    <link rel="shortcut icon" type="image/ico" href="iti.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .nodal-report-card { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1); }
        .nodal-card-header-dashboard { background: linear-gradient(135deg, #003366 0%, #1a4a72 100%); color: white; padding: 22px 30px; font-weight: 700; display: flex; align-items: center; gap: 15px; }
        .nodal-card-header-dashboard i { width: 38px; height: 38px; background: rgba(255, 255, 255, 0.2); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 1rem; }
        .form-label-official { font-size: 0.85rem; font-weight: 700; color: #445566; text-transform: uppercase; letter-spacing: 0.8px; display: block; }
        .form-select-official, .form-control-official { border: 1px solid #ced4da; border-radius: 6px; padding: 10px 15px; font-size: 1.05rem; color: #2d3748; background-color: #ffffff; transition: border-color 0.2s ease; width: 100%; }
        .form-select-official:focus, .form-control-official:focus { border-color: #003366; outline: none; box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1); }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .detail-section { background: #fff; border-radius: 8px; border: 1px solid #e0e0e0; margin-bottom: 20px; }
        .detail-section-header { background: #0f2c4e; color: white; padding: 15px 20px; font-weight: 700; font-size: 1.1rem; }
        .detail-table td:first-child { font-weight: 700; color: #445566; width: 35%; }
        .detail-table td:last-child { text-align: left; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="student_details" />
    <%@ include file="../nodal_navbar.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>STUDENT REG DETAILS</h2></div>
    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 600px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;"><i class="fas fa-search me-2"></i> Search Student</div>
            <div class="p-5 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event)">
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5"><label for="searchType" class="form-label-official mb-md-0">Search By</label></div>
                        <div class="col-md-7">
                            <select name="searchType" id="searchType" class="form-select-official w-100" onchange="updatePlaceholder()">
                                <option value="regid">Registration ID</option>
                                <option value="admNum">Admission Number</option>
                            </select>
                        </div>
                    </div>
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5"><label for="searchValue" class="form-label-official mb-md-0" id="searchLabel">Registration ID</label></div>
                        <div class="col-md-7"><input type="text" name="searchValue" id="searchValue" class="form-control-official" placeholder="Enter Registration ID"></div>
                    </div>
                    <div class="mt-5 text-center">
                        <button type="submit" class="btn-submit-official-navy w-100"><i class="fas fa-search me-2"></i>VIEW DETAILS</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="loader-spinner" id="loader"><i class="fas fa-spinner fa-spin fa-3x"></i><p class="mt-3 fw-bold">Loading student details...</p></div>
    <div class="container mt-4" id="reportView" style="display: none;">
        <div class="text-center mb-3" style="color: #003366;"><h2 class="fw-bold fs-4 mb-2">Student Complete Details</h2></div>
        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()"><i class="fas fa-arrow-left me-2"></i> BACK TO SEARCH</button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;"><i class="fas fa-print me-2"></i>PRINT DETAILS</button>
        </div>
        <div id="detailContent"></div>
    </div>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        function showSelection() { document.getElementById('reportView').style.display = 'none'; document.getElementById('selectionView').style.display = 'block'; }
        function updatePlaceholder() {
            const searchType = document.getElementById('searchType').value;
            const input = document.getElementById('searchValue');
            const label = document.getElementById('searchLabel');
            if (searchType === 'regid') {
                label.innerText = 'Registration ID';
                input.placeholder = 'Enter Registration ID';
            } else {
                label.innerText = 'Admission Number';
                input.placeholder = 'Enter Admission Number (e.g. 2024AB12345)';
            }
        }
        function fetchReport(event) {
            event.preventDefault();
            const searchType = document.getElementById('searchType').value;
            const searchValue = document.getElementById('searchValue').value;
            if (!searchValue) { alert('Please enter a value'); return; }
            if (searchType === 'regid' && !/^[0-9]{5,10}$/.test(searchValue)) {
                alert('Registration Number is invalid format, it should be numeric (5-10 digits)');
                document.getElementById('searchValue').value = '';
                document.getElementById('searchValue').focus();
                return;
            }
            if (searchType === 'admNum' && !/^[0-9]{4}[A-Z]{2}[0-9]{5,10}$/.test(searchValue)) {
                alert('Given Admission Number is Invalid, Enter a valid Admission Number');
                document.getElementById('searchValue').value = '';
                document.getElementById('searchValue').focus();
                return;
            }
            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';
            let params = searchType + '=' + encodeURIComponent(searchValue);
            fetch('${backendApiUrl}/student-details?' + params, { method: 'GET' })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                if (data.error) throw new Error(data.error);
                const content = document.getElementById('detailContent');
                content.innerHTML = '';

                const reg = data.registration || {};
                const ssc = data.sscMarks || {};
                const appliedItis = data.appliedItis || [];
                const verified = data.verified || {};
                const meritList = data.meritList || [];
                const admission = data.admission || {};

                content.innerHTML += '<div class="detail-section"><div class="detail-section-header">Registration Details</div><table class="table table-bordered mb-0 detail-table"><tr><td>Student Name</td><td>' + (reg.name || '-') + '</td></tr><tr><td>Registration ID</td><td>' + (reg.registrationId || '-') + '</td></tr><tr><td>Date of Birth</td><td>' + (reg.dateOfBirth || '-') + '</td></tr><tr><td>SSC Hall Ticket No</td><td>' + (reg.sscHtNo || '-') + '</td></tr><tr><td>Father Name</td><td>' + (reg.fatherName || '-') + '</td></tr><tr><td>Mother Name</td><td>' + (reg.motherName || '-') + '</td></tr><tr><td>Address</td><td>' + (reg.address || '-') + '</td></tr><tr><td>Phone No</td><td>' + (reg.phoneNo || '-') + '</td></tr><tr><td>Gender</td><td>' + (reg.gender || '-') + '</td></tr><tr><td>Caste</td><td>' + (reg.caste || '-') + '</td></tr><tr><td>SSC Passed</td><td>' + (reg.sscPassed || '-') + '</td></tr><tr><td>PHC</td><td>' + (reg.phc || '-') + '</td></tr><tr><td>SSC Pass Year</td><td>' + (reg.sscPassYear || '-') + '</td></tr><tr><td>Registered Phase</td><td>' + (reg.registeredPhase || '-') + '</td></tr><tr><td>Registration Date</td><td>' + (reg.registrationDate || '-') + '</td></tr><tr><td>Verified Date</td><td colspan="5">' + (reg.verifiedDate || '-') + '</td></tr></table></div>';

                content.innerHTML += '<div class="detail-section"><div class="detail-section-header">SSC Marks</div><table class="table table-bordered mb-0 detail-table"><tr><td>First Language</td><td>' + (ssc.firstLanguage || '-') + '</td><td>English</td><td>' + (ssc.english || '-') + '</td></tr><tr><td>Second Language</td><td>' + (ssc.secondLanguage || '-') + '</td><td>Maths</td><td>' + (ssc.maths || '-') + '</td></tr><tr><td>Science</td><td>' + (ssc.science || '-') + '</td><td>Total</td><td>' + (ssc.total || '-') + '</td></tr></table></div>';

                let appliedHtml = '<div class="detail-section"><div class="detail-section-header">Applied ITIs</div><table class="table table-bordered mb-0 detail-table"><thead><tr><th>ITI Code</th><th>ITI Name</th><th>Phase</th><th>Admissions Year</th></tr></thead><tbody>';
                if (appliedItis.length > 0) {
                    appliedItis.forEach(iti => {
                        appliedHtml += '<tr><td>' + (iti.itiCode || '-') + '</td><td style="text-align: left;">' + (iti.itiName || '-') + '</td><td>' + (iti.phase || '-') + '</td><td>' + (iti.admissionsYear || '-') + '</td></tr>';
                    });
                } else {
                    appliedHtml += '<tr><td colspan="4" style="text-align:center; padding:15px;">No ITIs applied.</td></tr>';
                }
                content.innerHTML += appliedHtml + '</tbody></table></div>';

                content.innerHTML += '<div class="detail-section"><div class="detail-section-header">Verified Details</div><table class="table table-bordered mb-0 detail-table"><tr><td>Verified Name</td><td>' + (verified.name || '-') + '</td></tr><tr><td>Registration ID</td><td>' + (verified.registrationId || '-') + '</td></tr><tr><td>SSC HT No</td><td>' + (verified.sscHtNo || '-') + '</td></tr><tr><td>Father Name</td><td>' + (verified.fatherName || '-') + '</td></tr><tr><td>Mother Name</td><td>' + (verified.motherName || '-') + '</td></tr><tr><td>SSC Pass Year</td><td>' + (verified.sscPassYear || '-') + '</td></tr><tr><td>Registration Date</td><td>' + (verified.registrationDate || '-') + '</td></tr></table></div>';

                let meritHtml = '<div class="detail-section"><div class="detail-section-header">Merit List</div><table class="table table-bordered mb-0 detail-table"><thead><tr><th>District</th><th>ITI Name</th><th>Rank</th><th>Phase</th><th>Qualification</th></tr></thead><tbody>';
                if (meritList.length > 0) {
                    meritList.forEach(m => {
                        meritHtml += '<tr><td>' + (m.distName || '-') + '</td><td style="text-align: left;">' + (m.itiName || '-') + '</td><td>' + (m.rank || '-') + '</td><td>' + (m.phase || '-') + '</td><td style="text-align: left;">' + (m.qualification || '-') + '</td></tr>';
                    });
                } else {
                    meritHtml += '<tr><td colspan="5" style="text-align:center; padding:15px;">No merit list entries.</td></tr>';
                }
                content.innerHTML += meritHtml + '</tbody></table></div>';

                content.innerHTML += '<div class="detail-section"><div class="detail-section-header">Admission Details</div><table class="table table-bordered mb-0 detail-table"><tr><td>District</td><td>' + (admission.district || '-') + '</td><td>ITI</td><td style="text-align: left;">' + (admission.iti || '-') + '</td></tr><tr><td>Trade</td><td style="text-align: left;">' + (admission.trade || '-') + '</td><td>Admission Number</td><td>' + (admission.admissionNumber || '-') + '</td></tr><tr><td>Reservation Category</td><td>' + (admission.reservationCategory || '-') + '</td><td>Year Of Admission</td><td>' + (admission.yearOfAdmission || '-') + '</td></tr><tr><td>Phase</td><td>' + (admission.phase || '-') + '</td><td>Date Of Admission</td><td>' + (admission.dateOfAdmission || '-') + '</td></tr><tr><td>Phone Number</td><td>' + (admission.phoneNumber || '-') + '</td><td></td><td></td></tr></table></div>';
            })
            .catch(error => { document.getElementById('loader').style.display = 'none'; document.getElementById('selectionView').style.display = 'block'; alert('Error loading data: ' + error.message); console.error('Error:', error); });
        }
    </script>
</body>
</html>
