<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Shift & Unit Permitted Configuration</title>
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
        .details-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 25px;
            background-color: #fff;
        }
        .details-card-header {
            background-color: #212529;
            color: white;
            padding: 12px 18px;
            font-size: 18px;
            font-weight: 600;
        }
        .details-card-body {
            padding: 20px;
        }
        .detail-label {
            font-weight: 600;
            color: #555;
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
        .success-message {
            text-align: center;
            padding: 15px;
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 16px;
        }
        .validation-error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            font-weight: 600;
        }
        .btn-save {
            min-width: 180px;
        }
        .btn-back {
            min-width: 180px;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
</head>

<body>
    <!-- Global Header -->
    <header>
        <%@ include file="../bannernew.jsp" %>
    </header>

    <div class="container-fluid px-5 mt-4 mb-5" style="min-height: 50vh;">
        <!-- Page Header & Breadcrumbs -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="page-title text-uppercase">Shift & Unit Permitted Configuration</h2>
            <div class="breadcrumb-text">Home / Shift Unit Permitted</div>
        </div>

        <!-- Missing ITI/Trade Message -->
        <div id="missingInfoMessage" class="error-message" style="display: none;">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <span id="missingInfoText"></span>
            <br><br>
            <a href="${pageContext.request.contextPath}/iti-trade-selection" class="btn btn-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Trade Selection
            </a>
        </div>

        <!-- Main Content -->
        <div id="mainContent" style="display: none;">
            <!-- Selected ITI Card -->
            <div class="details-card">
                <div class="details-card-header">
                    <i class="fas fa-building"></i> Selected ITI
                </div>
                <div class="details-card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>ITI Code:</strong> <span id="selectedItiCode"></span></p>
                            <p class="mb-0"><strong>ITI Name:</strong> <span id="selectedItiName"></span></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Selected Trade Card -->
            <div class="details-card">
                <div class="details-card-header">
                    <i class="fas fa-tools"></i> Selected Trade
                </div>
                <div class="details-card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Trade Code:</strong> <span id="selectedTradeCode"></span></p>
                            <p class="mb-0"><strong>Trade:</strong> <span id="selectedTradeShort"></span></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Configuration Section -->
            <div class="details-card">
                <div class="details-card-header">
                    <i class="fas fa-cogs"></i> Configuration
                </div>
                <div class="details-card-body">
                    <!-- Available for Year -->
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="detail-label">Available for Year</label>
                            <select class="form-select" id="availableYear">
                                <option value="false">No</option>
                                <option value="true">Yes</option>
                            </select>
                        </div>
                    </div>

                    <!-- Entries Table -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0" style="color: #444;">Shift & Unit Entries</h5>
                        <button class="btn btn-success" id="addEntryBtn">
                            <i class="fas fa-plus me-2"></i>Add Entry
                        </button>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped" id="entriesTable">
                            <thead>
                                <tr>
                                    <th>Strength</th>
                                    <th>Shift</th>
                                    <th>Unit</th>
                                    <th>Strength Vacant</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="entriesTableBody">
                                <tr id="emptyRow">
                                    <td colspan="5" class="text-center">No entries configured. Click "Add Entry" to add one.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div id="entriesValidationError" class="validation-error" style="display: none;"></div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex justify-content-between mt-4">
                <a href="${pageContext.request.contextPath}/iti-trade-selection" class="btn btn-secondary btn-back">
                    <i class="fas fa-arrow-left me-2"></i>Back to Trade Selection
                </a>
                <button class="btn btn-primary btn-save" id="saveBtn">
                    <i class="fas fa-save me-2"></i>Save Configuration
                </button>
            </div>

            <!-- Success Message -->
            <div id="successMessage" class="success-message" style="display: none;">
                <i class="fas fa-check-circle me-2"></i>
                <span id="successText"></span>
            </div>

            <!-- Loading Message -->
            <div id="loadingMessage" class="loading-message" style="display: none;">
                <i class="fas fa-spinner fa-spin me-2"></i> <span id="loadingText">Loading configuration...</span>
            </div>

            <!-- Error Message -->
            <div id="errorMessage" class="error-message" style="display: none;">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <span id="errorText"></span>
            </div>
        </div>
    </div>

    <!-- Global Footer -->
    <footer>
        <%@ include file="../footer.jsp" %>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const apiUrl = "${shiftUnitApiUrl}";

            // URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const itiCode = urlParams.get("itiCode");
            const tradeCode = urlParams.get("tradeCode");
            const itiName = urlParams.get("itiName");
            const tradeShort = urlParams.get("tradeShort");

            // DOM elements
            const missingInfoMessage = document.getElementById("missingInfoMessage");
            const missingInfoText = document.getElementById("missingInfoText");
            const mainContent = document.getElementById("mainContent");
            const selectedItiCode = document.getElementById("selectedItiCode");
            const selectedItiName = document.getElementById("selectedItiName");
            const selectedTradeCode = document.getElementById("selectedTradeCode");
            const selectedTradeShort = document.getElementById("selectedTradeShort");
            const availableYearSelect = document.getElementById("availableYear");
            const entriesTableBody = document.getElementById("entriesTableBody");
            const emptyRow = document.getElementById("emptyRow");
            const addEntryBtn = document.getElementById("addEntryBtn");
            const saveBtn = document.getElementById("saveBtn");
            const successMessage = document.getElementById("successMessage");
            const successText = document.getElementById("successText");
            const loadingMessage = document.getElementById("loadingMessage");
            const loadingText = document.getElementById("loadingText");
            const errorMessage = document.getElementById("errorMessage");
            const errorText = document.getElementById("errorText");
            const entriesValidationError = document.getElementById("entriesValidationError");

            let entries = [];
            let isSaving = false;

            // Initialize page
            initializePage();

            function initializePage() {
                // Validate required parameters
                if (!itiCode || !tradeCode) {
                    if (!itiCode) {
                        missingInfoText.textContent = "ITI information is missing. Please return to ITI Trade Selection.";
                    } else if (!tradeCode) {
                        missingInfoText.textContent = "Trade information is missing. Please return to ITI Trade Selection.";
                    }
                    missingInfoMessage.style.display = "block";
                    mainContent.style.display = "none";
                    return;
                }

                // Display selected ITI and Trade
                selectedItiCode.textContent = escapeHtml(itiCode);
                selectedItiName.textContent = escapeHtml(itiName || 'N/A');
                selectedTradeCode.textContent = escapeHtml(tradeCode);
                selectedTradeShort.textContent = escapeHtml(tradeShort || 'N/A');

                missingInfoMessage.style.display = "none";
                mainContent.style.display = "block";

                // Load existing configuration
                loadExistingConfiguration();

                // Add event listeners
                addEntryBtn.addEventListener("click", addEntry);
                saveBtn.addEventListener("click", saveConfiguration);
            }

            function loadExistingConfiguration() {
                showLoading(true, "Loading configuration...");
                hideMessages();

                const url = apiUrl + '?itiCode=' + encodeURIComponent(itiCode) + '&tradeCode=' + encodeURIComponent(tradeCode);

                fetch(url)
                    .then(response => {
                        if (!response.ok) {
                            if (response.status === 404) {
                                // No existing configuration, start fresh
                                return null;
                            }
                            throw new Error("HTTP error! status: " + response.status);
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data && data.entries) {
                            // Populate existing configuration
                            availableYearSelect.value = String(data.availableYear);
                            entries = data.entries.map(entry => ({
                                strength: entry.strength,
                                shiftAllowed: entry.shiftAllowed,
                                unitAllowed: entry.unitAllowed,
                                strengthVacant: entry.strengthVacant
                            }));
                            renderEntries();
                        } else {
                            // Start with empty configuration
                            entries = [];
                            renderEntries();
                        }
                        showLoading(false);
                    })
                    .catch(error => {
                        console.error("Error loading configuration:", error);
                        showError("Unable to load configuration. Please try again.");
                        showLoading(false);
                        entries = [];
                        renderEntries();
                    });
            }

            function renderEntries() {
                entriesTableBody.innerHTML = "";

                if (entries.length === 0) {
                    const emptyRowClone = document.createElement("tr");
                    emptyRowClone.id = "emptyRow";
                    emptyRowClone.innerHTML = '<td colspan="5" class="text-center">No entries configured. Click "Add Entry" to add one.</td>';
                    entriesTableBody.appendChild(emptyRowClone);
                    return;
                }

                entries.forEach((entry, index) => {
                    const row = document.createElement("tr");
                    row.innerHTML = `
                        <td>
                            <select class="form-select form-select-sm strength-select" data-index="\${index}">
                                <option value="20" \${entry.strength === 20 ? 'selected' : ''}>20</option>
                                <option value="24" \${entry.strength === 24 ? 'selected' : ''}>24</option>
                            </select>
                        </td>
                        <td>
                            <select class="form-select form-select-sm shift-select" data-index="\${index}">
                                <option value="1" \${entry.shiftAllowed === 1 ? 'selected' : ''}>1</option>
                                <option value="2" \${entry.shiftAllowed === 2 ? 'selected' : ''}>2</option>
                                <option value="3" \${entry.shiftAllowed === 3 ? 'selected' : ''}>3</option>
                            </select>
                        </td>
                        <td>
                            <select class="form-select form-select-sm unit-select" data-index="\${index}">
                                \${generateUnitOptions(entry.unitAllowed)}
                            </select>
                        </td>
                        <td>
                            <input type="number" class="form-control form-control-sm strength-vacant-input" 
                                   data-index="\${index}" value="\${entry.strengthVacant}" min="0" style="width: 100px;">
                        </td>
                        <td>
                            <button class="btn btn-danger btn-sm remove-entry-btn" data-index="\${index}">
                                <i class="fas fa-trash"></i> Remove
                            </button>
                        </td>
                    `;
                    entriesTableBody.appendChild(row);
                });

                // Add event listeners
                document.querySelectorAll('.remove-entry-btn').forEach(btn => {
                    btn.addEventListener('click', function() {
                        const index = parseInt(this.getAttribute('data-index'));
                        removeEntry(index);
                    });
                });
            }

            function generateUnitOptions(selectedValue) {
                let options = '';
                for (let i = 1; i <= 12; i++) {
                    options += `<option value="\${i}" \${i === selectedValue ? 'selected' : ''}>\${i}</option>`;
                }
                return options;
            }

            function addEntry() {
                entries.push({
                    strength: 20,
                    shiftAllowed: 1,
                    unitAllowed: 1,
                    strengthVacant: 0
                });
                renderEntries();
                hideMessages();
            }

            function removeEntry(index) {
                entries.splice(index, 1);
                renderEntries();
                hideMessages();
            }

            function validateEntries() {
                const errors = [];

                // Get current values from DOM
                const strengthSelects = document.querySelectorAll('.strength-select');
                const shiftSelects = document.querySelectorAll('.shift-select');
                const unitSelects = document.querySelectorAll('.unit-select');
                const vacantInputs = document.querySelectorAll('.strength-vacant-input');

                // Check at least one entry exists
                if (strengthSelects.length === 0) {
                    errors.push("At least one shift and unit entry is required.");
                    return errors;
                }

                // Validate each entry
                const shiftUnitMap = new Map();

                for (let i = 0; i < strengthSelects.length; i++) {
                    const strength = parseInt(strengthSelects[i].value);
                    const shift = parseInt(shiftSelects[i].value);
                    const unit = parseInt(unitSelects[i].value);
                    const vacant = parseInt(vacantInputs[i].value) || 0;

                    // Validate strength
                    if (strength !== 20 && strength !== 24) {
                        errors.push(`Entry ${i + 1}: Strength must be either 20 or 24.`);
                    }

                    // Validate shift
                    if (shift < 1 || shift > 3) {
                        errors.push(`Entry ${i + 1}: Shift must be between 1 and 3.`);
                    }

                    // Validate unit
                    if (unit < 1 || unit > 12) {
                        errors.push(`Entry ${i + 1}: Unit must be between 1 and 12.`);
                    }

                    // Validate strength vacant
                    if (vacant < 0) {
                        errors.push(`Entry ${i + 1}: Strength vacant cannot be negative.`);
                    }

                    // Check for duplicate shift + unit combinations
                    const shiftUnitKey = `${shift}-${unit}`;
                    if (shiftUnitMap.has(shiftUnitKey)) {
                        errors.push(`Entry ${i + 1}: Shift ${shift} and Unit ${unit} are already configured.`);
                    } else {
                        shiftUnitMap.set(shiftUnitKey, true);
                    }
                }

                return errors;
            }

            function buildPayload() {
                // Read current values from DOM
                const updatedEntries = [];
                const strengthSelects = document.querySelectorAll('.strength-select');
                const shiftSelects = document.querySelectorAll('.shift-select');
                const unitSelects = document.querySelectorAll('.unit-select');
                const vacantInputs = document.querySelectorAll('.strength-vacant-input');

                for (let i = 0; i < entries.length; i++) {
                    updatedEntries.push({
                        strength: parseInt(strengthSelects[i].value),
                        shiftAllowed: parseInt(shiftSelects[i].value),
                        unitAllowed: parseInt(unitSelects[i].value),
                        strengthVacant: parseInt(vacantInputs[i].value) || 0
                    });
                }

                return {
                    itiCode: String(itiCode),
                    tradeCode: String(tradeCode),
                    availableYear: availableYearSelect.value === "true",
                    entries: updatedEntries
                };
            }

            function saveConfiguration() {
                if (isSaving) {
                    return;
                }

                hideMessages();

                // Validate entries
                const errors = validateEntries();
                if (errors.length > 0) {
                    entriesValidationError.textContent = errors.join(" ");
                    entriesValidationError.style.display = "block";
                    return;
                }

                // Build payload
                const payload = buildPayload();

                // Send PUT request
                isSaving = true;
                saveBtn.disabled = true;
                showLoading(true, "Saving...");
              console.log("========== SAVE CONFIGURATION ==========");
console.log("API URL:", apiUrl);
console.log("Payload:", payload);
console.log("========================================");
                fetch(apiUrl, {
                    method: "PUT",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(payload)
                })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(data => {
                            throw { status: response.status, data: data };
                        }).catch(() => {
                            throw { status: response.status, data: null };
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    showSuccess("Shift and unit configuration saved successfully.");
                    showLoading(false);
                    isSaving = false;
                    saveBtn.disabled = false;
                })
                .catch(error => {
                    console.error("Error saving configuration:", error);
                    showLoading(false);
                    isSaving = false;
                    saveBtn.disabled = false;

                    if (error.status) {
                        if (error.status === 400) {
                            showError("Invalid data provided. Please check your entries.");
                        } else if (error.status === 409) {
                            showError("Duplicate shift and unit combination detected.");
                        } else if (error.status === 404) {
                            showError("Resource not found. Please try again.");
                        } else if (error.status === 500) {
                            showError("Server error. Please try again later.");
                        } else {
                            showError("Failed to save configuration. Please try again.");
                        }
                    } else {
                        showError("Unable to connect to the server. Please check whether the backend is running.");
                    }
                });
            }

            function showLoading(show, text) {
                loadingMessage.style.display = show ? "block" : "none";
                if (text) {
                    loadingText.textContent = text;
                }
                if (show) {
                    mainContent.style.opacity = "0.6";
                    mainContent.style.pointerEvents = "none";
                } else {
                    mainContent.style.opacity = "1";
                    mainContent.style.pointerEvents = "auto";
                }
            }

            function showSuccess(message) {
                successText.textContent = message;
                successMessage.style.display = "block";
                setTimeout(() => {
                    successMessage.style.display = "none";
                }, 5000);
            }

            function showError(message) {
                errorText.textContent = message;
                errorMessage.style.display = "block";
            }

            function hideMessages() {
                errorMessage.style.display = "none";
                successMessage.style.display = "none";
                entriesValidationError.style.display = "none";
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