/**
 * 
 */

	let jwtToken = null;
	let insCode =  null;
	let roleId =  null;

$(document).ready(function(){
	
	$("#navbaropen").hide(); 
	$("#navbar").hide(); 
	
	$("#formdiv").hide(); 
	convertFormValuesAsNull(); 
	
	  
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
		
		$.ajax({
			type: 'get',
			url: 'http://10.72.4.135:8888/itiapi/masterdata/getAdmissionTimings?insCode='+insCode+'&roleId='+roleId,
			cache: false,
			success: function(resp){
				//alert("resp=>"+JSON.stringify(resp));
				
				if(resp.length > 0){
					$("#formdiv").show();
					convertFormValuesAsNull(); 
					$("#admTime").append('<option value="">-select-</option>');
					for(var i=0; i<resp.length;i++){
						var bean = resp[i];
						$("#admTime").append('<option value="'+bean.callTime+'">'+bean.callTime+'</option>');
					}
				}else{
					$("#admTimingError").append('<h6 style="color: red;">YOU DONT HAVE ANY SCHEDULE FOR TAKING ADMISSIONS TODAY</h6>');
					convertFormValuesAsNull();
				}
			}
		});
	}
	  
	});

function convertFormValuesAsNull(){
	$("#caste_perform").val(''); 
	//qual_perform
	$("#qual_perform").val(''); 
	//admPerform
	$("#admTime").val(''); 
}

function validate(){
	
	var caste_perform =	$("#caste_perform").val(); 
	var qual_perform =	$("#qual_perform").val(); 
	var admTime =	$("#admTime").val(); 
	
	//alert("caste_perform="+caste_perform+",qual_perform="+qual_perform+","+admTime);
	
	if(caste_perform == '' || caste_perform == null){
		$("#castePerformError").html("Caste is required.");
		$("#castePerformError").css({"color": "red"}); 
		$("#caste_perform").focus(); 
		return false;
	}
	
	if(qual_perform == '' || qual_perform == null){
		$("#qualPerformError").html("Qualification is required.");
		$("#qualPerformError").css({"color": "red"}); 
		$("#qual_perform").focus(); 
		return false;
	}
	
	if(admTime == '' || admTime == null){
		$("#admPerformError").html("Admission Timings is required.");
		$("#admPerformError").css({"color": "red"}); 
		$("#admTime").focus(); 
		return false;
	}
	
	$("#admTimingError").empty();
	
	var rbody = {};
	rbody['castePerform'] = caste_perform;
	rbody['qualPerform'] = qual_perform;
	rbody['admTime'] = admTime;
	rbody['roleId'] = roleId;
	rbody['insCode'] = insCode;
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/masterdata/itiAdmissionEntry',
		contentType: 'application/json',
		data: JSON.stringify(rbody),
		cache: false,
		timeout: 600000,
		success:function(response){
			//alert("resp=>"+JSON.stringify(response));
			
			$("#admDate").val(response.admDate);
			$("#meritTo").val(response.meritTo);
			$("#meritFrom").val(response.meritFrom);
			
			document.forms[0].submit();
		},
		error:function(error){
			//alert("error=>"+JSON.stringify(error));
			$("#admTimingError").append('<h6 style="color: red;">'+error.responseText+'<h6>');
		}
	});
	
	return false;
}

function checkValue(a){
	document.getElementById(a).innerHTML = '';
}
