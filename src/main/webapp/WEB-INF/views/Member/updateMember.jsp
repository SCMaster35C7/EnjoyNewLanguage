<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>	
<title>Enjoy Language</title>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	
	$('#btnUpdate').on('click', function(){
		
		$pattern = '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
			
		if($('#userpwd').val().match($pattern)){
			
			alert('비밀번호 형식이 맞습니다.');
			
		} else {
			alert('비밀번호는 대/소문자,  숫자, 특수 문자 포함, 8자 이상');
		}
		$('#updateMember').submit();
	
	});
	
	$('#btnCancel').on('click', function(){
		
		location.href = "${pageContext.request.contextPath}/"
	});
	
});
</script>
</head>
<body>
	<h1>회원정보수정</h1>
	<form id="updateMember" action="updateMember" method="post">
	<table border="1" >
		<tr>
			<td>아이디[이메일] :</td>
			<td>${sessionScope.useremail}</td>
		</tr>
		
		<tr>
			<td>닉네임 :</td>
			<td>${sessionScope.usernick}</td>
		</tr>
		
		<tr>
			<td>바꿀 닉네임</td>
			<td><input type="text" id="usernick" name="usernick"
				placeholder="바꿀 닉네임을 입력" /></td>
		</tr>

		<tr>
			<td>바꿀 비밀번호 :</td>
			<td><input id="userpwd"  type="password" name="userpwd" placeholder="바꿀 비밀번호 입력" /></td>
		</tr>
		<!-- <tr>
			<td>새 비밀번호 입력 :</td>
			<td><input id="newpwd" type="password" name="newpwd" placeholder="새 비밀번호 입력" /></td>
		</tr>
		<tr>
			<td>새 비밀번호 확인 :</td>
			<td><input id="checkpwd" type="password"  placeholder="새 비밀번호 확인" /></td>
		</tr> -->
		
		<tr>
			<td>성별 :</td>
			<td>${sessionScope.gender}</td>
		</tr>

		<tr>
			<td>생일 :</td>
			<td>${sessionScope.birth}</td>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
			<input type="button" value="수정" id="btnUpdate" />
			<input type="button" value="취소" id="btnCancel" />
			</td>			
		</tr>
	</table>
	</form>
</body>
</html>