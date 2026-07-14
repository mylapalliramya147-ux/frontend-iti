<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI Admissions | Full DSC Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* DASHBOARD UI OVERRIDES */
        .nodal-dashboard-navbar {
            background: #002244;
            padding: 0;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 2.5rem;
        }
        .nodal-dashboard-link {
            padding: 18px 25px;
            color: rgba(255, 255, 255, 0.7) !important;
            text-decoration: none;
            font-size: 0.72rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.25s ease;
            border-bottom: 4px solid transparent;
        }
        .nodal-dashboard-link:hover {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.05);
        }
        .nodal-dashboard-link.active {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.1);
            border-bottom-color: #ffd700;
        }
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
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="../header.jsp" %>
    
    <c:set var="activeTab" value="home" />
    <%@ include file="nodal_navbar.jsp" %>

    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Industrial Training Institute — Full DSC Report Selection</h2>
    </div>

    <div class="container mt-4">
        <div class="nodal-report-card shadow-lg mx-auto" style="max-width: 900px;">
            <div class="nodal-card-header-dashboard">
                <i class="fas fa-file-invoice me-2"></i> DSC Selection Criteria
            </div>
            <div class="p-5 bg-white rounded-bottom">
                <form action="${pageContext.request.contextPath}/nodal-report/reports/dsc_full" method="post" id="selectionForm">
                    <div class="row g-4">
                        <!-- District -->
                        <div class="col-md-6">
                            <label for="dist_code" class="form-label fw-bold small text-secondary">SELECT DISTRICT *</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-map-marker-alt text-primary"></i></span>
                                <select name="dist_code" id="dist_code" class="form-select border-start-0" onchange="loadItis()" required>
                                    <option value="">-- Select District --</option>
                                </select>
                            </div>
                        </div>

                        <!-- ITI Name -->
                        <div class="col-md-6">
                            <label for="iti_code" class="form-label fw-bold small text-secondary">SELECT ITI NAME *</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-university text-primary"></i></span>
                                <select name="iti_code" id="iti_code" class="form-select border-start-0" onchange="loadTrades()" required>
                                    <option value="">-- Select ITI --</option>
                                </select>
                            </div>
                        </div>

                        <!-- Trade Name -->
                        <div class="col-md-12">
                            <label for="trade_code" class="form-label fw-bold small text-secondary">SELECT TRADE NAME *</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-tools text-primary"></i></span>
                                <select name="trade_code" id="trade_code" class="form-select border-start-0" required>
                                    <option value="">-- Select Trade --</option>
                                </select>
                            </div>
                        </div>

                        <!-- Phase -->
                        <div class="col-md-4">
                            <label for="phase" class="form-label fw-bold small text-secondary">SELECT PHASE *</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-layer-group text-primary"></i></span>
                                <select name="phase" id="phase" class="form-select border-start-0" required>
                                    <option value="">-- Select Phase --</option>
                                </select>
                            </div>
                        </div>

                        <!-- Year -->
                        <div class="col-md-4">
                            <label for="year" class="form-label fw-bold small text-secondary">SELECT YEAR *</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-calendar-alt text-primary"></i></span>
                                <select name="year" id="year" class="form-select border-start-0" required>
                                    <option value="">-- Select Year --</option>
                                </select>
                            </div>
                        </div>

                        <!-- Level -->
                        <div class="col-md-4">
                            <label for="mode_adm" class="form-label fw-bold small text-secondary">SELECT LEVEL *</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-sliders-h text-primary"></i></span>
                                <select name="mode_adm" id="mode_adm" class="form-select border-start-0" required>
                                    <option value="">-- Select Level --</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="mt-5 d-flex gap-4">
                        <button type="button" class="btn btn-lg btn-outline-secondary px-5" onclick="resetForm()" style="border-radius: 10px; font-weight: 600;">
                            <i class="fas fa-undo me-2"></i> RESET
                        </button>
                        <button type="submit" class="nodal-btn-primary flex-grow-1 py-3" style="border-radius: 10px; font-weight: 600; letter-spacing: 1px;">
                            <i class="fas fa-search me-2"></i> VIEW SELECTION REPORT
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script>
        const API = '${pageContext.request.contextPath}/nodal-report'; 

        async function fetchJSON(url) {
            try {
                const r = await fetch(url);
                if (!r.ok) throw new Error('HTTP ' + r.status);
                return await r.json();
            } catch (e) {
                console.error('Fetch error:', url, e);
                return [];
            }
        }

        async function loadDistricts() {
            const districts = await fetchJSON(API + '/api/districts');
            const sel = document.getElementById('dist_code');
            districts.forEach(d => {
                const o = document.createElement('option');
                o.value = d.dist_code;
                o.textContent = d.dist_name;
                sel.appendChild(o);
            });
        }

        async function loadItis() {
            const dist_code = document.getElementById('dist_code').value;
            const itiSel    = document.getElementById('iti_code');
            const tradeSel  = document.getElementById('trade_code');

            itiSel.innerHTML   = '<option value="">-- Select ITI --</option>';
            tradeSel.innerHTML = '<option value="">-- Select Trade --</option>';
            if (!dist_code) return;

            const itis = await fetchJSON(API + '/api/itis?dist_code=' + encodeURIComponent(dist_code));
            itis.forEach(i => {
                const o = document.createElement('option');
                o.value = i.iti_code;
                o.textContent = i.iti_name;
                itiSel.appendChild(o);
            });
        }

        async function loadTrades() {
            const iti_code = document.getElementById('iti_code').value;
            const tradeSel = document.getElementById('trade_code');

            tradeSel.innerHTML = '<option value="">-- Select Trade --</option>';
            if (!iti_code) return;

            const trades = await fetchJSON(API + '/api/trades?iti_code=' + encodeURIComponent(iti_code));
            trades.forEach(t => {
                const o = document.createElement('option');
                o.value = t.trade_code;
                o.textContent = t.trade_name;
                tradeSel.appendChild(o);
            });
        }

        async function loadMetadata() {
            const data = await fetchJSON(API + '/api/metadata');
            const yearSel  = document.getElementById('year');
            const phaseSel = document.getElementById('phase');
            const levelSel = document.getElementById('mode_adm');

            (data.years  || []).forEach(y => {
                const o = document.createElement('option');
                o.value = o.textContent = y;
                yearSel.appendChild(o);
            });
            (data.phases || []).forEach(p => {
                const o = document.createElement('option');
                o.value = o.textContent = p;
                phaseSel.appendChild(o);
            });
            (data.levels || []).forEach(l => {
                const o = document.createElement('option');
                o.value = o.textContent = l;
                levelSel.appendChild(o);
            });
        }

        function resetForm() {
            document.getElementById('selectionForm').reset();
            document.getElementById('iti_code').innerHTML   = '<option value="">-- Select ITI --</option>';
            document.getElementById('trade_code').innerHTML = '<option value="">-- Select Trade --</option>';
        }

        window.onload = () => {
            loadDistricts();
            loadMetadata();
        };
    </script>
</body>
</html>
