<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="widtd=device-widtd, initial-scale=1">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.bundle.min.js"></script>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/all.min.css">
<link rel="stylesheet" href="./css/style.css">
<title>Add Trade</title>
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/siteScript.js"></script>
<script type="text/javascript" src="./js/jquery364.min.js"></script>
<script type="text/javascript" src="./js/customJs/addTradeJs.js"></script>
</head>
<body onload="generateCaptcha(),getReady();">
	<div id="404Msg" align="center">
		<%@include file="/WEB-INF/banner.jsp"%>
		<%@include file="/WEB-INF/navbaropen.jsp"%>
	</div>
	<div id="navbar">
		<%@include file="/WEB-INF/banner.jsp"%>
	<%@include file="/WEB-INF/navbar.jsp"%>
	</div>
	<br>

	<div align="center">
		<div class="row align-items-center m-2">
			<div class="col-12">
				<h6 class="h6 font-weight-bolder text-danger ">Add Trade And
					Reservation Matrix In Selected ITI</h6>
			</div>
		</div>

		<div class="container mt-2 mb-4 border font-weight-bolder  shadow-lg"
			style="background-color: #e6ffff; border-radius: 20px;" id="divOne">



			<div class="row align-items-center m-2">
				<div class="col-2">
					<label for="montdYear" class="col-form-label float-right">Select
						ITI:</label>
				</div>

				<div class="col-4">
					<select class="mandalsclass form-control" name="itiName"
						id="itiName" onchange="checkValue('itiError')">

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

		<div class="container" id="tradeDataTableDiv">


			<div class="itiNameSpan"></div>
			<div align="left"><button class="btn btn-success" style="margin-right: 20px;"
				onclick="addNewTrade();">ADD NEW TRADE</button></div>
			<form>
				<table class="table table-bordered table-stripped">
					<thead>
						<tr>
							<td
								style="background-color: black; color: white; font-weight: bolder;">TRADE
								CODE</td>
							<td
								style="background-color: black; color: white; font-weight: bolder;">TRADE
								NAME</td>
							<td
								style="background-color: black; color: white; font-weight: bolder;">STRENGTH</td>
							<td
								style="background-color: black; color: white; font-weight: bolder;">VACANT</td>
							<td
								style="background-color: black; color: white; font-weight: bolder;">AVAILABLE
								FOR YEAR <span class="currentAdmYear"></span>
							</td>
							<td
								style="background-color: black; color: white; font-weight: bolder;">SEAT
								MATRIX</td>
							<td
								style="background-color: black; color: white; font-weight: bolder;">EDIT</td>
							<td
								style="background-color: black; color: white; font-weight: bolder;">RESERVATION
								ENTRY</td>
						</tr>
					</thead>
					<tbody id="admTradesTable"></tbody>
				</table>
			</form>
			<div class="col-12">
				<h6 class="h6 text-info">Note: Once Trades are Frozen, they
					cannot be edited</h6>
			</div>

			<div id="freezeAndApproveBtnDiv"></div>
<!-- 			<div><button class="btn btn-info" onclick="return freezeAll();">FREEZE ALL</button>  -->
<!-- 			 <button class="btn btn-info" onclick="return approveAll();">APPROVE ALL</button></div> -->
			

			<div class="col-12" id="addTradeSuccessMsg"
				style="font-weight: bolder;"></div>

		</div>

		<div id="addNewTradeDiv" class="container">
			<div class="itiNameSpan"></div>

			<div class="container p-2   border font-weight-bolder  shadow-lg"
				style="background-color: #e6ffff; border-radius: 20px;" id="divOne">

				<div class="row align-items-center m-2">
					<div class="col-12">
						<h6 class="h6 font-weight-bolder text-primary ">Add Trade
							Form</h6>
					</div>
				</div>

				<div class="row">
					<div class="col-4">
						<label for="trade">Trade</label> <select name="trade" id="trade"
							class="form-select" onchange="checkValue('tradeError')"></select><span
							id="tradeError"></span>
					</div>
					<div class="col-4">
						<label for="strength">Strength</label><input type="text"
							name="strength" id="strength" class="form-control"
							oninput="this.value=this.value.replace(/[^0-9]/g,'')"
							maxlength="4" onchange="checkValue('strengthError')" /><span
							id="strengthError"></span>
					</div>
					<div class="col-4">
						<label for="availableForYear" style="margin-bottom: 5px;">Available
							for Year <span class="currentAdmYear"></span>
						</label><br> <input type="radio" name="availableForYear" value="1"
							onchange="checkValue('availableForYearError')"> YES <input
							type="radio" name="availableForYear" value="0"
							onchange="checkValue('availableForYearError')"> NO <br>
						<span id="availableForYearError"></span>
					</div>
				</div>

				<div class="row m-1" align="center">
					<div class="col-md-12">
						<input type="submit" value="Submit" class="btn btn-success"
							onclick="return addTradeSubmit();" />
					</div>
				</div>

			</div>

		</div>

		<div class="container p-2   border font-weight-bolder  shadow-lg w-50"
			id="editTradeDiv"
			style="background-color: #e6ffff; border-radius: 20px;">

			<h6 class="h6 font-weight-bolder text-primary ">
				Edit Trade Details for the Trade Code <br>
				<span id="edittradename" style="font-weight: bolder;"></span>
			</h6>

			<input type="hidden" name="editTradeIticode" id="editTradeIticode" />
			<input type="hidden" name="editTradecode" id="editTradecode" />

			<div class="row">
				<div class="col-6">
					<label for="editStrength">Strength</label> <input type="text"
						name="editStrength" class="form-control" id="editStrength"
						oninput="this.value=this.value.replace(/[^0-9]/g, '')"
						maxlength="4" onchange="checkValue('editStrengthError')" /> <span
						id="editStrengthError"></span>
				</div>
				<div class="col-6">
					<label for="editAvailableForYear" style="margin-bottom: 5px;">Available
						for Year <span class="editCurrentAdmYear"></span>
					</label><br> <input type="radio" name="editAvailableForYear" value="1"
						onchange="checkValue('editAvailableForYearError')"
						id="editAvailableForYearYes"> YES <input type="radio"
						name="editAvailableForYear" value="0"
						onchange="checkValue('editAvailableForYearError')"
						id="editAvailableForYearNo"> NO <br> <span
						id="editAvailableForYearError"></span>
				</div>
			</div>

			<div class="row m-1" align="center">
				<div class="col-md-12">
					<input type="submit" value="Submit" class="btn btn-success"
						onclick="return editTradeSubmit();" />
				</div>
			</div>
			<br>
		</div>
		
		<div class="container p-2   border font-weight-bolder  shadow-lg" id="reservationEntryDiv">
			<h6 class="h6 font-weight-bolder text-primary ">
				Reservation Breakup of Seats for ITI in Trade <br>
				<span id="reservationEntryTradeNameSpan" style="font-weight: bolder;"></span>
			</h6>
				<table class="table table-bordered table-stripped">
					<thead>
					<tr>
						<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">CATEGORY</td>
						<td style="background-color: black; color: white; font-weight: bolder;text-align: center;" colspan="3">SEATS</td>
					</tr>
					<tr>
						<td style="background-color: black; color: white; font-weight: bolder;"></td>
						<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">STRENGTH</td>
						<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">FILLED</td>
						<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">VACANT</td>
					</tr>
					</thead>
					
					<tbody id="reservationEntryTbody">
						 
					</tbody>
					 
				</table>
				<span id="rEntry"></span>
				
				<input type="hidden" id="categoryList" />
				<input type="hidden" id="strengthList" />
				 
		</div>


	</div>


	<br>
	<br>
	<br>
	<br>
	<%@include file="/WEB-INF/footer.jsp"%>
</body>
</html>