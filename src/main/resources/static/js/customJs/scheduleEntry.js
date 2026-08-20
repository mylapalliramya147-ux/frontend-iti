let jwtToken = null;
let insCode = null;
let response = null;


function getReady(){
	
//	alert("getReady");
	jwtToken = localStorage.getItem('jwtToken');
	insCode =  localStorage.getItem('insCode');
	//alert("jwtToken=>"+jwtToken);
	
	if(jwtToken == null || jwtToken == ""){
		$("#navbar").hide(); 
		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
	}else{
		//alert("else"+jwtToken);
		jwtToken = "Bearer "+jwtToken;
		//alert("assign=>"+jwtToken);
		$("#404Msg").hide(); 
		$("#navbar").show(); 
		
		getCurrentPhaseValues();
		getScheduleEntryByDist();
		
	}
}

function getCurrentPhaseValues(){
	$.ajax({
		type:'get',
		url : 'http://10.72.4.135:8888/itiapi/masterdata/getAdmissionPhaseData',
		cache : false,
		timeout : 600000,
		success: function(resp){
			//alert("getAdmissionPhaseData=>"+JSON.stringify(resp));
			document.getElementById('currentphase').innerHTML = 
				'<h3 class="h3" style="color: blueviolet; font-size: 15px;" > Admission Entry(Counseling Schedule) for the Session Year-'+resp.admYear +' and Phase-'+resp.currentPhase+'</h3>';
		},
		error: function(error){
			alert("Admission Phase data is not Loaded.");
		}
	});
}

function getScheduleEntryByDist(){
	$("#entryList").empty();
	var data = {};
	data['distCode'] = insCode;
	//alert("before calling"+jwtToken);
	$.ajax({
		type: 'POST',
		url:'http://10.72.4.135:8888/itiapi/admissions/getScheduleEntryByDistCode',
		contentType: "application/json",
		data: JSON.stringify(data),
		headers:{
			'Authorization': jwtToken
		},
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("success=>getScheduleEntryByDistCode=>"+JSON.stringify(resp));
			response = resp;
			//alert("lenth=>"+parseInt(resp.length-1));
			if(resp.length==0){
				$("#from_date").val('1');
				$("#from_date").prop('readonly', true);
				$("#from_date").prop('disabled', true);
			}
			else{
				//alert("in else");
				var latest = parseInt(resp.length-1);
				var latestBean = resp[latest];
				//alert(latestBean.meritFrom)
				
				$("#from_date").val(parseInt(latestBean.meritTo+1));
				$("#from_date").prop('readonly', true);
				$("#from_date").prop('disabled', true);
				var count =0;
				for(var i=0; i<resp.length;i++){
					//alert(i);
		       		  count = count + 1;
		       		  var bean = resp[i];
		       		 
		       		  $("#entryList").append('<tr>'
		       				  +'<td>'+count+'</td>'
		       				  +'<td>'+bean.meritFrom+'</td>'
		       				  +'<td>'+bean.meritTo+'</td>'
		       				  +'<td>'+bean.callDate+'</td>'
		       				  +'<td>'+bean.callTime+'</td>'
		       				  +'</tr>');
		       	  }
			}
		},
		error:function(resp){
			alert("error=>getScheduleEntryByDistCode=>"+JSON.stringify(resp));
		}
	});
}





function validate(){
	//alert("working");
	  
	  var from_date = $("#from_date").val();
	  if(from_date == null || from_date == ""){
		  $("#from_dateError").html("Merit From Date is required.");
		  $("#from_dateError").css({"color": "red"});  
		  return false;
	  }
	  
	  var to_date = $("#to_date").val();
	  if(parseInt(from_date) > parseInt(to_date)){
		  //alert("invalid");
		  $("#to_dateError").html("Merit To  is should not less than Merit From .");
		  $("#to_dateError").css({"color": "red"}); 
		  $("#to_date").val('');
		  $("#to_date").focus('');
		  return false;
	  }
	  if(to_date == null || to_date == ""){
		  $("#to_dateError").html("Merit To Date is required.");
		  $("#to_dateError").css({"color": "red"}); 
		  $("#to_date").val('');
		  $("#to_date").focus(); 
		  return false;
	  }
	  
	  var caldate = $("#caldate").val();
	  if(caldate == null || caldate == ""){
		  $("#caldateError").html("Cal Date is required.");
		  $("#caldateError").css({"color": "red"}); $("#caldateError").val('');
		  $("#caldateError").focus(); return false;
	  }
	  
	  var latest = parseInt(response.length-1);
	  
	  if(latest < 0){
		  alert("latest=>if=>"+latest);  
		  
	  }else{
		  alert("latest=>else=>"+latest);
		  var latestBean = response[latest];
		  
		  if(latestBean.callDate > caldate){
			  $("#caldateError").html("Cal Date should not previous date of the before schedule entry.");
			  $("#caldateError").css({"color": "red"}); 
			  $("#caldate").val('');
			  $("#caldate").focus(); 
			  return false;
		  }
	  }
	  
	  
	  var callTime = $("#callTime").val();
	  if(callTime == null || callTime == ""){
		  $("#callTimeError").html("Cal Time is required.");
		  $("#callTimeError").css({"color": "red"}); $("#callTimeError").val('');
		  $("#callTimeError").focus(); return false;
	  }
	  
	
	  // txtInput 
	  var txtInput = $("#txtInput").val(); 
	  var mainCaptcha = $("#mainCaptcha").val();
	  if(txtInput == "" || txtInput == null){
		  $("#captchaErr").html("Captcha is required.");
		  $("#captchaErr").css({"color": "red"}); $("#txtInput").val('');
		  $("#txtInput").focus(); return false; } 
	  if(txtInput !== mainCaptcha){
			  $("#captchaErr").html("Given captcha is not matched.");
			  $("#captchaErr").css({"color": "red"}); $("#txtInput").val('');
			  $("#txtInput").focus(); return false; }
	  
	  sendDataDB();
	  
	  //return true;
	  
}
function sendDataDB(){
	//alert("sendDataDB"+jwtToken);
	
	var from_date = $("#from_date").val();
	var to_date = $("#to_date").val();
	var caldate = $("#caldate").val();
	var callTime = $("#callTime").val();
	
	var data = {};
	
	data['meritFrom'] = from_date;
	data['meritTo'] = to_date;
	data['callDate'] = caldate;
	data['callTime'] = callTime;
	data['distCode'] = insCode;
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/admissions/saveScheduleEntry',
		contentType: "application/json",
		data: JSON.stringify(data),
		headers:{
			'Authorization': jwtToken
		},
		cache: false,
		timeout: 600000,
		success: function(resp){
			//alert("success=resp=>"+JSON.stringify(resp));
			document.getElementById("successMsg").innerHTML = '';
			$("#successMsg").append('<h6 class="h6" style="color: green; font-size: 25px;">Schedule Entry saved Successfully !</h6>')
			
			$('#from_date').val('');
			$('#to_date').val('');
			$('#caldate').val('');
			$('#callTime').val('');
			$('#txtInput').val('');
			$("#from_date").prop('readonly', false);
			$("#from_date").prop('disabled', false);
			
			getScheduleEntryByDist();
			generateCaptcha();
			
		},
		error: function(resp){
			alert("error=resp=>"+JSON.stringify(resp));
		}
	});
}


function checkValue(a){
	document.getElementById(a).innerHTML = '';
}
