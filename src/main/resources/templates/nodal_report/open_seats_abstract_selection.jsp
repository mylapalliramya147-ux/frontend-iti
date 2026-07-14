<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI Admissions | Open Seats Abstract</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* DASHBOARD UI OVERRIDES */
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
    </style>
</head>
<body class="nodal-body">
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="../header.jsp" %>
    
    <c:set var="activeTab" value="open_seats" />
    <%@ include file="nodal_navbar.jsp" %>

    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Industrial Training Institute — Open Seats Abstract</h2>
    </div>

    <div class="container mt-5">
        <div class="nodal-report-card shadow-lg" style="max-width: 650px; margin: 0 auto;">
            <div class="nodal-card-header-blue">
                <i class="fas fa-door-open me-2"></i> Open Seats Selection Criteria
            </div>
            <div class="p-5 bg-white rounded-bottom">
                <form action="${pageContext.request.contextPath}/nodal-report/reports/open-seats-abstract" method="post" id="openSeatsForm">
                    <div class="mb-4">
                        <label for="year" class="form-label fw-bold small text-secondary">ADMISSION YEAR *</label>
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-calendar-check text-primary"></i></span>
                            <select name="year" id="year" class="form-select border-start-0" required style="font-size: 1rem;">
                                <option value="">-- Select Year --</option>
                            </select>
                        </div>
                    </div>

                    <%-- ITI Type removed as requested --%>

                    <div class="mt-5 text-center">
                        <button type="submit" class="nodal-btn-primary w-100 py-3" style="border-radius: 10px; font-weight: 600; letter-spacing: 1px;">
                            <i class="fas fa-search me-2"></i> VIEW OPEN SEATS REPORT
                        </button>
                        <p class="text-muted small mt-4">
                            <i class="fas fa-info-circle me-1"></i> Analysis of vacant seats across state ITIs
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
            
            if(data.years && data.years.length > 0) {
                data.years.forEach(y => {
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
