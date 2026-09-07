// ---------------------- PHASE 2 STEP 1 ----------------------
function convertDateFormat() {
    var dobb = $("#dobb").val();
    $("#dobbspan").val(dobb);
}

function validate() {
    var isValid = true;
    
    var sscHallTicket = $("#ssc_regnoo").val();
    if(!sscHallTicket) { $("#ssc_regnoError").text("Required"); isValid = false; }
    
    var regid = $("#regid").val();
    if(!regid) { $("#regidError").text("Required"); isValid = false; }
    
    var dob = $("#dobb").val();
    if(!dob) { $("#dobbError").text("Required"); isValid = false; }
    
    var captcha = $("#txtInput").val();
    if(!captcha) { $("#captchaErr").text("Required"); isValid = false; }
    
    if(!isValid) return false;

    var reqData = {
        regid: regid,
        sscHallTicket: sscHallTicket,
        dob: dob,
        captcha: captcha
    };

    $.ajax({
        url: API_BASE_URL + "/validatePhase", // Phase 2 Auth Endpoint
        type: "POST",
        contentType: "application/json",
        xhrFields: { withCredentials: true },
        crossDomain: true,
        data: JSON.stringify(reqData),
        success: function(res) {
            if(res.status === "SUCCESS") {
                window.location.href = "applyForITIPhase2StepTwo?regid=" + reqData.regid;
            } else {
                $("#errorMsg").html("<span style='color:red;font-weight:bold'>" + (res.message || "Invalid Details") + "</span>");
                generateCaptcha();
            }
        },
        error: function(err) {
            var msg = err.responseJSON && err.responseJSON.message ? err.responseJSON.message : "Error connecting to server";
            $("#errorMsg").html("<span style='color:red;font-weight:bold'>" + msg + "</span>");
            generateCaptcha();
        }
    });
}

// ---------------------- PHASE 2 STEP 2 ----------------------
let selectedITIs = [];
let itiNamesCache = {}; 
let allAvailableITIs = []; 

$(document).ready(function() {
    if(window.location.pathname.includes("applyForITIPhase2StepTwo")) {
        // Load Application Details
        $.ajax({
            url: API_BASE_URL + '/getApplicationDetails',
            type: 'POST',
            contentType: 'application/json',
            xhrFields: { withCredentials: true },
            crossDomain: true,
            data: JSON.stringify({ regid: new URLSearchParams(window.location.search).get("regid") }),
            success: function(res) {
                if(res.status === "SUCCESS") {
                    var d = res.application;
                    $("#lbl_ssc_regno").text(d.ssc_regno || "N/A");
                    $("#lbl_board").text(d.ssc_board || "N/A");
                    $("#lbl_year").text(d.ssc_year || "N/A");
                    $("#lbl_month").text(d.ssc_month || "N/A");
                    $("#lbl_name").text(d.name || "N/A");
                    $("#lbl_phno").text(d.phno || "N/A");
                    $("#lbl_dob").text(d.dob || "N/A");
                    $("#lbl_aadhar").text(d.adarno || "N/A");
                    $("#lbl_fname").text(d.fname || "N/A");
                    $("#lbl_gender").text(d.gender || "N/A");
                    $("#lbl_category").text(d.caste || "N/A");
                    $("#lbl_local").text(d.local || "Local");
                    $("#lbl_mname").text(d.mname || "N/A");
                    $("#lbl_phys").text(d.phc ? "Yes" : "No");
                    $("#lbl_pwd").text(d.pwd_category || "-");
                    $("#lbl_exserv").text(d.exservice ? "Yes" : "No");
                    $("#lbl_qual").text(d.ssc_passed ? "SSC Passed" : "Other");
                    $("#lbl_addr").text(d.addr || "N/A");
                    $("#lbl_pincode").text(d.pincode || "N/A");
                    $("#lbl_email").text(d.email || "N/A");
                    $("#lbl_ews").text(d.economic_weaker_section ? "Yes" : "No");
                    
                    if(res.marks) {
                        var m = res.marks;
                        var getVal = function(val) {
                            return (val !== null && val !== undefined && val !== "") ? val : "-";
                        };
                        $("#lbl_m1").text(getVal(m.ssc_first_lang_marks));
                        $("#lbl_m2").text(getVal(m.ssc_second_lang_marks));
                        $("#lbl_m3").text(getVal(m.ssc_eng_marks));
                        $("#lbl_m4").text(getVal(m.ssc_math_marks));
                        $("#lbl_m5").text(getVal(m.ssc_sci_marks));
                        $("#lbl_m6").text(getVal(m.ssc_social_marks));
                        $("#lbl_mtot").text(getVal(m.ssc_tot_marks));
                    }

                    // 1. Populate District Select
                    var distSelect = $("#districtSelect");
                    distSelect.empty().append('<option value="">--Select District--</option>');
                    if(res.phase1Dists && res.phase1Dists.length > 0) {
                        res.phase1Dists.forEach(function(dist) {
                            distSelect.append(`<option value="${dist.dist_code}">${dist.dist_name}</option>`);
                        });
                    }

                    // 2. Fetch ITIs for these districts
                    $.ajax({
                        url: API_BASE_URL + '/getitisfromselecteddists',
                        type: 'POST',
                        contentType: 'application/json',
                        xhrFields: { withCredentials: true },
                        crossDomain: true,
                        data: JSON.stringify({ dist_codes: [] }), 
                        success: function(itiRes) {
                            if(itiRes && itiRes.status === "SUCCESS" && itiRes.data) {
                                allAvailableITIs = itiRes.data;
                                filterITIs(); // Initialize list
                            }
                        }
                    });

                } else {
                    window.location.href = "applyForITIPhase2StepOne";
                }
            },
            error: function() {
                alert("Session expired");
                window.location.href = "applyForITIPhase2StepOne";
            }
        });
    }
});

function filterITIs() {
    var distCode = $("#districtSelect").val();
    var type = $("#typeSelect").val();
    var itiSelect = $("#itiSelect");
    
    itiSelect.empty().append('<option value="">--Select ITI--</option>');
    
    var filtered = allAvailableITIs.filter(function(iti) {
        var matchDist = !distCode || iti.dist_code.trim() === distCode.trim();
        var matchType = !type || (type === 'G' && (iti.govt === 'G' || iti.iti_type === 'Govt')) || (type === 'P' && (iti.govt === 'P' || iti.iti_type === 'Private'));
        return matchDist && matchType;
    });
    
    filtered.forEach(function(iti) {
        var typeLabel = (iti.govt === 'G' || iti.iti_type === 'Govt') ? 'Govt' : 'Private';
        itiNamesCache[iti.iti_code] = iti.iti_name;
        itiSelect.append(`<option value="${iti.iti_code}">${iti.iti_name} (${typeLabel})</option>`);
    });
}

function addITIFromDropdown() {
    var code = $("#itiSelect").val();
    var name = itiNamesCache[code];
    
    if(!code) {
        alert("Please select an ITI from the dropdown.");
        return;
    }
    
    addITI(code, name);
    $("#itiSelect").val(""); 
}

function addITI(code, name) {
    if(!code || !name) return;
    
    if(selectedITIs.includes(code)) {
        alert("This ITI Choice is already in your preference list.");
        return;
    }
    
    itiNamesCache[code] = name; 
    selectedITIs.push(code);
    renderChoices();
}

function removeITI(code) {
    selectedITIs = selectedITIs.filter(function(c) { return c !== code; });
    renderChoices();
}

function renderChoices() {
    var tbody = $("#selectedTableBody");
    tbody.empty();
    if(selectedITIs.length === 0) {
        tbody.append('<tr><td colspan="3" style="text-align:center; padding: 15px; color: #94a3b8; font-style: italic;">No ITIs selected yet.</td></tr>');
        return;
    }
    
    selectedITIs.forEach(function(code, index) {
        var name = itiNamesCache[code] || "Unknown ITI";
        var idx = index + 1;
        var row = `<tr style="vertical-align: middle;">
            <td align="center" style="font-weight:bold;">${idx}</td>
            <td style="padding-left:15px; font-weight:600; color: #1e3a8a;">[${code}] ${name}</td>
            <td align="center">
                <button class="btn btn-sm btn-link text-danger text-decoration-none fw-bold" onclick="removeITI('${code}')">
                    <i class="fas fa-trash-alt me-1"></i> Delete
                </button>
            </td>
        </tr>`;
        tbody.append(row);
    });
}

function submitApplication() {
    if(!$('#consent').is(':checked')) {
        alert("Please accept the consent declaration to proceed.");
        return;
    }
    if(selectedITIs.length === 0) {
        alert("Please select at least one ITI.");
        return;
    }

    var reqData = {
        iti_codes: selectedITIs
    };

    $.ajax({
        url: API_BASE_URL + '/applyPhase',
        type: 'POST',
        contentType: 'application/json',
        xhrFields: { withCredentials: true },
        crossDomain: true,
        data: JSON.stringify(reqData),
        success: function(res) {
            if(res.status === "SUCCESS") {
                window.location.href = "applyForITIPhase2Success?regid=" + res.regid;
            } else {
                alert(res.message);
            }
        },
        error: function(err) {
            var msg = err.responseJSON && err.responseJSON.message ? err.responseJSON.message : "Error applying phase 2";
            alert("Error: " + msg);
        }
    });
}
