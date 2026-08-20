<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/bootstrap.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <title>ITI DETAILS</title>

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

        .detail-value {
            color: #222;
            font-size: 14px;
            word-break: break-word;
        }

        .detail-row {
            border-bottom: 1px solid #eeeeee;
            padding: 10px 0;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .search-area {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            margin-bottom: 25px;
        }

        .loading {
            text-align: center;
            padding: 40px;
            font-size: 18px;
        }
    </style>
</head>

<body>

    <!-- Header -->
    <header>
        <%@ include file="../reports/bannernew.jsp" %>
    </header>


    <div class="container-fluid px-5 mt-4 mb-5">

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">

            <h2 class="page-title text-uppercase">
                ITI DETAILS
            </h2>

            <div class="breadcrumb-text">
                Home / ITI Details
            </div>

        </div>


        <!-- Search ITI -->
        <div class="search-area">

            <div class="row g-3">

                <div class="col-md-10">

                    <input type="text"
                           id="itiCodeInput"
                           class="form-control"
                           placeholder="Enter ITI Code">

                </div>

                <div class="col-md-2">

                    <button id="searchBtn"
                            class="btn btn-primary w-100">

                        Search

                    </button>

                </div>

            </div>

        </div>


        <!-- Loading -->
        <div id="loadingMessage"
             class="loading"
             style="display: none;">

            Loading ITI details...

        </div>


        <!-- Error -->
        <div id="errorMessage"
             class="alert alert-danger"
             style="display: none;">

        </div>


        <!-- Details -->
        <div id="detailsContainer"
             style="display: none;">


            <!-- Basic Details -->
            <div class="details-card">

                <div class="details-card-header">
                    <i class="fas fa-building"></i>
                    Basic ITI Details
                </div>

                <div class="details-card-body">

                    <div class="row">

                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                ITI Code
                            </div>

                            <div class="detail-value"
                                 id="itiCode">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                ITI Name
                            </div>

                            <div class="detail-value"
                                 id="itiName">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                District Code
                            </div>

                            <div class="detail-value"
                                 id="distCode">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Government / Private
                            </div>

                            <div class="detail-value"
                                 id="govt">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                ITI Type
                            </div>

                            <div class="detail-value"
                                 id="itiType">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                ITI / Non-ITI
                            </div>

                            <div class="detail-value"
                                 id="itiNoniti">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Old ITI Code
                            </div>

                            <div class="detail-value"
                                 id="olditicode">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                NCVT Code
                            </div>

                            <div class="detail-value"
                                 id="ncvtCode">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                DGET ITI Code
                            </div>

                            <div class="detail-value"
                                 id="dgetItiCode">
                            </div>
                        </div>

                    </div>

                </div>

            </div>


            <!-- Contact Details -->
            <div class="details-card">

                <div class="details-card-header">
                    <i class="fas fa-address-book"></i>
                    Contact Details
                </div>

                <div class="details-card-body">

                    <div class="row">

                        <div class="col-md-6 detail-row">
                            <div class="detail-label">
                                Address
                            </div>

                            <div class="detail-value"
                                 id="address">
                            </div>
                        </div>


                        <div class="col-md-6 detail-row">
                            <div class="detail-label">
                                City / Town
                            </div>

                            <div class="detail-value"
                                 id="cityTown">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Email
                            </div>

                            <div class="detail-value"
                                 id="email">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Mobile
                            </div>

                            <div class="detail-value"
                                 id="mobile">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Landline Number
                            </div>

                            <div class="detail-value"
                                 id="landlineNumber">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                PIN Code
                            </div>

                            <div class="detail-value"
                                 id="pinCode">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Website
                            </div>

                            <div class="detail-value"
                                 id="website">
                            </div>
                        </div>

                    </div>

                </div>

            </div>


            <!-- Principal Details -->
            <div class="details-card">

                <div class="details-card-header">
                    <i class="fas fa-user-tie"></i>
                    Principal / Administration Details
                </div>

                <div class="details-card-body">

                    <div class="row">

                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Principal Name
                            </div>

                            <div class="detail-value"
                                 id="principalName">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Role ID
                            </div>

                            <div class="detail-value"
                                 id="roleId">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Username
                            </div>

                            <div class="detail-value"
                                 id="username">
                            </div>
                        </div>


                        <div class="col-md-6 detail-row">
                            <div class="detail-label">
                                Description
                            </div>

                            <div class="detail-value"
                                 id="description">
                            </div>
                        </div>

                    </div>

                </div>

            </div>


            <!-- Capacity Details -->
            <div class="details-card">

                <div class="details-card-header">
                    <i class="fas fa-chart-bar"></i>
                    Capacity Details
                </div>

                <div class="details-card-body">

                    <div class="row">

                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Capacity
                            </div>

                            <div class="detail-value"
                                 id="capacity">
                            </div>
                        </div>


                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Allocated
                            </div>

                            <div class="detail-value"
                                 id="allocated">
                            </div>
                        </div>


                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Remaining Capacity
                            </div>

                            <div class="detail-value"
                                 id="remainingCapacity">
                            </div>
                        </div>


                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Total Strength
                            </div>

                            <div class="detail-value"
                                 id="totStrength">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Exam Conducting Strength
                            </div>

                            <div class="detail-value"
                                 id="examconductingStrength">
                            </div>
                        </div>

                    </div>

                </div>

            </div>


            <!-- Infrastructure Details -->
            <div class="details-card">

                <div class="details-card-header">
                    <i class="fas fa-school"></i>
                    Infrastructure Details
                </div>

                <div class="details-card-body">

                    <div class="row">

                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Number of Toilets
                            </div>

                            <div class="detail-value"
                                 id="noofToilets">
                            </div>
                        </div>


                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Number of Labs
                            </div>

                            <div class="detail-value"
                                 id="noofLabs">
                            </div>
                        </div>


                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Classrooms
                            </div>

                            <div class="detail-value"
                                 id="noofClassrooms">
                            </div>
                        </div>


                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Built-up Area
                            </div>

                            <div class="detail-value"
                                 id="builtupArea">
                            </div>
                        </div>


                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Land
                            </div>

                            <div class="detail-value"
                                 id="land">
                            </div>
                        </div>


                        <div class="col-md-3 detail-row">
                            <div class="detail-label">
                                Drinking Water Available
                            </div>

                            <div class="detail-value"
                                 id="availableDrinkingwater">
                            </div>
                        </div>

                    </div>

                </div>

            </div>


            <!-- Other Details -->
            <div class="details-card">

                <div class="details-card-header">
                    <i class="fas fa-info-circle"></i>
                    Other Details
                </div>

                <div class="details-card-body">

                    <div class="row">

                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Year Established
                            </div>

                            <div class="detail-value"
                                 id="yearEst">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Region
                            </div>

                            <div class="detail-value"
                                 id="region">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Urban / Rural
                            </div>

                            <div class="detail-value"
                                 id="urbanRural">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                VTP
                            </div>

                            <div class="detail-value"
                                 id="vtp">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                VTP Registration Number
                            </div>

                            <div class="detail-value"
                                 id="vtpRegno">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Admission Permission
                            </div>

                            <div class="detail-value"
                                 id="admissionPermission">
                            </div>
                        </div>


                        <div class="col-md-4 detail-row">
                            <div class="detail-label">
                                Tool Status
                            </div>

                            <div class="detail-value"
                                 id="toolStatus">
                            </div>
                        </div>

                    </div>

                </div>

            </div>
            <!-- Back Button -->
            <div class="text-center mb-4">

                <button class="btn btn-secondary"
                        onclick="window.history.back();">
                        <i class="fas fa-arrow-left"></i> 
                        Back to ITI List
                </button>
                </div>
        </div>
        </div>
        <!--Footer-->
        <footer>
        <%@include file="../reports/footer.jsp" %>
        </footer>
        <script>

document.addEventListener("DOMContentLoaded", function () {

    const itiApiUrl = "${itiApiUrl}";

    const itiCodeInput =
        document.getElementById("itiCodeInput");

    const searchBtn =
        document.getElementById("searchBtn");

    const loadingMessage =
        document.getElementById("loadingMessage");

    const errorMessage =
        document.getElementById("errorMessage");

    const detailsContainer =
        document.getElementById("detailsContainer");


    function showDetails(itiCode) {

        if (!itiCode) {

            showError("Please enter an ITI Code.");

            return;
        }


        loadingMessage.style.display = "block";

        errorMessage.style.display = "none";

        detailsContainer.style.display = "none";


        const url =
            itiApiUrl + "/" + encodeURIComponent(itiCode);


        console.log("Fetching URL:", url);


        fetch(url)

            .then(response => {

                if (!response.ok) {

                    if (response.status === 404) {

                        throw new Error(
                            "ITI not found: " + itiCode
                        );
                    }

                    throw new Error(
                        "Failed to retrieve ITI details. Status: "
                        + response.status
                    );
                }

                return response.json();

            })

            .then(iti => {

                displayItiDetails(iti);

                loadingMessage.style.display = "none";

                detailsContainer.style.display = "block";

            })

            .catch(error => {

                console.error(error);

                loadingMessage.style.display = "none";

                showError(error.message);

            });
    }


    function displayItiDetails(iti) {

        setValue("itiCode", iti.itiCode);

        setValue("itiName", iti.itiName);

        setValue("distCode", iti.distCode);

        setValue("govt", iti.govt);

        setValue("itiType", iti.itiType);

        setValue("itiNoniti", iti.itiNoniti);

        setValue("olditicode", iti.olditicode);

        setValue("ncvtCode", iti.ncvtCode);

        setValue("dgetItiCode", iti.dgetItiCode);


        setValue("address", iti.address);

        setValue("cityTown", iti.cityTown);

        setValue("email", iti.email);

        setValue("mobile", iti.mobile);

        setValue("landlineNumber", iti.landlineNumber);

        setValue("pinCode", iti.pinCode);

        setValue("website", iti.website);


        setValue("principalName", iti.principalName);

        setValue("roleId", iti.roleId);

        setValue("username", iti.username);

        setValue("description", iti.description);


        setValue("capacity", iti.capacity);

        setValue("allocated", iti.allocated);

        setValue("remainingCapacity", iti.remainingCapacity);

        setValue("totStrength", iti.totStrength);

        setValue(
            "examconductingStrength",
            iti.examconductingStrength
        );


        setValue("noofToilets", iti.noofToilets);

        setValue("noofLabs", iti.noofLabs);

        setValue("noofClassrooms", iti.noofClassrooms);

        setValue("builtupArea", iti.builtupArea);

        setValue("land", iti.land);

        setValue(
            "availableDrinkingwater",
            formatBoolean(iti.availableDrinkingwater)
        );


        setValue("yearEst", iti.yearEst);

        setValue("region", iti.region);

        setValue("urbanRural", iti.urbanRural);

        setValue("vtp", formatBoolean(iti.vtp));

        setValue("vtpRegno", iti.vtpRegno);

        setValue(
            "admissionPermission",
            formatBoolean(iti.admissionPermission)
        );

        setValue(
            "toolStatus",
            formatBoolean(iti.toolStatus)
        );
    }


    function setValue(elementId, value) {

        const element =
            document.getElementById(elementId);


        if (!element) {

            console.warn(
                "Element not found:",
                elementId
            );

            return;
        }


        if (
            value === null ||
            value === undefined ||
            value === ""
        ) {

            element.textContent = "-";

        } else {

            element.textContent = value;
        }
    }


    function formatBoolean(value) {

        if (value === true) {

            return "Yes";
        }

        if (value === false) {

            return "No";
        }

        return "-";
    }


    function showError(message) {

        errorMessage.textContent = message;

        errorMessage.style.display = "block";
    }


    searchBtn.addEventListener(
        "click",
        function () {

            const itiCode =
                itiCodeInput.value.trim();

            showDetails(itiCode);
        }
    );


    itiCodeInput.addEventListener(
        "keyup",
        function (event) {

            if (event.key === "Enter") {

                const itiCode =
                    itiCodeInput.value.trim();

                showDetails(itiCode);
            }
        }
    );


    const urlParams =
        new URLSearchParams(
            window.location.search
        );


    const itiCodeFromUrl =
        urlParams.get("itiCode");


    if (itiCodeFromUrl) {

        itiCodeInput.value =
            itiCodeFromUrl;

        showDetails(itiCodeFromUrl);
    }

});

</script>
</body>
</html>
