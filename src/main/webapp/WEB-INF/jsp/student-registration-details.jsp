<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Candidate Complete Details | ITI Admissions</title>
            <!-- CSS Links (Same as all report pages) -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
            <link rel="stylesheet"
                href="${pageContext.request.contextPath}/css/style.css?v=${System.currentTimeMillis()}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
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
                    margin-bottom: 30px;
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

                .grid-table {
                    width: 100%;
                    border-collapse: collapse;
                    font-size: 0.95rem;
                }

                .grid-table td {
                    padding: 15px 20px;
                    border: 1px solid #f1f5f9;
                }

                .label-cell {
                    background-color: #f8fafc;
                    color: #475569;
                    font-weight: 700;
                    width: 16%;
                    text-align: right;
                    font-size: 0.72rem;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                    border: 1px solid #e2e8f0;
                }

                .value-cell {
                    color: #1e293b;
                    font-weight: 600;
                    width: 17.3%;
                    border: 1px solid #e2e8f0;
                    text-transform: none;
                    font-size: 0.95rem;
                    text-align: left;
                    padding-left: 15px !important;
                }

                .report-table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-bottom: 0;
                }

                .report-table thead th {
                    background: #003366;
                    color: #ffffff;
                    padding: 15px;
                    font-weight: 800;
                    border: 1px solid #1a4a72;
                    font-size: 0.75rem;
                    text-transform: uppercase;
                    text-align: center;
                }

                .report-table td {
                    padding: 12px 15px;
                    border: 1px solid #e2e8f0;
                    font-weight: 600;
                    color: #1e293b;
                    text-align: center;
                    font-size: 0.95rem;
                }
            </style>
        </head>

        <body class="nodal-body">
            <c:set var="hideNavbar" value="true" scope="request" />
            <%@ include file="header.jsp" %>

                <c:set var="activeTab" value="candidate_details" />
                <%@ include file="nodal_navbar.jsp" %>

                    <!-- Dashboard Title -->
                    <div class="nodal-page-title-dashboard">
                        <h2>Candidate Complete Profile Summary</h2>
                    </div>

                    <div class="container-fluid px-5 py-4">
                        <!-- Action Buttons (Same as second image style) -->
                        <div class="no-print d-flex justify-content-center gap-3 mb-4">
                            <button class="btn btn-outline-secondary shadow-sm px-4 rounded-pill fw-bold"
                                onclick="window.location.href='${pageContext.request.contextPath}/nodal-report/candidate-details'">
                                <i class="fas fa-arrow-left me-2"></i> BACK TO SEARCH
                            </button>
                            <button class="btn btn-dark shadow-sm px-4 rounded-pill fw-bold" onclick="window.print()">
                                <i class="fas fa-print me-2"></i> PRINT DETAILS
                            </button>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger text-center py-5 shadow-sm"
                                style="border-radius: 12px; border: none; background: #fff1f1; color: #b91c1c;">
                                <i class="fas fa-exclamation-circle me-3 fs-3"></i>
                                <span class="fs-5 fw-bold">${error}</span>
                            </div>
                        </c:if>

                        <c:if test="${empty error}">
                            <!-- 1. STUDENT REGISTRATION DETAILS -->
                            <div class="nodal-report-card shadow-sm">
                                <div class="nodal-card-header-dashboard">
                                    <i class="fas fa-user-edit"></i> STUDENT REGISTRATION DETAILS
                                </div>
                                <table class="grid-table">
                                    <tr>
                                        <td class="label-cell">Name:</td>
                                        <td class="value-cell">${registration.name}</td>
                                        <td class="label-cell">Registration ID:</td>
                                        <td class="value-cell">${registration.registration_id}</td>
                                        <td class="label-cell">Date Of Birth:</td>
                                        <td class="value-cell">${registration.date_of_birth}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">SSC HT No:</td>
                                        <td class="value-cell">${registration.ssc_ht_no}</td>
                                        <td class="label-cell">Father Name:</td>
                                        <td class="value-cell">${registration.father_name}</td>
                                        <td class="label-cell">Mother Name:</td>
                                        <td class="value-cell">${registration.mother_name}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Address:</td>
                                        <td class="value-cell">${registration.address}</td>
                                        <td class="label-cell">Phone No:</td>
                                        <td class="value-cell">${registration.phone_no}</td>
                                        <td class="label-cell">Gender:</td>
                                        <td class="value-cell">${registration.gender}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Caste:</td>
                                        <td class="value-cell">${registration.caste}</td>
                                        <td class="label-cell">SSC Passed:</td>
                                        <td class="value-cell">${registration.ssc_passed}</td>
                                        <td class="label-cell">PHC:</td>
                                        <td class="value-cell">${registration.phc}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">SSC Pass Year:</td>
                                        <td class="value-cell">${registration.ssc_pass_year}</td>
                                        <td class="label-cell">Registered Phase:</td>
                                        <td class="value-cell">${registration.registered_phase}</td>
                                        <td class="label-cell">Registration Date:</td>
                                        <td class="value-cell">${registration.registration_date}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Verified Date:</td>
                                        <td class="value-cell" colspan="5">${registration.verified_date}</td>
                                    </tr>
                                </table>
                            </div>

                            <!-- 2. SSC Result MARKS -->
                            <div class="nodal-report-card shadow-sm">
                                <div class="nodal-card-header-dashboard">
                                    <i class="fas fa-file-alt"></i> SSC RESULT TYPE: MARKS
                                </div>
                                <table class="report-table">
                                    <thead>
                                        <tr>
                                            <th>First Language</th>
                                            <th>Second Language</th>
                                            <th>English</th>
                                            <th>Maths</th>
                                            <th>Science</th>
                                            <th>Social</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty sscMarks}">
                                                <tr>
                                                    <td>${sscMarks.first_language}</td>
                                                    <td>${sscMarks.second_language}</td>
                                                    <td>${sscMarks.english}</td>
                                                    <td>${sscMarks.maths}</td>
                                                    <td>${sscMarks.science}</td>
                                                    <td>${sscMarks.social}</td>
                                                    <td>${sscMarks.total}</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="7">No SSC marks data available.</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <!-- 3. STUDENT APPLIED ITIs -->
                            <div class="nodal-report-card shadow-sm">
                                <div class="nodal-card-header-dashboard">
                                    <i class="fas fa-university"></i> STUDENT APPLIED ITIs
                                </div>
                                <table class="report-table">
                                    <thead>
                                        <tr>
                                            <th>ITI CODE</th>
                                            <th>ITI NAME</th>
                                            <th>PHASE</th>
                                            <th>ADMISSIONS YEAR</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty appliedItis}">
                                            <tr>
                                                <td colspan="4">No ITIs applied.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${appliedItis}" var="iti">
                                            <tr>
                                                <td>${iti.iti_code}</td>
                                                <td style="text-align: left; padding-left: 15px;">${iti.iti_name}</td>
                                                <td>${iti.phase}</td>
                                                <td>${iti.admissions_year}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- 4. STUDENT VERIFIED DETAILS -->
                            <div class="nodal-report-card shadow-sm">
                                <div class="nodal-card-header-dashboard">
                                    <i class="fas fa-check-circle"></i> STUDENT VERIFIED DETAILS
                                </div>
                                <table class="grid-table">
                                    <tr>
                                        <td class="label-cell">Name:</td>
                                        <td class="value-cell">${verified.name}</td>
                                        <td class="label-cell">Registration ID:</td>
                                        <td class="value-cell">${verified.registration_id}</td>
                                        <td class="label-cell">Date Of Birth:</td>
                                        <td class="value-cell">${verified.date_of_birth}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">SSC HT No:</td>
                                        <td class="value-cell">${verified.ssc_ht_no}</td>
                                        <td class="label-cell">Father Name:</td>
                                        <td class="value-cell">${verified.father_name}</td>
                                        <td class="label-cell">Mother Name:</td>
                                        <td class="value-cell">${verified.mother_name}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Address:</td>
                                        <td class="value-cell">${verified.address}</td>
                                        <td class="label-cell">Phone No:</td>
                                        <td class="value-cell">${verified.phone_no}</td>
                                        <td class="label-cell">Gender:</td>
                                        <td class="value-cell">${verified.gender}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Caste:</td>
                                        <td class="value-cell">${verified.caste}</td>
                                        <td class="label-cell">SSC Passed:</td>
                                        <td class="value-cell">${verified.ssc_passed}</td>
                                        <td class="label-cell">PHC:</td>
                                        <td class="value-cell">${verified.phc}</td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">SSC Pass Year:</td>
                                        <td class="value-cell">${verified.ssc_pass_year}</td>
                                        <td class="label-cell">Registered Phase:</td>
                                        <td class="value-cell">${verified.registered_phase}</td>
                                        <td class="label-cell">Registration Date:</td>
                                        <td class="value-cell">${verified.registration_date}</td>
                                    </tr>
                                </table>
                            </div>

                            <!-- 5. MERIT LIST INFORMATION -->
                            <div class="nodal-report-card shadow-sm">
                                <div class="nodal-card-header-dashboard">
                                    <i class="fas fa-list-ol"></i> MERIT LIST INFORMATION
                                </div>
                                <table class="report-table">
                                    <thead>
                                        <tr>
                                            <th>DIST NAME</th>
                                            <th>ITI NAME</th>
                                            <th>RANK</th>
                                            <th>PHASE</th>
                                            <th>QUALIFICATION</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty meritList}">
                                            <tr>
                                                <td colspan="5">No merit list information found.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${meritList}" var="merit">
                                            <tr>
                                                <td>${merit.dist_name}</td>
                                                <td style="text-align: left; padding-left: 15px;">${merit.iti_name}</td>
                                                <td>${merit.rank}</td>
                                                <td>${merit.phase}</td>
                                                <td>${merit.qualification}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- 6. ADMISSION DETAILS -->
                            <div class="nodal-report-card shadow-sm">
                                <div class="nodal-card-header-dashboard">
                                    <i class="fas fa-user-graduate"></i> ADMISSION DETAILS
                                </div>
                                <c:choose>
                                    <c:when test="${not empty admission}">
                                        <table class="grid-table">
                                            <tr>
                                                <td class="label-cell">District:</td>
                                                <td class="value-cell">${admission.district}</td>
                                                <td class="label-cell">ITI:</td>
                                                <td class="value-cell">${admission.iti}</td>
                                                <td class="label-cell">Trade:</td>
                                                <td class="value-cell">${admission.trade}</td>
                                            </tr>
                                            <tr>
                                                <td class="label-cell">Admission Number:</td>
                                                <td class="value-cell">${admission.admission_number}</td>
                                                <td class="label-cell">Reservation Category:</td>
                                                <td class="value-cell">${admission.reservation_category}</td>
                                                <td class="label-cell">Year of Admission:</td>
                                                <td class="value-cell">${admission.year_of_admission}</td>
                                            </tr>
                                            <tr>
                                                <td class="label-cell">Phase:</td>
                                                <td class="value-cell">${admission.phase}</td>
                                                <td class="label-cell">Date of Admission:</td>
                                                <td class="value-cell">${admission.date_of_admission}</td>
                                                <td class="label-cell">Phone Number:</td>
                                                <td class="value-cell">${admission.phone_number}</td>
                                            </tr>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        <div
                                            style="padding: 15px; text-align: center; color: #003366; font-weight: bold;">
                                            No admission data found.
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>

                        <!-- Back Button Bottom -->
                        <div class="row no-print mt-5">
                            <div class="col-12 text-center">
                                <button class="btn btn-outline-secondary shadow-sm px-5 rounded-pill fw-bold"
                                    onclick="window.location.href='${pageContext.request.contextPath}/nodal-report/candidate-details'">
                                    <i class="fas fa-arrow-left me-2"></i> BACK TO SEARCH
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Scripts -->
                    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
                    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>