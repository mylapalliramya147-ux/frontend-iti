/**
 * 
 */
let jwtToken = null;
let insCode = null;

let getSSCBoards = null;
let getCastes = null;

let admissionPhaseData = null;


function getReady(){
	//alert("getReady");
	getAdmissionPhaseData();
	
	jwtToken = localStorage.getItem('jwtToken');
	insCode =  localStorage.getItem('insCode');
	//alert("jwtToken=>"+jwtToken);
	
	if(jwtToken == null || jwtToken == ""){
		$("#contentDiv").hide();
		
		$("#navbar").hide(); 
		$("#formTwo").hide(); 
		$("#admYearPhaseDiv").hide(); 
		
		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
	}else{
		//alert("else");
		jwtToken = "Bearer "+jwtToken;
		$("#404Msg").hide(); 
		$("#navbar").show(); 
		$("#formTwo").hide(); 
		$("#admYearPhaseDiv").hide(); 
		$("#printOptions").hide(); 
		
		getAllSSCBoards(function(boards) {
			getSSCBoards = boards;
			getAllCastes(function(castes) {
				getCastes = castes;
				getDistVerificationList(insCode);
			});
		});
		
	}
}

function getDistVerificationList(insCode){
	//alert("getDistVerificationList=>"+insCode);
	
	$.ajax({
		type: 'get',
		url: 'http://10.72.4.135:8888/itiapi/masterdata/getDistVerificationList?dist_code='+insCode,
		contentType: 'application/json',
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("success resp=>"+JSON.stringify(resp));
			
			$("#verificationList").empty();
			
			var count =0;
			
			for(var j=0; j < resp.length; j++){
				
				count = count + 1;
				
				var bean = resp[j];
				
				var app_statuss = bean.app_status;
				var reverify = '';
				if(app_statuss == null || app_statuss == ""){ 
					app_statuss = '<a href="javascript:editApplication(\''+bean.ssc_regno+'\',\''+bean.regid+'\',\''+bean.dob+'\')">VERIFY</a>'; 
				}
				if(app_statuss == 'A'){ 
					app_statuss = 'APPROVED';
					reverify = '<a href="javascript:editApplication(\''+bean.ssc_regno+'\',\''+bean.regid+'\',\''+bean.dob+'\')">RE-VERIFY</a>'; 
				}
				if(app_statuss == 'R'){ 
					app_statuss = 'REJECTED'; 
					reverify = '<a href="javascript:editApplication(\''+bean.ssc_regno+'\',\''+bean.regid+'\',\''+bean.dob+'\')">RE-VERIFY</a>'; 
				} 
				 
				
				var user_idd = bean.user_id;
				if(user_idd == null || user_idd == ""){ user_idd = ''; }
				
				var verified_datee = bean.verified_date;
				if(verified_datee == null || verified_datee == ""){ verified_datee = ''; }
				
				
				
				$("#verificationList").append('<tr>'
						+'<td>'+count+'</td>'
						+'<td>'+bean.regid+'</td>'
						+'<td>'+bean.name+'</td>'
						+'<td>'+bean.fname+'</td>'
						+'<td>'+user_idd+'</td>'
						+'<td>'+verified_datee+'</td>'
						+'<td style="text-align: center;font-weight: bolder;">'+app_statuss+'</td>'
						+'<td style="text-align: center;font-weight: bolder;">'+reverify+'</td>'
						+'</tr>');
			}
		},
		error:function(resp){
			//alert("error resp=>"+JSON.stringify(resp));
			alert("Something went wrong getting verification list");
		}
		
	});
	
}

function getCandidateAppliedDetails(a){
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/std/getCandidateAppliedDetails?regid='+a,
		contentType: 'application/json',
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("success resp=>"+JSON.stringify(resp));
			$("#selectedDists").empty();
			
			for(var l=0; l < resp.length; l++){
				var bean = resp[l];
				const sno = l+1;
				var distname = getDistName(bean.distCode);
				
				$("#selectedDists").append('<tr>' 
						+'<td>'+sno+'</td>'
						+'<td>'+distname+'</td>'
						+'</tr>');
			}
			 
		},
		error:function(resp){
			//alert("error resp=>"+JSON.stringify(resp));
			alert("Something went wrong while get candidate applied details");
		}
		
	});
}

function editApplication(ssc_regno,regid,dob){
	//alert("editApplication=>ssc_regno=>"+ssc_regno);
	//alert("editApplication=>regid=>"+regid);
	//alert("editApplication=>dob=>"+dob);
	$("#formthree").hide();
	
	
	var convertedDate = changeDateFormat(dob);
	//alert("editApplication=>convertedDate=>"+convertedDate);
	
	 
	 
	
	//check the registration
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/std/checkRegOrNot?sscRegno='+ssc_regno+'&regid='+regid+'&dob='+convertedDate,
		cache: false,
		timeout: 6000000,
		success:function(resp){
			//alert("resp=>"+JSON.stringify(resp));
			
			$("#regidd").val(resp.studentApplication.regid);
			$("#dobPrint").val(convertedDate);
			$("#ssc_regnoPrint").val(resp.studentApplication.sscRegno);
			
			document.getElementById('admYearPhase').innerHTML = admissionPhaseData.admYear+' & Phase-'+admissionPhaseData.currentPhase;
			
			$("#imageContainer").empty();
			$("#contentDiv").hide();
			$("#formTwo").show();
			$("#admYearPhaseDiv").show();
			
			$("#ssc_board").empty();
			$("#ssc_board").append('<option value="">-select-</option>');
			for(var i=0; i < getSSCBoards.length; i++){
				var bean = getSSCBoards[i];
			//	alert(bean)
				$("#ssc_board").append('<option value="'+bean.boardCode+'">'+bean.boardName+'</option>');
			}
			
			
			document.getElementById('ssc_regno').value = resp.studentApplication.sscRegno;
			$('#ssc_board').val(resp.studentApplication.sscBoard);
			document.getElementById('ssc_year').value = resp.studentApplication.sscYear;
			$('#ssc_month').val(resp.studentApplication.sscMonth);
			document.getElementById('name').value = resp.studentApplication.name;
			document.getElementById('phno').value = resp.studentApplication.phno;
			$('#dob').val(resp.studentApplication.dob);
			document.getElementById('adarno').value = resp.studentApplication.adarno;
			document.getElementById('gen').value = resp.studentApplication.gender;
			
			$("#caste").empty();
			$("#caste").append('<option value="">-select-</option>');
			for(var i=0; i < getCastes.length; i++){
				var bean = getCastes[i];
				$("#caste").append('<option value="'+bean.category_code+'">'+bean.category_name+'</option>');
			}
			$('#caste').val(resp.studentApplication.caste); 
			document.getElementById('fname').value = resp.studentApplication.fname;
			document.getElementById('mname').value = resp.studentApplication.mname;
			document.getElementById('phc').value = resp.studentApplication.phc;
			document.getElementById('pwd_category').value = resp.studentApplication.pwdCategory;
			document.getElementById('exs').value = resp.studentApplication.exservice;
			document.getElementById('ssc').value = resp.studentApplication.sscPassed;
			document.getElementById('loconoc').value = resp.studentApplication.local;
			document.getElementById('pincode').value = resp.studentApplication.pincode;
			document.getElementById('email').value = resp.studentApplication.email;
			document.getElementById('addr').value = resp.studentApplication.addr;
			document.getElementById('ews').value = resp.studentApplication.economicWeakerSection;
			
			$("#ssc_type").val(resp.studentApplication.sscType);
			$("#noOfLangs").val(resp.studentApplication.noOfLangs);
			
			var sscType = $("#ssc_type").val();
			var noOfLangs = $("#noOfLangs").val();
			
			if(noOfLangs == '2'){
				$("#sllabel").hide();
				$("#second_lang").val('');
			}
			
			if(sscType == 'sscm'){
				document.getElementById('first_lang').value = resp.studentCandMarksEntity.ssc_first_lang_marks;
				document.getElementById('second_lang').value = resp.studentCandMarksEntity.ssc_second_lang_marks;
				document.getElementById('third_lang').value = resp.studentCandMarksEntity.ssc_eng_marks;
				document.getElementById('maths').value = resp.studentCandMarksEntity.ssc_math_marks;
				document.getElementById('science').value = resp.studentCandMarksEntity.ssc_sci_marks;
				document.getElementById('social').value = resp.studentCandMarksEntity.ssc_social_marks;
			}else{
				document.getElementById('first_lang').value = resp.studentCandMarksEntity.ssc_first_lang_gpa;
				document.getElementById('second_lang').value = resp.studentCandMarksEntity.ssc_second_lang_gpa;
				document.getElementById('third_lang').value = resp.studentCandMarksEntity.ssc_eng_gpa;
				document.getElementById('maths').value = resp.studentCandMarksEntity.ssc_math_gpa;
				document.getElementById('science').value = resp.studentCandMarksEntity.ssc_sci_gpa;
				document.getElementById('social').value = resp.studentCandMarksEntity.ssc_social_gpa;
			}
			$("#oldImage").val(resp.imageCandPhotosEntity.image);
			// Create an img element
		    var imgElement = document.createElement("img");
		    imgElement.src = 'data:image/png;base64,'+resp.imageCandPhotosEntity.image;

		    // Set other attributes as needed (e.g., width, height)
		    imgElement.width = 300;
		    imgElement.height = 200;

		    // Append the img element to the image container
		    document.getElementById("imageContainer").appendChild(imgElement);
		    
	        getCandidateAppliedDetails(resp.studentApplication.regid);
			 
		},
		error:function(resp){
			//alert(JSON.stringify(resp));
			//$("#errorMsg").append('<h3 class="h3 text-danger">'+resp.responseText+'</h3>')
		}
	});
	
	
}

function getAdmissionPhaseData(){
	$.ajax({
        type: "get",
        contentType: "application/json",
        url: "http://10.72.4.135:8888/itiapi/masterdata/getAdmissionPhaseData",
        cache: false,
        timeout: 600000,
        success: function (data) {
          //  alert("sendData=>success" +JSON.stringify(data));
            admissionPhaseData = data;
        },
        error: function (data) {
            //alert("Problem Accured While Saving Admission Initialization Entry Details");
        }
    });
}

function convertToUppercase(inputElement) {
    // Get the input value and convert it to uppercase
    var inputValue = inputElement.value;
    var uppercaseValue = inputValue.toUpperCase();

    // Update the input field with the uppercase value
    inputElement.value = uppercaseValue;
}

function ssctype(ssc_type){
	marksvaluesnull();
	$("#marksrow").hide();
	$("#noOfLangs").val('');
	if(ssc_type == "" || ssc_type == null){ 
		$("#ssc_typeError").html("SSC Marks Type is required please enter."); 
		$("#ssc_typeError").css({"color": "red"}); 
		$("#ssc_type").focus(); 
		return false; 
	}
}

function marksvaluesnull(){
	$("#first_lang").val('');
	$("#second_lang").val('');
	$("#third_lang").val('');
	$("#maths").val('');
	$("#science").val('');
	$("#social").val('');
	
	$("#first_langError").val('');
	$("#second_langError").val('');
	$("#third_langError").val('');
	$("#mathsError").val('');
	$("#scienceError").val('');
	$("#socialError").val('');
}

function valuesAsNull(){
	$("#ssc_regno").val('');
	$("#ssc_board").val('');
	$("#ssc_year").val('');
	$("#ssc_month").val('');
	$("#name").val('');
	$("#phno").val('');
	$("#dob").val('');
	$("#adarno").val('');
	$("#gen").val('');
	$("#caste").val('');
	$("#fname").val('');
	$("#mname").val('');
	$("#phc").val('');
	$("#pwd_category").val('');
	$("#exs").val('');
	$("#ssc").val('');
	$("#loconoc").val('');
	$("#pincode").val('');
	$("#email").val('');
	$("#ews").val('');
	$("#addr").val('');
	$("#ssc_type").val('');
	$("#noOfLangs").val('');
	$("#first_lang").val('');
	$("#second_lang").val('');
	$("#third_lang").val('');
	$("#maths").val('');
	$("#science").val('');
	$("#social").val('');
	$("#photo").val('');
	$("#base64Image").val('');
	$("#oldImage").val('');
	
	var valueToCheck = "NA";
	
    var ssc_eqRadioButtons = document.querySelectorAll('input[name="ssc_eq"]');
    ssc_eqRadioButtons.forEach(function(ssc_eqRadioButton) {
        if (ssc_eqRadioButton.value === valueToCheck) {
        	ssc_eqRadioButton.checked = true; 
        }
    });
	
    var tcRadioButtons = document.querySelectorAll('input[name="tc"]');
    tcRadioButtons.forEach(function(tcRadioButton) {
    	if (tcRadioButton.value === valueToCheck) {
    		tcRadioButton.checked = true; 
    	}
    });
    
    var ccRadioButtons = document.querySelectorAll('input[name="cc"]');
    ccRadioButtons.forEach(function(ccRadioButton) {
    	if (ccRadioButton.value === valueToCheck) {
    		ccRadioButton.checked = true; 
    	}
    });
    
    var pcRadioButtons = document.querySelectorAll('input[name="pc"]');
    pcRadioButtons.forEach(function(pcRadioButton) {
    	if (pcRadioButton.value === valueToCheck) {
    		pcRadioButton.checked = true; 
    	}
    });
    
    var exsvRadioButtons = document.querySelectorAll('input[name="exsv"]');
    exsvRadioButtons.forEach(function(exsvRadioButton) {
    	if (exsvRadioButton.value === valueToCheck) {
    		exsvRadioButton.checked = true; 
    	}
    });
    
    var scRadioButtons = document.querySelectorAll('input[name="sc"]');
    scRadioButtons.forEach(function(scRadioButton) {
    	if (scRadioButton.value === valueToCheck) {
    		scRadioButton.checked = true; 
    	}
    });
    
    var ncRadioButtons = document.querySelectorAll('input[name="nc"]');
    ncRadioButtons.forEach(function(ncRadioButton) {
    	if (ncRadioButton.value === valueToCheck) {
    		ncRadioButton.checked = true; 
    	}
    });
    
    var uidvRadioButtons = document.querySelectorAll('input[name="uidv"]');
    uidvRadioButtons.forEach(function(uidvRadioButton) {
    	if (uidvRadioButton.value === valueToCheck) {
    		uidvRadioButton.checked = true; 
    	}
    });
    
    var ewsvRadioButtons = document.querySelectorAll('input[name="ewsv"]');
    ewsvRadioButtons.forEach(function(ewsvRadioButton) {
    	if (ewsvRadioButton.value === valueToCheck) {
    		ewsvRadioButton.checked = true; 
    	}
    });
    
    $("#selectedDists").empty();
    $("#rejectReason").val('');
    $("#rejError").empty('');
}




function marksdiv(value){
	//alert("marksdiv "+value);
	marksvaluesnull();
	
	var ssc_type = $("#ssc_type").val(); 
	if(ssc_type == "" || ssc_type == null){ $("#ssc_typeError").html("SSC Marks Type is required please enter."); $("#ssc_typeError").css({"color": "red"}); $("#ssc_type").focus(); return false; }
	
	if(value == "" || value == null){
		$("#marksrow").hide();
		$("#noOfLangsError").html("Number of Languages is required please enter."); 
		$("#noOfLangsError").css({"color": "red"}); 
		$("#noOfLangs").focus(); 
		return false; 
	}else{
		$("#marksrow").show();
		if(value == '2'){
			$("#sllabel").hide();
			$("#second_lang").val('');
		}else{
			$("#sllabel").show();
			$("#second_lang").val('');
		}
		
		
	}
	
}


function rejectData(){
	//alert("working");
	
	$("#formthree").show();
	$("#approveButton").hide();
	
	var ssc_regno = $("#ssc_regno").val();
	var rejectReason = $("#rejectReason").val();
	
//	alert("ssc_regno=>"+ssc_regno)
//	alert("insCode=>"+insCode)
//	alert("rejectReason=>"+rejectReason)
	
	if(rejectReason == null || rejectReason == ''){
	$("#rejError").html("Please mention reason for Rejecting this Canidate"); 
		$("#rejError").css({"color": "red"});
		return false;
	}else{
		//alert("else");
		var data = {};
		
		data['sscRegno'] = ssc_regno;
		data['rejectedBy'] = insCode;
		data['rejectedReason'] =  rejectReason;
		data['action'] = 'reject';
		
		$.ajax({
			type: 'post',
			contentType: 'application/json',
			data: JSON.stringify(data),
			headers:{
	       		'Authorization': jwtToken
	       	},
			url: "http://10.72.4.135:8888/itiapi/admissions/verificationRejection",
			cache: false,
			timeout: 600000,
			success:function(resp){
				//alert("success=>"+resp);
				
				 document.getElementById("verificationSuccessMsg").innerHTML=resp;
				 $("#verificationSuccessMsg").css({'color': 'green'});
				 $("#404Msg").hide(); 
					$("#navbar").show(); 
					$("#formTwo").hide(); 
					$("#admYearPhaseDiv").hide(); 
					$("#contentDiv").show(); 
					$("#approveButton").show(); 
					
					getSSCBoards = getAllSSCBoards();
					getCastes = getAllCastes();
					getDistVerificationList(insCode);
					
					valuesAsNull();
			},
			error:function(resp){
				//alert("error=>"+JSON.stringify(resp));
				$("#serverResponse").html(resp.responseText);
				$("#serverResponse").css({'color': 'red'});
				return false;
			}
		});
	}
	
	
	 
	 
}






function checkValue(a){
	document.getElementById(a).innerHTML = '';
	}
function approveData(){
	//alert("sendData");
	
	
	$("#rejectButton").hide();
	
	var ssc_board = document.getElementById("ssc_board").value;
	if(ssc_board == "" || ssc_board == null){ 
		$("#ssc_boardError").html("SSC/8th Board is required please choose one."); $("#ssc_boardError").css({"color": "red"}); 
		$("#ssc_board").val(''); $("#ssc_board").focus(); return false; }
	
	var ssc_year = document.getElementById("ssc_year").value;
	if(ssc_year == "" || ssc_year == null){ 
		$("#ssc_yearError").html("Year Of Passing is required please enter."); $("#ssc_yearError").css({"color": "red"});
		$("#ssc_year").val(''); $("#ssc_year").focus(); return false; }
	if (!ssc_year.match('^[0-9 ]{4}$')) { 
		$("#ssc_yearError").html("Year Of Passing is in invalid format."); $("#ssc_yearError").css({"color": "red"}); 
		$("#ssc_year").val(''); $("#ssc_year").focus(); return false; }
	
	var ssc_month = document.getElementById("ssc_month").value;
	if(ssc_month == "" || ssc_month == null){ 
		$("#ssc_monthError").html("Month of Pass is required please enter."); $("#ssc_monthError").css({"color": "red"}); 
		$("#ssc_month").val(''); $("#ssc_month").focus(); return false; }
	if(ssc_month !== "3" && ssc_month !== "4") { 
		$("#ssc_monthError").html("Month of Pass is in invalid format."); $("#ssc_monthError").css({"color": "red"}); 
		$("#ssc_month").val(''); $("#ssc_month").focus(); return false; }
	
	var name = document.getElementById("name").value;
	if(name == "" || name == null){ 
		$("#nameError").html("Applicants Name is required please enter."); $("#nameError").css({"color": "red"}); 
		$("#name").val(''); $("#name").focus(); return false; }
	if (!name.match('^[A-Za-z ]{3,50}$')) { 
		$("#nameError").html("Applicants Name is in invalid format."); $("#nameError").css({"color": "red"}); 
		$("#name").val(''); $("#name").focus(); return false; }
	var phno = document.getElementById("phno").value;
	if(phno == "" || phno == null){ 
		$("#phnoError").html("Mobile Number is required please enter."); $("#phnoError").css({"color": "red"}); 
		$("#phno").val(''); $("#phno").focus(); return false; }
	if (!phno.match('^[0-9]{10}$')) { 
		$("#phnoError").html("Mobile Number is in invalid format."); $("#phnoError").css({"color": "red"}); 
		$("#phno").val(''); $("#phno").focus(); return false; }
	
	var dob = document.getElementById("dob").value;
	//alert(dob)
	if(dob == "" || dob == null){ 
		$("#dobError").html("Date of Birth is required please enter."); $("#dobError").css({"color": "red"}); 
		$("#dob").val(''); $("#dob").focus(); return false; }
	
	var adarno = document.getElementById("adarno").value;
	if(adarno == "" || adarno == null){ 
		$("#adarnoError").html("Aadhar Card Number is required please enter."); $("#adarnoError").css({"color": "red"}); 
		$("#adarno").val(''); $("#adarno").focus(); return false; }
	if (!adarno.match('^[0-9]{12}$')) { 
		$("#adarnoError").html("Aadhar Card Number is in invalid format."); $("#adarnoError").css({"color": "red"}); 
		$("#adarno").val(''); $("#adarno").focus(); return false; }
	
	var gen = document.getElementById("gen").value;
	if(gen == "" || gen == null){ 
		$("#genError").html("Gender is required please enter."); $("#genError").css({"color": "red"}); 
		$("#gen").val(''); $("#gen").focus(); return false; }
	if(gen !== "male" && gen !== "female") { 
		$("#genError").html("Gender is in invalid format."); $("#genError").css({"color": "red"}); 
		$("#gen").val(''); $("#gen").focus(); return false; }
	
	var caste = document.getElementById("caste").value;
	if(caste == "" || caste == null){ 
		$("#casteError").html("Category is required please enter."); $("#casteError").css({"color": "red"}); 
		$("#caste").val(''); $("#caste").focus(); return false; }
	
	var fname = document.getElementById("fname").value;
	if(fname == "" || fname == null){ 
		$("#fnameError").html("Father Name is required please enter."); $("#fnameError").css({"color": "red"}); 
		$("#fname").val(''); $("#fname").focus(); return false; }
	if (!fname.match('^[A-Za-z ]{3,50}$')) { 
		$("#fnameError").html("Father Name is in invalid format."); $("#fnameError").css({"color": "red"}); 
		$("#fname").val(''); $("#fname").focus(); return false; }
	
	var mname = document.getElementById("mname").value;
	if(mname == "" || mname == null){ 
		$("#mnameError").html("Mother Name is required please enter."); $("#mnameError").css({"color": "red"}); 
		$("#mname").val(''); $("#mname").focus(); return false; }
	if (!mname.match('^[A-Za-z ]{3,50}$')) { 
		$("#mnameError").html("Mother Name is in invalid format."); $("#mnameError").css({"color": "red"}); 
		$("#mname").val(''); $("#mname").focus(); return false; }
	
	var phc = document.getElementById("phc").value;
	if(phc == "" || phc == null){ 
		$("#phcError").html("Physically Challenged is required please enter."); $("#phcError").css({"color": "red"}); 
		$("#phc").val(''); $("#phc").focus(); return false; }
	
	var pwd_category = '0';
	if(phc == 'true'){
		pwd_category = $("#pwd_category").val();
		if(pwd_category == "0"){ 
			$("#pwd_categoryError").html("PWD Category is required please enter."); $("#pwd_categoryError").css({"color": "red"}); 
			$("#pwd_category").val('0'); $("#pwd_category").focus(); return false; }
	} 
	
	var exs = $("#exs").val();
	if(exs == "" || exs == null){ 
		$("#exsError").html("Ex-Servicemen is required please enter."); $("#exsError").css({"color": "red"}); 
		$("#exs").val(''); $("#exs").focus(); return false; }
	
	var ssc = $("#ssc").val();
	if(ssc == "" || ssc == null){ 
		$("#sscError").html("Qualification is required please enter."); $("#sscError").css({"color": "red"}); 
		$("#ssc").val(''); $("#ssc").focus(); return false; }
	
	var loconoc = $("#loconoc").val();
	if(loconoc == "" || loconoc == null){ 
		$("#loconocError").html("Local/Non Local is required please enter."); $("#loconocError").css({"color": "red"}); 
		$("#loconoc").val(''); $("#loconoc").focus(); return false; }
	
	var pincode = $("#pincode").val();
	if(pincode == "" || pincode == null){ 
		$("#pincodeError").html("Pincode is required please enter."); $("#pincodeError").css({"color": "red"}); 
		$("#pincode").val(''); $("#pincode").focus(); return false; }
	if (!pincode.match('^[0-9]{6}$')) { 
		$("#pincodeError").html("Pincode is in invalid format."); $("#pincodeError").css({"color": "red"}); 
		$("#pincode").val(''); $("#pincode").focus(); return false; }
	
	var email = $("#email").val(); 
	if(email == "" || email == null){ 
		$("#emailError").html("E-Mail is required please enter."); $("#emailError").css({"color": "red"}); 
		$("#email").val(''); $("#email").focus(); return false; }
	 var filter = /^([\w-\.]+@(gmail.com|yahoo.com|hotmail.com|yahoo.co.in|ap.nic.in|nic.in|gov.in|ap.gov.in))?$/;
     if (!filter.test(email)) {
    	 $("#emailError").html("Invalid E-Mail ID format."); $("#emailError").css({"color": "red"}); 
			$("#email").val(''); $("#email").focus(); return false; 
         return false;
     }
     
     var ews = $("#ews").val();   
		if(ews == "" || ews == null){ 
			$("#ewsError").html("Economic Weaker Section is required please enter."); $("#ewsError").css({"color": "red"}); 
			$("#ews").val(''); $("#ews").focus(); return false; }
		
		var addr =  $("#addr").val(); 
		if(addr == "" || addr == null){ 
			$("#addrError").html("Address is required please enter."); $("#addrError").css({"color": "red"}); 
			$("#addr").val(''); $("#addr").focus(); return false; }
		
		var ssc_type = $("#ssc_type").val(); 
		if(ssc_type == "" || ssc_type == null){ 
			$("#ssc_typeError").html("SSC Marks Type is required please enter."); $("#ssc_typeError").css({"color": "red"}); 
			$("#ssc_type").val(''); $("#ssc_type").focus(); return false; }
		
		var noOfLangs = $("#noOfLangs").val();
		if(noOfLangs == "" || noOfLangs == null){ 
			$("#noOfLangsError").html("Number of Languages is required please enter."); $("#noOfLangsError").css({"color": "red"}); 
			$("#noOfLangs").val(''); $("#noOfLangs").focus(); return false; }
		
		var first_lang = $("#first_lang").val();
		var second_lang = $("#second_lang").val();
		var third_lang = $("#third_lang").val();
		var maths = $("#maths").val();
		var science = $("#science").val();
		var social = $("#social").val();
		
		if(ssc_type == 'sscm'){
			
			if(first_lang == "" || first_lang == null){ 
				$("#first_langError").html("First language marks are required please enter."); $("#first_langError").css({"color": "red"}); 
				$("#first_lang").val(''); $("#first_lang").focus(); return false; }
			if (!first_lang.match('^[0-9]{1,3}$')) { 
				$("#first_langError").html("First Lang marks should be in range 1-100, numeric only."); $("#first_langError").css({"color": "red"}); 
				$("#first_lang").val(''); $("#first_lang").focus(); return false; }
			if(first_lang < 0 || first_lang > 100){
				$("#first_langError").html("First Lang marks should be in range 1-100, numeric only."); $("#first_langError").css({"color": "red"}); 
				$("#first_lang").val(''); $("#first_lang").focus(); return false; }
			
			if(noOfLangs == '3'){
				if(second_lang == "" || second_lang == null){ 
					$("#second_langError").html("Second Language marks are required please enter."); $("#second_langError").css({"color": "red"}); 
					$("#second_lang").val(''); $("#second_lang").focus(); return false; }
				if (!second_lang.match('^[0-9]{1,3}$')) { 
					$("#second_langError").html("Second Lang marks should be in range 1-100, numeric only."); $("#second_langError").css({"color": "red"}); 
					$("#second_lang").val(''); $("#second_lang").focus(); return false; }
				if(second_lang < 0 || second_lang > 100){
					$("#second_langError").html("First Lang marks should be in range 1-100, numeric only."); $("#second_langError").css({"color": "red"}); 
					$("#second_lang").val(''); $("#second_lang").focus(); return false; }
				
			}else{
				$("#second_lang").val('0');
			}
			
			if(third_lang == "" || third_lang == null){ 
				$("#third_langError").html("Third Language- English marks are required please enter."); $("#third_langError").css({"color": "red"}); 
				$("#third_lang").val(''); $("#third_lang").focus(); return false; }
			if (!third_lang.match('^[0-9]{1,3}$')) { 
				$("#third_langError").html("Third Language- English marks should be in range 1-100, numeric only."); $("#third_langError").css({"color": "red"});
				$("#third_lang").val(''); $("#third_lang").focus(); return false; }
			if(third_lang < 0 || third_lang > 100){
				$("#third_langError").html("Third Language- English marks should be in range 1-100, numeric only."); $("#third_langError").css({"color": "red"});
				$("#third_lang").val(''); $("#third_lang").focus(); return false; }
			
			if(maths == "" || maths == null){ 
				$("#mathsError").html("Mathematics marks are required please enter."); $("#mathsError").css({"color": "red"}); 
				$("#maths").val(''); $("#maths").focus(); return false; }
			if (!maths.match('^[0-9]{1,3}$')) { 
				$("#mathsError").html("Mathematics marks should be in range 1-100, numeric only."); $("#mathsError").css({"color": "red"}); 
				$("#maths").val(''); $("#maths").focus(); return false; }
			if(maths < 0 || maths > 100){
				$("#mathsError").html("Mathematics marks should be in range 1-100, numeric only."); $("#mathsError").css({"color": "red"}); 
				$("#maths").val(''); $("#maths").focus(); return false; }
			
			if(science == "" || science == null){ 
				$("#scienceError").html("General Science marks are required please enter."); $("#scienceError").css({"color": "red"}); 
				$("#science").val(''); $("#science").focus(); return false; }
			if (!science.match('^[0-9]{1,3}$')) { 
				$("#scienceError").html("General Science marks should be in range 1-100, numeric only."); $("#scienceError").css({"color": "red"}); 
				$("#science").val(''); $("#science").focus(); return false; }
			if(science < 0 || science > 100){
				$("#scienceError").html("General Science marks should be in range 1-100, numeric only."); $("#scienceError").css({"color": "red"}); 
				$("#science").val(''); $("#science").focus(); return false; }
			
			if(social == "" || social == null){ 
				$("#socialError").html("Social Studies marks are required please enter."); $("#socialError").css({"color": "red"}); 
				$("#social").val(''); $("#social").focus(); return false; }
			if (!social.match('^[0-9]{1,3}$')) { 
				$("#socialError").html("Social Studies marks should be in range 1-100, numeric only."); $("#socialError").css({"color": "red"}); 
				$("#social").val(''); $("#social").focus(); return false; }
			if(social < 0 || social > 100){
				$("#socialError").html("Social Studies marks should be in range 1-100, numeric only."); $("#socialError").css({"color": "red"}); 
				$("#social").val(''); $("#social").focus(); return false; }
			
		}
		
		if(ssc_type == 'sscg'){
			var pattern = /^(?:10(?:\.0)?|\d(?:\.\d)?)$/;
			//first_lang
			if(first_lang == "" || first_lang == null){ 
				$("#first_langError").html("First language GPA are required please enter."); $("#first_langError").css({"color": "red"}); 
				$("#first_lang").val(''); $("#first_lang").focus(); 
				return false; }
			if (!first_lang.match('^[0-9.]{1,3}$')) { 
				$("#first_langError").html("Invalid First Lang  GPA should be in range 0-10, numeric only."); $("#first_langError").css({"color": "red"}); 
				$("#first_lang").val(''); $("#first_lang").focus(); 
				return false; }
			if(first_lang < 0 || first_lang > 10){
				$("#first_langError").html("First Lang  GPA should be in range 0-10, numeric only."); $("#first_langError").css({"color": "red"}); 
				$("#first_lang").val(''); $("#first_lang").focus(); 
				return false; }
			if(!pattern.test(first_lang)){ 
				$("#first_langError").html("Invalid First Lang GPA should be in range 0-10, numeric only."); $("#first_langError").css({"color": "red"}); 
				$("#first_lang").val(''); $("#first_lang").focus(); 
				return false; }
			
			//second_lang
			if(noOfLangs == '3'){
				if(second_lang == "" || second_lang == null){ 
					$("#second_langError").html("Second Language GPA is required please enter."); $("#second_langError").css({"color": "red"}); 
					$("#second_lang").val(''); $("#second_lang").focus(); return false; }
				if (!second_lang.match('^[0-9.]{1,3}$')) { 
					$("#second_langError").html("Second Lang GPA is should be in range 1-10, numeric only."); $("#second_langError").css({"color": "red"}); 
					$("#second_lang").val(''); $("#second_lang").focus(); return false; }
				if(second_lang < 0 || second_lang > 10){
					$("#second_langError").html("First Lang marks should be in range 1-10, numeric only."); $("#second_langError").css({"color": "red"}); 
					$("#second_lang").val(''); $("#second_lang").focus(); return false; }
				if(!pattern.test(second_lang)){ 
					$("#second_langError").html("Invalid Second Lang GPA should be in range 0-10, numeric only."); $("#second_langError").css({"color": "red"}); 
					$("#second_lang").val(''); $("#second_lang").focus(); 
					return false; }
			}else{
				$("#second_lang").val('0');
			}
			
			//third_lang
			if(third_lang == "" || third_lang == null){ 
				$("#third_langError").html("Third Language- English GPA is required please enter."); $("#third_langError").css({"color": "red"}); 
				$("#third_lang").val(''); $("#third_lang").focus(); 
				return false; }
			if (!third_lang.match('^[0-9.]{1,3}$')) { 
				$("#third_langError").html("Invalid Third Language- English  GPA should be in range 0-10, numeric only."); $("#third_langError").css({"color": "red"}); 
				$("#third_lang").val(''); $("#third_lang").focus(); 
				return false; }
			if(third_lang < 0 || third_lang > 10){
				$("#third_langError").html("Invalid Third Language- English  GPA should be in range 0-10, numeric only."); $("#third_langError").css({"color": "red"}); 
				$("#third_lang").val(''); $("#third_lang").focus(); 
				return false; }
			if(!pattern.test(third_lang)){ 
				$("#third_langError").html("Invalid Third Language- English GPA should be in range 0-10, numeric only."); $("#third_langError").css({"color": "red"}); 
				$("#third_lang").val(''); $("#third_lang").focus(); 
				return false; }
			
			//maths
			if(maths == "" || maths == null){ 
				$("#mathsError").html("Mathematics GPA is required please enter."); $("#mathsError").css({"color": "red"}); 
				$("#maths").val(''); $("#maths").focus(); 
				return false; }
			if (!maths.match('^[0-9.]{1,3}$')) { 
				$("#mathsError").html("Invalid Mathematics  GPA should be in range 0-10, numeric only."); $("#mathsError").css({"color": "red"}); 
				$("#maths").val(''); $("#maths").focus(); 
				return false; }
			if(maths < 0 || maths > 10){
				$("#mathsError").html("Invalid Mathematics  GPA should be in range 0-10, numeric only."); $("#mathsError").css({"color": "red"}); 
				$("#maths").val(''); $("#maths").focus(); 
				return false; }
			if(!pattern.test(maths)){ 
				$("#mathsError").html("Invalid Mathematics GPA should be in range 0-10, numeric only."); $("#mathsError").css({"color": "red"}); 
				$("#maths").val(''); $("#maths").focus(); 
				return false; }
			
			//science
			if(science == "" || science == null){ 
				$("#scienceError").html("General Science GPA is required please enter."); $("#scienceError").css({"color": "red"}); 
				$("#science").val(''); $("#science").focus(); 
				return false; }
			if (!science.match('^[0-9.]{1,3}$')) { 
				$("#scienceError").html("Invalid General Science  GPA should be in range 0-10, numeric only."); $("#scienceError").css({"color": "red"}); 
				$("#science").val(''); $("#science").focus(); 
				return false; }
			if(science < 0 || science > 10){
				$("#scienceError").html("Invalid General Science GPA should be in range 0-10, numeric only."); $("#scienceError").css({"color": "red"}); 
				$("#science").val(''); $("#science").focus(); 
				return false; }
			if(!pattern.test(science)){ 
				$("#scienceError").html("Invalid General Science GPA should be in range 0-10, numeric only."); $("#scienceError").css({"color": "red"}); 
				$("#science").val(''); $("#science").focus(); 
				return false; }
			
			//social
			if(social == "" || social == null){ 
				$("#socialError").html("General Social Studies GPA is required please enter."); $("#socialError").css({"color": "red"}); 
				$("#social").val(''); $("#social").focus(); 
				return false; }
			if (!social.match('^[0-9.]{1,3}$')) { 
				$("#socialError").html("Invalid Social Studies GPA should be in range 0-10, numeric only."); $("#socialError").css({"color": "red"}); 
				$("#social").val(''); $("#social").focus(); 
				return false; }
			if(social < 0 || social > 10){
				$("#socialError").html("Invalid Social Studies GPA should be in range 0-10, numeric only."); $("#socialError").css({"color": "red"}); 
				$("#social").val(''); $("#social").focus(); 
				return false; }
			if(!pattern.test(social)){ 
				$("#socialError").html("Invalid Social Studies GPA should be in range 0-10, numeric only."); $("#socialError").css({"color": "red"}); 
				$("#social").val(''); $("#social").focus(); 
				return false; }
			
		}
		 
		 var photoo = document.getElementById('photo').value;
		 var photo = document.getElementById('photo');
		// alert(photo)
		 if(photoo == null || photoo == ""){
			 
		 }else{
			
			 if (photo.files.length > 0) {
				 //alert("asdfasdfasdfasdf")
		            var filee = photo.files[0];
		            var allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
		            if (allowedTypes.includes(filee.type)) {
		            } else {
		            	$("#photoError").html("Invalid Photo file type. Please select a JPEG, PNG or JPG image."); $("#photoError").css({"color": "red"}); 
						$("#photo").focus(); 
						return false; 
		            }
		            if (filee.size > 100 * 1024) {
		            	$("#photoError").html("File size exceeds 100KB. Please select a smaller image."); $("#photoError").css({"color": "red"}); 
						$("#photo").focus(); 
						return false; 
		            }
		            const imageInput = document.getElementById('photo');
			        const file = imageInput.files[0];

			        if (file) {
			            getBase64FromFile(file, function (base64Image) {
			                // Make the AJAX call with the Base64 image data
			            	//alert(base64Image)
			            	$("#base64Image").val(base64Image);
			               // sendImageToAPI(base64Image);
			            });
			        } else {
			            console.error('No image selected.');
			        }
		            
		        } 
			
	         
		 }
    var ssc_regno = $("#ssc_regno").val();
     
    var ssc_eq = '';
    var ssc_eqAll = document.querySelectorAll('input[name="ssc_eq"]');
    ssc_eqAll.forEach(function(ssc_eqBean){
    	if(ssc_eqBean.checked){
    		ssc_eq = ssc_eqBean.value;
    	}
    });
    //alert("ssc_eq=>"+ssc_eq);
    
    var tc = '';
    var tcAll = document.querySelectorAll('input[name="tc"]');
    tcAll.forEach(function(tcBean){
    	if(tcBean.checked){
    		tc = tcBean.value;
    	}
    });
    //alert("tc=>"+tc);
    
    var cc = '';
    var ccAll = document.querySelectorAll('input[name="cc"]');
    ccAll.forEach(function(ccBean){
    	if(ccBean.checked){
    		cc = ccBean.value;
    	}
    });
    //alert("cc=>"+cc);
    
    var pc = '';
    var pcAll = document.querySelectorAll('input[name="pc"]');
    pcAll.forEach(function(pcBean){
    	if(pcBean.checked){
    		pc = pcBean.value;
    	}
    });
    //alert("pc=>"+pc);
    
    var exsv = '';
    var exsvAll = document.querySelectorAll('input[name="exsv"]');
    exsvAll.forEach(function(exsvBean){
    	if(exsvBean.checked){
    		exsv = exsvBean.value;
    	}
    });
    //alert("exsv=>"+exsv);
    
    var sc = '';
    var scAll = document.querySelectorAll('input[name="sc"]');
    scAll.forEach(function(scBean){
    	if(scBean.checked){
    		sc = scBean.value;
    	}
    });
    //alert("sc=>"+sc);
    
    var nc = '';
    var ncAll = document.querySelectorAll('input[name="nc"]');
    ncAll.forEach(function(ncBean){
    	if(ncBean.checked){
    		nc = ncBean.value;
    	}
    });
    //alert("nc=>"+nc);
    
    var uidv = '';
    var uidvAll = document.querySelectorAll('input[name="uidv"]');
    uidvAll.forEach(function(uidvBean){
    	if(uidvBean.checked){
    		uidv = uidvBean.value;
    	}
    });
    //alert("uidv=>"+uidv);
    
    var ewsv = '';
    var ewsvAll = document.querySelectorAll('input[name="ewsv"]');
    ewsvAll.forEach(function(ewsvBean){
    	if(ewsvBean.checked){
    		ewsv = ewsvBean.value;
    	}
    });
    //alert("ewsv=>"+ewsv);
    
    var data = {};
	
	data["ssc_regno"] = ssc_regno;
	data["ssc_board"] = ssc_board;  
	data["ssc_year"] = ssc_year;  
	data["ssc_month"] =ssc_month;  
	data["name"] =  name;  
	data["phno"] =  phno; 
	
	var convertedDate = changeDateFormat(dob);
	data["dob"] = convertedDate;
	
	data["adarno"] =  adarno; 
	data["gen"] =  gen; 
	data["caste"] =  caste; 
	data["fname"] =  fname; 
	
	if(phc==true){ data["phc"] = 'yes'; }else{ data["phc"] = 'no'; }
	
	data["mname"] =  mname;
	data["pwd_category"] =  pwd_category; 
	
	if(exs==true){ data["exs"] = 'yes';
	}else{ data["exs"] = 'no'; }
	
	data["ssc"] =  ssc; 
	data["loconoc"] =  loconoc; 
	data["pincode"] =  pincode;  
	data["email"] =  email; 
	
	if(ews==true){ data["ews"] = 'yes';
	}else{ data["ews"] = 'no'; }
	
	data["addr"] =  addr; 
	
	data["ssc_type"] =  ssc_type;  
	data["noOfLangs"] =   noOfLangs;  
	
	data["first_lang"] =  first_lang;  
	data["second_lang"] = second_lang; 
	data["third_lang"] = third_lang; 
	data["science"] = science;  
	data["social"] = social;  
	data["maths"] = maths;
	
	data["userId"] = insCode;
	data["verifiedIp"] = "";
	data["verifiedDate"] = "";
	
	data["sscDocVerify"] = ssc_eq;
	data["transferDocVerify"] = tc;
	data["casteDocVerify"] = cc;
	data["physicallyDocVerify"] = pc;
	data["exServiceDocVerify"] = exsv;
	data["studyDocVerify"] = sc;
	data["nativityDocVerify"] = nc;
	data["uidDocVerify"] = uidv;
	data["ewsDocVerify"] = ewsv;
	
	var photoo = document.getElementById('photo').value;
	if(photoo == null || photoo == ""){
		data["photo"] = $("#oldImage").val();
	}else{
		data["photo"] = $("#base64Image").val();
	}
	//alert(JSON.stringify(data));
	
	if(ssc_eq == 'Y'){
		$.ajax({
			type: 'post',
			url: 'http://10.72.4.135:8888/itiapi/admissions/verificationApproval',
			contentType: 'application/json',
			cache: false,
			timeout: 600000,
			data: JSON.stringify(data),
			headers: {
				'Authorization': jwtToken
			},
			success:function(resp){
				//alert("verificationApproval=>success=>resp=>"+JSON.stringify(resp));
				
				 document.getElementById("verificationSuccessMsg").innerHTML=resp;
				 $("#verificationSuccessMsg").css({'color': 'green'});
				 
				 $("#contentDiv").hide();
				 $("#admYearPhaseDiv").hide();
				 $("#formTwo").hide();
				// getDistVerificationList(insCode);
				 $("#rejectButton").hide();
				 $("#ssc_eqError").empty();
				 
				 $("#printOptions").show(); 
				 $("#printOptionsRegid").innerHTML=ssc_regno; 
				 
				 
			},
			failue:function(resp){
				alert("failure=>resp=>"+JSON.stringify(resp));
			}
			
		});
	}else{
		 $("#ssc_eqError").html('Document SSC/Equivalent Marks should be checked Yes or No for Approve of this candidate.');
		 $("#ssc_eqError").css({"color": "red"});
		 return false;
	}
	
}
//function printData(){
//	alert("printdata");
//}
function reloadPage(){
	window.location.reload();
}
function checkPwd(phc){
	  if(phc == "" || phc == null){ 
			$("#phcError").html("Physically Challenged is required please choose."); $("#phcError").css({"color": "red"}); 
			$("#phc").val(''); $("#phc").focus();
			$("#pwd_category").prop('disabled', true);
			$("#pwd_category").val('0');
			 return false; 
			}else{
				if(phc == 'true'){
					//alert("yeassss")
					$("#pwd_category").prop('disabled', false);
				}else{
					$("#pwd_category").prop('disabled', true);
					$("#pwd_category").val('0');
				}
			}
}
function uploadImage() {
    const imageInput = document.getElementById('photo');
     const file = imageInput.files[0];

     if (file) {
         getBase64FromFile(file, function (base64Image) {
             // Make the AJAX call with the Base64 image data
         	//alert(base64Image)
         	$("#base64Image").val(base64Image);
            // sendImageToAPI(base64Image);
         });
     } else {
         console.error('No image selected.');
     }
 }
 

 

 
