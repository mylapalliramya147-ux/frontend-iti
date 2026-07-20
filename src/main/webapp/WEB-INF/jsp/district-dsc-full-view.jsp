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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
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
        <%@ include file="bannernew.jsp" %>
    </header>
    <c:set var="activeTab" value="dsc_full" />
    <%@ include file="district_navbar.jsp" %>
    
    <div class="nodal-page-title-dashboard">
        <h2>District Selection Committee (DSC) Report</h2>
    </div>

    <!-- SELECTION VIEW -->
    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 650px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;">
                <i class="fas fa-filter me-2"></i> Selection Criteria
            </div>
            <div class="p-4 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event)">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label-official">ITI Code</label>
                            <select name="iti_code" id="iti_code" class="form-select-official" required>
                                <option value="">Select ITI</option>
                            </select>
                        </div>
                        <div class="col-md-6 mt-3 mt-md-0">
                            <label class="form-label-official">Trade Code</label>
                            <select name="trade_code" id="trade_code" class="form-select-official" required>
                                <option value="">Select Trade</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label-official">Year</label>
                            <select name="year" id="year" class="form-select-official" required>
                                <option value="2025">2025</option>
                                <option value="2024" selected>2024</option>
                                <option value="2023">2023</option>
                                <option value="2022">2022</option>
                                <option value="2021">2021</option>
                            </select>
                        </div>
                        <div class="col-md-4 mt-3 mt-md-0">
                            <label class="form-label-official">Phase</label>
                            <select name="phase" id="phase" class="form-select-official" required>
                                <option value="1">Phase 1</option>
                                <option value="2">Phase 2</option>
                                <option value="3">Phase 3</option>
                                <option value="4">Phase 4</option>
                                <option value="5">Phase 5</option>
                            </select>
                        </div>
                        <div class="col-md-4 mt-3 mt-md-0">
                            <label class="form-label-official">Admission Mode</label>
                            <select name="mode_adm" id="mode_adm" class="form-select-official" required>
                                <option value="CONVENER">Convener</option>
                                <option value="MANAGEMENT">Management</option>
                                <option value="SPOT">Spot</option>
                            </select>
                        </div>
                    </div>

                    <div class="mt-4 text-center">
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
        <p class="mt-3 fw-bold">Generating DSC Report...</p>
    </div>

    <!-- REPORT VIEW -->
    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        
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
            document.getElementById('reportView').style.display = 'none';
            document.getElementById('selectionView').style.display = 'block';
        }

        function fetchReport(event) {
            event.preventDefault();
            const iti_code = document.getElementById('iti_code').value;
            const trade_code = document.getElementById('trade_code').value;
            const year = document.getElementById('year').value;
            const phase = document.getElementById('phase').value;
            const mode_adm = document.getElementById('mode_adm').value;

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            fetch('${backendApiUrl}/dsc-full?distCode=ALL&itiCode=' + encodeURIComponent(iti_code) + '&tradeCode=' + encodeURIComponent(trade_code) + '&phase=' + encodeURIComponent(phase) + '&year=' + encodeURIComponent(year) + '&modeAdm=' + encodeURIComponent(mode_adm), {
                method: 'GET', headers: { 'Content-Type': 'application/json' }
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
                
                let metaHtml = `
                    <div class="text-center mb-4">
                        <h3 class="fw-bold" style="color: #003366;">\${meta.selection_type || 'DSC Report'}</h3>
                        <h5 class="text-muted">SESSION: \${meta.session || ''} - Phase \${meta.phase || ''}</h5>
                    </div>
                    <div class="meta-info">
                        <div class="meta-item"><span class="meta-label">District</span><span class="meta-value">\${meta.dist_code || 'N/A'}</span></div>
                        <div class="meta-item"><span class="meta-label">ITI Code & Name</span><span class="meta-value">\${iti.iti_code || ''} - \${iti.iti_name || 'N/A'}</span></div>
                        <div class="meta-item"><span class="meta-label">Trade</span><span class="meta-value">\${trade.trade_code || ''} - \${trade.trade_name || 'N/A'}</span></div>
                        <div class="meta-item"><span class="meta-label">Total Trade Strength</span><span class="meta-value">\${trade.total_strength || 0}</span></div>
                    </div>
                `;
                document.getElementById('reportContent').innerHTML = metaHtml;

                // Render Categories
                let catHtml = '';
                if(data.categories && data.categories.length > 0) {
                    data.categories.forEach(cat => {
                        catHtml += `
                            <div class="category-header">
                                <span>Category: \${cat.category_code}</span>
                                <span>Strength: \${cat.strength} | Filled: \${cat.filled} | Vacant: \${cat.vacant}</span>
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
                        `;
                        if(cat.candidates && cat.candidates.length > 0) {
                            cat.candidates.forEach(cand => {
                                const isVacant = cand.admission_number === 'VACANT';
                                catHtml += `
                                    <tr style="\${isVacant ? 'background-color: #fff5f5; color: #dc3545;' : ''}">
                                        <td>\${cand.rank || '-'}</td>
                                        <td style="font-weight: \${isVacant ? 'bold' : 'normal'};\${isVacant ? 'color: #dc3545;' : ''}">\${cand.admission_number || '-'}</td>
                                        <td style="text-align: left; padding-left: 10px;">\${cand.name || '-'}</td>
                                        <td style="text-align: left; padding-left: 10px;">\${cand.father_name || '-'}</td>
                                        <td>\${cand.gender || '-'}</td>
                                        <td>\${cand.date_of_birth || '-'}</td>
                                        <td>\${cand.caste || '-'}</td>
                                    </tr>
                                `;
                            });
                        } else {
                            catHtml += `<tr><td colspan="7" class="text-muted">No candidates</td></tr>`;
                        }
                        catHtml += `</tbody></table></div>`;
                    });
                } else {
                    catHtml = '<div class="alert alert-info">No category data found for this selection.</div>';
                }
                document.getElementById('categoriesContainer').innerHTML = catHtml;
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('selectionView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            console.log('Fetching DSC options...');
            let localDistCode = '';
            try {
                localDistCode = localStorage.getItem('insCode') || '';
            } catch (e) {
                console.warn('localStorage not available:', e);
            }
            const url = '${backendApiUrl}/dsc-options' + (localDistCode ? '?dist_code=' + localDistCode : '');
            
            fetch(url, { credentials: 'include' })
                .then(response => {
                    console.log('DSC options response status:', response.status);
                    if (!response.ok) throw new Error('HTTP error ' + response.status);
                    return response.json();
                })
                .then(data => {
                    console.log('DSC options data received:', data);
                    const itiSelect = document.getElementById('iti_code');
                    const tradeSelect = document.getElementById('trade_code');
                    
                    if (data.itis && data.itis.length > 0) {
                        data.itis.forEach(iti => {
                            const option = document.createElement('option');
                            option.value = iti.iti_code;
                            option.textContent = iti.iti_code + ' - ' + iti.iti_name;
                            itiSelect.appendChild(option);
                        });
                        console.log('Populated ' + data.itis.length + ' ITIs');
                    } else {
                        console.warn('No ITIs found in options data');
                    }
                    
                    if (data.trades && data.trades.length > 0) {
                        data.trades.forEach(trade => {
                            const option = document.createElement('option');
                            option.value = trade.trade_code;
                            option.textContent = trade.trade_code + ' - ' + trade.trade_name;
                            tradeSelect.appendChild(option);
                        });
                        console.log('Populated ' + data.trades.length + ' trades');
                    } else {
                        console.warn('No trades found in options data');
                        tradeSelect.innerHTML = '<option value="">No trades available</option>';
                    }

                    if (itiSelect && tradeSelect) {
                        itiSelect.addEventListener('change', () => {
                            const selectedIti = itiSelect.value;
                            tradeSelect.innerHTML = '<option value="">Select Trade</option>';
                            
                            let fetchUrl = '${backendApiUrl}/dsc-options?dist_code=' + localDistCode;
                            if (selectedIti) {
                                fetchUrl += '&iti_code=' + selectedIti;
                            }
                            
                            fetch(fetchUrl, { credentials: 'include' })
                                .then(response => {
                                    if (!response.ok) throw new Error('HTTP error ' + response.status);
                                    return response.json();
                                })
                                .then(filteredData => {
                                    if (filteredData.trades && filteredData.trades.length > 0) {
                                        filteredData.trades.forEach(trade => {
                                            const option = document.createElement('option');
                                            option.value = trade.trade_code;
                                            option.textContent = trade.trade_code + ' - ' + trade.trade_name;
                                            tradeSelect.appendChild(option);
                                        });
                                        console.log('Populated ' + filteredData.trades.length + ' filtered trades');
                                    } else {
                                        tradeSelect.innerHTML = '<option value="">No trades available</option>';
                                    }
                                })
                                .catch(error => {
                                    console.error('Error fetching filtered trades:', error);
                                    tradeSelect.innerHTML = '<option value="">Error loading trades</option>';
                                });
                        });
                    }
                })
                .catch(error => {
                    console.error('Error fetching options:', error);
                    const tradeSelect = document.getElementById('trade_code');
                    if (tradeSelect) {
                        tradeSelect.innerHTML = '<option value="">Error loading options</option>';
                    }
                    alert('Failed to load selection options. Please ensure you are logged in and the backend is running.');
                });
        });
    








</script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
