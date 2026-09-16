<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires", 0); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="backendBaseUrl" value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IN-PLANT Entry</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/xlsx.full.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.all.min.css">
<script>
var insCode = '<c:out value="${sessionScope.insCode}" default=""/>';
var jwtToken = '';
var baseUrl = '${backendBaseUrl}/';
</script>
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border:1px solid black;width:100%;border-radius:2px;">
<%@ include file="../portal_navbar.jsp" %>
<br>
<div class="container border p-2 mt-2 shadow-lg" style="border-radius:5px;">
    <div align="center" style="text-decoration:underline;color:fuchsia;">IN-PLANT TRAINING ENTRY FORM</div>
    <div class="row">
        <div class="col-md-4">
            <label for="facultyName">Faculty Name</label>
            <input type="text" name="facultyName" class="form-control" id="facultyName" />
        </div>
        <div class="col-md-8">
            <label for="industryName">Industry Name / Firm Name</label>
            <select name="industryName" class="form-control" id="industryName"></select>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-md-4">
            <label for="location">Location</label>
            <input type="text" name="location" class="form-control" id="location" />
        </div>
        <div class="col-md-4">
            <label for="industryAddress">Industry Address</label>
            <input type="text" name="industryAddress" class="form-control" id="industryAddress" />
        </div>
        <div class="col-md-4">
            <label for="hrNo">HR Contact Number</label>
            <input type="text" name="hrNo" class="form-control" id="hrNo" maxlength="10" />
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-md-4">
            <label for="fromDate">From Date</label>
            <input type="date" name="fromDate" class="form-control" id="fromDate" />
        </div>
        <div class="col-md-4">
            <label for="toDate">To Date</label>
            <input type="date" name="toDate" class="form-control" id="toDate" />
        </div>
        <div class="col-md-4">
            <label for="noOfStudents">Number of Student U.T</label>
            <input type="text" name="noOfStudents" class="form-control" id="noOfStudents" maxlength="9"/>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-md-4">
            <label for="implantState">State</label>
            <select name="implantState" class="form-control" id="implantState" onchange="return getAllDists(this.value);"></select>
        </div>
        <div class="col-md-4">
            <label for="implantDist">District</label>
            <select name="implantDist" class="form-control" id="implantDist"></select>
        </div>
        <div class="col-md-4">
            <label for="description">Description</label>
            <textarea name="description" class="form-control" id="description"></textarea>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <input type="button" class="btn btn-success" value="Save" style="width:150px;margin-left:100px;" onclick="return saveImplant();" />
        </div>
        <div class="col-md-4"></div>
    </div>
    <div align="center" id="servermsg"></div>
</div>

<script>
$(document).ready(function(){
    var username = '<c:out value="${sessionScope.username}" default=""/>';
    var insName = '<c:out value="${sessionScope.itiName}" default=""/>';
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;
    getReady();
});

function getReady(){
    // Load industries for this ITI
    $.ajax({
        type:'get', url: baseUrl + 'api/implant/industries?itiCode=' + encodeURIComponent(insCode),
        cache:false, timeout:600000,
        success: function(response){
            $("#industryName").empty();
            $("#industryName").append('<option value="">-SELECT-</option>');
            if(response && response.length > 0){
                response.forEach(function(item){
                    $("#industryName").append('<option value="'+item[0]+'" data-address="'+item[2]+'" data-hrno="'+item[3]+'">'+item[1]+'</option>');
                });
            }
        }
    });
    // Load states
    $.ajax({
        type:'get', url: baseUrl + 'api/implant/master/states',
        cache:false, timeout:600000,
        success: function(response){
            $("#implantState").empty();
            $("#implantState").append('<option value="">-SELECT-</option>');
            if(response && response.length > 0){
                response.forEach(function(s){
                    $("#implantState").append('<option value="'+s.statecode+'">'+s.statename+'</option>');
                });
            }
        }
    });
}

function getAllDists(stateCode){
    $("#implantDist").empty();
    $("#implantDist").append('<option value="">-SELECT-</option>');
    if(!stateCode) return false;
    $.ajax({
        type:'get', url: baseUrl + 'api/implant/master/districts?stateCode=' + encodeURIComponent(stateCode),
        cache:false, timeout:600000,
        success: function(response){
            if(response && response.length > 0){
                response.forEach(function(d){
                    $("#implantDist").append('<option value="'+d.dist_code+'">'+d.dist_name+'</option>');
                });
            }
        }
    });
    return false;
}

function saveImplant(){
    var industryName = $("#industryName option:selected").text();
    var industryId = $("#industryName").val();
    if(!industryId){ $("#servermsg").html("<span style='color:red;'>Select Industry</span>"); return false; }
    var facultyName = $("#facultyName").val().trim();
    var location = $("#location").val().trim();
    var industryAddress = $("#industryAddress").val().trim();
    var hrNo = $("#hrNo").val().trim();
    var fromDate = $("#fromDate").val();
    var toDate = $("#toDate").val();
    var noOfStudents = $("#noOfStudents").val().trim();
    var implantDist = $("#implantDist").val();
    var description = $("#description").val().trim();

    if(!facultyName || !fromDate || !toDate || !noOfStudents){
        $("#servermsg").html("<span style='color:red;'>Please fill all mandatory fields (Faculty Name, From Date, To Date, No. of Students)</span>");
        return false;
    }
    if(!/^[A-Za-z][A-Za-z\s.]{1,49}$/.test(facultyName)){
        $("#servermsg").html("<span style='color:red;'>Faculty Name must contain only letters, spaces and dots (2-50 characters).</span>");
        return false;
    }
    if(hrNo && !/^\d{10}$/.test(hrNo)){
        $("#servermsg").html("<span style='color:red;'>HR Contact Number must be exactly 10 digits.</span>");
        return false;
    }
    if(!/^\d+$/.test(noOfStudents) || parseInt(noOfStudents, 10) <= 0 || parseInt(noOfStudents, 10) > 999999){
        $("#servermsg").html("<span style='color:red;'>Number of Students must be a positive number (1 - 999999).</span>");
        return false;
    }
    if(new Date(toDate) < new Date(fromDate)){
        $("#servermsg").html("<span style='color:red;'>To Date cannot be earlier than From Date.</span>");
        return false;
    }

    var data = {
        facultyName: facultyName,
        itiCode: insCode,
        industryAddress: industryAddress,
        hrNo: hrNo ? hrNo : null,
        location: location,
        fromDate: fromDate,
        toDate: toDate,
        noOfStudents: parseInt(noOfStudents) || 0,
        description: description,
        distcode: implantDist ? parseInt(implantDist) : null,
        industryName: industryName,
        industryId: parseInt(industryId),
        entryBy: insCode
    };

    $.ajax({
        type:'post', url: baseUrl + 'api/implant',
        contentType:'application/json', data: JSON.stringify(data), timeout:600000,
        success: function(response){
            $("#servermsg").html("<span style='color:green;'>In-Plant training saved successfully!</span>");
            $("#facultyName").val(""); $("#location").val(""); $("#industryAddress").val("");
            $("#hrNo").val(""); $("#fromDate").val(""); $("#toDate").val("");
            $("#noOfStudents").val(""); $("#description").val("");
            $("#implantState").val(""); $("#implantDist").empty(); $("#implantDist").append('<option value="">-SELECT-</option>');
        }, error: function(xhr){
            var msg = "Failed to save";
            try {
                var resp = typeof xhr.responseText === 'string' ? JSON.parse(xhr.responseText) : xhr.responseJSON;
                if (resp && resp.message) msg = resp.message;
            } catch(e) { /* keep default */ }
            $("#servermsg").html("<span style='color:red;'>Error: " + msg + "</span>");
        }
    });
    return false;
}
</script>
</body>
</html>
