
let jwtToken = null;
let insCode = null;
let admissionPhaseData = null;
let distItis = null;
let allTrades = null;
let allCastes = null;


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
		
		//trade data table
		$("#tradeDataTableDiv").hide(); 
		$("#itiNameSpan").empty(); 
		$("#currentAdmYear").empty(); 
		
		//add new trade
		$("#addNewTradeDiv").hide();
		
		//edit trade strength
		$("#editTradeDiv").hide();
		
		//reservation entry div
		$("#reservationEntryDiv").hide();
		
		getAdmissionPhaseData();
		getAllTrades();
		getAllCastes(function(castes) {
			allCastes = castes;
		});
	}
}

//GET ALL TRADES
function getAllTrades(){
	$.ajax({
		type:'get',
		url: 'http://10.72.4.135:8888/itiapi/masterdata/ititrademaster',
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("success=>"+ JSON.stringify(resp));
			allTrades=resp;
		},
		error: function(resp){
			alert("Something went wrong while getting trades data");
		}
	});
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
			admissionPhaseData= resp;
			getDistItis(insCode,resp.currentPhase);
		},
		error: function(resp){
			alert("Error getting iti data");
		}
	});
}

function getDistItis(a,b){
	//alert("getDistItis a=>"+a);
	//alert("getDistItis a=>"+b);
	
	if(b == 1){
		//alert("1111111")
		$.ajax({
			type: 'get',
			url: 'http://10.72.4.135:8888/itiapi/masterdata/getAllItisDistwise?distCode='+a,
			cache: false,
			timeout: 600000,
			success: function(resp){
				//alert("success=>"+JSON.stringify(resp));
				distItis = resp;
				$("#itiName").empty();
				$("#itiName").append('<option value="">--SELECT--</option>');
				for(var i=0; i < resp.length; i++){
					var bean = resp[i];
					if(bean.govt == 'G'){
						$("#itiName").append('<option value="'+bean.itiCode+'">'+bean.itiName+'('+bean.itiCode+')</option>');
					}
				}
			},
			error: function(resp){
				alert("Error getting iti data");
			}
		});
	}else{
		$.ajax({
			type: 'get',
			url: 'http://10.72.4.135:8888/itiapi/masterdata/getAllItisDistwise?distCode='+a,
			cache: false,
			timeout: 600000,
			success: function(resp){
				//alert("success=>"+JSON.stringify(resp));
				distItis = resp;
				$("#itiName").empty();
				$("#itiName").append('<option value="">--SELECT--</option>');
				for(var i=0; i < resp.length; i++){
					var bean = resp[i];
						$("#itiName").append('<option value="'+bean.itiCode+'">'+bean.itiName+'('+bean.itiCode+')</option>');
				}
			},
			error: function(resp){
				alert("Error getting iti data");
			}
		});
	}
	
	
}

function validate(){
	//alert("Working");
	
	var itiCode = $("#itiName").val();
	if(itiCode == null || itiCode == ""){
		document.getElementById('itiError').innerHTML = 'Select a ITI.';
		$("#itiName").focus();
		return false;
	}
	 
    // Validate Captcha
	  // txtInput 
	/***
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
	  **/
	$(".currentAdmYear").empty();
	  getItitradeData(itiCode);
}

function getItitradeData(itiCode){
	//alert("getItitradeData=>"+itiCode);
	//alert(jwtToken);
	
	var data = {};
	data['itiCode']=itiCode;
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/getItitradeData',
		contentType: 'application/json',
		data: JSON.stringify(data),
		headers:{
			'Authorization': jwtToken
		},
		cache:false,
		timeout: 600000,
		success:function(resp){
			//alert("success=>"+JSON.stringify(resp));
			//alert("resp.length=>"+resp.length);
			
			$(".currentAdmYear").empty();
			
			var itiNameShow = '';
			for(var i=0;i<distItis.length;i++){
				var bean = distItis[i];
				if(bean.itiCode == itiCode){
					//alert(bean.itiName);
					
					$(".itiNameSpan").empty();
					$(".itiNameSpan").append('<span class="text-success" style="font-weight: bolder;">'+bean.itiName+'</span>');
					//alert(admissionPhaseData.admYear);
					$(".currentAdmYear").append(admissionPhaseData.admYear);
				}
			}
			
			if(resp.length == 0){ $("#admTradesTable").append('<tr><td colspan="8" style="text-align: center;color:red;">NO TRADES ARE AVAILABLE FOR THIS ITI</td></tr>'); }
			else{
				var freezeBtn = false;
				var approveBtn = false;
				
				$("#admTradesTable").empty();
				
				for(var i=0;i<resp.length;i++){
					var bean = resp[i];
					//alert("bean=>"+JSON.stringify(bean));
					
					var tradename = '';
					for(var j=0; j<allTrades.length;j++){
						var trade = allTrades[j];
						if(trade.tradeCode == bean.tradeCode){
							tradename = trade.tradeName;
						}
					}
					
					var availableforyear = '';
					if(bean.availableForYear == 1){ availableforyear = 'YES'; }
					else{ availableforyear = 'NO'; }
					
					var tradeFreezee = '';
					if(bean.tradeFreeze == 0){ 
						tradeFreezee = '<a href="javascript:editTrade(\''+bean.itiCode+'\',\''+bean.tradeCode+'\')">EDIT</a>'; 
						freezeBtn = true;
					}
					else{ tradeFreezee = 'FREEZED'; }
					
					var convApprovall = '';
					if(bean.convApproval == 0){ 
						convApprovall = '<a href="javascript:reservationEntry(\''+bean.itiCode+'\',\''+bean.tradeCode+'\')">RESERVATION ENTRY</a>'; 
						approveBtn = true;
					}
					else{ convApprovall = 'APPROVED'; }
					
					$("#admTradesTable").append('<tr>'
							+'<td>'+bean.tradeCode+'</td>'
							+'<td>'+tradename+'</td>'
							+'<td>'+bean.strength+'</td>'
							+'<td>'+bean.strenthVacant+'</td>'
							+'<td>'+availableforyear+'</td>'
							+'<td>'+bean.seatmatrix+'</td>'
							+'<td>'+tradeFreezee+'</td>'
							+'<td>'+convApprovall+'</td>'
		 					+'</tr>');
				}
				
				$("#freezeAndApproveBtnDiv").empty();
				
				if(freezeBtn == true){ $("#freezeAndApproveBtnDiv").append('<button class="btn btn-info" onclick="return freezeAll();">FREEZE ALL</button>'); }
				if(approveBtn == true){ $("#freezeAndApproveBtnDiv").append('&nbsp;&nbsp;&nbsp;<button class="btn btn-info" onclick="return approveAll();">APPROVE ALL</button>'); }
				
			}
			$("#divOne").hide(); 
			$("#tradeDataTableDiv").show(); 
			
		},
		error:function(resp){
			alert("Something went wrong while getting iti trade data");
		}
		
	});
	
	
}

//ADDING NEW TRADE FOR THE ITI
function addNewTrade(){
	//alert("addNewTrade");
	
	$("#divOne").hide();
	$("#tradeDataTableDiv").hide();
	$("#addNewTradeDiv").show();
	
	$("#trade").empty();
	$("#trade").append('<option value="">-SELECT-</option>');
	//alert(allTrades.length);
	for(var i=0; i<allTrades.length;i++){
		var bean = allTrades[i];
		$("#trade").append('<option value="'+bean.tradeCode+'">'+bean.tradeName+'</option>');
	}
}

function addTradeSubmit(){
	//alert("addTradeSubmit()");
	
	//trade
	var trade = $("#trade").val();
	if(trade == "" || trade == null){
		$("#tradeError").append('Trade is Required.'); $("#tradeError").css('color','red'); $("#trade").val(''); $("#trade").focus(); return false;
	}
	//strength
	var strength = $("#strength").val();
	if(strength == "" || strength == null){
		$("#strengthError").append('Strength is Required.'); $("#strengthError").css('color','red'); $("#strength").val(''); $("#strength").focus(); return false;
	}
	//availableForYear
	var availableForYear = document.getElementsByName('availableForYear');
	var radioselected = false;
	var selectedValue = false;
	for(var i=0;i<availableForYear.length;i++){
		if(availableForYear[i].checked){  radioselected = true; selectedValue=availableForYear[i].value; break; }
	}
	
	if(!radioselected){
		$("#availableForYearError").append('Available for Year 2023 is required.'); $("#availableForYearError").css('color','red'); return false; 
	} 
	
	saveNewTrade(trade,strength,selectedValue);
}

function saveNewTrade(trade,strength,selectedValue){
	var itiCode = $("#itiName").val();
	//alert(trade); alert(strength); alert(selectedValue); alert(itiCode);
	
	var data = {};
	data['itiCode'] = itiCode;
	data['tradeCode'] = trade;
	data['strength'] = strength;
	data['availableForYear'] = selectedValue;
	//alert(jwtToken);
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/saveNewItiTrade',
		contentType: 'application/json',
		data: JSON.stringify(data),
		headers:{
			'Authorization': jwtToken
		},
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("success=>"+JSON.stringify(resp));
			
			//div three
			$("#addNewTradeDiv").hide();
			$("#trade").val('');
			$("#strength").val('');
			
			//div two
			$("#tradeDataTableDiv").show();
			$("#addTradeSuccessMsg").empty();
			$("#addTradeSuccessMsg").append('<h6 class="h6 text-success">Trade is Added Successfully!</h6>');
			
			var tradename = '';
			for(var i=0; i<allTrades.length;i++){
				var bean = allTrades[i];
				if(bean.tradeCode == resp.tradeCode){
					tradename = bean.tradeName;
				}
			}
			
			var availableforyear = '';
			if(resp.availableForYear == 1){ availableforyear = 'YES'; }
			else{ availableforyear = 'NO'; }
			
			$("#admTradesTable").append('<tr>'
					+'<td>'+resp.tradeCode+'</td>'
					+'<td>'+tradename+'</td>'
					+'<td>'+resp.strength+'</td>'
					+'<td>'+resp.strenthVacant+'</td>'
					+'<td>'+availableforyear+'</td>'
					+'<td> </td>'
					+'<td> </td>'
					+'<td> </td>'
 					+'</tr>');
			
			
			
			
		},
		error:function(resp){
			//alert("error=>"+JSON.stringify(resp));
			
			//div three
			$("#addNewTradeDiv").hide();
			$("#trade").val('');
			$("#strength").val('');
			
			//div two
			$("#tradeDataTableDiv").show();
			$("#addTradeSuccessMsg").append('<h6 class="h6 text-danger">'+resp.responseText+'</h6>');
		}
	});
}

//EDIT TRADE STRENGTH AND AVAILABLE FOR CURRENT YEAR
function editTrade(itiCode,tradeCode){
	//alert("editTrade=itiCode="+itiCode+",tradeCode="+tradeCode);
	
	var rbody = {};
	rbody['itiCode'] = itiCode;
	rbody['tradeCode'] = tradeCode;
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/getByItiCodeAndTradeCode',
		contentType: 'application/json',
		data: JSON.stringify(rbody),
		headers: {
			'Authorization': jwtToken
		},
		cache:false,
		success:function(resp){
			alert("resp=>"+JSON.stringify(resp));
			
			$("#tradeDataTableDiv").hide();
			$("#editTradeDiv").show();
			
			var tradename = '';
			for(var j=0; j<allTrades.length;j++){
				var trade = allTrades[j];
				if(tradeCode == trade.tradeCode){
					tradename = trade.tradeName;
				}
			}
			document.getElementById('edittradename').innerHTML = tradename;
			
			$("#editTradeIticode").val(itiCode);
			$("#editTradecode").val(tradeCode);
			
			$("#editStrength").val(resp.strength);
			
			if(resp.availableForYear == 1){
				document.getElementById('editAvailableForYearYes').checked = true;
				document.getElementById('editAvailableForYearNo').checked = false;
			}else{
				document.getElementById('editAvailableForYearYes').checked = false;
				document.getElementById('editAvailableForYearNo').checked = false;
			}
			
		},
		error:function(error){
			alert("error=>"+JSON.stringify(error));
		}
	});

}

//edit onclick
function editTradeSubmit(){
	//strength
	var editStrength = $("#editStrength").val();
	if(editStrength == "" || editStrength == null){
		$("#editStrengthError").append('Strength is Required.'); $("#editStrengthError").css('color','red'); $("#editStrength").val(''); $("#editStrength").focus(); return false;
	}
	//availableForYear
	var editAvailableForYear = document.getElementsByName('editAvailableForYear');
	var radioselected = false;
	var selectedValue = false;
	for(var i=0;i<editAvailableForYear.length;i++){
		if(editAvailableForYear[i].checked){  radioselected = true; selectedValue=editAvailableForYear[i].value; break; }
	}
	
	if(!radioselected){
		$("#editAvailableForYearError").append('Available for Year 2023 is required.'); $("#editAvailableForYearError").css('color','red'); return false; 
	} 
	
	var editTradeIticode = $("#editTradeIticode").val();
	var editTradecode = $("#editTradecode").val();
	
	editTradeData(editTradeIticode,editTradecode,editStrength,selectedValue);
}

function editTradeData(editTradeIticode,editTradecode,editStrength,selectedValue){
	//alert("editTradeData=>editTradeIticode="+editTradeIticode+",editTradecode="+editTradecode+",editStrength="+editStrength+",selectedValue="+selectedValue);
	
	var rbody = {};
	rbody['itiCode'] = editTradeIticode;
	rbody['tradeCode'] = editTradecode;
	rbody['availableForYear'] = selectedValue;
	rbody['strength'] = editStrength;
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/editItiTrade',
		contentType: 'application/json',
		data: JSON.stringify(rbody),
		headers: {
			'Authorization': jwtToken
		},
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("resp>"+JSON.stringify(resp));
			$("#addTradeSuccessMsg").append('<span class="text-success">DATA UPDATED SUCCESSFULLY!</span>');
			$("#editTradeDiv").hide();
			
			$("#editTradeIticode").val('');
			$("#editTradecode").val('');
			$("#editStrength").val('');
			
			document.getElementById('editAvailableForYearYes').checked = false;
			document.getElementById('editAvailableForYearNo').checked = false;
			
			$("#tradeDataTableDiv").show();
			$(".currentAdmYear").empty();
			getItitradeData(resp.itiCode);
			
		},
		error:function(error){
			alert("error=>"+JSON.stringify(error));
			$("#addTradeSuccessMsg").append('<span class="text-danger">'+error.responseText+'</span>');
			$("#editTradeDiv").hide();
			
			$("#editTradeIticode").val('');
			$("#editTradecode").val('');
			$("#editStrength").val('');
			
			document.getElementById('editAvailableForYearYes').checked = false;
			document.getElementById('editAvailableForYearNo').checked = false;
			
			$("#tradeDataTableDiv").show();
		}
		
	});
	
}


//ADDING RESERVATION ENTRY
function reservationEntry(itiCode,tradeCode){
	//alert("reservationEntry=>itiCode="+itiCode+",tradeCode="+tradeCode);
	
	$("#tradeDataTableDiv").hide();
	$("#reservationEntryDiv").show();
	
	var tradename = '';
	for(var j=0; j<allTrades.length;j++){
		var trade = allTrades[j];
		if(tradeCode == trade.tradeCode){
			tradename = trade.tradeName;
		}
	}
	$("#reservationEntryTradeNameSpan").append(tradename);
	
	var rbody = {};
	rbody['itiCode']= itiCode;
	rbody['tradeCode']= tradeCode;
	
	$("#reservationEntryTbody").empty();
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/getSeatmatrix',
		contentType: 'application/json',
		data: JSON.stringify(rbody),
		headers: {
			'Authorization': jwtToken
		},
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("resp=>"+JSON.stringify(resp));
			//alert("resp=>"+resp.length);
			
			var currentTradeData;
			var totseatmatrixcount;
			
			if(resp.length > 0){
				totseatmatrixcount=resp.length;
				
				var totStrength = 0, totStrengthFill = 0, totStrengthVacant = 0;
				
				for(var i=0; i<resp.length; i++){
					currentTradeData = resp[0]; 
					var bean = resp[i];
					
					totStrength = totStrength + bean.strength;
					totStrengthFill = totStrengthFill + bean.strengthFill;
					totStrengthVacant = totStrengthVacant + bean.strengthVacant;
					
					$("#reservationEntryTbody").append('<tr>'
							+'<td style="text-align: center;"><input type="hidden" name="category" id="category'+i+'" value="'+bean.categoryCode+'" />'+bean.categoryCode+'</td>'
							+'<td style="text-align: center;"><input type="text" name="seatmatrixstrength" id="seatmatrixstrength'+i+'" value="'+bean.strength+'" class="form-control w-50"/></td>'
							+'<td style="text-align: center;">'+bean.strengthFill+'</td>'
							+'<td style="text-align: center;">'+bean.strengthVacant+'</td>'
							+'</tr>');
				}
				$("#reservationEntryTbody").append('<tr>'
						+'<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">TOTAL</td>'
						+'<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">'+totStrength+'</td>'
						+'<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">'+totStrengthFill+'</td>'
						+'<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">'+totStrengthVacant+'</td>'
						+'</tr>');
				//alert("resp=>"+JSON.stringify(currentTradeData));
				$("#reservationEntryTbody").append('<tr><td colspan="4" style="text-align: center;">'
						+'<button class="btn btn-success" onclick="return updateSeatMatrix(\''+currentTradeData.itiCode+'\',\''+currentTradeData.tradeCode+'\',\''+totseatmatrixcount+'\')">UPDATE DATA</button></td></tr>');
				
			}else{
				//alert("SEATMATRIX IS NOT AVAILABLE");
				$("#reservationEntryTbody").empty();
				var itiCode = $("#itiName").val();
				for(var i=0; i<allCastes.length;i++){
					var bean = allCastes[i];
					//alert(bean);
					$("#reservationEntryTbody").append('<tr>'
							+'<td style="text-align: center;"><input type="hidden" name="category_code" id="category_code'+i+'" value="'+bean.category_code+'" />'+bean.category_code+'</td>'+bean.category_code+'</td>'
							+'<td style="text-align: center;"><input type="text" name="category_codeseatmatrixstrength" id="category_codeseatmatrixstrength'+i+'" value="0" maxlength="4" class="form-control w-50"/></td>'
							+'<td style="text-align: center;">'+0+'</td>'
							+'<td style="text-align: center;">'+0+'</td>'
							+'</tr>');
				}
				$("#reservationEntryTbody").append('<tr>'
						+'<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">TOTAL</td>'
						+'<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">0</td>'
						+'<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">0</td>'
						+'<td style="background-color: black; color: white; font-weight: bolder;text-align: center;">0</td>'
						+'</tr>');
				$("#reservationEntryTbody").append('<tr><td colspan="4" style="text-align: center;">'
						+'<button class="btn btn-success" onclick="return insertSeatMatrix(\''+itiCode+'\',\''+tradeCode+'\')">INSERT DATA</button></td></tr>');
				
			}
		},
		error:function(error){
			alert("error=>"+JSON.stringify(error));
		}
	});
	
	
}

function insertSeatMatrix(itiCode, tradeCode){
	alert("updateSeatMatrix=>itiCode="+itiCode+", tradeCode="+tradeCode);
	
	var data={};
	var categoryListt = '';
	var strengthListt = '';
	
	for(var i=0; i<allCastes.length; i++){
		category = $("#category_code"+i).val();
		strength = $("#category_codeseatmatrixstrength"+i).val();
		
		
		//alert(a);
		if(strength === null || strength === ""){
			$("#rEntry").empty();
			$("#rEntry").append('Strength should not be empty.');
			$("#rEntry").css("color","red");
			$("#rEntry").css("font-weight","bolder");
		}else{
			//alert("in else");
			
			categoryListt = categoryListt + document.getElementById("category_code" + i).value + ",";
			strengthListt = strengthListt + document.getElementById("category_codeseatmatrixstrength" + i).value + ",";
			
		}
	}
	
	document.getElementById("categoryList").value = '';
	document.getElementById("strengthList").value = '';
	
	document.getElementById("categoryList").value = categoryListt;
	document.getElementById("strengthList").value = strengthListt;
	
	alert(document.getElementById("categoryList").value);
	alert(document.getElementById("strengthList").value);
	
	insertNewSeatmatrix(itiCode, tradeCode,document.getElementById("categoryList").value,document.getElementById("strengthList").value);
	
}
function insertNewSeatmatrix(itiCode, tradeCode,categoryList,strengthList){
	alert("insertNewSeatmatrix=>itiCode="+itiCode+", tradeCode="+tradeCode+",categoryList="+categoryList+",strengthList="+strengthList);
	
	var rbody = {};
	rbody['itiCode'] = itiCode;
	rbody['tradeCode'] = tradeCode;
	rbody['noofcount'] = allCastes.length;
	rbody['categories'] = categoryList;
	rbody['strengths'] = strengthList;
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/insertNewSeatmatrix',
		contentType: 'application/json',
		data: JSON.stringify(rbody),
		headers: {
			'Authorization' : jwtToken
		},
		cache: false,
		success:function(resp){
			alert("success=>"+JSON.stringify(resp));
			
			document.getElementById("categoryList").value = '';
			document.getElementById("strengthList").value = '';
			document.getElementById("reservationEntryTradeNameSpan").innerHTML = '';
			document.getElementById("rEntry").innerHTML = '';
			$("#reservationEntryTbody").empty();
			
			$("#reservationEntryDiv").hide();
			$("#tradeDataTableDiv").show();
			
			$("#addTradeSuccessMsg").append('<span class="text-success font-weight-bolder" >'+resp+'</span>');
			
		},
		error:function(error){
			alert("error=>"+JSON.stringify(error));
		}
		
	});
}
function updateSeatMatrix(itiCode, tradeCode,totseatmatrixcount){
	//alert("updateSeatMatrix=>itiCode="+itiCode+", tradeCode="+tradeCode+",totseatmatrixcount="+totseatmatrixcount);
	
	var data={};
	var categoryListt = '';
	var strengthListt = '';
	
	for(var i=0; i<totseatmatrixcount; i++){
		  category = $("#category"+i).val();
		  strength = $("#seatmatrixstrength"+i).val();
		  
		
		//alert(a);
		if(strength === null || strength === ""){
			$("#rEntry").empty();
			$("#rEntry").append('Strength should not be empty.');
			$("#rEntry").css("color","red");
			$("#rEntry").css("font-weight","bolder");
		}else{
			//alert("in else");
			
			categoryListt = categoryListt + document.getElementById("category" + i).value + ",";
			strengthListt = strengthListt + document.getElementById("seatmatrixstrength" + i).value + ",";
			
		}
	}
	
	document.getElementById("categoryList").value = categoryListt;
	document.getElementById("strengthList").value = strengthListt;
	
	//alert(document.getElementById("categoryList").value);
	//alert(document.getElementById("strengthList").value);
	
	saveSeatmatrix(itiCode, tradeCode,totseatmatrixcount,document.getElementById("categoryList").value,document.getElementById("strengthList").value);
	
}

function saveSeatmatrix(itiCode, tradeCode,totseatmatrixcount,categoryList,strengthList){
	//alert("saveSeatmatrix=>itiCode="+itiCode+", tradeCode="+tradeCode+",totseatmatrixcount="+totseatmatrixcount+",categoryList="+categoryList+",strengthList="+strengthList);
	
	var rbody = {};
	rbody['itiCode'] = itiCode;
	rbody['tradeCode'] = tradeCode;
	rbody['noofcount'] = totseatmatrixcount;
	rbody['categories'] = categoryList;
	rbody['strengths'] = strengthList;
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/saveSeatMatrix',
		contentType: 'application/json',
		data: JSON.stringify(rbody),
		headers: {
			'Authorization' : jwtToken
		},
		cache: false,
		success:function(resp){
			//alert("success=>"+JSON.stringify(resp));
			
			document.getElementById("categoryList").value = '';
			document.getElementById("strengthList").value = '';
			document.getElementById("reservationEntryTradeNameSpan").innerHTML = '';
			document.getElementById("rEntry").innerHTML = '';
			$("#reservationEntryTbody").empty();
			
			$("#reservationEntryDiv").hide();
			$("#tradeDataTableDiv").show();
			
			$("#addTradeSuccessMsg").append('<span class="text-success font-weight-bolder" >'+resp+'</span>');
			
		},
		error:function(error){
			alert("error=>"+JSON.stringify(error));
		}
		
	});
}


function approveAll(){
	//alert("approveAll");
	
	var itiCode = $("#itiName").val();
	//alert("itiCode=>"+itiCode);
	
	var rbody = {};
	rbody['itiCode'] = itiCode;
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/approveTradeAll',
		contentType: 'application/json',
		data: JSON.stringify(rbody),
		headers:{
			'Authorization' : jwtToken
		},
		cache: false,
		success: function(resp){
			//alert("success=>"+JSON.stringify(resp));
			$("#addTradeSuccessMsg").empty();
			$("#addTradeSuccessMsg").append('<span class="text-success font-weight-bolder">'+resp+'</span>');
			$(".currentAdmYear").empty();
			getItitradeData(itiCode);
		},
		error: function(error){
			//alert("error=>"+JSON.stringify(error));
			$("#addTradeSuccessMsg").empty();
			$("#addTradeSuccessMsg").append('<span class="text-danger font-weight-bolder">'+error.responseText+'</span>');
		}
	});
	
	
}

function freezeAll() {
	//alert("freezeAll");
	
	var itiCode = $("#itiName").val();
	//alert("itiCode=>"+itiCode);
	
	var rbody = {};
	rbody['itiCode'] = itiCode;
	
	$.ajax({
		type:'post',
		url: 'http://10.72.4.135:8888/itiapi/itiseatmatrix/freezeTradeAll',
		contentType: 'application/json',
		data: JSON.stringify(rbody),
		headers: {
			'Authorization': jwtToken
		},
		cache: false,
		success: function(resp){
			//alert("success=>"+JSON.stringify(resp));
			$("#addTradeSuccessMsg").empty();
			$("#addTradeSuccessMsg").append('<span class="text-success font-weight-bolder">'+resp+'</span>');
			$(".currentAdmYear").empty();
			getItitradeData(itiCode);
		},
		error: function(error){
			//alert("error=>"+JSON.stringify(error));
			$("#addTradeSuccessMsg").empty();
			$("#addTradeSuccessMsg").append('<span class="text-danger font-weight-bolder">'+error.responseText+'</span>');
		}
		

		
	});
}













function checkValue(a){
	document.getElementById(a).innerHTML = '';
}







 

