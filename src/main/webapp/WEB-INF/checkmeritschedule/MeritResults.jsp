<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Merit List Results - AP ITI</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Essential layout adjustments */
        .results-container {
            width: 98%;
            max-width: 1600px;
            margin: 30px auto;
        }
        .outer-border {
            border: 3px solid #004a99 !important;
            padding: 15px;
            border-radius: 12px;
            background: #fff;
        }
        .inner-box {
            background-color: #ffffff;
            border: 1px solid #dee2e6 !important;
            padding: 20px;
            border-radius: 8px;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="/WEB-INF/reports/bannernew.jsp" />
    <jsp:include page="/WEB-INF/checkmeritschedule/authNavbar.jsp" />

    <div class="results-container">
        <div class="outer-border shadow-lg">
            <h2 id="resultHeading" class="page-title">Merit List Results</h2>
            
            <div class="inner-box shadow-sm">
                <!-- Search and Pagination Controls -->
                <div class="search-container">
                    <div class="search-box flex-grow-1">
                        <i class="fas fa-search"></i>
                        <input type="text" id="regidSearch" class="form-control search-input" placeholder="Search by Registration ID or Name..." onkeyup="filterTable()">
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div class="rows-select d-flex align-items-center gap-2">
                            <label class="mb-0 fw-bold text-primary">Show:</label>
                            <select id="rowLimit" class="form-select" onchange="updateRowDisplay()">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="all">All</option>
                            </select>
                        </div>
                        <button class="btn btn-primary btn-print-custom shadow-sm" onclick="window.print()">
                            <i class="fas fa-print"></i> Print Report
                        </button>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-custom mb-0" id="meritTable">
                        <thead class="table-dark">
                            <tr>
                                <th style="width: 60px;">S.No</th>
                                <th style="width: 80px;">Rank</th>
                                <th style="width: 150px;">Reg. ID</th>
                                <th>Candidate Name</th>
                                <th>Father Name</th>
                                <th>Mother Name</th>
                                <th style="width: 90px;">Gender</th>
                                <th style="width: 90px;">Caste</th>
                                <th style="width: 120px;">DOB</th>
                                <th style="width: 100px;">SSC Status</th>
                                <th style="width: 70px;">PH</th>
                                <th style="width: 100px;">Ex-Service</th>
                            </tr>
                        </thead>
                        <tbody id="meritBody">
                            <!-- Populated by JS -->
                        </tbody>
                    </table>
                </div>
                <div id="noDataMsg" class="no-data py-5 text-center text-muted" style="display:none;">
                    <i class="fas fa-search-minus fa-3x mb-3 opacity-25"></i>
                    <p class="fs-5">No results match your search keywords.</p>
                </div>
            </div>

            <!-- Back Button -->
            <div class="text-center mt-4 print-hide">
                <a href="<%= request.getContextPath() %>/MeritList" class="btn btn-secondary px-5 rounded-pill shadow-sm fw-bold">
                    <i class="fas fa-arrow-left me-2"></i> Return to List Portal
                </a>
            </div>
        </div>
    </div>

    <footer class="print-hide">
        <jsp:include page="/WEB-INF/reports/footer.jsp" />
    </footer>

    <script>
        let allData = [];

        document.addEventListener('DOMContentLoaded', () => {
            const storedData = sessionStorage.getItem('meritData');
            if (storedData) {
                const result = JSON.parse(storedData);
                if (result.success && result.data) {
                    allData = result.data;
                    document.getElementById('resultHeading').textContent = (result.heading || "Merit List").toUpperCase() + " GENERATED";
                    renderTable(allData);
                }
            } else {
                document.getElementById('meritBody').innerHTML = '<tr><td colspan="12" class="text-center text-danger py-5 fw-bold"><i class="fas fa-exclamation-circle me-2"></i> No session data found. Redirecting...</td></tr>';
                setTimeout(() => window.location.href = "<%= request.getContextPath() %>/MeritList", 2000);
            }
        });

        function renderTable(data, limit = 10) {
            const body = document.getElementById('meritBody');
            body.innerHTML = '';
            
            const displayData = limit === 'all' ? data : data.slice(0, parseInt(limit));
            
            if (displayData.length === 0) {
                document.getElementById('noDataMsg').style.display = 'block';
                return;
            }
            document.getElementById('noDataMsg').style.display = 'none';

            displayData.forEach((row, index) => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td class="text-center fw-bold text-muted">${index + 1}</td>
                    <td class="text-center"><span class="rank-badge">${row.rank || row.generated_rank || 'N/A'}</span></td>
                    <td class="text-center fw-bold text-primary">${row.regid || 'N/A'}</td>
                    <td class="fw-bold">${row.name || 'N/A'}</td>
                    <td>${row.fname || 'N/A'}</td>
                    <td>${row.mname || 'N/A'}</td>
                    <td class="text-center text-uppercase">${row.gender || 'N/A'}</td>
                    <td class="text-center">${row.caste || 'N/A'}</td>
                    <td class="text-center">${row.dob || 'N/A'}</td>
                    <td class="text-center">
                        <span class="badge ${row.ssc_passed === 'Pass' ? 'bg-success' : 'bg-danger'}">${row.ssc_passed || 'N/A'}</span>
                    </td>
                    <td class="text-center">${row.phc || row.ph || 'No'}</td>
                    <td class="text-center">${row.exservice || 'No'}</td>
                `;
                body.appendChild(tr);
            });
        }

        function updateRowDisplay() {
            filterTable();
        }

        function filterTable() {
            const term = document.getElementById('regidSearch').value.toLowerCase();
            const limit = document.getElementById('rowLimit').value;
            const filtered = allData.filter(row => 
                String(row.regid).toLowerCase().includes(term) || 
                String(row.name).toLowerCase().includes(term) ||
                String(row.fname).toLowerCase().includes(term)
            );
            renderTable(filtered, limit);
        }
    </script>
</body>
</html>
