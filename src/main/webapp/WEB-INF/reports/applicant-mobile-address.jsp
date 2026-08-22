<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applicant Address With Mobile | Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.dataTables.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .report-table th { font-size: 12px; padding: 12px 8px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 8px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
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
    <c:set var="activeTab" value="applicant_mobile" />
    <%@ include file="district_navbar.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>Applicant Address With Mobile</h2></div>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Loading applicant data...</p>
    </div>

    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;">
                <i class="fas fa-print me-2"></i>PRINT REPORT
            </button>
        </div>
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="applicantTable" style="min-width: 1000px;">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>SSC Hallticket</th>
                            <th>Mobile No</th>
                            <th>Reg Id</th>
                            <th>Name</th>
                            <th>Father Name</th>
                            <th>Mother Name</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
    <script>
        let dataTable;

        function loadReport() {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('reportView').style.display = 'none';

            fetch('${backendApiUrl}/applicant-mobile-address?page=0&size=10000', {
                method: 'GET'
            })
            .then(response => response.json())
            .then(response => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';

                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = '';

                const data = response.data || [];
                if (data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="7" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                    return;
                }

                data.forEach((row, index) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (index + 1) + '</td>' +
                        '<td>' + (row.sscRegno || '-') + '</td>' +
                        '<td>' + (row.mobile || '-') + '</td>' +
                        '<td>' + (row.regId || '-') + '</td>' +
                        '<td style="text-align: left;">' + (row.name || '-') + '</td>' +
                        '<td style="text-align: left;">' + (row.fatherName || '-') + '</td>' +
                        '<td style="text-align: left;">' + (row.motherName || '-') + '</td>';
                    tbody.appendChild(tr);
                });

                if (dataTable) {
                    dataTable.destroy();
                }
                dataTable = $('#applicantTable').DataTable({
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

        document.addEventListener('DOMContentLoaded', loadReport);
    </script>
</body>
</html>
