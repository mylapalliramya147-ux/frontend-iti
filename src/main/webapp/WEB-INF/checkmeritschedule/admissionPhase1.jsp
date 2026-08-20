<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- <meta name="viewport" content="widtd=device-widtd, initial-scale=1"> -->

<title>Admissions Phase - 1</title>

<script src="./js/customJs/admissionsPhase1Js.js"></script>

</head>
<body onload="getReady();">
	<div id="404Msg" align="center">
		<%@include file="/WEB-INF/banner.jsp"%>
		<%@include file="/WEB-INF/navbaropen.jsp"%>
	</div>
	<div id="navbar">
		<%@include file="/WEB-INF/banner.jsp"%>
		<%@include file="/WEB-INF/navbar.jsp"%>
	</div>
	<br>
	<div align="center" id="pagename">
		<h6 class="h6 font-weight-bolder text-danger ">TAKING ADMISSIONS
			- PHASE-1</h6>
	</div>

		<div class="container border font-weight-bolder  shadow-lg  w-75"
			style="background-color: #e6ffff; border-radius: 20px;" id="checkRankDiv">

			<div class="row align-items-center m-2">

				<div class="col-md-6">
					<label for="montdYear" class="col-form-label float-right">
						Rank :</label> <input type="text" name="rank" id="rank" value="2"
						class="form-control"
						oninput="this.value=this.value.replace(/[a-zA-Z]/g, '')"
						maxlength="4" onchange="checkValue('rankError')" /> <span
						id="rankError" class="text-danger"></span>
				</div>



				<div class="col-md-6">
					<label for="montdYear" class="col-form-label float-right">
						Schedule :</label> <select class="form-control" name="schedule"
						id="schedule" onchange="checkValue('scheduleError')">
						<option value="">-select-</option>
					</select> <span id="scheduleError" class="text-danger"></span>
				</div>
			</div>

			<div class="row m-1" align="center">
				<div class="col-md-12">

					<input type="submit" value="Submit" id="submitBtn"
						class="btn btn-success" onclick="return validate();" />

				</div>
			</div>
<div align="center" id="checkRankResp"></div>
		</div>

		


		<div class="container border font-weight-bolder  shadow-lg"
			style="background-color: #e6ffff; border-radius: 20px;" id="admissionDiv">
			
			<form action="" method="post" onsubmit="return admValidate()">
			
			<div class="row">
				<div class="col-md-2"> <div id="imageContainer"></div> </div>
				<div class="col-md-5" id="detailsOne"> </div>
				<div class="col-md-5" id="detailsTwo"> </div>
			</div>
			<br>
			<span id="selectedValueError"></span>
			<table class="table table-bordered" id="tableAdm">
 
			</table>
			
			<div class="container w-75">
				<div class="row">
					<div class="col-md-4"></div>
					<div class="col-md-4">
						<label for="boardCode">Type of Examination</label>
						<select name="boardCode" id="boardCode" class="form-control" onchange="checkValue('boardCodeError')">
							<option value="">-SELECT-</option>
							<option value="A">Apprenticeship</option>
							<option value="C1">COE(Advanced)</option>
							<option value="C">COE(BBBT)</option>
							<option value="M">Minority</option>
							<option value="N">NCVT</option>
							<option value="S">SCVT</option>
						</select>
						<span id="boardCodeError"></span>
					</div>
					<div class="col-md-4"></div>
				</div>
				
				<div class="row">
					<div class="col-md-6">
						<label for="idmarks1">ID Marks 1</label>
						<textarea name="idmarks1" id="idmarks1" rows="2" cols="1" class="form-control" onchange="checkValue('idmarks1Error')"></textarea><span id="idmarks1Error"></span>
					</div>
					<div class="col-md-6">
						<label for="idmarks2">ID Marks 2</label>
						 <textarea name="idmarks2" id="idmarks2" rows="2" cols="1" class="form-control" onchange="checkValue('idmarks2Error')"></textarea><span id="idmarks2Error"></span>
					</div>
				</div>
				
				<div align="center" class="m-1">
					<input type="submit" class="btn btn-success" value="Take Admissions">
				</div>
				
				
			</div>
			</form>
		</div>


	<br>
	<br>
	<br>
	<br>
	<%@include file="/WEB-INF/footer.jsp"%>
</body>
</html>