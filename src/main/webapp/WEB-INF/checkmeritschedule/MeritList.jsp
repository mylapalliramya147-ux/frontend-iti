<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Merit List Management - AP ITI</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/all.min.css">
    <style>
        .form-container {
            max-width: 580px;
            margin: 30px auto;
        }
        /* Index-style "Generate Merit List" panel. Palette matches
           jsp/index.jsp via style.css + iti-portal.css (menu bar / footer,
           shared partials) and the pale-cyan box used by this module's own
           classic pages (admissionPhase1.jsp / MeritListPhaseOne.jsp). */
        .outer-border {
            border: 1px solid black !important;
            padding: 15px;
            border-radius: 20px;
            background: #e4eeb9;
        }
        .inner-box {
            background-color: #fff;
            border: 1px solid black !important;
            padding: 25px 30px;
            border-radius: 20px;
        }
        .form-label-custom {
            font-weight: 700;
            color: #660000; /* index.jsp maroon headings */
            font-size: 0.9rem;
            text-transform: uppercase;
            font-family: verdana, Arial, sans-serif;
        }
        .custom-select-box {
            border: 1.5px solid #b9c46d;
            font-weight: 500;
            color: #222;
            border-radius: 6px;
            padding: 6px 12px;
            background-color: #fff;
            font-size: 0.95rem;
        }

        /* ---- Native <select> dropdowns (Category / Qualification / Status) ----
           Replace the blue OS highlight that appears on hovered <option> items,
           and the blue Bootstrap focus ring, with the index palette. */
        .custom-select-box option:hover,
        .form-select option:hover {
            background-color: #b9c46d !important;
            color: #000000 !important;
        }
        .custom-select-box:focus,
        .form-select:focus {
            border-color: #4CAF50 !important;
            box-shadow: 0 0 0 0.25rem rgba(76, 175, 80, 0.25) !important;
        }
        /* Navbar dropdown items: replace legacy blue hover (#2f6fa5) with the
           index palette so MeritList matches ScheduleEntry. */
        body .dropdown-menu .dropdown-item:hover {
            background-color: #b9c46d !important;
            color: #000000 !important;
            padding-left: 25px;
        }
        /* Buttons - index.jsp palette: green submit, yellow-green reset */
        .btn-submit-custom {
            background: #1aab1f;
            border: none;
            color: #fff;
            font-weight: bold;
            padding: 10px 40px;
            border-radius: 50px;
            transition: 0.3s;
        }
        .btn-submit-custom:hover {
            background: #3d8b40;
            transform: translateY(-2px);
        }
        .btn-reset-custom {
            background: #c41818;
            border: 1.5px solid #b9c46d;
            color: #fff;
            font-weight: bold;
            padding: 10px 40px;
            border-radius: 50px;
            transition: 0.3s;
        }
        .btn-reset-custom:hover {
            background: #cb342c;
            transform: translateY(-2px);
        }
        .page-title {
            color: #000000;
            background: #e4eeb9;
            border-radius: 20px;
            padding: 10px;
            font-weight: 800;
            font-size: 1.6rem;
            text-align: center;
            margin-bottom: 15px;
            font-family: verdana, Arial, sans-serif;
        }

        /* Footer colour - pale yellow-green (#e4eeb9) */
        .lower-footer {
            background-color: #e4eeb9 !important;
            color: #000000 !important;
        }
    </style>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/iti-portal.css">
</head>
<body>
    <!-- Header Content -->
    <jsp:include page="/WEB-INF/bannernew.jsp" />
    <jsp:include page="/WEB-INF/navbars/iti_navbar.jsp" />

    <div class="container form-container">
        <div class="outer-border shadow-lg">
            <h2 class="page-title">Generate Merit List</h2>
            
            <div class="inner-box mt-2">
                
                <!-- Category Dropdown -->
                <div class="row mb-3 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">Category:</label>
                    </div>
                    <div class="col-md-7">
                        <select id="categorySelect" class="form-select custom-select-box">
                            <option value="all">All</option>
                            <!-- Caste codes will be loaded here -->
                        </select>
                    </div>
                </div>

                <!-- Qualification Dropdown -->
                <div class="row mb-3 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">Qualification:</label>
                    </div>
                    <div class="col-md-7">
                        <select id="qualificationSelect" class="form-select custom-select-box">
                            <option value="all">All</option>
                            <option value="SSC">SSC</option>
                            <option value="8th">8th</option>
                        </select>
                    </div>
                </div>

                <!-- Status Dropdown -->
                <div class="row mb-3 align-items-center">
                    <div class="col-md-5">
                        <label class="form-label-custom">Status:</label>
                    </div>
                    <div class="col-md-7">
                        <select id="statusSelect" class="form-select custom-select-box">
                            <option value="checklist">checklist</option>
                            <option value="regeneratechecklist">regeneratechecklist</option>
                            <option value="finalmeritlist">finalmeritlist</option>
                        </select>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="row mt-4">
                    <div class="col-12 d-flex justify-content-center gap-3">
                        <button type="button" class="btn btn-submit-custom" onclick="submitMeritList()">SUBMIT</button>
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
    <%-- Backend API base URL from application.properties (backend.api.base-url)
         via GlobalControllerAdvice#backendBaseUrl. Dynamic <jsp:include> is a
         separate translation unit, so its EL (${backendBaseUrl}) resolves here
         even though this page uses isELIgnored="true". A static <%@ include %>
         would inherit that flag and print the literal token. --%>
    <jsp:include page="/WEB-INF/jsp/_api_base_url.jsp"/>
    <script>
        const NODE_API_BASE = window.API_BASE_URL;

        document.addEventListener('DOMContentLoaded', async () => {
            // Load Caste/Category List
            try {
                const response = await fetch(NODE_API_BASE + '/api/dsc/caste-list',{ credentials: 'include' });
                const result = await response.json();
                
                if (result.success && result.data) {
                    const categorySelect = document.getElementById('categorySelect');
                    result.data.forEach(item => {
                        const opt = document.createElement('option');
                        opt.value = item.casteCode;
                        opt.textContent = item.casteName;
                        categorySelect.appendChild(opt);
                    });
                }
            } catch (err) {
                console.error("Failed to load caste list:", err);
            }
        });

        function resetForm() {
            document.getElementById('categorySelect').value = 'all';
            document.getElementById('qualificationSelect').value = 'all';
            document.getElementById('statusSelect').value = 'checklist';
        }

        async function submitMeritList() {
            const payload = {
                category: document.getElementById('categorySelect').value,
                qual: document.getElementById('qualificationSelect').value,
                status: document.getElementById('statusSelect').value
            };

            console.log("Submitting Merit List Request:", payload);
            
            try {
                // Pointing to existing merit generation endpoint
                const response = await fetch(NODE_API_BASE + '/api/meritlist/generate', { credentials: 'include',
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload),
                    credentials: 'include'
                });
                const result = await response.json();
                if (result.success) {
                    // Store data and redirect to results page
                    sessionStorage.setItem('meritData', JSON.stringify(result));
                    window.location.href = "<%= request.getContextPath() %>/MeritResults";
                } else {
                    console.error("Merit Generation Failed:", result);
                    alert("Failed: " + (result.error || result.message || "Unknown error"));
                }
            } catch (err) {
                console.error("Submission error:", err);
                alert("An error occurred during submission.");
            }
        }
    </script>
</body>
</html>
