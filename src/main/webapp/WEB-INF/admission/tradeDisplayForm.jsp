<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript" src="./js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="./js/jquery364.min.js"></script>
                    <jsp:include page="/WEB-INF/jsp/_api_base_url.jsp"/>
<script type="text/javascript" src="./js/siteScript.js"></script>

<link rel="stylesheet" href="./css/style.css">
<link href="./css/bootstrap.min.css" rel="stylesheet">

<script>

$(document).ready(function(){
	
	dists = getDists();
	
	$("#itidata").hide();
	$("#itisdata").hide();
	$("#itiData").hide();
	
	//alert("dists=>"+dists);
	
	$("#distss").append('<option value="">-select-</option>');
		for(var j=0; j<dists.length; j++){
			var bean = dists[j];
			$("#distss").append('<option value="'+bean.dist_code+'">'+bean.dist_name+'</option>');
		}
});

 function validate(){
	 var distcode = $("#distss").val();
		var govt = $("#govt").val();
		
		var condition;
		//alert(distcode);
		if(distcode == "" || distcode==null) {
			//alert("plz select a district");
			$("#distError").html('Please select a district.')
			$("#distError").css('color','red');
			$("#distss").focus();
			return false;
		}
 }
</script>
</head>
<body>
	<%@include file="/WEB-INF/bannernew.jsp"%>
	<%@include file="../navbars/openNavbar.jsp"%>


	<div class="container border p-2 mt-2 rounded-3 w-50"  style="background-color: #e6ffff;">
	<form action="./tradeDisplay" method="post">
		<div class="row m-1">
			<div class="col-12 text-center text-decoration-underline">
				<h3 class="h3" style="color: blueviolet; font-size: 15px;">
					List of ITI's with Trades & Strengths Interface</h3>
			</div>
		</div>
	
		<div class="row m-1">
			<div class="col-lg-6 col-md-6"><label>District</label></div>
			<div class="col-lg-6 col-md-6">
				<select class="form-select form-control" name="distss" id="distss" 
				onchange="return checkValue('distError')">
				</select>
				<span id="distError"></span>
			</div>
		</div>
		<div class="row m-1">
			<div class="col-lg-6 col-md-6"><label>College Type</label></div>
			<div class="col-lg-6 col-md-6">
				<select class="form-select form-control" name="govt" id="govt">
							<option value="all">-ALL-</option>
							<option value="G">GOVERNMENT</option>
							<option value="P">PRIVATE</option>
				</select>
			</div> 
		</div>
		
		<div align="center">
			<button class="btn btn-success w-25" onclick="return validate();">Submit</button>
		</div>
		
		</form>
	</div>
	<br>
	<%@include file="/WEB-INF/footer1.jsp"%>



</body>
</html>