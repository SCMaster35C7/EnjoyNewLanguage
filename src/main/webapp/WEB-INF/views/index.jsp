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
			
		});
	</script>
</head>

<body>

	<h2>[Home]</h2>
	<a href="eduBoard">study board로 가보자</a> <br/>
	
	<c:if test="${empty sessionScope.userid }">
		<a href="login">login</a>
	</c:if>
	
	<c:if test="${not empty sessionScope.userid }">
		<a href="logout">logout</a>
	</c:if>
</body>
</html>
