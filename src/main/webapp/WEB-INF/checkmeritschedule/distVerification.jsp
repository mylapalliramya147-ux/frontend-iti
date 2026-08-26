<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="./css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="./js/bootstrap.bundle.min.js"></script>
<link
	href="./css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="./js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="./css/all.min.css">
<link rel="stylesheet" href="./css/style.css">
<title>Dist Verification</title>
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/customJs/distVerificationJs.js"></script>
<script type="text/javascript" src="./js/siteScript.js"></script>
</head>
<body onload="getReady();">
	<div id="404Msg" align="center">
		<img src="./images/gen.jpg" class="img-fluid" />
	</div>
	<div id="navbar">
		<jsp:include page="/WEB-INF/bannernew.jsp" />
		<jsp:include page="/WEB-INF/checkmeritschedule/authNavbar.jsp" />
<%-- 		<%@include file="/WEB-INF/userpages/Navbar.jsp"%> --%>
	</div>
	
	<div align="center">
	</div>

	<div align="center" id="contentDiv">

		<div class="container mt-2 mb-4 border font-weight-bolder shadow-lg "
			style="background-color: #e6ffff; border-radius: 20px;">

			<div class="row align-items-center m-2">
				<div class="col-12">
					<h6
						class="h6 font-weight-bolder text-primary text-decoration-underline">VERIFICATION
						LIST</h6>
				</div>
			</div>
			
			<div>
				<span id="verificationSuccessMsg" style="font-weight: bolder;"></span>
			</div>
			
			<table class="table table-bordered">
				<thead>
					<tr>
						<td
							style="text-align: center; background-color: black; color: white; font-weight: bolder;">S.NO
							 </td>
						<td
							style="text-align: center; background-color: black; color: white; font-weight: bolder;">REG
							ID</td>
						<td
							style="text-align: center; background-color: black; color: white; font-weight: bolder;">NAME</td>
						<td
							style="text-align: center; background-color: black; color: white; font-weight: bolder;">FATHER
							NAME</td>

						<td
							style="text-align: center; background-color: black; color: white; font-weight: bolder;">VERIFIED
							BY</td>
						<td
							style="text-align: center; background-color: black; color: white; font-weight: bolder;">VERIFIED
							DATE</td>
						<td
							style="text-align: center; background-color: black; color: white; font-weight: bolder;">APPLICATION
							STATUS</td>
						<td
							style="text-align: center; background-color: black; color: white; font-weight: bolder;">Re-Verify
							 </td>
					</tr>
				</thead>
				<tbody id="verificationList">

				</tbody>
			</table>


		</div>
	</div>

	<div class="row m-1" id="admYearPhaseDiv">
		<div class="col-12 text-center text-decoration-underline">
			<h3 class="h3" style="color: blueviolet; font-size: 15px;">
				STUDENT VERIFICATION FORM FOR ADMISSIONS INTO ITI FOR SESSION <span
					id="admYearPhase"></span>
			</h3>
		</div>
	</div>
	<div class="container border p-2 mt-2 bg-light rounded-3" id="formTwo">

		<div class="row m-1">
			<div class="col-12 text-center text-info text-underline">
				<h5 class="h5">PERSONAL DETAILS</h5>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Hall Ticket Number</label> 
				<input
					type="text" class="form-control" name="ssc_regno" id="ssc_regno"
					readonly="readonly" disabled="disabled" /> <span
					id="ssc_regnoError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Board </label> <select
					class="form-control form-select" name="ssc_board" id="ssc_board"
					onchange="return checkValue('ssc_boardError')">
				</select> <span id="ssc_boardError"></span>

			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Year of Pass SSC</label> <input
					type="text" name="ssc_year" id="ssc_year" class="form-control"
					onchange="return checkValue('ssc_yearError')" maxlength="4" /> <span
					id="ssc_yearError"></span>
			</div>
		</div>

		<div class="row">

			<div class="col-lg-4 col-md-6">
				<label class="form-label">Month of Pass</label> <select
					class="form-select form-control" name="ssc_month" id="ssc_month"
					onchange="return checkValue('ssc_monthError')">
					<option value="">-select-</option>
					<option value="3">March</option>
					<option value="4">Supplementary</option>
				</select> <span id="ssc_monthError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Applicants Name </label> <input
					type="text" name="name" id="name" class="form-control"
					onchange="return checkValue('nameError')"
					oninput="convertToUppercase(this)" maxlength="52" /><span
					id="nameError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Mobile Number</label> <input type="text"
					name="phno" id="phno" class="form-control"
					onchange="return checkValue('phnoError')" maxlength="10" /> <span
					id="phnoError"></span>
			</div>
		</div>

		<div class="row">

			<div class="col-lg-4 col-md-6">
				<label class="form-label">Date of Birth(mm-dd-yyyy):</label> <input
					type="date" name="dob" id="dob" class="form-control"
					onchange="return checkValue('dobError')" /><span id="dobError"></span>
				<input type="hidden" id="dob" />
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Aadhar Card Number </label> <input
					type="text" name="adarno" id="adarno" class="form-control"
					onchange="return checkValue('adarnoError')" autocomplete="off"
					maxlength="12" /><span id="adarnoError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Gender</label> <select
					class="form-select form-control" name="gen" id="gen"
					onchange="return checkValue('genError')">
					<option value="">-select-</option>
					<option value="male">Male</option>
					<option value="female">Female</option>
				</select> <span id="genError"></span>
			</div>
		</div>

		<div class="row">

			<div class="col-lg-4 col-md-6">
				<label class="form-label">Category</label> <select
					class="form-select form-control" name="caste" id="caste"
					onchange="return checkValue('casteError')"
					oninput="convertToUppercase(this)">
				</select> <span id="casteError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Father Name</label> <input type="text"
					name="fname" id="fname" class="form-control"
					onchange="return checkValue('fnameError')"
					oninput="convertToUppercase(this)" maxlength="52" /><span
					id="fnameError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">mothers Name</label> <input type="text"
					name="mname" id="mname" class="form-control"
					onchange="return checkValue('mnameError')"
					oninput="convertToUppercase(this)" maxlength="52" /> <span
					id="mnameError"></span>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Physically Challenged </label> <select
					class="form-select form-control" name="phc" id="phc"
					onchange="return checkValue('phcError'), checkPwd(this.value)">
					<option value="">-select-</option>
					<option value="true">Yes</option>
					<option value="false">No</option>
				</select> <span id="phcError"></span>
			</div>

			<div class="col-lg-4 col-md-6">
				<label class="form-label">PWD Category</label> <select
					class="form-select form-control" name="pwd_category"
					id="pwd_category" onchange="return checkValue('pwd_categoryError')">
					<option value="0">None</option>
					<option value="1">Blind</option>
					<option value="2">Deaf</option>
					<option value="3">Motor Disability</option>
					<option value="4">Mental Disability</option>
				</select> <span id="pwd_categoryError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Ex-Servicemen </label> <select
					class="form-select form-control" name="exs" id="exs"
					onchange="return checkValue('exsError')">
					<option value="">-select-</option>
					<option value="true">Yes</option>
					<option value="false">No</option>
				</select> <span id="exsError"></span>
			</div>
		</div>

		<div class="row">

			<div class="col-lg-4 col-md-6">
				<label class="form-label">Qualification</label> <select
					class="form-select form-control" name="ssc" id="ssc"
					onchange="return checkValue('sscError')">
					<option value="">-select-</option>
					<option value="true">SSC Passed</option>
					<option value="false">8th Passed</option>
				</select> <span id="sscError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Local/Non Local</label> <select
					class="form-select form-control" name="loconoc" id="loconoc"
					onchange="return checkValue('loconocError')">
					<option value="">-select-</option>
					<option value="Local">Local</option>
					<option value="NonLocal">Non-Local</option>
				</select> <span id="loconocError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Pincode </label> <input type="text"
					name="pincode" id="pincode" class="form-control"
					onchange="return checkValue('pincodeError')" maxlength="6" /><span
					id="pincodeError"></span>
			</div>
		</div>

		<div class="row">

			<div class="col-lg-4 col-md-6">
				<label class="form-label">E-Mail</label> <input type="email"
					name="email" id="email" class="form-control"
					onchange="return checkValue('emailError')" maxlength="50" /><span
					id="emailError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Economic Weaker Section</label> <select
					class="form-select form-control" name="ews" id="ews"
					onchange="return checkValue('ewsError')">
					<option value="">-select-</option>
					<option value="true">Yes</option>
					<option value="false">No</option>
				</select> <span id="ewsError"></span>
			</div>
			<div class="col-lg-4 col-md-6">
				<label class="form-label">Address </label>
				<textarea rows="2" class="form-control" name="addr" id="addr"
					onchange="return checkValue('addrError')"></textarea>
				<span id="addrError"></span>
			</div>
		</div>


		<div class="row m-1">
			<div class="col-md-6">
				<h5 class="h5 text-center text-info text-underline">MARKS
					DETAILS</h5>

				<div class="row m-1">
					<div class="col-lg-6 col-md-6">
						<label class="form-label">SSC Marks Type</label> <select
							class="form-select form-control" name="ssc_type" id="ssc_type"
							onchange="return checkValue('ssc_typeError'), ssctype(this.value)">
							<option value="">-select-</option>
							<option value="sscm">MARKS</option>
							<option value="sscg">GPA</option>
						</select> <span id="ssc_typeError"></span>
					</div>
					<div class="col-lg-6 col-md-6">
						<label class="form-label">Number of Languages</label> <select
							name="noOfLangs" id="noOfLangs" class="form-select form-control"
							onchange="return checkValue('noOfLangsError'), marksdiv(this.value)">
							<option value="">-select-</option>
							<option value="3">THREE</option>
							<option value="2">TWO</option>
						</select> <span id="noOfLangsError"></span>
					</div>
				</div>

				<div class="row m-1" id="marksrow">
					<div class="col-lg-4">
						<label class="form-label">First language</label> <input
							type="text" name="first_lang" id="first_lang"
							class="form-control"
							onchange="return checkValue('first_langError')" maxlength="3" /><span
							id="first_langError"></span>
					</div>
					<div class="col-lg-4" id="sllabel">
						<label class="form-label">Second Language</label> <input
							name="second_lang" id="second_lang" type="text"
							class="form-control"
							onchange="return checkValue('second_langError')" maxlength="3" /><span
							id="second_langError"></span>
					</div>
					<div class="col-lg-4">
						<label class="form-label">Third Language- English</label> <input
							name="third_lang" id="third_lang" type="text"
							class="form-control"
							onchange="return checkValue('third_langError')" maxlength="3" /><span
							id="third_langError"></span>
					</div>
					<div class="col-lg-4">
						<label class="form-label">Mathematics </label> <input type="text"
							name="maths" id="maths" class="form-control"
							onchange="return checkValue('mathsError')" maxlength="3" /><span
							id="mathsError"></span>
					</div>
					<div class="col-lg-4">
						<label class="form-label">General Science</label> <input
							name="science" id="science" type="text" class="form-control"
							onchange="return checkValue('scienceError')" maxlength="3" /><span
							id="scienceError"></span>
					</div>
					<div class="col-lg-4">
						<label class="form-label">Social Studies</label> <input
							type="text" name="social" id="social" class="form-control"
							onchange="return checkValue('socialError')" maxlength="3" /><span
							id="socialError"></span>
					</div>
				</div>

			</div>
			<div class="col-md-6 text-center">
				<h5 class="h5 text-center text-info text-underline">PHOTO</h5>
				<div class="row m-1">
					<div class="col-lg-12 col-md-12">
						<label class="form-label">Upload Photo </label> <input type="file"
							name="photo" id="photo"
							onchange="return checkValue('photoError'), uploadImage();">
						<span id="photoError"></span>

						<div id="imageContainer"></div>
						<input type="hidden" id="base64Image" /> <input type="hidden"
							id="oldImage" />

					</div>
				</div>
				<div class="row m-1">
					<div class="col-lg-12 col-md-12">
						<label class="form-label text-danger"> * File less than
							100kb and Must be jpg,png,jpeg images. </label>
					</div>
				</div>
			</div>
		</div>

		<br>



		<div class="row m-1">
			<div class="col-12 text-center text-info text-underline">
				<h5 class="h5">LIST OF DOCUMENTS VERIFIED</h5>
			</div>
		</div>

		<div class="container mt-3">
			<table class="table table-bordered">


				<tr>
					<th style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center" width="30px">S.No</th>
					<th style="padding: 5px; margin: 5px; text-align: center;" class="text-center">Name of Documents</th>
					<th style="padding: 5px; margin: 5px; text-align: center;" class="text-center">Verification(Please Select Yes/No/Not Applicable</th>
				<tr>
					<td>1</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">SSC/Equivalent Marks</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="ssc_eq" value="Y">Yes
						<input type="radio" name="ssc_eq" value="N">No 
						<input type="radio" name="ssc_eq" value="NA"  checked="checked" >Not Applicable
					</td>
				</tr>
				<tr>
					<td>2</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">Transfer Certificate</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="tc" value="Yes">Yes 
						<input type="radio" name="tc" value="N">No
						<input type="radio" name="tc" value="NA" checked="checked" >Not Applicable
					</td>
				</tr>
				<tr>
					<td>3</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">Caste Certificate</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="cc" value="Y">Yes 
						<input type="radio" name="cc" value="N">No
						<input type="radio" name="cc" value="NA" checked="checked" >Not Applicable
					</td>
				</tr>
				<tr>
					<td>4</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">Physically challenged(If applicable)</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="pc" value="Y">Yes 
						<input type="radio" name="pc" value="N">No
						<input type="radio" name="pc" value="NA" checked="checked">Not Applicable
					</td>
				</tr>
				<tr>
					<td>5</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">Ex-Serviceman(If applicable)</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="exsv" value="Y">Yes 
						<input type="radio" name="exsv" value="N">No
						<input type="radio" name="exsv" value="NA" checked="checked">Not Applicable
					</td>
				</tr>
				<tr>
					<td>6</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">Study Certificate</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="sc" value="Y">Yes 
						<input type="radio" name="sc" value="N">No
						<input type="radio" name="sc" value="NA" checked="checked">Not Applicable
					</td>
				</tr>

				<tr>
					<td>7</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">Nativity Certificate</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="nc" value="Y">Yes 
						<input type="radio" name="nc" value="N">No
						<input type="radio" name="nc" value="NA" checked="checked">Not Applicable
					</td>
				</tr>
				<tr>
					<td>8</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">UID</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="uidv" value="Y">Yes 
						<input type="radio" name="uidv" value="N">No
						<input type="radio" name="uidv" value="NA" checked="checked">Not Applicable
					</td>
				</tr>
				<tr>
					<td>9</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">EWS</td>
					<td style="padding: 5px; margin: 5px; text-align: center;" scope="row" class="text-center">
						<input type="radio" name="ewsv" value="Y">Yes 
						<input type="radio" name="ewsv" value="N">No
						<input type="radio" name="ewsv" value="NA" checked="checked">Not Applicable
					</td>
				</tr>
			</table>
		</div>

		<div class="row m-1">
			<div class="col-12 text-center text-info text-underline">
				<h5 class="h5">SELECTED DISTRICTS ARE :</h5>
			</div>
		</div>

		<div class="container mt-1" align="center">
			<table class="table table-bordered w-50">
				<thead>
					<tr>
						<th>S.No</th>
						<th>District Name</th>
					</tr>

				</thead>
				<tbody id="selectedDists">
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="col-lg-4 col-md-6" ></div>
			<div class="col-lg-4 col-md-6" id="formthree" align="center">
				<label class="form-label">Reject Reason :</label> 
					<input type="text" name="rejectReason" id="rejectReason" class="form-control"
					onchange="return checkValue('rejError')" maxlength="100" /> 
					<span
					id="rejError"></span>
			</div>
		</div>
		<br>
		<div align="center"><span id="ssc_eqError"></span></div>
		<div align="center">

			<input type="button" value="APPROVE" class="btn btn-success"
				onclick="approveData()" id="approveButton" /> 
				
				<input type="button" id="rejectButton"
				value="REJECT" class="btn btn-danger" onclick="rejectData()" id="rejectButton" />
				
		</div>
		
		<div align="center"><span id="serverResponse"></span></div>

	</div>
	
	<div id="printOptions" align="center">
		THE APPLICATION HAS BEEN APPROVED FOR SSC REGISTRATION ID: <span id="printOptionsRegid"></span> <br>
		
		<form action="./printVeriedApplication" method="post" target="_blank;" >
		
				<input type="hidden" id="regidd" name="printregid"   />
				<input type="hidden" id="dobPrint" name="dobPrint" />
				<input type="hidden" id="ssc_regnoPrint" name="ssc_regnoPrint" />
				
				
				<input type="submit" class="btn btn-success w-25" value="Click here to PRINT APPLICATION" />
				<input type="button" class="btn btn-success w-25" value="Click here to VERIFY another application" onclick="return reloadPage();" />
			</form>
	</div>
 



	<br>
	<br>
	<br>
	<br>
	<jsp:include page="/WEB-INF/footer.jsp" />
</body>
</html>