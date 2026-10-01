<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>State Dashboard | Nodal Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .num { text-align: center; font-weight: 700 !important; }
        .district-link { color: #003366; text-decoration: none; font-weight: 600; }
        .district-link:hover { color: #0057AF; text-decoration: underline; }
    </style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="state_dashboard" />
    <div class="nodal-page-title-dashboard"><h2 id="reportTitle">API Dashboard (State)</h2></div>

    <div class="container-fluid px-4 mb-3 d-flex justify-content-between align-items-center" id="downloadSection" style="display: none;">
        <div class="d-flex align-items-center gap-2">
            <label for="yearSelect" class="fw-bold text-secondary mb-0">Admission Year:</label>
            <select id="yearSelect" class="form-select form-select-sm" style="width: 120px;" onchange="changeYear(this.value)">
                <option value="2025">2025</option>
                <option value="2024">2024</option>
                <option value="2023">2023</option>
                <option value="2022">2022</option>
            </select>
        </div>
        <div class="d-flex gap-2">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold btn-sm" onclick="tableToExcel('tot', 'State Dashboard')">
                <i class="fas fa-file-excel me-2 text-success"></i>Excel Download
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill btn-sm" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>
    </div>

    <div class="loader-spinner" id="loader"><i class="fas fa-spinner fa-spin fa-3x"></i><p class="mt-3 fw-bold">Loading state dashboard...</p></div>

    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="tot" style="min-width: 1000px;">
                    <thead>
                        <tr>
                            <th>slno</th>
                            <th>District Name</th>
                            <th>Total</th>
                            <th>Success</th>
                            <th>Pending status from SID</th>
                            <th>Verified</th>
                            <th>To be Verified</th>
                            <th>To be Updated</th>
                            <th>Phone Duplicate Records</th>
                            <th>Aadhar Duplicate Records</th>
                            <th>Email Duplicate Records</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                    <tfoot id="tableFoot"></tfoot>
                </table>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        let currentYear = '';

        function tableToExcel(tableID, name = '') {
            var table = document.getElementById(tableID);
            var html = table.outerHTML;
            var blob = new Blob(['\ufeff', html], { type: "application/vnd.ms-excel" });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = (name || 'report') + '.xls';
            a.click();
            URL.revokeObjectURL(url);
        }

        function changeYear(y) {
            currentYear = y;
            loadReport(y);
        }

        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            fetch('${backendApiUrl}/current-admission-phase')
                .then(r => r.json())
                .then(config => {
                    const year = urlParams.get('year') || '${param.year}' || config.year || String(new Date().getFullYear());
                    currentYear = year;
                    const sel = document.getElementById('yearSelect');
                    if (sel) sel.value = year;
                    loadReport(year);
                })
                .catch(err => {
                    console.error('Failed to load current phase:', err);
                    const year = urlParams.get('year') || '${param.year}' || String(new Date().getFullYear());
                    currentYear = year;
                    const sel = document.getElementById('yearSelect');
                    if (sel) sel.value = year;
                    loadReport(year);
                });
        });

        function loadReport(year) {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('reportView').style.display = 'none';
            document.getElementById('reportTitle').innerText = 'API Dashboard (State) — ' + year;

            fetch('${backendApiUrl}/state-dashboard?year=' + encodeURIComponent(year) + '&govt=All', { method: 'GET' })
            .then(response => response.json())
            .then(response => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                document.getElementById('downloadSection').style.display = 'block';

                const tbody = document.getElementById('tableBody');
                const tfoot = document.getElementById('tableFoot');
                tbody.innerHTML = ''; tfoot.innerHTML = '';

                const data = response.data || [];
                if (data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="11" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                    return;
                }

                let gTotal = 0, gSuccess = 0, gPendingSid = 0, gVerified = 0, gToBeVerified = 0, gToBeUpdated = 0, gPhone = 0, gAadhar = 0, gEmail = 0;

                data.forEach((row, index) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (index + 1) + '</td>' +
                        '<td style="text-align: left;"><a href="javascript:void(0)" class="district-link" onclick="viewDistrictDetails(\'' + row.distCode + '\', \'' + year + '\')">' + (row.districtName || '-') + '</a></td>' +
                        '<td class="num">' + (row.total || 0) + '</td>' +
                        '<td class="num">' + (row.success || 0) + '</td>' +
                        '<td class="num">' + (row.pendingSid || 0) + '</td>' +
                        '<td class="num">' + (row.verified || 0) + '</td>' +
                        '<td class="num">' + (row.toBeVerified || 0) + '</td>' +
                        '<td class="num">' + (row.toBeUpdated || 0) + '</td>' +
                        '<td class="num">' + (row.phoneDuplicateRecords || 0) + '</td>' +
                        '<td class="num">' + (row.aadharDuplicateRecords || 0) + '</td>' +
                        '<td class="num">' + (row.emailDuplicateRecords || 0) + '</td>';
                    tbody.appendChild(tr);

                    gTotal += row.total || 0; gSuccess += row.success || 0; gPendingSid += row.pendingSid || 0;
                    gVerified += row.verified || 0; gToBeVerified += row.toBeVerified || 0; gToBeUpdated += row.toBeUpdated || 0;
                    gPhone += row.phoneDuplicateRecords || 0; gAadhar += row.aadharDuplicateRecords || 0; gEmail += row.emailDuplicateRecords || 0;
                });

                const ft = document.createElement('tr');
                ft.style.fontWeight = '800';
                ft.style.backgroundColor = '#e2e8f0';
                ft.innerHTML = '<td colspan="2" style="text-align: right; padding-right: 20px;">Total</td>' +
                    '<td class="num">' + gTotal + '</td>' +
                    '<td class="num">' + gSuccess + '</td>' +
                    '<td class="num">' + gPendingSid + '</td>' +
                    '<td class="num">' + gVerified + '</td>' +
                    '<td class="num">' + gToBeVerified + '</td>' +
                    '<td class="num">' + gToBeUpdated + '</td>' +
                    '<td class="num">' + gPhone + '</td>' +
                    '<td class="num">' + gAadhar + '</td>' +
                    '<td class="num">' + gEmail + '</td>';
                tfoot.appendChild(ft);
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }

        function viewDistrictDetails(distCode, year) {
            window.open('${pageContext.request.contextPath}/reports/api-dashboard-district?distCode=' + distCode + '&year=' + year, '_blank');
        }
    </script>
<%@ include file="../footer.jsp" %>
</body>
</html>
