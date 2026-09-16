<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>Shift & Unit Permitted Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
    <style>
        .district-row td { cursor: pointer; }
        .district-row:hover td { background-color: #e8f4f8; }
        .district-row.selected td { background-color: #d4e9f7 !important; font-weight: bold; }
        .detail-section { display: none; margin-top: 20px; }
        .loader { text-align: center; padding: 20px; color: #005073; }
        .spinner {
            display: inline-block; width: 30px; height: 30px; margin: auto;
            border: 4px solid #f3f3f3; border-top: 4px solid #4CAF50;
            border-radius: 50%; animation: spin 0.8s linear infinite;
        }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        .back-btn { margin-top: 15px; }
    </style>
    <script>
        var backendUrl = '${backendApiUrl}';
        var districtData = {};

        function showLoader(id) { document.getElementById(id).style.display = 'block'; }
        function hideLoader(id) { document.getElementById(id).style.display = 'none'; }

        function loadAllDistricts() {
            showLoader('loader');
            fetch(backendUrl + '/trade-display/districts')
                .then(function(r) { if (!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
                .then(function(j) {
                    if (j.error) throw new Error(j.error);
                    var districts = j.data || [];
                    if (!districts.length) {
                        document.getElementById('districtBody').innerHTML =
                            '<tr><td colspan="5" class="text-center">No districts found</td></tr>';
                        hideLoader('loader');
                        return null;
                    }
                    var proms = districts.map(function(d) {
                        return fetch(backendUrl + '/permitted-shift-unit?distCode='
                            + encodeURIComponent(d.code) + '&itaCode=All&size=1000')
                            .then(function(rr) { if (!rr.ok) throw new Error('HTTP ' + rr.status); return rr.json(); })
                            .then(function(jj) { if (jj.error) throw new Error(jj.error); return { dist: d, rows: jj.data || [] }; })
                            .catch(function(e) { console.error('shift-unit load failed for ' + d.code, e); return { dist: d, rows: [] }; });
                    });
                    return Promise.all(proms);
                })
                .then(function(res) {
                    if (!res) return;
                    var tb = document.getElementById('districtBody');
                    tb.innerHTML = '';
                    res.forEach(function(item, i) {
                        var d = item.dist, rows = item.rows;
                        var seen = {}, enteredMap = {};
                        rows.forEach(function(r) {
                            if (r.itiName) seen[r.itiName] = true;
                            if (r.itiName && r.shift && r.shift !== '0' && r.unit && r.unit !== '0') enteredMap[r.itiName] = true;
                        });
                        var total = Object.keys(seen).length;
                        var entered = Object.keys(enteredMap).length;
                        districtData[d.code] = { name: d.name, rows: rows, totalITIs: total, enteredCount: entered, notEnteredCount: total - entered };
                        var tr = document.createElement('tr');
                        tr.className = 'district-row';
                        tr.setAttribute('data-code', d.code);
                        tr.onclick = (function(code) { return function() { showITIDetail(code); }; })(d.code);
                        tr.innerHTML =
                            '<td>' + (i + 1) + '</td>' +
                            '<td>' + d.name + '</td>' +
                            '<td class="text-center font-weight-bold">' + total + '</td>' +
                            '<td class="text-center font-weight-bold">' + entered + '</td>' +
                            '<td class="text-center font-weight-bold">' + (total - entered) + '</td>';
                        tb.appendChild(tr);
                    });
                    hideLoader('loader');
                })
                .catch(function(e) {
                    document.getElementById('districtBody').innerHTML =
                        '<tr><td colspan="5" class="text-center text-danger">Error loading districts: ' + e.message + '</td></tr>';
                    hideLoader('loader');
                });
        }

        function showITIDetail(code) {
            var rows = document.querySelectorAll('.district-row');
            for (var k = 0; k < rows.length; k++) rows[k].classList.remove('selected');
            var row = document.querySelector('.district-row[data-code="' + code + '"]');
            if (row) row.classList.add('selected');
            var data = districtData[code];
            if (!data) return;
            document.getElementById('districtName').textContent = data.name;
            var tb = document.getElementById('itiBody');
            tb.innerHTML = '';
            if (!data.rows.length) {
                tb.innerHTML = '<tr><td colspan="7" class="text-center">No ITI records found</td></tr>';
            } else {
                data.rows.forEach(function(r, i) {
                    var tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (i + 1) + '</td>' +
                        '<td style="text-align:left;">' + (r.itiName || '-') + '</td>' +
                        '<td>' + (r.itiType || '-') + '</td>' +
                        '<td style="text-align:left;">' + (r.tradeName || '-') + '</td>' +
                        '<td class="text-center">' + (r.strength || 0) + '</td>' +
                        '<td>' + (r.shift || '-') + '</td>' +
                        '<td>' + (r.unit || '-') + '</td>';
                    tb.appendChild(tr);
                });
            }
            document.getElementById('detailSection').style.display = 'block';
            document.getElementById('detailSection').scrollIntoView({ behavior: 'smooth', block: 'start' });
        }

        function hideDetail() {
            document.getElementById('detailSection').style.display = 'none';
            var rows = document.querySelectorAll('.district-row');
            for (var k = 0; k < rows.length; k++) rows[k].classList.remove('selected');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        document.addEventListener('DOMContentLoaded', loadAllDistricts);
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container mt-4">
        <div class="nodal-page-title-dashboard">
            <h2>Shift &amp; Unit Permitted Report</h2>
        </div>
        <p class="text-muted">Permitted shift units - overall report by district</p>

        <h3>1. Overall Report (by District)</h3>
        <div id="loader" class="loader"><span class="spinner"></span><p class="mt-2">Loading district data...</p></div>
        <table class="table report-table">
            <thead>
                <tr>
                    <th>Sl. No</th>
                    <th>District</th>
                    <th>Total No of ITIs</th>
                    <th>ITIs shift &amp; unit entered</th>
                    <th>ITIs shift &amp; unit not entered</th>
                </tr>
            </thead>
            <tbody id="districtBody"></tbody>
        </table>

        <div id="detailSection" class="detail-section">
            <hr class="my-4">
            <h3><i class="fas fa-building me-2"></i><span id="districtName"></span> - ITI Details</h3>
            <table class="table report-table">
                <thead>
                    <tr>
                        <th>Sl. No</th>
                        <th>ITI Name</th>
                        <th>Type</th>
                        <th>Trade Name</th>
                        <th>Strength</th>
                        <th>Shift</th>
                        <th>Unit</th>
                    </tr>
                </thead>
                <tbody id="itiBody"></tbody>
            </table>
            <button id="backBtn" class="btn btn-outline-secondary back-btn" onclick="hideDetail()">
                <i class="fas fa-arrow-up me-1"></i> Back to top
            </button>
        </div>
    </div>
</body>
</html>
