<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open Seats Abstract | ITI Admissions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=12">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .nodal-dashboard-navbar {
            background: #002244;
            padding: 0;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 2.5rem;
        }
        .nodal-dashboard-link {
            padding: 18px 25px;
            color: rgba(255, 255, 255, 0.7) !important;
            text-decoration: none;
            font-size: 0.72rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.25s ease;
            border-bottom: 4px solid transparent;
        }
        .nodal-dashboard-link:hover {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.05);
        }
        .nodal-dashboard-link.active {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.1);
            border-bottom-color: #ffd700;
        }
        .nodal-page-title-dashboard {
            text-align: center;
            padding: 30px 0;
            color: #003366;
            font-weight: 800;
            background: #f8fbff;
            border-bottom: 1px solid #e1ecf8;
            margin-bottom: 40px;
        }
        .nodal-page-title-dashboard h2 {
            margin: 0;
            font-size: 1.6rem;
            letter-spacing: 0.5px;
        }
        .nodal-report-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1);
        }
        .nodal-card-header-dashboard {
            background: linear-gradient(135deg, #003366 0%, #1a4a72 100%);
            color: white;
            padding: 22px 30px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .nodal-card-header-dashboard i {
            width: 38px;
            height: 38px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }
        .selection-form {
            max-width: 500px;
            margin: 0 auto 30px;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        .selection-form label {
            font-weight: 700;
            color: #003366;
            margin-bottom: 8px;
        }
        .nodal-download-btn-black {
            background: #000;
            color: #fff;
            border: none;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .nodal-download-btn-black:hover {
            background: #222;
            color: #fff;
        }
    </style>
</head>
<body class="nodal-body">
    <%@ include file="header.jsp" %>
    
    <c:set var="activeTab" value="open_seats" />
    <%@ include file="nodal_navbar.jsp" %>

    <div class="nodal-page-title-dashboard">
        <h2>Open Seats Abstract — District Wise Summary</h2>
    </div>

    <div class="container mt-4 mb-5">
        <div class="no-print d-flex justify-content-center mb-4" id="downloadSection" style="display:none;">
            <button class="nodal-download-btn-black shadow-sm" style="padding: 12px 35px !important; font-size: 0.85rem !important;" onclick="exportTableToExcel('resultsTable', 'District_Wise_Open_Seats')">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
        </div>

        <div class="selection-form" id="selectionView">
            <form onsubmit="fetchReport(event)">
                <div class="mb-3">
                    <label for="year" class="form-label">SELECT YEAR</label>
                    <select class="form-select" id="year" required>
                        <option value="">-- Select Year --</option>
                        <option value="2024">2024</option>
                        <option value="2023">2023</option>
                    </select>
                </div>
                <div class="d-grid">
                    <button type="submit" class="nodal-btn-primary" style="padding: 12px; font-weight: 800;">
                        <i class="fas fa-search me-2"></i> VIEW REPORT
                    </button>
                </div>
            </form>
        </div>

        <div class="nodal-report-card shadow-lg" style="max-width: 1000px; margin: 0 auto; display:none;" id="reportView">
            <div class="nodal-card-header-dashboard">
                <i class="fas fa-chart-bar me-2"></i> OPEN SEATS ABSTRACT FOR THE YEAR: <span id="reportTitle"></span>
            </div>
            <div class="p-0">
                <table class="nodal-table mb-0" id="resultsTable">
                    <thead>
                        <tr>
                            <th style="width: 80px;">SNO</th>
                            <th style="text-align: center;">DISTRICT NAME</th>
                            <th style="width: 180px;">NO.OF SEATS</th>
                            <th style="width: 180px;">FILL</th>
                            <th style="width: 180px;">VACANT</th>
                        </tr>
                    </thead>
                    <tbody style="font-size: 1.05rem;" id="tableBody"></tbody>
                    <tfoot id="tableFoot"></tfoot>
                </table>
            </div>
        </div>

        <div class="loader-spinner" id="loader" style="display:none;">
            <i class="fas fa-spinner fa-spin fa-3x"></i>
            <p class="mt-3 fw-bold">Loading Open Seats Abstract...</p>
        </div>

        <div class="row no-print" style="margin-top: 50px; text-align: center;">
            <div class="d-flex justify-content-center">
                <button class="nodal-btn-primary" style="width: auto; padding: 12px 50px; border-radius: 8px;" 
                        onclick="showSelection()">
                    <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
                </button>
            </div>
        </div>
    </div>

    <script>
        function showSelection() {
            document.getElementById('reportView').style.display = 'none';
            document.getElementById('selectionView').style.display = 'block';
            document.getElementById('downloadSection').style.display = 'none';
        }

        function fetchReport(event) {
            event.preventDefault();
            const year = document.getElementById('year').value;

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            fetch('${backendApiUrl}/open-seats?year=' + encodeURIComponent(year), {
                method: 'GET', headers: { 'Content-Type': 'application/json' }
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';

                if(data.error) throw new Error(data.error);

                document.getElementById('reportView').style.display = 'block';
                document.getElementById('downloadSection').style.display = 'block';
                document.getElementById('reportTitle').innerText = year;

                const tbody = document.getElementById('tableBody');
                const tfoot = document.getElementById('tableFoot');
                tbody.innerHTML = '';
                tfoot.innerHTML = '';

                if (data.data && data.data.length > 0) {
                    let totalSeats = 0, totalFill = 0, totalVacant = 0;
                    data.data.forEach((row, index) => {
                        const tr = document.createElement('tr');
                        tr.innerHTML = `
                            <td class="text-secondary" style="font-weight: 600;">\${index + 1}</td>
                            <td class="text-start" style="padding-left: 35px;">
                                <a href="${pageContext.request.contextPath}/nodal-report/reports/open-seats-college?year=\${year}&dist_code=\${row.distCode}" 
                                   class="text-decoration-none" style="color: #003366; font-weight: 800; font-size: 1.05rem;">
                                    \${row.distName}
                                </a>
                            </td>
                            <td style="font-weight: 800; color: #1e293b;">\${row.noOfSeats || 0}</td>
                            <td style="font-weight: 800; color: #1a4a72;">\${row.fill || 0}</td>
                            <td style="font-weight: 800;" class="\${row.vacant < 0 ? 'text-danger' : 'text-success'}">\${row.vacant || 0}</td>
                        `;
                        tbody.appendChild(tr);
                        totalSeats += row.noOfSeats || 0;
                        totalFill += row.fill || 0;
                        totalVacant += row.vacant || 0;
                    });

                    const ft = document.createElement('tr');
                    ft.className = 'nodal-total-row';
                    ft.innerHTML = `
                        <td colspan="2" style="text-align: center; padding: 15px; font-weight: 900;">GRAND TOTAL</td>
                        <td style="font-weight: 900; color: #1e293b;">\${totalSeats}</td>
                        <td style="font-weight: 900; color: #1a4a72;">\${totalFill}</td>
                        <td style="font-weight: 900; color: #059669;">\${totalVacant}</td>
                    `;
                    tfoot.appendChild(ft);
                } else {
                    tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                }
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('selectionView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }

        function exportTableToExcel(tableID, filename = '') {
            var tableSelect = document.getElementById(tableID);
            var html = tableSelect.outerHTML;
            var blob = new Blob(['\ufeff', html], {
                type: "application/vnd.ms-excel"
            });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = filename ? filename + '.xls' : 'excel_data.xls';
            a.click();
            URL.revokeObjectURL(url);
        }
    </script>
</body>
</html>
