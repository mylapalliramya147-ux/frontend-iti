<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>DGT Permitted Shift Units | ITI IMS</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
            <style>
                :root {
                    --primary-green: #008000;
                    --dark-green: #006400;
                    --light-bg: #f4f7f6;
                    --header-bg: #e2e2e2;
                }

                body {
                    background-color: var(--light-bg);
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                }

                .main-content {
                    flex: 1;
                }

                .selection-container {
                    background-color: white;
                    border: none;
                    padding: 0;
                    margin: 40px auto;
                    max-width: 900px;
                    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
                    border-radius: 8px;
                    overflow: hidden;
                }

                .blue-title-bar {
                    background-color: #2f6fa5;
                    color: white;
                    padding: 12px 15px;
                    text-align: center;
                    font-weight: 700;
                    margin-bottom: 30px;
                    font-size: 1.1rem;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                .selection-body {
                    padding: 0 40px 40px 40px;
                }

                .form-label {
                    font-weight: 600;
                    color: #444;
                    font-size: 0.95rem;
                }

                .btn-proceed {
                    background-color: #28a745;
                    color: white;
                    font-weight: 600;
                    padding: 8px 30px;
                    border: none;
                    border-radius: 4px;
                    transition: all 0.3s;
                }

                .btn-proceed:hover {
                    background-color: #218838;
                    transform: translateY(-1px);
                    box-shadow: 0 4px 8px rgba(40, 167, 69, 0.2);
                    color: white;
                }

                .btn-reset {
                    background-color: #dc3545;
                    color: white;
                    font-weight: 600;
                    padding: 8px 30px;
                    border: none;
                    border-radius: 4px;
                    transition: all 0.3s;
                }

                .btn-reset:hover {
                    background-color: #c82333;
                    transform: translateY(-1px);
                    box-shadow: 0 4px 8px rgba(220, 53, 69, 0.2);
                    color: white;
                }

                .table-container {
                    margin: 20px auto;
                    max-width: 1000px;
                    background: white;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                }

                .iti-header-row {
                    background-color: rgb(27, 116, 194);
                    color: white;
                    font-weight: bold;
                    padding: 5px 10px;
                }

                .data-table {
                    width: 100%;
                    border-collapse: collapse;
                }

                .data-table th {
                    background-color: rgb(27, 116, 194);
                    color: white;
                    padding: 8px;
                    border: 1px solid #fff;
                    text-align: center;
                    font-size: 14px;
                }

                .data-table td {
                    border: 1px solid #ccc;
                    padding: 10px;
                    vertical-align: middle;
                }

                .btn-add-more {
                    background-color: var(--dark-green);
                    color: white;
                    font-size: 12px;
                    padding: 2px 8px;
                    border-radius: 3px;
                    border: none;
                }

                .btn-remove {
                    background-color: #cc0000;
                    color: white;
                    font-size: 12px;
                    padding: 2px 8px;
                    border-radius: 3px;
                    border: none;
                }

                .btn-save {
                    background-color: #3f51b5;
                    color: white;
                    padding: 8px 25px;
                    font-weight: bold;
                    border: none;
                    border-radius: 4px;
                    margin-top: 20px;
                }

                select.form-select-sm {
                    padding: 2px 5px;
                    font-size: 12px;
                }

                .loader {
                    display: none;
                    position: fixed;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    z-index: 1000;
                }
            </style>
        </head>

        <body class="bg-light">
            <!-- Global Header -->
            <%@ include file="header.jsp" %>

            <div class="main-content">
                <div class="container mt-5">
                    <div class="selection-container">
                        <div class="blue-title-bar">Permitted Shift Unit For Admissions</div>
                        <div class="selection-body">
                            <div class="row align-items-center justify-content-center">
                                <div class="col-md-5">
                                    <div class="row mb-3">
                                        <label class="col-sm-4 col-form-label form-label text-end">Select ITI</label>
                                        <div class="col-sm-8">
                                            <select id="iti_select" class="form-select form-select-sm">
                                                <option value="">--Select ITI--</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="row mb-3">
                                        <label class="col-sm-4 col-form-label form-label text-end">Select Trade</label>
                                        <div class="col-sm-8">
                                            <select id="trade_select" class="form-select form-select-sm">
                                                <option value="">--Select Trade--</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center mt-4">
                                <button id="btn_proceed" class="btn btn-proceed me-3"
                                    style="background-color: #249B17; color: white;">Proceed</button>
                                <button id="btn_reset" class="btn btn-reset"
                                    style="background-color: red; color: white;">Reset</button>
                            </div>
                        </div>
                    </div>

                    <div id="results_container" class="table-container" style="display: none;">
                        <div id="iti_name_display" class="iti-header-row"></div>
                        <table class="data-table" id="shifts_table">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">Sl No</th>
                                    <th>ITI Name</th>
                                    <th>ITI Type</th>
                                    <th>Trade</th>
                                    <th>NCVT MIS Code</th>
                                    <th>Strength & Shift & Unit Allowed</th>
                                </tr>
                            </thead>
                            <tbody id="table_body">
                                <!-- Data will be populated here -->
                            </tbody>
                        </table>
                        <div class="text-center pb-4">
                            <button id="btn_save" class="btn btn-save"
                                style="background-color: #327ac7; color: white;">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="loader" id="loader">
                <div class="spinner-border text-success" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>

            <!-- Global Footer -->
            <footer>
                
            </footer>

            <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

            <script>








                $(document).ready(function () {
                    loadItis();

                    $('#iti_select').on('change', function () {
                        const itiCode = $(this).val();
                        if (itiCode) {
                            loadTrades(itiCode);
                        } else {
                            $('#trade_select').html('<option value="">--Select Trade--</option>');
                        }
                    });

                    $('#btn_proceed').on('click', function () {
                        const itiCode = $('#iti_select').val();
                        const tradeCode = $('#trade_select').val();
                        if (!itiCode || !tradeCode) {
                            alert('Please select both ITI and Trade');
                            return;
                        }
                        fetchDetails(itiCode, tradeCode);
                    });

                    $('#btn_reset').on('click', function () {
                        $('#iti_select').val('');
                        $('#trade_select').html('<option value="">--Select Trade--</option>');
                        $('#results_container').hide();
                    });

                    $('#btn_save').on('click', function () {
                        saveChanges();
                    });
                });

                function loadItis() {
                    showLoader(true);
                    fetch('/api/iti-list', { credentials: 'include' })
                        .then(res => res.json())
                        .then(data => {
                            showLoader(false);
                            if (data.error) {
                                alert('Error: ' + data.error);
                                return;
                            }
                            if (!Array.isArray(data)) return;
                            let options = '<option value="">--Select ITI--</option>';
                            data.forEach(iti => {
                                options += `<option value="\${iti.iti_code}">\${iti.iti_name}</option>`;
                            });
                            $('#iti_select').empty().html(options);
                        })
                        .catch(err => {
                            showLoader(false);
                            alert('Failed to connect to backend server.');
                        });
                }

                function loadTrades(itiCode) {
                    showLoader(true);
                    fetch(`/api/trade-list?iti_code=\${itiCode}`, { credentials: 'include' })
                        .then(res => res.json())
                        .then(data => {
                            showLoader(false);
                            if (data.error) {
                                alert('Error: ' + data.error);
                                return;
                            }
                            if (!Array.isArray(data)) return;
                            let options = '<option value="">--Select Trade--</option>';
                            data.forEach(trade => {
                                options += `<option value="\${trade.trade_code}">\${trade.trade_name}</option>`;
                            });
                            $('#trade_select').html(options);
                        })
                        .catch(err => {
                            showLoader(false);
                            console.error('Error loading trades:', err);
                        });
                }

                function fetchDetails(itiCode, tradeCode) {
                    showLoader(true);
                    fetch('/api/district-log', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ district_id: 'dummy', iti_code: itiCode, trade_code: tradeCode }),
                        credentials: 'include'
                    })
                        .then(res => res.json())
                        .then(data => {
                            showLoader(false);
                            if (data && data.length > 0) {
                                displayTable(data[0], itiCode, tradeCode);
                            } else {
                                alert('No data found for the selected ITI and Trade');
                            }
                        })
                        .catch(err => {
                            showLoader(false);
                            console.error('Error fetching details:', err);
                        });
                }

                function displayTable(info, itiCode, tradeCode) {
                    $('#iti_name_display').text(info.iti_name);
                    $('#results_container').show();
                    const tbody = $('#table_body');
                    tbody.empty();
                    const row = `
                        <tr data-iti="\${itiCode}" data-trade="\${tradeCode}">
                            <td class="text-center">1</td>
                            <td class="text-center">\${info.iti_name}</td>
                            <td class="text-center">\${info.iti_type || 'P'}</td>
                            <td>\${info.trade_name}</td>
                            <td>\${info.ncvt_code || 'N/A'}</td>
                            <td>
                                <div id="shifts_inputs_container">
                                    <div class="d-flex align-items-center mb-2 shift-row">
                                        <select class="form-select form-select-sm me-1 strength-select" style="width: 80px;">
                                            <option value="">--Select--</option>
                                            <option value="20">20</option>
                                            <option value="24">24</option>
                                        </select>
                                        <select class="form-select form-select-sm me-1 shift-select" style="width: 100px;">
                                            <option value="">--Select Shift--</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                        </select>
                                        <select class="form-select form-select-sm me-1 unit-select" style="width: 100px;">
                                            <option value="">--Select Unit--</option>
                                            \${generateUnitOptions()}
                                        </select>
                                        <button class="btn btn-add-more" onclick="addShiftRow(this)" style="background-color:green; color: white;">Add More</button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    `;
                    tbody.append(row);
                }

                function generateUnitOptions() {
                    let options = '';
                    for (let i = 1; i <= 12; i++) {
                        options += `<option value="\${i}">\${i}</option>`;
                    }
                    return options;
                }

                window.addShiftRow = function (btn) {
                    const container = $(btn).closest('#shifts_inputs_container');
                    const newRow = `
                        <div class="d-flex align-items-center mb-2 shift-row">
                            <select class="form-select form-select-sm me-1 strength-select" style="width: 80px;">
                                <option value="">--Select--</option>
                                <option value="20">20</option>
                                <option value="24">24</option>
                            </select>
                            <select class="form-select form-select-sm me-1 shift-select" style="width: 100px;">
                                <option value="">--Select Shift--</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                            <select class="form-select form-select-sm me-1 unit-select" style="width: 100px;">
                                <option value="">--Select Unit--</option>
                                \${generateUnitOptions()}
                            </select>
                            <button class="btn btn-remove" onclick="removeShiftRow(this)" style="background-color:red; color: white;">Remove</button>
                        </div>
                    `;
                    container.append(newRow);
                };

                window.removeShiftRow = function (btn) {
                    $(btn).closest('.shift-row').remove();
                };

                $('#btn_save').on('click', saveChanges);

                function saveChanges() {
                    const itiCode = $('#iti_select').val();
                    const tradeCode = $('#trade_select').val();
                    const shifts = [];
                    $('.shift-row').each(function () {
                        const strength = $(this).find('.strength-select').val();
                        const shift = $(this).find('.shift-select').val();
                        const unit = $(this).find('.unit-select').val();
                        if (strength && shift && unit) {
                            shifts.push({ strength, shift, unit });
                        }
                    });
                    if (shifts.length === 0) {
                        alert('Please select at least one complete shift configuration');
                        return;
                    }
                    showLoader(true);
                    $('#btn_save').prop('disabled', true);
                    
                    fetch('/api/save-dgt-shifts', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ iti_code: itiCode, trade_code: tradeCode, shifts: shifts }),
                        credentials: 'include'
                    })
                        .then(res => res.json())
                        .then(data => {
                            showLoader(false);
                            $('#btn_save').prop('disabled', false);
                            if (data.success) alert('Changes saved successfully!');
                            else alert('Error: ' + (data.error || 'Failed to save changes'));
                        })
                        .catch(err => {
                            showLoader(false);
                            $('#btn_save').prop('disabled', false);
                            alert('An error occurred while saving changes');
                        });
                }

                function showLoader(show) {
                    if (show) $('#loader').show();
                    else $('#loader').hide();
                }
            







</script>
        </body>

        </html>