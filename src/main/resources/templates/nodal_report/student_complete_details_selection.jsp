<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI Admissions | Candidate Details</title>
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
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="../header.jsp" %>
    
    <c:set var="activeTab" value="candidate_details" />
    <%@ include file="nodal_navbar.jsp" %>

    
    <!-- Dashboard Title -->
    <div class="nodal-page-title-dashboard">
        <h2>Industrial Training Institute — Candidate Profile Lookup</h2>
    </div>

    <div class="container mt-4">
        <div class="nodal-report-card shadow-lg mx-auto" style="max-width: 700px;">
            <div class="nodal-card-header-dashboard">
                <i class="fas fa-user-check me-2"></i> Candidate Profile Lookup
            </div>
            <div class="p-5 bg-white rounded-bottom">
                <form action="${pageContext.request.contextPath}/nodal-report/reports/student-complete-details" method="post" id="candidateSearchForm">
                    <div class="mb-4">
                        <label for="searchBy" class="form-label fw-bold small text-secondary">SEARCH CANDIDATE BY *</label>
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-list text-primary"></i></span>
                            <select name="searchBy" id="searchBy" class="form-select border-start-0" onchange="toggleInputs()" style="font-size: 1rem;">
                                <option value="regid">Registration ID</option>
                                <option value="adm_num">Admission Number</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-4" id="regid_input">
                        <label for="regid" class="form-label fw-bold small text-secondary text-uppercase">Registration ID *</label>
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-id-card text-primary"></i></span>
                            <input type="text" name="regid" id="regid" class="form-control border-start-0" placeholder="e.g. 24000123" required style="font-size: 1.1rem; letter-spacing: 1px;">
                        </div>
                    </div>

                    <div class="mb-4" id="adm_num_input" style="display:none;">
                        <label for="adm_num" class="form-label fw-bold small text-secondary text-uppercase">Admission Number *</label>
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-file-invoice text-primary"></i></span>
                            <input type="text" name="adm_num" id="adm_num" class="form-control border-start-0" placeholder="e.g. ADM12345" style="font-size: 1.1rem; letter-spacing: 1px;">
                        </div>
                    </div>

                    <div class="mt-5 d-flex gap-4">
                        <button type="button" class="btn btn-lg btn-outline-secondary px-5" onclick="resetForm()" style="border-radius: 10px; font-weight: 600;">
                            <i class="fas fa-undo me-2"></i> RESET
                        </button>
                        <button type="submit" class="nodal-btn-primary flex-grow-1 py-3" style="border-radius: 10px; font-weight: 600; letter-spacing: 1px;">
                            <i class="fas fa-search me-2"></i> SEARCH CANDIDATE
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script>
        function toggleInputs() {
            const searchBy = document.getElementById('searchBy').value;
            const regContainer = document.getElementById('regid_input');
            const admContainer = document.getElementById('adm_num_input');
            const regInput = document.getElementById('regid');
            const admInput = document.getElementById('admission_number');

            if (searchBy === 'regid') {
                regContainer.style.display = 'block';
                regInput.required = true;
                admContainer.style.display = 'none';
                admInput.required = false;
            } else {
                regContainer.style.display = 'none';
                regInput.required = false;
                admContainer.style.display = 'block';
                admInput.required = true;
            }
        }

        function resetForm() {
            document.getElementById('candidateSearchForm').reset();
            toggleInputs();
        }
    </script>
</body>
</html>
