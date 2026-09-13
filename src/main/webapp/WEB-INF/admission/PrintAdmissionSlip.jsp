<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Print Admission Slip - AP ITI</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #2563eb;
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
            max-width: 900px;
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
            background-color: #198754 !important;
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
        }

        /* Print Styles */
        @media print {
            body { background: #fff !important; }
            .navbar, .btn, .card-header-custom, .form-card, .breadcrumb, #alreadyAdmittedSection {
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
        
        <div class="card form-card">
            <div class="card-header-custom">
                <i class="fas fa-print me-2"></i> Print Admission Slip
            </div>
            <div class="card-body card-body-custom">
                <form id="printSlipForm">
                    <div class="row g-4 align-items-end">
                        <div class="col-md-4">
                            <label class="form-label-custom">Registration ID:</label>
                            <input type="text" id="regidInput" class="form-control form-control-custom" placeholder="Enter Registration ID" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label-custom">Phase:</label>
                            <input type="text" id="phaseInput" class="form-control form-control-custom" placeholder="e.g. 1" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label-custom">Year:</label>
                            <input type="text" id="yearInput" class="form-control form-control-custom" placeholder="e.g. 2026" required>
                        </div>
                        <div class="col-md-2 text-end">
                            <button type="submit" class="btn btn-submit w-100">Submit</button>
                        </div>
                    </div>
                </form>
                
                <div id="errorMsg" class="alert alert-danger mt-4" style="display: none; border-radius: 8px;"></div>
                
                <!-- Notice Section -->
                <div id="alreadyAdmittedSection" class="alert alert-info mt-4" style="display: none; border: 1px solid #93c5fd; background-color: #eff6ff; border-radius: 12px;">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="text-primary mb-1"><i class="fas fa-info-circle me-2"></i> Admission Record Found</h5>
                            <p class="mb-0" id="admNoticeText">Student is already admitted.</p>
                        </div>
                        <button type="button" class="btn btn-primary px-4 py-2" onclick="window.print()"><i class="fas fa-print me-2"></i> Print Application</button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Hidden Print Document -->
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const NODE_API_BASE = 'http://10.72.4.135:5051';

        document.getElementById('printSlipForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const regid = document.getElementById('regidInput').value.trim();
            const phase = document.getElementById('phaseInput').value.trim();
            const year = document.getElementById('yearInput').value.trim();
            
            document.getElementById('errorMsg').style.display = 'none';
            document.getElementById('alreadyAdmittedSection').style.display = 'none';
            
            try {
                const response = await fetch(`\${NODE_API_BASE}/api/admission/print-slip-details`, { credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include',
                    body: JSON.stringify({ regid, phase, year })
                });
                
                const result = await response.json();
                
                if (result.success && result.data) {
                    const adm = result.data;
                    document.getElementById('alreadyAdmittedSection').style.display = 'block';
                    document.getElementById('admNoticeText').innerHTML = `Student <strong class="text-dark">\${adm.name || 'N/A'}</strong> was admitted in <strong class="text-primary">\${adm.iti_name}</strong> for <strong class="text-primary">\${adm.trade_name}</strong> on <strong>\${new Date(adm.date_of_admission).toLocaleDateString('en-GB')}</strong>.`;
                    
                    // Populate Print Section
                    document.getElementById('pRegId').textContent = adm.regid;
                    document.getElementById('pName').textContent = adm.name;
                    document.getElementById('pFather').textContent = adm.fname;
                    document.getElementById('pRank').textContent = adm.rank || 'N/A';
                    document.getElementById('pAdmDate').textContent = new Date(adm.date_of_admission).toLocaleDateString('en-GB');
                    document.getElementById('pAdmNum').textContent = adm.adm_num;
                    document.getElementById('pITI').textContent = adm.iti_name;
                    document.getElementById('pTrade').textContent = adm.trade_name;

                    if (adm.photo_base64) {
                        let proto = adm.photo_base64.startsWith('data:image') ? '' : 'data:image/jpeg;base64,';
                        document.getElementById('pStudentPhoto').src = proto + adm.photo_base64;
                        document.getElementById('pStudentPhoto').style.display = 'block';
                        document.getElementById('pPhotoText').style.display = 'none';
                    } else {
                        document.getElementById('pStudentPhoto').style.display = 'none';
                        document.getElementById('pPhotoText').style.display = 'inline';
                    }
                } else {
                    document.getElementById('errorMsg').textContent = result.message || result.error || "No admission details found.";
                    document.getElementById('errorMsg').style.display = 'block';
                }
            } catch (err) {
                console.error("Error fetching slip details:", err);
                document.getElementById('errorMsg').textContent = "Failed to communicate with server.";
                document.getElementById('errorMsg').style.display = 'block';
            }
        });
        
        // Auto fetch current phase and year to pre-fill inputs
        document.addEventListener('DOMContentLoaded', async () => {
             try {
                const response = await fetch(`\${NODE_API_BASE}/api/status`, { credentials: 'include', 
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include'
                });
                const result = await response.json();
                if (result.success) {
                    if (result.phase) document.getElementById('phaseInput').value = result.phase;
                    if (result.year) document.getElementById('yearInput').value = result.year;
                }
            } catch (err) {
                console.error("Error fetching default parameters:", err);
            }
        });
    </script>
</body>
</html>
