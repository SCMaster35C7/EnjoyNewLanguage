<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Enjoy Language</title>
<script type="text/javascript" src="scripts/jquery-3.3.1.min.js"></script>
</head>
<body>
	<div>회원 수정</div>
	<form action="updateMember" method="post"></form>
	<table>
	<tr>
	<td>아이디[이메일] : </td>
	<td><input type="text" disabled="disabled" value="${sessionScope.useremail} readonly="readonly"/></td>	
	</tr>
	<tr>
	<td></td>
	</tr>
	<tr>
	<td>비밀번호 : </td>
	<td><input type="text"  /> </td>
	</tr>
	
	</table>
</body>
</html>