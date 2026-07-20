<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applicant Report By Phase | ITI Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* DASHBOARD UI OVERRIDES */
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

        /* OFFICIAL UI CLASSES */
        .form-label-official {
            font-size: 0.85rem;
            font-weight: 700;
            color: #445566;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            display: block;
        }
        .form-select-official {
            border: 1px solid #ced4da;
            border-radius: 6px;
            padding: 10px 15px;
            font-size: 1.05rem;
            color: #2d3748;
            background-color: #ffffff;
            transition: border-color 0.2s ease;
        }
        .form-select-official:focus {
            border-color: #003366;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1);
        }
        .btn-submit-official-navy {
            background-color: #003366;
            color: white;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 700;
            letter-spacing: 0.5px;
            border: none;
            transition: all 0.2s ease;
        }
        .btn-submit-official-navy:hover {
            background-color: #002244;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2);
            color: white;
        }

        /* TABLE OVERRIDES */
        .report-table th {
            font-size: 12px;
            padding: 12px 5px;
            background: #0f2c4e !important;
            color: white !important;
            text-transform: uppercase;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .report-table td {
            font-size: 13px;
            padding: 10px 5px;
            border-bottom: 1px solid #f0f0f0;
            font-weight: 500;
            color: #1e293b;
        }
        .loader-spinner {
            display: none;
            text-align: center;
            padding: 40px;
            color: #003366;
        }
    </style>
</head>
<body class="nodal-body">
    
    <!-- Use Nodal Header and Navbar as requested -->
    <header class="fixed-top-header">
        <%@ include file="bannernew.jsp" %>
    </header>
    
    <c:set var="activeTab" value="applicant_phase" />
    <%@ include file="iti_navbar.jsp" %>
    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Industrial Training Institute — Applicant Report By Phase</h2>
    </div>

    <!-- SELECTION VIEW -->
    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 550px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;">
                <i class="fas fa-filter me-2"></i> Selection Criteria
            </div>
            <div class="p-5 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event)">
                    <!-- Admission Year -->
                    <div class="row align-items-center mb-3">
                        <div class="col-md-5">
                            <label for="year" class="form-label-official mb-md-0">Year</label>
                        </div>
                        <div class="col-md-7">
                            <select name="year" id="year" class="form-select-official w-100" required>
                                <option value="2021">2021</option>
                                <option value="2022">2022</option>
                                <option value="2023">2023</option>
                                <option value="2024">2024</option>
                                <option value="2025" selected>2025</option>
                            </select>
                        </div>
                    </div>

                    <!-- Admission Phase -->
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5">
                            <label for="phase" class="form-label-official mb-md-0">Admission Phase</label>
                        </div>
                        <div class="col-md-7">
                            <select name="phase" id="phase" class="form-select-official w-100" required>
                                <option value="">-- Select Phase --</option>
                                <option value="1">Phase 1</option>
                                <option value="2">Phase 2</option>
                                <option value="3">Phase 3</option>
                                <option value="4">Phase 4</option>
                                <option value="5">Phase 5</option>
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
        <p class="mt-3 fw-bold">Processing applicant data from database...</p>
    </div>

    <!-- REPORT VIEW -->
    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        
        <div class="text-center mb-3" style="color: #003366;">
            <h2 class="fw-bold fs-4 mb-2" id="reportTitle">Total Applicant's Report</h2>
            <p class="mb-4 text-muted" style="font-size: 1.1rem;" id="reportTotal">Total Applicants: 0</p>
        </div>

        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()">
                <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
            </button>
            <button class="btn btn-dark shadow-sm px-4 rounded-pill fw-bold" onclick="exportTableToExcel('applicantTable', 'Applicant_Report_Phase')">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>

        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="applicantTable">
                    <thead>
                        <tr>
                            <th style="width: 60px;">SNO</th>
                            <th>SSC REG NO</th>
                            <th>MOBILE NO</th>
                            <th>REG ID</th>
                            <th>NAME</th>
                            <th>FATHER NAME</th>
                            <th>MOTHER NAME</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- Data will be injected here -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>

        function showSelection() {
            document.getElementById('reportView').style.display = 'none';
            document.getElementById('selectionView').style.display = 'block';
        }

        function fetchReport(event) {
            event.preventDefault();
            const phase = document.getElementById('phase').value;
            const year = document.getElementById('year').value;

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            fetch('http://10.72.4.135:5051/reports/applicant-report-by-phase', { credentials: 'include',
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ phase: parseInt(phase), year: year })
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                
                document.getElementById('reportTitle').innerText = 'Total Applicant\'s Report - Phase ' + phase;
                document.getElementById('reportTotal').innerText = 'Total Applicants: ' + (data.total_applicants || 0);
                
                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = ''; // clear

                if (data.applicants && data.applicants.length > 0) {
                    data.applicants.forEach((applicant, index) => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td style="font-weight: 600; color: #64748b;">\${index + 1}</td>
                            <td style="font-weight: 700;">\${applicant.ssc_regno || ''}</td>
                            <td>\${applicant['Mobile No'] || ''}</td>
                            <td>\${applicant['Reg Id'] || ''}</td>
                            <td style="text-align: left; padding-left: 15px; font-weight: 600;">\${applicant['Name'] || ''}</td>
                            <td style="text-align: left; padding-left: 15px;">\${applicant['Father Name'] || ''}</td>
                            <td style="text-align: left; padding-left: 15px;">\${applicant['Mother Name'] || ''}</td>
                        `;
                        tbody.appendChild(row);
                    });
                } else {
                    tbody.innerHTML = '<tr><td colspan="7" style="text-align:center; padding:20px; font-weight: bold;">No applicants found for Phase ' + phase + '.</td></tr>';
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

        document.addEventListener('DOMContentLoaded', () => {
            const phaseSelect = document.getElementById('phase');
            if (phaseSelect && phaseSelect.value === "") {
                phaseSelect.value = "1";
            }
        });
    
</script>
</body>
</html>
