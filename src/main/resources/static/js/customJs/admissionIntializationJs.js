/**
 * Admission Process Initialization - page /PrintAdmissionSlip
 * (WEB-INF/checkmeritschedule/admissionIntialization.jsp).
 *
 * Re-pointed 2026-09-30 off the /itiapi facade, a namespace no project on this
 * machine defines (WRONG_IMPLEMENTATIONS.md, Issue 2). The real API is
 * AdmissionPhaseController in the Backend:
 *
 *   GET  /api/admission-phase/all                          - list every row
 *   POST /api/admission-phase/save                         - insert/overwrite one row
 *   PUT  /api/admission-phase/update/{year}/{phase}/{itiType}
 *
 * Ghost field -> AdmissionPhaseDto mapping (the ghost names matched no column):
 *   admYear                     -> year (varchar(4) key, sent as a string)
 *   currentPhase                -> phase
 *   itiTypeG / itiTypeP         -> itiType. admission_phase is keyed by
 *                                  (year, phase, iti_type), so one submit writes one
 *                                  'G' row and, for phase > 1, one 'P' row - the form
 *                                  keeps a single date set for both ITI types.
 *   applicationFromDate/ToDate  -> applicationFromDate/applicationToDate
 *   verificationFromDate/ToDate -> verificationStartDate/verificationEndDate
 *   meritListFromDate/ToDate    -> meritListStartDate/meritListToDate
 *   admissionsGovtFromDate/ToDate -> admissionsStartDate/admissionsEndDate ('G' row)
 *   admissionsPvtFromDate/ToDate  -> admissionsStartDate/admissionsEndDate ('P' row)
 *
 * The form has no fields for fromdate/todate, seatmatrix_phase, admission_role,
 * lid, trno or reverification*, and PUT rewrites every column of its target row,
 * so those values are read back from GET /all and echoed into the payload
 * untouched. A brand-new row is written with current = false: the single
 * current = true row is what MeritListService, TradeSelectionService and
 * AdmissionTimingRepository key on, and this screen has no UI to move that flag.
 *
 * The old gate read localStorage 'jwtToken', which nothing in this application
 * sets any more, so every visitor fell into the "not authorized" branch. It now
 * uses the session check the other checkmeritschedule pages use: LoginController
 * puts roleId/insCode in the HTTP session and the JSP publishes it as
 * SESSION_ROLE_ID.
 */
const API_BASE_URL = window.API_BASE_URL;
const ADMISSION_PHASE_API = API_BASE_URL + '/api/admission-phase';

/* One entry per (year, phase): {key, year, phase, G: row|null, P: row|null}.
   Built by groupAdmissionPhases() from GET /all, read by the table renderer and
   by updateCurrentPhaseDetails(index). */
let admissionPhaseGroups = null;
/* The flat GET /all response, kept under the original global name. */
let availableAdmissionPhaseData = null;
/* Group the table's Update button loaded into the form; null while creating. */
let activeUpdateGroup = null;

function checkToken(){
	if(typeof SESSION_ROLE_ID === 'undefined' || SESSION_ROLE_ID === null || SESSION_ROLE_ID === ''){
		$("#contentDiv").hide();
		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
		return false;
	}
	
	$("#404Msg").hide();
	changeValuesAsNull();
	$("#updateButton").hide();
	
	// the field is read-only in the JSP; it doubles with phase for the row key
	$("#admYear").val(new Date().getFullYear());
	
	for(var i=1; i < 10; i++){
		$("#currentPhase").append('<option value="'+i+'">Phase - '+i+'</option>');
	}
	
	$("#itiTypeGDiv").hide();
	$("#itiTypePDiv").hide();
	
	getAdmissionPhaseData();
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
/* datetime-local inputs already hold "YYYY-MM-DDTHH:mm[:ss]" - the ISO form
   Jackson binds to LocalDateTime. Empty inputs must travel as JSON null. */
function toIsoDateTime(value){
	return (value == null || value === '') ? null : value;
}

/* Row already stored for (year, phase, itiType), or {} when there is none. */
function existingRowFor(year, phase, itiType){
	var groups = admissionPhaseGroups || [];
	for(var i = 0; i < groups.length; i++){
		var group = groups[i];
		if(String(group.year) === String(year) && Number(group.phase) === Number(phase)){
			return (itiType === 'P' ? group.P : group.G) || {};
		}
	}
	return {};
}

/* One AdmissionPhaseDto for the current form state. `existing` supplies the
   columns the form does not expose, so a save/PUT cannot blank them. */
function buildAdmissionPhaseRow(itiType, existing){
	var row = existing || {};
	var isGovt = itiType === 'G';
	return {
		year: String($("#admYear").val()),
		phase: parseInt($("#currentPhase").val(), 10),
		itiType: itiType,
		fromDate: row.fromDate || null,
		toDate: row.toDate || null,
		seatmatrixPhase: row.seatmatrixPhase == null ? null : row.seatmatrixPhase,
		admissionRole: row.admissionRole == null ? null : row.admissionRole,
		lid: row.lid == null ? null : row.lid,
		current: row.current == null ? false : row.current,
		trno: row.trno == null ? null : row.trno,
		applicationFromDate: toIsoDateTime($("#applicationFromDate").val()),
		applicationToDate: toIsoDateTime($("#applicationToDate").val()),
		verificationStartDate: toIsoDateTime($("#verificationFromDate").val()),
		verificationEndDate: toIsoDateTime($("#verificationToDate").val()),
		meritListStartDate: toIsoDateTime($("#meritListFromDate").val()),
		meritListToDate: toIsoDateTime($("#meritListToDate").val()),
		admissionsStartDate: toIsoDateTime(isGovt ? $("#admissionsGovtFromDate").val() : $("#admissionsPvtFromDate").val()),
		admissionsEndDate: toIsoDateTime(isGovt ? $("#admissionsGovtToDate").val() : $("#admissionsPvtToDate").val()),
		reverificationStartDate: row.reverificationStartDate || null,
		reverificationEndDate: row.reverificationEndDate || null
	};
}

/* Rows the current form implies: always the 'G' row, plus 'P' once the phase is
   past 1 - changingPhase() only exposes the private-ITI block for phase > 1. */
function formRows(){
	var year = $("#admYear").val();
	var phase = parseInt($("#currentPhase").val(), 10);
	var rows = [buildAdmissionPhaseRow('G', existingRowFor(year, phase, 'G'))];
	if(phase > 1){
		rows.push(buildAdmissionPhaseRow('P', existingRowFor(year, phase, 'P')));
	}
	return rows;
}

/* One ajax call per entry; reports how many failed. POST /save is the backend's
   insert-or-overwrite by primary key; the entries decide between PUT /update/...
   for rows that already exist and POST for rows the form is creating. */
function persistEntries(entries, onSettled){
	var pending = entries.length;
	var failed = 0;
	entries.forEach(function(entry){
		$.ajax({
			type: entry.method,
			contentType: "application/json",
			url: entry.url,
			data: JSON.stringify(entry.row),
			cache: false,
			timeout: 600000,
			success: function(){
				if(--pending === 0 && onSettled){ onSettled(failed); }
			},
			error: function(xhr){
				failed++;
				$("#mainError").html('Could not save ' + entry.row.itiType + ' entry: ' + (xhr.responseText || xhr.status));
				$("#mainError").css({"color":"red"});
				if(--pending === 0 && onSettled){ onSettled(failed); }
			}
		});
	});
}

function saveEntries(rows){
	return rows.map(function(row){
		return { row: row, method: 'POST', url: ADMISSION_PHASE_API + '/save' };
	});
}

/* PUT the rows that already exist (that path carries the primary key and 404s
   otherwise), POST the ones the form is adding. */
function updateEntries(rows){
	var group = activeUpdateGroup;
	return rows.map(function(row){
		var exists = group != null && (row.itiType === 'P' ? group.P : group.G) != null;
		return exists
			? { row: row, method: 'PUT', url: ADMISSION_PHASE_API + '/update/' + row.year + '/' + row.phase + '/' + row.itiType }
			: { row: row, method: 'POST', url: ADMISSION_PHASE_API + '/save' };
	});
}

function sendDataTOApi(){
	persistEntries(saveEntries(formRows()), function(failed){
		if(failed > 0){
			return; // persistEntries already wrote the failing row to #mainError
		}
		changeValuesAsNull();
		$("#mainSuccessError").html('Admission Phase Saved Successfully');
		$("#mainSuccessError").css({"color":"green"});
		getAdmissionPhaseData();
	});
}

/* GET /all returns one row per (year, phase, iti_type); the table shows one row
   per phase, so fold the G and P rows of a phase together, newest first. */
function groupAdmissionPhases(rows){
	var groups = [];
	var byKey = {};
	(rows || []).forEach(function(row){
		if(row == null || row.year == null || row.phase == null){
			return;
		}
		var key = row.year + '|' + row.phase;
		var group = byKey[key];
		if(!group){
			group = { key: key, year: row.year, phase: row.phase, G: null, P: null };
			byKey[key] = group;
			groups.push(group);
		}
		if(row.itiType === 'P'){ group.P = row; } else { group.G = row; }
	});
	groups.sort(function(a, b){
		return String(b.year).localeCompare(String(a.year)) || (Number(b.phase) - Number(a.phase));
	});
	return groups;
}

function cell(value){
	return value == null ? '' : value;
}

function getAdmissionPhaseData(){
	$("#admissionData").empty();
	$.ajax({
		type: "GET",
		contentType: "application/json",
		url: ADMISSION_PHASE_API + "/all",
		cache: false,
		timeout: 600000,
		success: function (data) {
			availableAdmissionPhaseData = data;
			admissionPhaseGroups = groupAdmissionPhases(data);
			if(admissionPhaseGroups.length === 0){
				$("#admissionData").append('<tr>'
							+'<td colspan="12" style="text-align: center;color:red;font-weight: bolder;">No Current Admission Phase Details are available.</td>'
							+'</tr>');
				return;
			}
			admissionPhaseGroups.forEach(function(group, index){
				// Once-per-phase windows come from whichever row exists (phase 1 has only a
				// P row in the data today); the admission windows are per ITI type.
				var common = group.G || group.P || {};
				$("#admissionData").append('<tr>'
							+'<td>'+cell(group.year)+'</td>'
							+'<td>'+cell(group.phase)+'</td>'
							+'<td>'+cell(common.applicationFromDate)+'</td>'
							+'<td>'+cell(common.applicationToDate)+'</td>'
							+'<td>'+cell(common.verificationStartDate)+'</td>'
							+'<td>'+cell(common.verificationEndDate)+'</td>'
							+'<td>'+cell(common.meritListStartDate)+'</td>'
							+'<td>'+cell(common.meritListToDate)+'</td>'
							+'<td>'+cell(group.G == null ? '' : group.G.admissionsStartDate)+'</td>'
							+'<td>'+cell(group.G == null ? '' : group.G.admissionsEndDate)+'</td>'
							+'<td>'+cell(group.P == null ? '' : group.P.admissionsStartDate)+'</td>'
							+'<td>'+cell(group.P == null ? '' : group.P.admissionsEndDate)+'</td>'
							+'</tr>');
				$("#admissionData").append('<tr>'
							+'<td colspan="12" style="text-align: center;"><button class="btn btn-warning" onclick="return updateCurrentPhaseDetails('+index+')">Update</button></td>'
							+'</tr>');
			});
		},
		error: function (xhr) {
			$("#mainError").html('Could not load admission phase details: ' + (xhr.responseText || xhr.status));
			$("#mainError").css({"color":"red"});
		}
	});
}

/* Load the group behind the table's Update button back into the form. */
function updateCurrentPhaseDetails(index){
	var group = (admissionPhaseGroups || [])[index];
	if(!group){
		return false;
	}
	activeUpdateGroup = group;
	$("#admissionData button").hide();
	
	$("#admYear").val(group.year);
	$("#currentPhase").val(String(group.phase));
	
	var common = group.G || group.P || {};
	$("#applicationFromDate").val(cell(common.applicationFromDate));
	$("#applicationToDate").val(cell(common.applicationToDate));
	$("#verificationFromDate").val(cell(common.verificationStartDate));
	$("#verificationToDate").val(cell(common.verificationEndDate));
	$("#meritListFromDate").val(cell(common.meritListStartDate));
	$("#meritListToDate").val(cell(common.meritListToDate));
	
	// Same show/hide as changingPhase(), without its "clear the fields" step.
	$("#itiTypeGDiv").show();
	$("#admissionsGovtFromDate").val(cell(group.G == null ? '' : group.G.admissionsStartDate));
	$("#admissionsGovtToDate").val(cell(group.G == null ? '' : group.G.admissionsEndDate));
	if(Number(group.phase) === 1){
		$("#itiTypePDiv").hide();
		$("#admissionsPvtFromDate").val('');
		$("#admissionsPvtToDate").val('');
	}else{
		$("#itiTypePDiv").show();
		$("#admissionsPvtFromDate").val(cell(group.P == null ? '' : group.P.admissionsStartDate));
		$("#admissionsPvtToDate").val(cell(group.P == null ? '' : group.P.admissionsEndDate));
	}
	$("#submitButton").hide();
	$("#updateButton").show();
	return false;
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
	
	// The validations above already ran in updateData().
	persistEntries(updateEntries(formRows()), function(failed){
		if(failed > 0){
			return; // persistEntries already wrote the failing row to #mainError
		}
		$("#mainSuccessError").html('Admission Phase Updated Successfully');
		$("#mainSuccessError").css({"color":"green"});
		changeValuesAsNull();
		getAdmissionPhaseData();
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
	
	$("#mainError").html('');
	$("#mainSuccessError").html('');
	
	activeUpdateGroup = null;
	$("#submitButton").show();
	$("#updateButton").hide();
}
