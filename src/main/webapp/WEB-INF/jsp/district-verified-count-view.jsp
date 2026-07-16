<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verified Application Count | District Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .nodal-report-card { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1); }
        .nodal-card-header-dashboard { background: linear-gradient(135deg, #003366 0%, #1a4a72 100%); color: white; padding: 22px 30px; font-weight: 700; display: flex; align-items: center; gap: 15px; }
        .nodal-card-header-dashboard i { width: 38px; height: 38px; background: rgba(255, 255, 255, 0.2); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 1rem; }
        .form-control-official, .form-select-official { border: 1px solid #ced4da; border-radius: 6px; padding: 10px 15px; font-size: 1.05rem; color: #2d3748; background-color: #ffffff; transition: border-color 0.2s ease; width: 100%; }
        .form-control-official:focus, .form-select-official:focus { border-color: #003366; outline: none; box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1); }
        .form-label-official { font-size: 0.85rem; font-weight: 700; color: #445566; text-transform: uppercase; letter-spacing: 0.8px; display: block; }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 13px; padding: 15px 10px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 14px; padding: 12px 10px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
    </style>
</head>
<body class="nodal-body">
    
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="verified_count" />
    <%@ include file="district_navbar.jsp" %>
    
    <div class="nodal-page-title-dashboard">
        <h2>Verified Application Count Report</h2>
    </div>

    <!-- SELECTION VIEW -->
    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 550px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;">
                <i class="fas fa-filter me-2"></i> Selection Criteria
            </div>
            <div class="p-5 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event)">
                    <div class="row mb-3 justify-content-center">
                        <div class="col-md-10">
                            <label class="form-label-official">Admission Year *</label>
                            <select id="year" class="form-select-official" required>
                                <option value="2021">2021</option>
                                <option value="2022">2022</option>
                                <option value="2023">2023</option>
                                <option value="2024">2024</option>
                                <option value="2025" selected>2025</option>
                            </select>
                        </div>
                    </div>

                    <div class="mt-5 text-center">
                        <button type="submit" class="btn-submit-official-navy w-100">
                            <i class="fas fa-search me-2"></i>VIEW REPORT
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Loading application counts...</p>
    </div>

    <!-- REPORT VIEW -->
    <div class="container px-4 py-4" id="reportView" style="display: none;">
        
        <div class="text-center mb-4" style="color: #003366;">
            <h2 class="fw-bold fs-4 mb-2" id="reportTitle">Verified Application Count</h2>
            <p class="text-muted" style="font-size: 1.1rem;" id="reportDistInfo">District Code: </p>
        </div>

        <div class="no-print d-flex justify-content-center gap-3 mb-4">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()">
                <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
            </button>
            <button class="btn btn-dark shadow-sm px-4 rounded-pill fw-bold" onclick="exportTableToExcel('verifiedTable', 'Verified_Application_Count')">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>

        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div class="table-responsive" style="max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="verifiedTable">
                    <thead>
                        <tr>
                            <th style="width: 60px;">SNO</th>
                            <th>District Name</th>
                            <th>Total Applications</th>
                            <th>Approved</th>
                            <th>Rejected</th>
                            <th>Unverified</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function showSelection() {
            document.getElementById('reportView').style.display = 'none';
            document.getElementById('selectionView').style.display = 'block';
        }

        function fetchReport(event) {
            if(event) event.preventDefault();

            const year = document.getElementById('year').value;

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';
            document.getElementById('reportView').style.display = 'none';

            fetch('${backendApiUrl}/verified-application-count', { credentials: 'include',
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include',
                body: JSON.stringify({ year: year })
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                
                if(data.error) {
                    alert("Error: " + data.error);
                    return;
                }

                document.getElementById('reportView').style.display = 'block';
                
                document.getElementById('reportTitle').innerText = 'Verified Application Count ' + (data.year ? ' - Year ' + data.year : '');
                document.getElementById('reportDistInfo').innerText = 'District Code: ' + (data.dist_code || 'N/A');
                
                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = '';

                let gTotal = 0, gApproved = 0, gRejected = 0, gUnverified = 0;

                if (data.data && data.data.length > 0) {
                    data.data.forEach((rowObj, index) => {
                        const totalApp = parseInt(rowObj['Total Applications']) || 0;
                        const approved = parseInt(rowObj['Approved']) || 0;
                        const rejected = parseInt(rowObj['Rejected']) || 0;
                        const unverified = parseInt(rowObj['Unverified']) || 0;

                        gTotal += totalApp;
                        gApproved += approved;
                        gRejected += rejected;
                        gUnverified += unverified;

                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td style="font-weight: 600; color: #64748b;">\${index + 1}</td>
                            <td style="text-align: left; padding-left: 20px; font-weight: 600;">\${rowObj['District Name'] || ''}</td>
                            <td class="fw-bold">\${totalApp}</td>
                            <td style="color: #10b981; font-weight: bold;">\${approved}</td>
                            <td style="color: #ef4444; font-weight: bold;">\${rejected}</td>
                            <td style="color: #f59e0b; font-weight: bold;">\${unverified}</td>
                        `;
                        tbody.appendChild(row);
                    });

                    // Add a totals row
                    const tRow = document.createElement('tr');
                    tRow.style.backgroundColor = '#e2e8f0';
                    tRow.style.fontWeight = '800';
                    tRow.innerHTML = `
                        <td></td>
                        <td style="text-align: right; padding-right: 20px;">TOTAL</td>
                        <td>\${gTotal}</td>
                        <td style="color: #10b981;">\${gApproved}</td>
                        <td style="color: #ef4444;">\${gRejected}</td>
                        <td style="color: #f59e0b;">\${gUnverified}</td>
                    `;
                    tbody.appendChild(tRow);

                } else {
                    tbody.innerHTML = '<tr><td colspan="6" style="text-align:center; padding:20px; font-weight: bold;">No data found.</td></tr>';
                }
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }

        function exportTableToExcel(tableID, filename = ''){
            var tableSelect = document.getElementById(tableID);
            var html = tableSelect.outerHTML;
            var blob = new Blob(['\ufeff', html], { type: "application/vnd.ms-excel" });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = (filename || 'Report') + '.xls';
            a.click();
            URL.revokeObjectURL(url);
        }
    </script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
