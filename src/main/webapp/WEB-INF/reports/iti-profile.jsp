<!DOCTYPE html>
<html>
    <head>
        
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
<link rel="shortcut icon" type="image/ico" href="iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
    </head>

    <body>
        
<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
</center>

        





<head>

<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="shortcut icon" type="image/ico" href="iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">

</head>


<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">

<style>

/* ================= MENU CSS (Your Existing) ================= */






/* ================= POPUP CSS ================= */

.popup-overlay {
    display: none;
    position: fixed;
    z-index: 99999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.7);
}

.popup-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    padding: 8px;
    border-radius: 10px;
}

.popup-img {
    width: 500px;
    max-width: 90%;
    height: auto;
    cursor: pointer;
}

.close-btn {
    position: absolute;
    top: 5px;
    right: 12px;
    font-size: 30px;
    color: red;
    cursor: pointer;
}

</style>
</head>

<body>

<!-- ================= IMAGE POPUP ================= -->


<!-- ================= MENU BAR ================= -->

<%@ include file="../navbars/index_navbar.jsp" %>

<br><br>

<!-- ================= MARQUEE ================= -->





<marquee onmouseover="this.stop();"
          onmouseout="this.start();"
          scrolldelay="100">

<b>
<font color="blue" size="5">

<a href=""
   target="_blank">

 ITI Admissions 2026 Phase -3 registrations, applications and verifications available in  all GovtPvts ITIs on 15-08-2026 and 19-08-2026. 

</a>

</font>
</b>

</marquee>



<!-- ================= POPUP SCRIPT ================= -->

<script>

// Show popup on page load
window.onload = function () {

    document.getElementById(
        "airforcePopup"
    ).style.display = "block";

    // Auto close after 10 sec
    setTimeout(function () {

        closeAirforcePopup();

    }, 10000);
};

// Manual close
function closeAirforcePopup() {
    document.getElementById(
        "airforcePopup"
    ).style.display = "none";
}

</script>

<%@ include file="../footer.jsp" %>
</body>
</html>