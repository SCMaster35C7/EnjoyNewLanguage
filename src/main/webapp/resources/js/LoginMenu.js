$('#loginBtn').on('click', function() {
				var useremail = $('#useremail').val();
				var userpwd = $('#userpwd').val();
				
				var sendData = {	
						"useremail":useremail
						,"userpwd": userpwd
				};
				
				$.ajax({
					method	:	'post'
					, url	: 'statusCheck'
					, data	: JSON.stringify(sendData)
					, dataType	: 'text'
					, contentType: 'application/json; charset=utf-8'
					, success	: function(resp){
						if (resp=="checkEmail") {
							$("#checkline").val('Please check your email first.');
						}else if (resp=="loginFailure") {
							$("#checkline").val('Please check your ID or password.');
						} else {
							window.location.reload();
						}
					}, error:function(resp, code, error) {
						alert("resp : "+resp+", code:"+code+", error:"+error);
					}
				});//ajax
			});


//회원탈퇴
function closeID(){
	var useremail=$('#checkuseremail').val();
	var pwd=$('#pwd').val();
	var dataForm={
			"useremail":useremail,
			"userpwd":pwd
	}
	
	$.ajax({
		method:'post'
		, url:'closeIDsubmit'
		, data:JSON.stringify(dataForm)
		, contentType: "application/json; charset=utf-8"
		, success:function(resp){
			if(resp=='ok'){
				var finalCheck=confirm('Are you sure you want to leave?');
				if(finalCheck){
					$('#submitform').submit();
				}else{
					alert('Cancel!');
					location.href="//";
				}
			}else{
				alert('Please check your ID or password.');
			}
		}	
	})
}

//인증메일 재발송하기
function checkResend() {
	var useremail=$('#resendemail').val();
	var pwd=$('#resendpwd').val();
	var dataForm={
			"useremail":useremail,
			"userpwd":pwd
	}
	
	$.ajax({
		method:'post'
		, url:'resendValidate'
		, data:JSON.stringify(dataForm)
		, dataType	: 'text'
		, contentType: "application/json; charset=utf-8"
		, success:function(resp){
			if(resp=='ok'){
					$('#resendForm').submit();
			}else{
				alert('Enter invalid email or mail is already authenticated.');
			}
		}	
	})
}

//회원정보수정
$(function(){
	//닉네임중복검사
	$('#usernick').keyup(function(){
		
		var usernick = $(this).val();   			
			
			$.ajax({
					method	:	'post'
					,url	: 'nickCheck'
					,data	: "usernick="+usernick
					,dataType	: 'text'
					,success	: function(resp){
						
						$("#nickcheck").text(resp);
						/* if(resp=='true'){
							$("#nickcheck").text("사용가능!!!!! 아이디입니다.");
						}else{
							$("#nickcheck").html('<span style="color: red; font-weight: bold;">중복된 아이디입니다.</span>');
						}  */
						
	            	 	
				}, error:function(resp, code, error) {
					alert("resp : "+resp+", code:"+code+", error:"+error);
				}    					
			});    			
	});
	
	$('#btnUpdate').on('click', function(){
		
		var usernick = $("#usernick").val();
		var nickcheck = $("#nickcheck").text();
		
		$pattern = '^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';			
		
		
		if (nickcheck.length<=0||nickcheck=='The nickname is already existed') {
				alert('Please check your nickname one more time');
				$("#usernick").select();
				$("#usernick").focus();
				return;
		}
		
		if($('#currpwd').val() == $('#newpwd').val()){
			alert('The new password and current password must be different.');
			return;
		}
		
		if($('#newpwd').val() != $('#checkpwd').val()){
			alert('The new password and the confirm password must be same.');
			return;
		}
		
		if($('#newpwd').val().match($pattern)){
			
			alert('The password is successfully changed. Please Login again');
			
		} else {
			alert('Password must be eight characters including one uppercase letter, one special character and alphanumeric characters');
		
			return;
		}
		
		$('#updateMember').submit();
	
	});
	
	$('#btnCancel').on('click', function(){
		
		location.href = "${pageContext.request.contextPath}/"
	});
	
});

function check() {
	var recoveryEmail = $("#recoveryEmail").val();
	//alert(recoveryEmail);
	$.ajax({
		type : 'post',
		url : 'selectInConfirm',
		data : recoveryEmail,
		dataType:'text',
		contentType: "application/text; charset=UTF-8",
		success : function(resp){
			if (resp=="notok") {
				alert("이메일을 다시 한 번 확인해주세요.");
			} else {
				$('#req').submit();
			}
		}
	});
}