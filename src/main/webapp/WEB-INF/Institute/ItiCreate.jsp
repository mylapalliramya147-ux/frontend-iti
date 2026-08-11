<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>CREATE ITI</title>
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
    </style>
</head>

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
            <div class="col-md-6">
                <label class="form-label">
                    Address
                </label>

                <textarea id="address"
                          class="form-control"
                          rows="3"></textarea>
            </div>

            <!-- City / Town -->
            <div class="col-md-6">
                <label class="form-label">
                    City / Town
                </label>

                <input type="text"
                       id="cityTown"
                       class="form-control">
            </div>

            <!-- Email -->
            <div class="col-md-4">
                <label class="form-label">
                    Email
                </label>

                <input type="email"
                       id="email"
                       class="form-control">
            </div>

            <!-- Mobile -->
            <div class="col-md-4">
                <label class="form-label">
                    Mobile
                </label>

                <input type="text"
                       id="mobile"
                       class="form-control"
                       maxlength="10">
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

            <!-- PIN Code -->
            <div class="col-md-4">
                <label class="form-label">
                    PIN Code
                </label>

                <input type="number"
                       id="pinCode"
                       class="form-control">
            </div>

            <!-- Website -->
            <div class="col-md-8">
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

            <!-- Year Established -->
            <div class="col-md-4">

                <label class="form-label">
                    Year Established
                </label>

                <input type="text"
                       id="yearEst"
                       class="form-control">

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
                    <option value="U">Urban</option>
                    <option value="R">Rural</option>

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
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save me-2"></i>Create ITI
        </button>
    </form>

    </div>
            
    <!-- Footer -->
    <footer>
        <%@ include file="../reports/footer.jsp" %>
    </footer>

    <script>
function loadDistricts() {
    const districtApiUrl = "${districtApiUrl}";

    fetch(districtApiUrl)
        .then(res => res.json())
        .then(data => {
            const select = document.getElementById("districtName");
            select.innerHTML = '<option value="">Select District</option>';

            data.forEach(district => {
                const opt = document.createElement("option");
                opt.value = district.code;
                opt.textContent = district.name;
                select.appendChild(opt);
            });

            select.addEventListener("change", function() {
                document.getElementById("distCode").value = this.value;
            });
        })
        .catch(err => {
            console.error("Failed to load districts", err);
            document.getElementById("districtName").innerHTML = '<option>Failed to load districts</option>';
        });
}

function loadDesignations() {
    const designationApiUrl = "${designationApiUrl}";

    fetch(designationApiUrl)
        .then(res => res.json())
        .then(data => {
            const container = document.getElementById("designationContainer");
            container.innerHTML = "";

            data.sort((a, b) => a.displayOrder - b.displayOrder);

            data.forEach(desig => {
                const colDiv = document.createElement("div");
                colDiv.className = "col-md-4";

                const formCheckDiv = document.createElement("div");
                formCheckDiv.className = "form-check";

                const checkbox = document.createElement("input");
                checkbox.className = "form-check-input";
                checkbox.type = "checkbox";
                checkbox.name = "designation";
                checkbox.value = desig.desigCode;
                checkbox.id = "desig_" + desig.desigCode;

                const label = document.createElement("label");
                label.className = "form-check-label";
                label.htmlFor = "desig_" + desig.desigCode;
                label.textContent = desig.designation;

                formCheckDiv.appendChild(checkbox);
                formCheckDiv.appendChild(label);
                colDiv.appendChild(formCheckDiv);
                container.appendChild(colDiv);
            });
        })
        .catch(err => {
            console.error("Failed to load designations", err);
            document.getElementById("designationContainer").innerHTML = "Failed to load Designations";
        });
}

function collectFormData() {
    const payload = {
        itiCode: document.getElementById("itiCode").value,
        itiName: document.getElementById("itiName").value,
        govt: document.getElementById("govt").value,
        distCode: document.getElementById("distCode").value,
        itiNoniti: document.getElementById("itiNoniti").value,
        olditicode: document.getElementById("olditicode").value,
        ncvtCode: document.getElementById("ncvtCode").value,
        dgetItiCode: document.getElementById("dgetItiCode").value,
        address: document.getElementById("address").value,
        cityTown: document.getElementById("cityTown").value,
        email: document.getElementById("email").value,
        mobile: document.getElementById("mobile").value,
        landlineNumber: document.getElementById("landlineNumber").value,
        pinCode: document.getElementById("pinCode").value ? parseInt(document.getElementById("pinCode").value) : null,
        website: document.getElementById("website").value,
        principalName: document.getElementById("principalName").value,
        roleId: document.getElementById("roleId").value ? parseInt(document.getElementById("roleId").value) : null,
        username: document.getElementById("username").value,
        password: document.getElementById("password").value,
        description: document.getElementById("description").value,
        capacity: document.getElementById("capacity").value ? parseInt(document.getElementById("capacity").value) : null,
        allocated: document.getElementById("allocated").value ? parseInt(document.getElementById("allocated").value) : null,
        remainingCapacity: document.getElementById("remainingCapacity").value ? parseInt(document.getElementById("remainingCapacity").value) : null,
        totStrength: document.getElementById("totStrength").value ? parseInt(document.getElementById("totStrength").value) : null,
        examconductingStrength: document.getElementById("examconductingStrength").value ? parseInt(document.getElementById("examconductingStrength").value) : null,
        land: document.getElementById("land").value,
        builtupArea: document.getElementById("builtupArea").value,
        noofToilets: document.getElementById("noofToilets").value ? parseInt(document.getElementById("noofToilets").value) : null,
        noofLabs: document.getElementById("noofLabs").value ? parseInt(document.getElementById("noofLabs").value) : null,
        noofClassrooms: document.getElementById("noofClassrooms").value ? parseInt(document.getElementById("noofClassrooms").value) : null,
        availableDrinkingwater: document.getElementById("availableDrinkingwater").value ? (document.getElementById("availableDrinkingwater").value === "true") : null,
        yearEst: document.getElementById("yearEst").value,
        region: document.getElementById("region").value,
        urbanRural: document.getElementById("urbanRural").value,
        vtp: document.getElementById("vtp").value ? (document.getElementById("vtp").value === "true") : null,
        vtpRegno: document.getElementById("vtpRegno").value,
        admissionPermission: document.getElementById("admissionPermission").value ? (document.getElementById("admissionPermission").value === "true") : null,
        toolStatus: document.getElementById("toolStatus").value ? (document.getElementById("toolStatus").value === "true") : null
    };

    const designationCodes = [];
    const checkedDesignations = document.querySelectorAll('input[name="designation"]:checked');
    checkedDesignations.forEach(checkbox => {
        designationCodes.push(checkbox.value);
    });

    payload.designationCodes = designationCodes;

    return payload;
}

document.addEventListener("DOMContentLoaded", function () {
    loadDistricts();
    loadDesignations();

    document.getElementById("itiCreateForm").addEventListener("submit", function(e) {
        e.preventDefault();
        const payload = collectFormData();
        console.log("POST payload:", payload);

        fetch("http://localhost:8080/ItiapInstitute/api/itis", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        })
        .then(res => {
            if (!res.ok) {
                return res.json().then(data => {
                    throw { status: res.status, data: data };
                }).catch(() => {
                    throw { status: res.status, data: null };
                });
            }
            return res.json();
        })
        .then(responseData => {
            console.log("ITI created successfully:", responseData);
        })
        .catch(err => {
            if (err.status) {
                console.error("ITI creation failed:", err.status, err.data);
            } else {
                console.error("Error creating ITI:", err);
            }
        });
    });
});
</script>
</body>
</html>
