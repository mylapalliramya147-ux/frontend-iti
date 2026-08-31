<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.sessionUser}"><c:redirect url="/?error=session"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ITI Placements / In-Plant Training - Dashboard</title>
    <!-- Local Bootstrap 5.3.8 + Font Awesome (shipped by ITIAP under /css) -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/all.min.css" rel="stylesheet">
    <!-- Chart.js v2.9.4 (CDN — not shipped locally); matches new Chart(ctx,{type:'pie'}) API -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
    <!-- SheetJS xlsx (CDN) — used by the above/below-20% Excel export -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <!-- jQuery (local) — dependency for Bootstrap bundle + all page scripts -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <!-- Page styles (kept from ITIAP) + data-table helper for the below-20% grid -->
    <style>
        body{margin:0;background:#f5f5f5;font-family:'Segoe UI',Arial,sans-serif;}
        .header-banner{width:100%;height:110px;overflow:hidden;position:relative;background:#172233;}
        .header-banner img{width:100%;height:110px;object-fit:cover;opacity:.85;}
        .header-banner .banner-title{position:absolute;inset:0;display:flex;align-items:center;justify-content:center;color:#fff;font-size:22px;font-weight:bold;text-shadow:1px 1px 4px rgba(0,0,0,.7);}
        .navbar{background:#172233;padding:10px 16px;}
        .navbar .brand{display:inline-flex;align-items:center;color:#fff;text-decoration:none;font-weight:700;font-size:18px;}
        .navbar .brand img{height:34px;margin-right:10px;}
        .navbar .navlinks{display:inline-flex;align-items:center;gap:14px;}
        .navbar .navlinks a{color:#fff;text-decoration:none;font-size:14px;}
        .navbar .navlinks a:hover{color:#ffc107;}
        .navbar .user-dd{position:relative;display:inline-block;}
        .navbar .dropdown-menu-right{position:absolute;right:0;top:30px;background:#fff;border:1px solid #ccc;border-radius:4px;min-width:170px;box-shadow:0 2px 8px rgba(0,0,0,.15);}
        .navbar .dropdown-menu-right a{display:block;padding:6px 12px;color:#212529;text-decoration:none;font-size:13px;}
        .navbar .dropdown-menu-right a:hover{background:#f0f0f0;}
        .card{border:none;border-radius:8px;box-shadow:0 1px 4px rgba(0,0,0,.1);}
        .card-header{border-radius:8px 8px 0 0!important;background:#fff;border-bottom:2px solid #172233;color:#172233;font-weight:700;font-size:15px;}
        .card-body{padding:14px 16px;}
        .stat{font-size:26px;font-weight:700;color:#172233;}
        .stat-sub{font-size:13px;color:#6c757d;}
        .menu-list a{display:block;padding:4px 0;color:#212529;text-decoration:none;font-size:13px;}
        .menu-list a:hover{background:#eef5ff;border-radius:3px;}
        #tabledata th,#tabledata td{border:1px solid #dee2e6;padding:6px 10px;font-size:13px;text-align:center;}
        #tabledata th{background:#172233;color:#fff;}
    </style>
    <!-- Session-derived auth. ITIAP authenticates via server sessions, NOT the
         JWT the original page used — so role/ITI come from the session and
         jwtToken is left empty (stubbed). The masterdata/** stats endpoints are
         not yet implemented in the ITIAP Backend; their callers fail silently. -->
    <script>
        var roleId   = '<c:out value="${sessionScope.roleId}" default=""/>';
        var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
        var username = '<c:out value="${sessionScope.username}" default=""/>';
        var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
        var jwtToken = '';
        var baseUrl  = "${backendBaseUrl}/";   /* e.g. http://localhost:5050/ */
    </script>
</head>
<body>
<div class="header-banner">
    <img src="${pageContext.request.contextPath}/images/gen.jpg" alt="ITI Placements Banner">
    <span class="banner-title">ITI Placements / In-Plant Training - Dashboard</span>
</div>
<nav class="navbar">
  <div class="d-flex justify-content-between align-items-center w-100">
    <a class="brand" href="${pageContext.request.contextPath}/placements/loginSuccess"><img src="${pageContext.request.contextPath}/images/gen.jpg" alt="ITI" class="img-fluid">ITIAP</a>
    <div class="navlinks">
      <a href="${pageContext.request.contextPath}/placements/loginSuccess"><i class="fa fa-home"></i> Home</a>
      <span id="userinfo" style="color:#cfe3ff;font-size:13px;">&nbsp;</span>
      <div class="user-dd dropdown">
        <span class="name dropdown-toggle" id="userMenu" type="button" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fa fa-user"></i>
          <c:if test="${not empty sessionScope.username}">${sessionScope.username}</c:if>
          <c:if test="${empty sessionScope.username}">User</c:if>
        </span>
        <ul class="dropdown-menu dropdown-menu-right">
          <li><a class="dropdown-item" href="#">Change User Details</a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out"></i> Logout</a></li>
        </ul>
      </div>
    </div>
  </div>
</nav>

<script>
$(function () {
    // Populate the navbar user-info line from the session (source used a
    // document.ready block with insName/insCode/username for #userinfo).
    var parts = [];
    if (insName) parts.push(insName);
    if (insCode) parts.push('ITI Code: ' + insCode);
    if (username) parts.push('User: ' + username);
    $('#userinfo').text(parts.length ? parts.join('  |  ') : 'Welcome');
});
</script>

<div class="container-fluid py-3">
  <!-- Loading spinner (hidden once the stat fetches settle) -->
  <div id="spinnerdiv" class="text-center py-5">
    <div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading…</span></div>
  </div>

  <div id="datadiv" style="display:none;">
    <div id="dataheading" class="h5 mb-3">Overview</div>
    <div id="tabledata" class="mb-4"></div>
  </div>

  <!-- Seat strength / fill-ratio pie charts (faithful to the source layout) -->
  <div class="row g-3 mb-4">
    <div class="col-md-4">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-chair"></i> All Seats</div>
        <div class="card-body">
          <canvas id="dashBoardAllSeats" height="200"></canvas>
          <hr>
          <div class="d-flex justify-content-between stat-sub">Total&nbsp;<span id="dashBoardAllSeats-total">—</span></div>
          <div class="d-flex justify-content-between stat-sub">Filled&nbsp;<span id="dashBoardAllSeats-filled">—</span></div>
          <div class="d-flex justify-content-between stat-sub">Fill Ratio&nbsp;<span id="dashBoardAllSeats-fillratio">—%</span></div>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-building"></i> Govt ITI Seats</div>
        <div class="card-body">
          <canvas id="govtSeatsPieChart" height="200"></canvas>
          <hr>
          <div class="d-flex justify-content-between stat-sub">Total&nbsp;<span id="govtSeats-total">—</span></div>
          <div class="d-flex justify-content-between stat-sub">Filled&nbsp;<span id="govtSeats-filled">—</span></div>
          <div class="d-flex justify-content-between stat-sub">Fill Ratio&nbsp;<span id="govtSeats-fillratio">—%</span></div>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-hotel"></i> Pvt ITI Seats</div>
        <div class="card-body">
          <canvas id="pvtSeatsPieChart" height="200"></canvas>
          <hr>
          <div class="d-flex justify-content-between stat-sub">Total&nbsp;<span id="pvtSeats-total">—</span></div>
          <div class="d-flex justify-content-between stat-sub">Filled&nbsp;<span id="pvtSeats-filled">—</span></div>
          <div class="d-flex justify-content-between stat-sub">Fill Ratio&nbsp;<span id="pvtSeats-fillratio">—%</span></div>
        </div>
      </div>
    </div>
  </div>

  <!-- Above 20% fill ratio -->
  <div class="card mb-4">
    <div class="card-header"><i class="fa fa-thumbs-up"></i> ITIs with Fill Ratio Above 20%</div>
    <div class="card-body">
      <canvas id="above20PercentPieChart" height="110"></canvas>
      <div class="row text-center mt-3">
        <div class="col"><div class="stat" id="above20NoOfItis">—</div><div class="stat-sub">No. of ITIs</div></div>
        <div class="col"><div class="stat" id="above20TotalSeats">—</div><div class="stat-sub">Total Seats</div></div>
        <div class="col"><div class="stat" id="above20FilledSeats">—</div><div class="stat-sub">Filled Seats</div></div>
      </div>
      <div id="above20Tabledata" class="mt-3"></div>
    </div>
  </div>

  <!-- Below 20% fill ratio -->
  <div class="card mb-4">
    <div class="card-header"><i class="fa fa-thumbs-down"></i> ITIs with Fill Ratio Below 20%</div>
    <div class="card-body">
      <canvas id="below20PercentPieChart" height="110"></canvas>
      <div class="row text-center mt-3">
        <div class="col"><div class="stat" id="below20NoOfItis">—</div><div class="stat-sub">No. of ITIs</div></div>
        <div class="col"><div class="stat" id="below20TotalSeats">—</div><div class="stat-sub">Total Seats</div></div>
        <div class="col"><div class="stat" id="below20FilledSeats">—</div><div class="stat-sub">Filled Seats</div></div>
      </div>
      <div id="below20Tabledata" class="mt-3"></div>
      <div class="text-end mt-3">
        <button type="button" class="btn btn-sm btn-outline-primary" onclick="fnExcelReport()">
          <i class="fa fa-file-excel"></i> Export to Excel
        </button>
      </div>
    </div>
  </div>
</div>

<div class="container-fluid pb-4">
  <div class="row g-3">
    <div class="col-md-3">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-cog"></i> SERVICES</div>
        <div class="card-body">
          <div class="menu-list">
            <a href="#">Change User Details</a>
            <a href="#">My Profile</a>
            <a href="#">Change Password</a>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-briefcase"></i> PLACEMENTS</div>
        <div class="card-body">
          <div class="menu-list">
            <a href="#">Placement Entry</a>
            <a href="#">Placement Report</a>
            <a href="#">Placement Schedule Entry</a>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-industry"></i> IN-PLANT TRAINING</div>
        <div class="card-body">
          <div class="menu-list">
            <a href="#">In-Plant Entry</a>
            <a href="#">In-Plant Report</a>
            <a href="#">In-Plant Schedule Entry</a>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-flask"></i> LABORATORIES</div>
        <div class="card-body">
          <div class="menu-list">
            <a href="#">Lab Entry</a>
            <a href="#">Lab Item List</a>
            <a href="#">Lab Report</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
// ============================================================================
// Dashboard scripts (faithful to the ITI placements source, ITIAP-adapted).
//
// The source calls `masterdata/dashBoardData`, `masterdata/getAbove20PercentItisStats`
// and `masterdata/getBelow20PercentItisStats` for these widgets. Those endpoints are
// not implemented in the ITIAP Backend yet, so each call is wrapped so that on
// failure it degrades silently (no alert) and leaves the charts/tables empty.
// When the endpoints are added, the AJAX below will light these sections up
// with no further page changes.
// ============================================================================
$(function () {
    var call = function (url, options) {
        // Wrap $.get with a silent fail handler. A JWT is not used in ITIAP
        // (sessions instead), so the `Authorization` header is only sent if a
        // token was ever injected (it is currently empty and therefore omitted).
        var settings = options || {};
        return $.get({
            url: baseUrl + url,
            headers: jwtToken ? { 'Authorization': 'Bearer ' + jwtToken } : undefined
        }).done(settings.done || function () {}).fail(function (xhr, status, err) {
            // masterdata/** is not available yet in ITIAP -> fail silently.
            if (settings.error) settings.error(xhr, status, err);
        });
    };

    var fillLabels = function (id, total, filled) {
        $('#dashBoardAllSeats-total').text(total == null || isNaN(total) ? '—' : Number(total).toLocaleString('en-US'));
        $('#dashBoardAllSeats-filled').text(filled == null || isNaN(filled) ? '—' : Number(filled).toLocaleString('en-US'));
        if (total > 0) {
            $('#dashBoardAllSeats-fillratio').text(((filled / total) * 100).toFixed(1) + '%');
        } else { $('#dashBoardAllSeats-fillratio').text('—%'); }
    };

    function renderPieChart(canvasId, labels, values, title) {
        var ctx = document.getElementById(canvasId);
        if (!ctx) return;
        if (window.dashPieCharts === undefined) window.dashPieCharts = {};
        if (window.dashPieCharts[canvasId]) window.dashPieCharts[canvasId].destroy();
        window.dashPieCharts[canvasId] = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    data: values,
                    backgroundColor: ['#28a745', '#dc3545', '#ffc107', '#17a2b8', '#6610f2', '#fd7e14', '#20c997'],
                    borderWidth: 1
                }]
            },
            options: {
                maintainAspectRatio: false,
                legend: { position: 'bottom' },
                title: { display: !!title, text: title },
                cutoutPercentage: 0
            }
        });
    }
function fetchDataAndRenderChart() {
        call('masterdata/dashBoardData', {
            done: function (data) {
                var d = data || {};
                var seatsTotal = Number(d.dashBoardAllSeats ? d.dashBoardAllSeats.strength : d.allSeatsTotal);
                var seatsFilled = Number(d.dashBoardAllSeats ? d.dashBoardAllSeats.filledSheets : d.allSeatsFilled);
                renderPieChart('dashBoardAllSeats', ['Filled', 'Vacant'],
                    [isNaN(seatsFilled) ? 0 : seatsFilled, Math.max(isNaN(seatsTotal) ? 0 : seatsTotal - (isNaN(seatsFilled) ? 0 : seatsFilled), 0)],
                    'All Seats');
                fillLabels('dashBoardAllSeats', seatsTotal, seatsFilled);
                $('#spinnerdiv').hide();
                $('#datadiv').show();
            },
            error: function () {
                $('#spinnerdiv').hide();
                $('#datadiv').show();
            }
        });
    }

    function getPieChartsGovt() {
        call('masterdata/dashBoardData', {
            done: function (data) {
                var d = data || {};
                var total = Number(d.govtSeatsTotal != null ? d.govtSeatsTotal : (d.dashBoardGovt ? d.dashBoardGovt.strength : 0));
                var filled = Number(d.govtSeatsFilled != null ? d.govtSeatsFilled : (d.dashBoardGovt ? d.dashBoardGovt.filledSheets : 0));
                renderPieChart('govtSeatsPieChart', ['Filled', 'Vacant'],
                    [filled, Math.max(total - filled, 0)], 'Govt ITI Seats');
                $('#govtSeats-total').text(isNaN(total) ? '—' : Number(total).toLocaleString('en-US'));
                $('#govtSeats-filled').text(isNaN(filled) ? '—' : Number(filled).toLocaleString('en-US'));
                $('#govtSeats-fillratio').text(total > 0 ? ((filled / total) * 100).toFixed(1) + '%' : '—%');
            }
        });
    }

    function getPieChartsPvt() {
        call('masterdata/dashBoardData', {
            done: function (data) {
                var d = data || {};
                var total = Number(d.pvtSeatsTotal != null ? d.pvtSeatsTotal : (d.dashBoardPvt ? d.dashBoardPvt.strength : 0));
                var filled = Number(d.pvtSeatsFilled != null ? d.pvtSeatsFilled : (d.dashBoardPvt ? d.dashBoardPvt.filledSheets : 0));
                renderPieChart('pvtSeatsPieChart', ['Filled', 'Vacant'],
                    [filled, Math.max(total - filled, 0)], 'Pvt ITI Seats');
                $('#pvtSeats-total').text(isNaN(total) ? '—' : Number(total).toLocaleString('en-US'));
                $('#pvtSeats-filled').text(isNaN(filled) ? '—' : Number(filled).toLocaleString('en-US'));
                $('#pvtSeats-fillratio').text(total > 0 ? ((filled / total) * 100).toFixed(1) + '%' : '—%');
            }
        });
    }
function fetchAbove20PercentData() {
        call('masterdata/getAbove20PercentItisStats', {
            done: function (data) {
                var d = data || {};
                $('#above20NoOfItis').text(d.noOfItis == null ? '—' : Number(d.noOfItis).toLocaleString('en-US'));
                $('#above20TotalSeats').text(d.totalSeats == null ? '—' : Number(d.totalSeats).toLocaleString('en-US'));
                $('#above20FilledSeats').text(d.filledSeats == null ? '—' : Number(d.filledSeats).toLocaleString('en-US'));
                if (d.noOfItis != null) {
                    renderPieChart('above20PercentPieChart', ['Above 20% ITIs', 'Others'],
                        [Number(d.noOfItis), Number(d.noOfItis)], 'Above 20%');
                }
                if (d.itis && d.itis.length) {
                    var rows = '<table class="table table-bordered table-sm mb-0"><thead><tr><th>ITI Code</th><th>ITI Name</th><th>Total Seats</th><th>Filled Seats</th><th>Fill Ratio</th></tr></thead><tbody>';
                    d.itis.forEach(function (it) {
                        rows += '<tr><td>' + (it.itiCode || '') + '</td><td>' + (it.itiName || '') + '</td><td>' + (it.totalSeats || 0) + '</td><td>' + (it.filledSeats || 0) + '</td><td>' + (it.fillratio != null ? it.fillratio : '') + '%</td></tr>';
                    });
                    rows += '</tbody></table>';
                    $('#above20Tabledata').html(rows);
                }
            }
        });
    }

    function fetchBelow20PercentData() {
        call('masterdata/getBelow20PercentItisStats', {
            done: function (data) {
                var d = data || {};
                $('#below20NoOfItis').text(d.noOfItis == null ? '—' : Number(d.noOfItis).toLocaleString('en-US'));
                $('#below20TotalSeats').text(d.totalSeats == null ? '—' : Number(d.totalSeats).toLocaleString('en-US'));
                $('#below20FilledSeats').text(d.filledSeats == null ? '—' : Number(d.filledSeats).toLocaleString('en-US'));
                if (d.noOfItis != null) {
                    renderPieChart('below20PercentPieChart', ['Below 20% ITIs', 'Others'],
                        [Number(d.noOfItis), Number(d.noOfItis)], 'Below 20%');
                }
                if (d.itis && d.itis.length) {
                    var rows = '<table class="table table-bordered table-sm mb-0"><thead><tr><th>ITI Code</th><th>ITI Name</th><th>Total Seats</th><th>Filled Seats</th><th>Fill Ratio</th></tr></thead><tbody>';
                    d.itis.forEach(function (it) {
                        rows += '<tr><td>' + (it.itiCode || '') + '</td><td>' + (it.itiName || '') + '</td><td>' + (it.totalSeats || 0) + '</td><td>' + (it.filledSeats || 0) + '</td><td>' + (it.fillratio != null ? it.fillratio : '') + '%</td></tr>';
                    });
                    rows += '</tbody></table>';
                    $('#below20Tabledata').html(rows);
                }
            }
        });
    }

    window.fnExcelReport = function () {
        // Export the below-20% table to an .xlsx workbook (SheetJS).
        var rows = [];
        var $table = $('#below20Tabledata table');
        if ($table.length) {
            var colCount = $table.find('thead th').length;
            var headers = [];
            $table.find('thead th').each(function () { headers.push($(this).text()); });
            rows.push(headers);
            $table.find('tbody tr').each(function () {
                var row = [];
                $(this).find('td').each(function () { row.push($(this).text().replace('%', '')); });
                while (row.length < colCount) row.push('');
                rows.push(row);
            });
        }
        if (!rows.length) rows.push(['ITI Code', 'ITI Name', 'Total Seats', 'Filled Seats', 'Fill Ratio']);
        var ws = XLSX.utils.aoa_to_sheet(rows);
        var wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, 'Below20Percent');
        XLSX.writeFile(wb, 'Below20Percent_ITIs.xlsx');
    };

    // Kick off the overview + above/below-20% fetches (all fail silently for now).
    fetchDataAndRenderChart();
    getPieChartsGovt();
    getPieChartsPvt();
    fetchAbove20PercentData();
    fetchBelow20PercentData();
})(jQuery);
</script>
</body>
</html>
