<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DSC List - AP ITI</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .form-container {
            max-width: 580px;
            margin: 30px auto;
        }
        .outer-border {
            border: 3px solid #004a99 !important;
            padding: 15px;
            border-radius: 12px;
            background: #fff;
        }
        .inner-box {
            background-color: #f8fbff; /* Very light blue */
            border: 1px solid #004a99 !important;
            padding: 25px 30px;
            border-radius: 8px;
        }
        .form-label-custom {
            font-weight: 700;
            color: #003366;
            font-size: 0.9rem;
            text-transform: uppercase;
        }
        .custom-select-box {
            border: 1.5px solid #004a99;
            font-weight: 500;
            color: #222;
            border-radius: 6px;
            padding: 6px 12px;
            background-color: #fff;
            font-size: 0.95rem;
        }
        /* Buttons */
        .btn-submit-custom {
            background: #004a99;
            border: none;
            color: #fff;
            font-weight: bold;
            padding: 10px 40px;
            border-radius: 50px;
            box-shadow: 0 4px 6px rgba(0,74,153,0.2);
            transition: 0.3s;
        }
        .btn-submit-custom:hover {
            background: #003366;
            transform: translateY(-2px);
        }
        .btn-reset-custom {
            background: #f1f1f1;
            border: 1.5px solid #004a99;
            color: #004a99;
            font-weight: bold;
            padding: 10px 40px;
            border-radius: 50px;
            transition: 0.3s;
        }
        .btn-reset-custom:hover {
            background: #e6f0fa;
        }
        .page-title {
            color: #004a99;
            font-weight: 800;
            font-size: 1.6rem;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Header Content -->
    <jsp:include page="/WEB-INF/bannernew.jsp" />
    <jsp:include page="/WEB-INF/checkmeritschedule/authNavbar.jsp" />

    <div class="container form-container">
        <div class="outer-border shadow-lg">
            <h2 class="page-title">Generate DSC List</h2>
            
            <div class="inner-box mt-2">
                <!-- District -->
                <div class="row mb-3 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">District:</label>
                    </div>
                    <div class="col-md-7">
                        <input type="text" id="districtDisplay" class="form-control custom-select-box" readonly style="background-color: #e9ecef;">
                    </div>
                </div>

                <!-- ITI -->
                <div class="row mb-3 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">ITI Name:</label>
                    </div>
                    <div class="col-md-7">
                        <select id="itiSelect" class="form-select custom-select-box">
                            <option value="">-- Select ITI --</option>
                        </select>
                    </div>
                </div>

                <!-- Trade -->
                <div class="row mb-3 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">Trade Name:</label>
                    </div>
                    <div class="col-md-7">
                        <select id="tradeSelect" class="form-select custom-select-box">
                            <option value="">-- Select Trade --</option>
                        </select>
                    </div>
                </div>

                <!-- Phase -->
                <div class="row mb-3 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">Admission Phase:</label>
                    </div>
                    <div class="col-md-5">
                        <select id="phaseSelect" class="form-select custom-select-box">
                            <option value="1">Phase 1</option>
                            <option value="2">Phase 2</option>
                            <option value="3">Phase 3</option>
                            <option value="4">Phase 4</option>
                            <option value="5">Phase 5</option>
                        </select>
                    </div>
                </div>

                <!-- Year -->
                <div class="row mb-3 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">Admission Year:</label>
                    </div>
                    <div class="col-md-5">
                        <select id="yearSelect" class="form-select custom-select-box">
                            <!-- Populated via JS -->
                        </select>
                    </div>
                </div>

                <!-- Level -->
                <div class="row mb-4 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">Admission Level:</label>
                    </div>
                    <div class="col-md-7">
                        <select id="levelSelect" class="form-select custom-select-box">
                            <option value="CONVENER">CONVENER</option>
                            <option value="ITI">ITI</option>
                        </select>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="row mt-4">
                    <div class="col-12 d-flex justify-content-center gap-3">
                        <button type="button" class="btn btn-submit-custom" onclick="submitDscList()">SUBMIT</button>
                        <button type="button" class="btn btn-reset-custom" onclick="resetForm()">Reset</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Global Footer -->
    <footer>
        <jsp:include page="/WEB-INF/footer.jsp" />
    </footer>

    <script>
        // Ensure we point to the Node backend correctly
        const NODE_API_BASE = "http://" + window.location.hostname + ":5051";

        document.addEventListener('DOMContentLoaded', async () => {
            // 1. Setup District Display
            let displayName = localStorage.getItem('displayName') || '';
            if (displayName.toLowerCase().startsWith('district:')) {
                displayName = displayName.substring(9).trim();
            }
            document.getElementById('districtDisplay').value = displayName || "N/A";

            // 2. Setup Year selection
            const yearSelect = document.getElementById('yearSelect');
            for (let y = 2026; y >= 2000; y--) {
                const opt = document.createElement('option');
                opt.value = y;
                opt.textContent = y;
                if(y === 2024) opt.selected = true; 
                yearSelect.appendChild(opt);
            }

            // 3. Fetch Data
            try {
                const distCode = localStorage.getItem('insCode');
                const itiUrl = "http://" + window.location.hostname + ":5051/getItisByDistrictCodes" + (distCode ? '?dist_code=' + distCode : '');
                const tradeUrl = NODE_API_BASE + '/api/dsc/trade-list';

                console.log("Loading DSC Filters:", itiUrl);

                const [itiResp, tradeResp] = await Promise.all([
                    fetch(itiUrl, { credentials: 'include', credentials: 'include' }),
                    fetch(tradeUrl, { credentials: 'include', credentials: 'include' })
                ]);

                if (!itiResp.ok || !tradeResp.ok) throw new Error("Backend response error");

                const itiData = await itiResp.json();
                const tradeData = await tradeResp.json();

                if (itiData.status === "SUCCESS" && itiData.data) {
                    const itiSelect = document.getElementById('itiSelect');
                    itiData.data.forEach(iti => {
                        const opt = document.createElement('option');
                        opt.value = iti.iti_code;
                        opt.textContent = iti.iti_name;
                        itiSelect.appendChild(opt);
                    });
                } else {
                    console.error("ITI Loading Failed", itiData.message);
                }

                if (tradeData.success && tradeData.data) {
                    const tradeSelect = document.getElementById('tradeSelect');
                    tradeData.data.forEach(trade => {
                        const opt = document.createElement('option');
                        opt.value = trade.trade_code;
                        opt.textContent = trade.trade_name;
                        tradeSelect.appendChild(opt);
                    });
                }
            } catch (err) {
                console.error("Fetch failure:", err);
                // Optionally show a user-friendly message
            }
        });

        function resetForm() {
            document.getElementById('itiSelect').selectedIndex = 0;
            document.getElementById('tradeSelect').selectedIndex = 0;
            document.getElementById('phaseSelect').selectedIndex = 0;
            document.getElementById('yearSelect').value = "2024";
            document.getElementById('levelSelect').selectedIndex = 0;
        }

        function submitDscList() {
            const iti = document.getElementById('itiSelect').value;
            const trade = document.getElementById('tradeSelect').value;
            if(!iti || !trade) {
                alert("Please select both ITI and Trade to proceed.");
                return;
            }
            alert("Fetching DSC List for Selected Criteria...");
        }
    </script>
</body>
</html>
