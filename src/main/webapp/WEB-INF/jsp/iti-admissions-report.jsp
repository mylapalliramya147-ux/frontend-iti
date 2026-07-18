<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI Admissions | ITI Admissions Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
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
    <%@ include file="header.jsp" %>
    
    <c:set var="activeTab" value="iti_admissions" />
    <%@ include file="nodal_navbar.jsp" %>
    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Industrial Training Institute — ITI Admissions Report</h2>
    </div>

    <div class="container no-print mt-4">
        <div class="nodal-report-card shadow-lg mx-auto" style="max-width: 1000px;">
            <div class="nodal-card-header-dashboard">
                <i class="fas fa-filter me-2"></i> Report Selection Criteria
            </div>
            <div class="p-4 bg-white rounded-bottom">
                <form action="${pageContext.request.contextPath}/nodal-report/reports/iti-admissions-report" method="post" id="reportForm">
                    <div class="row g-4">
                        <div class="col-md-4">
                            <label for="year" class="form-label fw-bold small text-secondary">ADMISSION YEAR *</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-calendar-alt text-primary"></i></span>
                                <select name="year" id="year" class="form-select border-start-0" required>
                                    <option value="">-select-</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="dist_code" class="form-label fw-bold small text-secondary">DISTRICT</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-map-marker-alt text-primary"></i></span>
                                <select name="dist_code" id="dist_code" class="form-select border-start-0">
                                    <option value="All">All Districts</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="govt" class="form-label fw-bold small text-secondary">ITI TYPE</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-building text-primary"></i></span>
                                <select name="govt" id="govt" class="form-select border-start-0">
                                    <option value="All" ${govt == 'All' ? 'selected' : ''}>All Types</option>
                                    <option value="Govt" ${govt == 'Govt' ? 'selected' : ''}>Government</option>
                                    <option value="Pvt" ${govt == 'Pvt' ? 'selected' : ''}>Private</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="caste" class="form-label fw-bold small text-secondary">CASTE CATEGORY</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-users text-primary"></i></span>
                                <select name="caste" id="caste" class="form-select border-start-0">
                                    <option value="All" ${caste == 'All' ? 'selected' : ''}>All Categories</option>
                                    <option value="OC" ${caste == 'OC' ? 'selected' : ''}>OC</option>
                                    <option value="BC-A" ${caste == 'BC-A' ? 'selected' : ''}>BC-A</option>
                                    <option value="BC-B" ${caste == 'BC-B' ? 'selected' : ''}>BC-B</option>
                                    <option value="BC-C" ${caste == 'BC-C' ? 'selected' : ''}>BC-C</option>
                                    <option value="BC-D" ${caste == 'BC-D' ? 'selected' : ''}>BC-D</option>
                                    <option value="BC-E" ${caste == 'BC-E' ? 'selected' : ''}>BC-E</option>
                                    <option value="SC" ${caste == 'SC' ? 'selected' : ''}>SC</option>
                                    <option value="ST" ${caste == 'ST' ? 'selected' : ''}>ST</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="gender" class="form-label fw-bold small text-secondary">GENDER</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-venus-mars text-primary"></i></span>
                                <select name="gender" id="gender" class="form-select border-start-0">
                                    <option value="All" ${gender == 'All' ? 'selected' : ''}>All Genders</option>
                                    <option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="ncvt_scvt" class="form-label fw-bold small text-secondary">ACTIVITY</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-cogs text-primary"></i></span>
                                <select name="ncvt_scvt" id="ncvt_scvt" class="form-select border-start-0">
                                    <option value="All" ${ncvt_scvt == 'All' ? 'selected' : ''}>All Activities</option>
                                    <option value="NCVT" ${ncvt_scvt == 'NCVT' ? 'selected' : ''}>NCVT</option>
                                    <option value="SCVT" ${ncvt_scvt == 'SCVT' ? 'selected' : ''}>SCVT</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="limitRows" class="form-label fw-bold small text-secondary">RECORDS LIMIT</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="fas fa-sort-numeric-up text-primary"></i></span>
                                <select name="limitRows" id="limitRows" class="form-select border-start-0">
                                    <option value="20" ${limitRows == '20' ? 'selected' : ''}>20 Records</option>
                                    <option value="50" ${limitRows == '50' ? 'selected' : ''}>50 Records</option>
                                    <option value="100" ${limitRows == '100' ? 'selected' : ''}>100 Records</option>
                                    <option value="500" ${limitRows == '500' ? 'selected' : ''}>500 Records</option>
                                    <option value="All" ${limitRows == 'All' ? 'selected' : ''}>All Records</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4 text-center">
                        <button type="submit" class="nodal-btn-primary py-3 px-5" style="border-radius: 8px; font-weight: 600; letter-spacing: 1px;">
                            <i class="fas fa-sync-alt me-2"></i> GENERATE REPORT DATA
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Results Section -->
    <c:if test="${not empty reportData}">
        <div id="resultsSection" class="container mt-5 mb-5" style="max-width: 1100px;">
            <div class="text-center mb-4">
                <h4 class="mb-1 fw-bold" style="color: #003366; letter-spacing: 0.5px;">Admissions Report Results</h4>
                <p class="text-muted small mb-3"><i class="fas fa-info-circle me-1"></i> Found ${reportData.size()} records for your selected criteria</p>
                
                <button class="nodal-download-btn-black shadow-sm" style="padding: 12px 35px !important; font-size: 0.85rem !important;" onclick="exportTable('resultsTable')">
                    <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
                </button>
            </div>

            <div class="nodal-report-card shadow">
                <div class="p-0">
                    <table class="nodal-table mb-0" id="resultsTable">
                        <thead>
                            <tr>
                                <th style="width: 25%;">ADMISSION NUMBER</th>
                                <th style="text-align: center;">CANDIDATE NAME</th>
                                <th style="width: 25%;">SSC REG. NUMBER</th>
                                <th style="width: 15%;">YEAR</th>
                            </tr>
                        </thead>
                        <tbody style="font-size: 1.05rem;">
                            <c:forEach items="${reportData}" var="row">
                                <tr style="border-bottom: 1px solid #e2e8f0;">
                                    <td style="font-weight: 800; color: #1e293b;">${row.admission_number}</td>
                                    <td class="text-start" style="padding-left: 35px; color: #003366; font-weight: 800;">${row.name}</td>
                                    <td style="font-weight: 800; color: #1a4a72;">${row.ssc_regno}</td>
                                    <td style="font-weight: 800; color: #64748b;">${row.year_of_admission}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty reportData && not empty year}">
        <div class="text-center mt-5 p-5 bg-white shadow-sm rounded-3">
            <i class="fas fa-search fa-3x text-muted mb-3 opacity-25"></i>
            <p class="text-muted fw-bold">No admission records found for the selected criteria.</p>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="container mt-4">
            <div class="alert alert-danger shadow-sm border-0 d-flex align-items-center">
                <i class="fas fa-exclamation-triangle me-3 fs-4"></i>
                <div>${error}</div>
            </div>
        </div>
    </c:if>

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
            const selectedDist = '${dist_code}';

            districts.forEach(d => {
                const o = document.createElement('option');
                o.value = d.dist_code;
                o.textContent = d.dist_name;
                if (d.dist_code == selectedDist) o.selected = true;
                sel.appendChild(o);
            });

            if (selectedDist && selectedDist !== 'All') {
                // Cascading ITI load removed as requested
            }
        }

        // loadItis and loadTrades removed as requested

        async function loadMetadata() {
            const data = await fetchJSON(API + '/api/metadata');
            const yearSel = document.getElementById('year');
            const selectedYear = '${year}';

            if (data.years && data.years.length > 0) {
                data.years.forEach(y => {
                    const o = document.createElement('option');
                    o.value = y;
                    o.textContent = y;
                    if (y == selectedYear) o.selected = true;
                    yearSel.appendChild(o);
                });
            }
        }

        function exportTable(tableId) {
            const table = document.getElementById(tableId);
            if (!table) {
                alert('No data to export');
                return;
            }
            const html = table.outerHTML;
            const blob = new Blob(['\ufeff', html], { type: 'application/vnd.ms-excel' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'ITI_Admissions_Report.xls';
            a.click();
            URL.revokeObjectURL(url);
        }

        window.onload = () => {
            loadMetadata();
            loadDistricts();
            
            // Auto-scroll to results if present
            const resultsSection = document.getElementById('resultsSection');
            if (resultsSection) {
                setTimeout(() => {
                    resultsSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }, 100);
            }
        };
    </script>
</body>
</html>
