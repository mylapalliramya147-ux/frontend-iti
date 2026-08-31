<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.sessionUser}"><c:redirect url="/?error=session"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ITI Placements / In-Plant Training - Dashboard</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.8/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.8/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style>
body{margin:0;background:#f5f5f5;font-family:'Segoe UI',Arial,sans-serif;}
.header-banner{width:100%;height:110px;background:#172233 url('${pageContext.request.contextPath}/images/gen.jpg') center center no-repeat;background-size:cover;display:flex;align-items:center;justify-content:center;color:#fff;font-size:22px;font-weight:bold;text-shadow:1px 1px 4px rgba(0,0,0,.7);}
.navbar{background:#172233;padding:10px 16px;}
.navbar .brand{display:inline-flex;align-items:center;color:#fff;text-decoration:none;font-weight:700;font-size:18px;}
.navbar .brand img{height:34px;margin-right:10px;}
.navbar .navlinks{display:inline-flex;align-items:center;gap:14px;}
.navbar .navlinks a{color:#fff;text-decoration:none;font-size:14px;}
.navbar .navlinks a:hover{color:#ffc107;}
.navbar .user-dd{position:relative;display:inline-block;}
.navbar .dropdown-menu-right{position:absolute;right:0;top:30px;background:#fff;border:1px solid #ccc;border-radius:4px;min-width:170px;box-shadow:0 2px 8px rgba(0,0,0,.15);}
.navbar .dropdown-menu-right a{display:block;padding:6px 12px;color:#212529;text-decoration:none;font-size:13px;}
.navbar .dropdown-menu-right a:hover{background:#f0f0f0;}
.card{border:none;border-radius:8px;box-shadow:0 1px 4px rgba(0,0,0,.1);}
.card-header{border-radius:8px 8px 0 0!important;background:#fff;border-bottom:2px solid #172233;color:#172233;font-weight:700;font-size:15px;}
.card-body{padding:14px 16px;}
.stat{font-size:26px;font-weight:700;color:#172233;}
.stat-sub{font-size:13px;color:#6c757d;}
.menu-list a{display:block;padding:4px 0;color:#212529;text-decoration:none;font-size:13px;}
.menu-list a:hover{background:#eef5ff;border-radius:3px;}
</style>
</head>
<body>
<div class="header-banner">
ITI Placements / In-Plant Training - Dashboard
</div>
<nav class="navbar">
  <div class="d-flex justify-content-between align-items-center w-100">
    <a class="brand" href="${pageContext.request.contextPath}/placements/loginSuccess"><img src="${pageContext.request.contextPath}/images/gen.jpg" alt="ITI" class="img-fluid">ITIAP</a>
    <div class="navlinks">
      <a href="${pageContext.request.contextPath}/placements/loginSuccess"><i class="fa fa-home"></i> Home</a>
      <c:if test="${not empty sessionScope.itiName}">
        <span style="color:#cfe3ff;font-size:13px;">ITI: ${sessionScope.itiName}</span>
      </c:if>
      <div class="user-dd dropdown">
        <span class="name dropdown-toggle" id="userMenu" type="button" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fa fa-user"></i>
          <c:if test="${not empty sessionScope.username}">${sessionScope.username}</c:if>
          <c:if test="${empty sessionScope.username}">User</c:if>
        </span>
        <ul class="dropdown-menu dropdown-menu-right">
          <li><a class="dropdown-item" href="#">Change User Details</a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out"></i> Logout</a></li>
        </ul>
      </div>
    </div>
  </div>
</nav>

<div class="container-fluid py-3">
  <div class="row g-3 mb-3">
    <div class="col-md-4">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-briefcase"></i> PLACEMENTS</div>
        <div class="card-body text-center">
          <div class="stat" id="allPlacement">—</div>
          <div class="stat-sub">Total Placements</div>
          <table class="table table-borderless table-sm mt-2 mb-0">
            <tr><td class="stat-sub">Job</td><td class="text-end"><span id="jobTotal">—</span></td></tr>
            <tr><td class="stat-sub">Other than Job</td><td class="text-end"><span id="oaTotal">—</span></td></tr>
            <tr><td class="stat-sub">Apprenticeship</td><td class="text-end"><span id="apprenticeTotal">—</span></td></tr>
            <tr><td class="stat-sub">Higher Education</td><td class="text-end"><span id="heTotal">—</span></td></tr>
            <tr><td class="stat-sub">Self Employment</td><td class="text-end"><span id="seTotal">—</span></td></tr>
            <tr><td class="stat-sub">Distinct ITIs</td><td class="text-end"><span id="placementsDistinctItis">—</span></td></tr>
          </table>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-industry"></i> IN-PLANT TRAINING</div>
        <div class="card-body text-center">
          <div class="stat" id="inplantTotal">—</div>
          <div class="stat-sub">Total In-Plant Training</div>
          <table class="table table-borderless table-sm mt-2 mb-0">
            <tr><td class="stat-sub">Distinct ITIs</td><td class="text-end"><span id="inplantDistinctItis">—</span></td></tr>
            <tr><td class="stat-sub">Distinct Industries</td><td class="text-end"><span id="inplantDistinctIndustries">—</span></td></tr>
            <tr><td class="stat-sub">Students</td><td class="text-end"><span id="sumOfStudent">—</span></td></tr>
          </table>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-flask"></i> LABORATORIES</div>
        <div class="card-body text-center">
          <div class="stat" id="labsTotal">—</div>
          <div class="stat-sub">Total Labs</div>
          <table class="table table-borderless table-sm mt-2 mb-0">
            <tr><td class="stat-sub">Distinct ITIs</td><td class="text-end"><span id="labsDistinctItis">—</span></td></tr>
            <tr><td class="stat-sub">Distinct Trades</td><td class="text-end"><span id="labsDistinctTrades">—</span></td></tr>
            <tr><td class="stat-sub">Total Items</td><td class="text-end"><span id="labItemsTotal">—</span></td></tr>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="container-fluid pb-4">
  <div class="row g-3">
    <div class="col-md-3">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-cog"></i> SERVICES</div>
        <div class="card-body">
          <div class="menu-list">
            <a href="#">Change User Details</a>
            <a href="#">My Profile</a>
            <a href="#">Change Password</a>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-briefcase"></i> PLACEMENTS</div>
        <div class="card-body">
          <div class="menu-list">
            <a href="#">Placement Entry</a>
            <a href="#">Placement Report</a>
            <a href="#">Placement Schedule Entry</a>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-industry"></i> IN-PLANT TRAINING</div>
        <div class="card-body">
          <div class="menu-list">
            <a href="#">In-Plant Entry</a>
            <a href="#">In-Plant Report</a>
            <a href="#">In-Plant Schedule Entry</a>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card h-100">
        <div class="card-header"><i class="fa fa-flask"></i> LABORATORIES</div>
        <div class="card-body">
          <div class="menu-list">
            <a href="#">Lab Entry</a>
            <a href="#">Lab Item List</a>
            <a href="#">Lab Report</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
// Stat cards are wired to the real ITIAP Backend APIs:
//   GET /api/placements/overviewdetails  (allPlacement)
//   GET /api/placements/countPlacementsGroupedByPtype  (Job, OA, Apprenticeship, HigherEducation, SelfEmployment)
//   GET /api/placements/getdDistinctItiCodesByPtype  (jobItisCount ...)
//   GET /api/implant/overviewdetails  (inplantTotal, inplantDistinctItis, industriesDistinctIndustries, sumOfStudent)
//   GET /api/labs/overviewdetails  (labsTotal, labsDistinctItis, labsDistinctTrades, labItemsTotal)
// All service "target buttons" in the menu cards above are stubs (href="#")
// so clicking them does nothing until those features are implemented.
(function ($) {
    var baseUrl = "${backendBaseUrl}"; // e.g. http://localhost:5050
    function fmt(v) {
        return (v === null || v === undefined || isNaN(v)) ? '—' : Number(v).toLocaleString('en-US');
    }
    $.get(baseUrl + "/api/placements/overviewdetails").done(function (r) {
        if (r) { $("#allPlacement").text(fmt(r.allPlacement)); }
    }).fail(function () { $("#allPlacement").text('—'); });

    $.get(baseUrl + "/api/placements/countPlacementsGroupedByPtype").done(function (r) {
        if (r) {
            $("#jobTotal").text(fmt(r.Job));
            $("#oaTotal").text(fmt(r.OA));
            $("#apprenticeTotal").text(fmt(r.Apprenticeship));
            $("#heTotal").text(fmt(r.HigherEducation));
            $("#seTotal").text(fmt(r.SelfEmployment));
        }
    }).fail(function () { });

    $.get(baseUrl + "/api/placements/getdDistinctItiCodesByPtype").done(function (r) {
        if (r) { $("#placementsDistinctItis").text(fmt(r.jobItisCount)); }
    }).fail(function () { });

    $.get(baseUrl + "/api/implant/overviewdetails").done(function (r) {
        if (r) {
            $("#inplantTotal").text(fmt(r.inplantTotal));
            $("#inplantDistinctItis").text(fmt(r.inplantDistinctItis));
            $("#inplantDistinctIndustries").text(fmt(r.industriesDistinctIndustries));
            $("#sumOfStudent").text(fmt(r.sumOfStudent));
        }
    }).fail(function () { });

    $.get(baseUrl + "/api/labs/overviewdetails").done(function (r) {
        if (r) {
            $("#labsTotal").text(fmt(r.labsTotal));
            $("#labsDistinctItis").text(fmt(r.labsDistinctItis));
            $("#labsDistinctTrades").text(fmt(r.labsDistinctTrades));
            $("#labItemsTotal").text(fmt(r.labItemsTotal));
        }
    }).fail(function () { });
})(jQuery);
</script>
</body>
</html>
