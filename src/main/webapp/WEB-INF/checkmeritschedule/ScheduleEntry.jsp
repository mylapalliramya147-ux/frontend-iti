<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Schedule Entry - AP ITI</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .page-header-custom {
            background-color: #0b4d8c;
            color: white;
            padding: 20px 0;
            margin-bottom: 30px;
            border-bottom: 4px solid #083a6b;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .form-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }
        .card-header-primary {
            background-color: #0b4d8c;
            color: white;
            font-weight: 700;
            padding: 15px 25px;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .card-body-custom {
            padding: 30px;
            background-color: #fff;
        }
        .form-label-custom {
            font-weight: 600;
            color: #0b4d8c;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        .form-control-custom {
            border: 1.5px solid #dee2e6;
            border-radius: 8px;
            padding: 10px 15px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .form-control-custom:focus {
            border-color: #0b4d8c;
            box-shadow: 0 0 0 4px rgba(11,77,140,0.1);
        }
        .btn-success-custom {
            background-color: #28a745;
            border: none;
            color: white;
            font-weight: 700;
            padding: 10px 30px;
            border-radius: 50px;
            transition: all 0.3s;
        }
        .btn-success-custom:hover {
            background-color: #218838;
            transform: translateY(-1px);
        }
        .btn-danger-custom {
            background-color: #dc3545;
            border: none;
            color: white;
            font-weight: 700;
            padding: 10px 30px;
            border-radius: 50px;
            transition: all 0.3s;
        }
        .btn-danger-custom:hover {
            background-color: #c82333;
            transform: translateY(-1px);
        }
        .info-text-custom {
            font-size: 0.9rem;
            color: #6c757d;
            font-style: italic;
        }
        #timingContainer {
            display: none;
            animation: slideUp 0.5s ease;
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .read-only-box {
            background-color: #f8fbff;
            border: 1px solid #e1ecf8;
            padding: 12px 15px;
            border-radius: 8px;
            font-weight: 600;
            color: #0b4d8c;
        }
    </style>
</head>
<body class="bg-light">

    <jsp:include page="/WEB-INF/reports/bannernew.jsp" />
    <jsp:include page="/WEB-INF/checkmeritschedule/authNavbar.jsp" />

    <div class="page-header-custom text-center">
        <div class="container">
            <h2 class="mb-0"><i class="fas fa-calendar-alt me-2"></i> Admission Schedule Portal</h2>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row justify-content-center">
            
            <!-- Step 1: Initial Parameters (Medium size) -->
            <div class="col-lg-7" id="initContainer">
                <div class="card form-card">
                    <div class="card-header-primary d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-cog"></i> Schedule Initialization</span>
                        <span class="badge bg-light text-dark p-2" style="font-size: 0.85rem;">Phase: <span id="headerPhase">...</span></span>
                    </div>
                    <div class="card-body card-body-custom">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label-custom">Category / Reservation:</label>
                                <select id="casteSelect" class="form-select form-control-custom">
                                    <option value="all">All Categories</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-custom">Minimum Qualification:</label>
                                <select id="qualSelect" class="form-select form-control-custom">
                                    <option value="all">All Qualifications</option>
                                    <option value="SSC Passed">SSC Passed</option>
                                    <option value="8th Passed">8th Passed</option>
                                </select>
                            </div>
                            <div class="col-12 text-center mt-4 border-top pt-4">
                                <button class="btn btn-success-custom me-2" onclick="initializeSchedule()">
                                    <i class="fas fa-check-circle me-1"></i> Submit Initialization
                                </button>
                                <button class="btn btn-danger-custom" onclick="resetInitForm()">
                                    <i class="fas fa-undo me-1"></i> Reset Form
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Step 2: Assignments (Medium size) -->
            <div class="col-lg-8" id="timingContainer">
                <div class="card form-card border-success">
                    <div class="card-header-primary bg-success">
                        <i class="fas fa-clock"></i> Assign Timing & Merit Ranges
                    </div>
                    <div class="card-body card-body-custom">
                        <div class="row g-4">
                            <!-- Read Only Information -->
                            <div class="col-md-12">
                                <div class="row text-center mb-2">
                                    <div class="col-md-3">
                                        <label class="form-label-custom d-block">District/ITI name:</label>
                                        <div id="dispEntity" class="read-only-box">-</div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label-custom d-block">Qualification:</label>
                                        <div id="dispQual" class="read-only-box">-</div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label-custom d-block">Reservation:</label>
                                        <div id="dispCaste" class="read-only-box">-</div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label-custom d-block">Current Phase:</label>
                                        <div id="dispPhase" class="read-only-box">-</div>
                                    </div>
                                </div>
                            </div>

                            <hr class="mt-4">

                            <!-- Inputs -->
                            <div class="col-md-6">
                                <label class="form-label-custom">Merit Rank From:</label>
                                <input type="number" id="meritFrom" class="form-control form-control-custom" placeholder="e.g. 1" min="1">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-custom">Merit Rank To:</label>
                                <input type="number" id="meritTo" class="form-control form-control-custom" placeholder="e.g. 500" min="1">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label-custom">Call Date:</label>
                                <input type="date" id="calDate" class="form-control form-control-custom">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-custom">Call Time (08:00 - 18:00):</label>
                                <input type="text" id="calTime" class="form-control form-control-custom" placeholder="HH:MM (24-hour)" maxlength="5" oninput="this.value = this.value.replace(/[^0-9:]/g, ''); if(this.value.length === 2 && !this.value.includes(':')) this.value += ':';">
                                <p class="info-text-custom mt-1"><i class="fas fa-info-circle me-1"></i> Office timings are strictly 8 AM to 6 PM.</p>
                            </div>

                            <div class="col-12 text-center mt-4 border-top pt-4">
                                <button class="btn btn-success-custom me-2" onclick="saveTimings()">
                                    <i class="fas fa-save me-1"></i> Save Schedule
                                </button>
                                <button class="btn btn-danger-custom" onclick="clearTimingForm()">
                                    <i class="fas fa-trash me-1"></i> Clear All
                                </button>
                                <div id="feedbackArea" class="mt-3 fw-bold"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>
        const API_BASE = "http://localhost:8080/itiapchecklistmeritlist/admission-timings";
        const NODE_API_BASE = 'http://localhost:8080/itiapchecklistmeritlist';
        let currentInitData = null;

        // Fetch Caste List
        async function fetchCastes() {
            try {
                // Fetch Global Status (Year/Phase)
                const statusResp = await fetch(`${NODE_API_BASE}/api/status`, { 
                    credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' }
                });
                const statusRes = await statusResp.json();
                if (statusRes.success) {
                    document.getElementById('headerPhase').innerText = statusRes.phase;
                }

                // Fetch Caste List
                const response = await fetch(`${NODE_API_BASE}/api/dsc/caste-list`, { 
                    credentials: 'include'
                });
                const result = await response.json();
                if (result.success && result.data) {
                    const select = document.getElementById('casteSelect');
                    result.data.forEach(item => {
                        const opt = document.createElement('option');
                        opt.value = opt.textContent = item.caste_code;
                        select.appendChild(opt);
                    });
                }
            } catch (err) {
                console.error("Initialization error:", err);
            }
        }

        // Initialize Schedule (Step 1)
        async function initializeSchedule() {
            const caste = document.getElementById('casteSelect').value;
            const qual = document.getElementById('qualSelect').value;

            const payload = { reservation: caste, minqul: qual };

            try {
                const response = await fetch(API_BASE + '/entry', { 
                    credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });

                const result = await response.json();
                if (result.success) {
                    currentInitData = payload;
                    // Handle placeholder response - build data from payload if not provided
                    const responseData = result.data || {
                        dist_name: localStorage.getItem('displayName') || 'Unknown',
                        iti_name: localStorage.getItem('displayName') || 'Unknown',
                        reservation: payload.reservation,
                        minqul: payload.minqul,
                        phase: document.getElementById('headerPhase').innerText
                    };
                    showTimingForm(responseData);
                } else {
                    alert("Initialization Failed: " + (result.error || result.message || "Unknown error"));
                }
            } catch (err) {
                console.error("Submit Error:", err);
            }
        }

        function showTimingForm(data) {
            // Populate display fields: Priority to Backend Data, Fallback to Session displayName
            const sessionName = localStorage.getItem('displayName') || 'Unknown';
            document.getElementById('dispEntity').innerText = data.dist_name || data.iti_name || sessionName;
            document.getElementById('dispQual').innerText = data.minqul || '-';
            document.getElementById('dispCaste').innerText = data.reservation || '-';
            document.getElementById('dispPhase').innerText = data.phase || document.getElementById('headerPhase').innerText || '-';

            // Show container
            document.getElementById('timingContainer').style.display = 'block';
            window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
        }

        // Save Timings (Step 2)
        async function saveTimings() {
            const feedback = document.getElementById('feedbackArea');
            feedback.innerText = "";
            feedback.className = "mt-3 fw-bold";

            const payload = {
                ...currentInitData,
                meritFrom:parseInt(document.getElementById('meritFrom').value),
                meritTo: parseInt(document.getElementById('meritTo').value),
                calDate: document.getElementById('calDate').value,
                calTime: document.getElementById('calTime').value
            };

            // Basic Validation
            if (!payload.meritFrom || !payload.meritTo || !payload.calDate || !payload.calTime) {
                setFeedback("Please fill all timing fields.", "text-danger");
                return;
            }

            // Time Validation (08:00 to 18:00)
            const [hours, minutes] = payload.calTime.split(':').map(Number);
            if (hours < 8 || hours > 18 || (hours === 18 && minutes > 0)) {
                setFeedback("Error: Time must be between 08:00 and 18:00 (Office Timings).", "text-danger");
                return;
            }

            try {
                const response = await fetch(API_BASE + '/timings', { 
                    credentials: 'include',
                    method: 'PUT',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });

                const result = await response.json();
                if (result.success) {
                    setFeedback("Schedule entered successfully!", "text-success");
                    // Optionally clear or scroll
                } else {
                    setFeedback("Error: " + (result.error || result.message || "Unknown error"), "text-danger");
                }
            } catch (err) {
                setFeedback("Submission error occurred.", "text-danger");
            }
        }

        function setFeedback(msg, className) {
            const feedback = document.getElementById('feedbackArea');
            feedback.innerText = msg;
            feedback.className = "mt-3 fw-bold " + className;
        }

        function resetInitForm() {
            document.getElementById('casteSelect').value = 'all';
            document.getElementById('qualSelect').value = 'all';
            document.getElementById('timingContainer').style.display = 'none';
        }

        function clearTimingForm() {
            document.getElementById('meritFrom').value = "";
            document.getElementById('meritTo').value = "";
            document.getElementById('calDate').value = "";
            document.getElementById('calTime').value = "";
            document.getElementById('feedbackArea').innerText = "";
        }

        // Start
        window.onload = fetchCastes;
    </script>
</body>
</html>