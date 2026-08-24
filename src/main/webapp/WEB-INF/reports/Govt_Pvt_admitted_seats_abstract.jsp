<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Government/Private Admissions Seats Abstract Report | State Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .nodal-page-title-dashboard { text-align: center; padding: 30px 0; color: #003366; font-weight: 800; background: #f8fbff; border-bottom: 1px solid #e1ecf8; margin-bottom: 40px; }
        .nodal-page-title-dashboard h2 { margin: 0; font-size: 1.6rem; letter-spacing: 0.5px; }
        .report-table th { font-size: 12px; padding: 12px 5px; background: #0f2c4e !important; color: white !important; text-transform: uppercase; position: sticky; top: 0; z-index: 10; }
        .report-table td { font-size: 13px; padding: 10px 5px; border-bottom: 1px solid #f0f0f0; font-weight: 500; color: #1e293b; }
        .loader-spinner { display: none; text-align: center; padding: 40px; color: #003366; }
        .num { text-align: center; font-weight: 700 !important; }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>
    <c:set var="activeTab" value="iti_admissions" />
    <%@ include file="state_navbar.jsp" %>
    <div class="nodal-page-title-dashboard"><h2>Government/Private Admissions Seats Abstract Report</h2></div>

    <form method="post" action="Govt_Pvt_admitted_seats_abstract.jsp" onsubmit="return validate()">
        <br>
            <table align="center" bgcolor="#e4eeb9" id="tot">
                <tr>
                    <td>Select Year</td>
                    <td>
                        <select name="year" id="year">
                            <option value="">-select-</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                            <option value="2025" selected>2025</option>
                            <option value="2026">2026</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>Select Govt/Pvt</td>
                    <td>
                        <select name="govt" id="govt">
                            <option value="">-select-</option>
                            <option value="All">All</option>
                            <option value="G">Govt</option>
                            <option value="P">Pvt</option>
                        </select>
                    </td>
                    <tr>
                        <td align="center" colspan="2">
                            <input type="submit" name="submit" id="submit" value="submit"/>
                        </td>
                    </tr>
                </tr>

                </table>
                </form>

    <div class="loader-spinner" id="loader"><i class="fas fa-spinner fa-spin fa-3x"></i><p class="mt-3 fw-bold">Loading admitted seats abstract...</p></div>
    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        <div class="no-print d-flex justify-content-center gap-3 mb-5">
            <button class="btn text-white fw-bold shadow-sm px-4 rounded-pill" onclick="window.print()" style="background-color: #337ab7;"><i class="fas fa-print me-2"></i>PRINT REPORT</button>
        </div>
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="tabcolor" style="min-width: 1000px;">
                    <thead><tr><th>SNO</th><th>ITI Code</th><th>ITI Name</th><th>Strength</th><th>Fill</th><th>Vacant</th></tr></thead>
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

        function validate() {
            var year = document.getElementById("year").value;
            if (year === null || year === "") {
                document.getElementById("year").focus();
                alert("please fill Select Year");
                return false;
            }
            var govt = document.getElementById("govt").value;
            if (govt === null || govt === "") {
                document.getElementById("govt").focus();
                alert("please fill Select Govt/Pvt");
                return false;
            }
            return true;
        }

        function loadReport() {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('reportView').style.display = 'none';

            const year = document.getElementById('year').value;
            const govt = document.getElementById('govt').value;

            fetch('${backendApiUrl}/govt-pvt-seats?year=' + encodeURIComponent(year) + '&govt=' + encodeURIComponent(govt), { method: 'GET' })
            .then(response => response.json())
            .then(response => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';

                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = '';

                const data = response.data || [];
                if (data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="6" style="text-align:center; padding:20px; font-weight: bold;">No records found.</td></tr>';
                    return;
                }

                data.forEach((row, index) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (index + 1) + '</td>' +
                        '<td>' + (row.itiCode || '-') + '</td>' +
                        '<td style="text-align: left;">' + (row.itiName || '-') + '</td>' +
                        '<td>' + (row.strength || 0) + '</td>' +
                        '<td>' + (row.filled || 0) + '</td>' +
                        '<td>' + (row.vacant || 0) + '</td>';
                    tbody.appendChild(tr);
                });

                if (dataTable) {
                    dataTable.destroy();
                }
                dataTable = $('#tabcolor').DataTable({
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
    </script>
</body>
</html>
