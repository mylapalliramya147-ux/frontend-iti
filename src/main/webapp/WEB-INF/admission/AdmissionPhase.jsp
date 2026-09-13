<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admission Phase - AP ITI</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #64748b;
            --success-color: #22c55e;
            --bg-light: #f8fafc;
            --card-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        body {
            background-color: var(--bg-light);
            font-family: 'Inter', sans-serif;
            color: #1e293b;
        }

        h2, h3, h5 {
            font-family: 'Outfit', sans-serif;
            font-weight: 600;
        }

        .main-container {
            padding: 2rem 0;
            max-width: 1200px;
        }

        .form-card {
            background: #ffffff;
            border: none;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .card-header-custom {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            color: #fff;
            padding: 1.25rem 1.5rem;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-body-custom {
            padding: 2rem;
        }

        .form-label-custom {
            font-weight: 500;
            font-size: 0.875rem;
            color: #475569;
            margin-bottom: 0.5rem;
        }

        .form-control-custom, .form-select-custom {
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 0.625rem 1rem;
            transition: all 0.2s;
        }

        .form-control-custom:focus, .form-select-custom:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .btn-submit {
            background-color: #198754 !important; /* Force Bootstrap Success Green */
            color: white !important;
            border: none;
            padding: 0.75rem 2.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-submit:hover {
            background-color: #16a34a;
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn-clear {
            background-color: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
            padding: 0.75rem 2.5rem;
            border-radius: 8px;
            font-weight: 600;
        }

        .results-table-container {
            margin-top: 2rem;
        }

        .table-custom {
            border-collapse: separate;
            border-spacing: 0 8px;
        }

        .table-custom thead th {
            background-color: #f1f5f9;
            border: none;
            color: #475569;
            font-weight: 600;
            padding: 1rem;
        }

        .table-custom tbody tr {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
            border-radius: 8px;
        }

        .table-custom tbody td {
            padding: 1rem;
            border-top: 1px solid #f1f5f9;
            border-bottom: 1px solid #f1f5f9;
        }

        .table-custom tbody td:first-child { border-left: 1px solid #f1f5f9; border-top-left-radius: 8px; border-bottom-left-radius: 8px; }
        .table-custom tbody td:last-child { border-right: 1px solid #f1f5f9; border-top-right-radius: 8px; border-bottom-right-radius: 8px; }

        .student-card {
            background: linear-gradient(to right, #ffffff, #f1f5f9);
            border-left: 4px solid var(--primary-color);
            border-radius: 12px;
            padding: 2rem;
            margin-top: 1.5rem;
            display: none;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        .seat-matrix-container {
            max-height: 550px;
            overflow-y: auto;
            overflow-x: hidden; /* Only vertical scroll */
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            background: #fff;
            scrollbar-width: thin;
        }

        /* Custom scrollbar styling for Chrome/Safari/Edge */
        .seat-matrix-container::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        .seat-matrix-container::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 10px;
        }
        .seat-matrix-container::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }
        .seat-matrix-container::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        .table-seat-matrix {
            font-size: 0.85rem;
            margin-bottom: 0;
            white-space: nowrap;
        }

        .table-seat-matrix thead {
            position: sticky;
            top: 0;
            z-index: 10;
            background: #f8fafc;
        }

        .category-header {
            text-align: center;
            font-weight: 700;
            background: #f1f5f9 !important;
            border-bottom: 2px solid #cbd5e1 !important;
        }

        .tfv-header {
            font-size: 0.75rem;
            text-align: center;
            background: #f8fafc !important;
            padding: 0.25rem !important;
        }

        .tfv-cell {
            text-align: center;
            padding: 0.5rem 0.25rem !important;
        }

        .tfv-val {
            display: inline-block;
            width: 24px;
            height: 24px;
            line-height: 22px;
            border-radius: 4px;
            font-weight: 600;
            border: 1px solid #ddd;
        }

        .tfv-t { background: #eff6ff; color: #2563eb; }
        .tfv-f { background: #fff7ed; color: #ea580c; }
        .tfv-v { background: #f0fdf4; color: #16a34a; }

        .confirmation-box {
            background: #fefce8;
            border: 1px solid #fef08a;
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 2rem;
            display: none;
        }

        .btn-yes { background-color: #22c55e; color: #fff; font-weight: 600; padding: 0.6rem 2rem; border-radius: 8px; border: none; }
        .btn-no { background-color: #ef4444; color: #fff; font-weight: 600; padding: 0.6rem 2rem; border-radius: 8px; border: none; }
        
        .search-bar-container {
            margin-bottom: 1rem;
            position: relative;
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }

        .search-input {
            padding-left: 2.75rem !important;
            border-radius: 10px;
        }

        /* Print Styles */
        @media print {
            body { background: #fff !important; }
            .navbar, .btn, .card-header-custom, .form-card, .search-bar-container, .badge-phase, .breadcrumb, .admission-status, #filterSection, #resultsSection, #rankSection {
                display: none !important;
            }
            #printSection {
                display: block !important;
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                background: #fff;
                padding: 1rem;
            }
            .print-header { border-bottom: 2px solid #000; margin-bottom: 2rem; padding-bottom: 1rem; }
            .print-table { width: 100%; border-collapse: collapse; margin-top: 1.5rem; }
            .print-table th, .print-table td { padding: 0.75rem; border: 1px solid #ddd; text-align: left; }
            .print-table th { background: #f8f9fa !important; width: 35%; }
            .photo-box {
                width: 120px;
                height: 150px;
                border: 1px solid #000;
                float: right;
                text-align: center;
                line-height: 150px;
                font-size: 0.8rem;
                color: #666;
                margin-top: 10px;
                margin-bottom: 20px;
                overflow: hidden;
            }
        }

        #printSection { display: none; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/bannernew.jsp" />
    <jsp:include page="/WEB-INF/authNavbar.jsp" />

    <div class="container main-container">
        <!-- Section 1: Filter Selection -->
        <div class="card form-card">
            <div class="card-header-custom justify-content-between">
                <span><i class="fas fa-filter me-2"></i> select the below caste,qualificaiton and time</span>
                <span class="badge-phase">Active Phase: <span id="currentPhase">...</span></span>
            </div>
            <div class="card-body card-body-custom">
                <form id="filterForm">
                    <div class="row g-4 align-items-end">
                        <div class="col-md-3">
                            <label class="form-label-custom">Caste:</label>
                            <select id="casteSelect" class="form-select form-select-custom">
                                <option value="all">All</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label-custom">Qualification:</label>
                            <select id="qualSelect" class="form-select form-select-custom">
                                <option value="all">All</option>
                                <option value="8th pass">8th pass</option>
                                <option value="SSC pass">SSC pass</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label-custom">Date:</label>
                            <input type="date" id="dateSelect" class="form-control form-control-custom">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label-custom">Admission Timings (HH:MM):</label>
                            <div class="d-flex gap-2">
                                <select id="hour" class="form-select form-select-custom">
                                    <option value="">HH</option>
                                    <% for(int i=0; i<24; i++){ %>
                                        <option value="<%= String.format("%02d", i) %>"><%= String.format("%02d", i) %></option>
                                    <% } %>
                                </select>
                                <input type="number" id="minute" class="form-control form-control-custom" placeholder="MM" min="0" max="59" step="1" oninput="if(value > 59) value=59; if(value < 0) value=0;">
                            </div>
                        </div>
                        <div class="col-md-2 text-center">
                            <button type="submit" class="btn btn-submit btn-success w-100">Submit</button>
                        </div>
                    </div>
                </form>
                <div id="filterError" class="alert alert-danger mt-3" style="display: none; border-radius: 8px; font-size: 0.9rem;"></div>
            </div>
        </div>

        <!-- Section 2: Results Table -->
        <div id="resultsSection" style="display: none;">
            <div class="d-flex align-items-center gap-3 mb-4">
                <div style="width: 4px; height: 24px; background: var(--primary-color); border-radius: 2px;"></div>
                <h4 class="mb-0">ADMISSION COUNSELLING</h4>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>DATE</th>
                            <th>MERIT RANGE</th>
                            <th>CASTE</th>
                            <th>QUALIFICATION</th>
                            <th>TIME</th>
                        </tr>
                    </thead>
                    <tbody id="timingsTableBody">
                        <!-- Data dynamic -->
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Section 3: Rank Lookup -->
        <div id="rankSection" class="card form-card mt-5" style="display: none;">
            <div class="card-header-custom">
                <i class="fas fa-search me-2"></i> Enter Rank
            </div>
            <div class="card-body card-body-custom">
                <form id="rankForm">
                    <div class="row g-4 align-items-end">
                        <div class="col-md-6">
                            <label class="form-label-custom">Rank:</label>
                            <input type="number" id="rankInput" class="form-control form-control-custom" placeholder="Enter student merit rank..." required>
                        </div>
                        <div class="col-md-6 d-flex gap-3">
                            <button type="submit" class="btn btn-submit btn-success flex-grow-1">Submit</button>
                            <button type="button" id="clearRank" class="btn btn-clear flex-grow-1">Clear</button>
                        </div>
                    </div>
                </form>
                <div id="rankError" class="alert alert-danger mt-3" style="display: none; border-radius: 8px; font-size: 0.9rem;"></div>

                <!-- Student Details Expanded -->
                <div id="studentDetails" class="student-card">
                    <div class="row align-items-center mb-4">
                        <div class="col-md-8">
                            <h4 id="studentName" class="text-primary mb-1">...</h4>
                            <p class="text-muted mb-0">Registration ID: <span id="studentRegId" class="fw-bold">...</span> | Father's Name: <span id="studentFather" class="fw-bold">...</span></p>
                        </div>
                        <div class="col-md-4 text-end">
                            <span class="badge bg-primary fs-6 px-3 py-2">Rank: <span id="studentRankDisp">...</span></span>
                        </div>
                    </div>
                    <div class="row g-4 text-center">
                        <div class="col-6 col-md-3">
                            <label class="text-muted small d-block mb-1">Caste</label>
                            <span id="studentCaste" class="fw-bold">...</span>
                        </div>
                        <div class="col-6 col-md-2">
                            <label class="text-muted small d-block mb-1">Gender</label>
                            <span id="studentGender" class="fw-bold">...</span>
                        </div>
                        <div class="col-6 col-md-2">
                            <label class="text-muted small d-block mb-1">Date of Birth</label>
                            <span id="studentDOB" class="fw-bold">...</span>
                        </div>
                        <div class="col-6 col-md-2">
                            <label class="text-muted small d-block mb-1">PH / Ex-S</label>
                            <span id="studentPHEx" class="fw-bold">... / ...</span>
                        </div>
                        <div class="col-6 col-md-3">
                            <label class="text-muted small d-block mb-1">Academic Year</label>
                            <span id="studentYear" class="fw-bold text-success">...</span>
                        </div>
                    </div>
                </div>

                <!-- Already Admitted Notice -->
                <div id="alreadyAdmittedSection" class="alert alert-info mt-4" style="display: none; border: 1px solid #93c5fd; background-color: #eff6ff; border-radius: 12px;">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="text-primary mb-1"><i class="fas fa-info-circle me-2"></i> Already Admitted</h5>
                            <p class="mb-0" id="admNoticeText">Student is already admitted.</p>
                        </div>
                        <button type="button" class="btn btn-primary px-4 py-2" onclick="window.print()"><i class="fas fa-print me-2"></i> Print Application</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Section 4: Admission Flow (Seat Matrix & Verification) -->
        <div id="admissionSection" style="display: none;">
            <!-- Seat Matrix -->
            <div class="card form-card">
                <div class="card-header-custom">
                    <i class="fas fa-th-list me-2"></i> Select ITI and Trade from Seat Matrix
                </div>
                <div class="card-body card-body-custom">
                    <div class="search-bar-container">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" id="itiSearch" class="form-control form-control-custom search-input" placeholder="Search college by name...">
                    </div>
                    
                    <div class="seat-matrix-container">
                        <table class="table table-bordered table-seat-matrix">
                            <thead>
                                <tr>
                                    <th rowspan="2" class="align-middle text-center">ITI Name</th>
                                    <th rowspan="2" class="align-middle text-center">Trade Name</th>
                                    <th rowspan="2" class="align-middle text-center">Select</th>
                                    <th rowspan="2" class="align-middle text-center">Total</th>
                                    <th colspan="3" class="category-header">General</th>
                                    <th colspan="3" class="category-header">IM</th>
                                    <th colspan="3" class="category-header">PH</th>
                                    <th colspan="3" class="category-header">EX-S</th>
                                </tr>
                                <tr>
                                    <th class="tfv-header">T</th><th class="tfv-header">F</th><th class="tfv-header">V</th>
                                    <th class="tfv-header">T</th><th class="tfv-header">F</th><th class="tfv-header">V</th>
                                    <th class="tfv-header">T</th><th class="tfv-header">F</th><th class="tfv-header">V</th>
                                    <th class="tfv-header">T</th><th class="tfv-header">F</th><th class="tfv-header">V</th>
                                </tr>
                            </thead>
                            <tbody id="seatMatrixBody">
                                <!-- Data dynamic -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Additional Details & Final Submit -->
            <div class="card form-card">
                <div class="card-header-custom">
                    <i class="fas fa-user-check me-2"></i> Verification & Final Admission
                </div>
                <div class="card-body card-body-custom">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label-custom">Identification Mark 1:</label>
                            <input type="text" id="idMark1" class="form-control form-control-custom" placeholder="Enter identification mark 1">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-custom">Identification Mark 2:</label>
                            <input type="text" id="idMark2" class="form-control form-control-custom" placeholder="Enter identification mark 2">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label-custom">SSC Reg No:</label>
                            <input type="text" id="sscRegNo" class="form-control form-control-custom" readonly>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label-custom">SSC Year of Pass:</label>
                            <input type="text" id="sscYear" class="form-control form-control-custom" readonly>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label-custom">Type of Admission:</label>
                            <select id="admissionBoard" class="form-select form-select-custom">
                                <option value="">Select Board</option>
                            </select>
                        </div>
                    </div>

                    <div class="text-center mt-5">
                        <button type="button" id="btnTakeAdmission" class="btn btn-submit btn-success btn-lg px-5">Take Admission</button>
                    </div>

                    <!-- Confirmation Panel -->
                    <div id="confirmationPanel" class="confirmation-box text-center">
                        <h5 class="mb-4 text-dark"><i class="fas fa-question-circle text-warning me-2"></i> Are you sure to proceed with the admission?</h5>
                        <div class="d-flex justify-content-center gap-3">
                            <button type="button" id="confirmYes" class="btn-yes"><i class="fas fa-check me-2"></i> Yes, Proceed</button>
                            <button type="button" id="confirmNo" class="btn-no"><i class="fas fa-times me-2"></i> No, Cancel</button>
                        </div>
                    </div>

                    <!-- Admission Error Alert -->
                    <div id="admissionError" class="alert alert-danger mt-3" style="display: none; border-radius: 8px;"></div>

                    <!-- Success Alert -->
                    <div id="admissionSuccess" class="alert alert-success mt-4" style="display: none;">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <i class="fas fa-check-circle me-2"></i> Admission successful! 
                                <strong id="successMsg"></strong>
                            </div>
                            <button type="button" id="btnPrintApp" class="btn btn-primary d-print-none">
                                <i class="fas fa-print me-2"></i> Print Application
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Section 5: Hidden Print Document -->
    <div id="printSection">
        <div class="print-header text-center">
            <img src="/assets/img/gov_logo.png" style="height: 60px;" alt="" onerror="this.style.display='none'">
            <h3 class="mt-2 text-uppercase">Government of Andhra Pradesh</h3>
            <h5>Department of Employment and Training</h5>
            <h4 class="mt-3">ITI ADMISSION RECEIPT - 2026</h4>
        </div>

        <div class="photo-box">
            <img id="pStudentPhoto" src="" style="width: 100%; height: 100%; object-fit: cover; display: none;" />
            <span id="pPhotoText">Student Photo</span>
        </div>

        <div style="clear: both;"></div>

        <table class="print-table">
            <tr><th>Registration ID</th><td id="pRegId"></td></tr>
            <tr><th>Candidate Name</th><td id="pName"></td></tr>
            <tr><th>Father's Name</th><td id="pFather"></td></tr>
            <tr><th>Rank</th><td id="pRank"></td></tr>
            <tr><th>Date of Admission</th><td id="pAdmDate"></td></tr>
            <tr><th>Admission Number</th><td id="pAdmNum" class="fw-bold fs-5"></td></tr>
            <tr><th>Institute Allotted</th><td id="pITI"></td></tr>
            <tr><th>Trade Allotted</th><td id="pTrade"></td></tr>
        </table>

        <div class="mt-5 pt-5 row">
            <div class="col-6 text-start">
                <br><br>
                _______________________<br>
                Candidate Signature
            </div>
            <div class="col-6 text-end">
                <br><br>
                _______________________<br>
                Principal/Superintendent Stamp
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Global error handling for debugging
        window.onerror = function(msg, url, line, col, error) {
            console.error("Global JS Error: " + msg + " at " + line + ":" + col);
            return false;
        };

        const NODE_API_BASE = 'http://10.72.4.135:5051';
        let currentStudent = null;
        let seatMatrixData = [];

        document.addEventListener('DOMContentLoaded', () => {
            console.log("DOM Content Loaded - Initializing...");
            try {
                initPage();
                setupEventListeners();
            } catch (err) {
                console.error("Fatal initialization error:", err);
            }
        });

        async function initPage() {
            try {
                const statusResp = await fetch(`\${NODE_API_BASE}/api/status`, { credentials: 'include', 
                    method: 'POST',
                    credentials: 'include' 
                });
                const statusRes = await statusResp.json();
                if (statusRes.success) {
                    const el = document.getElementById('currentPhase');
                    if (el) el.innerText = statusRes.phase;
                }

                const casteResp = await fetch(`\${NODE_API_BASE}/api/dsc/caste-list`, { credentials: 'include', credentials: 'include' });
                const casteRes = await casteResp.json();
                if (casteRes.success && casteRes.data) {
                    const select = document.getElementById('casteSelect');
                    casteRes.data.forEach(item => {
                        const opt = document.createElement('option');
                        opt.value = item.caste_code;
                        opt.textContent = item.caste_code;
                        select.appendChild(opt);
                    });
                }
                fetchITIBoards();
            } catch (err) {
                console.error("initPage failed:", err);
            }
        }

        function setupEventListeners() {
            const fForm = document.getElementById('filterForm');
            if (fForm) fForm.addEventListener('submit', handleFilterSubmit);
            
            const rForm = document.getElementById('rankForm');
            if (rForm) rForm.addEventListener('submit', handleRankSubmit);
            
            const iSearch = document.getElementById('itiSearch');
            if (iSearch) iSearch.addEventListener('input', (e) => renderSeatMatrix(e.target.value));

            const takeBtn = document.getElementById('btnTakeAdmission');
            if (takeBtn) {
                takeBtn.addEventListener('click', () => {
                    console.log("Take Admission clicked");
                    const selected = document.querySelector('input[name="selectedTrade"]:checked');
                    if (!selected) {
                        alert("Please select an ITI and Trade from the list above.");
                        return;
                    }
                    const board = document.getElementById('admissionBoard').value;
                    if (!board) {
                        alert("Please select Type of Admission (Board).");
                        return;
                    }
                    
                    const panel = document.getElementById('confirmationPanel');
                    if (panel) {
                        panel.style.display = 'block';
                        setTimeout(() => {
                            panel.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        }, 100);
                    }
                });
            }

            const confirmYes = document.getElementById('confirmYes');
            if (confirmYes) confirmYes.addEventListener('click', processAdmission);

            const confirmNo = document.getElementById('confirmNo');
            if (confirmNo) confirmNo.addEventListener('click', () => {
                const panel = document.getElementById('confirmationPanel');
                if (panel) panel.style.display = 'none';
            });

            const clearBtn = document.getElementById('clearRank');
            if (clearBtn) clearBtn.addEventListener('click', () => {
                document.getElementById('rankInput').value = '';
                document.getElementById('studentDetails').style.display = 'none';
                document.getElementById('admissionSection').style.display = 'none';
                document.getElementById('alreadyAdmittedSection').style.display = 'none';
                document.getElementById('rankError').style.display = 'none';
                document.getElementById('admissionSuccess').style.display = 'none';
                document.getElementById('admissionError').style.display = 'none';
                currentStudent = null;
            });

            const printBtn = document.getElementById('btnPrintApp');
            if (printBtn) printBtn.addEventListener('click', () => window.print());
        }

        async function fetchITIBoards() {
            try {
                const resp = await fetch(`\${NODE_API_BASE}/api/admission/iti-boards`, { credentials: 'include', credentials: 'include' });
                const res = await resp.json();
                if (res.success) {
                    const select = document.getElementById('admissionBoard');
                    res.data.forEach(board => {
                        const opt = document.createElement('option');
                        opt.value = board.board_code;
                        opt.textContent = board.board_name;
                        select.appendChild(opt);
                    });
                }
            } catch (e) { console.error("Error fetching boards:", e); }
        }

        async function handleFilterSubmit(e) {
            e.preventDefault();
            const caste = document.getElementById('casteSelect').value;
            const minqul = document.getElementById('qualSelect').value;
            const date = document.getElementById('dateSelect').value;
            const h = document.getElementById('hour').value;
            const m = document.getElementById('minute').value;
            
            const payload = { caste, minqul };
            if (date) {
                payload.cal_date = date;
            }
            if (h && m) {
                const paddedM = m.toString().padStart(2, '0');
                payload.cal_time = `\${h}:\${paddedM}`;
            }

            try {
                const resp = await fetch(`\${NODE_API_BASE}/api/admission/view-timings`, { credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include',
                    body: JSON.stringify(payload)
                });
                const result = await resp.json();
                if (result.success && result.data) {
                    renderTimings(result.data);
                } else {
                    showFilterError(result.message || "No records found.");
                }
            } catch (err) {
                showFilterError("Failed to fetch timings.");
            }
        }

        function renderTimings(data) {
            document.getElementById('filterError').style.display = 'none';
            const tbody = document.getElementById('timingsTableBody');
            tbody.innerHTML = '';
            
            if (data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted py-4">No counseling sessions found.</td></tr>';
            } else {
                data.forEach(item => {
                    const row = `<tr>
                        <td>\${item.date}</td>
                        <td><span class="fw-bold text-primary">\${item.merit_range}</span></td>
                        <td>\${item.caste}</td>
                        <td>\${item.qualification}</td>
                        <td><i class="far fa-clock me-1 text-secondary"></i> \${item.cal_time}</td>
                    </tr>`;
                    tbody.insertAdjacentHTML('beforeend', row);
                });
            }
            document.getElementById('resultsSection').style.display = 'block';
            document.getElementById('rankSection').style.display = 'block';
            
            // Robust scroll
            setTimeout(() => {
                document.getElementById('resultsSection').scrollIntoView({ behavior: 'smooth', block: 'start' });
            }, 100);
        }

        async function handleRankSubmit(e) {
            e.preventDefault();
            const rank = document.getElementById('rankInput').value;
            try {
                const resp = await fetch(`\${NODE_API_BASE}/api/admission/get-student-by-rank`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include',
                    body: JSON.stringify({ rank })
                });
                const result = await resp.json();
                if (result.success && result.data) {
                    currentStudent = result.data;
                    showStudentDetails(result.data, rank);
                    fetchSeatMatrix();
                } else {
                    showRankError(result.message || "Student not found.");
                }
            } catch (err) {
                showRankError("Failed to lookup rank.");
            }
        }

        function showStudentDetails(s, rank) {
            document.getElementById('rankError').style.display = 'none';
            document.getElementById('studentName').innerText = s.name || 'N/A';
            document.getElementById('studentRegId').innerText = s.regid || 'N/A';
            document.getElementById('studentFather').innerText = s.fname || 'N/A';
            document.getElementById('studentRankDisp').innerText = rank;
            document.getElementById('studentCaste').innerText = s.caste || 'N/A';
            document.getElementById('studentGender').innerText = s.gender || 'N/A';
            document.getElementById('studentDOB').innerText = s.dob ? new Date(s.dob).toLocaleDateString() : 'N/A';
            document.getElementById('studentPHEx').innerText = `\${s.phc === 'Y' ? 'Yes' : 'No'} / \${s.exservice === 'Y' ? 'Yes' : 'No'}`;
            document.getElementById('studentYear').innerText = s.year_of_admission || '2025-26';
            
            // Pre-fill form
            document.getElementById('sscRegNo').value = s.ssc_regno || '';
            document.getElementById('sscYear').value = s.ssc_year || '';
            
            document.getElementById('studentDetails').style.display = 'block';
            
            if (s.is_admitted && s.admission_details) {
                const adm = s.admission_details;
                document.getElementById('admissionSection').style.display = 'none';
                document.getElementById('alreadyAdmittedSection').style.display = 'block';
                document.getElementById('admNoticeText').innerHTML = `Student was admitted in <strong class="text-primary">\${adm.iti_name}</strong> for <strong class="text-primary">\${adm.trade_name}</strong> on <strong>\${new Date(adm.date_of_admission).toLocaleDateString('en-GB')}</strong>.`;
                
                // Populate Print Section
                document.getElementById('pRegId').textContent = s.regid;
                document.getElementById('pName').textContent = s.name;
                document.getElementById('pFather').textContent = s.fname;
                document.getElementById('pRank').textContent = rank;
                document.getElementById('pAdmDate').textContent = new Date(adm.date_of_admission).toLocaleDateString('en-GB');
                document.getElementById('pAdmNum').textContent = adm.adm_num;
                document.getElementById('pITI').textContent = adm.iti_name;
                document.getElementById('pTrade').textContent = adm.trade_name;

                if (s.photo_base64) {
                    let proto = s.photo_base64.startsWith('data:image') ? '' : 'data:image/jpeg;base64,';
                    document.getElementById('pStudentPhoto').src = proto + s.photo_base64;
                    document.getElementById('pStudentPhoto').style.display = 'block';
                    document.getElementById('pPhotoText').style.display = 'none';
                } else {
                    document.getElementById('pStudentPhoto').style.display = 'none';
                    document.getElementById('pPhotoText').style.display = 'inline';
                }
            } else {
                document.getElementById('admissionSection').style.display = 'block';
                document.getElementById('alreadyAdmittedSection').style.display = 'none';
            }
            
            // Robust scroll
            setTimeout(() => {
                document.getElementById('studentDetails').scrollIntoView({ behavior: 'smooth', block: 'start' });
            }, 100);
        }

        async function fetchSeatMatrix() {
            try {
                const resp = await fetch(`\${NODE_API_BASE}/api/admission/iti-seat-matrix`, { credentials: 'include',
                    method: 'POST',
                    credentials: 'include',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({})
                });
                const res = await resp.json();
                if (res.success) {
                    seatMatrixData = res.data;
                    renderSeatMatrix();
                }
            } catch (e) { console.error("Error matrix:", e); }
        }

        function renderSeatMatrix(filter = '') {
            const tbody = document.getElementById('seatMatrixBody');
            tbody.innerHTML = '';
            
            const filtered = seatMatrixData.filter(item => 
                item.iti_name.toLowerCase().includes(filter.toLowerCase()) ||
                item.trade_name.toLowerCase().includes(filter.toLowerCase())
            );

            filtered.forEach((item, idx) => {
                const row = `
                    <tr>
                        <td class="small">\${item.iti_name}</td>
                        <td class="small fw-bold">\${item.trade_name}</td>
                        <td class="text-center">
                            <input type="radio" name="selectedTrade" value="\${idx}" 
                                data-iti="\${item.iti_code}" data-trade="\${item.trade_code}"
                                data-iti-name="\${item.iti_name}" data-trade-name="\${item.trade_name}">
                        </td>
                        <td class="text-center fw-bold">\${item.strength_total || 'N/A'}</td>
                        <!-- General -->
                        <td class="tfv-cell"><span class="tfv-val tfv-t">\${item.categories.General.T}</span></td>
                        <td class="tfv-cell"><span class="tfv-val tfv-f">\${item.categories.General.F}</span></td>
                        <td class="tfv-cell"><span class="tfv-val tfv-v">\${item.categories.General.V}</span></td>
                        <!-- IM -->
                        <td class="tfv-cell"><span class="tfv-val tfv-t">\${item.categories.IM.T}</span></td>
                        <td class="tfv-cell"><span class="tfv-val tfv-f">\${item.categories.IM.F}</span></td>
                        <td class="tfv-cell"><span class="tfv-val tfv-v">\${item.categories.IM.V}</span></td>
                        <!-- PH -->
                        <td class="tfv-cell"><span class="tfv-val tfv-t">\${item.categories.PH.T}</span></td>
                        <td class="tfv-cell"><span class="tfv-val tfv-f">\${item.categories.PH.F}</span></td>
                        <td class="tfv-cell"><span class="tfv-val tfv-v">\${item.categories.PH.V}</span></td>
                        <!-- EX-S -->
                        <td class="tfv-cell"><span class="tfv-val tfv-t">\${item.categories.EXS.T}</span></td>
                        <td class="tfv-cell"><span class="tfv-val tfv-f">\${item.categories.EXS.F}</span></td>
                        <td class="tfv-cell"><span class="tfv-val tfv-v">\${item.categories.EXS.V}</span></td>
                    </tr>
                `;
                tbody.insertAdjacentHTML('beforeend', row);
            });
        }

        async function processAdmission() {
            const btn = document.getElementById('confirmYes');
            const originalText = btn.innerHTML;
            
            try {
                const selected = document.querySelector('input[name="selectedTrade"]:checked');
                if (!selected || !currentStudent) {
                    showAdmissionError("Missing selection or student data.");
                    return;
                }

                // Show loading
                btn.disabled = true;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Admitting...';
                document.getElementById('admissionError').style.display = 'none';

                const payload = {
                    regid: currentStudent.regid,
                    trade_code: selected.dataset.trade,
                    iti_code: selected.dataset.iti,
                    idmarks1: document.getElementById('idMark1').value,
                    idmarks2: document.getElementById('idMark2').value,
                    ssc_regno: currentStudent.ssc_regno,
                    ssc_board: currentStudent.ssc_board,
                    ssc_year: currentStudent.ssc_year,
                    ssc_month: currentStudent.ssc_month,
                    type_admission: document.getElementById('admissionBoard').value
                };

                console.log("Processing admission with payload:", payload);

                const resp = await fetch(`\${NODE_API_BASE}/api/admission/take-admission`, { credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include',
                    body: JSON.stringify(payload)
                });
                
                const res = await resp.json();
                console.log("Admission response:", res);

                if (res.success) {
                    document.getElementById('admissionError').style.display = 'none';
                    document.getElementById('confirmationPanel').style.display = 'none';
                    document.getElementById('admissionSuccess').style.display = 'block';
                    document.getElementById('successMsg').textContent = `\${payload.regid} successfully admitted in \${selected.dataset.itiName} in \${selected.dataset.tradeName}`;
                    
                    // Populate Print Section
                    document.getElementById('pRegId').textContent = payload.regid;
                    document.getElementById('pName').textContent = currentStudent.name;
                    document.getElementById('pFather').textContent = currentStudent.fname;
                    document.getElementById('pRank').textContent = document.getElementById('studentRankDisp').textContent;
                    document.getElementById('pAdmDate').textContent = new Date().toLocaleDateString('en-GB');
                    document.getElementById('pAdmNum').textContent = res.adm_num;
                    document.getElementById('pITI').textContent = selected.dataset.itiName;
                    document.getElementById('pTrade').textContent = selected.dataset.tradeName;

                    if (currentStudent.photo_base64) {
                        let proto = currentStudent.photo_base64.startsWith('data:image') ? '' : 'data:image/jpeg;base64,';
                        document.getElementById('pStudentPhoto').src = proto + currentStudent.photo_base64;
                        document.getElementById('pStudentPhoto').style.display = 'block';
                        document.getElementById('pPhotoText').style.display = 'none';
                    } else {
                        document.getElementById('pStudentPhoto').style.display = 'none';
                        document.getElementById('pPhotoText').style.display = 'inline';
                    }

                    setTimeout(() => {
                        document.getElementById('admissionSuccess').scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }, 100);
                    
                    document.getElementById('btnTakeAdmission').disabled = true;
                } else {
                    showAdmissionError(res.error || res.message || "Admission failed.");
                    btn.disabled = false;
                    btn.innerHTML = originalText;
                }
            } catch (err) {
                console.error("Admission process error:", err);
                showAdmissionError("Server error during admission. Check browser console.");
                btn.disabled = false;
                btn.innerHTML = originalText;
            }
        }

        function showAdmissionError(msg) {
            const errDiv = document.getElementById('admissionError');
            errDiv.textContent = msg;
            errDiv.style.display = 'block';
            errDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        function showFilterError(msg) {
            const errDiv = document.getElementById('filterError');
            errDiv.textContent = msg;
            errDiv.style.display = 'block';
            document.getElementById('resultsSection').style.display = 'none';
        }

        function showRankError(msg) {
            const errDiv = document.getElementById('rankError');
            errDiv.textContent = msg;
            errDiv.style.display = 'block';
            document.getElementById('studentDetails').style.display = 'none';
            document.getElementById('admissionSection').style.display = 'none';
        }
    </script>
</body>
</html>
