<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Merit List Management - AP ITI</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
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
            background: #28a745; /* Success Green */
            border: none;
            color: #fff;
            font-weight: bold;
            padding: 10px 40px;
            border-radius: 50px;
            box-shadow: 0 4px 6px rgba(40,167,69,0.2);
            transition: 0.3s;
        }
        .btn-submit-custom:hover {
            background: #218838;
            transform: translateY(-2px);
        }
        .btn-reset-custom {
            background: #dc3545; /* Danger Red */
            border: none;
            color: #fff;
            font-weight: bold;
            padding: 10px 40px;
            border-radius: 50px;
            box-shadow: 0 4px 6px rgba(220,53,69,0.2);
            transition: 0.3s;
        }
        .btn-reset-custom:hover {
            background: #c82333;
            transform: translateY(-2px);
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

    <script>
        const NODE_API_BASE = "http://" + window.location.hostname + ":8080/itiapchecklistmeritlist";

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
