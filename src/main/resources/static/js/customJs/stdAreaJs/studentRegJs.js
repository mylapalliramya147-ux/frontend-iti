// Convert element value to uppercase
function convertToUppercase(element) {
    element.value = element.value.toUpperCase();
}

$(document).ready(function() {
    // Populate SSC Boards dropdown is handled in studentRegStep1.jsp inline script


    // Load category / caste
    var casteSelect = $("#caste");
    casteSelect.empty();
    casteSelect.append('<option value="">-select-</option>');
    getAllCastes(function(categories) {
        if (categories && categories.length > 0) {
            $.each(categories, function(i, bean) {
                casteSelect.append('<option value="'+bean.category_code+'">'+bean.category_name+'</option>');
            });
        }
    });
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
    // Keep all rows visible as per user's latest request to have 6 subjects
    $("#slrow").show();
    $("#tlrow").show();
    
    if(noOfLangs == "2") {
        $("#tl_label").text("English");
    } else {
        $("#tl_label").text("Third Language- English");
    }
    
    calculateTotal();
}

function checkPwd(val) {
    if(val === "true" || val === true) {
        $("#pwd_category").prop("disabled", false);
    } else {
        $("#pwd_category").val("0");
        $("#pwd_category").prop("disabled", true);
    }
}

// Global variable for the image
let globalBase64Image = null;

function uploadImage() {
    var fileInput = document.getElementById('photo');
    var file = fileInput.files[0];
    var reader = new FileReader();
    reader.onload = function(e) {
        globalBase64Image = e.target.result;
        document.getElementById("base64Image").value = globalBase64Image;
    };
    reader.readAsDataURL(file);
}

function sendData() {
    var isValid = true;
    
    // Simple exhaustive frontend validation
    const reqFields = ["ssc_regno", "ssc_board", "ssc_year", "ssc_month", "name", "phno", "dob", "adarno", "gen", "caste", "fname", "phc", "mname", "exs", "ssc", "addr", "loconoc", "pincode", "ews", "ssc_type", "noOfLangs"];
    reqFields.forEach(function(f) {
        if(!$("#" + f).val()) {
            $("#" + f + "Error").text("Required");
            isValid = false;
        } else {
            $("#" + f + "Error").text("");
        }
    });

    if(!globalBase64Image) {
        $("#photoError").text("Photo is required");
        isValid = false;
    }

    if(!isValid) {
        alert("Please fill all required fields correctly.");
        return false;
    }
    
    // Check Inter Marks specifically if 'Inter' is chosen
    if ($("#ssc").val() === "Inter") {
        if (!$("#inter_marks").val()) {
            $("#interMarksError").text("Inter Marks are required.");
            alert("Please provide your Inter Marks.");
            return false;
        }
    }

    var requestData = {
        name: $("#name").val(),
        fname: $("#fname").val(),
        mname: $("#mname").val(),
        address: $("#addr").val(),
        phno: $("#phno").val(),
        aadhar_no: $("#adarno").val(),
        gender: $("#gen").val(),
        caste: $("#caste").val(),
        qualification: $("#ssc").val(),
        ssc_passed: true,
        inter_passed: $("#ssc").val() === "Inter",
        local_status: $("#loconoc").val(),
        pincode: $("#pincode").val(),
        phc: $("#phc").val() === "true",
        pwd_category: $("#pwd_category").val() !== "0" ? $("#pwd_category").val() : null,
        exservice: $("#exs").val() === "yes",
        dob: $("#dob").val(),
        ssc_regno: $("#ssc_regno").val(),
        ssc_board: $("#ssc_board").val(),
        ssc_year: parseInt($("#ssc_year").val()),
        ssc_month: $("#ssc_month").val(),
        ssc_type: $("#ssc_type").val(),
        email: $("#email").val() || null,
        economic_weaker_section: $("#ews").val() === "yes",
        ssc_first_lang_marks: parseFloat($("#first_lang").val() || 0),
        ssc_second_lang_marks: parseFloat($("#second_lang").val() || 0),
        ssc_eng_marks: parseFloat($("#third_lang").val() || 0),
        ssc_math_marks: parseFloat($("#maths").val() || 0),
        ssc_sci_marks: parseFloat($("#science").val() || 0),
        ssc_social_marks: parseFloat($("#social").val() || 0),
        inter_passed: $("#ssc").val() === "Inter",
        inter_marks: $("#ssc").val() === "Inter" ? parseFloat($("#inter_marks").val() || 0) : null,
        photo: globalBase64Image
    };

    $.ajax({
        url: API_BASE_URL + "/register",
        type: "POST",
        contentType: "application/json",
        xhrFields: { withCredentials: true },
        crossDomain: true,
        data: JSON.stringify(requestData),
        success: function(res) {
            if(res.success) {
                // Populate the hidden form regid to post to success page
                $("#regid").val(res.regid);
                $("#registrationForm").submit();
            } else {
                alert("Failed: " + res.message);
            }
        },
        error: function(err) {
            var msg = err.responseJSON ? err.responseJSON.message : "Error submitting form.";
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
