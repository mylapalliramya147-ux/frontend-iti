<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>ITI Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<script type="text/javascript" src="./js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="./js/jquery364.min.js"></script>
                    <jsp:include page="/WEB-INF/jsp/_api_base_url.jsp"/>
<script type="text/javascript" src="./js/siteScript.js"></script>
<!-- Add this script tag to include the XLSX library from a CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.4/xlsx.full.min.js"></script>

 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="./css/style.css">
<link href="./css/bootstrap.min.css" rel="stylesheet">

<script>
	let dists = null;
	let itis = null;
	let data = null;
	let seatmatrix = null;
	
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
		
		$.ajax({
			type: 'get',
			url: '${backendBaseUrl}/itiapi/masterdata/getItiProfilesWithTradeAndStrength',
			//url: 'https://itiadmissions.ap.gov.in/itiapi/masterdata/getItiProfilesWithTradeAndStrength',
			cache: false,
			timeout: 6000000,
			success:function(resp){
				//alert("resp=>"+JSON.stringify(resp));
				data = resp;
				 
			}
		});
		$.ajax({
			type: 'get',
			url: '${backendBaseUrl}/itiapi/masterdata/getAllItis',
			//url: 'https://itiadmissions.ap.gov.in/itiapi/masterdata/getAllItis',
			cache: false,
			timeout: 6000000,
			success:function(resp){
				//alert("resp=>"+JSON.stringify(resp));
				itis = resp;
			}
		});
		$.ajax({
			type: 'get',
			url: '${backendBaseUrl}/itiapi/masterdata/getSeatMatrixItiwise',
			//url: 'https://itiadmissions.ap.gov.in/itiapi/masterdata/getSeatMatrixItiwise',
			cache: false,
			timeout: 6000000,
			success:function(resp){
				//alert("resp=>"+JSON.stringify(resp));
				seatmatrix = resp;
			}
		});
		
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
		}else{
			
			$("#itidata").show();
			$("#itisdata").show();
			$("#itiData").hide();
			
			$("#itidata").empty();
			$("#itisdata").empty();
			$("#itiData").empty();
			
			for(var j=0; j<dists.length; j++){
				var bean = dists[j];
				if(distcode == bean.dist_code){
					$("#itidata").append('<h5 class="h5 text-primary text-center">List of ITIs with Trades & Strengths in '+bean.dist_name+'</h5>' 
					+'<h6 class="h6 text-info text-center">Click on ITI Name to view the ITI profile and staff details</h6>'
					+'<div align="center"> <button class="btn btn-success" onclick="exportToExcel()">Download Excel Data</button></div>'
					);
				}
			}
			generateItisData(distcode,govt);
		}
		
		
	}
	function generateItisData(distcode,govt ){
 		//alert(distcode)
 		//alert(govt)
 		
 		var count = 0;
 		var content ='';
 		for(var a=0; a<itis.length;a++){
 			var entity = itis[a];
 			
 			if(entity.distCode == distcode){
 				if(govt == 'all'){
 					for(var s=0; s< seatmatrix.length;s++){
 						var seat = seatmatrix[s];
 						
 						if(entity.itiCode == seat.iticode){
 							count = count + 1;
 							$("#itisdata").append('<a href="javascript:getItiInfo(\''+entity.itiCode+'\')">'+entity.itiCode+'-'+entity.itiName+'</a><br>');
 							$("#itisdata").append('&nbsp;&nbsp;&nbsp;'+count+'.'+seat.tradename+' ('+seat.strength+')<br>');
 						}else{
 							$("#itisdata").append('<a href="javascript:getItiInfo(\''+entity.itiCode+'\')">'+entity.itiCode+'-'+entity.itiName+'</a><br>');
 						}
 					}
 					
 				}else{
 					if(entity.govt == govt){
 						for(var s=0; s< seatmatrix.length;s++){
 	 						var seat = seatmatrix[s];
 	 						
 	 						if(entity.itiCode == seat.iticode){
 	 							count = count + 1;
 	 							alert("entity.itiCode == seat.iticode=>");
 	 							$("#itisdata").append('<a href="javascript:getItiInfo(\''+entity.itiCode+'\')">'+entity.itiCode+'-'+entity.itiName+'</a><br>');
 	 							$("#itisdata").append('&nbsp;&nbsp;&nbsp;'+count+'.'+seat.tradename+' ('+seat.strength+')<br>');
 	 						}else{
 	 							$("#itisdata").append('<a href="javascript:getItiInfo(\''+entity.itiCode+'\')">'+entity.itiCode+'-'+entity.itiName+'</a><br>');
 	 						}
 	 					}
 					}
 				}
 			}
 		}
 		
	}
	

	
	function getItiInfo(itiCode){
		//alert(itiCode)
		$("#itidata").hide();
		$("#itisdata").hide();
		$("#itiData").show();
		$("#itiData").empty();
		
		for(var a=0; a<itis.length;a++){
			var beanbean = itis[a];
			
			if(beanbean.itiCode == itiCode){
				//alert("bean=>"+beanbean)
				var govtSpan;
				if(beanbean.govt == 'G'){ govtSpan = 'Government' }
				if(beanbean.govt == 'P'){ govtSpan = 'Private' }
				
				var distname = getDistName(beanbean.distCode);
				//alert(distname)
					
				$("#itiData").append('<h5 class="h5 text-center text-danger text-decoration-underline">'+beanbean.itiName+'<h5>'
				+'<div class="row">'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">ITI Type:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+govtSpan+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Principal Name:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.principalname+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Email:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.email+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Land Line Number:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.landlinenumber+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Mobile:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.mobile+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">ITI/Non-ITI:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.itiNoniti+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Total Strength:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.totStrength+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">City/Town:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.cityTown+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Capacity:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.capacity+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">District Name:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+distname+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Year of Establishment:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.yearEst+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Land(In Acres):</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.land+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Pin Code:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.pinCode+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Description:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.description+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">VTP:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.vtp+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Vtp Reg.No:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.vtpRegno+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Built Up Area(sq.ft):</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.builtupArea+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">No.of Toilets:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.noofToilets+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Drinking Water Available:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.availableDrinkingwater+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">No.of Labs:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.noofLabs+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">No.Of Class Rooms:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.noofClassrooms+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Capacity For Exam Conducting:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.examconductingStrength+'</span></div>'
				+'<div class="col-lg-3 col-md-3"><label class="form-label">Address:</label></div><div class="col-lg-3 col-md-3"><span class="text-primary">'+beanbean.address+'</span></div>'
				+'</div>'
				+'<div align="center"><button class="btn btn-success" onclick="return closediv()">Back</button></div>'
				);
			}
		}
		
		
	}
	
	function getDistName(distcode){
		var distName;
		
		for(var a=0; a<dists.length;a++){
			var bean = dists[a];
			var code = bean.dist_code;
			
			if(code == distcode){
				distName = bean.dist_name;
			}
		}
		return distName;
	}
	
	function closediv(){
		//alert("closediv()")
		$("#itidata").show();
		$("#itisdata").show();
		$("#itiData").hide();
		$("#itiData").empty();
	}
	
	 
	function checkValue(a){
		//alert('a===>'+a);
		document.getElementById(a).innerHTML = '';
	}

	
</script>

</head>
<body>
	<%@include file="/WEB-INF/bannernew.jsp"%>
	<%@include file="../navbars/openNavbar.jsp"%>


	<div class="container border p-2 mt-2 rounded-3 w-50"  style="background-color: #e6ffff;">
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
		
		
	</div>


	<div class="container border p-2 mt-2 bg-light rounded-3 w-75" id="itidata"></div>
	<div class="container border p-2 mt-2 bg-light rounded-3 w-75" id="itisdata"> </div>
	<div class="container border p-2 mt-2 bg-light rounded-3 w-75" id="itiData"> </div>




<!-- 	<br> -->
<!-- 	<br> -->
<!-- 	<br> -->
	<br>
	<%@include file="/WEB-INF/footer1.jsp"%>



</body>
</html>