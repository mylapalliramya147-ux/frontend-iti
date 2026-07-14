/**
 * 
 */
let availableAdmissionPhaseData = null;
let jwtToken = null;
function checkToken(){
	jwtToken = "Bearer "+localStorage.getItem('jwtToken');
	//alert("jwtToken=>"+jwtToken);
	if(jwtToken == null || jwtToken == ""){
		$("#contentDiv").hide();
		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
	}else{
		changeValuesAsNull();
		$("#404Msg").hide();
		$("#updateButton").hide();
		
		var year = new Date().getFullYear();
		//alert("year=>"+year);
		$("#admYear").val(year);
		
		for(var i=1; i < 10; i++){
			$("#currentPhase").append('<option value="'+i+'">Phase - '+i+'</option>');
		}
		
		$("#itiTypeGDiv").hide();
		$("#itiTypePDiv").hide();
		
		getAdmissionPhaseData();
	}
	
}

function sendData(){
	validate();
}

function validate(){
	
	$("#mainError").html('');
	
	var currentPhase = $("#currentPhase").val();
	
	var applicationFromDate = $("#applicationFromDate").val();
	var applicationToDate = $("#applicationToDate").val();
	
	var verificationFromDate = $("#verificationFromDate").val();
	var verificationToDate = $("#verificationToDate").val();
	
	var meritListFromDate = $("#meritListFromDate").val();
	var meritListToDate = $("#meritListToDate").val();
	
	var admissionsGovtFromDate = $("#admissionsGovtFromDate").val();
	var admissionsGovtToDate = $("#admissionsGovtToDate").val();
	
	var admissionsPvtFromDate = $("#admissionsPvtFromDate").val();
	var admissionsPvtToDate = $("#admissionsPvtToDate").val();
	
	if(currentPhase == null || currentPhase == ''){
		$("#currentPhaseError").html('Phase is required');
		$("#currentPhaseError").css({"color":"red"});
		$("#currentPhase").val('');
		$("#currentPhase").focus();
		return false;
	}
	
	if(applicationFromDate == null || applicationFromDate == ''){
		$("#applicationFromDateError").html('Applications from date is required');
		$("#applicationFromDateError").css({"color":"red"});
		$("#applicationFromDate").val('');
		$("#applicationFromDate").focus();
		return false;
	}
	
	if(applicationToDate == null || applicationToDate == ''){
		$("#applicationToDateError").html('Applications To date is required');
		$("#applicationToDateError").css({"color":"red"});
		$("#applicationToDate").val('');
		$("#applicationToDate").focus();
		return false;
	}
	
	var convertedApplicationFromDate = new Date(applicationFromDate);
	var convertedApplicationToDate = new Date(applicationToDate);
	if(convertedApplicationFromDate > convertedApplicationToDate){
		//alert("pora puski");
		$("#mainError").html('Applications From Date should not be less than to Application To Date.');
		$("#mainError").css({"color":"red"});
		return false;
	}
	
	if(verificationFromDate == null || verificationFromDate == ''){
		$("#verificationFromDateError").html('Verification from date is required');
		$("#verificationFromDateError").css({"color":"red"});
		$("#verificationFromDate").val('');
		$("#verificationFromDate").focus();
		return false;
	}
	
	if(verificationToDate == null || verificationToDate == ''){
		$("#verificationToDateError").html('Verification To date is required');
		$("#verificationToDateError").css({"color":"red"});
		$("#verificationToDate").val('');
		$("#verificationToDate").focus();
		return false;
	}
	var convertedVerificationFromDate = new Date(verificationFromDate);
	var convertedVerificationToDate = new Date(verificationToDate);
	if(convertedVerificationFromDate > convertedVerificationToDate){
		//alert("pora puski");
		$("#mainError").html('Verification From Date should not be less than to Verification To Date.');
		$("#mainError").css({"color":"red"});
		return false;
	}
	
	if(meritListFromDate == null || meritListFromDate == ''){
		$("#meritListFromDateError").html('Merit List from date is required');
		$("#meritListFromDateError").css({"color":"red"});
		$("#meritListFromDate").val('');
		$("#meritListFromDate").focus();
		return false;
	}
	
	if(meritListToDate == null || meritListToDate == ''){
		$("#meritListToDateError").html('Merit List To date is required');
		$("#meritListToDateError").css({"color":"red"});
		$("#meritListToDate").val('');
		$("#meritListToDate").focus();
		return false;
	}
	var convertedMeritListFromDate = new Date(meritListFromDate);
	var convertedMeritListToDate = new Date(meritListToDate);
	if(convertedMeritListFromDate > convertedMeritListToDate){
		//alert("pora puski");
		$("#mainError").html('Merit List From Date should not be less than to Merit List To Date.');
		$("#mainError").css({"color":"red"});
		return false;
	}
	
	//Admissions dates
	if(currentPhase == 1){
		
		if(admissionsGovtFromDate == null || admissionsGovtFromDate == ''){
			$("#admissionsGovtFromDateError").html('Government Admissions From Date is required');
			$("#admissionsGovtFromDateError").css({"color":"red"});
			$("#admissionsGovtFromDate").val('');
			$("#admissionsGovtFromDate").focus();
			return false;
		}
		
		if(admissionsGovtToDate == null || admissionsGovtToDate == ''){
			$("#admissionsGovtToDateError").html('Government Admissions To date is required');
			$("#admissionsGovtToDateError").css({"color":"red"});
			$("#admissionsGovtToDate").val('');
			$("#admissionsGovtToDate").focus();
			return false;
		}
		var convertedAdmissionsGovtFromDate = new Date(admissionsGovtFromDate);
		var convertedAdmissionsGovtToDate = new Date(admissionsGovtToDate);
		if(convertedAdmissionsGovtFromDate > convertedAdmissionsGovtToDate){
			//alert("pora puski");
			$("#mainError").html('Government Admissions From Date should not be less than to Government Admissions To Date.');
			$("#mainError").css({"color":"red"});
			return false;
		}
	}
	
	if(currentPhase > 1){
		//Government
		
		if(admissionsGovtFromDate == null || admissionsGovtFromDate == ''){
			$("#admissionsGovtFromDateError").html('Government Admissions From Date is required');
			$("#admissionsGovtFromDateError").css({"color":"red"});
			$("#admissionsGovtFromDate").val('');
			$("#admissionsGovtFromDate").focus();
			return false;
		}
		if(admissionsGovtToDate == null || admissionsGovtToDate == ''){
			$("#admissionsGovtToDateError").html('Government Admissions To date is required');
			$("#admissionsGovtToDateError").css({"color":"red"});
			$("#admissionsGovtToDate").val('');
			$("#admissionsGovtToDate").focus();
			return false;
		}
		var convertedAdmissionsGovtFromDate = new Date(admissionsGovtFromDate);
		var convertedAdmissionsGovtToDate = new Date(admissionsGovtToDate);
		if(convertedAdmissionsGovtFromDate > convertedAdmissionsGovtToDate){
			$("#mainError").html('Government Admissions From Date should not be less than to Government Admissions To Date.');
			$("#mainError").css({"color":"red"});
			return false;
		}
		//Private
		if(admissionsPvtFromDate == null || admissionsPvtFromDate == ''){
			$("#admissionsPvtFromDateError").html('Prvate Admissions From Date is required');
			$("#admissionsPvtFromDateError").css({"color":"red"});
			$("#admissionsPvtFromDate").val('');
			$("#admissionsPvtFromDate").focus();
			return false;
		}
		
		if(admissionsPvtToDate == null || admissionsPvtToDate == ''){
			$("#admissionsPvtToDateError").html('Private Admissions To date is required');
			$("#admissionsPvtToDateError").css({"color":"red"});
			$("#admissionsPvtToDate").val('');
			$("#admissionsPvtToDate").focus();
			return false;
		}
		var convertedAdmissionsPvtFromDate = new Date(admissionsPvtFromDate);
		var convertedAdmissionsPvtToDate = new Date(admissionsPvtToDate);
		if(convertedAdmissionsPvtFromDate > convertedAdmissionsPvtToDate){
			//alert("pora puski");
			$("#mainError").html('Private Admissions From Date should not be less than to Private Admissions To Date.');
			$("#mainError").css({"color":"red"});
			return false;
		}
	}
	

	 sendDataTOApi();
	
}
function sendDataTOApi(){
	
	var admYear = $("#admYear").val();
	var currentPhase = $("#currentPhase").val();
	var applicationFromDate = $("#applicationFromDate").val();
	var applicationToDate = $("#applicationToDate").val();
	var verificationFromDate = $("#verificationFromDate").val();
	var verificationToDate = $("#verificationToDate").val();
	var meritListFromDate = $("#meritListFromDate").val();
	var meritListToDate = $("#meritListToDate").val();
	var itiTypeG = $("#itiTypeG").val();
	var admissionsGovtFromDate = $("#admissionsGovtFromDate").val();
	var admissionsGovtToDate = $("#admissionsGovtToDate").val();
	var itiTypeP = $("#itiTypeP").val();
	var admissionsPvtFromDate = $("#admissionsPvtFromDate").val();
	var admissionsPvtToDate = $("#admissionsPvtToDate").val();
	
	var data = {};
	
	data["admYear"] = admYear;
	data["currentPhase"] = currentPhase;
	
	data["applicationFromDate"] = applicationFromDate;
	data["applicationToDate"] = applicationToDate;
	
	data["verificationFromDate"] = verificationFromDate;
	data["verificationToDate"] = verificationToDate;
	
	data["meritListFromDate"] = meritListFromDate;
	data["meritListToDate"] = meritListToDate;
	
	data["itiTypeG"] = itiTypeG;
	data["admissionsGovtFromDate"] = admissionsGovtFromDate;
	data["admissionsGovtToDate"] = admissionsGovtToDate;
	
	data["itiTypeP"] = itiTypeP;
	data["admissionsPvtFromDate"] = admissionsPvtFromDate;
	data["admissionsPvtToDate"] = admissionsPvtToDate;
	
	$.ajax({
        type: "POST",
        contentType: "application/json",
        url: "http://10.72.4.135:8888/itiapi/admissions/saveAdmissionPhase",
        data: JSON.stringify(data),
    	headers:{
       		'Authorization': jwtToken
       	},
        cache: false,
        timeout: 600000,
        success: function (data) {
            //alert("sendData=>success" +data);
        	changeValuesAsNull();
        	 
        	$("#mainSuccessError").html(data);
 			$("#mainSuccessError").css({"color":"green"});
 			
 			getAdmissionPhaseData();
        },
        error: function (data) {
            //alert("Problem Accured While Saving Admission Initialization Entry Details");
            $("#mainError").html(data);
			$("#mainError").css({"color":"red"});
        }
    });
	
}

function getAdmissionPhaseData(){
	$("#admissionData").empty();
	$.ajax({
        type: "get",
        contentType: "application/json",
        url: "http://10.72.4.135:8888/itiapi/masterdata/getAdmissionPhaseData",
        cache: false,
        timeout: 600000,
        success: function (data) {
            //alert("sendData=>success" +JSON.stringify(data));
        	availableAdmissionPhaseData = data;
        	//alert("sendData=>success" +JSON.stringify(availableAdmissionPhaseData));
        	if(data.length == 0){
        		//alert("00000000000000000000000")
        		$("#admissionData").append('<tr>'
        				+'<td colspan="12" style="text-align: center;color:red;font-weight: bolder;">No Current Admission Phase Details are available.</td>'
        				+'</tr>');
        	}else{
        		 $("#admissionData").append('<tr>'
                 		
                 		+'<td>'+data.admYear+'</td>'
                 		+'<td>'+data.currentPhase+'</td>'
                 		
                 		+'<td>'+data.applicationFromDate+'</td>'
                 		+'<td>'+data.applicationToDate+'</td>'
                 		
                 		+'<td>'+data.verificationFromDate+'</td>'
                 		+'<td>'+data.verificationToDate+'</td>'
                 		
                 		+'<td>'+data.meritListFromDate+'</td>'
                 		+'<td>'+data.meritListToDate+'</td>'
                 		
                 		+'<td>'+data.admissionsGovtFromDate+'</td>'
                 		+'<td>'+data.admissionsGovtToDate+'</td>'
                 		
                 		+'<td>'+data.admissionsPvtFromDate+'</td>'
                 		+'<td>'+data.admissionsPvtToDate+'</td>'
                 		
                 		+'</tr>');
        		 $("#admissionData").append('<tr>'
         				+'<td colspan="12" style="text-align: center;"><button id="updatetableinput" class="btn btn-warning" onclick="return updateCurrentPhaseDetails()">Update</button></td>'
         				+'</tr>');
        	}
        },
        error: function (data) {
            //alert("Problem Accured While Saving Admission Initialization Entry Details");
        }
    });
}

function updateCurrentPhaseDetails(){
	//alert("updateCurrentPhaseDetails=>"+JSON.stringify(availableAdmissionPhaseData));
	
	$("#updatetableinput").hide();
	
	$("#pid").val(availableAdmissionPhaseData.pid);
	
	$("#admYear").val(availableAdmissionPhaseData.admYear);
	 $("#currentPhase").val(availableAdmissionPhaseData.currentPhase);
	 
	 $("#applicationFromDate").val(availableAdmissionPhaseData.applicationFromDate);
	 $("#applicationToDate").val(availableAdmissionPhaseData.applicationToDate);
	 
	 $("#verificationFromDate").val(availableAdmissionPhaseData.verificationFromDate);
	 $("#verificationToDate").val(availableAdmissionPhaseData.verificationToDate);
	 
	 $("#meritListFromDate").val(availableAdmissionPhaseData.meritListFromDate);
	 $("#meritListToDate").val(availableAdmissionPhaseData.meritListToDate);
	 
	 if(availableAdmissionPhaseData.currentPhase == 1){
		 $("#itiTypeGDiv").show();
		 $("#admissionsGovtFromDate").val(availableAdmissionPhaseData.admissionsGovtFromDate);
		 $("#admissionsGovtToDate").val(availableAdmissionPhaseData.admissionsGovtToDate);
		 
		 $("#itiTypePDiv").hide();
		 $("#admissionsPvtFromDate").val('');
		 $("#admissionsPvtToDate").val('');
	 }else{
		 $("#itiTypeGDiv").show();
		 $("#admissionsGovtFromDate").val(availableAdmissionPhaseData.admissionsGovtFromDate);
		 $("#admissionsGovtToDate").val(availableAdmissionPhaseData.admissionsGovtToDate);
		 
		 $("#itiTypePDiv").show();
		 $("#admissionsPvtFromDate").val(availableAdmissionPhaseData.admissionsPvtFromDate);
		 $("#admissionsPvtToDate").val(availableAdmissionPhaseData.admissionsPvtToDate);
	 }
	 $("#submitButton").hide();
	 $("#updateButton").show();
}

function changingPhase(value){ 
	//alert("value=>"+value);
	
	if(value == null || value == ''){
		$("#currentPhaseError").html('Phase is required');
		$("#currentPhaseError").css({"color":"red"});
		$("#currentPhase").val('');
		$("#currentPhase").focus();
		
		$("#itiTypeGDiv").hide();
		$("#itiTypePDiv").hide();
	}
	
	if(value == 1){ 
		 $("#itiTypeGDiv").show();
		 $("#admissionsGovtFromDate").val('');
		 $("#admissionsGovtToDate").val('');
		 
		 $("#itiTypePDiv").hide();
		 $("#admissionsPvtFromDate").val('');
		 $("#admissionsPvtToDate").val('');
	} 
	if(value > 1){ 
		 $("#itiTypeGDiv").show();
		 $("#admissionsGovtFromDate").val('');
		 $("#admissionsGovtToDate").val('');
		 
		 $("#itiTypePDiv").show();
		 $("#admissionsPvtFromDate").val('');
		 $("#admissionsPvtToDate").val(''); 
	} 
	
}
function updateData(){
	//alert("updateData");
	$("#mainError").html('');
	
	var pid = $("#pid").val();
	
	var currentPhase = $("#currentPhase").val();
	if(currentPhase == null || currentPhase == ''){
		$("#currentPhaseError").html('Phase is required');
		$("#currentPhaseError").css({"color":"red"});
		$("#currentPhase").val('');
		$("#currentPhase").focus();
		return false;
	}
	
	var applicationFromDate = $("#applicationFromDate").val();
	if(applicationFromDate == null || applicationFromDate == ''){
		$("#applicationFromDateError").html('Applications from date is required');
		$("#applicationFromDateError").css({"color":"red"});
		$("#applicationFromDate").val('');
		$("#applicationFromDate").focus();
		return false;
	}
	var applicationToDate = $("#applicationToDate").val();
	if(applicationToDate == null || applicationToDate == ''){
		$("#applicationToDateError").html('Applications To date is required');
		$("#applicationToDateError").css({"color":"red"});
		$("#applicationToDate").val('');
		$("#applicationToDate").focus();
		return false;
	}
	
	var convertedApplicationFromDate = new Date(applicationFromDate);
	var convertedApplicationToDate = new Date(applicationToDate);
	if(convertedApplicationFromDate > convertedApplicationToDate){
		//alert("pora puski");
		$("#mainError").html('Applications From Date should not be less than to Application To Date.');
		$("#mainError").css({"color":"red"});
		return false;
	}
	
	var verificationFromDate = $("#verificationFromDate").val();
	if(verificationFromDate == null || verificationFromDate == ''){
		$("#verificationFromDateError").html('Verification from date is required');
		$("#verificationFromDateError").css({"color":"red"});
		$("#verificationFromDate").val('');
		$("#verificationFromDate").focus();
		return false;
	}
	var verificationToDate = $("#verificationToDate").val();
	if(verificationToDate == null || verificationToDate == ''){
		$("#verificationToDateError").html('Verification To date is required');
		$("#verificationToDateError").css({"color":"red"});
		$("#verificationToDate").val('');
		$("#verificationToDate").focus();
		return false;
	}
	var convertedVerificationFromDate = new Date(verificationFromDate);
	var convertedVerificationToDate = new Date(verificationToDate);
	if(convertedVerificationFromDate > convertedVerificationToDate){
		//alert("pora puski");
		$("#mainError").html('Verification From Date should not be less than to Verification To Date.');
		$("#mainError").css({"color":"red"});
		return false;
	}
	
	var meritListFromDate = $("#meritListFromDate").val();
	if(meritListFromDate == null || meritListFromDate == ''){
		$("#meritListFromDateError").html('Merit List from date is required');
		$("#meritListFromDateError").css({"color":"red"});
		$("#meritListFromDate").val('');
		$("#meritListFromDate").focus();
		return false;
	}
	var meritListToDate = $("#meritListToDate").val();
	if(meritListToDate == null || meritListToDate == ''){
		$("#meritListToDateError").html('Merit List To date is required');
		$("#meritListToDateError").css({"color":"red"});
		$("#meritListToDate").val('');
		$("#meritListToDate").focus();
		return false;
	}
	var convertedMeritListFromDate = new Date(meritListFromDate);
	var convertedMeritListToDate = new Date(meritListToDate);
	if(convertedMeritListFromDate > convertedMeritListToDate){
		//alert("pora puski");
		$("#mainError").html('Merit List From Date should not be less than to Merit List To Date.');
		$("#mainError").css({"color":"red"});
		return false;
	}
	
	//Admissions dates
	if(currentPhase == 1){
		var admissionsGovtFromDate = $("#admissionsGovtFromDate").val();
		if(admissionsGovtFromDate == null || admissionsGovtFromDate == ''){
			$("#admissionsGovtFromDateError").html('Government Admissions From Date is required');
			$("#admissionsGovtFromDateError").css({"color":"red"});
			$("#admissionsGovtFromDate").val('');
			$("#admissionsGovtFromDate").focus();
			return false;
		}
		var admissionsGovtToDate = $("#admissionsGovtToDate").val();
		if(admissionsGovtToDate == null || admissionsGovtToDate == ''){
			$("#admissionsGovtToDateError").html('Government Admissions To date is required');
			$("#admissionsGovtToDateError").css({"color":"red"});
			$("#admissionsGovtToDate").val('');
			$("#admissionsGovtToDate").focus();
			return false;
		}
		var convertedAdmissionsGovtFromDate = new Date(admissionsGovtFromDate);
		var convertedAdmissionsGovtToDate = new Date(admissionsGovtToDate);
		if(convertedAdmissionsGovtFromDate > convertedAdmissionsGovtToDate){
			//alert("pora puski");
			$("#mainError").html('Government Admissions From Date should not be less than to Government Admissions To Date.');
			$("#mainError").css({"color":"red"});
			return false;
		}
	}
	
	if(currentPhase > 1){
		//Government
		var admissionsGovtFromDate = $("#admissionsGovtFromDate").val();
		if(admissionsGovtFromDate == null || admissionsGovtFromDate == ''){ 
			$("#admissionsGovtFromDateError").html('Government Admissions From Date is required');
			$("#admissionsGovtFromDateError").css({"color":"red"});
			$("#admissionsGovtFromDate").val('');
			$("#admissionsGovtFromDate").focus();
			return false;
		}
		var admissionsGovtToDate = $("#admissionsGovtToDate").val();
		if(admissionsGovtToDate == null || admissionsGovtToDate == ''){
			$("#admissionsGovtToDateError").html('Government Admissions To date is required');
			$("#admissionsGovtToDateError").css({"color":"red"});
			$("#admissionsGovtToDate").val('');
			$("#admissionsGovtToDate").focus();
			return false;
		}
		var convertedAdmissionsGovtFromDate = new Date(admissionsGovtFromDate);
		var convertedAdmissionsGovtToDate = new Date(admissionsGovtToDate);
		if(convertedAdmissionsGovtFromDate > convertedAdmissionsGovtToDate){
			$("#mainError").html('Government Admissions From Date should not be less than to Government Admissions To Date.');
			$("#mainError").css({"color":"red"});
			return false;
		}
		//Private
		var admissionsPvtFromDate = $("#admissionsPvtFromDate").val();
		if(admissionsPvtFromDate == null || admissionsPvtFromDate == ''){
			$("#admissionsPvtFromDateError").html('Prvate Admissions From Date is required');
			$("#admissionsPvtFromDateError").css({"color":"red"});
			$("#admissionsPvtFromDate").val('');
			$("#admissionsPvtFromDate").focus();
			return false;
		}
		var admissionsPvtToDate = $("#admissionsPvtToDate").val();
		if(admissionsPvtToDate == null || admissionsPvtToDate == ''){
			$("#admissionsPvtToDateError").html('Private Admissions To date is required');
			$("#admissionsPvtToDateError").css({"color":"red"});
			$("#admissionsPvtToDate").val('');
			$("#admissionsPvtToDate").focus();
			return false;
		}
		var convertedAdmissionsPvtFromDate = new Date(admissionsPvtFromDate);
		var convertedAdmissionsPvtToDate = new Date(admissionsPvtToDate);
		if(convertedAdmissionsPvtFromDate > convertedAdmissionsPvtToDate){
			//alert("pora puski");
			$("#mainError").html('Private Admissions From Date should not be less than to Private Admissions To Date.');
			$("#mainError").css({"color":"red"});
			return false;
		}
	}
	
	var data = {};
	
	data["pid"] = $("#pid").val();
	data["admYear"] = $("#admYear").val();
	data["currentPhase"] = $("#currentPhase").val();
	
	data["applicationFromDate"] = $("#applicationFromDate").val();
	data["applicationToDate"] = $("#applicationToDate").val();
	
	data["verificationFromDate"] = $("#verificationFromDate").val();
	data["verificationToDate"] = $("#verificationToDate").val();
	
	data["meritListFromDate"] = $("#meritListFromDate").val();
	data["meritListToDate"] = $("#meritListToDate").val();
	
	
	data["itiTypeG"] = $("#itiTypeG").val();
	data["admissionsGovtFromDate"] = $("#admissionsGovtFromDate").val();
	data["admissionsGovtToDate"] = $("#admissionsGovtToDate").val();
	
	data["itiTypeP"] = $("#itiTypeP").val();
	data["admissionsPvtFromDate"] = $("#admissionsPvtFromDate").val();;
	data["admissionsPvtToDate"] = $("#admissionsPvtToDate").val();
	
	//update ajax call
	$.ajax({
		type: 'POST',
		contentType: "application/json",
		url: 'http://10.72.4.135:8888/itiapi/admissions/updateAdmissionPhase',
		data: JSON.stringify(data),
		headers:{
       		'Authorization': jwtToken
       	},
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("success=>"+JSON.stringify(resp));
			$("#mainSuccessError").append(resp);
			getAdmissionPhaseData();
			changeValuesAsNull()
		},
		failure:function(resp){
			//alert("failure=>"+JSON.stringify(resp));
			$("#mainSuccessError").append(resp);
		}
	});
	
}

function checkValue(a){
	document.getElementById(a).innerHTML = '';
}

function changeValuesAsNull(){
	
	$("#pid").val('');
	 $("#currentPhase").val('');
	
	 $("#applicationFromDate").val('');
	 $("#applicationToDate").val('');
	
	 $("#verificationFromDate").val('');
	 $("#verificationToDate").val('');
	
	 $("#meritListFromDate").val('');
	 $("#meritListToDate").val('');
	
	 $("#admissionsGovtFromDate").val('');
	 $("#admissionsGovtToDate").val('');
	
	 $("#admissionsPvtFromDate").val('');
	 $("#admissionsPvtToDate").val('');
}
