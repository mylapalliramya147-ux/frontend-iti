/**
 * 
 */

function getReady(){
	
	//alert("getReady");
	jwtToken = localStorage.getItem('jwtToken');
	insCode =  localStorage.getItem('insCode');
	//alert("jwtToken=>"+jwtToken);
	
	if(jwtToken == null || jwtToken == ""){
		$("#navbar").hide(); 
		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
		
		$("#pagename").hide();
		$("#checkRankDiv").hide();
		$("#admissionDiv").hide();
	}else{
		//alert("else"+jwtToken);
		jwtToken = "Bearer "+jwtToken;
		//alert("assign=>"+jwtToken);
		$("#404Msg").hide(); 
		$("#navbar").show(); 
		
		$("#pagename").show();
		$("#checkRankDiv").show();
		$("#admissionDiv").hide();
		
		$("#boardCode").val('');
		$("#idmarks1").val('');
		$("#idmarks2").val('');
		
		getScheduleTimingsByDist(insCode);
		
	}
}

function getScheduleTimingsByDist(insCode){
	//alert(insCode);
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/admissions/getScheduleTimingsByDist?distCode='+insCode,
		headers:{
			'Authorization': jwtToken
		},
		cache: false,
		timeout: 600000,
		success:function(resp){
			//alert("success=>"+JSON.stringify(resp));
			
			for(var i=0; i<resp.length; i++){
				var bean = resp[i];
				$("#schedule").append('<option value="'+bean.callTime+'">'+bean.callTime+'</option>');
			}
		},
		error:function(resp){
			//alert("error=>"+JSON.stringify(resp));
		}
	});
	
}

function validate(){
	//alert("validate");
	
	$("#rankError").empty();
	$("#scheduleError").empty();
	
	var rank = $("#rank").val();
	//alert(rank);
	
	if(rank == "" || rank == null){
		$("#rankError").append('Rank should not be empty.');
		$("#rankError").css({"color":"red"});
		$("#rank").val('')
		return false;
	}
	
	var schedule = $("#schedule").val();
	//alert(schedule);
	
	if(schedule == "" || schedule == null){
		$("#scheduleError").append('Schedule should not be empty.');
		$("#scheduleError").css({"color":"red"});
		$("#schedule").val('')
		return false;
	}
	
	checkAdmissions(rank,insCode);
	
}

function checkAdmissions(rank,insCode){
	//alert("rank="+rank);
	//alert("insCode="+insCode);
	
	var rbody = {};
	rbody['rank'] = rank;
	rbody['distCode'] = insCode;
	rbody['phase'] = '1';
	
	$.ajax({
		type: 'post',
		url: 'http://10.72.4.135:8888/itiapi/masterdata/getSeatMatrixPhaseOneByRank',
		//url: 'http://10.72.4.135:8888/itiapi/admissions/checkRankIsAdmitted',
		data: JSON.stringify(rbody),
		contentType: 'application/json',
//		headers: {
//			'Authorization': jwtToken
//		},
		cache: false,
		success: function(resp){
			//alert("success=>"+JSON.stringify(resp));
			$("#tableAdm").empty();
			$("#checkRankDiv").hide();
			$("#admissionDiv").show();
			
			$("#checkRankResp").append('');
			$("#rank").val('');
			$("#schedule").val('');
			
			var imgElement = document.createElement("img");
			imgElement.src = 'data:image/png;base64,'+resp.imageCandPhotosEntity.image;
			imgElement.width = 180;
			imgElement.height = 130;
			document.getElementById('imageContainer').appendChild(imgElement);
			
			var phc = resp.studentApplication.phc == true? 'Yes':'No';
			var exservice = resp.studentApplication.exservice == true? 'Yes':'No';
			
			$("#detailsOne").append('<table>'
					+'<tr><td>Name </td><td style="font-weight: bold;">: '+resp.studentApplication.name+'</td></tr>'
					+'<tr><td>Community </td><td style="font-weight: bold;">: '+resp.studentApplication.caste+'</td></tr>'
					+'<tr><td>Gender </td><td style="font-weight: bold;">: '+resp.studentApplication.gender.toUpperCase()+'</td></tr>'
					+'<tr><td>Rank </td><td style="font-weight: bold;">: '+resp.ranksEntity.rank+'</td></tr>'
					+'<tr><td>Physically Challenged </td><td style="font-weight: bold;">: '+phc+'</td></tr>'
					+'</table>');
			
			$("#detailsTwo").append('<table>'
					+'<tr><td>Father Name </td><td style="font-weight: bold;">: '+resp.studentApplication.fname+'</td></tr>'
					+'<tr><td>Academic Year </td><td style="font-weight: bold;">: '+resp.studentApplication.sscYear+'</td></tr>'
					+'<tr><td>DOB </td><td style="font-weight: bold;">: '+resp.studentApplication.dob+'</td></tr>'
					+'<tr><td>Reg No </td><td style="font-weight: bold;">: '+resp.studentApplication.regid+'</td></tr>'
					+'<tr><td>Exservice </td><td style="font-weight: bold;">: '+exservice+'</td></tr>'
					+'</table>');
			
			if(resp.studentApplication.gender == 'male'){
				//alert("male");
				
				if(resp.studentApplication.caste == 'OC'){
					//alert("OC");
					
					$("#tableAdm").append('<thead>'
							+'<tr>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">ITI NAME</td>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">TRADE NAME</td>' 
							+'<td style="background-color: black;color: white;" align="center" rowspan="2"></td>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">TOTAL STRENGTH</td> ' 
							+'<td style="background-color: black;color: white;" colspan="3" align="center">GENERAL</td>  '
							+'</tr>  '
							+'<tr>  '
						//	+'<td style="background-color: black;color: white;" colspan="4"> </td> ' 
							+'<td style="background-color: black;color: white;" align="center"> Total </td>  '
							+'<td style="background-color: black;color: white;" align="center"> Fill </td>  '
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td>  '
							+'</tr> '
							+'</thead>');
					
					for(var i=0;i<resp.seatmatrix.length;i++){
						var bean = resp.seatmatrix[i];
						$("#tableAdm").append('<tbody>'
								+'<tr>'
								+'<td>'+bean.iti_name+'</td>'
								+'<td>'+bean.trade_name+'</td>'
								+'<td><input type="radio" name="selectedRecord" id="selectedRecord'+i+'" value="'+bean.itiCode+','+bean.tradeCode+','+resp.ranksEntity.regid+'" /></td>'
								+'<td>'+bean.strength+'</td>'
								
								+'<td>'+bean.genTotalStrength+'</td>'
								+'<td>'+bean.genTotalStrengthFill+'</td>'
								+'<td>'+bean.genTotalStrengthVacant+'</td>'
								
								+'</tr>'
								+'</tbody>');
					}
				}else{
					//alert("male and not oc");
					
					$("#tableAdm").append('<thead>'
							+'<tr>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">ITI NAME</td>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">TRADE NAME</td> '
							+'<td style="background-color: black;color: white;" align="center" rowspan="2"></td> '
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">TOTAL STRENGTH</td>'
							+'<td style="background-color: black;color: white;" colspan="3" align="center">GENERAL</td>'
							+'<td style="background-color: black;color: white;" colspan="3" align="center">'+resp.studentApplication.caste+'</td>'
							+'</tr>'
							+'<tr> '
							//+'<td style="background-color: black;color: white;" colspan="4"> </td> '
							+'<td style="background-color: black;color: white;" align="center"> Total </td>'
							+'<td style="background-color: black;color: white;" align="center"> Fill </td> '
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td> '
							+'<td style="background-color: black;color: white;" align="center"> Total </td> '
							+'<td style="background-color: black;color: white;" align="center"> Fill </td>'
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td> '
							+'</tr> '
							+'</thead>');
					
					for(var i=0;i<resp.seatmatrix.length;i++){
						var bean = resp.seatmatrix[i];
						$("#tableAdm").append('<tbody>'
								+'<tr>'
								+'<td>'+bean.iti_name+'</td>'
								+'<td>'+bean.trade_name+'</td>'
								+'<td><input type="radio" name="selectedRecord" id="selectedRecord'+i+'" value="'+bean.itiCode+','+bean.tradeCode+','+resp.ranksEntity.regid+'" /></td>'
								+'<td>'+bean.strength+'</td>'
								
								+'<td>'+bean.genTotalStrength+'</td>'
								+'<td>'+bean.genTotalStrengthFill+'</td>'
								+'<td>'+bean.genTotalStrengthVacant+'</td>'
								
								+'<td>'+bean.categoryTotalStrength+'</td>'
								+'<td>'+bean.categoryTotalStrengthFill+'</td>'
								+'<td>'+bean.categoryTotalStrengthVacant+'</td>'
								
								+'</tr>'
								+'</tbody>');
					}
					
				}
				
				
			}//gender male ends
			
			if(resp.studentApplication.gender == 'female'){
				//alert("gender female");
				
				if(resp.studentApplication.caste == 'OC-W'){
					//alert("gender female and OC-W");
					
					$("#tableAdm").append('<thead>'
							+'<tr>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">ITI NAME</td>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">TRADE NAME</td> '
							+'<td style="background-color: black;color: white;" align="center" rowspan="2"></td> '
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">TOTAL STRENGTH</td>'
							+'<td style="background-color: black;color: white;" colspan="3" align="center">GENERAL</td>'
							+'<td style="background-color: black;color: white;" colspan="3" align="center">'+resp.studentApplication.caste+'</td>'
							+'</tr>'
							+'<tr> '
							//+'<td style="background-color: black;color: white;" colspan="4"> </td> '
							+'<td style="background-color: black;color: white;" align="center"> Total </td>'
							+'<td style="background-color: black;color: white;" align="center"> Fill </td> '
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td> '
							
							+'<td style="background-color: black;color: white;" align="center"> Total </td> '
							+'<td style="background-color: black;color: white;" align="center"> Fill </td>'
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td> '
							+'</tr> '
							+'</thead>');
					
					for(var i=0;i<resp.seatmatrix.length;i++){
						var bean = resp.seatmatrix[i];
						$("#tableAdm").append('<tbody>'
								+'<tr>'
								+'<td>'+bean.iti_name+'</td>'
								+'<td>'+bean.trade_name+'</td>'
								+'<td><input type="radio" name="selectedRecord" id="selectedRecord'+i+'" value="'+bean.itiCode+','+bean.tradeCode+','+resp.ranksEntity.regid+'" /></td>'
								+'<td>'+bean.strength+'</td>'
								
								+'<td>'+bean.genTotalStrength+'</td>'
								+'<td>'+bean.genTotalStrengthFill+'</td>'
								+'<td>'+bean.genTotalStrengthVacant+'</td>'
								
								+'<td>'+bean.genWTotalStrength+'</td>'
								+'<td>'+bean.genWTotalStrengthFill+'</td>'
								+'<td>'+bean.genWTotalStrengthVacant+'</td>'
								
								+'</tr>'
								+'</tbody>');
					}
					
				}else{
					//alert("in else");
					var castee = resp.studentApplication.caste.slice(0, 4);
					$("#tableAdm").append('<thead>'
							+'<tr>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">ITI NAME</td>'
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">TRADE NAME</td> '
							+'<td style="background-color: black;color: white;" align="center" rowspan="2"></td> '
							+'<td style="background-color: black;color: white;" align="center" rowspan="2">TOTAL STRENGTH</td>'
							
							+'<td style="background-color: black;color: white;" colspan="3" align="center">GENERAL</td>'
							+'<td style="background-color: black;color: white;" colspan="3" align="center">GENERAL - W</td>'
							
							+'<td style="background-color: black;color: white;" colspan="3" align="center">'+castee+'</td>'
							+'<td style="background-color: black;color: white;" colspan="3" align="center">'+resp.studentApplication.caste+'</td>'
							+'</tr>'
							
							+'<tr> '
//							+'<td style="background-color: black;color: white;" colspan="4" > </td> '
							+'<td style="background-color: black;color: white;" align="center"> Total </td>'
							+'<td style="background-color: black;color: white;" align="center"> Fill </td> '
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td> '
							
							+'<td style="background-color: black;color: white;" align="center"> Total </td> '
							+'<td style="background-color: black;color: white;" align="center"> Fill </td>'
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td> '
							
							+'<td style="background-color: black;color: white;" align="center"> Total </td> '
							+'<td style="background-color: black;color: white;" align="center"> Fill </td>'
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td> '
							
							+'<td style="background-color: black;color: white;" align="center"> Total </td> '
							+'<td style="background-color: black;color: white;" align="center"> Fill </td>'
							+'<td style="background-color: black;color: white;" align="center"> Vacant </td> '
							+'</tr> '
							+'</thead>');
					
					for(var i=0;i<resp.seatmatrix.length;i++){
						var bean = resp.seatmatrix[i];
						$("#tableAdm").append('<tbody>'
								+'<tr>'
								+'<td>'+bean.iti_name+'</td>'
								+'<td>'+bean.trade_name+'</td>'
								+'<td><input type="radio" name="selectedRecord" id="selectedRecord'+i+'" value="'+bean.itiCode+','+bean.tradeCode+','+resp.ranksEntity.regid+'" /></td>'
								+'<td>'+bean.strength+'</td>'
								
								+'<td>'+bean.genTotalStrength+'</td>'
								+'<td>'+bean.genTotalStrengthFill+'</td>'
								+'<td>'+bean.genTotalStrengthVacant+'</td>'
								
								+'<td>'+bean.genWTotalStrength+'</td>'
								+'<td>'+bean.genWTotalStrengthFill+'</td>'
								+'<td>'+bean.genWTotalStrengthVacant+'</td>'
								
								+'<td>'+bean.categoryTotalStrength+'</td>'
								+'<td>'+bean.categoryTotalStrengthFill+'</td>'
								+'<td>'+bean.categoryTotalStrengthVacant+'</td>'
								
								+'<td>'+bean.categoryWTotalStrength+'</td>'
								+'<td>'+bean.categoryWTotalStrengthFill+'</td>'
								+'<td>'+bean.categoryWTotalStrengthVacant+'</td>'
								
								+'</tr>'
								+'</tbody>');
					}
					 
					
				}
			}
			
			 
			
			 
			
		},
		error: function(resp){
			alert("erro=>"+JSON.stringify(resp));
			$("#checkRankResp").append('<span style="color: red;">'+resp.responseText+'</span>');
			$("#rank").val('');
			$("#schedule").val('');
			
		}
		
	});
	
	
}


function admValidate(){
	
	$("#selectedValueError").empty();
	
	var boardCode = $("#boardCode").val();
	
	if(boardCode == "" || boardCode == null){
		$("#boardCodeError").append('Type of Examination is required.');
		$("#boardCodeError").css({'color':'red'});
		$("#boardCode").focus();
		return false;
	}
	
	var idmarks1 = $("#idmarks1").val();
	if(idmarks1 == "" || idmarks1 == null){
		$("#idmarks1Error").append('ID Marks 1 is required.');
		$("#idmarks1Error").css({'color':'red'});
		$("#idmarks1").focus();
		return false;
	}
	
	var idmarks2 = $("#idmarks2").val();
	if(idmarks2 == "" || idmarks2 == null){
		$("#idmarks2Error").append('ID Marks 2 is required.');
		$("#idmarks2Error").css({'color':'red'});
		$("#idmarks2").focus();
		return false;
	}
	
	var checkedValues = document.getElementsByName('selectedRecord');
	var radioSelected = false;
	var selectedId = '';
	for(var i=0; i< checkedValues.length; i++){
		if(checkedValues[i].checked){ radioSelected = true; selectedId = checkedValues[i].value; break; }
	}
	
	if(radioSelected){
		alert('selected'+selectedId);
		$("#selectedValueError").append('');
		
		var values = selectedId.split(",");
		
		var itiCode = values[0];
		alert(itiCode);
		
		var tradeCode = values[1];
		alert(tradeCode);
		
		var regid = values[2];
		alert(regid);
		
		
		takeAdmission(itiCode,tradeCode,regid);
		
	}else{
		//alert("alert");
		$("#selectedValueError").append('Please choose trade from given below itis for taking admission for this canidate');
		$("#selectedValueError").css({'color':'red'});
		return false;
	}
	
	return false;
}

function takeAdmission(itiCode,tradeCode,regid){
	alert(itiCode);
	alert(tradeCode);
	alert(regid);
	
	
}



function checkValue(a){
	document.getElementById(a).innerHTML = '';
}
