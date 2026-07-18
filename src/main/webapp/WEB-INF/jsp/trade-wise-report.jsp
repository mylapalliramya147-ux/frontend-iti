<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trade Wise Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <style>
        .nodal-page-title { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .nodal-report-card { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1); }
        .nodal-card-header { background: linear-gradient(135deg, #003366 0%, #1a4a72 100%); color: white; padding: 22px 30px; font-weight: 700; display: flex; align-items: center; gap: 15px; }
        .nodal-card-header i { width: 38px; height: 38px; background: rgba(255, 255, 255, 0.2); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 1rem; }
        .form-label-official { font-size: 0.85rem; font-weight: 700; color: #445566; text-transform: uppercase; letter-spacing: 0.8px; display: block; }
        .form-select-official { border: 1px solid #ced4da; border-radius: 6px; padding: 10px 15px; font-size: 1.05rem; color: #2d3748; background-color: #ffffff; transition: border-color 0.2s ease; }
        .form-select-official:focus { border-color: #003366; outline: none; box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1); }
        .btn-submit-official-navy { background-color: #003366; color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; letter-spacing: 0.5px; border: none; transition: all 0.2s ease; }
        .btn-submit-official-navy:hover { background-color: #002244; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2); color: white; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .total-row { background-color: #f1f5f9 !important; font-weight: 700; }
    </style>
</head>
<body class="nodal-body">
    <%@ include file="header.jsp" %>
    <div class="nodal-page-title">
        <h2>Trade Wise Report</h2>
    </div>

    <div class="container mt-4" id="selectionView">
        <div class="nodal-report-card shadow-lg" style="max-width: 500px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header" style="padding: 15px 25px;">
                <i class="fas fa-filter me-2"></i> Select Year
            </div>
            <div class="p-4 bg-white rounded-bottom">
                <form id="reportForm" onsubmit="fetchReport(event)">
                    <div class="mb-3">
                        <label class="form-label-official">Year</label>
                        <select name="year" id="year" class="form-select-official w-100" required>
                            <option value="2025">2025</option>
                            <option value="2024" selected>2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                        </select>
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
        <p class="mt-3 fw-bold">Generating Trade Wise Report...</p>
    </div>

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
            <div class="table-responsive">
                <table class="table table-bordered table-sm table-hover text-center report-table" id="reportTable">
                    <thead>
                        <tr>
                            <th>Trade Name</th>
                            <th>Trade Code</th>
                            <th>Total Strength</th>
                            <th>Filled</th>
                            <th>Vacant</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                    <tfoot id="tableFoot"></tfoot>
                </table>
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
            const year = document.getElementById('year').value;

            document.getElementById('selectionView').style.display = 'none';
            document.getElementById('loader').style.display = 'block';

            fetch('\${backendApiUrl}/trade-wise-report?year=' + encodeURIComponent(year), {
                method: 'GET', headers: { 'Content-Type': 'application/json' }
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loader').style.display = 'none';

                if(data.error) throw new Error(data.error);

                document.getElementById('reportView').style.display = 'block';
                document.getElementById('reportTitle').innerText = 'Trade Wise Report (' + year + ')';

                const tbody = document.getElementById('tableBody');
                const tfoot = document.getElementById('tableFoot');
                tbody.innerHTML = '';
                tfoot.innerHTML = '';

                if (data.data && data.data.length > 0) {
                    let totalStrength = 0, totalFilled = 0, totalVacant = 0;
                    data.data.forEach(row => {
                        const tr = document.createElement('tr');
                        tr.innerHTML = `
                            <td style="text-align: left;">\\${row.tradeName || '-'}</td>
                            <td>\\${row.tradeCode || '-'}</td>
                            <td class="num">\\${row.totalStrength || 0}</td>
                            <td class="num text-success">\\${row.filled || 0}</td>
                            <td class="num text-danger">\\${row.vacant || 0}</td>
                        `;
                        tbody.appendChild(tr);
                        totalStrength += row.totalStrength || 0;
                        totalFilled += row.filled || 0;
                        totalVacant += row.vacant || 0;
                    });

                    const ft = document.createElement('tr');
                    ft.className = 'total-row';
                    ft.innerHTML = `
                        <td colspan="2" style="text-align: right; padding-right: 30px;">GRAND TOTAL</td>
                        <td class="num">\${totalStrength}</td>
                        <td class="num text-success">\${totalFilled}</td>
                        <td class="num text-danger">\${totalVacant}</td>
                    `;
                    tfoot.appendChild(ft);
                } else {
                    tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                }
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('selectionView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }
    


</script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
