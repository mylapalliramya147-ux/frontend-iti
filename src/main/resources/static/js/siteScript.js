/**
 * 
 */
// API_BASE_URL is injected by the JSP before this script loads via window.API_BASE_URL
const API_BASE_URL = window.API_BASE_URL;


function checkValue(errorId) {
	$("#" + errorId).html("");
}

/**
 * Generates captcha by fetching text from the Frontend /captcha/text endpoint
 * (served by CaptchaController) and populating the mainCaptcha input field.
 * Falls back to local generation if the endpoint is unavailable.
 */
function generateCaptcha() {
	$.ajax({
		url: "/captcha/text",
		method: "GET",
		xhrFields: { withCredentials: true },
		success: function (response) {
			var captchaElem = document.getElementById("mainCaptcha");
			if (captchaElem) {
				captchaElem.value = response.trim();
			}
		},
		error: function () {
			console.error("Failed to generate captcha from server. Falling back to local generation.");
			var alpha = new Array('1', '2', '3', '4', '5', '6', '7', '8', '9', '0');
			var code = '';
			for (var i = 0; i < 4; i++) {
				code += alpha[Math.floor(Math.random() * alpha.length)];
			}
			var captchaElem = document.getElementById("mainCaptcha");
			if (captchaElem) {
				captchaElem.value = code;
			}
		}
	});
}

function getAllCastes(callback) {
    var url = API_BASE_URL + '/api/student/castes';
	$.ajax({
		type: 'GET',
		url: url,
		xhrFields: { withCredentials: true },
		success: function (resp) {
			if (callback) callback(resp);
		},
		error: function () {
			console.error("Failed to fetch Castes from server.");
			if (callback) callback([]);
		}
	});
}

/**
 * Returns SSC boards list. The Backend has no dedicated SSC-boards endpoint,
 * so this returns an empty array immediately — callers populate board
 * dropdowns via the student's stored sscBoard field instead.
 */
function getAllSSCBoards(callback) {
    if (callback) callback([]);
}

function getBoardName(boardCode, callback) {
	getAllSSCBoards(function (boards) {
		var boardName = "";
		for (var i = 0; i < boards.length; i++) {
			var bean = boards[i];
			if (bean.boardCode == boardCode) {
				boardName = bean.boardName;
			}
		}
		if (callback) callback(boardName);
	});
}
function getCastesName(category_code, callback) {
	getAllCastes(function (castes) {
		var category_name = "";
		for (var i = 0; i < castes.length; i++) {
			var bean = castes[i];
			if (bean.category_code == category_code) {
				category_name = bean.category_name;
			}
		}
		if (callback) callback(category_name);
	});
}

function changeDateFormat(date) {
	var convertedDate = '';
	var parts = date.split('-');
	var year = parts[0];
	var month = parts[1];
	var day = parts[2];

	convertedDate = day + '-' + month + '-' + year;

	return convertedDate;
}

function formatDateString(originalDateString) {
	// Parse the original date string
	const originalDate = new Date(originalDateString);

	// Extract date components
	const day = originalDate.getDate().toString().padStart(2, '0');
	const month = (originalDate.getMonth() + 1).toString().padStart(2, '0'); // Months are zero-based
	const year = originalDate.getFullYear();
	const hours = originalDate.getHours().toString().padStart(2, '0');
	const minutes = originalDate.getMinutes().toString().padStart(2, '0');
	const seconds = originalDate.getSeconds().toString().padStart(2, '0');

	// Format the date as "DD-MM-YYYY HH:mm:ss"
	const formattedDate = `${day}-${month}-${year} ${hours}:${minutes}:${seconds}`;

	return formattedDate;
}

function getBase64FromFile(file, callback) {
	const reader = new FileReader();
	reader.onloadend = function () {
		callback(reader.result.split(',')[1]);
	};
	reader.readAsDataURL(file);
}


