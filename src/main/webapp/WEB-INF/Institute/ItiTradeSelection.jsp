<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>ITI TRADE SELECTION</title>
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
        .selection-area {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #dee2e6;
        }
        .details-area {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #dee2e6;
        }
        .loading-message {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }
        .error-message {
            text-align: center;
            padding: 40px;
            color: #dc3545;
            font-size: 16px;
        }
        .radio-cell {
            text-align: center;
            width: 60px;
        }
        .btn-continue {
            min-width: 150px;
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
            <h2 class="page-title text-uppercase">ITI TRADE SELECTION</h2>
            <div class="breadcrumb-text">Home / ITI Trade Selection</div>
        </div>

        <!-- ITI Selection Area -->
        <div class="selection-area">
            <h5 class="mb-3" style="color: #444;">Select ITI</h5>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="itiSelect" class="form-label fw-bold">ITI:</label>
                    <select class="form-select" id="itiSelect">
                        <option value="">-- Select ITI --</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Selected ITI Details -->
        <div class="details-area" id="itiDetails" style="display: none;">
            <h5 class="mb-3" style="color: #444;">Selected ITI Details</h5>
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-1"><strong>ITI Code:</strong> <span id="selectedItiCode"></span></p>
                    <p class="mb-0"><strong>ITI Name:</strong> <span id="selectedItiName"></span></p>
                </div>
            </div>
        </div>

        <!-- Trades Table Area -->
        <div id="tradesArea" style="display: none;">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="m-0" style="color: #444;">Trades Available in This ITI</h4>
                <div class="text-muted" id="tradeCount">Showing 0 entries</div>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th class="radio-cell">Select</th>
                            <th>Trade Code</th>
                            <th>Trade</th>
                            <th>Strength</th>
                            <th>Units</th>
                            <th>Available</th>
                        </tr>
                    </thead>
                    <tbody id="tradeTableBody">
                        <tr>
                            <td colspan="6" class="text-center">Please select an ITI to load trades.</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Loading Message -->
        <div id="loadingMessage" class="loading-message" style="display: none;">
            <i class="fas fa-spinner fa-spin me-2"></i> Loading trades...
        </div>

        <!-- Error Message -->
        <div id="errorMessage" class="error-message" style="display: none;">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <span id="errorText"></span>
        </div>

        <!-- Empty Result Message -->
        <div id="emptyMessage" class="loading-message" style="display: none;">
            No trades are currently associated with this ITI.
        </div>

        <!-- Continue Button -->
        <div class="d-flex justify-content-end mt-4">
            <button class="btn btn-primary btn-continue" id="continueBtn" disabled>
                Continue <i class="fas fa-arrow-right ms-2"></i>
            </button>
        </div>
    </div>

    <!-- Global Footer -->
    <footer>
        <%@ include file="../reports/footer.jsp" %>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const itiSelect = document.getElementById("itiSelect");
            const itiDetails = document.getElementById("itiDetails");
            const selectedItiCode = document.getElementById("selectedItiCode");
            const selectedItiName = document.getElementById("selectedItiName");
            const tradesArea = document.getElementById("tradesArea");
            const tradeTableBody = document.getElementById("tradeTableBody");
            const tradeCount = document.getElementById("tradeCount");
            const continueBtn = document.getElementById("continueBtn");
            const loadingMessage = document.getElementById("loadingMessage");
            const errorMessage = document.getElementById("errorMessage");
            const errorText = document.getElementById("errorText");
            const emptyMessage = document.getElementById("emptyMessage");

            const itiApiUrl = "${itiApiUrl}";
            const backendBaseUrl = "${backendApiBaseUrl}";

            let allItis = [];
            let currentTrades = [];
            let selectedTrade = null;

            // Load ITI list on page load
            fetchItiList();

            // ITI selection change handler
            itiSelect.addEventListener("change", function () {
                const itiCode = this.value;
                if (itiCode) {
                    loadTradesForIti(itiCode);
                } else {
                    resetTradeSection();
                }
            });

            // Continue button click handler
            continueBtn.addEventListener("click", function () {
                if (selectedTrade) {
                    goToShiftUnitPage(selectedTrade);
                }
            });

            function fetchItiList() {
                fetch(itiApiUrl)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("Failed to fetch ITI list");
                        }
                        return response.json();
                    })
                    .then(data => {
                        allItis = data;
                        populateItiDropdown(allItis);

                        // Check if itiCode is provided in URL
                        const urlParams = new URLSearchParams(window.location.search);
                        const urlItiCode = urlParams.get('itiCode');
                        if (urlItiCode) {
                            itiSelect.value = urlItiCode;
                            loadTradesForIti(urlItiCode);
                        }
                    })
                    .catch(error => {
                        console.error("Error loading ITI list:", error);
                        errorText.textContent = "Unable to load ITI list. Please refresh the page.";
                        errorMessage.style.display = "block";
                    });
            }

            function populateItiDropdown(itis) {
                itiSelect.innerHTML = '<option value="">-- Select ITI --</option>';
                itis.forEach(iti => {
                    const option = document.createElement("option");
                    option.value = iti.itiCode;
                    option.textContent = (iti.itiCode || '') + ' - ' + (iti.itiName || 'Unknown ITI');
                    itiSelect.appendChild(option);
                });
            }

            function loadTradesForIti(itiCode) {
                showLoading(true);
                hideMessages();

                const url = backendBaseUrl + '/api/ititrades/' + encodeURIComponent(itiCode);

                fetch(url)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("HTTP error! status: " + response.status);
                        }
                        return response.json();
                    })
                    .then(data => {
                        currentTrades = data;
                        renderTrades(currentTrades);
                        updateSelectedItiDetails(itiCode);
                        showLoading(false);
                    })
                    .catch(error => {
                        console.error("Error loading trades:", error);
                        errorText.textContent = "Unable to load trades for the selected ITI. Please try again.";
                        errorMessage.style.display = "block";
                        showLoading(false);
                        resetTradeSection();
                    });
            }

            function renderTrades(trades) {
                tradeTableBody.innerHTML = "";

                if (trades.length === 0) {
                    emptyMessage.style.display = "block";
                    tradesArea.style.display = "none";
                    continueBtn.disabled = true;
                    selectedTrade = null;
                    tradeCount.textContent = "Showing 0 entries";
                    return;
                }

                emptyMessage.style.display = "none";
                tradesArea.style.display = "block";

                trades.forEach((trade, index) => {
                    const tr = document.createElement("tr");

                    const isAvailable = trade.availableforyear === "1" || trade.availableforyear === 1;

                   tr.innerHTML = `
    <td class="radio-cell">
        <input type="radio" name="tradeRadio" value="\${index}" class="trade-radio">
    </td>
    <td>\${escapeHtml(trade.tradecode)}</td>
    <td><strong>\${escapeHtml(trade.tradeshort)}</strong></td>
    <td>\${escapeHtml(String(trade.strength))}</td>
    <td>\${escapeHtml(String(trade.no_of_units))}</td>
    <td>\${isAvailable
        ? '<span class="text-success fw-bold">Yes</span>'
        : '<span class="text-danger">No</span>'}</td>
`;

tradeTableBody.appendChild(tr);
                });

                tradeCount.textContent = `Showing ${trades.length} entries`;

                // Add event listeners to radio buttons
                const radioButtons = document.querySelectorAll('.trade-radio');
                radioButtons.forEach(radio => {
                    radio.addEventListener('change', handleTradeSelection);
                });
            }

            function handleTradeSelection(event) {
                const selectedIndex = parseInt(event.target.value);
                selectedTrade = currentTrades[selectedIndex];
                continueBtn.disabled = false;
            }

            function updateSelectedItiDetails(itiCode) {
                const iti = allItis.find(i => i.itiCode === itiCode);
                if (iti) {
                    selectedItiCode.textContent = iti.itiCode || '';
                    selectedItiName.textContent = iti.itiName || '';
                    itiDetails.style.display = "block";
                }
            }

            function goToShiftUnitPage(trade) {
                const itiCode = itiSelect.value;
                const tradeCode = String(trade.tradecode);
                const tradeShort = trade.tradeshort;

                const url =
                    'ShiftUnitPermitted.jsp?itiCode=' + encodeURIComponent(itiCode) +
                    '&tradeCode=' + encodeURIComponent(tradeCode) +
                    '&tradeShort=' + encodeURIComponent(tradeShort);

                window.location.href = url;
            }

            function showLoading(show) {
                loadingMessage.style.display = show ? "block" : "none";
                if (show) {
                    tradesArea.style.display = "none";
                    emptyMessage.style.display = "none";
                    errorMessage.style.display = "none";
                }
            }

            function hideMessages() {
                errorMessage.style.display = "none";
                emptyMessage.style.display = "none";
            }

            function resetTradeSection() {
                currentTrades = [];
                selectedTrade = null;
                tradeTableBody.innerHTML = '<tr><td colspan="6" class="text-center">Please select an ITI to load trades.</td></tr>';
                tradesArea.style.display = "none";
                itiDetails.style.display = "none";
                continueBtn.disabled = true;
                tradeCount.textContent = "Showing 0 entries";
            }

            function escapeHtml(text) {
                const div = document.createElement('div');
                div.textContent = text;
                return div.innerHTML;
            }
        });
    </script>
</body>

</html>