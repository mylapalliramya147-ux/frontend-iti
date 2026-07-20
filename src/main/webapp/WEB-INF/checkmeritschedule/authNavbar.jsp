<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        /* Nested dropdown submenu styles */
        .dropdown-menu .dropend {
            position: relative;
        }
        .dropdown-menu .dropdown-submenu {
            display: none !important;
            position: absolute;
            left: 100%;
            top: -7px;
            margin-top: 0;
            border-radius: 0.25rem;
            min-width: 200px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .dropdown-menu .dropend:hover > .dropdown-submenu,
        .dropdown-menu .dropend:focus-within > .dropdown-submenu {
            display: block !important;
        }
    </style>
    <nav class="navbar navbar-expand-lg custom-navbar authenticated-navbar">
        <div class="container-fluid">
            <!-- Toggle Button (Mobile) -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#authNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Items -->
            <div class="collapse navbar-collapse" id="authNav">
                <ul class="navbar-nav nav-menu mx-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/authHome">
                            <i class="fas fa-home me-1"></i> Home
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-cogs me-1"></i> ITI Services
                        </a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="itiReportsDropdown" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-chart-bar me-1"></i> ITI Reports
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="itiReportsDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/district-dsc-full" onclick="validateReportAccess(event, '3', '${pageContext.request.contextPath}/district-dsc-full')">District Reports</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/applicant-report-by-phase" onclick="validateReportAccess(event, '4', '${pageContext.request.contextPath}/applicant-report-by-phase')">ITI Reports</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/nodal-report/dashboard" onclick="validateReportAccess(event, '10', '${pageContext.request.contextPath}/nodal-report/dashboard')">Nodal Reports</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="admissionsDropdown" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-plus me-1"></i> Admissions
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="admissionsDropdown">
                            <li><a class="dropdown-item" href="#">Application Report</a></li>
                            <li><a class="dropdown-item" href="#">Reprint Verified Application</a></li>
                            <li><a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/VerificationReport">Verification Report</a>
                            </li>
                            <li><a class="dropdown-item" href="#">Seat matrix </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/MeritList">Merit List
                                </a>
                            </li>
                            <li><a class="dropdown-item" href="#">Add Trade</a></li>
                            <li><a id="nav-admission-phase" class="dropdown-item"
                                    href="${pageContext.request.contextPath}/AdmissionPhase">Admission Phase 1</a></li>
                            <li><a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/PrintAdmissionSlip">Print
                                    Admission Slip</a></li>
                            <li><a class="dropdown-item"
                                    href="${pageContext.request.contextPath}/ScheduleEntry">Schedule
                                    Entry</a></li>
                            <li><a class="dropdown-item" href="#">Call Letter</a></li>
                            <li><a class="dropdown-item" href="#">DISCHARGE ADMISSION</a></li>
                            <li><a class="dropdown-item" href="#">Verification For Online Application</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/DgtPermittedShift">DGT Permitted Shift Units</a></li>


                        </ul>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-pen-nib me-1"></i> SCVT Exams
                        </a>
                    </li>

                    <li class="nav-item ms-lg-5">
                        <a class="nav-link logout-link" href="${pageContext.request.contextPath}/logout"
                            onclick="clearAuthCookie()">
                            <i class="fas fa-sign-out-alt me-1"></i> Log out
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <script>
        function clearAuthCookie() {
            // Clear the user_role cookie by setting its expiry to the past
            document.cookie = "user_role=; path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC";
        }

        function validateReportAccess(event, requiredRole, targetUrl) {
            event.preventDefault();
            
            let userRole = null;
            const match = document.cookie.match(new RegExp('(^| )user_role=([^;]+)'));
            if (match) userRole = match[2];
            if (!userRole) userRole = '${sessionScope.role_id}';

            // STRICT ROLE MATCHING
            if (String(userRole) === String(requiredRole)) {
                if (targetUrl) window.location.href = targetUrl;
            } else {
                let roleName = "User";
                if (requiredRole === '3') roleName = "District User";
                else if (requiredRole === '4') roleName = "ITI User";
                else if (requiredRole === '10') roleName = "Nodal Admin";
                
                alert("ACCESS LOCKED: This section is only available to " + roleName + ".");
            }
        }

        // Dynamic Admission Phase update
        document.addEventListener('DOMContentLoaded', async function () {
            const navPhaseItem = document.getElementById('nav-admission-phase');
            if (navPhaseItem) {
                try {
                    const response = await fetch('http://localhost:8080/itiapchecklistmeritlist/admission-timings', { credentials: 'include',
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' }
                    });
                    const result = await response.json();
                    console.log("Navbar Status API Response:", result); // Debug log

                    if (result.success && result.phase !== undefined && result.phase !== null) {
                        // Update text reliably using textContent
                        navPhaseItem.textContent = "Admission Phase " + result.phase;
                    } else {
                        console.warn("Admission Phase number not found in API response.");
                    }
                } catch (err) {
                    console.error("Error updating admission phase in navbar:", err);
                }
            }
        });
    </script>