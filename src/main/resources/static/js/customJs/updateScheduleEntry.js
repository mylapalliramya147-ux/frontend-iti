let jwtToken = null;
let insCode = null;
let itis = null;




function getReady(){
	
	alert("getReady");
	jwtToken = localStorage.getItem('jwtToken');
	insCode =  localStorage.getItem('insCode');
	alert("jwtToken=>"+jwtToken);
	
	if(jwtToken == null || jwtToken == ""){
		$("#navbar").hide(); 
		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
	}else{
		//alert("else"+jwtToken);
		jwtToken = "Bearer "+jwtToken;
		//alert("assign=>"+jwtToken);
		$("#404Msg").hide(); 
		$("#navbar").show(); 
		
		
	}
	$.ajax({
		type: 'get',
		url: 'http://10.72.4.135:8888/itiapi/masterdata/getAllItis',
		cache: false,
		timeout: 6000000,
		success:function(resp){
			
			itis = resp;
		}
	});
}
function Street_name() {
    var dists = getDists(); // Assuming getDists() function is accessible from siteScript.js

    var selectElement = document.getElementById('addrs_state_p');

    for (var i = 0; i < dists.length; i++) {
        var option = document.createElement('option');
        option.value = dists[i].dist_code;
        option.textContent = dists[i].dist_name;
        selectElement.appendChild(option);
    }
}

// Call the function to populate the select element when the page loads
window.onload = function() {
	Street_name();
};


function getColleges(){
	//alert("resp=>"+JSON.stringify(itis));
	 var dist = document.getElementById('addrs_state_p').value;
	var govt=document.getElementById('addrs_district_p').value;
	var selectElement=document.getElementById('addrs_mandal_p');
	selectElement.innerHTML = '';
	selectElement.innerHTML='<option value="all">--ALL--</option>'
	alert("selectElement--->"+dist+"Type----->"+govt);
	 for (var i = 0; i < itis.length; i++) {
		 if(itis[i].distCode==dist && itis[i].govt==govt){
	        var option = document.createElement('option');
	        option.value = itis[i].itiCode;
	        option.textContent = itis[i].itiName;
	        selectElement.appendChild(option);
	    }
	 }
}


function getScheduleEntryByDistAndIti(){
	$("#entryList").empty();
	var data = {};
	data['distCode'] = insCode;
	data['itiCode'] = insCode;
	//alert("before calling"+jwtToken);
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
			
			 // Clear all input fields
		    $("#addrs_state_p").val("all");
		    $("#addrs_district_p").val("all");
		    $("#addrs_mandal_p").val("all");
		    $("#txtInput").val("");
		    $("#mainCaptcha").val("");
		    
			alert("success=>getScheduleEntryByDistAndIti=>"+JSON.stringify(resp));
			response = resp;
			//alert("lenth=>"+parseInt(resp.length-1));
			
		
				var count =0;
				for(var i=0; i<resp.length;i++){
					//alert(i);
		       		  count = count + 1;
		       		  var bean = resp[i];
		       		 
		       		  $("#entryList").append('<tr>'
		       				  +'<td>'+count+'</td>'
		       				  +'<td>'+bean.distCode+'</td>'
		       				  +'<td>'+bean.itiCode+'</td>'
		       				  +'<td>'+bean.meritFrom+'</td>'
		       				  +'<td>'+bean.meritTo+'</td>'
		       				  +'<td>'+bean.callDate+'</td>'
		       				  +'<td>'+bean.callTime+'</td>'
		       				  +'</tr>');
		       	  }
			
		},
		error:function(resp){
			alert("error=>getScheduleEntryByDistCode=>"+JSON.stringify(resp));
		}
	});
}




function validate() {
	
	alert("Validate is working");
    // Validate District Name
	
	var districtName = document.getElementById('addrs_state_p').value;
	var districtError = document.getElementById('districtError');

	if (districtName === 'all') {
	    districtError.textContent = 'Please select a district.';
	    $("#districtError").css({"color": "red"});
	} else {
	    districtError.textContent = ''; // Clear error message
	}


	// Validate Government/Private Type
	var govtPrivateSelect = document.getElementById('addrs_district_p').value;
	var adddistrictError = document.getElementById('adddistrictError');

	if (govtPrivateSelect === 'all') {
	    adddistrictError.textContent = 'Please select Government or Private.';
	    $("#adddistrictError").css({"color": "red"});
	} else {
	    adddistrictError.textContent = ''; // Clear error message
	}

    // Validate ITI Name
	var itiSelect = document.getElementById('addrs_mandal_p').value;
	var itiError = document.getElementById('itiError');

	if (itiSelect === 'all') {
	    itiError.textContent = 'Please select a valid ITI Name.';
	    $("#itiError").css({"color": "red"});
	} else {
	    itiError.textContent = ''; // Clear error message
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
    // If all validations pass, return true to submit the form
    return true;
}


function checkValue(a){
	document.getElementById(a).innerHTML = '';
}


