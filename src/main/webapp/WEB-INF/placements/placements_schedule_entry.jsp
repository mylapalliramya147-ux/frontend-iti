<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Placement Schedule Entry</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/siteScript.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- ITIAP uses server sessions, NOT the JWT the original page used -->
<script>
var roleId   = '<c:out value="${sessionScope.roleId}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';   /* e.g. http://localhost:5050/ */
</script>
<script>
$(document).ready(function(){

    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;

    loadScheduleItis();
    loadSchedules();

});

function loadScheduleItis() {
    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/schedule/itis?distCode=' + encodeURIComponent(insCode),
        cache: false,
        timeout: 600000,
        success: function(response){
            $("#scheduleLocation").append('<option value="">-select-</option>');
            response.forEach(function(iti){
                $("#scheduleLocation").append('<option value="' + iti.itiCode + '">' + (iti.itiName || iti.itiCode) + '</option>');
            });
        }
    });
}

function loadSchedules() {
    $.ajax({
        type: 'get',
        url: baseUrl + 'api/placements/schedule/list?distCode=' + encodeURIComponent(insCode),
        cache: false,
        timeout: 600000,
        success: function(response){
            $("#schedulebody").empty();
            if (!response.length) {
                $("#schedulebody").append('<tr><td colspan="5" style="text-align:center;padding:15px;font-weight:bold;">No schedules found.</td></tr>');
                return;
            }
            response.forEach(function(s){
                $("#schedulebody").append('<tr>'
                    + '<td>' + (s.id || '-') + '</td>'
                    + '<td>' + (s.location || '-') + '</td>'
                    + '<td>' + (s.date || '-') + '</td>'
                    + '<td>' + (s.type || '-') + '</td>'
                    + '<td>' + (s.description || '-') + '</td>'
                    + '</tr>');
            });
        }
    });
}

function validate() {
    $("#alertError").html('');
    var type = $("#scheduleType").val();
    var date = $("#scheduleDate").val();
    var location = $("#scheduleLocation").val();

    if (!type) { showError('Please select Schedule Type.'); return false; }
    if (!date) { showError('Please select Schedule Date.'); return false; }
    if (!location) { showError('Please select Schedule Location.'); return false; }

    var payload = {
        distCode: insCode,
        scheduleType: type,
        scheduleDate: date,
        scheduleLocation: location,
        scheduleDesc: $("#scheduleDesc").val() || ''
    };

    $.ajax({
        type: 'post',
        url: baseUrl + 'api/placements/schedule',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        cache: false,
        timeout: 600000,
        success: function(resp){
            if (resp && resp.status === 'SUCCESS') {
                showSuccess(resp.message || 'Schedule saved successfully.');
                $("#scheduleDate").val('');
                $("#scheduleDesc").val('');
                loadSchedules();
            } else {
                showError(resp && resp.message ? resp.message : 'Failed to save schedule.');
            }
        },
        error: function(xhr, status, error){
            showError('Error saving schedule: ' + error);
        }
    });
    return false;
}

function showSuccess(msg) {
    $("#successmsg").text(msg);
    $("#myModalSuccess").css('display','block');
}
function closeSuccess() {
    $("#myModalSuccess").css('display','none');
}
function showError(msg) {
    $("#alertError").html(msg);
    $("#myModalErroralert").css('display','block');
}
function closeError() {
    $("#myModalErroralert").css('display','none');
}
</script>
<style>
.required{ color: red; }
.mymodalsuccess { display: none; position: fixed; z-index: 1; padding-top: 220px; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0,0,0); background-color: rgba(0,0,0,0.4); }
.successcontent { background-color: #fefefe; margin: auto; padding: 20px; border: 1px solid #888; width: 80%; }
.modalErroralert { display: none; position: fixed; z-index: 1; padding-top: 220px; left: 0; top: 0; width: 100%; height: 100%; overflow-y: scroll; background-color: rgb(0,0,0); background-color: rgba(0,0,0,0.4); }
.modal-contenterroralert { background-color: #e4eeb9; border: 2px solid black; margin: auto; padding: 20px; width: 80%; }
#alertError { font-weight: bolder; color: red; font-size: larger; }
</style>
</head>
<body>

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container-fluid">

    <!-- Home -->
    <a class="navbar-brand" href="${pageContext.request.contextPath}/placements/loginSuccess">
        <i class="fas fa-home"></i> Home
    </a>

    <!-- Welcome User Info -->
    <div class="text-white fw-bold">
        Welcome :
        <span id="userinfo"></span>
    </div>

    <!-- Logout -->
    <div>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

</div>
</nav>
<br>
<div align="center" class="text-info font-weight-bolder"> PLACEMENT SCHEDULE ENTRY FORM </div>

    <div class="container inline-grid" style=" border: 2px solid black !important;
         background-color: #e4eeb9 !important; font-weight: bolder;
         margin: 0 auto; width: 90%;" id="formdiv"><br>

        <div class="row">
            <div class="col-sm-2 mt-1">Schedule Type</div>
            <div class="col-sm-2"><select name="scheduleType" id="scheduleType" class="custom-select form-control w-100" style="width:340px;">
                    <option value="">-select-</option>
                    <option value="Job">JOB</option>
                    <option value="Apprenticeship">APPRENTICESHIP</option>
                </select></div>
            <div class="col-sm-2 mt-1">Schedule Date</div>
            <div class="col-sm-2"><input type="date" name="scheduleDate" id="scheduleDate" class="form-control w-100" style="width:340px;"/></div>
            <div class="col-sm-2 mt-1">Schedule Location</div>
            <div class="col-sm-2 text-primary"><select name="scheduleLocation" class="custom-select form-control w-100" id="scheduleLocation" style="width:340px;">
                    <option value="">-select-</option>
                </select></div>
        </div>
        <div class="row">
            <div class="col-sm-2">Event Description</div>
            <div class="col-sm-2 mt-1"><textarea id="scheduleDesc" name="scheduleDesc" rows="2" cols="50"></textarea></div>
        </div>
        <div class="row">
            <div class="col-sm-2"></div>
            <div class="col-sm-2"></div>
            <div class="col-sm-4">
                <input type="button" class="btn btn-success mb-1 mt-1 w-50" value="Submit" id="submit" onclick="return validate();"/>
            </div>
            <div class="col-sm-2"> </div>
        </div>

    </div>

    <!--Operation Success Modal-->
    <div id="myModalSuccess" class="mymodalsuccess">
        <div class="successcontent">
            <button type="button" class="btn btn-warning" style="margin-left: 90%;" onclick="closeSuccess()">&#x2716;</button><br><br>
            <div align="center">
                <i class="fas fa-check-circle" style="color: green; font-size: 80px;"></i><br>
                <h3 style="color: green; font-weight: bolder; font-size: x-large">
                    <span id="successmsg"></span>
                </h3><br>
            </div>
        </div>
    </div>
    <!--Modal for Error Alerts-->
    <div id="myModalErroralert" class="modalErroralert">
        <div class="modal-contenterroralert">
            <div align="center">
                <button type="button" class="btn btn-success" onclick="closeError()">&#x2716;</button>
                <span id="alertError"></span><br>
                <i class="fas fa-exclamation-triangle" style="color: red; font-size: 80px;"></i>
            </div>
        </div>
    </div>


    <div align="center" class="text-info font-weight-bolder mt-2">AVAILABLE PLACEMENT SCHEDULES</div>

    <table class="table table-striped m-1">
        <thead class="table-dark">
        <tr>
        <th class="text-white">ID</th>
        <th class="text-white">LOCATION</th>
        <th class="text-white">DATE</th>
        <th class="text-white">TYPE</th>
        <th class="text-white">DESCRIPTION</th>
        </tr>
    </thead>
    <tbody id='schedulebody'>

    </tbody>
</table>
</body>
</html>
