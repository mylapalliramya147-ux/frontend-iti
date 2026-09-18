<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <jsp:include page="/WEB-INF/jsp/_api_base_url.jsp"/>
 <script type="text/javascript" src="./js/customJs/DistrictAdmissionEntryJs.js"></script>
 
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
		
		
		<div class="container border p-2 mt-2 border font-weight-bolder shadow-lg w-50" style=" border-radius: 20px">
		
			<table class="table table-borderless">
				<fmt:parseDate pattern="yyyy-MM-dd" value="${admDate }" var="admDate" />
				<fmt:formatDate pattern="dd-MM-yyyy" value="${admDate }" var="admDatee" />
				<tr>
					<td>Date : <span style="font-weight: bolder;">${admDatee }</span></td><td>Ranks for counseling : <span style="font-weight: bolder;">${meritFrom } to ${meritTo }</span></td><td></td>
				</tr>
				<tr>
					<td>Caste : <span style="font-weight: bolder;">${castePerform }</span></td><td>Qualification : <span style="font-weight: bolder;">${qualPerform }</span></td> 
				</tr>
				<tr>
					<td>Call Time : <span style="font-weight: bolder;">${admTime }</span></td> 
				</tr>
			</table>
			
			<div class="row align-items-center m-2">
				<div class="col-md-4">
					<label for="rank" class="col-form-label float-right">
						Rank </label> 
				</div>
				<div class="col-md-8 w-50">
					 <input type="text" name="rank" id="rank" class="form-control" /><span id="rankErr"></span>
				</div>
			</div>               
			<div align="center">
				<button class="btn btn-success w-50" onclick="return validate();">SUBMIT</button>
			</div>
		
		</div>
		 
	</div>
	
	
	
	
	
<!-- 	<br> <br> -->
<!-- 	<br> <br> -->
	<%@include file="/WEB-INF/footer.jsp"%>
	
</body>
</html>