<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI Admissions | Applicant Count Nodal Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            display: block;
        }
        .form-select-official {
            border: 1px solid #ced4da;
            border-radius: 6px;
            padding: 10px 15px; /* Larger padding */
            font-size: 1.05rem; /* Larger font */
            color: #2d3748;
            background-color: #ffffff;
            transition: border-color 0.2s ease;
        }
        .form-select-official:focus {
            border-color: #003366;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.1);
        }
        .btn-submit-official-navy {
            background-color: #003366;
            color: white;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 700;
            letter-spacing: 0.5px;
            border: none;
            transition: all 0.2s ease;
        }
        .btn-submit-official-navy:hover {
            background-color: #002244;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 34, 68, 0.2);
            color: white;
        }
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="../header.jsp" %>
    
    <c:set var="activeTab" value="nodal_report" />
    <%@ include file="nodal_navbar.jsp" %>
    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Industrial Training Institute — Nodal Report Selection</h2>
    </div>

    <div class="container mt-4">
        <div class="nodal-report-card shadow-lg" style="max-width: 550px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 12px;">
            <div class="nodal-card-header-dashboard" style="padding: 15px 25px;">
                <i class="fas fa-chart-line me-2"></i> Selection Criteria
            </div>
            <div class="p-5 bg-white rounded-bottom">
                <form action="${pageContext.request.contextPath}/nodal-report/reports/applicant-count-nodal" method="post" id="nodalForm">
                    <!-- Admission Year -->
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5">
                            <label for="year" class="form-label-official mb-md-0">Admission Year</label>
                        </div>
                        <div class="col-md-7">
                            <select name="year" id="year" class="form-select-official w-100" required>
                                <option value="">-- Select Year --</option>
                            </select>
                        </div>
                    </div>

                    <!-- Admission Phase -->
                    <div class="row align-items-center mb-4">
                        <div class="col-md-5">
                            <label for="phase" class="form-label-official mb-md-0">Admission Phase</label>
                        </div>
                        <div class="col-md-7">
                            <select name="phase" id="phase" class="form-select-official w-100" required>
                                <option value="">-- Select Phase --</option>
                            </select>
                        </div>
                    </div>

                    <div class="mt-5 text-center">
                        <button type="submit" class="btn-submit-official-navy w-100">
                            <i class="fas fa-search me-2"></i>VIEW NODAL REPORT
                        </button>
                        <p class="text-muted small mt-4 italic mb-0">
                            <i class="fas fa-info-circle me-1"></i> Data aggregated by district and institution type
                        </p>
                    </div>
                </form>
            </div>
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
                return { years: ["2024", "2025"], phases: ["1", "2", "3", "4", "5"] };
            }
        }

        async function loadMetadata() {
            const data = await fetchJSON(API + '/api/metadata');
            const yearSel = document.getElementById('year');
            const phaseSel = document.getElementById('phase');
            
            if(data.years && data.years.length > 0) {
                data.years.forEach(y => {
                    const o = document.createElement('option');
                    o.value = y;
                    o.textContent = y;
                    yearSel.appendChild(o);
                });
            }

            if(data.phases && data.phases.length > 0) {
                data.phases.forEach(p => {
                    const o = document.createElement('option');
                    o.value = p;
                    o.textContent = "Phase " + p;
                    phaseSel.appendChild(o);
                });
            }
        }

        document.addEventListener('DOMContentLoaded', loadMetadata);
    </script>
</body>
</html>
