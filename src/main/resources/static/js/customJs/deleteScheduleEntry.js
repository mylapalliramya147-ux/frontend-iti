let jwtToken = null;
let insCode = null;
let itis = null;




function getReady(){
	
	//alert("getReady");
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
		Street_name();
		getAdmissionPhaseData();
		
	}
}

//getAdmissionPhaseData
function getAdmissionPhaseData(){
	$.ajax({
		type: 'get',
		url: 'http://10.72.4.135:8888/itiapi/masterdata/getAdmissionPhaseData',
		cache: false,
		timeout: 600000,
		success: function(resp){
			//alert("success=>"+JSON.stringify(resp));
			
			if(resp.currentPhase == 1){
				//alert("phase1")	
				$("#addrs_district_p").val('G');
				document.getElementById('addrs_district_p').disabled=true;
				document.getElementById('addrs_mandal_p').disabled=true;
			}
			 
		},
		error: function(resp){
			alert("Error getting iti data");
		}
	});
}
 
function Street_name() {
    var dists = getDists(); // Assuming getDists() function is accessible from siteScript.js

    $("#addrs_state_p").empty();
	$("#addrs_state_p").append('<option value="all">--ALL--</option>');
    for (var i = 0; i < dists.length; i++) {
    	var bean = dists[i];
    	$("#addrs_state_p").append('<option value="'+bean.dist_code+'">'+bean.dist_name+'</option>');
    }
}

function getDistItis(a){
	//alert("getDistItis a=>"+a);
	
	var dist = $("#addrs_district_p").val();
	
	$.ajax({
		type: 'get',
		url: 'http://10.72.4.135:8888/itiapi/masterdata/getAllItisInDistandGovt?distCode='+a+'&govt='+dist,
		cache: false,
		timeout: 600000,
		success: function(resp){
			//alert("success=>"+JSON.stringify(resp));
			$("#addrs_mandal_p").empty();
			$("#addrs_mandal_p").append('<option value="all">--ALL--</option>');
			for(var i=0; i < resp.length; i++){
				var bean = resp[i];
				$("#addrs_mandal_p").append('<option value="'+bean.itiCode+'">'+bean.itiName+'('+bean.itiCode+')</option>');
				
			}
		},
		error: function(resp){
			alert("Error getting iti data");
		}
	});
}
 


function getColleges(a){
	//alert("a=>"+a);
	
	if(a == "" || a == null){
		document.getElementById('adddistrictError').innerHTML = 'Govt or Private anyone is mandatory for getting data';
		$("#addrs_district_p").focus();
		return false;
	}
	Street_name();
	
	$.ajax({
		type: 'get',
		url: 'http://10.72.4.135:8888/itiapi/masterdata/getAllItisGovtorPvt?itiType='+a,
		cache: false,
		timeout: 600000,
		success: function(resp){
			//alert("resp=>"+JSON.stringify(resp));
			$("#addrs_mandal_p").empty();
			$("#addrs_mandal_p").append('<option value="all">--ALL--</option>');
			for(var i=0; i < resp.length; i++){
				var bean = resp[i];
				$("#addrs_mandal_p").append('<option value="'+bean.itiCode+'">'+bean.itiName+'('+bean.itiCode+')</option>');
				
			}
		},
		error: function(resp){
			alert("error while getting itis data");
		}
	});
}

function getScheduleEntryByDistAndIti(){
	
	var govt = $("#addrs_district_p").val();
	var dist = $("#addrs_state_p").val();
	var iticode = $("#addrs_mandal_p").val();
	
	
	var data = {};
	data['distCode'] = dist;
	data['itiCode'] = iticode;
	data['itiType'] = govt;
	//alert("before calling"+jwtToken);
	
	$("#entryList").empty();
	
	$.ajax({
		type: 'POST',
		url:'http://10.72.4.135:8888/itiapi/admissions/getScheduleEntryByDistCodeAndItiCode',
		contentType: "application/json",
		data: JSON.stringify(data),
		headers:{
			'Authorization': jwtToken
		},
		cache: false,
		timeout: 600000,
		success:function(resp){
			
			//alert("success=>getScheduleEntryByDistAndIti=>"+JSON.stringify(resp));
			response = resp;
			//alert("lenth=>"+parseInt(resp.length-1));
		
				var count =0;
				var distName='';
				var itiName = '';
				
				for(var i=0; i<resp.length;i++){
					//alert(i);
		       		  count = count + 1;
		       		  var bean = resp[i];
		       		  
		       		distName = getDistName(bean.distCode);
		       		
		       		if(bean.itiCode == null || bean.itiCode == ''){
		       			itiName = '';
		       		}
		       		 
		       		  $("#entryList").append('<tr>'
		       				  +'<td>'+count+'</td>'
		       				  +'<td>'+distName+'</td>'
		       				  +'<td>'+itiName+'</td>'
		       				  +'<td>'+bean.meritFrom+'</td>'
		       				  +'<td>'+bean.meritTo+'</td>'
		       				  +'<td>'+bean.callDate+'</td>'
		       				  +'<td>'+bean.callTime+'</td>'
		       				  +'<td><a href="javascript:deleteScheduleEntry(\''+bean.sid+ '\')"><i class="fas fa-trash fa-2x pt-1"></i></a></td>'
		       				  +'</tr>');
		       	  }
				generateCaptcha();
				$("#txtInput").val('');
		},
		error:function(resp){
			alert("error=>getScheduleEntryByDistCode=>"+JSON.stringify(resp));
		}
	});
}




function validate() {
	
	//alert("Validate is working");
    // Validate District Name
	var addrs_district_p = $("#addrs_district_p").val();
	if(addrs_district_p == null || addrs_district_p == ""){
		document.getElementById('adddistrictError').innerHTML = 'Govt or Private anyone is mandatory for getting data';
		$("#addrs_district_p").focus();
		return false;
	}
	 
    // Validate Captcha
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

	  getScheduleEntryByDistAndIti();
}


function checkValue(a){
	document.getElementById(a).innerHTML = '';
}

function deleteScheduleEntry(a){
	//alert("deleteScheduleEntry"+a);
	
	if(confirm("are you sure about this deletion")){
		//alert("yea");
		
		var data = {};
		data['sid'] = a;
		
		$.ajax({
			type: 'POST',
			url:'http://10.72.4.135:8888/itiapi/admissions/deleteScheduleEntryById',
			contentType: "application/json",
			data: JSON.stringify(data),
			headers:{
				'Authorization': jwtToken
			},
			cache: false,
			timeout: 600000,
			success:function(resp){
				//alert("success=>getScheduleEntryByDistAndIti=>"+JSON.stringify(resp));
				document.getElementById('successMsg').innerHTML = '<h6 style="color: green;">'+resp+'</h6>';
				getScheduleEntryByDistAndIti();
			},
			error:function(resp){
				//alert("error=>getScheduleEntryByDistCode=>"+JSON.stringify(resp));
				document.getElementById('successMsg').innerHTML = '<h6 style="color: red;">'+resp+'</h6>';
			}
		});
		
	} 
}


