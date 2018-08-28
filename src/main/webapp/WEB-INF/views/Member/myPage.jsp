<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
</head>
<body>
	<a href="updateMember">회원정보수정</a>
	<br/><br/>
	이름 : ${myInfo.usernick}
	<br/>
	<br/>
	승률 : ${myInfo.winningRate} (승 : ${myInfo.allSuccess}/ 패 :  ${myInfo.allFailure}/ 도전: ${myInfo.allChallenge})
	<br/>
	보고있는 영상 : 
		<c:forEach var="nf" items="${notfinished}">
			<a href="detailEduBoard?videoNum=${nf.videoNum}">${nf.title}</a> 
		</c:forEach>
	<br/>
	완료한 영상 : 
		<c:forEach var="f" items="${finished}">
			<a href="detailEduBoard?videoNum=${f.videoNum}"> ${f.title}</a><br/>
		</c:forEach>
	<br/>
	
	
 <c:forEach var="m" items="${levelMap}">
		 
		
		<c:if test="${m.key==1}">
			레벨1 : ${m.value}
		</c:if>
		
		<c:if test="${m.key==2}">
			레벨2 : ${m.value}
		</c:if>
		
		<c:if test="${m.key==3}">
			레벨3 : ${m.value}
		</c:if>
		
		<c:if test="${m.key==4}">
			레벨4 : ${m.value}
		</c:if>
		
		<c:if test="${m.key==5}">
			레벨5 : ${m.value}
		</c:if>
		
		</c:forEach> 
</body>
</html>