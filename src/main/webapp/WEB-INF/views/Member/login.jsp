<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Enjoy Language</title>
	
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script>
		$(function() {
			$('#loginBtn').on('click', function() {
				var useremail = $('#useremail');
				var userpwd = $('#userpwd');
				
				$('#loginForm').submit();
			});
		});
	</script>
</head>

<body>
	<h2>[로그인 페이지]</h2>
	<c:if test="${not empty message}">
		<p style="color:red;"><b>${message}</b></p>
	</c:if>
	
	<form id="loginForm" action="login" method="POST">
		<table border="1">
			<tr>
				<td>아이디 </td>
				<td><input type="text" id="useremail" name="useremail" value="${useremail}" /></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" id="userpwd" name="userpwd" value="${userpwd}"/></td>
			</tr>
			<tr>
				<td colspan="2"> 
					<input type="button" id="loginBtn" value="로그인"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
