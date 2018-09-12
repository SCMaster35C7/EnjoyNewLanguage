<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function closeID(){
	var useremail=$('#useremail').val();
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
				var finalCheck=confirm('정말 탈퇴하시겠습니까?');
				if(finalCheck){
					alert('이용해주셔서 감사합니다. \n계정 복구는 한달안으로 가능합니다.\n 계정복구시 기존 기록을 모두 보존가능합니다.');
					$('#submitform').submit();
				}else{
					alert('취소합니다!');
					location.href="//";
				}
			}else{
				alert('아이디 또는 패스워드를 확인해주세요.');
			}
		}	
	})
}

</script>
</head>
<body>
<h4>회원탈퇴 페이지 입니다.</h4>
<h5>*회원탈퇴를 하시면 한달이내에는 아이디를 복구할 수 있습니다.</h5>
<h5>기간 이후에는 회원정보가 영구 삭제됩니다.</h5>
<form action="insertCloseID" method="post" id="submitform">
이메일 주소<input type="text" id="useremail" name="useremail" placeholder="이메일 주소를 입력하세요."><br>
</form>
패스워드<input type="password" id="pwd"><br>
<input type="button" onclick="closeID()" value="확인!">
</body>
</html>