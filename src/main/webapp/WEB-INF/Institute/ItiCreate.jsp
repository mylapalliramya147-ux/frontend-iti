import <frontenditi class="frontend-iti src main webapp WEB-INF reports">

</frontenditi>bannernew.jsp

<body>

    <!-- Header -->
    <header>
        <%@ include file="../reports/bannernew.jsp" %>
    </header>

    <div class="container-fluid px-5 mt-4 mb-5">

        <!-- Page Heading -->
        <div class="d-flex justify-content-between align-items-center mb-4">

            <h2 class="page-title text-uppercase">
                CREATE ITI
            </h2>

            <div class="breadcrumb-text">
                Home / Create ITI
            </div>

        </div>

        <!-- Success / Error Message -->
        <div id="messageBox" style="display:none;"></div>

        <form id="itiCreateForm">

            <!-- ================= BASIC ITI DETAILS ================= -->

            <div class="details-card">

                <div class="details-card-header">
                    <i class="fas fa-building"></i>
                    Basic ITI Details
                </div>

                <div class="details-card-body">

                    <div class="row">

                        <!-- ITI Code -->
                        <div class="col-md-4 detail-row">

                            <label class="detail-label">
                                ITI Code <span class="text-danger">*</span>
                            </label>

                            <input
                                type="text"
                                id="itiCode"
                                class="form-control"
                                required>

                        </div>

                        <!-- ITI Name -->
                        <div class="col-md-8 detail-row">

                            <label class="detail-label">
                                ITI Name <span class="text-danger">*</span>
                            </label>

                            <input
                                type="text"
                                id="itiName"
                                class="form-control"
                                required>

                        </div>

                        <!-- Government / Private -->
                        <div class="col-md-4 detail-row">

    <label class="detail-label">
        ITI Type <span class="text-danger">*</span>
    </label>

    <select id="govt" class="form-select" required>

        <option value="">Select ITI Type</option>

        <option value="G">Government (G)</option>

        <option value="P">Private (P)</option>

    </select>

</div>                        <!-- District -->
                        <div class="col-md-4 detail-row">

                            <label class="detail-label">
                                District Name
                            </label>

                            <select
                                id="districtName"
                                class="form-select">

                                <option>
                                    Loading Districts...
                                </option>

                            </select>

                        </div>

                        <!-- District Code -->
                        <div class="col-md-4 detail-row">

                            <label class="detail-label">
                                District Code
                            </label>

                            <input
                                type="text"
                                id="distCode"
                                class="form-control"
                                readonly>

                        </div>

                        <!-- ITI / Non ITI -->
                        <div class="col-md-4 detail-row">

                            <label class="detail-label">
                                ITI / Non ITI
                            </label>

                            <input
                                type="text"
                                id="itiNoniti"
                                class="form-control">

                        </div>

                        <!-- Old ITI Code -->
                        <div class="col-md-4 detail-row">

                            <label class="detail-label">
                                Old ITI Code
                            </label>

                            <input
                                type="text"
                                id="olditicode"
                                class="form-control">

                        </div>

                        <!-- NCVT Code -->
                        <div class="col-md-4 detail-row">

                            <label class="detail-label">
                                NCVT Code
                            </label>

                            <input
                                type="text"
                                id="ncvtCode"
                                class="form-control">

                        </div>

                        <!-- DGET ITI Code -->
                        <div class="col-md-4 detail-row">

                            <label class="detail-label">
                                DGET ITI Code
                            </label>

                            <input
                                type="text"
                                id="dgetItiCode"
                                class="form-control">

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

        <div class="row g-3">

            <!-- Address -->
            <div class="col-md-12">
                <label class="form-label">
                    Address
                </label>

                <textarea id="address"
                          class="form-control"
                          rows="3"></textarea>
            </div>

            <!-- City / Town -->
            <div class="col-md-4">
                <label class="form-label">
                    City / Town
                </label>

                <input type="text"
                       id="cityTown"
                       class="form-control">
            </div>

            <!-- PIN Code -->
            <div class="col-md-4">
                <label class="form-label">
                    PIN Code
                </label>

                <input type="text"
                       id="pinCode"
                       class="form-control"
                       maxlength="6">
            </div>

            <!-- Email -->
            <div class="col-md-4">
                <label class="form-label">
                    Email
                    <span class="text-danger">*</span>
                </label>

                <input type="email"
                       id="email"
                       class="form-control"
                       required>
            </div>

            <!-- Mobile -->
            <div class="col-md-4">
                <label class="form-label">
                    Mobile
                    <span class="text-danger">*</span>
                </label>

                <input type="text"
                       id="mobile"
                       class="form-control"
                       maxlength="10"
                       required>
            </div>

            <!-- Landline Number -->
            <div class="col-md-4">
                <label class="form-label">
                    Landline Number
                </label>

                <input type="text"
                       id="landlineNumber"
                       class="form-control">
            </div>

            <!-- Website -->
            <div class="col-md-4">
                <label class="form-label">
                    Website
                </label>

                <input type="text"
                       id="website"
                       class="form-control">
            </div>

        </div>

    </div>

</div>
              <!-- Principal / Administration Details -->
<div class="details-card">

    <div class="details-card-header">
        <i class="fas fa-user-tie"></i>
        Principal / Administration Details
    </div>

    <div class="details-card-body">

        <div class="row g-3">

            <!-- Principal Name -->
            <div class="col-md-4">

                <label class="form-label">
                    Principal Name
                </label>

                <input type="text"
                       id="principalName"
                       class="form-control">

            </div>

            <!-- Role ID -->
            <div class="col-md-4">

                <label class="form-label">
                    Role ID
                </label>

                <input type="number"
                       id="roleId"
                       class="form-control">

            </div>

            <!-- Username -->
            <div class="col-md-4">

                <label class="form-label">
                    Username
                </label>

                <input type="text"
                       id="username"
                       class="form-control">

            </div>

            <!-- Password -->
            <div class="col-md-4">

                <label class="form-label">
                    Password
                </label>

                <input type="password"
                       id="password"
                       class="form-control">

            </div>

            <!-- Description -->
            <div class="col-md-8">

                <label class="form-label">
                    Description
                </label>

                <textarea id="description"
                          rows="3"
                          class="form-control"></textarea>

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

        <div class="row g-3">

            <!-- Capacity -->
            <div class="col-md-3">

                <label class="form-label">
                    Capacity
                </label>

                <input type="number"
                       id="capacity"
                       class="form-control">

            </div>

            <!-- Allocated -->
            <div class="col-md-3">

                <label class="form-label">
                    Allocated
                </label>

                <input type="number"
                       id="allocated"
                       class="form-control">

            </div>

            <!-- Remaining Capacity -->
            <div class="col-md-3">

                <label class="form-label">
                    Remaining Capacity
                </label>

                <input type="number"
                       id="remainingCapacity"
                       class="form-control">

            </div>

            <!-- Total Strength -->
            <div class="col-md-3">

                <label class="form-label">
                    Total Strength
                </label>

                <input type="number"
                       id="totStrength"
                       class="form-control">

            </div>

            <!-- Exam Conducting Strength -->
            <div class="col-md-4">

                <label class="form-label">
                    Exam Conducting Strength
                </label>

                <input type="number"
                       id="examconductingStrength"
                       class="form-control">

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

        <div class="row g-3">

            <!-- Land -->
            <div class="col-md-4">

                <label class="form-label">
                    Land
                </label>

                <input type="text"
                       id="land"
                       class="form-control">

            </div>

            <!-- Built-up Area -->
            <div class="col-md-4">

                <label class="form-label">
                    Built-up Area
                </label>

                <input type="text"
                       id="builtupArea"
                       class="form-control">

            </div>

            <!-- Number of Toilets -->
            <div class="col-md-4">

                <label class="form-label">
                    Number of Toilets
                </label>

                <input type="number"
                       id="noofToilets"
                       class="form-control">

            </div>

            <!-- Number of Labs -->
            <div class="col-md-4">

                <label class="form-label">
                    Number of Labs
                </label>

                <input type="number"
                       id="noofLabs"
                       class="form-control">

            </div>

            <!-- Number of Classrooms -->
            <div class="col-md-4">

                <label class="form-label">
                    Number of Classrooms
                </label>

                <input type="number"
                       id="noofClassrooms"
                       class="form-control">

            </div>

            <!-- Drinking Water Available -->
            <div class="col-md-4">

                <label class="form-label">
                    Drinking Water Available
                </label>

                <select id="availableDrinkingwater"
                        class="form-select">

                    <option value="">Select</option>
                    <option value="true">Yes</option>
                    <option value="false">No</option>

                </select>

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

        <div class="row g-3">

            <!-- Year Established -->
            <div class="col-md-4">

                <label class="form-label">
                    Year Established
                </label>

                <input type="text"
                       id="yearEst"
                       class="form-control">

            </div>

            <!-- Region -->
            <div class="col-md-4">

                <label class="form-label">
                    Region
                </label>

                <input type="text"
                       id="region"
                       class="form-control">

            </div>

            <!-- Urban / Rural -->
            <div class="col-md-4">

                <label class="form-label">
                    Urban / Rural
                </label>

                <select id="urbanRural"
                        class="form-select">

                    <option value="">Select</option>
                    <option value="Urban">Urban</option>
                    <option value="Rural">Rural</option>

                </select>

            </div>

            <!-- VTP -->
            <div class="col-md-4">

                <label class="form-label">
                    VTP
                </label>

                <select id="vtp"
                        class="form-select">

                    <option value="">Select</option>
                    <option value="true">Yes</option>
                    <option value="false">No</option>

                </select>

            </div>

            <!-- VTP Registration Number -->
            <div class="col-md-4">

                <label class="form-label">
                    VTP Registration Number
                </label>

                <input type="text"
                       id="vtpRegno"
                       class="form-control">

            </div>

            <!-- Admission Permission -->
            <div class="col-md-4">

                <label class="form-label">
                    Admission Permission
                </label>

                <select id="admissionPermission"
                        class="form-select">

                    <option value="">Select</option>
                    <option value="true">Yes</option>
                    <option value="false">No</option>

                </select>

            </div>

            <!-- Tool Status -->
            <div class="col-md-4">

                <label class="form-label">
                    Tool Status
                </label>

                <select id="toolStatus"
                        class="form-select">

                    <option value="">Select</option>
                    <option value="true">Available</option>
                    <option value="false">Not Available</option>

                </select>

            </div>

        </div>

    </div>

</div>
        <!-- Designations -->
<div class="details-card">

    <div class="details-card-header">
        <i class="fas fa-user-tag"></i>
        Designations
    </div>

    <div class="details-card-body">

        <div class="row">

            <div class="col-md-12">

                <label class="form-label">
                    Select Designations
                </label>

                <div id="designationContainer"
                     class="border rounded p-3"
                     style="max-height:300px;overflow-y:auto;">

                    Loading Designations...

                </div>

            </div>

        </div>

    </div>

</div>
        </form>

    </div>
            
    <!-- Footer -->
    <footer>
        <%@ include file="../reports/footer.jsp" %>
    </footer>

</body>