<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students Not Admitted Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .nodal-report-card { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1); }
        .nodal-card-header-dashboard { background: linear-gradient(135deg, #003366 0%, #1a4a72 100%); color: white; padding: 22px 30px; font-weight: 700; display: flex; align-items: center; gap: 15px; }
        .nodal-card-header-dashboard i { width: 38px; height: 38px; background: rgba(255, 255, 255, 0.2); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 1rem; }
        .form-label-official { font-size: 0.85rem; font-weight: 700; color: #445566; text-transform: uppercase; letter-spacing: 0.8px; display: block; }
        .form-select-official, .form-control-official { border: 1px solid #ced4da; border-radius: 6px; padding: 10px 15px; font-size: 1.05rem; color: #2d3748; background-color: #ffffff; transition: border-color 0.2s ease; width: 100%; }
        .form-select-official:focus, .form-control-official:focus { border-color: #003366; outline: none; box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1); }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .num { text-align: center; font-weight: 700 !important; }
        .page-btn { border: 1px solid #ced4da; background: white; color: #003366; padding: 6px 12px; margin: 0 2px; border-radius: 6px; font-weight: 600; }
        .page-btn.active { background: #003366; color: white; border-color: #003366; }
        .page-btn:disabled { opacity: 0.5; cursor: not-allowed; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>Students Not Admitted Report</h2></div>
    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 550px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;"><i class="fas fa-filter me-2"></i> Selection Criteria</div>
            <div class="p-5 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event, 0)">
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5"><label for="year" class="form-label-official mb-md-0">Admission Year *</label></div>
                        <div class="col-md-7">
                            <select name="year" id="year" class="form-select-official" required>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                        </div>
                    </div>
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5"><label for="phase" class="form-label-official mb-md-0">Phase</label></div>
                        <div class="col-md-7">
                            <select name="phase" id="phase" class="form-select-official">
                                <option value="">All Phases</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>
                        </div>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn-submit-official-navy"><i class="fas fa-search me-2"></i>FETCH REPORT</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="container mt-4" id="loader" style="display:none;">
        <div class="loader-spinner" style="display:block;">
            <div class="spinner-border text-primary" style="width:3rem;height:3rem;" role="status"><span class="visually-hidden">Loading...</span></div>
            <p class="mt-3 fw-bold">Loading report data...</p>
        </div>
    </div>
    <div class="container-fluid mt-4 mb-5" id="reportView" style="display:none;">
        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
            <button class="btn btn-outline-secondary fw-bold px-4 rounded-pill" onclick="showSelection()"><i class="fas fa-arrow-left me-2"></i>BACK</button>
            <h5 class="fw-bold text-primary mb-0" id="reportTitle"></h5>
            <div class="d-flex gap-2">
                <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="fnExcelReport()" style="background-color: #107c41;"><i class="fas fa-file-excel me-2"></i>EXPORT TO EXCEL</button>
                <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;"><i class="fas fa-print me-2"></i>PRINT REPORT</button>
            </div>
        </div>
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="statusTable" style="min-width: 900px;">
                    <thead><tr>
                        <th class="num">S.NO</th><th>REG ID</th><th>STUDENT NAME</th><th>FATHER NAME</th><th>GENDER</th>
                        <th>CASTE</th><th>DOB</th><th>MOBILE</th><th>PHASE</th><th>STATUS</th>
                    </tr></thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>
        </div>
        <div class="d-flex justify-content-between align-items-center mt-3 flex-wrap gap-2">
            <div class="fw-bold text-muted" id="countInfo"></div>
            <div id="pagination" class="d-flex flex-wrap"></div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        var PAGE_SIZE = 500;
        var totalCount = 0, currentPage = 0, allRows = [];

        function showSelection() { document.getElementById('reportView').style.display = 'none'; document.getElementById('selectionView').style.display = 'block'; }

        function fetchReport(event, page) {
            if (event) event.preventDefault();
            const year = document.getElementById('year').value;
            const phase = document.getElementById('phase').value;
            currentPage = page;
            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('reportView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';
            let url = '${backendApiUrl}/students-not-admitted?year=' + encodeURIComponent(year) + '&page=' + page + '&size=' + PAGE_SIZE;
            if (phase) url += '&phase=' + encodeURIComponent(phase);
            fetch(url, { method: 'GET', headers: { 'Content-Type': 'application/json' } })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                document.getElementById('reportTitle').innerText = 'Students Not Admitted (' + year + (phase ? ' - Phase ' + phase : '') + ')';
                totalCount = data.count || 0;
                allRows = data.data || [];
                renderTable();
                renderPagination();
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('selectionView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }

        function renderTable() {
            const tbody = document.getElementById('tableBody');
            tbody.innerHTML = '';
            const start = currentPage * PAGE_SIZE;
            if (allRows.length > 0) {
                allRows.forEach((row, i) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML = '<td class="num">' + (start + i + 1) + '</td>'
                        + '<td>' + (row.regid || '-') + '</td>'
                        + '<td style="text-align:left;">' + (row.name || '-') + '</td>'
                        + '<td style="text-align:left;">' + (row.fname || '-') + '</td>'
                        + '<td>' + (row.gender || '-') + '</td>'
                        + '<td>' + (row.caste || '-') + '</td>'
                        + '<td>' + (row.dob || '-') + '</td>'
                        + '<td>' + (row.phno || '-') + '</td>'
                        + '<td class="num">' + (row.phase || '-') + '</td>'
                        + '<td>' + (row.appStatus || '-') + '</td>';
                    tbody.appendChild(tr);
                });
            } else {
                tbody.innerHTML = '<tr><td colspan="10" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
            }
            document.getElementById('countInfo').innerText = 'Total: ' + totalCount + ' student(s) | Showing ' + (allRows.length ? (start + 1) : 0) + ' - ' + (start + allRows.length);
        }

        function renderPagination() {
            const pages = Math.ceil(totalCount / PAGE_SIZE);
            const pg = document.getElementById('pagination');
            pg.innerHTML = '';
            if (pages <= 1) return;
            const mkBtn = (label, page, disabled, active) => {
                const b = document.createElement('button');
                b.className = 'page-btn' + (active ? ' active' : '');
                b.innerHTML = label;
                b.disabled = disabled;
                b.onclick = () => fetchReport(null, page);
                return b;
            };
            pg.appendChild(mkBtn('&laquo;', Math.max(0, currentPage - 1), currentPage === 0, false));
            const from = Math.max(0, currentPage - 2), to = Math.min(pages - 1, currentPage + 2);
            for (let p = from; p <= to; p++) pg.appendChild(mkBtn(p + 1, p, false, p === currentPage));
            pg.appendChild(mkBtn('&raquo;', Math.min(pages - 1, currentPage + 1), currentPage >= pages - 1, false));
        }

        function fnExcelReport() {
            const tab_text = '<table border=1px>' + document.getElementById('statusTable').innerHTML + '</table>';
            let blob = new Blob([tab_text], { type: 'application/vnd.ms-excel' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'Students_Not_Admitted_Report.xls';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    </script>
</body>
</html>
