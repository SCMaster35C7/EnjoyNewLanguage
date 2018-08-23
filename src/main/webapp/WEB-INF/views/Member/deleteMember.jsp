<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Enjoy Language</title>
<script type="text/javascript" src="scripts/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#validateDelete').on('click', deleteMember);
	
});

function deleteMember() {
	
	var useremail = $('#useremail').val();
	var userpwd = $('#userpwd').val();
	
	if(){
		
	}
	
	if(userpwd.val().length == 0){
		alert('비밀번호를 입력해주십시오');
		
		return false;
	}
}
</script>
</head>
<body>
<div>회원 탈퇴</div>
<form action="return ">
<table border="1">
<tr>
<td>아이디 : </td>
</tr>
<tr>
<td><input type="text" id="useremail" /></td>
</tr>
<tr>
<td>비밀번호 : </td>
<td><input type="text" id="userpwd" /></td>
</tr>
<tr>
<td colspan="2"><input type="button" value="회원 탈퇴"/></td>
</tr>
</table>
</form>
</body>
</html>