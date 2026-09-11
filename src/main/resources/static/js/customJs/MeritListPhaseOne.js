/**
* 
*/
let jwtToken = null;
let insCode = null;



function getReady() {
	alert("getReady");


	jwtToken = localStorage.getItem('jwtToken');
	insCode = localStorage.getItem('insCode');
	alert("jwtToken=>" + jwtToken);

	if (jwtToken == null || jwtToken == "") {
		$("#contentDiv").hide();

		$("#navbar").hide();

		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
	} else {
		alert("else");
		jwtToken = "Bearer " + jwtToken;
		$("#404Msg").hide();
		$("#navbar").show();



	}
}
//<script>
//function validate() {
//    var category = document.getElementById("category").value;
//    if (category === null || category === "") {
//        document.getElementById("category").focus();
//        alert("Category is required please fill that");
//        return false;
//    }
//    var qualification = document.getElementById("qualification").value;
//    if (qualification === null || qualification === "") {
//        document.getElementById("qualification").focus();
//        alert("Qualification is required please fill that");
//        return false;
//    }
//    var status = document.getElementById("status").value;
//    if (status === null || status === "") {
//        document.getElementById("status").focus();
//        alert("Status is required please fill that");
//        return false;
//    }
//
//    return true;
//}
//</script>


function validate() {
	alert("working");

	// txtInput 
	var txtInput = $("#txtInput").val();
	var mainCaptcha = $("#mainCaptcha").val();
	if (txtInput == "" || txtInput == null) {
		$("#captchaErr").html("Captcha is required.");
		$("#captchaErr").css({ "color": "red" }); $("#txtInput").val('');
		$("#txtInput").focus(); return false;
	}
	if (txtInput !== mainCaptcha) {
		$("#captchaErr").html("Given captcha is not matched.");
		$("#captchaErr").css({ "color": "red" }); $("#txtInput").val('');
		$("#txtInput").focus(); return false;
	}

}
