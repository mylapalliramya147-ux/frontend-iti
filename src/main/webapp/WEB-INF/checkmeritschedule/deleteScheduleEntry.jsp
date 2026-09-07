<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.bundle.min.js"></script>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/all.min.css">
<link rel="stylesheet" href="./css/style.css">
<title>Update Schedule Entry</title>
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/siteScript.js"></script>
<script type="text/javascript"
	src="./js/customJs/deleteScheduleEntry.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body onload="generateCaptcha(),getReady();">
	<div id="404Msg" align="center">
		<img src="./images/gen.jpg" class="img-fluid" />
		<%@include file="/WEB-INF/openNavbar.jsp"%>
	</div>
	<div id="navbar">
<%-- 		<%@include file="/WEB-INF/userpages/Navbar.jsp"%> --%>
		<%@include file="/WEB-INF/bannernew.jsp"%>
	<%@include file="/WEB-INF/checkmeritschedule/authNavbar.jsp"%>
	</div>

	<br>
	<div class="row m-1">
		<div class="col-12 text-center" id="currentphase"></div>
	</div>

	<div align="center">

		<div class="container mt-2 mb-4 border font-weight-bolder  shadow-lg"
			style="background-color: #e6ffff; border-radius: 20px;">


			<div class="row align-items-center m-2">
				<div class="col-12">
					<h6 class="h6 font-weight-bolder text-primary ">Update
						Schedule Entry Timings</h6>
				</div>
			</div>

			<div class="row align-items-center m-2">
				<div class="col-2">
					<label for="monthYear" class="col-form-label float-right">Government / Private
						Type</label>
				</div>

				<div class="col-4">
					<select name="addrs_district_p" class="distclass form-control"
						id="addrs_district_p" onchange="getColleges(this.value);">
						<option value="">--SELECT--</option>
						<option value="G">Government</option>
						<option value="P">Private</option>
					</select> <span id="adddistrictError" class="text-danger"></span>
				</div>
				<div class="col-6"></div>
			</div>

			<div class="row align-items-center m-2">
				<div class="col-2">
					<label for="monthYear" class="col-form-label float-right">District
						Name:</label>
				</div>

				<div class="col-4">
					<select name="addrs_state_p" class="stateclass form-control"
						id="addrs_state_p" onchange="getDistItis(this.value);">
						<option value="all">--SELECT--</option>

					</select> <span id="districtError" class="text-danger"></span>
				</div>
			</div>

			<div class="row align-items-center m-2">
				<div class="col-2">
					<label for="monthYear" class="col-form-label float-right">ITI
						Name:</label>
				</div>

				<div class="col-4">
					<select class="mandalsclass form-control" name="addrs_mandal_p"
						id="addrs_mandal_p">

					</select> <span id="itiError" class="text-danger"></span>
				</div>
			</div>


			<div class="row align-items-center m-2">
				<div class="col-2">
					<label class="form-label float-md-right">Captcha&nbsp;&nbsp;</label>
				</div>
				<div class="col-4">
					<input type="text" id="txtInput" class="form-control" maxlength="4"
						autocomplete="off" onchange="return checkValue('captchaErr')" />

				</div>
				<div class="col-2">
					<input type="text" id="mainCaptcha" readonly="readonly"
						class="form-control"
						style='letter-spacing: 10px; font-weight: bolder; color: white; background-color: black;' />
					<span id="captchaErr"></span>
				</div>
				<div class="col-1">
					<i class="fas fa-sync fa-2x pt-1" onclick="generateCaptcha();"></i>
				</div>
			</div>

			<div class="row m-1" align="center">
				<div class="col-md-12">

					<input type="submit" value="Submit" id="submitBtn"
						class="btn btn-success" onclick="return validate();" />

				</div>
			</div>

		</div>


		<div id='response'></div>
	</div>
	<br>

	<div align="center" id="successMsg"></div>
	<!-- 		<div align="center" > -->
	<!-- 			<h6 class="h6" style="color: blueviolet; font-size: 15px;">Already scheduled for the following ranks</h6> -->
	<!-- 		</div> -->
	<div>
		<div class="table-responsive">
			<table border="1" class="table table-striped" id="table">
				<thead class="table-dark">
					<tr>
						<th class="text-white">Sl No</th>
						<th class="text-white">District Name</th>
						<th class="text-white">ITI Name</th>
						<th class="text-white">Merit From</th>
						<th class="text-white">Merit To</th>
						<th class="text-white">Call Date (YYYY-MM-DD)</th>
						<th class="text-white">Call Time ()</th>
						<th class="text-white">Actions</th>
					</tr>
				</thead>
				<tbody id="entryList">

				</tbody>
			</table>
		</div>



	</div>

	<br>
	<br>
	<br>
	<br>
	<%@include file="/WEB-INF/footer.jsp"%>
</body>
</html>