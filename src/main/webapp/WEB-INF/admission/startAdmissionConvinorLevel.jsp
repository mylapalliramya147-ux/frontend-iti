<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <jsp:include page="/WEB-INF/jsp/_api_base_url.jsp"/>
 <script type="text/javascript" src="./js/customJs/startAdmissionConvinorLevelJs.js"></script>
</head>
<body> 

	<div id="navbaropen" align="center">
		<%@include file="/WEB-INF/banner.jsp"%>
		<%@include file="/WEB-INF/navbaropen.jsp"%>
		<span id="errorMsg"></span>
	</div>
	
	<div id="navbar">
		<%@include file="/WEB-INF/banner.jsp"%>
		<%@include file="/WEB-INF/navbar.jsp"%>
		
		<div align="center">
				<h6 class="h6 font-weight-bolder">TAKING ADMISSIONS - PHASE-1</h6>
		</div>
		
		
		<div class="container border p-2 mt-2 border font-weight-bolder shadow-lg w-50" style=" border-radius: 20px" id="formdiv">
			<form action="./itiAdmEntry" method="post" id="submitform">
			
			<input type="hidden" name="admDate" id="admDate" />
			<input type="hidden" name="meritTo" id="meritTo" />
			<input type="hidden" name="meritFrom" id="meritFrom" />
			
			<div class="row align-items-center m-2">
				<div class="col-md-4">
					<label for="caste" class="col-form-label float-right">
						Caste </label> 
				</div>
				<div class="col-md-8">
					<select name="castePerform" id="caste_perform" class="form-control form-select" onchange="return checkValue('castePerformError')">
						<option value="">-select-</option>
						<option value="all">all</option>
                        <option value="w">Women</option>
						</select>
						<span id="castePerformError"></span>
				</div>
			</div>
			
			<div class="row align-items-center m-2">
				<div class="col-md-4">
					<label for="qualification" class="col-form-label float-right" onchange="return checkValue('regidError')">
						Qualification </label> 
				</div>
				<div class="col-md-8">
					<select name="qualPerform" id="qual_perform" class="form-control form-select" onchange="return checkValue('qualPerformError')">
						<option value="">-select-</option>
						 <option value="all">all</option>
                         <option value="assc">Intermediate</option>
						</select>
						<span id="qualPerformError"></span>
				</div>
			</div>
			
			<div class="row align-items-center m-2">
				<div class="col-md-4">
					<label for="admissionTimings" class="col-form-label float-right">
						Admission Timings </label> 
				</div>
				<div class="col-md-8">
					<select name="admTime" id="admTime" class="form-control form-select" onchange="return checkValue('admPerformError')">
					</select>
					<span id="admPerformError"></span>
				</div>
			</div>
			
			<div align="center">
				<button class="btn btn-success w-50" onclick="return validate();">SUBMIT</button>
			</div>
			</form>
		
		</div>
		<div align="center" id="admTimingError">
				
		</div>
	</div>
	
	
	
	
	
<!-- 	<br> <br> -->
<!-- 	<br> <br> -->
	<%@include file="/WEB-INF/footer.jsp"%>
	
</body>
</html>