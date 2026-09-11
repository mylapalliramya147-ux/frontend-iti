/**
 * 
 */

let jwtToken = null;
	let insCode =  null;
	let roleId =  null;

$(document).ready(function(){
	
	jwtToken = localStorage.getItem('jwtToken');
	insCode =  localStorage.getItem('insCode');
	roleId =  localStorage.getItem('roleId');
	//alert("jwtToken=>"+jwtToken);
	
	if(jwtToken == null || jwtToken == ""){
		$("#navbaropen").show(); 
		$("#errorMsg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO ACCESS THIS PAGE</h3>');
	}else{
		$("#navbaropen").hide(); 
		$("#navbar").show(); 
		
		 
	}
	  
	});


function validate(){
	alert("validate");
	
	var rank = $("#rank").val();
	alert("rank=>"+rank);
	
	
}
