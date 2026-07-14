<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Caste Wise Admissions | District Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .nodal-report-card { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1); }
        .nodal-card-header-dashboard { background: linear-gradient(135deg, #003366 0%, #1a4a72 100%); color: white; padding: 22px 30px; font-weight: 700; display: flex; align-items: center; gap: 15px; }
        .nodal-card-header-dashboard i { width: 38px; height: 38px; background: rgba(255, 255, 255, 0.2); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 1rem; }
        .form-label-official { font-size: 0.85rem; font-weight: 700; color: #445566; text-transform: uppercase; letter-spacing: 0.8px; display: block; }
        .form-control-official, .form-select-official { border: 1px solid #ced4da; border-radius: 6px; padding: 10px 15px; font-size: 1.05rem; color: #2d3748; background-color: #ffffff; transition: border-color 0.2s ease; width: 100%; }
        .form-control-official:focus, .form-select-official:focus { border-color: #003366; outline: none; box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1); }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 11px; padding: 12px 4px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 12px; padding: 10px 4px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .total-row { background-color: #e2e8f0; font-weight: 800 !important; color: #0f172a !important; }
    </style>
</head>
<body class="nodal-body">
    
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="caste_wise" />
    <%@ include file="district_navbar.jsp" %>
    
    <div class="nodal-page-title-dashboard">
        <h2>Caste Wise Admissions Report</h2>
    </div>

    <!-- SELECTION VIEW -->
    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 650px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;">
                <i class="fas fa-filter me-2"></i> Selection Criteria
            </div>
            <div class="p-4 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event)">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label-official">Year *</label>
                            <select name="year" id="year" class="form-select-official" required>
                                <option value="2021">2021</option>
                                <option value="2022">2022</option>
                                <option value="2023">2023</option>
                                <option value="2024">2024</option>
                                <option value="2025" selected>2025</option>
                            </select>
                        </div>
                        <div class="col-md-6 mt-3 mt-md-0">
                            <label class="form-label-official">Govt / Pvt</label>
                            <select name="govt" id="govt" class="form-select-official">
                                <option value="All">All</option>
                                <option value="G">Government</option>
                                <option value="P">Private</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label-official">Phase *</label>
                            <select name="phase" id="phase" class="form-select-official" required>
                                <option value="1">Phase 1</option>
                                <option value="2">Phase 2</option>
                                <option value="3">Phase 3</option>
                                <option value="4">Phase 4</option>
                                <option value="5">Phase 5</option>
                            </select>
                        </div>
                        <div class="col-md-6 mt-3 mt-md-0">
                            <label class="form-label-official">Gender</label>
                            <select name="gender" id="gender" class="form-select-official">
                                <option value="All">All</option>
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                            </select>
                        </div>
                    </div>

                    <div class="mt-4 text-center">
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
        <p class="mt-3 fw-bold">Generating report...</p>
    </div>

    <!-- REPORT VIEW -->
    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        
        <div class="text-center mb-4" style="color: #003366;">
            <h2 class="fw-bold fs-4 mb-2" id="reportTitle">Caste Wise Admissions</h2>
            <p class="text-muted" style="font-size: 1.1rem;" id="reportMeta"></p>
        </div>

        <div class="no-print d-flex justify-content-center gap-3 mb-4">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()">
                <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
            </button>
            <button class="btn btn-dark shadow-sm px-4 rounded-pill fw-bold" onclick="exportTableToExcel('casteWiseTable', 'Caste_Wise_Admissions')">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>

        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div class="table-responsive" style="max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="casteWiseTable">
                    <thead>
                        <tr>
                            <th style="width: 50px;">SNO</th>
                            <th>District Name</th>
                            <th>BC-A</th>
                            <th>BC-B</th>
                            <th>BC-C</th>
                            <th>BC-D</th>
                            <th>BC-E</th>
                            <th>EWS</th>
                            <th>EX-S</th>
                            <th>IM</th>
                            <th>OC</th>
                            <th>PH</th>
                            <th>SC-I</th>
                            <th>SC-II</th>
                            <th>SC-III</th>
                            <th>SP</th>
                            <th>ST</th>
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
            event.preventDefault();
            const year = document.getElementById('year').value;
            const govt = document.getElementById('govt').value;
            const phase = document.getElementById('phase').value;
            const gender = document.getElementById('gender').value;

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            let phaseNum = phase === 'All' ? 'All' : parseInt(phase);

            fetch('http://10.72.4.135:5051/reports/caste-wise-admissions', { credentials: 'include',
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include',
                body: JSON.stringify({ year: year, govt: govt, phase: phaseNum, gender: gender })
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                
                if(data.error) {
                    alert("Error: " + data.error);
                    showSelection();
                    return;
                }

                document.getElementById('reportView').style.display = 'block';
                
                document.getElementById('reportTitle').innerText = 'Caste Wise Admissions ' + (data.year ? ' - Year ' + data.year : '');
                document.getElementById('reportMeta').innerText = `Govt/Pvt: \${govt} | Phase: \${phase} | Gender: \${gender} | Dist: \${data.dist_code || ''}`;
                
                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = '';

                if (data.data && data.data.length > 0) {
                    data.data.forEach((dist, index) => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td style="font-weight: 600; color: #64748b;">\${index + 1}</td>
                            <td style="text-align: left; padding-left: 15px; font-weight: 600;">\${dist['District Name'] || ''}</td>
                            <td>\${dist['BC-A'] || 0}</td>
                            <td>\${dist['BC-B'] || 0}</td>
                            <td>\${dist['BC-C'] || 0}</td>
                            <td>\${dist['BC-D'] || 0}</td>
                            <td>\${dist['BC-E'] || 0}</td>
                            <td>\${dist['EWS'] || 0}</td>
                            <td>\${dist['EX-S'] || 0}</td>
                            <td>\${dist['IM'] || 0}</td>
                            <td>\${dist['OC'] || 0}</td>
                            <td>\${dist['PH'] || 0}</td>
                            <td>\${dist['SC-I'] || 0}</td>
                            <td>\${dist['SC-II'] || 0}</td>
                            <td>\${dist['SC-III'] || 0}</td>
                            <td>\${dist['SP'] || 0}</td>
                            <td>\${dist['ST'] || 0}</td>
                        `;
                        tbody.appendChild(row);
                    });

                    // Totals Row
                    if (data.totals) {
                        const t = data.totals;
                        const tRow = document.createElement('tr');
                        tRow.className = 'total-row';
                        tRow.innerHTML = `
                            <td></td>
                            <td style="text-align: right; padding-right: 15px;">\${t['District Name'] || 'Total'}</td>
                            <td>\${t['BC-A'] || 0}</td>
                            <td>\${t['BC-B'] || 0}</td>
                            <td>\${t['BC-C'] || 0}</td>
                            <td>\${t['BC-D'] || 0}</td>
                            <td>\${t['BC-E'] || 0}</td>
                            <td>\${t['EWS'] || 0}</td>
                            <td>\${t['EX-S'] || 0}</td>
                            <td>\${t['IM'] || 0}</td>
                            <td>\${t['OC'] || 0}</td>
                            <td>\${t['PH'] || 0}</td>
                            <td>\${t['SC-I'] || 0}</td>
                            <td>\${t['SC-II'] || 0}</td>
                            <td>\${t['SC-III'] || 0}</td>
                            <td>\${t['SP'] || 0}</td>
                            <td>\${t['ST'] || 0}</td>
                        `;
                        tbody.appendChild(tRow);
                    }
                } else {
                    tbody.innerHTML = '<tr><td colspan="17" style="text-align:center; padding:20px; font-weight: bold;">No data found.</td></tr>';
                }
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('selectionView').style.display = 'block';
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
