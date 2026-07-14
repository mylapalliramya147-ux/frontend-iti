<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>ITI Admissions | Trade Duration Seats</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
            <link rel="stylesheet"
                href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <style>
                body {
                    background-color: #e0effd !important;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }

                /* --- DASHBOARD NAVBAR --- */
                .nodal-dashboard-navbar {
                    background: #002244;
                    padding: 0;
                    display: flex;
                    justify-content: center;
                    flex-wrap: wrap;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                    margin-bottom: 2.5rem;
                }

                .nodal-dashboard-link {
                    padding: 18px 25px;
                    color: rgba(255, 255, 255, 0.7) !important;
                    text-decoration: none;
                    font-size: 0.72rem;
                    font-weight: 800;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    transition: all 0.25s ease;
                    border-bottom: 4px solid transparent;
                }

                .nodal-dashboard-link:hover {
                    color: #ffffff !important;
                    background: rgba(255, 255, 255, 0.05);
                }

                .nodal-dashboard-link.active {
                    color: #ffffff !important;
                    background: rgba(255, 255, 255, 0.1);
                    border-bottom-color: #ffd700;
                }

                /* --- TITLE --- */
                .custom-page-title {
                    color: #003366;
                    font-weight: 800;
                    text-align: center;
                    margin: 60px 0 40px;
                    font-size: 1.8rem;
                    max-width: 800px;
                    margin-left: auto;
                    margin-right: auto;
                    line-height: 1.3;
                }

                /* --- SELECTION CARD --- */
                .selection-card {
                    background: #ffffff;
                    border-radius: 12px;
                    box-shadow: 0 15px 40px rgba(0, 51, 102, 0.1);
                    padding: 50px 60px;
                    max-width: 750px;
                    margin: 0 auto;
                }

                .form-row {
                    display: flex;
                    align-items: center;
                    margin-bottom: 25px;
                }

                .form-label-custom {
                    flex: 0 0 250px;
                    font-weight: 800;
                    font-size: 0.8rem;
                    color: #4b5563;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                .form-input-custom {
                    flex: 1;
                }

                .form-select-custom {
                    border-radius: 8px;
                    border: 1px solid #d1d5db;
                    padding: 12px 15px;
                    font-size: 0.95rem;
                    color: #374151;
                    width: 100%;
                }

                /* --- RADIO BUTTONS --- */
                .radio-group {
                    display: flex;
                    gap: 30px;
                    align-items: center;
                }

                .radio-item {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    cursor: pointer;
                    font-weight: 800;
                    font-size: 0.9rem;
                    color: #374151;
                    text-transform: uppercase;
                }

                .radio-item input {
                    width: 18px;
                    height: 18px;
                    cursor: pointer;
                }

                /* --- BUTTON --- */
                .btn-generate {
                    background-color: #337ab7;
                    color: white;
                    font-weight: 800;
                    padding: 12px 30px;
                    border-radius: 8px;
                    border: none;
                    float: right;
                    text-transform: uppercase;
                    font-size: 0.85rem;
                    transition: background 0.2s;
                    margin-top: 10px;
                }

                .btn-generate:hover {
                    background-color: #286090;
                    color: white;
                }

                .clearfix::after {
                    content: "";
                    clear: both;
                    display: table;
                }
            </style>
        </head>

        <body>
            <c:set var="hideNavbar" value="true" scope="request" />
            <%@ include file="../header.jsp" %>

                <c:set var="activeTab" value="trade_duration" />
                <%@ include file="nodal_navbar.jsp" %>

                    <div class="container pb-5">
                        <h2 class="custom-page-title">Govt Or Private ITIs Seats Abstract For Different Duration Trades
                        </h2>

                        <div class="selection-card">
                            <form
                                action="${pageContext.request.contextPath}/nodal-report/reports/trade-duration-seats-abstract"
                                method="post" id="tradeForm">

                                <!-- Academic Year -->
                                <div class="form-row">
                                    <label class="form-label-custom">ACADEMIC YEAR</label>
                                    <div class="form-input-custom">
                                        <select name="year" id="year" class="form-select-custom" required>
                                            <option value="">-- Select Year --</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Trade Duration -->
                                <div class="form-row">
                                    <label class="form-label-custom">TRADE DURATION</label>
                                    <div class="form-input-custom">
                                        <select name="duration_months" id="duration_months" class="form-select-custom"
                                            required>
                                            <option value="">-- Select Duration --</option>
                                            <option value="6">6 Months</option>
                                            <option value="12">12 Months</option>
                                            <option value="15">15 Months</option>
                                            <option value="24">24 Months</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- ITIs Type -->
                                <div class="form-row">
                                    <label class="form-label-custom">ITIS TYPE</label>
                                    <div class="form-input-custom">
                                        <div class="radio-group">

                                            <label class="radio-item">
                                                <input type="radio" name="iti_type" value="G" required> GOVT
                                            </label>
                                            <label class="radio-item">
                                                <input type="radio" name="iti_type" value="P" required> PRIVATE
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix mt-4">
                                    <button type="submit" class="btn-generate">GENERATE REPORT</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
                    <script>
                        const API = '${pageContext.request.contextPath}/nodal-report';

                        async function fetchJSON(url) {
                            try {
                                const r = await fetch(url);
                                if (!r.ok) throw new Error('HTTP ' + r.status);
                                return await r.json();
                            } catch (e) {
                                console.error('Fetch error:', url, e);
                                return { years: ["2024", "2025"] };
                            }
                        }

                        async function loadMetadata() {
                            const data = await fetchJSON(API + '/api/metadata');
                            const yearSel = document.getElementById('year');

                            if (data.years && data.years.length > 0) {
                                // Sort years descending to show latest first
                                data.years.sort((a, b) => b - a).forEach(y => {
                                    const o = document.createElement('option');
                                    o.value = y;
                                    o.textContent = y;
                                    yearSel.appendChild(o);
                                });
                            }
                        }

                        document.addEventListener('DOMContentLoaded', loadMetadata);
                    </script>
        </body>

        </html>