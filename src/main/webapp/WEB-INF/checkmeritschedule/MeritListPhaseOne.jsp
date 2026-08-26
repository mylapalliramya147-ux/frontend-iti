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
<title>Merit List</title>
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/siteScript.js"></script>
<script type="text/javascript" src="./js/customJs/MeritListPhaseOneJs.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>


<script>
function exportToExcel() {
    // Get the table element
    var table = document.getElementById("table");

    // Generate an array of arrays representing the table data
    var data = [
        Array.from(table.querySelectorAll("thead th")).map(th => th.innerText.trim()), // Headers
        ...Array.from(table.querySelectorAll("tbody tr")).map(row =>
            Array.from(row.querySelectorAll("td")).map(td => td.innerText.trim())
        ),
    ];

    // Create a worksheet
    var ws = XLSX.utils.aoa_to_sheet(data);

    // Create a workbook
    var wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "Sheet1");

    // Save the workbook to an Excel file
    XLSX.writeFile(wb, "table_data.xlsx");
}
</script>



    
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

	<div class="row text-danger">
		<div class="col-2"></div>
		<div class="col-9">
			Note : <br> 1. Click here to generate Merit List. If you
			generate Merit List, Your ITI will be automatically Freezed.<br>
			2. After clicking the button, please be patient as generating the
			list would take around 5-10 mins do not close the window or refresh
			the page.<br> 3. You can Generate CHECK LIST any number of
			times.<br> 4. But, if you generate FINAL MERIT LIST then only
			MERIT LIST will be generated and applications will be automatically
			freezed.

		</div>
		<div class="col-1"></div>
	</div>


	<br>
	<div align="center">

		<div style="background-color: #e6ffff; border: 1px solid black;border-radius: 20px;"
			class="w-50 p-2" id="formone">
			<h6 class="h6 text-info fw-bolder">MERIT LIST GENERATION FORM</h6>
			<div class="row m-1">
				<div class="col-md-6">
					<strong class="form-label">Merit List Type :</strong>
				</div>
				<div class="col-md-6">
					<select name="meritListType" id="meritListType"
						class="form-control">
						<option value="">-SELECT-</option>
						<option value="checklist">CHECK LIST</option>
						<option value="meritlist">MERIT LIST</option>
					</select><span id="meritListTypeError"></span>

				</div>
				
			</div>
			<div class="row">
				<div class="col-lg-6 col-md-6">
					<strong class="form-label">Captcha :</strong>
				</div>
				<div class="col-lg-6 col-md-6">
					<input type="text" id="txtInput" class="form-control" maxlength="4"
						autocomplete="off" onchange="return checkValue('captchaErr')" /><span
						id="captchaErr"></span>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-6 col-md-6"></div>
				<div class="col-lg-4 col-md-4">
					<input type="text" id="mainCaptcha" readonly="readonly"
						class="form-control"
						style="letter-spacing: 30px; font-weight: bolder; color: white; background-color: black;  " />
				</div>
				<div class="col-lg-2 col-md-2">
					<i class="fas fa-sync fa-2x" onclick="generateCaptcha();"
						style="cursor: pointer; margin-top: 10px;"></i>
				</div>
			</div>
			<div class="row m-1" align="center">
				<div class="col-md-12">
					
					<input type="submit" value="Submit" class="btn btn-success"
						onclick="return validate();" /> <input type="reset" value="RESET"
						class="btn btn-info">
				</div>
			</div>
		</div>

	</div>



	<div
		class="container border p-2 mt-2 border font-weight-bolder shadow-lg "
		style="background-color: #e6ffff; border-radius: 20px;" id="data">
			<!-- Add a button for exporting to Excel -->
						<button class="export-button" onclick="exportToExcel()">Export to Excel</button>
<!-- 						 <button onclick="exportToExcel()" style="float: right;">Export to Excel</button> -->

<div class="table-responsive">
		<table border="1" class="table table-striped" id="table">
			<thead class="table-dark">
				<tr>
					<th class="text-white">Sl No</th>
					<th class="text-white">Rank</th>
					<th class="text-white">Registration Id</th>
					<th class="text-white">Name Of Candidate</th>
					<th class="text-white">Father Name</th>
					<th class="text-white">Gender</th>
					<th class="text-white">Caste</th>
					<th class="text-white">Date Of Birth</th>
					<th class="text-white">SSC Passed</th>
					<th class="text-white">Phc</th>
					<th class="text-white">Ex-Service</th>
					<th class="text-white">Contact No</th>
					<th class="text-white">GPA</th>
					
				</tr>
			</thead>
			<tbody id="meritList">

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