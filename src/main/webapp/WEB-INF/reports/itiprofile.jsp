<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI Profile | Nodal Reports</title>
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
        .form-select-official, .form-control-official { border: 1px solid #ced4da; border-radius: 6px; padding: 10px 15px; font-size: 1.05rem; color: #2d3748; background-color: #ffffff; transition: border-color 0.2s ease; width: 100%; }
        .form-select-official:focus, .form-control-official:focus { border-color: #003366; outline: none; box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1); }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .num { text-align: center; font-weight: 700 !important; }
        .iti-profile-card { background: white; border-radius: 10px; border: 1px solid #e1e8f0; padding: 20px; margin-bottom: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.03); }
        .iti-profile-card h4 { color: #003366; font-weight: 700; margin-bottom: 10px; border-bottom: 2px solid #e1e8f0; padding-bottom: 8px; }
        .trade-item { display: flex; justify-content: space-between; padding: 4px 0; border-bottom: 1px dashed #e1e8f0; }
        .trade-item:last-child { border-bottom: none; }
        .badge-strength { background: #e2e8f0; color: #4a5568; padding: 2px 10px; border-radius: 12px; font-size: 0.8rem; font-weight: 600; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="iti_profile" />
    <%@ include file="state_navbar.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>List of ITI's with Trades &amp; Strengths</h2></div>
    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 600px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;"><i class="fas fa-filter me-2"></i> Selection Criteria</div>
            <div class="p-5 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event)">
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5"><label for="distCode" class="form-label-official mb-md-0">Select District *</label></div>
                        <div class="col-md-7">
                            <select name="distCode" id="distCode" class="form-select-official w-100" required>
                                <option value="">-- Select District --</option>
                            </select>
                        </div>
                    </div>
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5"><label for="govt" class="form-label-official mb-md-0">GOVT/PVT</label></div>
                        <div class="col-md-7">
                            <select name="govt" id="govt" class="form-select-official w-100">
                                <option value="">---- ALL ----</option>
                                <option value="G">GOVERNMENT</option>
                                <option value="P">PRIVATE</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-5 text-center">
                        <button type="submit" class="btn-submit-official-navy w-100"><i class="fas fa-search me-2"></i>VIEW REPORT</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="loader-spinner" id="loader"><i class="fas fa-spinner fa-spin fa-3x"></i><p class="mt-3 fw-bold">Loading ITI profiles...</p></div>
    <div class="container mt-4" id="reportView" style="display: none;">
        <div class="text-center mb-4" style="color: #003366;">
            <h2 class="fw-bold fs-4 mb-2" id="reportTitle">ITI Profiles</h2>
            <p class="mb-4 text-muted" style="font-size: 1.1rem;" id="reportSubtitle">List of ITI's with Trades &amp; Strengths</p>
        </div>
        <div class="no-print d-flex justify-content-center gap-3 mb-4">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()"><i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION</button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;"><i class="fas fa-print me-2"></i>PRINT REPORT</button>
        </div>
        <div id="resultsContainer"></div>
    </div>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        function showSelection() { document.getElementById('reportView').style.display = 'none'; document.getElementById('selectionView').style.display = 'block'; }
        function loadDistricts() {
            fetch('${backendApiUrl}/trade-display/districts', { method: 'GET' })
            .then(response => response.json())
            .then(data => {
                const select = document.getElementById('distCode');
                if (data.data && data.data.length > 0) {
                    data.data.forEach(dist => {
                        const option = document.createElement('option');
                        option.value = dist.code;
                        option.textContent = dist.name;
                        select.appendChild(option);
                    });
                }
            })
            .catch(error => console.error('Error loading districts:', error));
        }
        window.addEventListener('load', loadDistricts);
        function fetchReport(event) {
            event.preventDefault();
            const distCode = document.getElementById('distCode').value;
            const govt = document.getElementById('govt').value;
            if (!distCode) { alert('Please select a district'); return; }
            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';
            let params = 'dist=' + encodeURIComponent(distCode);
            if (govt && govt !== '') params += '&type=' + encodeURIComponent(govt);
            fetch('${backendApiUrl}/trade-display/itis?' + params, { method: 'GET' })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                document.getElementById('reportTitle').innerText = 'List of ITI\'s - District: ' + distCode;
                document.getElementById('reportSubtitle').innerHTML = 'Trades &amp; Strengths <span class="text-muted">(' + (govt && govt !== '' ? (govt === 'G' ? 'Government' : 'Private') : 'All Types') + ')</span>';
                const container = document.getElementById('resultsContainer');
                container.innerHTML = '';
                if (data.error) throw new Error(data.error);
                if (data.data && data.data.length > 0) {
                    data.data.forEach((row, idx) => {
                        const card = document.createElement('div');
                        card.className = 'iti-profile-card';
                        let html = '<h4>' + (row.code || '-') + ' :- ' + (row.itiName || '-') + '</h4>';
                        if (row.trades && row.trades.length > 0) {
                            html += '<ol style="margin: 0; padding-left: 20px;">';
                            row.trades.forEach(trade => {
                                html += '<li style="margin-bottom: 4px;">' + (trade.tradeName || '-') + ' <span class="badge-strength">' + (trade.strength || 0) + '</span></li>';
                            });
                            html += '</ol>';
                        } else {
                            html += '<p style="color: #999; font-style: italic; margin: 0;">No trades listed</p>';
                        }
                        card.innerHTML = html;
                        container.appendChild(card);
                    });
                } else {
                    container.innerHTML = '<div class="alert alert-info text-center" style="font-weight: bold; padding: 20px;">No ITI records found for the selected district.</div>';
                }
            })
            .catch(error => { document.getElementById('loader').style.display = 'none'; document.getElementById('selectionView').style.display = 'block'; alert('Error loading data: ' + error.message); console.error('Error:', error); });
        }
    </script>
</body>
</html>
