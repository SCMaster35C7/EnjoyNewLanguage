<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Enjoy Language</title>
<script type="text/javascript" src="scripts/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	
	$('#btnUpdate').on('click', function(){
		
		if($('#currpwd').val().length <4 || $('#currpwd').val().length>10){
			alert('비밀번호 유효성 몇자리로 합니까?');
			return;
		}
		if($('#newpwd').val().length <4 || $('#newpwd').val().length>10){
			alert('비밀번호  유효성 몇자리로 합니까?');
			return;
		}
		if($('#currpwd').val() == $('#newpwd').val()){
			alert('새로 입력한 비밀번호와 현재 비밀번호가 달라야 합니다.');
			return;
		}
		if($('#newpwd').val() != $('#checkpwd').val()){
			alert('새로 입력한 비밀번호와 비밀번호 확인 값은 같아야 합니다.');
			return;
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
	<div>회원 수정</div>3
	<form id="updateMember" action="updateMember" method="post">
	<table>
		<tr>
			<td>아이디[이메일] :</td>
			<td><input type="text" id="useremail" disabled="disabled"
				value="${sessionScope.useremail} readonly=" readonly"/></td>
		</tr>

		<tr>
			<td>이름 :</td>
			<td><input type="text" id="usernick" disabled="disabled"
				value="${sessionScope.usernick} readonly=" readonly"/></td>
		</tr>

		<tr>
			<td>현재 비밀번호 :</td>
			<td><input id="currpwd"  type="password" name="currpwd" placeholder="현재 비밀번호 입력" /></td>
		</tr>
		<tr>
			<td>새 비밀번호 입력 :</td>
			<td><input id="newpwd" type="password" name="newpwd" placeholder="새 비밀번호 입력" /></td>
		</tr>
		<tr>
			<td>새 비밀번호 확인 :</td>
			<td><input id="checkpwd" type="password"  placeholder="새 비밀번호 확인" /></td>
		</tr>
		<tr>
			<td>성별 :</td>
			<td><input type="text" id="gender" disabled="disabled"
				value="${sessionScope.gender} readonly="readonly"/></td>
		</tr>

		<tr>
			<td>생일 :</td>
			<td><input type="text"  disabled="disabled"
				value="${sessionScope.birth} readonly="readonly"/></td>
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