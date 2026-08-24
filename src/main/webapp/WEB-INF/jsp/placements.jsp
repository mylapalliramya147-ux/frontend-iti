<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Placements / In-Plant Training</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.8/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.8/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/md5/2.18.0/md5.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script>
	let baseUrl = "http://localhost:5050/api/placements/";

	$(document).ready(function() {
		generateCaptcha();
		overviewdetails();
	});
	
	function validate() {
		$("#tokenError").empty();

		var username = $("#username").val();
		var password = $("#password").val();

		if (username == "" || username == null) {
			$(".usernameSpan").html("Username is required.");
			$("#username").focus();
			return false;
		}
		if (password == "" || password == null) {
			$(".passwordSpan").html("Password is required.");
			$("#password").focus();
			return false;
		}

		var md5_1 = hex_md5(password);
		var md5_2 = hex_md5(md5_1);

		$("#password").val(md5_2);
		return true;
	}

	function generateCaptcha() {
		var alpha = new Array('1', '2', '3', '4', '5', '6', '7', '8', '9', '0');
		var i;
		for (i = 0; i < 4; i++) {
			var a = alpha[Math.floor(Math.random() * alpha.length)];
			var b = alpha[Math.floor(Math.random() * alpha.length)];
			var c = alpha[Math.floor(Math.random() * alpha.length)];
			var d = alpha[Math.floor(Math.random() * alpha.length)];
		}
		var code = a + '' + b + '' + '' + c + '' + d;
		document.getElementById("mainCaptcha").value = code;
	}

	function overviewdetails() {
		$.ajax({
			type : 'get',
			url : baseUrl + 'masterdata/overviewdetails',
			cache : false,
			timeout : 600000,
			success : function(response) {
				$("#allPlacement").append(response.allPlacement.toLocaleString("en-US"));
				$("#allImplants").append(response.allImplants.toLocaleString("en-US"));
				$("#allLabs").append(response.allLabs.toLocaleString("en-US"));
				countPlacementsGroupedByPtype();
			}
		});
	}

	function countPlacementsGroupedByPtype() {
		$.ajax({
			type : 'get',
			url : baseUrl + 'masterdata/countPlacementsGroupedByPtype',
			cache : false,
			timeout : 600000,
			success : function(response) {
				$("#jobTotalRecords").append(response.Job.toLocaleString("en-US"));
				$("#otherThanjobTotalRecords").append(response.OA.toLocaleString("en-US"));
				$("#apprenticeshipTotalRecords").append(response.Apprenticeship.toLocaleString("en-US"));
				$("#oATotalRecords").append(response.OA.toLocaleString("en-US"));
				$("#higherEducationTotalRecords").append(response.HigherEducation.toLocaleString("en-US"));
				$("#selfEmploymentTotalRecords").append(response.SelfEmployment.toLocaleString("en-US"));
				getdDistinctItiCodesByPtype();
			}
		});
	}

	function getdDistinctItiCodesByPtype() {
		$.ajax({
			type : 'get',
			url : baseUrl + 'masterdata/getdDistinctItiCodesByPtype',
			cache : false,
			timeout : 600000,
			success : function(response) {
				$("#jobItisCount").append(response.jobItisCount.toLocaleString("en-US"));
				$("#ojItisCount").append(response.ojItisCount.toLocaleString("en-US"));
				$("#apprenticeshipItisCount").append(response.apprenticeshipItisCount.toLocaleString("en-US"));
				$("#oaItisCount").append(response.oaItisCount.toLocaleString("en-US"));
				$("#higherEducationItisCount").append(response.higherEducationItisCount.toLocaleString("en-US"));
				$("#selfEmploymentItisCount").append(response.selfEmploymentItisCount.toLocaleString("en-US"));
				inplantDashboardDetails();
			}
		});
	}

	function inplantDashboardDetails() {
		$.ajax({
			type : 'get',
			url : baseUrl + 'masterdata/inplantDashboardDetails',
			cache : false,
			timeout : 600000,
			success : function(response) {
				$("#inplantTotal").append(response.inplantTotal.toLocaleString("en-US"));
				$("#inplantDistinctItis").append(response.inplantDistinctItis.toLocaleString("en-US"));
				$("#inplantDistinctSlnos").append(response.inplantDistinctSlnos.toLocaleString("en-US"));

				$("#industriesTotal").append(response.industriesTotal.toLocaleString("en-US"));
				$("#industriesDistinctItis").append(response.industriesDistinctItis.toLocaleString("en-US"));
				$("#industriesDistinctIndustries").append(response.industriesDistinctIndustries.toLocaleString("en-US"));
				$("#industriesDistinctTrades").append(response.industriesDistinctTrades.toLocaleString("en-US"));

				$("#industryMasterTotal").append(response.industryMasterTotal.toLocaleString("en-US"));
				$("#industryMasterMajor").append(response.industryMasterMajor.toLocaleString("en-US"));
				$("#industryMasterMinor").append(response.industryMasterMinor.toLocaleString("en-US"));
				$("#sumOfStudent").append(response.sumOfStudent.toLocaleString("en-US"));

				labsDashboardDetails();
			}
		});
	}

	function labsDashboardDetails() {
		$.ajax({
			type : 'get',
			url : baseUrl + 'masterdata/labsDashboardDetails',
			cache : false,
			timeout : 600000,
			success : function(response) {
				$("#labsTotal").append(response.labsTotal.toLocaleString("en-US"));
				$("#labsDistinctItis").append(response.labsDistinctItis.toLocaleString("en-US"));
				$("#labsDistinctTrades").append(response.labsDistinctTrades.toLocaleString("en-US"));

				$("#labItemsTotal").append(response.labItemsTotal.toLocaleString("en-US"));
				$("#labItemsDistinctItems").append(response.labItemsDistinctItems.toLocaleString("en-US"));

				$("#spinnerdiv").hide();
			}
		});
	}
</script>
</head>
<body>

<img alt="banner" src="${pageContext.request.contextPath}/images/gen.jpg" style="border: 1px solid black;width: 100%;border-radius: 2px;">
 
<div class="text-center" id="spinnerdiv" align="center">
     <span>Dashboard data is Loading...</span>
     <div class="spinner-border" role="status"></div>
</div>
			
<div class="container-fluid p-2" id="dashBoard">

		<div class="row">
			<div align="center">
				<h3 class="h3" style="color: blueviolet; font-size: 12px;text-decoration: underline;">OVER VIEW</h3>
			</div>
		</div>
		
		<div class="container">
		<div class="row border shadow-lg m-1">
			<div class="col-md-3 d-flex" style="color: blueviolet; font-size: 12px;text-decoration: underline;">Total No.of Records</div>
			<div class="col-md-3 d-flex">Placements : &nbsp;&nbsp;<span id="allPlacement"></span></div>
			<div class="col-md-3 d-flex">In-Plant Training : &nbsp;&nbsp;<span id="allImplants"></span></div>
			<div class="col-md-3 d-flex">Labs : &nbsp;&nbsp;<span id="allLabs"></span></div>
		</div>
		</div>

		<div class="row">
			 
			<div class="col-md-3 d-flex">
				<div class="card h-100 w-100" >
					<div class="card-body"  > 
						<div align="center">
							<h3 class="h3" style="color: blueviolet; font-size: 12px;text-decoration: underline;">PLACEMENT MODULE INFORMATION</h3>
						</div>
						
						<table>
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">JOB</td></tr>
							<tr>
								<td style="font-size: 12px;">Total Records</td><td>: <span id="jobTotalRecords" ></span></td>
								<td style="font-size: 12px;padding-left: 10px;">No.of ITIs</td><td>: <span id="jobItisCount" ></span></td>
							</tr>
							
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">OTHER THAN JOB</td></tr>
							<tr>
								<td style="font-size: 12px;">Total Records</td><td>: <span id="otherThanjobTotalRecords" ></span></td>
								<td style="font-size: 12px;padding-left: 10px;">No.of ITIs</td><td>: <span id="ojItisCount" ></span></td>
							</tr>
							
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">APPRENTICESHIP</td></tr>
							<tr>
								<td style="font-size: 12px;">Total Records</td><td>: <span id="apprenticeshipTotalRecords" ></span></td> 
							 	<td style="font-size: 12px;padding-left: 10px;">No.of ITIs</td><td>: <span id="apprenticeshipItisCount" ></span></td>
							 </tr>
							
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">OTHER THAN APPRENTICESHIP</td></tr>
							<tr>
								<td style="font-size: 12px;">Total Records</td><td>: <span id="oATotalRecords" ></span></td> 
							 	<td style="font-size: 12px;padding-left: 10px;">No.of ITIs</td><td>: <span id="oaItisCount"  ></span></td>
							 </tr>
							
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">HIGHER EDUCATION</td></tr>
							<tr>
								<td style="font-size: 12px;">Total Records</td><td>: <span id="higherEducationTotalRecords"  ></span></td>
								<td style="font-size: 12px;padding-left: 10px;">No.of ITIs</td><td>: <span id="higherEducationItisCount"  ></span></td>
							</tr>
							
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">SELF EMPLOYMENT</td></tr>
							<tr>
								<td style="font-size: 12px;">Total Records</td><td>: <span id="selfEmploymentTotalRecords"  ></span></td> 
							 	<td style="font-size: 12px;padding-left: 10px;">No.of ITIs</td><td>: <span id="selfEmploymentItisCount"  ></span></td>
							 </tr>
							
						</table>
						
					</div>
				</div>
			</div>
			<div class="col-md-3 d-flex">
				<div class="card h-100  w-100" >
					<div class="card-body"  > 
						<div align="center">
							<h3 class="h3" style="color: blueviolet; font-size: 12px;text-decoration: underline;">IN-PLANT TRAINING MODULE INFORMATION</h3>
						</div>
						<table  >
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">In-Plant</td></tr>
							<tr><td style="font-size: 12px;">Total Records</td><td>: <span id="inplantTotal"></span></td></tr>
							<tr><td style="font-size: 12px;">No.of ITIs</td><td>: <span id="inplantDistinctItis"></span></td></tr>
							<tr><td style="font-size: 12px;">No.of Industries</td><td>: <span id="inplantDistinctSlnos"></span></td></tr>
							<tr><td style="font-size: 12px;">Total No Of Students</td><td>: <span id="sumOfStudent"></span></td></tr>
							
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">ITI-Industries Mappings</td></tr>
							<tr><td style="font-size: 12px;">Total Mappings</td><td>: <span id="industriesTotal"></span></td></tr>
							<tr><td style="font-size: 12px;">No.of ITIs</td><td>: <span id="industriesDistinctItis"></span></td></tr>
							<tr><td style="font-size: 12px;">No.of Industries</td><td>: <span id="industriesDistinctIndustries"></span></td></tr>
							<tr><td style="font-size: 12px;">No.of Trades</td><td>: <span id="industriesDistinctTrades"></span></td></tr>
							
							<tr><td colspan="2" style="color: blueviolet; font-size: 12px;">Industry Master Information</td></tr>
							<tr><td style="font-size: 12px;">Total Industries</td><td>: <span id="industryMasterTotal"></span></td></tr>
							<tr><td style="font-size: 12px;">Major Type Industries</td><td>: <span id="industryMasterMajor"></span></td></tr>
							<tr><td style="font-size: 12px;">Minor Type Industries</td><td>: <span id="industryMasterMinor"></span></td></tr>
							
							
						</table>
						
					</div>
				</div>
			</div>
			<div class="col-md-3 d-flex">
				<div class="card h-100  w-100">
					<div class="card-body"  > 
					<div align="center">
							<h3 class="h3" style="color: blueviolet; font-size: 12px;text-decoration: underline;">LABS MODULE INFORMATION</h3>
						</div>
						
						<table class="table table-borderless">
							<tr><td style="font-size: 12px;">Total Records</td><td>: <span id="labsTotal"></span></td></tr>
							<tr><td style="font-size: 12px;">No.of ITIs</td><td>: <span id="labsDistinctItis"></span></td></tr>
							<tr><td style="font-size: 12px;">No.of Trades</td><td>: <span id="labsDistinctTrades"></span></td></tr>
							<tr><td style="font-size: 12px;">Total Items</td><td>: <span id="labItemsTotal"></span></td></tr>
							<tr><td style="font-size: 12px;">No.of Items</td><td>: <span id="labItemsDistinctItems"></span></td></tr>
						</table>
						
						
					</div>
				</div>
			</div>
			<div class="col-md-3 d-flex">
				<div class="card h-100  w-100">
					<div class="card-body"  > 
						<div align="center">
							<h3 class="h3" style="color: blueviolet; font-size: 12px;text-decoration: underline;">OFFICIAL's LOGIN</h3>
						</div>
						<form id="bean" action="https://itiadmissions.ap.gov.in/placementsbe/userLogin" method="post">

						<div class="row m-2">
							<div class="col-lg-12 col-md-6">
							<label class="form-label">Username&nbsp;&nbsp;</label>
							<input id="username" name="username" class="form-control" type="text" value=""/>
							
							<span class="usernameSpan"></span>
							</div>
						</div>
						<div class="row m-2">
							<div class="col-lg-12 col-md-6">
							<label class="form-label">Password&nbsp;&nbsp;</label>
							<input id="password" name="password" class="form-control" type="password" value=""/>
							
							  <span class="passwordSpan"></span>
							</div>
						</div>
 
						<div class="row m-2">
							<div class="col-lg-5 col-md-3">
								<label class="form-label">Captcha&nbsp;&nbsp;</label>
								<input type="text" id="txtInput" class="form-control" autocomplete="off" maxlength="4" />
							</div>
							<div class="col-lg-7 col-md-3 d-flex align-items-center">
								<div style="margin-top: 30px;">
									<input type="text" id="mainCaptcha" readonly="readonly" class="form-control"
										style='letter-spacing: 10px; font-weight: bolder; color: white; background-color: black;' />
								</div>
								<div style="margin-top: 30px;">
									<i class="fas fa-sync fa-2x pt-2" onclick="generateCaptcha();"></i>
								</div>
							</div>
						</div>
						<div align="center">&nbsp;&nbsp;&nbsp;
							<button type="submit" class="btn btn-success"
							onclick="return validate()">Submit </button>
							<span id="captchaError" style="color:red;"></span><br> <span id="tokenError" style="color:red;"></span><br>
						</div>
						</form>
				
						<div align="center" style="color: green;"></div>
						
					</div>
				</div>
			</div>
			
			 
		</div>
	</div>

</body>
</html>
