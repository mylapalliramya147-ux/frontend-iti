<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI-Wise Admission Status Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .report-table th { font-size: 12px; padding: 12px 8px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 8px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .num { text-align: center; font-weight: 700 !important; }
        .dataTables_wrapper .dataTables_length,
        .dataTables_wrapper .dataTables_filter,
        .dataTables_wrapper .dataTables_info,
        .dataTables_wrapper .dataTables_paginate { margin: 10px 0; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="iti_status" />
    <%@ include file="../iti_navbar.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>Industrial Training Institute — ITI-Wise Status Report</h2></div>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Loading ITI status...</p>
    </div>

    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="statusTable" style="min-width: 1200px;">
                    <thead>
                        <tr>
                            <th>Sl No</th>
                            <th>District Name</th>
                            <th>ITI Name</th>
                            <th>ITI Code</th>
                            <th class="num">Total</th>
                            <th class="num">Success</th>
                            <th class="num">Pending status from SID</th>
                            <th class="num">Verified</th>
                            <th class="num">To be Verified</th>
                            <th class="num">To be Updated</th>
                            <th class="num">Phone Duplicate Records</th>
                            <th class="num">Email Duplicate Records</th>
                            <th class="num">Aadhar Duplicate Records</th>
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
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        let dataTable;

        function loadReport(year, phase) {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('reportView').style.display = 'none';

            fetch('${backendApiUrl}/iti-wise-status?distCode=All&itiCode=All&page=0&size=10000&year=' + year + '', {
                method: 'GET'
            })
            .then(response => response.json())
            .then(response => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';

                const tbody = document.getElementById('tableBody');
                const tfoot = document.getElementById('tableFoot');
                tbody.innerHTML = '';
                tfoot.innerHTML = '';

                const data = response.data || [];
                if (data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="13" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                    return;
                }

                let totals = { total: 0, success: 0, pendingSid: 0, verified: 0, toBeVerified: 0, toBeUpdated: 0, phone: 0, email: 0, aadhar: 0 };
                data.forEach((row, index) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (index + 1) + '</td>' +
                        '<td style="text-align: left;">' + (row.distName || '-') + '</td>' +
                        '<td style="text-align: left;">' + (row.itiName || '-') + '</td>' +
                        '<td>' + (row.itiCode || '-') + '</td>' +
                        '<td class="num">' + (row.total || 0) + '</td>' +
                        '<td class="num text-success">' + (row.success || 0) + '</td>' +
                        '<td class="num text-warning">' + (row.pendingSid || 0) + '</td>' +
                        '<td class="num text-primary">' + (row.verified || 0) + '</td>' +
                        '<td class="num text-danger">' + (row.toBeVerified || 0) + '</td>' +
                        '<td class="num">' + (row.toBeUpdated || 0) + '</td>' +
                        '<td class="num text-danger">' + (row.phoneDuplicateRecords || 0) + '</td>' +
                        '<td class="num text-danger">' + (row.emailDuplicateRecords || 0) + '</td>' +
                        '<td class="num text-danger">' + (row.aadharDuplicateRecords || 0) + '</td>';
                    tbody.appendChild(tr);
                    totals.total += row.total || 0; totals.success += row.success || 0; totals.pendingSid += row.pendingSid || 0; totals.verified += row.verified || 0; totals.toBeVerified += row.toBeVerified || 0; totals.toBeUpdated += row.toBeUpdated || 0; totals.phone += row.phoneDuplicateRecords || 0; totals.email += row.emailDuplicateRecords || 0; totals.aadhar += row.aadharDuplicateRecords || 0;
                });

                const ft = document.createElement('tr'); ft.className = 'total-row';
                ft.innerHTML = '<td colspan="4" style="text-align: right; padding-right: 30px; font-weight: bold;">GRAND TOTAL</td><td class="num">' + totals.total + '</td><td class="num">' + totals.success + '</td><td class="num">' + totals.pendingSid + '</td><td class="num">' + totals.verified + '</td><td class="num">' + totals.toBeVerified + '</td><td class="num">' + totals.toBeUpdated + '</td><td class="num">' + totals.phone + '</td><td class="num">' + totals.email + '</td><td class="num">' + totals.aadhar + '</td>';
                tfoot.appendChild(ft);

                if (dataTable) {
                    dataTable.destroy();
                }
                dataTable = $('#statusTable').DataTable({
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
                    loadReport(year, phase);
                })
                .catch(err => {
                    console.error('Failed to load current phase:', err);
                    loadReport(String(new Date().getFullYear()), '');
                });
        });

    </script>
</body>
</html>
