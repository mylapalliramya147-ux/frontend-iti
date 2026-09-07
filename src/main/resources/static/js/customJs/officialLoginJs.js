/**
 * Official Login JS
 * Handles captcha generation and login authentication for ITI Admissions.
 * Uses same-origin endpoints (Spring Boot) to avoid CORS issues.
 */

$(document).ready(function() {
    // Initial captcha load
    refreshCaptcha();

    // Trigger login on Enter key
    $("#password, #username, #captcha").keypress(function(event) {
        if (event.which == 13) {
            handleLogin();
        }
    });
});

let captchaToken = null;

/**
 * Fetches a new captcha from the Spring Boot backend (same-origin)
 */
function refreshCaptcha() {
    $.ajax({
        type: 'POST',
        url: './generateCaptcha',
        success: function(resp) {
            if (resp.status === "SUCCESS") {
                captchaToken = resp.captchaToken;
                $("#captchaDisplay").val(resp.captcha);
            }
        },
        error: function() {
            console.error("Failed to generate captcha from server. Falling back to local generation.");
            // Local captcha fallback
            var chars = new Array('1','2','3','4','5','6','7','8','9','0');
            var code = '';
            for (var i = 0; i < 4; i++) {
                code += chars[Math.floor(Math.random() * chars.length)];
            }
            $("#captchaDisplay").val(code);
        }
    });
}

/**
 * Submits credentials to the Spring Boot login API (same-origin)
 */
function handleLogin() {
    const username = $("#username").val().trim();
    const password = $("#password").val().trim();
    const captcha = $("#captcha").val().trim();

    // Basic validation
    if (!username || !password || !captcha) {
        showError("Please fill in all fields.");
        return;
    }

    // Clear previous errors
    $("#errorMsg").hide().text("");

    $.ajax({
        type: 'POST',
        url: './officialLogin',
        contentType: 'application/json',
        data: JSON.stringify({
            username: username,
            password: password,
            captcha: captcha,
            captchaToken: captchaToken
        }),
        success: function(resp) {
            if (resp.status === "SUCCESS") {
                // Success feedback
                $("#loginBtn").prop("disabled", true).text("Logging in...");
                
                // Redirect based on role or to a default dashboard
                setTimeout(function() {
                    // Save for authHome dashboard display
                    localStorage.setItem('userRole', resp.user.roleid);
                    localStorage.setItem('username', resp.user.username);
                    localStorage.setItem('insCode', resp.user.ins_code);
                    localStorage.setItem('displayName', resp.user.displayName || resp.user.username);
                    localStorage.setItem('loginTime', new Date().toLocaleString());

                    window.location.href = "./authHome"; 
                }, 500);
            } else {
                showError(resp.message || "Login failed. Please try again.");
                refreshCaptcha();
                $("#captcha").val("");
            }
        },
        error: function(xhr) {
            const resp = xhr.responseJSON;
            showError(resp && resp.message ? resp.message : "Invalid credentials or login failed.");
            refreshCaptcha(); // Refresh captcha on failure
            $("#captcha").val(""); // Clear captcha field
        }
    });
}

/**
 * Displays error messages with a subtle animation
 */
function showError(msg) {
    $("#errorMsg").text(msg).fadeIn();
    // Shake animation effect
    $(".login-card").addClass("shake");
    setTimeout(() => {
        $(".login-card").removeClass("shake");
    }, 500);
}