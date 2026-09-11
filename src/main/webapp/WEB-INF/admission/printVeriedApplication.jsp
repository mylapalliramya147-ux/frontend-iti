<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PRINT APPLICATION</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="./css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="./js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="./css/style.css">
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/siteScript.js"></script>
<script type="text/javascript" src="./js/customJs/printVeriedApplication.js"></script>

 
</head>
<body onload="getReady();">

	<div id="404Msg" align="center">
		<img src="./images/gen.jpg" class="img-fluid" />
		<%@include file="/WEB-INF/openNavbar.jsp"%>
	</div>
	
	<div id="navbar">
		<%@include file="/WEB-INF/userpages/Navbar.jsp"%>
	</div>
	

	<input type="hidden" name="regid" value="${regid}" id="regid" />
	<input type="hidden" name="dob" value="${dob}" id="dob" />
	<input type="hidden" name="ssc_regno" value="${ssc_regno}" id="ssc_regno" />
	 

	<div class="container-fluid" id="contentDiv">
		<div align="center">
			Certificate Verification for admission into ITI for the session <span id="yearandphase"></span>
		</div>
		
		<div class="row mt-2">
			<div class="col-8">
				<span style="font-weight: bolder;">Registration ID: <span id="registrationId"></span></span>
			</div></div>

		<div class="row">
			<div class="col-8">
				<span id="regid" class="fw-bold"></span> <br> <span
					class="text-info text-decoration-underline">QUALIFICATION
					DETAILS</span>

				<table>
					<tbody id="qualificationDetails"></tbody>
				</table>

			</div>
			<div class="col-4">
				<div id="imageContainer" align="center"></div>
			</div>
		</div>

		<div class="row mt-2">
			<div class="col-6">
				<span class="text-info text-decoration-underline">PERSONAL
					DETAILS</span>
				<table class="table table-bordered">
					<tbody id="personalDetails"></tbody>
				</table>
			</div>
			<div class="col-6">
				<span class="text-info text-decoration-underline">RESERVATION
					DETAILS</span>
				<table class="table table-bordered">
					<tbody id="reservationDetails"></tbody>
				</table>
			</div>
		</div>
		<div class="row mt-2">
			<div class="col-12">
			<span class="text-info text-decoration-underline">List of Documents Verified</span>
				<table class="table table-bordered">
					<tbody id="docverifiedDetails"></tbody>
				</table>

			</div>
			</div>
	

		<div class="mt-1">
			<span class="text-info text-decoration-underline">Fee
				Structure:</span>
			<p>a. Tuition Fees for Private ITIs per annum</p>

			<table class="table table-bordered w-75">
				<thead>
					<tr>
						<th></th>
						<th>Urban</th>
						<th>Rural</th>
					</tr>
					<tr>
						<td>Engineering Trades</td>
						<td>16,500</td>
						<td>15,000</td>
					</tr>
					<tr>
						<td>Non-Engineering Trades</td>
						<td>13,200</td>
						<td>12,000</td>
					</tr>
				</tbody>
			</table>

			<br>
			<p>
				b. Tuition fee for Government ITIs is <b>NIL</b> (Free education)
			</p>
		</div>
		<section class="container-fluid  boxbg">
			<br> <strong> NOTE:</strong><br>

			<p>This Verification acknowledgment will not give any guarantee to get admission into ITI.
			The applicant shall have to attend any applied district convener at his choice for admission  
			counseling in the prescribed date(s) to get seat.Allocation of seat is subject to availability 
			of vacancies in the trade as per merit cum reservation.Applicant shall have to produce the verification
			 acknowledgment while attending to admission counseling along with requisite 
			 original documents and prescribed tution fee.</p>
		
		
			 
		
			<br> <strong> UNDERTAKING:</strong><br>

			<p>This Verification acknowledgment will not give any guarantee to get admission into ITI.
			The applicant shall have to attend any applied district convener at his choice for admission  
			counseling in the prescribed date(s) to get seat.Allocation of seat is subject to availability 
			of vacancies in the trade as per merit cum reservation.Applicant shall have to produce the verification
			 acknowledgment while attending to admission counseling along with requisite 
			 original documents and prescribed tution fee.</p>
		
			 
		
			
			<br> <strong> DATE:</strong><br>
			<p>Signature of the Candidate</p>

			<p class="mr-5 pr-5" style="text-align: right">Signature of the Chief Verification Officer/Principal
						with office Seal</p>

		</section>







	</div>

</body>
</html>