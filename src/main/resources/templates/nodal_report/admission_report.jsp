<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admission Report | ITI Admissions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
    <style>
        /* DASHBOARD UI OVERRIDES */
        .nodal-page-title-dashboard {
            text-align: center;
            padding: 30px 0;
            color: #003366;
            font-weight: 800;
            background: #f8fbff;
            border-bottom: 1px solid #e1ecf8;
            margin-bottom: 40px;
        }
        .nodal-page-title-dashboard h2 {
            margin: 0;
            font-size: 1.6rem;
            letter-spacing: 0.5px;
        }
        .nodal-report-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 51, 102, 0.1);
        }
        .nodal-card-header-dashboard {
            background: linear-gradient(135deg, #003366 0%, #1a4a72 100%);
            color: white;
            padding: 22px 30px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .nodal-card-header-dashboard i {
            width: 38px;
            height: 38px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }

        /* OFFICIAL UI CLASSES */
        .form-label-official {
            font-size: 0.85rem;
            font-weight: 700;
            color: #445566;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 8px;
            display: block;
        }
        .form-select-official {
            border: 1px solid #ced4da;
            border-radius: 6px;
            padding: 8px 15px;
            font-size: 0.95rem;
            color: #2d3748;
            background-color: #ffffff;
            transition: border-color 0.2s ease;
            min-width: 150px;
        }
        .form-select-official:focus {
            border-color: #003366;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1);
        }
        .form-check-label-official {
            font-size: 0.95rem;
            font-weight: 500;
            color: #4a5568;
            cursor: pointer;
        }
        .btn-submit-official {
            background-color: #003366;
            color: white;
            padding: 9px 30px;
            border-radius: 6px;
            font-weight: 700;
            letter-spacing: 0.5px;
            border: none;
            transition: all 0.2s ease;
        }
        .btn-submit-official:hover {
            background-color: #002244;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2);
        }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="../header.jsp" %>
    
    <c:set var="activeTab" value="admission_report" />
    <%@ include file="nodal_navbar.jsp" %>
    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Industrial Training Institute — Trade-Wise Admissions Abstract</h2>
    </div>
        
        <!-- Unified Header and Selection Form -->
        <div class="nodal-report-card shadow-lg mb-5 mx-auto" style="max-width: 1000px;">
            <div class="nodal-card-header-dashboard">
                <i class="fas fa-filter me-2"></i> Report Selection Criteria
            </div>
            
            <div class="bg-white p-5" style="border-radius: 0 0 12px 12px;">
                <form action="${pageContext.request.contextPath}/nodal-report/reports/admission-report" method="post" id="admissionForm">
                    <div class="row g-4 align-items-end justify-content-center">
                        <!-- Year -->
                        <div class="col-auto">
                            <label for="year" class="form-label-official">Admission Year</label>
                            <select name="year" id="year" class="form-select-official w-100" required>
                                <c:if test="${not empty year}"><option value="${year}" selected>${year}</option></c:if>
                                <c:if test="${empty year}"><option value="">-- Select Year --</option></c:if>
                            </select>
                        </div>
                        
                        <!-- Caste -->
                        <div class="col-auto">
                            <label for="caste" class="form-label-official">Caste Category</label>
                            <select name="caste" id="caste" class="form-select-official w-100" style="min-width: 180px;">
                                <c:if test="${not empty caste}">
                                    <option value="${caste}" selected>${caste}</option>
                                </c:if>
                                <option value="All">All Categories</option>
                            </select>
                        </div>

                        <!-- PWD -->
                        <div class="col-auto">
                            <label class="form-label-official">PWD Status</label>
                            <div class="d-flex gap-3 py-2">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="pwd" id="pwd_yes" value="Yes" ${pwd == 'Yes' ? 'checked' : ''}>
                                    <label class="form-check-label form-check-label-official" for="pwd_yes">Yes</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="pwd" id="pwd_no" value="No" ${pwd == 'No' ? 'checked' : ''}>
                                    <label class="form-check-label form-check-label-official" for="pwd_no">No</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="pwd" id="pwd_all" value="All" ${empty pwd || pwd == 'All' ? 'checked' : ''}>
                                    <label class="form-check-label form-check-label-official" for="pwd_all">All</label>
                                </div>
                            </div>
                        </div>

                        <!-- Submit -->
                        <div class="col-auto">
                            <button type="submit" class="btn-submit-official">
                                <i class="fas fa-search me-2"></i>SUBMIT
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <c:if test="${not empty year}">
            <!-- Action Buttons -->
            <div class="no-print d-flex justify-content-center flex-wrap gap-3 mb-5" style="max-width: 900px; margin: 0 auto;">
                <button class="btn btn-outline-secondary fw-bold px-4" onclick="window.location.href='${pageContext.request.contextPath}/nodal-report/admission-report'" style="border-radius: 6px; font-size: 0.9rem;">
                    <i class="fas fa-arrow-left me-2"></i>BACK
                </button>
                <button class="btn btn-dark fw-bold px-4" style="border-radius: 6px; font-size: 0.9rem; padding: 10px 25px;" onclick="exportTableToExcel('admissionTable', 'Trade_Wise_Admissions_Report')">
                    <i class="fas fa-file-excel me-2"></i>EXCEL DOWNLOAD
                </button>
                <button class="btn text-white fw-bold px-4" onclick="window.print()" style="background-color: #337ab7; border-radius: 6px; font-size: 0.9rem;">
                    <i class="fas fa-print me-2"></i>PRINT REPORT
                </button>
            </div>
        </c:if>

        <c:if test="${not empty year}">
            <!-- Filter Summary -->
            <div class="mb-4 text-center" style="max-width: 900px; margin: 0 auto; color: #003366;">
                <h4 class="fw-bold mb-1" style="letter-spacing: 0.5px;">For Admission Year: ${year}</h4>
                <p class="mb-0 fw-bold opacity-75">Applied Filters: Caste [${caste}] <c:if test="${not empty pwd}">| PWD [${pwd}]</c:if></p>
            </div>

            <!-- Report Table -->
            <div class="nodal-report-card shadow-lg mx-auto" style="max-width: 1000px;">
                <div class="nodal-card-header-dashboard">
                    <i class="fas fa-list-alt me-2"></i> Trade-Wise Admissions — Results
                </div>
                <div class="table-responsive">
                    <table class="nodal-table table-bordered mb-0" id="admissionTable">
                        <thead>
                            <tr>
                                <th style="width: 50px;">#</th>
                                <th style="text-align: left;">TRADE NAME</th>
                                <th style="width: 100px;">BOYS</th>
                                <th style="width: 100px;">GIRLS</th>
                                <th style="width: 100px;">TOTAL</th>
                            </tr>
                        </thead>
                        <tbody style="font-size: 1.05rem;">
                            <c:if test="${empty data}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted fw-bold py-4">No admission data available for selected filters.</td>
                                </tr>
                            </c:if>
                            <c:forEach items="${data}" var="trade" varStatus="loop">
                                <tr style="border-bottom: 1px solid #e2e8f0;">
                                    <td style="font-weight: 600;">${loop.index + 1}</td>
                                    <td class="text-start" style="padding-left: 20px; color: #800000; font-weight: 800;">${trade.trade_name}</td>
                                    <td style="font-weight: 700;">${trade.boys}</td>
                                    <td style="font-weight: 700;">${trade.girls}</td>
                                    <td style="font-weight: 900; color: #dc2626;">${trade.total}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        
                        <c:if test="${not empty totals}">
                            <tfoot class="nodal-total-row">
                                <tr style="font-size: 1.1rem; border-top: 2px solid #003366;">
                                    <td colspan="2" style="text-align: center; padding: 15px; font-weight: 900;">GRAND TOTAL</td>
                                    <td style="font-weight: 900;">${totals.boys}</td>
                                    <td style="font-weight: 900;">${totals.girls}</td>
                                    <td style="font-weight: 900; color: #dc2626;">${totals.total}</td>
                                </tr>
                            </tfoot>
                        </c:if>
                    </table>
                </div>
            </div>
            
            <c:if test="${not empty error}">
                <div class="nodal-report-card shadow-lg mx-auto mt-4 p-4 text-center text-danger" style="max-width: 900px; background-color: #FED7D7; border: 1px solid #E53E3E;">
                    ${error}
                </div>
            </c:if>
        </c:if>
    </div>

    <!-- Scripts -->
    <script>
        const API = '${pageContext.request.contextPath}/nodal-report'; 

        async function fetchJSON(url) {
            try {
                const r = await fetch(url);
                if (!r.ok) throw new Error('HTTP ' + r.status);
                return await r.json();
            } catch (e) {
                console.error('Fetch error:', url, e);
                return [];
            }
        }

        async function loadMetadata() {
            const data = await fetchJSON(API + '/api/metadata');
            const yearSel = document.getElementById('year');
            const casteSel = document.getElementById('caste');
            const selectedYear = '${year}';
            const selectedCaste = '${caste}';
            
            if(data.years && data.years.length > 0) {
                data.years.forEach(y => {
                    if (y != selectedYear) {
                        const o = document.createElement('option');
                        o.value = y;
                        o.textContent = y;
                        yearSel.appendChild(o);
                    }
                });
            }

            if(data.castes && data.castes.length > 0) {
                data.castes.forEach(c => {
                    if (c != selectedCaste) {
                        const o = document.createElement('option');
                        o.value = c;
                        o.textContent = c;
                        casteSel.appendChild(o);
                    }
                });
            }
        }

        document.addEventListener('DOMContentLoaded', loadMetadata);

        function exportTableToExcel(tableID, filename = ''){
            var tableSelect = document.getElementById(tableID);
            if (!tableSelect) return;
            var html = tableSelect.outerHTML;
            var blob = new Blob(['\ufeff', html], {
                type: "application/vnd.ms-excel"
            });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = filename ? filename + '.xls' : 'excel_data.xls';
            a.click();
            URL.revokeObjectURL(url);
        }

        // Auto-scroll to report if results are present on page load
        window.addEventListener('load', function() {
            const reportTable = document.getElementById('admissionTable');
            if (reportTable) {
                setTimeout(() => {
                    reportTable.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }, 400);
            }
        });
    </script>
</body>
</html>
