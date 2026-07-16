function validate() {
    var isValid = true;
    
    var boardCode = $("#boardCode").val();
    if (!boardCode) {
        $("#boardCodeError").html("Please select a Board.");
        isValid = false;
    }

    var regno = $("#ssc_regnoo").val();
    if (!regno) {
        $("#ssc_regnooError").html("Hall Ticket number is required.");
        isValid = false;
    }
    
    var passingYear = $("#passingYear").val();
    if (!passingYear || !passingYear.match('^[0-9]{4}$')) {
        $("#passingYearError").html("Invalid Year.");
        isValid = false;
    }
    
    var dob = $("#dob").val();
    if(!dob) {
        $("#dobError").html("Date of Birth is required.");
        isValid = false;
    }
    
    var resultType = $("#resultType").val();
    if (!resultType) {
        $("#resultTypeError").html("Result Type is required.");
        isValid = false;
    }

    var captcha = $("#txtInput").val();
    if (!captcha) {
        $("#captchaErr").html("Captcha is required.");
        isValid = false;
    }
    
    if (!isValid) return false;

    // Call API to validate
    var reqBody = {
        sscBoard: boardCode,
        sscRegno: regno,
        sscYear: parseInt(passingYear),
        dob: dob,
        resultType: resultType,
        captcha: captcha
    };

    $.ajax({
        url: API_BASE_URL + '/validateStudentRegistration',
        type: 'POST',
        contentType: 'application/json',
        xhrFields: { withCredentials: true },
        crossDomain: true,
        data: JSON.stringify(reqBody),
        success: function (res) {
            if (res.status === "VALIDATED") {
                // Submit the form to proceed to Step 1 JSP
                $("#regForm").submit();
            } else if (res.status === "ALREADY_REGISTERED") {
                // Redirect to the dedicated already exists page
                window.location.href = "stdRegAlreadyExists?regid=" + res.regid;
            } else {
                $("#existRegMsg").html('<span style="color:red; font-weight:bold;">' + res.message + '</span>');
                generateCaptcha();
            }
        },
        error: function (err) {
            var msg = err.responseJSON && err.responseJSON.message ? err.responseJSON.message : "Server error";
            $("#existRegMsg").html('<span style="color:red; font-weight:bold;">' + msg + '</span>');
            generateCaptcha();
        }
    });

    return false; // Prevent default submission so AJAX handles it
}
