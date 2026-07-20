<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verification Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <style>
        .top-header-bar { background-color: var(--header-navy, #0b4d8c); color: white; padding: 10px; }
        .table tfoot td { font-weight: bold; background-color: #f8f9fa; }
        
        /* Verification Form Specific Styles */
        .verification-form-container { background-color: #f8f9fa; min-height: 100vh; padding: 20px; display: none; }
        .section-header { color: #0d6efd; font-weight: 600; font-size: 1.1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 8px; margin-bottom: 15px; }
        .card-custom { border-radius: 8px; border: 1px solid #dee2e6; box-shadow: 0 .125rem .25rem rgba(0,0,0,.075); margin-bottom: 20px; background: #fff; padding: 20px; }
        .info-row { display: flex; margin-bottom: 10px; align-items: center; }
        .info-label { width: 140px; color: #6c757d; font-size: 0.9rem; margin-bottom: 0; }
        .info-value { flex: 1; }
        .info-value input { background-color: #f8f9fa; border: 1px solid #ced4da; }
        .info-value input[readonly] { cursor: not-allowed; }
        .doc-row { display: flex; align-items: center; padding: 10px 0; border-bottom: 1px solid #f1f1f1; }
        .doc-row:last-child { border-bottom: none; }
        .doc-num { width: 40px; font-weight: bold; }
        .doc-name { flex: 1; font-weight: 500; font-size: 0.95rem; }
        .doc-radios { display: flex; gap: 15px; }
        .form-check-label { margin-left: 5px; font-size: 0.9rem; }
        
        /* Marks Layout */
        .marks-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .marks-grid .info-row { margin-bottom: 0px; }
        .total-row { text-align: right; color: #0d6efd; font-weight: bold; margin-top: 15px; display: flex; justify-content: flex-end; align-items: center; }

        /* Print Styles */
        @media print {
            body { background: #fff !important; }
            #overviewContainer, #successViewContainer, nav, .navbar, button { display: none !important; }
            #verificationFormContainer { display: block !important; position: static !important; width: 100% !important; margin: 0 !important; padding: 0 !important; }
            .card-custom { border: 0 !important; box-shadow: none !important; padding: 0 !important; margin-bottom: 15px !important; }
            input[type="text"] { border: 0 !important; background: transparent !important; padding: 0 !important; font-weight: bold !important; color: #000 !important; }
            #approvalFooter { display: block !important; }
            #verificationMsg { display: none !important; }
            .section-header { border-bottom: 2px solid #000 !important; color: #000 !important; }
            .doc-row { border-bottom: 1px solid #ccc !important; }
            .doc-radios input[type="radio"]:not(:checked) + label { display: none !important; }
            .doc-radios input[type="radio"]:not(:checked) { display: none !important; }
            .doc-radios { font-weight: bold; color: #000; }
        }
    </style>
</head>
<body>
    
    

    <!-- OVERVIEW VIEW -->
    <div id="overviewContainer" class="container mt-4 mb-5">
        <div class="card shadow-sm border-0">
            <div class="card-header top-header-bar rounded-top">
                <h4 class="mb-0 text-center" id="reportTitle">VERIFICATION REPORT</h4>
            </div>
            <div class="card-body bg-light">
                <div class="table-responsive bg-white p-3 rounded border">
                    <table class="table table-striped table-bordered table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="text-center align-middle" style="width: 80px;">S.No</th>
                                <th class="align-middle">District Name</th>
                                <th class="text-center align-middle">Verified Applications</th>
                                <th class="text-center align-middle">Rejected Applications</th>
                                <th class="text-center align-middle">Unverified Applications</th>
                                <th class="text-center align-middle bg-primary border-primary">Total Applications</th>
                            </tr>
                        </thead>
                        <tbody id="reportTableBody">
                            <tr>
                                <td colspan="6" class="text-center py-5">
                                    <div class="spinner-border text-primary mb-2" role="status"></div>
                                    <div class="text-muted fw-bold">Fetching verification data...</div>
                                </td>
                            </tr>
                        </tbody>
                        <tfoot id="reportTableFoot"></tfoot>
                    </table>
                </div>

                <!-- Unverified Candidates Button -->
                <div class="text-center mt-4">
                    <button id="loadUnverifiedBtn" class="btn btn-warning fw-bold px-4 py-2 shadow-sm text-dark">
                        <i class="fas fa-list-ul me-2"></i> Unverified Candidates
                    </button>
                </div>

                <!-- Unverified Candidates Table Container (Hidden initially) -->
                <div id="unverifiedContainer" class="mt-4" style="display: none;">
                    <h5 class="text-secondary fw-bold mb-3 border-bottom pb-2">
                        <i class="fas fa-users text-warning me-2"></i>Unverified Candidates List
                    </h5>
                    <div class="table-responsive bg-white rounded border">
                        <table class="table table-striped table-bordered table-hover mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th class="text-center align-middle" style="width: 60px;">S.No</th>
                                    <th class="align-middle">Registration ID</th>
                                    <th class="align-middle">Candidate Name</th>
                                    <th class="align-middle">Father Name</th>
                                    <th class="text-center align-middle">DOB</th>
                                    <th class="text-center align-middle">Gender</th>
                                    <th class="text-center align-middle bg-primary text-white border-primary">Verify</th>
                                </tr>
                            </thead>
                            <tbody id="unverifiedTableBody"></tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- VERIFICATION FORM VIEW (Hidden initially) -->
    <div id="verificationFormContainer" class="verification-form-container">
        <div class="container-fluid mx-auto" style="max-width: 1200px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="mb-1 fw-bold text-dark">Verify Candidate Application</h3>
                    <p class="text-muted mb-0">Applicant: <span id="headerCandidateName" class="fw-bold"></span> (<span id="headerRegId"></span>)</p>
                </div>
                <button id="backToListBtn" class="btn btn-secondary fw-bold shadow-sm">BACK TO LIST</button>
            </div>

            <div class="row">
                <!-- Personal Information -->
                <div class="col-lg-6">
                    <div class="card-custom">
                        <h4 class="section-header">Personal Information</h4>
                        
                        <div class="info-row">
                            <label class="info-label">Hall Ticket No:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_htno" readonly></div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Name:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_name" readonly></div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Father Name:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_fname" readonly></div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Mother Name:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_mname" readonly></div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Gender:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_gender" readonly></div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">DOB:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_dob" readonly></div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Aadhar No:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_aadhar" readonly></div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Caste:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_caste" readonly></div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Address:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="pi_address" readonly></div>
                        </div>
                    </div>
                </div>

                <!-- Academic & Marks -->
                <div class="col-lg-6">
                    <div class="card-custom">
                        <div class="d-flex justify-content-between align-items-start">
                            <h4 class="section-header w-100">Academic & Marks</h4>
                            <div class="ms-3 mb-3" style="width: 120px; height: 150px; flex-shrink: 0; position: relative; top: -10px;">
                                <img id="candidatePhoto" src="" alt="Candidate Photo" 
                                     style="width: 120px; height: 150px; object-fit: cover; border: 3px solid #fff; border-radius: 6px; box-shadow: 0 4px 8px rgba(0,0,0,0.15); background-color: #f1f1f1;">
                                <div id="photoPlaceholderText" class="text-muted text-center" style="position: absolute; top: 60px; width: 100%; font-size: 0.8rem; display: none;">No Photo</div>
                            </div>
                        </div>
                        
                        <div class="info-row mb-3" style="margin-top: -120px;">
                            <label class="info-label" style="width: 120px;">SSC Board:</label>
                            <div class="info-value" style="padding-right: 140px;"><input type="text" class="form-control form-control-sm" id="am_board" readonly></div>
                        </div>
                        <div class="info-row mb-3">
                            <label class="info-label" style="width: 120px;">Year of Pass:</label>
                            <div class="info-value" style="padding-right: 140px;"><input type="text" class="form-control form-control-sm" id="am_yop" readonly></div>
                        </div>
                        <div class="info-row mb-3">
                            <label class="info-label" style="width: 120px;">Category:</label>
                            <div class="info-value" style="padding-right: 140px;"><input type="text" class="form-control form-control-sm" id="am_category" readonly></div>
                        </div>
                        <div class="info-row mb-4">
                            <label class="info-label" style="width: 120px;">Phys. Challenged:</label>
                            <div class="info-value"><input type="text" class="form-control form-control-sm" id="am_phc" readonly></div>
                        </div>

                        <h4 class="section-header" style="font-size: 1rem;">SSC Marks Details</h4>
                        <div class="marks-grid">
                            <div class="info-row">
                                <label class="info-label text-muted" style="width: 130px; font-size: 0.8rem;">First language</label>
                                <div class="info-value"><input type="text" class="form-control form-control-sm text-center" id="mk_1st" readonly></div>
                            </div>
                            <div class="info-row">
                                <label class="info-label text-muted" style="width: 130px; font-size: 0.8rem;">Second Language</label>
                                <div class="info-value"><input type="text" class="form-control form-control-sm text-center" id="mk_2nd" readonly></div>
                            </div>
                            <div class="info-row">
                                <label class="info-label text-muted" style="width: 130px; font-size: 0.8rem;">Third Language-English</label>
                                <div class="info-value"><input type="text" class="form-control form-control-sm text-center" id="mk_3rd" readonly></div>
                            </div>
                            <div class="info-row">
                                <label class="info-label text-muted" style="width: 130px; font-size: 0.8rem;">Mathematics</label>
                                <div class="info-value"><input type="text" class="form-control form-control-sm text-center" id="mk_math" readonly></div>
                            </div>
                            <div class="info-row">
                                <label class="info-label text-muted" style="width: 130px; font-size: 0.8rem;">General Science</label>
                                <div class="info-value"><input type="text" class="form-control form-control-sm text-center" id="mk_sci" readonly></div>
                            </div>
                            <div class="info-row">
                                <label class="info-label text-muted" style="width: 130px; font-size: 0.8rem;">Social Studies</label>
                                <div class="info-value"><input type="text" class="form-control form-control-sm text-center" id="mk_soc" readonly></div>
                            </div>
                        </div>
                        <div class="total-row">
                            <span class="me-2 text-dark">Total:</span> 
                            <input type="text" class="form-control form-control-sm text-center fw-bold text-primary" id="mk_total" style="width: 80px;" readonly>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Documents Verified -->
            <div class="card-custom mt-2">
                <h4 class="section-header">List of Documents Verified</h4>
                <div id="documentsListContainer">
                    <!-- Dynamically generated documents -->
                    <div class="text-center text-muted">Loading documents...</div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex justify-content-between align-items-center mt-4 print-hide">
                <div>
                    <button id="btnVerifyNext" class="btn text-white fw-bold shadow-sm" style="background-color: #6c757d;">Verify Next Application</button>
                    <button id="btnPrint" class="btn btn-primary fw-bold shadow-sm ms-2"><i class="fas fa-print me-1"></i> Print Application</button>
                </div>
                <div>
                    <button id="btnReject" class="btn btn-outline-danger fw-bold shadow-sm px-4 bg-white">REJECT CANDIDATE</button>
                    <button id="btnApprove" class="btn btn-success fw-bold shadow-sm px-4 ms-2">APPROVE CANDIDATE</button>
                </div>
            </div>
            
            <div id="verificationMsg" class="mt-3 text-center fw-bold" style="display: none;"></div>

            <!-- Approval Footer (Visible only in Print after Approval) -->
            <div id="approvalFooter" class="mt-4 pt-3 border-top" style="display: none;">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="text-success fw-bold m-0"><i class="fas fa-check-double me-2"></i> APPROVED</h4>
                        <p class="mb-0 text-muted" style="font-size: 0.9rem;">Verified via Unified AP ITI Portal</p>
                    </div>
                    <div class="text-end">
                        <p class="mb-0 fw-bold">Verification Date & Time</p>
                        <p class="mb-0 text-muted" id="approvalTimestamp"></p>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- SUCCESS VIEW (Hidden initially) -->
    <div id="successViewContainer" class="container mt-5" style="display: none; max-width: 700px;">
        <div class="card shadow border-0 text-center">
            <div class="card-body py-5">
                <i class="fas fa-check-circle text-success mb-3" style="font-size: 5rem;"></i>
                <h3 class="fw-bold mb-3 text-dark">Candidate <span id="successRegId" class="text-primary"></span> is verified</h3>
                <p class="text-muted mb-4 fs-5">The candidate's application has been successfully approved.</p>
                
                <div class="d-flex justify-content-center gap-3 mt-4">
                    <button id="btnSuccessPrint" class="btn btn-outline-primary px-4 py-2 fw-bold shadow-sm">
                        <i class="fas fa-print me-2"></i> Print Application
                    </button>
                    <button id="btnSuccessNext" class="btn btn-success px-4 py-2 fw-bold shadow-sm">
                        Verify Next Candidate <i class="fas fa-arrow-right ms-2"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>








        // Global State
        window.unverifiedCandidates = [];
        window.currentCandidateIndex = -1;
        window.currentRegId = null;
        window.currentDocuments = [];

        document.addEventListener('DOMContentLoaded', async function () {
            // Load base statistics
            loadDistrictStats();
        });

        async function loadDistrictStats() {
            try {
                const response = await fetch('/api/district-wise-stats', { credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include' 
                });
                const jsonResp = await response.json();
                const tbody = document.getElementById('reportTableBody');
                const tfoot = document.getElementById('reportTableFoot');
                const reportTitle = document.getElementById('reportTitle');
                tbody.innerHTML = ''; tfoot.innerHTML = '';

                if (jsonResp.success) {
                    if(jsonResp.data && jsonResp.data.length > 0) {
                        const data = jsonResp.data;
                        let distName = "ALL DISTRICTS";
                        if(data.length === 1 && data[0].district_name && data[0].district_name !== 'N/A') { distName = data[0].district_name.toUpperCase(); }
                        reportTitle.textContent = distName + " VERIFIED AND UNVERIFIED APPLICATIONS COUNT";

                        let totalApproved = 0, totalRejected = 0, totalUnverified = 0, grandTotal = 0;
                        data.forEach((row, index) => {
                            const rowTotal = row.approved + row.rejected + row.unverified;
                            totalApproved += row.approved; totalRejected += row.rejected; totalUnverified += row.unverified; grandTotal += rowTotal;
                            tbody.innerHTML += `
                                <tr>
                                    <td class="text-center fw-bold text-muted">\${index + 1}</td>
                                    <td class="fw-bold">\${row.district_name || row.district_code}</td>
                                    <td class="text-center text-success fw-bold">\${row.approved}</td>
                                    <td class="text-center text-danger fw-bold">\${row.rejected}</td>
                                    <td class="text-center text-warning fw-bold">\${row.unverified}</td>
                                    <td class="text-center text-primary fw-bold bg-light">\${rowTotal}</td>
                                </tr>`;
                        });
                        if(data.length > 1) {
                            tfoot.innerHTML = `<tr><td colspan="2" class="text-end text-primary fs-5 border-end-0">GRAND TOTAL:</td><td class="text-center text-success fs-5">\${totalApproved}</td><td class="text-center text-danger fs-5">\${totalRejected}</td><td class="text-center text-warning fs-5">\${totalUnverified}</td><td class="text-center text-white bg-primary fs-5 border-primary">\${grandTotal}</td></tr>`;
                        }
                    } else {
                        tbody.innerHTML = '<tr><td colspan="6" class="text-center py-4 fw-bold text-muted">No records found.</td></tr>';
                    }
                } else {
                    tbody.innerHTML = `<tr><td colspan="6" class="text-center py-4 fw-bold text-danger">\${jsonResp.message || 'Error fetching data.'}</td></tr>`;
                }
            } catch (error) {
                document.getElementById('reportTableBody').innerHTML = `<tr><td colspan="6" class="text-center py-4 text-danger fw-bold"><i class="fas fa-exclamation-triangle me-2"></i> Failed to connect</td></tr>`;
            }
        }

        // Load Unverified Candidates
        document.getElementById('loadUnverifiedBtn').addEventListener('click', async function() {
            const container = document.getElementById('unverifiedContainer');
            const tbody = document.getElementById('unverifiedTableBody');
            const btn = this;
            
            btn.innerHTML = `<span class="spinner-border spinner-border-sm me-2" role="status"></span> Loading...`;
            btn.disabled = true;
            container.style.display = 'block';
            tbody.innerHTML = `<tr><td colspan="7" class="text-center py-4 fw-bold text-muted">Loading candidates...</td></tr>`;

            try {
                const response = await fetch('/api/unverified-candidates', { credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include' 
                });

                const jsonResp = await response.json();
                tbody.innerHTML = '';

                if (jsonResp.success) {
                    window.unverifiedCandidates = jsonResp.data || [];
                    
                    if (window.unverifiedCandidates.length > 0) {
                        window.unverifiedCandidates.forEach((cand, index) => {
                            tbody.innerHTML += `
                                <tr>
                                    <td class="text-center fw-bold text-muted">\${index + 1}</td>
                                    <td class="fw-bold">\${cand.regid || 'N/A'}</td>
                                    <td>\${cand.name || 'N/A'}</td>
                                    <td>\${cand.fname || 'N/A'}</td>
                                    <td class="text-center">\${cand.dob ? new Date(cand.dob).toLocaleDateString('en-GB') : 'N/A'}</td>
                                    <td class="text-center text-uppercase">\${cand.gender || 'N/A'}</td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-success fw-bold px-3 shadow-sm verify-btn" data-index="\${index}" data-regid="\${cand.regid}">
                                            <i class="fas fa-check-circle me-1"></i> Verify
                                        </button>
                                    </td>
                                </tr>
                            `;
                        });

                        document.querySelectorAll('.verify-btn').forEach(button => {
                            button.addEventListener('click', function() {
                                openVerificationForm(parseInt(this.getAttribute('data-index')));
                            });
                        });
                    } else {
                        tbody.innerHTML = '<tr><td colspan="7" class="text-center py-4 fw-bold text-muted">No unverified candidates found.</td></tr>';
                    }
                } else {
                    tbody.innerHTML = `<tr><td colspan="7" class="text-center py-4 fw-bold text-danger">\${jsonResp.message || 'Error fetching candidates.'}</td></tr>`;
                }
            } catch (error) {
                tbody.innerHTML = `<tr><td colspan="7" class="text-center py-4 text-danger fw-bold"><i class="fas fa-exclamation-triangle me-2"></i> Connection failed.</td></tr>`;
            } finally {
                btn.innerHTML = `<i class="fas fa-list-ul me-2"></i> Unverified Candidates`;
                btn.disabled = false;
            }
        });

        // Open Verification Form for Candidate
        async function openVerificationForm(index) {
            if (index < 0 || index >= window.unverifiedCandidates.length) {
                alert("No more candidates to verify.");
                return closeVerificationForm();
            }

            window.currentCandidateIndex = index;
            const cand = window.unverifiedCandidates[index];
            window.currentRegId = cand.regid;

            // Switch UI
            document.getElementById('overviewContainer').style.display = 'none';
            document.getElementById('successViewContainer').style.display = 'none';
            document.getElementById('verificationFormContainer').style.display = 'block';
            document.getElementById('verificationMsg').style.display = 'none';
            
            // Set Header
            document.getElementById('headerCandidateName').textContent = cand.name || 'Unknown';
            document.getElementById('headerRegId').textContent = cand.regid;

            // Clear values before fetching
            document.querySelectorAll('.info-value input').forEach(inp => inp.value = 'Loading...');
            document.getElementById('documentsListContainer').innerHTML = '<div class="text-center text-muted py-3">Loading documents...</div>';

            try {
                const response = await fetch(`/api/candidate/\${cand.regid}`, { credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include' 
                });
                
                const data = await response.json();
                
                // Populate Personal Information
                document.getElementById('pi_htno').value = data.ssc_regno || 'N/A';
                document.getElementById('pi_name').value = data.name || 'N/A';
                document.getElementById('pi_fname').value = data.fname || 'N/A';
                document.getElementById('pi_mname').value = data.mname || 'N/A';
                document.getElementById('pi_gender').value = data.gender || 'N/A';
                document.getElementById('pi_dob').value = data.dob ? new Date(data.dob).toLocaleDateString('en-GB') : 'N/A';
                document.getElementById('pi_aadhar').value = data.adarno || 'N/A';
                document.getElementById('pi_caste').value = data.caste || 'N/A';
                document.getElementById('pi_address').value = data.addr || 'N/A';

                // Populate Academic Marks
                document.getElementById('am_board').value = data.ssc_board || 'N/A';
                document.getElementById('am_yop').value = data.ssc_year || 'N/A';
                document.getElementById('am_category').value = data.caste || 'N/A';
                document.getElementById('am_phc').value = data.phc ? 'Yes' : 'No';

                // Photo Display
                const photoEl = document.getElementById('candidatePhoto');
                const placeholderText = document.getElementById('photoPlaceholderText');
                if (data.photos && data.photos.pic) {
                    photoEl.src = 'data:image/jpeg;base64,' + data.photos.pic;
                    photoEl.style.display = 'block';
                    placeholderText.style.display = 'none';
                } else {
                    photoEl.src = '';
                    photoEl.style.display = 'none';
                    placeholderText.style.display = 'block';
                }

                const marks = data.marks || {};
                document.getElementById('mk_1st').value = marks.first_language || '0';
                document.getElementById('mk_2nd').value = marks.second_language || '0';
                document.getElementById('mk_3rd').value = marks.third_language || '0';
                document.getElementById('mk_math').value = marks.mathematics || '0';
                document.getElementById('mk_sci').value = marks.general_science || '0';
                document.getElementById('mk_soc').value = marks.social_studies || '0';
                document.getElementById('mk_total').value = marks.total || '0';

                // Populate Documents
                window.currentDocuments = data.documents || [];
                let docHtml = '';
                window.currentDocuments.forEach((doc) => {
                    const savedVal = data[doc.col] || doc.default;
                    const radioName = `doc_\${doc.col}`;
                    
                    docHtml += `
                        <div class="doc-row">
                            <div class="doc-num">\${doc.s_no}</div>
                            <div class="doc-name">\${doc.name}</div>
                            <div class="doc-radios">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="\${radioName}" id="\${radioName}_yes" value="Yes" \${savedVal === 'Yes' ? 'checked' : ''}>
                                    <label class="form-check-label" for="\${radioName}_yes">Yes</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="\${radioName}" id="\${radioName}_no" value="No" \${savedVal === 'No' ? 'checked' : ''}>
                                    <label class="form-check-label" for="\${radioName}_no">No</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="\${radioName}" id="\${radioName}_na" value="Not Applicable" \${savedVal === 'Not Applicable' ? 'checked' : ''}>
                                    <label class="form-check-label" for="\${radioName}_na">Not Applicable</label>
                                </div>
                            </div>
                        </div>
                    `;
                });
                
                document.getElementById('documentsListContainer').innerHTML = docHtml;

            } catch (error) {
                console.error("Error loading candidate profile:", error);
                document.getElementById('documentsListContainer').innerHTML = '<div class="text-center text-danger py-3">Failed to load candidate details.</div>';
            }
        }

        // Close Verification Form
        function closeVerificationForm() {
            document.getElementById('verificationFormContainer').style.display = 'none';
            document.getElementById('successViewContainer').style.display = 'none';
            document.getElementById('overviewContainer').style.display = 'block';
            document.getElementById('loadUnverifiedBtn').click(); // refresh list
        }

        document.getElementById('backToListBtn').addEventListener('click', closeVerificationForm);

        // Submit Verification
        async function submitVerification(status) {
            const msgEl = document.getElementById('verificationMsg');
            msgEl.style.display = 'block';
            msgEl.className = "mt-3 text-center fw-bold text-primary";
            msgEl.textContent = "Processing...";

            // Gather document states
            let doc_states = {};
            window.currentDocuments.forEach(doc => {
                const radioName = `doc_\${doc.col}`;
                const checked = document.querySelector(`input[name="\${radioName}"]:checked`);
                doc_states[doc.col] = checked ? checked.value : doc.default;
            });

            const payload = {
                app_status: status,
                doc_states: doc_states
            };

            try {
                const response = await fetch(`/api/candidate/\${window.currentRegId}`, { credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include',
                    body: JSON.stringify(payload)
                });
                const respMatch = await response.json();

                if(respMatch.success) {
                    window.unverifiedCandidates.splice(window.currentCandidateIndex, 1);
                    
                    if (status === 'A') {
                        // Reveal Success Screen
                        document.getElementById('verificationFormContainer').style.display = 'none';
                        document.getElementById('successViewContainer').style.display = 'block';
                        document.getElementById('successRegId').textContent = window.currentRegId;
                        
                        // Set Approval Timestamp for Print Footer
                        const now = new Date();
                        document.getElementById('approvalTimestamp').textContent = now.toLocaleString('en-IN', { dateStyle: 'medium', timeStyle: 'short' });
                    } else {
                        // Rejections automatically trigger the next candidate
                        msgEl.className = "mt-3 text-center fw-bold text-success";
                        msgEl.textContent = `Candidate Rejected successfully! Loading next...`;
                        setTimeout(() => {
                            openVerificationForm(window.currentCandidateIndex); 
                        }, 1200);
                    }
                } else {
                    msgEl.className = "mt-3 text-center fw-bold text-danger";
                    msgEl.textContent = `Error: \${respMatch.message || 'Failed to update'}`;
                }

            } catch (error) {
                console.error(error);
                msgEl.className = "mt-3 text-center fw-bold text-danger";
                msgEl.textContent = "Network error. Failed to submit.";
            }
        }

        document.getElementById('btnApprove').addEventListener('click', () => submitVerification('A'));
        document.getElementById('btnReject').addEventListener('click', () => submitVerification('R'));
        document.getElementById('btnVerifyNext').addEventListener('click', () => {
            openVerificationForm(window.currentCandidateIndex + 1);
        });

        // Success View Button Binding
        document.getElementById('btnSuccessNext').addEventListener('click', () => {
            // Because we spliced out the approved candidate, index points to the "new" next one
            openVerificationForm(window.currentCandidateIndex);
        });
        
        document.getElementById('btnSuccessPrint').addEventListener('click', () => {
            window.print();
        });

        // Also allow printing right from the unverified view if they want
        document.getElementById('btnPrint').addEventListener('click', () => {
            document.getElementById('approvalFooter').style.display = 'none'; // Hide approved banner if not yet approved
            window.print();
        });

    







</script>
</body>
</html>
