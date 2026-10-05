<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Delete Schedule Entry - AP ITI</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/iti-portal.css">
        <style>
            .page-header-custom {
                background-color: #e4eeb9;
                color: #000;
                padding: 20px 0;
                margin-top: 15px;
                margin-bottom: 30px;
                border-bottom: 4px solid #b9c46d;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }

            .form-card {
                border: 1px solid #b9c46d;
                border-radius: 20px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.06);
                overflow: hidden;
                margin-bottom: 30px;
                background: #fff;
            }

            .card-header-primary {
                background-color: #e4eeb9;
                color: #000;
                font-weight: 700;
                padding: 15px 25px;
                text-transform: uppercase;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .card-header-danger {
                background-color: #e4eeb9;
                color: #000;
                font-weight: 700;
                padding: 15px 25px;
                text-transform: uppercase;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .card-body-custom {
                padding: 30px;
                background: #fff;
            }

            .form-label-custom {
                font-weight: 600;
                color: #660000;
                margin-bottom: 8px;
                font-size: 0.95rem;
            }

            .form-control-custom {
                border: 1.5px solid #dee2e6;
                border-radius: 8px;
                padding: 10px 15px;
                font-weight: 500;
                transition: all 0.3s;
            }

            .form-control-custom:focus {
                border-color: #b9c46d;
                box-shadow: 0 0 0 4px rgba(185, 196, 109, 0.2);
            }

            .btn-search-custom {
                background-color: #0b4d8c;
                border: none;
                color: #fff;
                font-weight: 700;
                padding: 10px 30px;
                border-radius: 50px;
                transition: all 0.3s;
                cursor: pointer;
            }

            .btn-search-custom:hover {
                background-color: #083a6b;
                transform: translateY(-1px);
            }

            .btn-reset-custom {
                background-color: #6c757d;
                border: none;
                color: #fff;
                font-weight: 700;
                padding: 10px 30px;
                border-radius: 50px;
                transition: all 0.3s;
                cursor: pointer;
            }

            .btn-reset-custom:hover {
                background-color: #545b62;
                transform: translateY(-1px);
            }

            .btn-delete-row {
                background-color: #c41818;
                border: none;
                color: #fff;
                font-weight: 600;
                padding: 5px 14px;
                border-radius: 20px;
                font-size: 0.82rem;
                transition: all 0.25s;
                white-space: nowrap;
                cursor: pointer;
            }

            .btn-delete-row:hover {
                background-color: #a31313;
                transform: scale(1.04);
            }

            .table-section {
                animation: fadeIn 0.4s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(16px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .table thead th {
                background-color: #e4eeb9;
                color: #000;
                font-weight: 700;
                font-size: 0.88rem;
                white-space: nowrap;
                vertical-align: middle;
            }

            .table tbody tr:hover {
                background-color: #f4f9e8;
            }

            .feedback-bar {
                border-radius: 10px;
                padding: 12px 20px;
                font-weight: 600;
                font-size: 0.95rem;
                margin-top: 12px;
                display: none;
            }

            .spinner-overlay {
                display: none;
                text-align: center;
                padding: 30px;
            }

            .modal-header-danger {
                background-color: #c41818;
                color: #fff;
            }

            .badge-count {
                background-color: #b9c46d;
                color: #000;
                border-radius: 50px;
                padding: 4px 12px;
                font-size: 0.8rem;
                margin-left: 8px;
            }

            .lower-footer {
                background-color: #e4eeb9 !important;
                color: #000 !important;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/bannernew.jsp" />
        <jsp:include page="/WEB-INF/navbars/iti_navbar.jsp" />
        <jsp:include page="/WEB-INF/jsp/_api_base_url.jsp" />

        <div class="page-header-custom text-center">
            <div class="container">
                <h1 class="mb-0" style="font-size:1.6rem;"><i class="fas fa-calendar-times me-2"></i> Delete Schedule
                    Entry</h1>
            </div>
        </div>

        <div class="container mb-5">
            <div class="row justify-content-center">
                <div class="col-lg-9">
                    <div class="card form-card">
                        <div class="card-header-primary"><i class="fas fa-filter"></i> Search Schedule Entries</div>
                        <div class="card-body card-body-custom">
                            <div class="row g-4">
                                <div class="col-md-4">
                                    <label class="form-label-custom">Government / Private Type</label>
                                    <select id="itiTypeSelect" class="form-select form-control-custom"
                                        onchange="onItiTypeChange(this.value)">
                                        <option value="">-- SELECT --</option>
                                        <option value="G">Government</option>
                                        <option value="P">Private</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label-custom">District Name</label>
                                    <select id="districtSelect" class="form-select form-control-custom"
                                        onchange="onDistrictChange(this.value)" disabled>
                                        <option value="all">-- ALL DISTRICTS --</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label-custom">ITI Name</label>
                                    <select id="itiSelect" class="form-select form-control-custom" disabled>
                                        <option value="all">-- ALL ITIs --</option>
                                    </select>
                                </div>
                                <div class="col-12 text-center border-top pt-4 mt-2">
                                    <button class="btn-search-custom me-2" onclick="searchScheduleEntries()"><i
                                            class="fas fa-search me-1"></i> Search</button>
                                    <button class="btn-reset-custom" onclick="resetForm()"><i
                                            class="fas fa-undo me-1"></i> Reset</button>
                                </div>
                            </div>
                            <div id="filterFeedback" class="feedback-bar mt-3"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="spinner-overlay" id="spinnerArea">
                <div class="spinner-border text-danger" role="status"></div>
                <p class="mt-2 text-muted fw-bold">Loading schedule entries...</p>
            </div>

            <div id="tableSection" class="table-section" style="display:none;">
                <div class="card form-card">
                    <div class="card-header-danger">
                        <i class="fas fa-list-alt"></i> Schedule Entries
                        <span class="badge-count" id="entryCountBadge">0</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Sl No</th>
                                        <th>District Name</th>
                                        <th>ITI Name</th>
                                        <th>Reservation</th>
                                        <th>Qualification</th>
                                        <th>Merit From</th>
                                        <th>Merit To</th>
                                        <th>Call Date</th>
                                        <th>Call Time</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="entryList"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div id="globalFeedback" class="feedback-bar text-center" style="font-size:1rem;"></div>
        </div>

        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow">
                    <div class="modal-header modal-header-danger">
                        <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i> Confirm Deletion</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body py-4 text-center">
                        <p class="mb-1">Are you sure you want to <strong>permanently delete</strong> this schedule
                            entry?</p>
                        <p class="text-danger fw-bold mb-0" id="deleteEntryLabel"></p>
                    </div>
                    <div class="modal-footer justify-content-center border-0">
                        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal"><i
                                class="fas fa-times me-1"></i> Cancel</button>
                        <button type="button" class="btn btn-danger px-4" id="confirmDeleteBtn"
                            onclick="confirmDelete()"><i class="fas fa-trash me-1"></i> Yes, Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
        <% Object sessionRoleId=session.getAttribute("roleId"); Object sessionInsCode=session.getAttribute("insCode");
            String jsRoleId=sessionRoleId==null ? "" : String.valueOf(sessionRoleId).replace("'","\\'"); String
            jsInsCode=sessionInsCode==null ? "" : String.valueOf(sessionInsCode).replace("'","\\'"); %>
            <script>
                var BACKEND = window.API_BASE_URL;
                var pendingSid = null;

                async function onItiTypeChange(itiType) {
                    var distSel = document.getElementById('districtSelect');
                    var itiSel = document.getElementById('itiSelect');
                    resetSelect(distSel, '-- ALL DISTRICTS --', 'all');
                    resetSelect(itiSel, '-- ALL ITIs --', 'all');
                    distSel.disabled = true; itiSel.disabled = true;
                    hideFilterFeedback();
                    if (!itiType) return;
                    try {
                        var resp = await fetch(BACKEND + '/itiapi/masterdata/getAllItisGovtorPvt?itiType=' + encodeURIComponent(itiType), { credentials: 'include' });
                        var data = await resp.json();
                        if (Array.isArray(data) && data.length > 0) {
                            var seen = {};
                            data.forEach(function (item) {
                                var code = item.dist_code || item.distCode || item.districtCode;
                                var name = item.dist_name || item.distName || item.districtName || code;
                                if (code && !seen[code]) { seen[code] = true; addOption(distSel, code, name); }
                            });
                            distSel.disabled = false;
                        }
                    } catch (e) { showFilterFeedback('Failed to load districts. Please try again.', 'danger'); }
                }

                async function onDistrictChange(distCode) {
                    var itiSel = document.getElementById('itiSelect');
                    var itiType = document.getElementById('itiTypeSelect').value;
                    resetSelect(itiSel, '-- ALL ITIs --', 'all');
                    itiSel.disabled = true;
                    if (!distCode || distCode === 'all' || !itiType) return;
                    try {
                        var resp = await fetch(BACKEND + '/itiapi/masterdata/getAllItisInDistandGovt?distCode=' + encodeURIComponent(distCode) + '&govt=' + encodeURIComponent(itiType), { credentials: 'include' });
                        var data = await resp.json();
                        if (Array.isArray(data) && data.length > 0) {
                            data.forEach(function (item) {
                                var code = item.iti_code || item.itiCode || item.code;
                                var name = item.iti_name || item.itiName || item.name || code;
                                if (code) addOption(itiSel, code, name);
                            });
                            itiSel.disabled = false;
                        }
                    } catch (e) { showFilterFeedback('Failed to load ITI list. Please try again.', 'danger'); }
                }

                async function searchScheduleEntries() {
                    hideFilterFeedback(); hideGlobalFeedback();
                    document.getElementById('tableSection').style.display = 'none';
                    var itiType = document.getElementById('itiTypeSelect').value;
                    var distCode = document.getElementById('districtSelect').value || 'all';
                    var itiCode = document.getElementById('itiSelect').value || 'all';
                    if (!itiType) { showFilterFeedback('Please select Government / Private Type.', 'warning'); return; }
                    showSpinner(true);
                    try {
                        var resp = await fetch(BACKEND + '/itiapi/admissions/getScheduleEntryByDistCodeAndItiCode', {
                            method: 'POST', credentials: 'include',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ distCode: distCode, itiCode: itiCode, itiType: itiType })
                        });
                        showSpinner(false);
                        if (!resp.ok) {
                            var errText = await resp.text();
                            console.error('[Search] HTTP ' + resp.status + ':', errText);
                            showFilterFeedback('Server error (' + resp.status + '). Check browser Console (F12) for details.', 'danger');
                            return;
                        }
                        var result = await resp.json();
                        var rows = Array.isArray(result) ? result : (Array.isArray(result.data) ? result.data : []);
                        if (rows.length === 0) { showFilterFeedback('No schedule entries found for the selected filters.', 'info'); return; }
                        renderTable(rows);
                    } catch (e) {
                        showSpinner(false);
                        console.error('[Search] Fetch error:', e);
                        showFilterFeedback('Error fetching entries: ' + e.message + ' — Is the backend running at ' + BACKEND + '?', 'danger');
                    }
                }

                function renderTable(rows) {
                    var tbody = document.getElementById('entryList');
                    tbody.innerHTML = '';
                    rows.forEach(function (row, idx) {
                        var sid = row.tempPk || row.sid || row.id || row.scheduleId || '';
                        var distName = row.distName || row.distCode || row.dist_code || '-';
                        var itiName = row.itiName || row.itiCode || row.iti_code || '-';
                        var reserv = row.caste || row.reservation || '-';
                        var qual = row.minqul || row.qualification || '-';
                        var meritFrom = row.meritFrom || row.merit_from || '-';
                        var meritTo = row.meritTo || row.merit_to || '-';
                        var callDate = row.calDate || row.cal_date || row.callDate || '-';
                        var callTime = row.calTime || row.cal_time || row.callTime || '-';
                        var sidSafe = String(sid).replace(/'/g, '');
                        var labelSafe = (itiName + ' - ' + distName).replace(/'/g, '');
                        var tr = document.createElement('tr');
                        tr.setAttribute('data-sid', sidSafe);
                        tr.innerHTML =
                            '<td class="text-center fw-bold">' + (idx + 1) + '</td>' +
                            '<td>' + distName + '</td><td>' + itiName + '</td>' +
                            '<td>' + reserv + '</td><td>' + qual + '</td>' +
                            '<td class="text-center">' + meritFrom + '</td>' +
                            '<td class="text-center">' + meritTo + '</td>' +
                            '<td class="text-center">' + callDate + '</td>' +
                            '<td class="text-center">' + callTime + '</td>' +
                            '<td class="text-center"><button class="btn-delete-row" onclick="openDeleteModal(\'' + sidSafe + '\',\'' + labelSafe + '\')">' +
                            '<i class="fas fa-trash me-1"></i> Delete</button></td>';
                        tbody.appendChild(tr);
                    });
                    document.getElementById('entryCountBadge').textContent = rows.length;
                    document.getElementById('tableSection').style.display = 'block';
                    document.getElementById('tableSection').scrollIntoView({ behavior: 'smooth', block: 'start' });
                }

                function openDeleteModal(sid, label) {
                    pendingSid = sid;
                    document.getElementById('deleteEntryLabel').textContent = label;
                    new bootstrap.Modal(document.getElementById('deleteConfirmModal')).show();
                }

                async function confirmDelete() {
                    if (!pendingSid) return;
                    var btn = document.getElementById('confirmDeleteBtn');
                    btn.disabled = true;
                    btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Deleting...';
                    bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal')).hide();
                    try {
                        var resp = await fetch(BACKEND + '/itiapi/admissions/deleteScheduleEntryById', {
                            method: 'POST', credentials: 'include',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ sid: pendingSid })
                        });
                        var result = await resp.json();
                        if (resp.ok && result.success !== false) {
                            showGlobalFeedback('<i class="fas fa-check-circle me-2"></i>Schedule entry deleted successfully!', 'success');
                            removeRowBySid(pendingSid);
                        } else {
                            showGlobalFeedback('<i class="fas fa-times-circle me-2"></i>Delete failed: ' + (result.message || result.error || 'Unknown error'), 'danger');
                        }
                    } catch (e) {
                        showGlobalFeedback('<i class="fas fa-times-circle me-2"></i>An error occurred. Please try again.', 'danger');
                    } finally {
                        btn.disabled = false;
                        btn.innerHTML = '<i class="fas fa-trash me-1"></i> Yes, Delete';
                        pendingSid = null;
                    }
                }

                function removeRowBySid(sid) {
                    var row = document.querySelector('#entryList tr[data-sid="' + sid + '"]');
                    if (row) row.remove();
                    var remaining = document.querySelectorAll('#entryList tr').length;
                    document.getElementById('entryCountBadge').textContent = remaining;
                    if (remaining === 0) { document.getElementById('tableSection').style.display = 'none'; showFilterFeedback('All entries deleted.', 'info'); }
                    document.querySelectorAll('#entryList tr').forEach(function (tr, i) { tr.cells[0].textContent = i + 1; });
                }

                function resetForm() {
                    document.getElementById('itiTypeSelect').value = '';
                    resetSelect(document.getElementById('districtSelect'), '-- ALL DISTRICTS --', 'all');
                    resetSelect(document.getElementById('itiSelect'), '-- ALL ITIs --', 'all');
                    document.getElementById('districtSelect').disabled = true;
                    document.getElementById('itiSelect').disabled = true;
                    document.getElementById('tableSection').style.display = 'none';
                    document.getElementById('entryList').innerHTML = '';
                    hideFilterFeedback(); hideGlobalFeedback();
                }

                function addOption(sel, value, text) { var o = document.createElement('option'); o.value = value; o.textContent = text; sel.appendChild(o); }
                function resetSelect(sel, ph, phv) { sel.innerHTML = ''; addOption(sel, phv, ph); }
                function showSpinner(s) { document.getElementById('spinnerArea').style.display = s ? 'block' : 'none'; }
                function showFilterFeedback(msg, type) { var e = document.getElementById('filterFeedback'); e.className = 'feedback-bar alert alert-' + type + ' mt-3'; e.innerHTML = msg; e.style.display = 'block'; }
                function hideFilterFeedback() { document.getElementById('filterFeedback').style.display = 'none'; }
                function showGlobalFeedback(msg, type) { var e = document.getElementById('globalFeedback'); e.className = 'feedback-bar alert alert-' + type + ' text-center'; e.innerHTML = msg; e.style.display = 'block'; }
                function hideGlobalFeedback() { document.getElementById('globalFeedback').style.display = 'none'; }
            </script>
            <%@ include file="../footer.jsp" %>
    </body>

    </html>