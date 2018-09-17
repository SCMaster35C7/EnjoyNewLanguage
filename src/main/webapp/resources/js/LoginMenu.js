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
							$("#checkline").val('이메일 인증 먼저 해주세요!');
						}else if (resp=="loginFailure") {
							$("#checkline").val('아이디나 비밀번호가 틀렸습니다!');
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
		
		
		if (nickcheck.length<=0||nickcheck=='중복된 닉네임 입니다') {
				alert('닉네임 다시 한 번 확인해주세요');
				$("#usernick").select();
				$("#usernick").focus();
				return;
		}
		
		if($('#currpwd').val() == $('#newpwd').val()){
			alert('새로입력한 비밀번호와 현재 비밀번호가 달라야 합니다.');
			return;
		}
		
		if($('#newpwd').val() != $('#checkpwd').val()){
			alert('새로입력한 비밀번호와 비밀번호 확인 값은 같아야 합니다.');
			return;
		}
		
		if($('#newpwd').val().match($pattern)){
			
			alert('비밀번호 수정이 완료되었습니다. 다시 로그인해주세요');
			
		} else {
			alert('비밀번호는 대/소문자, 숫자, 특수 문자 포함, 8자 이상');
		
			return;
		}
		
		$('#updateMember').submit();
	
	});
	
	$('#btnCancel').on('click', function(){
		
		location.href = "${pageContext.request.contextPath}/"
	});
	
});