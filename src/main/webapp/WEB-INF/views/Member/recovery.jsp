<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>아이디 복구 페이지</title>
<script type="text/javascript">
function recovery(){
	$('#req').submit;
}


</script>


</head>
<body>
<input type="text" id="useremail" placeholder="이메일 주소를 입력하세요.">

<!-- 
이메일 인증을 하고 인증이 되면 해당 이메일 주소를 recoveryID tag에 넣고 recovery() 메소드 호출
 -->
<form id="req" action="recoveryID" method="post">
<input type="hidden" id="recoveryID" name="recoveryID">
</form>
</body>
</html>