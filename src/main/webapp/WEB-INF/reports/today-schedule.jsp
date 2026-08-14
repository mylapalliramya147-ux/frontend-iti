<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Today Schedule ITIs | Nodal Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .nodal-report-card { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1); }
        .nodal-card-header-dashboard { background: linear-gradient(135deg, #003366 0%, #1a4a72 100%); color: white; padding: 22px 30px; font-weight: 700; display: flex; align-items: center; gap: 15px; }
        .nodal-card-header-dashboard i { width: 38px; height: 38px; background: rgba(255, 255, 255, 0.2); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 1rem; }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .num { text-align: center; font-weight: 700 !important; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="today_schedule" />
    <%@ include file="nodal_navbar.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>Today Schedule ITIs</h2></div>
    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 550px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;"><i class="fas fa-info-circle me-2"></i> Report Info</div>
            <div class="p-5 bg-white rounded-bottom">
                <p class="text-muted mb-4">This report shows all ITIs with scheduled admission sessions for today.</p>
                <div class="mt-5 text-center">
                    <button type="button" class="btn-submit-official-navy w-100" onclick="fetchReport()"><i class="fas fa-search me-2"></i>VIEW REPORT</button>
                </div>
            </div>
        </div>
    </div>
    <div class="loader-spinner" id="loader"><i class="fas fa-spinner fa-spin fa-3x"></i><p class="mt-3 fw-bold">Loading today's schedule...</p></div>
    <div class="container mt-4" id="reportView" style="display: none;">
        <div class="text-center mb-3" style="color: #003366;"><h2 class="fw-bold fs-4 mb-2" id="reportTitle">Today Schedule - ITIs</h2></div>
        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()"><i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION</button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;"><i class="fas fa-print me-2"></i>PRINT REPORT</button>
        </div>
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="statusTable" style="min-width: 1000px;">
                    <thead><tr><th>District</th><th style="text-align: left;">ITI Name</th><th>Trade</th><th class="num">Merit From</th><th class="num">Merit To</th><th>Date</th><th>Time</th><th>Phase</th></tr></thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        function showSelection() { document.getElementById('reportView').style.display = 'none'; document.getElementById('selectionView').style.display = 'block'; }
        function fetchReport() {
            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';
            fetch('${backendApiUrl}/today-schedule', { method: 'GET' })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = '';
                if (data.error) throw new Error(data.error);
                if (data.data && data.data.length > 0) {
                    data.data.forEach(row => {
                        const tr = document.createElement('tr');
                        tr.innerHTML = '<td>' + (row.distName || '-') + '</td><td style="text-align: left;">' + (row.itiName || '-') + '</td><td style="text-align: left;">' + (row.tradeName || '-') + '</td><td class="num">' + (row.meritFrom || '-') + '</td><td class="num">' + (row.meritTo || '-') + '</td><td>' + (row.calDate || '-') + '</td><td>' + (row.calTime || '-') + '</td><td>' + (row.phase || '-') + '</td>';
                        tbody.appendChild(tr);
                    });
                } else { tbody.innerHTML = '<tr><td colspan="8" style="text-align:center; padding:20px; font-weight: bold;">No schedules for today.</td></tr>'; }
            })
            .catch(error => { document.getElementById('loader').style.display = 'none'; document.getElementById('selectionView').style.display = 'block'; alert('Error loading data: ' + error.message); console.error('Error:', error); });
        }
    </script>
</body>
</html>
