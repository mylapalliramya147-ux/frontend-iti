<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>:: ITI Profile - Trades & Strengths ::</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
    <style>
        .iti-profile-header {
            background: linear-gradient(135deg, #003366 0%, #005073 100%);
            color: #ffffff;
            padding: 24px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            box-shadow: 0 4px 12px rgba(0, 51, 102, 0.15);
        }
        .iti-profile-header h2 {
            font-size: 1.65rem;
            font-weight: 700;
            margin-bottom: 6px;
        }
        .iti-profile-header p {
            margin: 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }
        .filter-card {
            background: #ffffff;
            border: 1px solid #d9e2ec;
            border-radius: 8px;
            padding: 20px 24px;
            margin-bottom: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        .filter-title {
            font-weight: 700;
            font-size: 1.05rem;
            color: #003366;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .stat-badge {
            background: #f0f7ff;
            border: 1px solid #cce3ff;
            border-radius: 6px;
            padding: 10px 16px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .stat-badge i {
            font-size: 1.4rem;
            color: #005073;
        }
        .stat-badge .stat-num {
            font-size: 1.25rem;
            font-weight: 700;
            color: #003366;
            line-height: 1.2;
        }
        .stat-badge .stat-label {
            font-size: 0.78rem;
            color: #627d98;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .table-profile {
            border: 1px solid #cbd5e1;
            background: #fff;
            width: 100%;
        }
        .table-profile thead th {
            background: #003366 !important;
            color: #ffffff !important;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 12px 10px;
            vertical-align: middle;
            border-color: #002244;
        }
        .table-profile tbody td {
            vertical-align: middle;
            padding: 12px 10px;
            font-size: 0.92rem;
            border-bottom: 1px solid #e2e8f0;
        }
        .table-profile tbody tr:hover {
            background-color: #f8fafc;
        }
        .badge-govt {
            background-color: #0d6efd;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .badge-pvt {
            background-color: #6c757d;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .trade-chip {
            display: inline-flex;
            align-items: center;
            background: #f1f5f9;
            border: 1px solid #cbd5e1;
            border-radius: 20px;
            padding: 4px 10px;
            margin: 3px 4px 3px 0;
            font-size: 0.82rem;
            color: #1e293b;
        }
        .trade-chip .strength-count {
            background: #005073;
            color: #fff;
            font-size: 0.75rem;
            font-weight: 700;
            border-radius: 12px;
            padding: 1px 7px;
            margin-left: 6px;
        }
        .iti-link {
            color: #003366;
            font-weight: 600;
            text-decoration: none;
        }
        .iti-link:hover {
            color: #0066cc;
            text-decoration: underline;
        }
    </style>
</head>
<body class="portal-page">

    <!-- Top Banner -->
    <center>
        <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" style="max-height: 130px; object-fit: cover;" />
    </center>

    <!-- Navigation Bar -->
    <%@ include file="../navbars/index_navbar.jsp" %>

    <!-- Marquee -->
    <marquee onmouseover="this.stop();" onmouseout="this.start();" scrolldelay="100" style="background: #eef4f9; padding: 6px 0; border-bottom: 1px solid #d8e2eb; font-weight: 600; color: #003366;">
        <i class="fas fa-bullhorn text-danger me-2"></i> Andhra Pradesh ITI Portal — View Complete ITI Profile, Trades, and Approved Strengths District-wise.
    </marquee>

    <!-- Main Container -->
    <div class="container my-4">
        
        <!-- Header Banner -->
        <div class="iti-profile-header text-center">
            <h2><i class="fas fa-university me-2"></i> List of ITIs with Trades & Strengths</h2>
            <p>Select a district and management type to view approved ITIs, trade lists, and sanctioned seats</p>
        </div>

        <!-- Filter Card -->
        <div class="filter-card">
            <div class="filter-title">
                <i class="fas fa-filter"></i> Search & Filter Criteria
            </div>
            <form id="filterForm" onsubmit="event.preventDefault(); loadItiProfile();">
                <div class="row g-3 align-items-end">
                    <div class="col-md-5 col-sm-12">
                        <label for="distSelect" class="form-label fw-bold text-secondary">
                            Select District <span class="text-danger">*</span>
                        </label>
                        <select id="distSelect" class="form-select" required>
                            <option value="" selected>-- Select District --</option>
                            <option value="11">Srikakulam</option>
                            <option value="12">Vizianagaram</option>
                            <option value="13">Visakhapatnam</option>
                            <option value="14">East Godavari</option>
                            <option value="15">West Godavari</option>
                            <option value="16">Krishna</option>
                            <option value="17">Guntur</option>
                            <option value="18">Prakasam</option>
                            <option value="19">Nellore</option>
                            <option value="20">YSR Kadapa</option>
                            <option value="21">Kurnool</option>
                            <option value="22">Anantapur</option>
                            <option value="23">Chittoor</option>
                            <option value="24">Anakapalli</option>
                            <option value="25">Alluri Sitaramaraju</option>
                            <option value="26">Parvathipuram-Manyam</option>
                            <option value="27">Kakinada</option>
                            <option value="28">Konaseema</option>
                            <option value="29">Eluru</option>
                            <option value="30">NTR</option>
                            <option value="31">Palnadu</option>
                            <option value="32">Bapatla</option>
                            <option value="33">Annamayya</option>
                            <option value="34">Nandyal</option>
                            <option value="35">Sri Satyasai</option>
                            <option value="36">Tirupati</option>
                        </select>
                    </div>

                    <div class="col-md-4 col-sm-12">
                        <label for="govSelect" class="form-label fw-bold text-secondary">
                            Management Type
                        </label>
                        <select id="govSelect" class="form-select">
                            <option value="">-- ALL MANAGEMENT (Govt & Pvt) --</option>
                            <option value="G">Government Only</option>
                            <option value="P">Private Only</option>
                        </select>
                    </div>

                    <div class="col-md-3 col-sm-12 d-flex gap-2">
                        <button type="submit" id="btnSubmit" class="btn btn-primary w-100 py-2 fw-semibold">
                            <i class="fas fa-search me-1"></i> Get Profile
                        </button>
                        <button type="button" id="btnExcel" class="btn btn-success py-2 fw-semibold" style="display: none;" onclick="exportTableToExcel('profileTable', 'ITI_Profile_Data')">
                            <i class="fas fa-file-excel me-1"></i> Excel
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Summary & Stats Bar (hidden initially) -->
        <div id="statsRow" class="row g-3 mb-4" style="display: none;">
            <div class="col-md-4 col-sm-6">
                <div class="stat-badge">
                    <i class="fas fa-school"></i>
                    <div>
                        <div class="stat-num" id="statItiCount">0</div>
                        <div class="stat-label">Total ITIs Found</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-6">
                <div class="stat-badge">
                    <i class="fas fa-cogs"></i>
                    <div>
                        <div class="stat-num" id="statTradeCount">0</div>
                        <div class="stat-label">Total Trades Offered</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-12">
                <div class="stat-badge">
                    <i class="fas fa-user-graduate"></i>
                    <div>
                        <div class="stat-num" id="statStrengthCount">0</div>
                        <div class="stat-label">Total Sanctioned Capacity</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Loading State -->
        <div id="loader" class="text-center py-5" style="display: none;">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p class="mt-3 text-secondary fw-semibold">Fetching ITI profile and trade strengths...</p>
        </div>

        <!-- Error State -->
        <div id="errorAlert" class="alert alert-danger" style="display: none;" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <span id="errorMessage">Failed to fetch ITI records.</span>
        </div>

        <!-- Initial Placeholder State -->
        <div id="initialState" class="text-center py-5 bg-white border rounded">
            <i class="fas fa-map-marked-alt text-primary mb-3" style="font-size: 3.5rem; opacity: 0.6;"></i>
            <h5 class="fw-bold text-secondary">No District Selected</h5>
            <p class="text-muted">Please select a district above and click "Get Profile" to view the ITI trade details.</p>
        </div>

        <!-- Results Table Card (hidden initially) -->
        <div id="resultsCard" class="card border-0 shadow-sm" style="display: none;">
            <div class="card-header bg-white py-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
                <h5 class="mb-0 fw-bold text-dark" id="resultsTitle">
                    <i class="fas fa-list-alt text-primary me-2"></i> ITI Trade Details
                </h5>
                <div class="d-flex align-items-center" style="max-width: 320px;">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-light"><i class="fas fa-search"></i></span>
                        <input type="text" id="tableSearchInput" class="form-control" placeholder="Quick search in table..." onkeyup="filterTableRows()">
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-profile mb-0" id="profileTable">
                    <thead>
                        <tr>
                            <th style="width: 60px; text-align: center;">#</th>
                            <th style="width: 320px;">ITI Code & Name</th>
                            <th style="width: 100px; text-align: center;">Type</th>
                            <th>Offered Trades & Approved Strengths</th>
                            <th style="width: 110px; text-align: center;">Total Seats</th>
                        </tr>
                    </thead>
                    <tbody id="itiTableBody">
                        <!-- Populated by JavaScript -->
                    </tbody>
                </table>
            </div>
            <div class="card-footer bg-light text-muted small py-2">
                <i class="fas fa-info-circle me-1"></i> Click on any ITI name to view its detailed institute and staff records.
            </div>
        </div>

    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

    <script>
        const BACKEND_BASE = "${backendApiUrl}";

        // Auto-fetch districts on page load to populate/refresh the dropdown
        document.addEventListener('DOMContentLoaded', function() {
            fetchDistricts();

            // Support query params if user arrived with ?dist_code=...&gov=...
            const urlParams = new URLSearchParams(window.location.search);
            const distParam = urlParams.get('dist_code') || urlParams.get('dist');
            const govParam = urlParams.get('gov') || urlParams.get('type');

            if (distParam) {
                const distSelect = document.getElementById('distSelect');
                distSelect.value = distParam;
                if (govParam) {
                    document.getElementById('govSelect').value = govParam;
                }
                loadItiProfile();
            }
        });

        function fetchDistricts() {
            fetch(BACKEND_BASE + '/trade-display/districts')
                .then(res => res.json())
                .then(data => {
                    if (data && data.data && data.data.length > 0) {
                        const distSelect = document.getElementById('distSelect');
                        const currentVal = distSelect.value;
                        distSelect.innerHTML = '<option value="">-- Select District --</option>';
                        data.data.forEach(d => {
                            const opt = document.createElement('option');
                            opt.value = d.code;
                            opt.textContent = d.name;
                            if (d.code === currentVal) opt.selected = true;
                            distSelect.appendChild(opt);
                        });
                    }
                })
                .catch(err => {
                    console.log('Using pre-populated district fallback options.');
                });
        }

        let currentRecords = [];

        function loadItiProfile() {
            const distSelect = document.getElementById('distSelect');
            const distCode = distSelect.value;
            const distName = distSelect.options[distSelect.selectedIndex].text;
            const govType = document.getElementById('govSelect').value;

            if (!distCode) {
                alert('Please select a district.');
                distSelect.focus();
                return;
            }

            // UI state management
            document.getElementById('initialState').style.display = 'none';
            document.getElementById('errorAlert').style.display = 'none';
            document.getElementById('resultsCard').style.display = 'none';
            document.getElementById('statsRow').style.display = 'none';
            document.getElementById('btnExcel').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            let endpoint = BACKEND_BASE + '/trade-display/itis?dist=' + encodeURIComponent(distCode);
            if (govType) {
                endpoint += '&type=' + encodeURIComponent(govType);
            }

            fetch(endpoint)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Server returned HTTP ' + response.status);
                    }
                    return response.json();
                })
                .then(resData => {
                    document.getElementById('loader').style.display = 'none';

                    const records = (resData && resData.data) ? resData.data : [];
                    currentRecords = records;

                    if (records.length === 0) {
                        document.getElementById('errorAlert').style.display = 'block';
                        document.getElementById('errorMessage').textContent = 
                            'No ITI records found for ' + distName + (govType ? ' (' + (govType === 'G' ? 'Government' : 'Private') + ')' : '') + '.';
                        return;
                    }

                    renderItiTable(records, distName);
                })
                .catch(err => {
                    document.getElementById('loader').style.display = 'none';
                    document.getElementById('errorAlert').style.display = 'block';
                    document.getElementById('errorMessage').textContent = 'Error loading ITI details: ' + err.message;
                    console.error('Fetch error:', err);
                });
        }

        function renderItiTable(records, distName) {
            const tbody = document.getElementById('itiTableBody');
            tbody.innerHTML = '';

            let totalTrades = 0;
            let totalCapacity = 0;

            records.forEach((row, index) => {
                const tr = document.createElement('tr');

                // S.No
                const tdIndex = document.createElement('td');
                tdIndex.style.textAlign = 'center';
                tdIndex.style.fontWeight = '600';
                tdIndex.textContent = (index + 1);
                tr.appendChild(tdIndex);

                // ITI Code & Name
                const tdName = document.createElement('td');
                const itiCode = row.code || '';
                const itiName = row.itiName || '-';
                tdName.innerHTML = 
                    '<a href="${pageContext.request.contextPath}/iti-details?itiCode=' + encodeURIComponent(itiCode) + '" class="iti-link" title="View ITI Profile">' +
                    '<span class="badge bg-secondary me-1">' + itiCode + '</span> ' + itiName +
                    '</a>';
                tr.appendChild(tdName);

                // Management
                const tdGovt = document.createElement('td');
                tdGovt.style.textAlign = 'center';
                const isGovt = (row.govt === 'G');
                tdGovt.innerHTML = isGovt 
                    ? '<span class="badge-govt">GOVT</span>' 
                    : '<span class="badge-pvt">PVT</span>';
                tr.appendChild(tdGovt);

                // Trades & Strengths
                const tdTrades = document.createElement('td');
                let itiTotalStrength = 0;

                if (row.trades && row.trades.length > 0) {
                    row.trades.forEach(t => {
                        const str = t.strength || 0;
                        itiTotalStrength += str;
                        totalTrades++;

                        const chip = document.createElement('span');
                        chip.className = 'trade-chip';
                        chip.innerHTML = (t.tradeName || 'General') + '<span class="strength-count">' + str + '</span>';
                        tdTrades.appendChild(chip);
                    });
                } else {
                    tdTrades.innerHTML = '<span class="text-muted fst-italic">No trades recorded</span>';
                }
                tr.appendChild(tdTrades);

                // Total Capacity
                const tdCapacity = document.createElement('td');
                tdCapacity.style.textAlign = 'center';
                tdCapacity.style.fontWeight = '700';
                tdCapacity.style.color = '#003366';
                tdCapacity.textContent = itiTotalStrength;
                tr.appendChild(tdCapacity);

                totalCapacity += itiTotalStrength;
                tbody.appendChild(tr);
            });

            // Update stats
            document.getElementById('statItiCount').textContent = records.length;
            document.getElementById('statTradeCount').textContent = totalTrades;
            document.getElementById('statStrengthCount').textContent = totalCapacity.toLocaleString();
            document.getElementById('resultsTitle').innerHTML = 
                '<i class="fas fa-list-alt text-primary me-2"></i> ITIs in ' + distName + ' (' + records.length + ')';

            // Show sections
            document.getElementById('statsRow').style.display = 'flex';
            document.getElementById('resultsCard').style.display = 'block';
            document.getElementById('btnExcel').style.display = 'inline-block';
        }

        // Live client-side search in results table
        function filterTableRows() {
            const query = document.getElementById('tableSearchInput').value.toLowerCase();
            const rows = document.querySelectorAll('#itiTableBody tr');

            rows.forEach(row => {
                const text = row.innerText.toLowerCase();
                row.style.display = text.includes(query) ? '' : 'none';
            });
        }

        // Excel Export
        function exportTableToExcel(tableID, filename) {
            let downloadLink;
            const dataType = 'application/vnd.ms-excel';
            const tableSelect = document.getElementById(tableID);
            const tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

            filename = filename ? filename + '.xls' : 'iti_profile.xls';

            downloadLink = document.createElement("a");
            document.body.appendChild(downloadLink);

            if (navigator.msSaveOrOpenBlob) {
                const blob = new Blob(['\ufeff', tableSelect.outerHTML], { type: dataType });
                navigator.msSaveOrOpenBlob(blob, filename);
            } else {
                downloadLink.href = 'data:' + dataType + ', ' + tableHTML;
                downloadLink.download = filename;
                downloadLink.click();
            }
            document.body.removeChild(downloadLink);
        }
    </script>

    <!-- Global Footer -->
    <%@ include file="../footer.jsp" %>
</body>
</html>