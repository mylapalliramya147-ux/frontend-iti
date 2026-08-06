<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>

    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>ATC/ITI DETAILS</title>
    <style>
        .page-title {
            color: #333; 
            font-size: 28px;
            font-weight: 600;
        }
        .breadcrumb-text {
            color: #888;
            font-size: 14px;
        }
        .table th {
            background-color: #212529 !important;
            color: white !important;
            padding: 12px;
            font-weight: bold;
            font-size: 13px;
        }
        .table td {
            padding: 10px;
            vertical-align: middle;
            font-size: 13px;
        }
        .search-area {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>

<body>
    <!-- Global Header -->
    <header>
        <%@ include file="../reports/bannernew.jsp" %>
    </header>

    <div class="container-fluid px-5 mt-4 mb-5" style="min-height: 50vh;">
        <!-- Page Header & Breadcrumbs -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="page-title text-uppercase">${title != null ? title : 'ATC / ITI DETAILS'}</h2>
            <div class="breadcrumb-text">Home / ${title != null ? title : 'ATC-ITI Details'}</div>
        </div>

        <!-- Search Area -->
        <div class="search-area">
            <div class="row g-3">
                <div class="col-md-10">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search by ITI Name, Code, DistrictCode, or Type...">
                </div>
                <div class="col-md-2">
                    <button class="btn btn-primary w-100" id="searchBtn">Search</button>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="m-0" style="color: #444;">List of ITIs</h4>
            <div class="text-muted" id="rowCount">Showing 0 entries</div>
        </div>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Sl. No.</th>
                        <th>ITI Code</th>
                        <th>NCVT Code</th>
                        <th>ITI Name</th>
                        <th>Name of the Principal</th>
                        <th>ITI Mail ID</th>
                        <th>Mobile Number</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <tr>
                        <td colspan="7" class="text-center">Loading data...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Global Footer -->
    <footer>
        <%@ include file="../reports/footer.jsp" %>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let allData = [];
            const tableBody = document.getElementById("tableBody");
            const searchInput = document.getElementById("searchInput");
            const searchBtn = document.getElementById("searchBtn");
            const rowCount = document.getElementById("rowCount");

            // Fetch Data
           const itiApiUrl = "${itiApiUrl}";

fetch(itiApiUrl)
    .then(response => {

        if (!response.ok) {
            throw new Error("Failed to fetch ITI data");
        }

        return response.json();
    })
    .then(data => {

        allData = data;
        renderTable(allData);
    })
    .catch(error => {

        console.error(error);

        tableBody.innerHTML =
            "<tr>" +
            "<td colspan='7' class='text-center text-danger'>" +
            "Failed to load ITI data" +
            "</td>" +
            "</tr>";
    });
            function renderTable(dataToRender) {
                tableBody.innerHTML = "";
                if (dataToRender.length === 0) {
                    tableBody.innerHTML = "<tr><td colspan='7' class='text-center'>No records found</td></tr>";
                    rowCount.textContent = "Showing 0 entries";
                    return;
                }

                dataToRender.forEach((item, index) => {
    const tr = document.createElement("tr");

    tr.innerHTML = `
        <td><strong>\${index + 1}</strong></td>

        <td>
            <a href="${pageContext.request.contextPath}/iti-details?itiCode=\${encodeURIComponent(item.itiCode)}"
               style="color: #2563eb; font-weight: bold; text-decoration: none;">

                \${item.itiCode || ''}

            </a>
        </td>

        <td style="color: #059669; font-weight: bold;">
            \${item.ncvtCode || ''}
        </td>

        <td style="font-weight: 600;">
            \${item.itiName || ''}
        </td>

        <td>
            \${item.principalName || ''}
        </td>

        <td>
            \${item.email || ''}
        </td>

        <td>
            \${item.mobile || ''}
        </td>
    `;

    tableBody.appendChild(tr);
});
        
                rowCount.textContent = `Showing \${dataToRender.length} entries`;
            }
           function applyFilter() {
    const term = searchInput.value.toLowerCase().trim();

    const filtered = allData.filter(item =>
        (item.itiCode && item.itiCode.toLowerCase().includes(term)) ||
        (item.ncvtCode && item.ncvtCode.toLowerCase().includes(term)) ||
        (item.itiName && item.itiName.toLowerCase().includes(term)) ||
        (item.principalName && item.principalName.toLowerCase().includes(term)) ||
        (item.email && item.email.toLowerCase().includes(term)) ||
        (item.mobile && item.mobile.toLowerCase().includes(term)) ||
        (item.cityTown && item.cityTown.toLowerCase().includes(term)) ||
        (item.address && item.address.toLowerCase().includes(term)) ||
        (item.distCode && item.distCode.toLowerCase().includes(term)) ||
        (item.itiType && item.itiType.toLowerCase().includes(term)) ||
        (item.description && item.description.toLowerCase().includes(term))
    );

    renderTable(filtered);
}
              

            searchBtn.addEventListener("click", applyFilter);
            searchInput.addEventListener("keyup", function(e) {
                if (e.key === "Enter") applyFilter();
            });
        });
    </script>
</body>

</html>
