<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="./css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="./js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="./css/all.min.css">
<link rel="stylesheet" href="./css/style.css">

<title>Admission Initialization</title>
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/customJs/admissionIntializationJs.js"></script>

</head>
<body onload="return checkToken();">

	<div id="404Msg" align="center">
		<img src="./images/gen.jpg" class="img-fluid" />
		<%@include file="/WEB-INF/openNavbar.jsp"%>
	</div>


	<div align="center" id="contentDiv">
<%-- 		<%@include file="/WEB-INF/userpages/Navbar.jsp"%> --%>
		<%@include file="/WEB-INF/bannernew.jsp"%>
	<%@include file="/WEB-INF/checkmeritschedule/authNavbar.jsp"%>
		<div
			class="container mt-2 mb-4 border font-weight-bolder shadow-lg "
			style="background-color: #e6ffff; border-radius: 20px;">

			<div class="row align-items-center m-2">
				<div class="col-12">
					<h6 class="h6 font-weight-bolder text-primary text-decoration-underline">ADMISSION PROCESS
						INITIALIZATION</h6>
				</div>
			</div>

			<div class="row align-items-center m-2">
				<div class="col-2">
					<label for="admYear" class="col-form-label float-right fw-bold">Admission
						Year </label>
				</div>
				<div class="col-4">
					<input type="text" name="admYear" id="admYear" class="form-control"
						readonly="readonly" disabled="disabled" />
				</div>
				<div class="col-2">
					<label for="currentPhase" class="col-form-label float-right fw-bold">Phase
					</label>
				</div>
				<div class="col-4">
					<select name="currentPhase" id="currentPhase" class="form-select" onchange="return checkValue('currentPhaseError'), changingPhase(this.value)">
						<option value="">-select-</option>
					</select>
					<span id="currentPhaseError"></span>
				</div>
			</div>

			<div class="row align-items-center m-2">
				
				
			</div>

			<div class="row align-items-center m-2">
				<div class="col-2">
					<label for="applicationFromDate" class="col-form-label float-right fw-bold">Applications
						From Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-4">
					<input type="datetime-local" step="1" name="applicationFromDate"
						id="applicationFromDate" class="form-control" onchange="return checkValue('applicationFromDateError')" />
						<span id="applicationFromDateError"></span>
				</div>
				<div class="col-2">
					<label for="applicationToDate" class="col-form-label float-right fw-bold">Applications
						To Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-4">
					<input type="datetime-local" step="1" name="applicationToDate" id="applicationToDate"
						class="form-control" onchange="return checkValue('applicationToDateError')" />
						<span id="applicationToDateError"></span>
				</div>
			</div>
			
			<div class="row align-items-center m-2">
				<div class="col-2">
					<label for="verificationFromDate" class="col-form-label float-right fw-bold">Verification
						From Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-4">
					<input type="datetime-local" step="1" name="verificationFromDate"
						id="verificationFromDate" class="form-control" onchange="return checkValue('verificationFromDateError')"/>
						<span id="verificationFromDateError"></span>
				</div>
				<div class="col-2">
					<label for="verificationToDate" class="col-form-label float-right fw-bold">Verification
						To Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-4">
					<input type="datetime-local" step="1" name="verificationToDate" id="verificationToDate"
						class="form-control" onchange="return checkValue('verificationToDateError')" />
						<span id="verificationToDateError"></span>
				</div>
			</div>
			
			<div class="row align-items-center m-2">
				<div class="col-2">
					<label for="meritListFromDate" class="col-form-label float-right fw-bold">Merit List
						From Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-4">
					<input type="datetime-local" step="1" name="meritListFromDate"
						id="meritListFromDate" class="form-control" onchange="return checkValue('meritListFromDateError')" />
						<span id="meritListFromDateError"></span>
				</div>
				<div class="col-2">
					<label for="meritListToDate" class="col-form-label float-right fw-bold">Merit List
						To Date &nbsp;&nbsp;&nbsp;(mm-dd-yyyy) </label>
				</div>
				<div class="col-4">
					<input type="datetime-local" step="1" name="meritListToDate" id="meritListToDate"
						class="form-control" onchange="return checkValue('meritListToDateError')" />
						<span id="meritListToDateError"></span>
				</div>
			</div>
			
			<div class="row align-items-center m-2" id="itiTypeGDiv">
				<div class="col-2">
					<label for="itiTypeG" class="col-form-label float-right fw-bold"> Government ITIs </label>
					<input type="hidden" name="itiTypeG" id="itiTypeG" value="G" />
				</div>
<!-- 				<div class="col-2"> -->
<!-- 					<select name="itiTypeG" id="itiTypeG" class="form-select" disabled="disabled"> -->
<!-- 						<option value="G">Government</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
				<div class="col-2">
					<label for="admissionsGovtFromDate" class="col-form-label float-right fw-bold">Admissions
						From Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-3">
					<input type="datetime-local" step="1" name="admissionsGovtFromDate"
						id="admissionsGovtFromDate" class="form-control" onchange="return checkValue('admissionsGovtFromDateError')" /><span id="admissionsGovtFromDateError"></span>
				</div>
				<div class="col-2">
					<label for="admissionsGovtToDate" class="col-form-label float-right fw-bold">Admissions
						To Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-3">
					<input type="datetime-local" step="1" name="admissionsGovtToDate" id="admissionsGovtToDate"
						class="form-control" onchange="return checkValue('admissionsGovtToDateError')" /><span id="admissionsGovtToDateError"></span>
				</div>
			</div>
			
			<div class="row align-items-center m-2" id="itiTypePDiv">
				<div class="col-2">
					<label for="itiTypeP"  class="col-form-label float-right fw-bold">Private ITIs </label>
					<input type="hidden" name="itiTypeP" id="itiTypeP" value="P" />
				</div>
<!-- 				<div class="col-2"> -->
					
<!-- 					<select name="itiTypeP" id="itiTypeP" class="form-select" disabled="disabled"> -->
<!-- 						<option value="P">Private</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
				<div class="col-2">
					<label for="admissionsPvtFromDate" class="col-form-label float-right fw-bold">Admissions
						From Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-3">
					<input type="datetime-local" step="1" name="admissionsPvtFromDate"
						id="admissionsPvtFromDate" class="form-control" onchange="return checkValue('admissionsPvtFromDateError')" /><span id="admissionsPvtFromDateError"></span>
				</div>
				<div class="col-2">
					<label for="admissionsPvtToDate" class="col-form-label float-right fw-bold">Admissions
						To Date (mm-dd-yyyy) </label>
				</div>
				<div class="col-3">
					<input type="datetime-local" step="1" name="admissionsPvtToDate" id="admissionsPvtToDate"
						class="form-control" onchange="return checkValue('admissionsPvtToDateError')" /><span id="admissionsPvtToDateError"></span>
				</div>
			</div>
			
			<div class="col-12 m-4" id="submitButton"> <button type="submit" class="btn btn-success fw-bolder form-control w-25" onclick="return sendData()">Submit</button> </div>
			<div class="col-12 m-4" id="updateButton"> <button type="submit" class="btn btn-warning fw-bolder form-control w-25" onclick="return updateData()">Update</button> </div>
			<input type="hidden" name="pid" id="pid"/>			
			<div class="col-12 m-4"> <span  class="fw-bolder text-danger" id="mainError"></span> </div>
			<div class="col-12 m-4"> <span  class="fw-bolder text-success" id="mainSuccessError"></span> </div>
			
		</div>
		<div class="container mt-2 mb-4 border font-weight-bolder shadow-lg "
			style="background-color: #e6ffff; border-radius: 20px;">
			<div class="row align-items-center m-2">
				<div class="col-12">
					<h6 class="h6 font-weight-bolder text-primary text-decoration-underline">CURRENT ADMISSION PHASE DETAILS</h6>
					
					<table class="table table-bordered">
						<thead>
							<tr>
								<td style="background-color: black;color:white;font-weight: bolder;">YEAR</td>
								<td style="background-color: black;color:white;font-weight: bolder;">PHASE</td>
								<td colspan="2" style="text-align: center;background-color: black;color:white;font-weight: bolder;">APPLICATIONS</td>
								<td colspan="2" style="text-align: center;background-color: black;color:white;font-weight: bolder;">VERIFICATION</td>
								<td colspan="2" style="text-align: center;background-color: black;color:white;font-weight: bolder;">MERIT LIST</td>
								<td colspan="2" style="text-align: center;background-color: black;color:white;font-weight: bolder;">GOVT ADMISSIONS</td>
								<td colspan="2" style="text-align: center;background-color: black;color:white;font-weight: bolder;">PRIVATE ADMISSION</td>
							</tr>
							<tr>
								<td colspan="2" style="background-color: black;color:white;font-weight: bolder;"></td>
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">FROM DATE</td>
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">TO DATE</td>
								
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">FROM DATE</td>
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">TO DATE</td>
								
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">FROM DATE</td>
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">TO DATE</td>
								
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">FROM DATE</td>
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">TO DATE</td>
								
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">FROM DATE</td>
								<td style="text-align: center;background-color: black;color:white;font-weight: bolder;">TO DATE</td>
							</tr>
						</thead>
						<tbody id="admissionData">
						
						</tbody>
					</table>
				</div>
			</div>
			</div>
	</div>
	<%@include file="/WEB-INF/footer.jsp"%>
</body>
</html>