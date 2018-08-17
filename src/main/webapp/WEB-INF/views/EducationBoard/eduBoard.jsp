<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Enjoy Language</title>
	
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script>
		$(function() {
			$('#addEduVideo').on('click', function() {
				location.href = "addEduVideo";
			});
		});
	</script>
</head>
<body>
	<h2>[Study Board]</h2>
	
	<table border="1">
		<tr>
			<th>제목</th>
			<th>등록일</th>
			<th>조회수</th>
			<th>추천수</th>
			<th>비추천수</th>
		</tr>
	<c:if test="${not empty eduList}">
		<c:forEach var="eduList" items="${eduList}">
			<tr>
				<td><a href="detailEduBoard?videoNum=${eduList.videoNum}">${eduList.videoNum}번 영상  시청</a></td>
				<td>${eduList.regDate}</td>
				<td>${eduList.hitCount}</td>
				<td>${eduList.recommendation}</td>
				<td>${eduList.decommendation}</td>
			</tr>
		</c:forEach>
	</c:if>
	</table>
	
	<c:if test="${(not empty sessionScope.admin) and sessionScope.admin == 0}">
		<input type="button" id="addEduVideo" value="영상추가"/>
	</c:if>
</body>
</html>