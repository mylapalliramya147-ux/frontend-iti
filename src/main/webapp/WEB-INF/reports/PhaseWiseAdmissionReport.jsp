<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phase Wise Admissions Details | Nodal Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .num { text-align: center; font-weight: 700 !important; }
        .slno-col { width: 60px; }
        .district-col { text-align: left; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="phase_wise" />
    <%@ include file="../nodal_navbar.jsp" %>

    <div class="nodal-page-title-dashboard">
        <h2 id="reportTitle">Phase Wise Admissions Details</h2>
    </div>

    <div class="text-right px-4 mb-3" id="downloadSection" style="display: none;">
        <input type="button" value="Excel Download" class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="tableToExcel('tot', 'PhaseWiseAdmissions')">
    </div>

    <div class="loader-spinner" id="loader"><i class="fas fa-spinner fa-spin fa-3x"></i><p class="mt-3 fw-bold">Loading phase-wise admissions...</p></div>

    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="tot" style="min-width: 1000px;">
                    <thead>
                        <tr>
                            <th class="slno-col">Sl No</th>
                            <th class="district-col">District Name</th>
                            <th class="num">Phase I</th>
                            <th class="num">Phase II</th>
                            <th class="num">Phase III</th>
                            <th class="num">Phase IV</th>
                            <th class="num">Phase V</th>
                            <th class="num">Total</th>
                            <th class="num">Today</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                    <tfoot id="tableFoot"></tfoot>
                </table>
            </div>
        </div>
    </div>
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="tot" style="min-width: 1000px;">
                    <thead>
                        <tr>
                            <th class="slno-col">Sl No</th>
                            <th class="district-col">District Name</th>
                            <th class="num">Phase I</th>
                            <th class="num">Phase II</th>
                            <th class="num">Phase III</th>
                            <th class="num">Phase IV</th>
                            <th class="num">Phase V</th>
                            <th class="num">Total</th>
                            <th class="num">Today</th>
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
        function tableToExcel(tableID, name = '') {
            var table = document.getElementById(tableID);
            var html = table.outerHTML;
            var blob = new Blob(['\ufeff', html], { type: "application/vnd.ms-excel" });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = name + '.xls';
            a.click();
            URL.revokeObjectURL(url);
        }

        function formatDate(date) {
            const d = new Date(date);
            const day = String(d.getDate()).padStart(2, '0');
            const month = String(d.getMonth() + 1).padStart(2, '0');
            const year = d.getFullYear();
            return day + '-' + month + '-' + year;
        }

        function showSelection() { document.getElementById('reportView').style.display = 'none'; document.getElementById('selectionView').style.display = 'block'; }
        function fetchReport(event) {
            event.preventDefault();
            const year = document.getElementById('year').value;
            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';
            loadReport(year);
        }

        document.addEventListener('DOMContentLoaded', function() {
            fetch('${backendApiUrl}/current-admission-phase')
                .then(r => r.json())
                .then(config => {
                    const year = config.year || String(new Date().getFullYear());
                    document.getElementById('year').value = year;
                })
                .catch(err => {
                    console.error('Failed to load current phase:', err);
                });
        });

        function loadReport(year) {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('reportView').style.display = 'none';

            fetch('${backendApiUrl}/phase-wise?year=' + encodeURIComponent(year), { method: 'GET' })
            .then(response => response.json())
            .then(response => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                document.getElementById('downloadSection').style.display = 'block';
                document.getElementById('reportTitle').innerText = 'Phase Wise Admissions Details (' + year + ')';

                const tbody = document.getElementById('tableBody');
                const tfoot = document.getElementById('tableFoot');
                tbody.innerHTML = ''; tfoot.innerHTML = '';

                const data = response.data || [];
                if (data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="9" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                    return;
                }

                let totals = { phaseI: 0, phaseII: 0, phaseIII: 0, phaseIV: 0, phaseV: 0, total: 0, today: 0 };

                data.forEach((row, index) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (index + 1) + '</td>' +
                        '<td class="district-col">' + (row.distName || '-') + '</td>' +
                        '<td class="num">' + (row.phaseI || 0) + '</td>' +
                        '<td class="num">' + (row.phaseII || 0) + '</td>' +
                        '<td class="num">' + (row.phaseIII || 0) + '</td>' +
                        '<td class="num">' + (row.phaseIV || 0) + '</td>' +
                        '<td class="num">' + (row.phaseV || 0) + '</td>' +
                        '<td class="num">' + (row.total || 0) + '</td>' +
                        '<td class="num">' + (row.today || 0) + '</td>';
                    tbody.appendChild(tr);

                    totals.phaseI += row.phaseI || 0; totals.phaseII += row.phaseII || 0; totals.phaseIII += row.phaseIII || 0;
                    totals.phaseIV += row.phaseIV || 0; totals.phaseV += row.phaseV || 0; totals.total += row.total || 0; totals.today += row.today || 0;
                });

                const ft = document.createElement('tr');
                ft.style.fontWeight = '800';
                ft.style.backgroundColor = '#e2e8f0';
                ft.innerHTML = '<td colspan="2" style="text-align: right; padding-right: 20px;">Total</td>' +
                    '<td class="num">' + totals.phaseI + '</td>' +
                    '<td class="num">' + totals.phaseII + '</td>' +
                    '<td class="num">' + totals.phaseIII + '</td>' +
                    '<td class="num">' + totals.phaseIV + '</td>' +
                    '<td class="num">' + totals.phaseV + '</td>' +
                    '<td class="num">' + totals.total + '</td>' +
                    '<td class="num">' + totals.today + '</td>';
                tfoot.appendChild(ft);
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('selectionView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html>
