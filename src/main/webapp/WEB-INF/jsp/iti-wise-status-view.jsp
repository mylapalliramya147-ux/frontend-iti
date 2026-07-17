<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI-Wise Admission Status Report</title>
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
        .total-row td {
            background: #0f2c4e !important;
            color: white !important;
            font-weight: bold;
        }
        .loader-spinner {
            display: none;
            text-align: center;
            padding: 40px;
            color: #003366;
        }
        .num { text-align: center; font-weight: 700 !important; }
    </style>
</head>
<body class="nodal-body">
    
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" />
    
    <c:set var="activeTab" value="iti_status" />
    <%@ include file="iti_navbar.jsp" />
    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Industrial Training Institute — ITI-Wise Status Report</h2>
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
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5">
                            <label for="year" class="form-label-official mb-md-0">Admission Year *</label>
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
        <p class="mt-3 fw-bold">Processing status data from database...</p>
    </div>

    <!-- REPORT VIEW -->
    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        
        <div class="text-center mb-3" style="color: #003366;">
            <h2 class="fw-bold fs-4 mb-2" id="reportTitle">ITI-Wise Admission Status Report</h2>
        </div>

        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()">
                <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
            </button>
            <button class="btn btn-dark shadow-sm px-4 rounded-pill fw-bold" onclick="exportTableToExcel('statusTable', 'ITI_Wise_Status_Report')">
                <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>

        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="statusTable" style="min-width: 1200px;">
                    <thead>
                        <tr>
                            <th>DISTRICT NAME</th>
                            <th>ITI NAME</th>
                            <th>ITI CODE</th>
                            <th class="num">TOTAL</th>
                            <th class="num">SUCCESS</th>
                            <th class="num">PENDING (SID)</th>
                            <th class="num">VERIFIED</th>
                            <th class="num">TO BE VERIFIED</th>
                            <th class="num">TO BE UPDATED</th>
                            <th class="num">PHONE DUPLICATES</th>
                            <th class="num">EMAIL DUPLICATES</th>
                            <th class="num">AADHAR DUPLICATES</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- Data will be injected here -->
                    </tbody>
                    <tfoot id="tableFoot">
                        <!-- Totals row will be injected here -->
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', async () => {
            // Simplified: only year selection
        });

        function showSelection() {
            document.getElementById('reportView').style.display = 'none';
            document.getElementById('selectionView').style.display = 'block';
        }

        function fetchReport(event) {
            event.preventDefault();
            const year = document.getElementById('year').value;

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            fetch('${backendApiUrl}/iti-wise-status?year=' + encodeURIComponent(year) + '&distCode=All&itiCode=All', {
                method: 'GET', headers: { 'Content-Type': 'application/json' }
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                
                document.getElementById('reportTitle').innerText = 'ITI-Wise Admission Status Report (' + year + ')';
                
                const tbody = document.getElementById('tableBody');
                const tfoot = document.getElementById('tableFoot');
                tbody.innerHTML = '';
                tfoot.innerHTML = '';

                if (data.error) throw new Error(data.error);

                let totals = { total: 0, success: 0, pending_sid: 0, verified: 0, to_be_verified: 0, to_be_updated: 0, phone_duplicate_records: 0, aadhar_duplicate_records: 0, email_duplicate_records: 0 };
                if (data.data && data.data.length > 0) {
                    data.data.forEach(row => {
                        const tr = document.createElement('tr');
                        tr.innerHTML = `
                            <td style="text-align: left;">${row.distName || '-'}</td>
                            <td style="text-align: left;">${row.itiName || '-'}</td>
                            <td>${row.itiCode || '-'}</td>
                            <td class="num" style="color: #003366;">${row.total || 0}</td>
                            <td class="num text-success">${row.success || 0}</td>
                            <td class="num text-warning">${row.pendingSid || 0}</td>
                            <td class="num text-primary">${row.verified || 0}</td>
                            <td class="num text-danger">${row.toBeVerified || 0}</td>
                            <td class="num">${row.toBeUpdated || 0}</td>
                            <td class="num text-danger">${row.phoneDuplicateRecords || 0}</td>
                            <td class="num text-danger">${row.emailDuplicateRecords || 0}</td>
                            <td class="num text-danger">${row.aadharDuplicateRecords || 0}</td>
                        `;
                        tbody.appendChild(tr);
                        totals.total += row.total || 0; totals.success += row.success || 0; totals.pending_sid += row.pendingSid || 0; totals.verified += row.verified || 0; totals.to_be_verified += row.toBeVerified || 0; totals.to_be_updated += row.toBeUpdated || 0; totals.phone_duplicate_records += row.phoneDuplicateRecords || 0; totals.aadhar_duplicate_records += row.aadharDuplicateRecords || 0; totals.email_duplicate_records += row.emailDuplicateRecords || 0;
                    });

                    const ft = document.createElement('tr');
                    ft.className = 'total-row';
                    ft.innerHTML = `
                        <td colspan="3" style="text-align: right; padding-right: 30px;">GRAND TOTAL</td>
                        <td class="num">${totals.total}</td>
                        <td class="num">${totals.success}</td>
                        <td class="num">${totals.pending_sid}</td>
                        <td class="num">${totals.verified}</td>
                        <td class="num">${totals.to_be_verified}</td>
                        <td class="num">${totals.to_be_updated}</td>
                        <td class="num">${totals.phone_duplicate_records}</td>
                        <td class="num">${totals.email_duplicate_records}</td>
                        <td class="num">${totals.aadhar_duplicate_records}</td>
                    `;
                    tfoot.appendChild(ft);
                } else {
                    tbody.innerHTML = '<tr><td colspan="12" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
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
</body>
</html>