 /**
 * 
 */





let jwtToken = null;
let insCode = null;



function getReady(){
	
	$("#data").hide();
	//alert("getReady");
	jwtToken = localStorage.getItem('jwtToken');
	insCode =  localStorage.getItem('insCode');
	//alert("jwtToken=>"+jwtToken);
	
	if(jwtToken == null || jwtToken == ""){
		$("#contentDiv").hide();
		
		$("#navbar").hide(); 
		
		$("#404Msg").append('<h3 class="h3 text-danger">YOU DONT HAVE AUTHORIZE TO THIS PAGE</h3>');
	}else{
		//alert("else");
		jwtToken = "Bearer "+jwtToken;
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


function validate(){
	//alert("working");
	
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
	  
	  var meritListType = $("#meritListType").val();
	  //alert("meritListType=>"+meritListType);
	  
	  if(meritListType == null || meritListType == ""){
		  $("#meritListTypeError").html("Merit List Type is required.");
		  $("#meritListTypeError").css({"color": "red"}); $("#meritListType").val('');
		  $("#meritListType").focus(); return false;
	  }else{
		 // alert("insCode"+insCode);
		  $("#meritList").empty();
		  $("#data").show();
		  generateCaptcha();
    	  $("#txtInput").val('');
		  $.ajax({
              url: 'http://10.72.4.135:8888/itiapi/admissions/meritListPhaseOne?distCode='+insCode+'&action='+meritListType,
              type: 'POST',
              headers:{
             		'Authorization': jwtToken
             	},
              dataType: 'json',
              success: function (data) {
            	  //alert("success=>"+JSON.stringify(data));
            	  
            	 
            	  var count =0;
            	  var passed = "",ssc_passed="",exservice="";
            	  
            	  for(var i=0; i<data.length;i++){
            		  count = count + 1;
            		  var bean = data[i];
            		  
            		  if(bean.phc == 'true'){ passed = 'YES' }else{  passed="NO" }
            		  if(bean.ssc_passed == 'true'){ ssc_passed = 'YES' }else{  ssc_passed="NO" }
            		  if(bean.exservice == 'true'){ exservice = 'YES' }else{  exservice="NO" }
            		  
            		  $("#meritList").append('<tr>'
            				  +'<td>'+count+'</td>'
            				  +'<td>'+count+'</td>'
            				  +'<td>'+bean.regid+'</td>'
            				  +'<td>'+bean.name+'</td>'
            				  +'<td>'+bean.fname+'</td>'
            				  +'<td>'+bean.gender+'</td>'
            				  +'<td>'+bean.caste+'</td>'
            				  +'<td>'+bean.dob+'</td>'
            				  +'<td>'+ssc_passed+'</td>'
            				  +'<td>'+passed+'</td>'
            				  +'<td>'+exservice+'</td>'
            				  +'<td>'+bean.phno+'</td>'
            				  +'<td>'+bean.ssc_tot_gpa+'</td>'
            				  +'</tr>');
            	  }
            	  
            	  
              },
              error: function (error) {
                  console.log('Error fetching data:', error);
              }
          });
	  }
	  
} 
	  
function checkValue(a){
	document.getElementById(a).innerHTML = '';
}
