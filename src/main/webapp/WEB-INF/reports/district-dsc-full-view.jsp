<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DSC Full Report | District Reports</title>
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
        .form-control-official, .form-select-official { border: 1px solid #ced4da; border-radius: 6px; padding: 10px 15px; font-size: 1.05rem; color: #2d3748; background-color: #ffffff; transition: border-color 0.2s ease; width: 100%; }
        .form-control-official:focus, .form-select-official:focus { border-color: #003366; outline: none; box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1); }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        
        /* DSC Specific Styles */
        .category-header { background-color: #f1f5f9; padding: 10px; border-left: 4px solid #003366; margin-top: 20px; margin-bottom: 10px; font-weight: 700; display: flex; justify-content: space-between; }
        .meta-info { display: flex; flex-wrap: wrap; gap: 20px; background: #f8fbff; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #e1ecf8; }
        .meta-item { display: flex; flex-direction: column; }
        .meta-label { font-size: 0.8rem; color: #64748b; font-weight: 700; text-transform: uppercase; }
        .meta-value { font-size: 1.1rem; color: #0f172a; font-weight: 600; }
    </style>
</head>
<body class="nodal-body">
    <header class="fixed-top-header">
        <%@ include file="../bannernew.jsp" %>
    </header>
    <c:set var="activeTab" value="dsc_full" />
    <%@ include file="../district_navbar.jsp" %>
    
    <div class="nodal-page-title-dashboard">
        <h2>District Selection Committee (DSC) Report</h2>
    </div>

    <!-- SELECTION VIEW -->
    <div class="container mt-4" id="selectionView" style="display: none;">
        <p class="text-center">Loading DSC Report...</p>
    </div>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Generating DSC Report...</p>
    </div>

    <!-- REPORT VIEW -->
    <div class="container mt-4" id="reportView" style="display: none;">
        
        <div class="no-print d-flex justify-content-center gap-3 mb-4">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()">
                <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>

        <div class="shadow" style="background-color: #fff; border-radius: 8px; padding: 20px; border: 1px solid #e0e0e0;">
            <div id="reportContent">
                <!-- Metadata header will be injected here -->
            </div>
            
            <div id="categoriesContainer" class="mt-4">
                <!-- Categories and tables will be injected here -->
            </div>
        </div>
    </div>

    <script>
        function showSelection() {
            window.location.reload();
        }

        function fetchReport() {
            const iti_code = 'All';
            const trade_code = 'All';
            const year = '2024';
            const phase = '1';
            const mode_adm = 'CONVENER';

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            fetch('${backendApiUrl}/dsc-full?distCode=' + encodeURIComponent("ALL") + '&itiCode=' + encodeURIComponent(iti_code) + '&tradeCode=' + encodeURIComponent(trade_code) + '&phase=' + encodeURIComponent(phase) + '&year=' + encodeURIComponent(year) + '&modeAdm=' + encodeURIComponent(mode_adm), {
                method: 'GET'
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                
                if(data.error) {
                    alert("Error: " + data.error);
                    showSelection();
                    return;
                }

                document.getElementById('reportView').style.display = 'block';
                
                // Render Meta Info
                const meta = data.meta || {};
                const iti = data.iti || {};
                const trade = data.trade || {};
                
                let metaHtml = '
                    <div class="text-center mb-4">
                        <h3 class="fw-bold" style="color: #003366;">\' + (meta.selection_type || 'DSC Report') + '</h3>
                        <h5 class="text-muted">SESSION: \' + (meta.session || '') + ' - Phase \' + (meta.phase || '') + '</h5>
                    </div>
                    <div class="meta-info">
                        <div class="meta-item"><span class="meta-label">District</span><span class="meta-value">\' + (meta.dist_code || 'N/A') + '</span></div>
                        <div class="meta-item"><span class="meta-label">ITI Code & Name</span><span class="meta-value">\' + (iti.iti_code || '') + ' - \' + (iti.iti_name || 'N/A') + '</span></div>
                        <div class="meta-item"><span class="meta-label">Trade</span><span class="meta-value">\' + (trade.trade_code || '') + ' - \' + (trade.trade_name || 'N/A') + '</span></div>
                        <div class="meta-item"><span class="meta-label">Total Trade Strength</span><span class="meta-value">\' + (trade.total_strength || 0) + '</span></div>
                    </div>
                ';
                document.getElementById('reportContent').innerHTML = metaHtml;

                // Render Categories
                let catHtml = '';
                if(data.categories && data.categories.length > 0) {
                    data.categories.forEach(cat => {
                        catHtml += '
                            <div class="category-header">
                                <span>Category: \' + (cat.category_code) + '</span>
                                <span>Strength: \' + (cat.strength) + ' | Filled: \' + (cat.filled) + ' | Vacant: \' + (cat.vacant) + '</span>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-sm table-hover text-center report-table">
                                    <thead>
                                        <tr>
                                            <th style="width: 50px;">Rank</th>
                                            <th>Admission No</th>
                                            <th>Candidate Name</th>
                                            <th>Father Name</th>
                                            <th>Gender</th>
                                            <th>DOB</th>
                                            <th>Caste</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                        ';
                        if(cat.candidates && cat.candidates.length > 0) {
                            cat.candidates.forEach(cand => {
                                const isVacant = cand.admission_number === 'VACANT';
                                catHtml += '
                                    <tr style="\' + (isVacant ? 'background-color: #fff5f5; color: #dc3545;' : '') + '">
                                        <td>\' + (cand.rank || '-') + '</td>
                                        <td style="font-weight: \${isVacant ? 'bold' : 'normal'};\${isVacant ? 'color: #dc3545;' : ''}">\' + (cand.admission_number || '-') + '</td>
                                        <td style="text-align: left; padding-left: 10px;">\' + (cand.name || '-') + '</td>
                                        <td style="text-align: left; padding-left: 10px;">\' + (cand.father_name || '-') + '</td>
                                        <td>\' + (cand.gender || '-') + '</td>
                                        <td>\' + (cand.date_of_birth || '-') + '</td>
                                        <td>\' + (cand.caste || '-') + '</td>
                                    </tr>
                                ';
                            });
                        } else {
                            catHtml += '<tr><td colspan="7" class="text-muted">No candidates</td></tr>';
                        }
                        catHtml += '</tbody></table></div>';
                    });
                } else {
                    catHtml = '<div class="alert alert-info">No category data found for this selection.</div>';
                }
                document.getElementById('categoriesContainer').innerHTML = catHtml;
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }

        document.addEventListener('DOMContentLoaded', fetchReport);
    </script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
