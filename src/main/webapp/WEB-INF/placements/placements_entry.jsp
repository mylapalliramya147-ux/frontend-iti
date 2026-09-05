<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Placements Entry</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/siteScript.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script>
var roleId   = '<c:out value="${sessionScope.roleId}" default=""/>';
var insCode  = '<c:out value="${sessionScope.insCode}" default=""/>';
var username = '<c:out value="${sessionScope.username}" default=""/>';
var insName  = '<c:out value="${sessionScope.itiName}" default=""/>';
var baseUrl  = '${backendBaseUrl}/';
</script>
<style>
.container-fluid{border:2px solid black !important;padding:5px !important;background-color:#e4eeb9 !important;}
.h3{text-decoration:underline !important;}
#namespan,#adm_numspan,#yearspan{color:blue;}
.editanchor{border:1px solid black;background:lightgoldenrodyellow;font-weight:bolder;padding:2px;}
.deleteanchor{border:1px solid black;background:lightcoral;font-weight:bolder;padding:2px;}
.required{color:red;font-weight:bolder;}
#scrollbar{width:800px;height:300px;overflow-x:hidden;overflow-y:auto;text-align:justify;}
.modal1,.modalalert,.modalErroralert,.mymodalsuccess,.savingplcmtmodel,.admNotFound,.modaldeletealert,.modal{display:none;position:fixed;z-index:1;padding-top:220px;left:0;top:0;width:100%;height:100%;overflow:auto;background-color:rgba(0,0,0,0.4);}
.modal-content1,.modal-contentalert,.modal-contenterroralert,.successcontent,.savingplcmtcontent,.admnotfound-content,.modal-content{background-color:#fefefe;margin:auto;padding:20px;border:1px solid #888;width:80%;}
.modal-content1,.modal-contentalert,.modal-contenterroralert,.admnotfound-content,.modal-content{background-color:#e4eeb9;border:2px solid black;}
.close1,.alert-close,.alertError-close{color:#aaa;float:right;font-size:28px;font-weight:bold;}
.close1:hover,.close1:focus,.alert-close:hover,.alert-close:focus,.alertError-close:hover,.alertError-close:focus{color:#000;text-decoration:none;cursor:pointer;}
#alertError{font-weight:bolder;color:red;font-size:larger;}
</style>
</head>
<body>
<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border:1px solid black;width:100%;border-radius:2px;">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container-fluid">
<a class="navbar-brand" href="${pageContext.request.contextPath}/placements/loginSuccess"><i class="fas fa-home"></i> Home</a>
<div class="text-white fw-bold">Welcome : <span id="userinfo"></span></div>
<div><a href="${pageContext.request.contextPath}/logout" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
</div>
</nav>
<br>
<div align="center" style="text-decoration:underline;color:fuchsia;">PLACEMENT ENTRY FORM</div>
<div class="container border p-2 mt-2 shadow-lg w-50" style="background-color:white !important;font-weight:bolder;margin:0 auto;width:90%;" id="formdiv">
<div class="row"><div class="col-md-4"></div><div class="col-md-4"><label for="adm_num">Admission Number</label><input type="text" name="adm_num" class="form-control" id="adm_num" minlength="10" maxlength="11"/></div><div class="col-md-4"></div></div>
<div class="row"><div class="col-sm-4"></div><div class="col-sm-4"><label>Captcha</label><input type="text" id="txtInput" class="form-control" maxlength="4"/></div><div class="col-sm-4"><span id="error" style="color:red"></span></div></div>
<div class="row"><div class="col-sm-4"></div><div class="col-sm-4"><input type="text" id="mainCaptcha" readonly="readonly" class="form-control w-100 mb-1 mt-1" style="letter-spacing:30px;font-weight:bolder;color:white;background-color:black;"/></div><div class="col-sm-2"><i class="fas fa-sync-alt float-left mt-1" style="cursor:pointer;font-size:24px;" id="refresh" onclick="generateCaptchaa();"></i></div></div>
<div class="row"><div class="col-sm-4"></div><div class="col-sm-4"><button type="button" class="btn btn-success float-left" id="findAdmbtn" onclick="return findAdmnum()">Get Details</button></div><div class="col-sm-4"></div></div>
<br><div align="center"><a href="javascript:void(0);" onclick="findByNames();" style="color:blue;text-decoration:underline;cursor:pointer;">You Can Find Admission Number By Name</a></div>
</div>
<br>
<div class="container-fluid" style="border:2px solid black !important;background-color:white !important;font-weight:bolder;margin:0 auto;width:90%;display:none;" id="admissiondetails">
<div align="center" style="color:tomato;text-decoration:underline;" id="admdetailsheading">ADMISSION DETAILS</div>
<div class="row" id="namerow"><div class="col-2"><label class="float-right">Name</label></div><div class="col-4"><label><span id="name"></span><input type="hidden" name="name"/></label></div><div class="col-2"><label class="float-right">ITI Name</label></div><div class="col-4"><label><span id="iti_namespan"></span><input type="hidden" name="iti_name" id="iti_name"/><input type="hidden" name="iti_code" id="iti_code"/></label></div></div>
<div class="row" id="distrow"><div class="col-2"><label class="float-right">District Name</label></div><div class="col-4"><label><span id="dist_namespan"></span><input type="hidden" name="dist_name" id="dist_name"/><input type="hidden" name="dist_code" id="dist_code"/></label></div><div class="col-2"><label class="float-right">Admission Year</label></div><div class="col-4"><label><span id="year_of_admission"></span><input type="hidden" name="year_of_admission"/></label></div></div>
<div class="row" id="traderow"><div class="col-2"><label class="float-right">Admitted Trade</label></div><div class="col-4"><label><span id="trade_codespan"></span><input type="hidden" name="trade_code" id="trade_code"/><input type="hidden" name="trade_name" id="trade_name"/></label></div></div>
</div>
<br>
<div align="center" id="plcmt_detailstabheading" style="color:tomato;text-decoration:underline;font-weight:bold;display:none;">AVAILABLE PLACEMENT DETAILS OF THE CANDIDATE</div>
<table border="1" id="plcmt_detailstab" class="table table-striped" style="display:none;">
<thead class="table-dark">
<tr><th class="text-white">Year of Pass</th><th class="text-white">Placement Type</th><th class="text-white">Name of the Company</th><th class="text-white">Post Name</th><th class="text-white">Salary</th><th class="text-white">Trade</th><th class="text-white">Stipend Amount</th><th class="text-white">Apprenticeship Start Date</th><th class="text-white">Apprenticeship End Date</th><th class="text-white">HR Contact Number</th><th class="text-white">Name of the Course</th><th class="text-white">Name of the College</th><th class="text-white">Name of the Self Employment</th><th class="text-white">Monthly Income</th><th class="text-white">Address</th></tr>
</thead>
<tbody id="plcmt_detailsbody"></tbody>
</table>

<div class="container-fluid" style="border:2px solid black !important;background-color:#e4eeb9 !important;font-weight:bolder;margin:0 auto;width:90%;display:none;" id="placementdiv">
<div align="center" style="color:tomato;text-decoration:underline;">ENTER PLACEMENT DETAILS</div>
<div class="row" id="monthofpassyeardiv">
<div class="col-2" id="passmonthlabel"><label class="float-right">Trainee Pass Month <span class="required">*</span></label></div>
<div class="col-4" id="passmonthdiv"><label><select name="passmonth" id="passmonth" class="custom-select form-control" style="width:340px;"><option value="">-SELECT-</option><option value="January">January</option><option value="February">February</option><option value="March">March</option><option value="April">April</option><option value="May">May</option><option value="June">June</option><option value="July">July</option><option value="August">August</option><option value="September">September</option><option value="October">October</option><option value="November">November</option><option value="December">December</option></select></label></div>
<div class="col-2" id="passyearlabel"><label class="float-right">Trainee Pass Year <span class="required">*</span></label></div>
<div class="col-4" id="passyeardiv"><label><select name="passyear" id="passyear" class="custom-select form-control" style="width:340px;"><option value="">-SELECT-</option>
<option value="2011">2011</option><option value="2012">2012</option><option value="2013">2013</option><option value="2014">2014</option><option value="2015">2015</option><option value="2016">2016</option><option value="2017">2017</option><option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option><option value="2023">2023</option><option value="2024">2024</option><option value="2025">2025</option><option value="2026">2026</option>
</select></label></div>
</div>
<div class="row" id="plcmttypediv">
<div class="col-2" id="plcmtYearLabel"><label class="float-right">Placement Year <span class="required">*</span></label></div>
<div class="col-4" id="plcmtYearDiv"><label><select name="plcmtYear" id="plcmtYear" class="custom-select form-control" style="width:340px;"></select></label></div>
<div class="col-2" id="typelabel"><label class="float-right">Placement Type <span class="required">*</span></label></div>
<div class="col-4" id="typediv"><label><select name="ptype" onchange="return divs()" id="type" class="custom-select form-control" style="width:340px;"><option value="">-SELECT-</option><option value="Job">Job(CAMPUS PLACEMENT)</option><option value="OJ">Other than Job Mela(DIRECT PLACEMENT)</option><option value="Apprenticeship">Apprenticeship</option><option value="OA">Other than Apprenticeship Mela(DIRECT APPRENTICESHIP)</option><option value="HigherEducation">Higher Education</option><option value="SelfEmployment">Self Employment</option></select></label></div>
<div class="col-2" id="scheduleIdlable"><label class="float-right">Schedule <span class="required">*</span></label></div>
<div class="col-4" id="scheduleIddiv"><label><select name="scheduleId" id="scheduleId" class="custom-select form-control"></select></label></div>
<div class="col-6"></div>
<div class="col-2" id="nameofcompanydivlabel"><label class="float-right">Company Name <span class="required">*</span></label></div>
<div class="col-4" id="nameofcompanydiv"><label><input type="text" name="pname_of_company" id="pname_of_company" class="form-control" onchange="return name_of_company()"/></label></div>
<div class="col-2" id="postdivlabel"><label class="float-right">Post Name <span class="required">*</span></label></div>
<div class="col-4" id="postdiv"><label><input type="text" name="ppostname" id="ppostname" class="form-control"/></label></div>
<div class="col-2" id="psalarylabel"><label class="float-right">Salary <span class="required">*</span></label></div>
<div class="col-4" id="psalarydiv"><label><input type="text" name="psalary" id="psalary" class="form-control" maxlength="10"/></label></div>
<div class="col-2" id="ptradelabel"><label class="float-right">Apprenticeship Trade <span class="required">*</span></label></div>
<div class="col-4" id="ptradediv"><label><select name="ptrade" id="ptrade" class="custom-select form-control" style="width:340px;"></select></label></div>
<div class="col-2" id="pstipendamtlabel"><label class="float-right">Stipend Amount <span class="required">*</span></label></div>
<div class="col-4" id="pstipendamtdiv"><label><input type="text" name="pstipendamt" id="pstipendamt" class="form-control"/></label></div>
<div class="col-2" id="phrnolabel"><label class="float-right">HR Contact Number <span class="required">*</span></label></div>
<div class="col-4" id="phrnodiv"><label><input type="text" name="phrno" id="phrno" class="form-control" maxlength="10"/></label></div>
<div class="col-2" id="paaprstartdatelabel"><label class="float-right">Apprenticeship Start Date <span class="required">*</span></label></div>
<div class="col-4" id="paaprstartdatediv"><label><input type="date" name="paaprstartdate" id="paaprstartdate" class="form-control" style="width:360px;"/></label></div>
<div class="col-2" id="paaprenddatelabel"><label class="float-right">Apprenticeship End Date <span class="required">*</span></label></div>
<div class="col-4" id="paaprenddatediv"><label><input type="date" name="paaprenddate" id="paaprenddate" class="form-control" style="width:340px;"/></label></div>
<div class="col-2" id="pcoursenamelabel"><label class="float-right">Course Name <span class="required">*</span></label></div>
<div class="col-4" id="pcoursenamediv"><label><input type="text" name="pcoursename" id="pcoursename" class="form-control"/></label></div>
<div class="col-2" id="pclgnamelabel"><label class="float-right">College Name <span class="required">*</span></label></div>
<div class="col-4" id="pclgnamediv"><label><input type="text" name="pclgname" id="pclgname" class="form-control"/></label></div>
<div class="col-2" id="pselfemplabel"><label class="float-right">Self Employment Name <span class="required">*</span></label></div>
<div class="col-4" id="pselfempdiv"><label><input type="text" name="pselfemp" id="pselfemp" class="form-control"/></label></div>
<div class="col-2" id="pmonthincomelabel"><label class="float-right">Monthly Income <span class="required">*</span></label></div>
<div class="col-4" id="pmonthincomediv"><label><input type="text" name="pmonthincome" id="pmonthincome" class="form-control"/></label></div>
<div class="col-2"><label class="float-right" id="pstatelabel">State <span class="required">*</span></label></div>
<div class="col-4" id="pstatediv"><label><select name="pstate" id="pstate" onchange="return getDistrictsDropdown()" class="custom-select form-control" style="width:340px;"><option value="">-select-</option></select></label></div>
<div class="col-2" id="pdistrictlabel"><label class="float-right">District <span class="required">*</span></label></div>
<div class="col-4" id="pdistrictdiv"><label><select name="pdistrict" id="pdistrict" class="custom-select form-control" style="width:340px;"><option value="">-select-</option></select></label></div>
<div class="col-2" id="paddresslabel"><label class="float-right">Address <span class="required">*</span></label></div>
<div class="col-4" id="paddressdiv"><label><textarea name="paddress" id="paddress" rows="4" cols="50" class="form-control"></textarea></label></div>
</div>
<div class="row"><div class="col-4"></div><div class="col-4"><input type="button" class="btn btn-success w-100" value="Submit" id="submit" onclick="return senddata();"/></div><div class="col-4"></div></div>
<div class="row"><div class="col-8">Note:<span class="required">* means mandatory field</span></div><div class="col-4"></div></div>
</div>

<!-- Find By Name Modal -->
<div id="myModal1" class="modal1">
<div class="modal-content1">
<span class="close1" style="color:red;font-weight:bold;">&#9746;</span>
<div align="center">
<h5 class="h5" style="margin:0 auto;color:blueviolet;">Find Admission Number By Using Candidate Name</h5>
<div class="container-fluid" style="background-color:#e4eeb9 !important;font-weight:bolder;margin:0 auto;width:80%;" id="formdiv">
<div class="row"><div class="col-4"><label class="float-right">Candidate Name</label></div><div class="col-4"><input type="text" name="message" id="findName" class="form-control w-100"/></div><div class="col-4"></div></div>
<div class="row"><div class="col-4"></div><div class="col-4"><button type="button" class="btn btn-info float-left mt-1" onclick="return findByName();" id="admnumtablesubmitbtn">Search</button></div></div>
</div>
<br>
<div id="scrollbar">
<table id="admnumtable" border="1" style="height:100%;" class="table table-bordered table-info">
<thead class="table-dark"><th class="text-white pl-4">Name</th><th class="text-white pl-4">Father Name</th><th class="text-white pl-4">Admission Number</th></thead>
<tbody id="admnumtablebody"></tbody>
</table>
</div>
</div>
</div>
</div>

<!-- Alert Message Modal -->
<div id="myModalalert" class="modalalert"><div class="modal-contentalert"><div align="center"><button type="button" class="btn btn-success alert-close">&#x2716;</button><span id="saveplcmtsuccessmsg"></span></div></div></div>

<!-- Error Alert Modal -->
<div id="myModalErroralert" class="modalErroralert"><div class="modal-contenterroralert"><div align="center"><button type="button" class="btn btn-success alertError-close">&#x2716;</button><span id="alertError"></span><br><i class="fas fa-exclamation-triangle" style="font-size:60px;color:red;"></i></div></div></div>

<!-- Success Modal -->
<div id="myModalSuccess" class="mymodalsuccess"><div class="successcontent"><button type="button" class="btn btn-warning successclose" style="margin-left:90%;">&#x2716;</button><br><br><div align="center"><i class="fas fa-check-circle" style="font-size:60px;color:green;"></i><br><h3 style="color:green;font-weight:bolder;font-size:x-large"><span id="successmsg"></span></h3></div></div></div>

<!-- Saving Placement Confirmation Modal -->
<div id="savingPlcmtModel" class="savingplcmtmodel"><div class="savingplcmtcontent"><div align="center"><i class="fas fa-save" style="font-size:60px;color:blue;"></i><h3 style="color:red;font-weight:bolder;font-size:x-large"><span id="savemsg"></span></h3><br><button type="button" class="btn btn-success" onclick="return savePlacement();">SAVE</button><button type="button" class="btn btn-warning savesuccessclose">CANCEL</button></div></div></div>

<!-- Admission Not Found Modal -->
<div id="admnotfound" class="admNotFound"><div class="admnotfound-content"><button type="button" class="btn btn-warning notfoundclose" style="margin-left:90%;">&#x2716;</button><br><div align="center"><h3 style="color:red;font-weight:bolder;font-size:x-large"><span>Given Admission Number is not Found</span></h3><br><i class="fas fa-search" style="font-size:60px;color:gray;"></i></div></div></div>

<script>
$(document).ready(function(){
    document.getElementById("userinfo").innerHTML = "<i class='fas fa-user'></i> " + username + " | <i class='fas fa-id-badge'></i> " + insCode + " | <i class='fas fa-building'></i> " + insName;
    generateCaptchaa();
    loadPlacementYears();
    loadTrades();
    loadStates();
});

function generateCaptchaa(){
    var captcha = "";
    var chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for(var i=0;i<4;i++){
        captcha += chars.charAt(Math.floor(Math.random()*chars.length));
    }
    document.getElementById("mainCaptcha").value = captcha;
    document.getElementById("txtInput").value = "";
}

function findAdmnum(){
    var admNum = document.getElementById("adm_num").value.trim();
    if(admNum.length < 10 || admNum.length > 11){
        alert("Enter a valid Admission Number (10-11 characters)");
        return false;
    }
    var input = document.getElementById("txtInput").value;
    var captcha = document.getElementById("mainCaptcha").value;
    if(input !== captcha){
        document.getElementById("error").innerHTML = "Captcha mismatch!";
        generateCaptchaa();
        return false;
    }
    document.getElementById("error").innerHTML = "";
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/candidate?admNum=' + encodeURIComponent(admNum) + '&itiCode=' + encodeURIComponent(insCode),
        cache:false, timeout:600000,
        success: function(response){
            if(response && response.name){
                $("#name").text(response.name);
                $("#iti_namespan").text(response.itiName);
                $("#iti_name").val(response.itiName);
                $("#iti_code").val(response.itiCode);
                $("#dist_namespan").text(response.distName);
                $("#dist_name").val(response.distName);
                $("#dist_code").val(response.distCode);
                $("#year_of_admission").text(response.yearOfAdmission);
                $("#trade_codespan").text(response.tradeName);
                $("#trade_code").val(response.tradeCode);
                $("#trade_name").val(response.tradeName);
                $("#admissiondetails").show();
                loadCandidatePlacements(admNum);
            } else {
                $("#admnotfound").show();
            }
        }, error: function(){ $("#admnotfound").show(); }
    });
    return false;
}

function findByNames(){ $("#myModal1").show(); $("#findName").val(""); $("#admnumtablebody").empty(); }
function findByName(){
    var name = $("#findName").val().trim();
    if(!name){ alert("Enter candidate name"); return false; }
    $("#admnumtablebody").empty();
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/candidate/byName?name=' + encodeURIComponent(name) + '&itiCode=' + encodeURIComponent(insCode),
        cache:false, timeout:600000,
        success: function(response){
            if(response && response.length > 0){
                response.forEach(function(c){
                    var link = $('<a>').text(c.admNum).attr('href','#').css({'text-decoration':'underline','color':'blue','cursor':'pointer'});
                    link.on('click', function(e){ e.preventDefault(); $('#adm_num').val(c.admNum); $('#myModal1').hide(); findAdmnum(); });
                    var row = $('<tr>').append($('<td>').text(c.name)).append($('<td>').text(c.fatherName)).append($('<td>').append(link));
                    $("#admnumtablebody").append(row);
                });
            } else {
                $("#admnumtablebody").append("<tr><td colspan='3' style='color:red;'>No records found</td></tr>");
            }
        }
    });
    return false;
}

function loadCandidatePlacements(admNum){
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/candidate/placements?admNum=' + encodeURIComponent(admNum) + '&itiCode=' + encodeURIComponent(insCode),
        cache:false, timeout:600000,
        success: function(response){
            if(response && response.length > 0){
                $("#plcmt_detailstabheading").show();
                $("#plcmt_detailstab").show();
                $("#plcmt_detailsbody").empty();
                response.forEach(function(p){
                    $("#plcmt_detailsbody").append("<tr><td>"+p.passYear+"</td><td>"+p.ptype+"</td><td>"+p.pnameOfCompany+"</td><td>"+p.ppostname+"</td><td>"+p.psalary+"</td><td>"+p.ptrade+"</td><td>"+p.pstipendamt+"</td><td>"+p.paaprstartdate+"</td><td>"+p.paaprenddate+"</td><td>"+p.phrno+"</td><td>"+p.pcoursename+"</td><td>"+p.pclgname+"</td><td>"+p.pselfemp+"</td><td>"+p.pmonthincome+"</td><td>"+p.paddress+"</td></tr>");
                });
            } else {
                $("#plcmt_detailstabheading").hide();
                $("#plcmt_detailstab").hide();
            }
            loadSchedules();
            $("#placementdiv").show();
        }, error: function(){ loadSchedules(); $("#placementdiv").show(); }
    });
}

function loadSchedules(){
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/schedule/list?distCode=' + encodeURIComponent($("#dist_code").val() || ''),
        cache:false, timeout:600000,
        success: function(response){
            $("#scheduleId").empty();
            $("#scheduleId").append('<option value="">-SELECT-</option>');
            if(response && response.length > 0){
                response.forEach(function(s){
                    if(s.location && s.location.startsWith(insCode)){
                        $("#scheduleId").append('<option value="'+s.id+'">'+s.date+' - '+s.type+' - '+s.location+'</option>');
                    }
                });
            }
        }
    });
}

function loadPlacementYears(){
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/iti/years?itiCode=' + encodeURIComponent(insCode),
        cache:false, timeout:600000,
        success: function(response){
            $("#plcmtYear").empty();
            $("#plcmtYear").append('<option value="">-SELECT-</option>');
            response.forEach(function(y){ $("#plcmtYear").append('<option value="'+y+'">'+y+'</option>'); });
        }
    });
}

function loadTrades(){
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/master/trades',
        cache:false, timeout:600000,
        success: function(response){
            $("#ptrade").empty();
            $("#ptrade").append('<option value="">-SELECT-</option>');
            response.forEach(function(t){ $("#ptrade").append('<option value="'+t.code+'">'+t.name+'</option>'); });
        }
    });
}

function loadStates(){
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/master/states',
        cache:false, timeout:600000,
        success: function(response){
            $("#pstate").empty();
            $("#pstate").append('<option value="">-select-</option>');
            response.forEach(function(s){ $("#pstate").append('<option value="'+s.code+'">'+s.name+'</option>'); });
        }
    });
}

function getDistrictsDropdown(){
    var stateCode = $("#pstate").val();
    if(!stateCode){ $("#pdistrict").empty().append('<option value="">-select-</option>'); return false; }
    $.ajax({
        type:'get', url: baseUrl + 'api/placements/master/districts?stateCode=' + encodeURIComponent(stateCode),
        cache:false, timeout:600000,
        success: function(response){
            $("#pdistrict").empty();
            $("#pdistrict").append('<option value="">-select-</option>');
            response.forEach(function(d){ $("#pdistrict").append('<option value="'+d.code+'">'+d.name+'</option>'); });
        }
    });
    return false;
}

function divs(){ return false; }
function name_of_company(){ return false; }

function senddata(){
    var admNum = $("#adm_num").val().trim();
    var name = $("#name").text();
    var itiCode = $("#iti_code").val();
    var itiName = $("#iti_name").val();
    var distCode = $("#dist_code").val();
    var distName = $("#dist_name").val();
    var passmonth = $("#passmonth").val();
    var passyear = $("#passyear").val();
    var plcmtYear = $("#plcmtYear").val();
    var ptype = $("#type").val();
    var scheduleId = $("#scheduleId").val();
    if(!admNum || !passmonth || !passyear || !plcmtYear || !ptype || !scheduleId){
        $("#alertError").html("Please fill all mandatory fields."); $("#myModalErroralert").show(); return false;
    }
    $("#savemsg").text("Are you sure you want to save the placement for " + name + "?");
    $("#savingPlcmtModel").show();
    return false;
}

function savePlacement(){
    var data = {
        admNum: $("#adm_num").val().trim(),
        name: $("#name").text(),
        itiCode: $("#iti_code").val(),
        itiName: $("#iti_name").val(),
        distCode: $("#dist_code").val(),
        distName: $("#dist_name").val(),
        passmonth: $("#passmonth").val(),
        passyear: $("#passyear").val(),
        plcmtYear: $("#plcmtYear").val(),
        ptype: $("#type").val(),
        scheduleId: $("#scheduleId").val(),
        pnameOfCompany: $("#pname_of_company").val(),
        ppostname: $("#ppostname").val(),
        psalary: $("#psalary").val(),
        ptrade: $("#ptrade").val(),
        pstipendamt: $("#pstipendamt").val(),
        phrno: $("#phrno").val(),
        paaprstartdate: $("#paaprstartdate").val(),
        paaprenddate: $("#paaprenddate").val(),
        pcoursename: $("#pcoursename").val(),
        pclgname: $("#pclgname").val(),
        pselfemp: $("#pselfemp").val(),
        pmonthincome: $("#pmonthincome").val(),
        pstate: $("#pstate").val(),
        pdistrict: $("#pdistrict").val(),
        paddress: $("#paddress").val(),
        entryBy: username
    };
    $.ajax({
        type:'post', url: baseUrl + 'api/placements/create',
        contentType:'application/json', data: JSON.stringify(data), timeout:600000,
        success: function(response){
            $("#savingPlcmtModel").hide();
            $("#successmsg").text(response.message || "Placement saved successfully!");
            $("#myModalSuccess").show();
        }, error: function(xhr){
            $("#savingPlcmtModel").hide();
            $("#alertError").html(xhr.responseText || "Error saving placement.");
            $("#myModalErroralert").show();
        }
    });
    return false;
}

// Modal close handlers
$(document).on("click", ".close1", function(){ $("#myModal1").hide(); });
$(document).on("click", ".alert-close", function(){ $("#myModalalert").hide(); });
$(document).on("click", ".alertError-close", function(){ $("#myModalErroralert").hide(); });
$(document).on("click", ".successclose", function(){ $("#myModalSuccess").hide(); });
$(document).on("click", ".savesuccessclose", function(){ $("#savingPlcmtModel").hide(); });
$(document).on("click", ".notfoundclose", function(){ $("#admnotfound").hide(); });
</script>
</body>
</html>
