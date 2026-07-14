/**
 * 
 */
let allSSCBoards = null;
let dists = null;

let jwtToken = null;

function getReady(){
	//alert("getReady");
	
	jwtToken = localStorage.getItem('jwtToken');
	insCode =  localStorage.getItem('insCode');
	//alert("jwtToken=>"+jwtToken);
	
	if(jwtToken == null || jwtToken == ""){
		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
		$("#navbar").hide();
		$("#contentDiv").hide();
	}else{
		//alert("else");
		jwtToken = "Bearer "+jwtToken;
		$("#404Msg").hide(); 
		$("#navbar").show(); 
		$("#contentDiv").show(); 
		printData();
	}
}


function printData(){
	//alert("printdata");
	
		 var regid = $("#regid").val();
		 var dob = $("#dob").val();
		 var ssc_regno = $("#ssc_regno").val();
		 var convertedDate = changeDateFormat(dob);
		getAllSSCBoards(function(boards) {
			allSSCBoards = boards;
			$.ajax({
				type : 'post',
				url: 'http://10.72.4.135:5051/checkRegOrNot?sscRegno='+ssc_regno+'&regid='+regid+'&dob='+dob, // Local backend
				cache : false,
				timeout : 6000000,
				success : function(resp) {
					$("#registrationId").append(resp.studentApplication.regid);

					var imgElement = document.createElement("img");
					imgElement.src = 'data:image/png;base64,'+ resp.imageCandPhotosEntity.image;
					imgElement.width = 120;
					imgElement.height = 150;
					document.getElementById("imageContainer").appendChild(imgElement);
					
					$('#qualificationDetails').append('<tr><td>Hall Ticket</td><td class="fw-bold">: '+resp.studentApplication.sscRegno+'</td></tr>');
					var sscBoard = resp.studentApplication.sscBoard;
					for(var j=0; j < allSSCBoards.length; j++){
						var bean = allSSCBoards[j];
						if(sscBoard == bean.boardCode){
							$('#qualificationDetails').append('<tr><td>Board</td><td class="fw-bold">: '+bean.boardName+'</td></tr>');
						}
					}
					$('#qualificationDetails').append('<tr><td>Year of Pass</td><td class="fw-bold">: '+resp.studentApplication.sscYear+'</td></tr>');
					var formattedDate = formatDateString(resp.studentApplication.verifiedDate);
					$('#qualificationDetails').append('<tr><td>Verified Date</td><td class="fw-bold">: '+formattedDate+'</td></tr>');
					$('#qualificationDetails').append('<tr><td>Verified By</td><td class="fw-bold">: '+resp.studentApplication.userId+'</td></tr>');
					
					
					
					
					$('#personalDetails').append('<tr><td>Name</td><td class="fw-bold">'+resp.studentApplication.name+'</td></tr>');
					$('#personalDetails').append('<tr><td>Father Name</td><td class="fw-bold">'+resp.studentApplication.fname+'</td></tr>');
					$('#personalDetails').append('<tr><td>Mother Name</td><td class="fw-bold">'+resp.studentApplication.mname+'</td></tr>');
					$('#personalDetails').append('<tr><td>D.O.B</td><td class="fw-bold">'+resp.studentApplication.dob+'</td></tr>');
					$('#personalDetails').append('<tr><td>Address</td><td class="fw-bold">'+resp.studentApplication.addr+'</td></tr>');
					$('#personalDetails').append('<tr><td>Pincode</td><td class="fw-bold">'+resp.studentApplication.pincode+'</td></tr>');
					
					$('#reservationDetails').append('<tr><td>Gender</td><td class="fw-bold">'+resp.studentApplication.gender+'</td></tr>');
					$('#reservationDetails').append('<tr><td>Caste</td><td class="fw-bold">'+resp.studentApplication.caste+'</td></tr>');
					$('#reservationDetails').append('<tr><td>Ex-Service</td><td class="fw-bold">'+resp.studentApplication.exservice+'</td></tr>');
					
					//alert(resp.studentApplication.phc);
					if(resp.studentApplication.phc == true){
						$('#reservationDetails').append('<tr><td>Physically Handicapped</td><td class="fw-bold">YES</td></tr>');
					}else{
						$('#reservationDetails').append('<tr><td>Physically Handicapped</td><td class="fw-bold">NO</td></tr>');
					}
					
					$('#reservationDetails').append('<tr><td>Local Status</td><td class="fw-bold">'+resp.studentApplication.local+'</td></tr>');
					$('#reservationDetails').append('<tr><td>Aadhar No</td><td class="fw-bold">'+resp.studentApplication.adarno+'</td></tr>');
					$('#reservationDetails').append('<tr><td>Phone No</td><td class="fw-bold">'+resp.studentApplication.phno+'</td></tr>');
					
					if(resp.studentApplication.sscDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>SSC/Equivalent Marks</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.sscDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>SSC/Equivalent Marks</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>SSC/Equivalent Marks</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					if(resp.studentApplication.transferDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>Transfer Certificate</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.transferDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>Transfer Certificate</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>Transfer Certificate</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					if(resp.studentApplication.casteDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>Caste Certificate</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.casteDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>Caste Certificate</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>Caste Certificate</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					if(resp.studentApplication.physicallyDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>Physically challenged(If applicable)</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.physicallyDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>Physically challenged(If applicable)</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>Physically challenged(If applicable)</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					if(resp.studentApplication.exServiceDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>Ex-Serviceman(If applicable)</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.exServiceDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>Ex-Serviceman(If applicable)</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>Ex-Serviceman(If applicable)</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					if(resp.studentApplication.studyDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>Study Certificate</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.studyDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>Study Certificate</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>Study Certificate</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					if(resp.studentApplication.nativityDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>Nativity Certificate</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.nativityDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>Nativity Certificate</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>Nativity Certificate</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					if(resp.studentApplication.uidDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>UID</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.uidDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>UID</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>UID</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					if(resp.studentApplication.ewsDocVerify == 'Y'){
						$('#docverifiedDetails').append('<tr><td>EWS</td><td class="fw-bold">Yes</td></tr>');
					}else if(resp.studentApplication.ewsDocVerify == 'N'){
						$('#docverifiedDetails').append('<tr><td>EWS</td><td class="fw-bold">No</td></tr>');
					}else{
						$('#docverifiedDetails').append('<tr><td>EWS</td><td class="fw-bold">Not Applicable</td></tr>');
					}
					
					window.print();
					
				},
				error : function(resp) {
					alert("error=>"+resp);
					 $("#msg").html(resp);
				}
			});
		});
		 
	 }
