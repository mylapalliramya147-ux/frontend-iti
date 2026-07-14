function convertDateFormat() {
    // Only needed if you want custom logic, otherwise raw "YYYY-MM-DD" from input type="date" is fine.
    var dobb = $("#dobb").val();
    $("#dobbspan").val(dobb);
}

// ---------------------- STEP 1 ----------------------
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
        url: API_BASE_URL + "/validatePhase1",
        type: "POST",
        contentType: "application/json",
        xhrFields: { withCredentials: true },
        crossDomain: true,
        data: JSON.stringify(reqData),
        success: function(res) {
            if(res.status === "SUCCESS") {
                // Successful Auth, redirect to Step 2
                window.location.href = "applyForITIStepTwo?regid=" + reqData.regid;
            } else {
                $("#errorMsg").html("<span style='color:red;font-weight:bold'>" + (res.message || "Invalid Details") + "</span>");
                // Do NOT refresh captcha on failure
            }
        },
        error: function(err) {
            var msg = err.responseJSON && err.responseJSON.message ? err.responseJSON.message : "Error connecting to server";
            $("#errorMsg").html("<span style='color:red;font-weight:bold'>" + msg + "</span>");
            // Do NOT refresh captcha on failure
        }
    });
}

// ---------------------- STEP 2 ----------------------
let selectedDistricts = []; // store dist_codes added
let currentRegId = ""; // store regid for submission

$(document).ready(function() {
    if(window.location.pathname.includes("applyForITIStepTwo") || window.location.pathname.includes("applyForITIPhase1StepTwo")) {
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
                    currentRegId = d.regid; // store the actual regid
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
                    $("#lbl_mname").text(d.mname || "N/A");
                    $("#lbl_phys").text(d.phc ? "Yes" : "No");
                    $("#lbl_pwd").text(d.pwd_category || "-");
                    $("#lbl_exserv").text(d.exservice ? "Yes" : "No");
                    $("#lbl_qual").text(d.ssc_passed ? "SSC Passed" : "Other");
                    $("#lbl_addr").text(d.addr || "N/A");
                    $("#lbl_pincode").text(d.pincode || "N/A");
                    $("#lbl_email").text(d.email || "N/A");
                    $("#lbl_local").text(d.local || "Local");
                    $("#lbl_ews").text(d.economic_weaker_section ? "Yes" : "No");
                    
                    // Display Caste Name instead of code
                    getCastesName(d.caste, function(name) {
                        $("#lbl_category").text(name || "N/A");
                    });
                    
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
                } else {
                    // Redirect back if unauthorized
                    window.location.href = "applyForITIStepOne";
                }
            },
            error: function() {
                alert("Session expired or unable to fetch profile");
                window.location.href = "applyForITIStepOne";
            }
        });

        // Load Districts Dictionary
        $.ajax({
            url: API_BASE_URL + '/getAllDists',
            type: 'POST',
            contentType: 'application/json',
            xhrFields: { withCredentials: true },
            crossDomain: true,
            success: function(itiRes) {
                var ds = $("#districtSelect");
                ds.empty();
                ds.append('<option value="">--Select District--</option>');
                var list = (itiRes && itiRes.data) ? itiRes.data : itiRes;
                if(list && list.length > 0) {
                    list.forEach(function(item) {
                        ds.append('<option value="' + item.distCode + '">' + item.distName + '</option>');
                    });
                }
            }
        });
    }
});

function addDistrict() {
    var val = $("#districtSelect").val();
    var txt = $("#districtSelect option:selected").text();
    
    if(!val) {
        alert("Please select a valid district.");
        return;
    }
    
    if(selectedDistricts.includes(val)) {
        alert("District already selected.");
        return;
    }
    
    selectedDistricts.push(val);
    var html = "<div style='display:flex; justify-content:space-between; border-bottom:1px solid #ccc; padding:3px 0;'><span>" + txt + "</span> <i class='fas fa-trash' style='color:red;cursor:pointer' onclick='removeDistrict(\"" + val + "\")'></i></div>";
    $("#selectedList").append(html);
}

function removeDistrict(val) {
    selectedDistricts = selectedDistricts.filter(function(code) { return code !== val; });
    // Re-render
    $("#selectedList").empty();
    selectedDistricts.forEach(function(code) {
        var txt = $("#districtSelect option[value='" + code + "']").text();
        var html = "<div style='display:flex; justify-content:space-between; border-bottom:1px solid #ccc; padding:3px 0;'><span>" + txt + "</span> <i class='fas fa-trash' style='color:red;cursor:pointer' onclick='removeDistrict(\"" + code + "\")'></i></div>";
        $("#selectedList").append(html);
    });
}

function submitApplication() {
    if(!$('#consent').is(':checked')) {
        alert("Please accept the consent declaration to proceed.");
        return;
    }
    if(selectedDistricts.length === 0) {
        alert("Please select at least one district.");
        return;
    }

    if(!currentRegId) {
        alert("Registration ID not found. Please refresh the page and try again.");
        return;
    }

    var reqData = {
        regid: currentRegId,
        dist_codes: selectedDistricts
    };

    $.ajax({
        url: API_BASE_URL + '/applyPhase1',
        type: 'POST',
        contentType: 'application/json',
        xhrFields: { withCredentials: true },
        crossDomain: true,
        data: JSON.stringify(reqData),
        success: function(res) {
            if(res.status === "SUCCESS") {
                // Success redirection to success logic.
                // We'll mock form submission to 'applyForITISuccess', but JSPs usually expect a standard POST.
                // For SPA-type approach, I can redirect using query string:
                window.location.href = "applyForITISuccess?regid=" + (res.regid || "SUCCESS");
            } else {
                alert(res.message);
            }
        },
        error: function(err) {
            var msg = err.responseJSON && err.responseJSON.message ? err.responseJSON.message : "Error applying phase 1";
            alert("Error: " + msg);
        }
    });
}
