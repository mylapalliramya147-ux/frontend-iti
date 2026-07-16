<style>
    .header-logo {
        max-height: 100px;
        width: auto;
    }

    .header-text-main {
        font-size: 26px;
        font-weight: bold;
        color: var(--header-navy);
        line-height: 1.2;
        text-transform: uppercase;
        font-family: Arial, sans-serif;
    }

    .header-text-sub {
        font-size: 18px;
        font-weight: bold;
        color: var(--header-green);
        text-transform: uppercase;
    }

    @media (max-width: 767.98px) {
        .header-logo {
            max-height: 70px;
        }

        .itilogo-img {
            height: 80px !important;
        }

        .dgt-logo {
            height: 50px !important;
        }

        .header-text-main {
            font-size: 18px;
            margin-top: 10px;
            line-height: 1.3;
        }

        .header-text-sub {
            font-size: 12px;
            margin-bottom: 10px;
        }

        .mobile-center-flex {
            justify-content: center !important;
        }
    }
</style>

<!-- Ensure bootstrap is loaded if the parent forgot -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<!-- Main Header Section -->
<div class="bg-white py-3 shadow-sm">
    <div class="container-fluid px-2 px-md-5">
        <div class="row align-items-center text-center">
            <!-- Left Logo -->
            <div class="col-md-3 text-center text-md-start mb-2 mb-md-0">
                <div class="d-flex justify-content-center justify-content-md-start align-items-center gap-3 mobile-center-flex">
                    <img src="${pageContext.request.contextPath}/images/ap.png" class="header-logo" alt="Andhra Pradesh Emblem">
                    <img src="${pageContext.request.contextPath}/images/itilogo.png" class="itilogo-img" style="height: 120px;" alt="ITI Logo">
                </div>
            </div>

            <!-- Center Text -->
            <div class="col-md-6 mb-2 mb-md-0">
                <div class="header-text-main">Government of ANDHRA PRADESH</div>
                <div class="header-text-sub">Department of Employment and Training</div>
            </div>

            <!-- Right Logos -->
            <div class="col-md-3 text-center text-md-end">
                <div class="d-flex justify-content-center justify-content-md-end align-items-center gap-3 mobile-center-flex">
                    <img src="${pageContext.request.contextPath}/images/skillindialogo.png" class="dgt-logo" style="height: 80px;" alt="Skill India">
                    <img src="${pageContext.request.contextPath}/images/training.png" class="dgt-logo" style="height: 80px;" alt="DGT">
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Dark Teal Bar (Admissions Title) -->
<div class="top-header-bar text-center px-2">
    AP ITI ADMISSIONS - 2026
</div>

<!-- Announcement Bar (Light Blue) -->
<div class="announcement-bar px-3">
    A Common Application for seeking Admission into all courses of Advanced Technology Centers (ATC's), Govt. ITI's and Pvt. ITI's in Andhra Pradesh State
</div>