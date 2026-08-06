<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trade Display - Districts</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <style>
        .nodal-page-title { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .total-row { background-color: #f1f5f9 !important; font-weight: 700; }
    </style>
</head>
<body class="nodal-body">
    <%@ include file="header.jsp" %>
    <div class="nodal-page-title">
        <h2>Trade Display - Districts</h2>
    </div>

    <div class="container mt-4">
        <div class="shadow" style="background-color: #fff; border-radius: 8px; padding: 20px; border: 1px solid #e0e0e0;">
            <div class="table-responsive">
                <table class="table table-bordered table-sm table-hover text-center report-table" id="reportTable">
                    <thead>
                        <tr>
                            <th>District Code</th>
                            <th>District Name</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                    <tfoot id="tableFoot"></tfoot>
                </table>
            </div>
        </div>
    </div>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Loading Districts...</p>
    </div>

    <script>

        document.addEventListener('DOMContentLoaded', () => {
            const tbody = document.getElementById('tableBody');
            const tfoot = document.getElementById('tableFoot');
            const loader = document.getElementById('loader');

            loader.style.display = 'block';

            fetch('${backendApiUrl}/trade-display/districts', {
                method: 'GET', headers: { 'Content-Type': 'application/json' }
            })
            .then(response => {
                loader.style.display = 'none';
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                tbody.innerHTML = '';
                tfoot.innerHTML = '';

                if (data.data && data.data.length > 0) {
                    data.data.forEach(row => {
                        const tr = document.createElement('tr');
                        tr.innerHTML = `
                            <td>\${row.code || '-'}</td>
                            <td style="text-align: left;">\${row.name || '-'}</td>
                        `;
                        tbody.appendChild(tr);
                    });

                    const ft = document.createElement('tr');
                    ft.className = 'total-row';
                    ft.innerHTML = `
                        <td colspan="2" style="text-align: center; padding: 15px; font-weight: bold;">
                            Total Districts: \${data.data.length}
                        </td>
                    `;
                    tfoot.appendChild(ft);
                } else {
                    tbody.innerHTML = '<tr><td colspan="2" style="text-align:center; padding:20px; font-weight: bold;">No districts found.</td></tr>';
                }
            })
            .catch(error => {
                loader.style.display = 'none';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        });
    
</script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
