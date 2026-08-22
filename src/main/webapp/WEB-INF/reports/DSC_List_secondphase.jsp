<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DSC List | ITI Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .form-label-official { font-size: 0.85rem; font-weight: 700; color: #445566; text-transform: uppercase; letter-spacing: 0.8px; display: block; }
        .form-select-official, .form-control-official { border: 1px solid #ced4da; border-radius: 6px; padding: 10px 15px; font-size: 1.05rem; color: #2d3748; background-color: #ffffff; transition: border-color 0.2s ease; width: 100%; }
        .form-select-official:focus, .form-control-official:focus { border-color: #003366; outline: none; box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1); }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 12px; padding: 12px 8px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 8px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .category-header { background-color: #f1f5f9; padding: 10px; border-left: 4px solid #003366; margin-top: 20px; margin-bottom: 10px; font-weight: 700; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .dataTables_wrapper .dataTables_length,
        .dataTables_wrapper .dataTables_filter,
        .dataTables_wrapper .dataTables_info,
        .dataTables_wrapper .dataTables_paginate { margin: 10px 0; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="dsc_list" />
    <%@ include file="iti_navbar.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>DSC List</h2></div>

    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 650px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;"><i class="fas fa-filter me-2"></i> Selection Criteria</div>
            <div class="p-4 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event)">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label-official">ITI Name</label>
                            <select name="iti_code" id="iti_code" class="form-select-official" required>
                                <option value="">Select ITI</option>
                            </select>
                        </div>
                        <div class="col-md-6 mt-3 mt-md-0">
                            <label class="form-label-official">Trade</label>
                            <select name="trade_code" id="trade_code" class="form-select-official" required>
                                <option value="">Select Trade</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label-official">Phase</label>
                            <select name="phase" id="phase" class="form-select-official" required>
                                <option value="">-select-</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="All">All</option>
                            </select>
                        </div>
                        <div class="col-md-4 mt-3 mt-md-0">
                            <label class="form-label-official">Year</label>
                            <select name="year" id="year" class="form-select-official" required>
                                <option value="">-select-</option>
                                <option value="2025" selected>2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                                <option value="2022">2022</option>
                                <option value="2021">2021</option>
                            </select>
                        </div>
                        <div class="col-md-4 mt-3 mt-md-0">
                            <label class="form-label-official">Admission Performed in Level</label>
                            <select name="level" id="level" class="form-select-official" required>
                                <option value="">-select-</option>
                                <option value="dist_code">Convener</option>
                                <option value="iti_code">ITI</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-4 text-center">
                        <button type="submit" class="btn-submit-official-navy"><i class="fas fa-search me-2"></i>VIEW REPORT</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Generating DSC List...</p>
    </div>

    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold" onclick="showSelection()">
                <i class="fas fa-arrow-left me-2"></i> BACK TO SELECTION
            </button>
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="dscTable" style="min-width: 900px;">
                    <thead>
                        <tr>
                            <th>Sl NO</th>
                            <th>RANK</th>
                            <th>Admission Number</th>
                            <th>Name</th>
                            <th>Father Name</th>
                            <th>Gender</th>
                            <th>Date of Birth</th>
                            <th>caste</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        let dataTable;

        function showSelection() {
            document.getElementById('reportView').style.display = 'none';
            document.getElementById('selectionView').style.display = 'block';
        }

        function loadOptions() {
            return fetch('${backendApiUrl}/dsc-options', { credentials: 'include' })
                .then(r => r.json())
                .then(data => {
                    const itiSelect = document.getElementById('iti_code');
                    const tradeSelect = document.getElementById('trade_code');
                    itiSelect.innerHTML = '<option value="">Select ITI</option>';
                    tradeSelect.innerHTML = '<option value="">Select Trade</option>';
                    if (data.itis && data.itis.length > 0) {
                        data.itis.forEach(iti => {
                            itiSelect.innerHTML += '<option value="' + iti.iti_code + '">' + iti.iti_name + '</option>';
                        });
                    }
                    if (data.trades && data.trades.length > 0) {
                        data.trades.forEach(trade => {
                            tradeSelect.innerHTML += '<option value="' + trade.trade_code + '">' + trade.trade_name + '</option>';
                        });
                    }
                })
                .catch(err => console.error('Failed to load options:', err));
        }

        function fetchReport(event) {
            event.preventDefault();
            const iti_code = document.getElementById('iti_code').value;
            const trade_code = document.getElementById('trade_code').value;
            const phase = document.getElementById('phase').value;
            const year = document.getElementById('year').value;
            const level = document.getElementById('level').value;

            if (!iti_code || !trade_code || !phase || !year || !level) {
                alert('Please select all fields');
                return;
            }

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            const modeAdm = level === 'dist_code' ? 'CONVENER' : 'ITI';

            fetch('${backendApiUrl}/dsc-full?distCode=' + encodeURIComponent('ALL') + '&itiCode=' + encodeURIComponent(iti_code) + '&tradeCode=' + encodeURIComponent(trade_code) + '&phase=' + encodeURIComponent(phase) + '&year=' + encodeURIComponent(year) + '&modeAdm=' + encodeURIComponent(modeAdm), {
                method: 'GET'
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';

                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = '';

                if (data.error || !data.categories || data.categories.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="8" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                    return;
                }

                let slNo = 1;
                data.categories.forEach(cat => {
                    if (cat.candidates && cat.candidates.length > 0) {
                        const headerRow = document.createElement('tr');
                        headerRow.innerHTML = '<td colspan="8" class="category-header">Category : ' + (cat.category_code || 'Unknown') + ' Strength (' + (cat.strength || 0) + ') Strength Fill (' + (cat.filled || 0) + ') and Strength Vacant (' + (cat.vacant || 0) + ')</td>';
                        tbody.appendChild(headerRow);

                        cat.candidates.forEach(cand => {
                            const tr = document.createElement('tr');
                            tr.innerHTML =
                                '<td>' + (slNo++) + '</td>' +
                                '<td>' + (cand.rank != null ? cand.rank : 'null') + '</td>' +
                                '<td>' + (cand.admission_number || '-') + '</td>' +
                                '<td style="text-align: left;">' + (cand.name || '-') + '</td>' +
                                '<td style="text-align: left;">' + (cand.father_name || '-') + '</td>' +
                                '<td>' + (cand.gender || '-') + '</td>' +
                                '<td>' + (cand.date_of_birth || '-') + '</td>' +
                                '<td>' + (cand.caste || '-') + '</td>';
                            tbody.appendChild(tr);
                        });
                    }
                });

                if (dataTable) {
                    dataTable.destroy();
                }
                dataTable = $('#dscTable').DataTable({
                    dom: 'T<"clear">lfrtip',
                    pageLength: 50,
                    order: [[0, 'asc']]
                });
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }

        document.addEventListener('DOMContentLoaded', function() {
            fetch('${backendApiUrl}/current-admission-phase')
                .then(r => r.json())
                .then(config => {
                    const year = config.year || String(new Date().getFullYear());
                    const phase = config.phase || '';
                    const yearSelect = document.getElementById('year');
                    const phaseSelect = document.getElementById('phase');
                    if (yearSelect) yearSelect.value = year;
                    if (phaseSelect && phase) phaseSelect.value = String(phase);
                    return loadOptions();
                })
                .catch(err => {
                    console.error('Failed to load current phase:', err);
                    return loadOptions();
                });
        });
    </script>
</body>
</html>
