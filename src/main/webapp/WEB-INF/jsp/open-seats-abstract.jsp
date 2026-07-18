<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <title>Seats Open Information</title>
    <style>
        body {
            background-color: #f8fafc;
        }
        .page-title {
            color: #555;
            font-size: 28px;
            font-weight: 500;
        }
        .file-card {
            background-color: white;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .file-title {
            font-size: 22px;
            color: #4a5568;
            font-weight: 500;
            margin-bottom: 5px;
        }
        .file-meta {
            font-size: 13px;
            color: #718096;
            display: flex;
            align-items: center;
        }
        .file-badge {
            background-color: #f3e8ff;
            color: #d6bcfa;
            font-size: 11px;
            font-weight: bold;
            padding: 3px 8px;
            border-radius: 12px;
            margin-right: 8px;
        }
        .search-container {
            background-color: #f7fafc;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 15px;
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
        }
        .btn-green {
            background-color: #38a169;
            color: white;
            border: none;
            padding: 8px 24px;
        }
        .btn-green:hover {
            background-color: #2f855a;
            color: white;
        }
        .btn-grey {
            background-color: #718096;
            color: white;
            border: none;
            padding: 8px 24px;
        }
        .btn-grey:hover {
            background-color: #4a5568;
            color: white;
        }
        .table-card {
            background-color: white;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 0;
            overflow: hidden;
            margin-bottom: 40px;
        }
        .table {
            margin-bottom: 0;
            border-collapse: collapse;
        }
        .table th {
            background-color: white;
            color: #4a5568;
            font-weight: 600;
            font-size: 13px;
            border-bottom: 1px solid #e2e8f0;
            padding: 15px;
        }
        .table td {
            font-size: 13px;
            color: #4a5568;
            vertical-align: middle;
            border-bottom: 1px solid #e2e8f0;
            padding: 15px;
        }
        .row-count-text {
            color: #718096;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
    <!-- Global Header -->
    <header>
        <%@ include file="header.jsp" %>
    </header>

    <div class="container-fluid px-5 mt-4">
        <h2 class="page-title mb-4">Seats Open Information</h2>

        <div class="file-card">
            <div class="file-title">Vacant Seats 17102025.xlsx</div>
            <div class="file-meta">
                <span class="file-badge">XLSX</span>
                <span>· 72.5 KB · Uploaded Nov 06, 2025</span>
            </div>
        </div>

        <div class="search-container">
            <div style="flex-grow: 1;">
                <input type="text" id="searchInput" class="form-control" placeholder="Search for ITI details, district, trade...">
            </div>
            <button class="btn btn-green" id="searchBtn">Search</button>
            <button class="btn btn-grey" id="clearBtn">Clear</button>
        </div>

        <div class="row-count-text">
            Showing <strong id="rowCount" style="color: #4a5568;">0</strong> rows
        </div>

        <!-- Summary Cards Section -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="summary-card" style="background-color: #ebf8ff; border: 1px solid #bee3f8; border-radius: 8px; padding: 20px; text-align: center;">
                    <div style="color: #2b6cb0; font-size: 14px; font-weight: 600; text-transform: uppercase; margin-bottom: 5px;">Total Seats Opened</div>
                    <div id="totalSeatsOpenedCount" style="color: #2c5282; font-size: 32px; font-weight: 800;">0</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-card" style="background-color: #f0fff4; border: 1px solid #c6f6d5; border-radius: 8px; padding: 20px; text-align: center;">
                    <div style="color: #2f855a; font-size: 14px; font-weight: 600; text-transform: uppercase; margin-bottom: 5px;">Total Reported</div>
                    <div id="totalReportedCount" style="color: #276749; font-size: 32px; font-weight: 800;">0</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-card" style="background-color: #fff5f5; border: 1px solid #fed7d7; border-radius: 8px; padding: 20px; text-align: center;">
                    <div style="color: #c53030; font-size: 14px; font-weight: 600; text-transform: uppercase; margin-bottom: 5px;">Total Vacant</div>
                    <div id="totalVacantCount" style="color: #9b2c2c; font-size: 32px; font-weight: 800;">0</div>
                </div>
            </div>
        </div>

        <div class="table-card">
            <div class="table-responsive">
                <table class="table table-borderless">
                    <thead>
                        <tr>
                            <th>Sl. No.</th>
                            <th>ITI Type</th>
                            <th>District</th>
                            <th>ITI Code</th>
                            <th>NCVT Code</th>
                            <th>ITI Name</th>
                            <th>Trade Code</th>
                            <th>Trade</th>
                            <th class="text-center">Total Seats Opened</th>
                            <th class="text-center">Total Reported</th>
                            <th class="text-center">Total Vacant</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <tr>
                            <td colspan="11" class="text-center">Loading data...</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Global Footer -->
    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let allData = [];
            const tableBody = document.getElementById("tableBody");
            const searchInput = document.getElementById("searchInput");
            const searchBtn = document.getElementById("searchBtn");
            const clearBtn = document.getElementById("clearBtn");
            const rowCount = document.getElementById("rowCount");

            // Fetch Data from API
            fetch("${pageContext.request.contextPath}/api/seats-open", {
                method: "POST",
                headers: { "Content-Type": "application/json" }
            })
                .then(response => response.json())
                .then(data => {
                    allData = data;
                    renderTable(allData);
                })
                .catch(error => {
                    console.error("Error fetching data: ", error);
                    tableBody.innerHTML = "<tr><td colspan='11' class='text-center text-danger'>Failed to load data.</td></tr>";
                });

            // Render Table
            function renderTable(dataToRender) {
                tableBody.innerHTML = "";
                let totalSeatsOpened = 0;
                let totalReported = 0;
                let totalVacant = 0;

                if (dataToRender.length === 0) {
                    tableBody.innerHTML = "<tr><td colspan='11' class='text-center text-muted py-4'>No matching records found</td></tr>";
                    rowCount.textContent = "0";
                    document.getElementById("totalSeatsOpenedCount").textContent = "0";
                    document.getElementById("totalReportedCount").textContent = "0";
                    document.getElementById("totalVacantCount").textContent = "0";
                    return;
                }

                dataToRender.forEach((item, index) => {
                    const tr = document.createElement("tr");
                    const seatsOpened = parseInt(item.totalSeatsOpened) || 0;
                    const reported = parseInt(item.totalReported) || 0;
                    const vacant = parseInt(item.totalVacant) || 0;

                    totalSeatsOpened += seatsOpened;
                    totalReported += reported;
                    totalVacant += vacant;

                    tr.innerHTML = `
                        <td><strong style="color: #4a5568;">\${index + 1}</strong></td>
                        <td>\${item.itiType || ''}</td>
                        <td>\${item.district || ''}</td>
                        <td style="color: #2563eb; font-weight: bold;">\${item.itiCode || ''}</td>
                        <td style="color: #059669; font-weight: bold;">\${item.ncvtCode || ''}</td>
                        <td style="font-weight: 600;">\${item.itiName || ''}</td>
                        <td>\${item.tradeCode || ''}</td>
                        <td style="max-width: 200px; word-wrap: break-word;">\${item.trade || ''}</td>
                        <td class="text-center" style="font-weight: bold; color: #2c5282;">\${seatsOpened}</td>
                        <td class="text-center" style="font-weight: bold; color: #276749;">\${reported}</td>
                        <td class="text-center" style="font-weight: bold; color: #9b2c2c;">\${vacant}</td>
                    `;
                    tableBody.appendChild(tr);
                });
                
                rowCount.textContent = dataToRender.length;
                document.getElementById("totalSeatsOpenedCount").textContent = totalSeatsOpened.toLocaleString();
                document.getElementById("totalReportedCount").textContent = totalReported.toLocaleString();
                document.getElementById("totalVacantCount").textContent = totalVacant.toLocaleString();
            }

            // Filter logic
            function applyFilter() {
                const term = searchInput.value.toLowerCase();
                const filtered = allData.filter(item => 
                    (item.district && item.district.toLowerCase().includes(term)) ||
                    (item.itiName && item.itiName.toLowerCase().includes(term)) ||
                    (item.itiCode && item.itiCode.toLowerCase().includes(term)) ||
                    (item.trade && item.trade.toLowerCase().includes(term)) ||
                    (item.tradeCode && item.tradeCode.toLowerCase().includes(term)) ||
                    (item.itiType && item.itiType.toLowerCase().includes(term))
                );
                renderTable(filtered);
            }

            // Event Listeners
            searchBtn.addEventListener("click", applyFilter);
            
            clearBtn.addEventListener("click", function() {
                searchInput.value = "";
                renderTable(allData);
            });
            
            searchInput.addEventListener("keyup", function(e) {
                if (e.key === "Enter") {
                    applyFilter();
                }
            });
        });
    </script>
</body>

</html>
