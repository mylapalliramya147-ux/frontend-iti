function convertDateFormat() {
    var dob = $("#dobb").val();
    $("#dobbspan").val(dob);
}

// Global Image override
let editGlobalBase64Image = null;
function uploadImage() {
    var fileInput = document.getElementById('photo');
    if(!fileInput.files[0]) return;
    
    var file = fileInput.files[0];
    var fileSize = file.size / 1024; // KB
    if (fileSize > 200) {
        alert("File size (" + fileSize.toFixed(1) + " KB) exceeds the 200 KB limit. Please choose a smaller image.");
        fileInput.value = "";
        return;
    }

    var reader = new FileReader();
    reader.onload = function(e) {
        editGlobalBase64Image = e.target.result;
        $("#base64Image").val(editGlobalBase64Image);
        $("#photoPreview").attr('src', editGlobalBase64Image).show();
        // Also update the image container if it exists
        if($("#imageContainer").length) {
            $("#imageContainer").html('<img src="' + editGlobalBase64Image + '" id="photoPreview" style="max-width: 100%; max-height: 100%;">');
        }
    };
    reader.readAsDataURL(file);
}

$(document).ready(function() {
    if (window.location.pathname.includes("stdEditDetails.jsp")) {
        // Just the auth page, we only need to wait for validation click.
    }
});

function ssctype(type) {
    const subjects = ["first_lang", "second_lang", "third_lang", "maths", "science", "social"];
    if(type === 'sscm') {
        subjects.forEach(id => {
            $("#" + id).attr("placeholder", "Marks");
            $("#" + id).attr("maxlength", "3");
        });
    } else {
        subjects.forEach(id => {
            $("#" + id).attr("placeholder", "GPA");
            $("#" + id).attr("maxlength", "4");
        });
    }
}

function marksdiv(noOfLangs) {
    if(noOfLangs != "") {
        $("#marksrow").fadeIn();
        if(noOfLangs == "2") {
            $("#tl_label").text("English");
        } else {
            $("#tl_label").text("Third Language- English");
        }
    } else {
        $("#marksrow").hide();
    }
}

function calculateTotal() {
    var f1 = parseFloat($("#first_lang").val()) || 0;
    var f2 = parseFloat($("#second_lang").val()) || 0;
    var f3 = parseFloat($("#third_lang").val()) || 0;
    var f4 = parseFloat($("#maths").val()) || 0;
    var f5 = parseFloat($("#science").val()) || 0;
    var f6 = parseFloat($("#social").val()) || 0;
    var total = f1 + f2 + f3 + f4 + f5 + f6;
    $("#total_marks").val(total > 0 ? total : "");
}

function validate() {
    var regid = $("#regid").val(); 
    var dob = $("#dobb").val();
    var captcha = $("#txtInput").val();
    var ssc_regnoo = $("#ssc_regnoo").val(); 

    if(!regid || !dob || !captcha || !ssc_regnoo) {
        alert("Please fill all required fields.");
        return false;
    }

    var reqData = {
        regid: regid,
        ssc_regno: ssc_regnoo,
        dob: dob,
        captcha: captcha
    };

    $.ajax({
        url: API_BASE_URL + "/validateAndFetchRegistrationforEdit",
        type: "POST",
        contentType: "application/json",
        xhrFields: { withCredentials: true },
        crossDomain: true,
        data: JSON.stringify(reqData),
        success: function(res) {
            if(res.status === "SUCCESS") {
                // Populate data into the fields
                populateEditFields(res);
                // Switch forms
                $("#formOne").hide();
                $("#formTwo").fadeIn();
            } else {
                $("#errorMsg").html("<span style='color:red;font-weight:bold'>" + (res.message || "Invalid Details") + "</span>");
                // Do NOT refresh captcha - let user correct their input and resubmit
            }
        },
        error: function(err) {
            var msg = err.responseJSON && err.responseJSON.message ? err.responseJSON.message : "Error connecting to server";
            $("#errorMsg").html("<span style='color:red;font-weight:bold'>" + msg + "</span>");
            // Do NOT refresh captcha - let user correct their input and resubmit
        }
    });
}

function populateEditFields(res) {
    if(!res.student) return;
    var s = res.student;
    
    // Populate Boards first
    getAllSSCBoards(function(boards) {
        var boardSelect = $("#ssc_board");
        boardSelect.empty().append('<option value="">-select-</option>');
        if (boards) {
            $.each(boards, function(i, b) {
                boardSelect.append('<option value="' + b.boardCode + '">' + b.boardName + '</option>');
            });
            // Re-select the saved board after populating
            $("#ssc_board").val(res.student.ssc_board);
        }
    });

    // Populate Category / Caste
    getAllCastes(function(categories) {
        var casteSelect = $("#caste");
        casteSelect.empty().append('<option value="">-select-</option>');
        if (categories) {
            $.each(categories, function(i, bean) {
                casteSelect.append('<option value="' + bean.category_code + '">' + bean.category_name + '</option>');
            });
            // Re-select the saved caste after populating
            $("#caste").val(res.student.caste);
        }
    });
    
    // Auto-fill existing details into the DOM
    $("#ssc_regno").val(s.ssc_regno);
    $("#ssc_board").val(s.ssc_board);
    $("#ssc_year").val(s.ssc_year);
    $("#ssc_month").val(s.ssc_month);
    $("#name").val(s.name);
    $("#fname").val(s.fname);
    $("#mname").val(s.mname);
    $("#addr").val(s.addr);
    $("#phno").val(s.phno);
    $("#adarno").val(s.adarno);
    $("#gen").val(s.gender);
    $("#caste").val(s.caste);
    $("#dob").val(s.dob);
    $("#pincode").val(s.pincode);
    $("#email").val(s.email);
    
    // Select menus
    $("#phc").val(s.phc ? "true" : "false");
    $("#exs").val(s.exservice ? "true" : "false");
    $("#ssc").val(s.inter_passed ? "Inter" : "SSC");
    toggleInterMarks($("#ssc").val());
    if(s.inter_passed) {
        $("#inter_marks").val(s.inter_marks);
    }
    $("#ews").val(s.economic_weaker_section ? "true" : "false");
    $("#loconoc").val(s.local);
    $("#pwd_category").val(s.pwd_category || "0");
    $("#ssc_type").val(s.ssc_type);
    
    // Trigger SSC type logic
    if(s.ssc_type) ssctype(s.ssc_type);

    // Populate Marks if available
    if(res.marks) {
        var m = res.marks;
        var hasSecondLang = m.ssc_second_lang_marks !== null && m.ssc_second_lang_marks !== undefined;
        var hasThirdLang = m.ssc_eng_marks !== null && m.ssc_eng_marks !== undefined;
        
        $("#noOfLangs").val(hasSecondLang ? "3" : "2");
        marksdiv($("#noOfLangs").val());

        $("#first_lang").val(m.ssc_first_lang_marks || 0);
        $("#second_lang").val(m.ssc_second_lang_marks || 0);
        $("#third_lang").val(m.ssc_eng_marks || 0);
        $("#maths").val(m.ssc_math_marks || 0);
        $("#science").val(m.ssc_sci_marks || 0);
        $("#social").val(m.ssc_social_marks || 0);
        
        // Ensure total is recalculated visually without requiring a click
        if (typeof calculateTotal === "function") {
            calculateTotal();
        }
    }

    if(res.photo) {
        editGlobalBase64Image = res.photo;
        $("#base64Image").val(editGlobalBase64Image);
        $("#imageContainer").html('<img src="' + editGlobalBase64Image + '" id="photoPreview" style="max-width: 100%; max-height: 100%;">');
    }
}

function sendData() {
    var reqData = {
        regid: parseInt($("#regid").val()),
        ssc_regno: $("#ssc_regno").val(),
        name: $("#name").val(),
        fname: $("#fname").val(),
        mname: $("#mname").val(),
        address: $("#addr").val(),
        phno: $("#phno").val(),
        aadhar_no: $("#adarno").val(),
        gender: $("#gen").val(),
        caste: $("#caste").val(),
        ssc_passed: true,
        inter_passed: $("#ssc").val() === "Inter",
        inter_marks: $("#ssc").val() === "Inter" ? parseFloat($("#inter_marks").val() || 0) : null,
        local_status: $("#loconoc").val(),
        pincode: $("#pincode").val(),
        phc: $("#phc").val() === "true",
        exservice: $("#exs").val() === "true",
        economic_weaker_section: $("#ews").val() === "true",
        pwd_category: $("#pwd_category").val() !== "0" ? $("#pwd_category").val() : null,
        email: $("#email").val(),
        dob: $("#dob").val(),
        photo: editGlobalBase64Image,
        ssc_board: $("#ssc_board").val(),
        ssc_year: $("#ssc_year").val(),
        ssc_month: $("#ssc_month").val(),
        ssc_type: $("#ssc_type").val(),
        ssc_first_lang_marks: parseFloat($("#first_lang").val() || 0),
        ssc_second_lang_marks: parseFloat($("#second_lang").val() || 0),
        ssc_eng_marks: parseFloat($("#third_lang").val() || 0),
        ssc_math_marks: parseFloat($("#maths").val() || 0),
        ssc_sci_marks: parseFloat($("#science").val() || 0),
        ssc_social_marks: parseFloat($("#social").val() || 0),
        ssc_tot_marks: parseFloat($("#total_marks").val() || 0)
    };

    if(!$("#consent").is(":checked")) {
        $("#consentError").html("<span style='color:red;'>Please give your consent.</span>");
        return false;
    }

    $.ajax({
        url: API_BASE_URL + "/EditRegistration",
        type: "POST",
        contentType: "application/json",
        xhrFields: { withCredentials: true },
        crossDomain: true,
        data: JSON.stringify(reqData),
        success: function(res) {
            if(res.status === "SUCCESS") {
                window.location.href = "stdEditRegSuccess?regid=" + reqData.regid;
            } else {
                alert(res.message || "Failed to update");
            }
        },
        error: function(err) {
            var msg = err.responseJSON ? err.responseJSON.message : "Error executing update.";
            alert("Error: " + msg);
        }
    });

    return false;
}

function toggleInterMarks(val) {
    if (val === "Inter") {
        $("#interMarksRow").fadeIn();
    } else {
        $("#interMarksRow").hide();
        $("#inter_marks").val('');
        $("#interMarksError").text('');
    }
}
