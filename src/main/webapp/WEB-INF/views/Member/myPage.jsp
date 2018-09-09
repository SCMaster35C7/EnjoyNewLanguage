<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
</head>
<body>
	<a href="updateMember">회원정보수정</a>
	<br/><br/>
	이름 : ${usernick}
	<br/><br/>
	
	<c:if test="${myInfo!=null }">
	
	승률 : ${myInfo.winningRate} (승 : ${myInfo.allSuccess}/ 패 :  ${myInfo.allFailure}/ 도전: ${myInfo.allChallenge})
	<br/>
	</c:if>
	<c:if test="${myInfo==null }">
	승률 데이터 없음 하셈	
	<br/>
	</c:if>
	
	
	
	
	보고있는 영상 : 
	<c:if test="${not empty notfinished}">
		<c:forEach var="nf" items="${notfinished}">
			<a href="detailEduBoard?videoNum=${nf.videoNum}">${nf.title}</a> 
		</c:forEach>
	</c:if>
	
	<c:if test="${empty notfinished}">
		없음
	</c:if> 
	<br/>
	완료한 영상 : 
	
	<c:if test="${not empty finished}">
		<c:forEach var="f" items="${finished}">
			<a href="detailEduBoard?videoNum=${f.videoNum}"> ${f.title}</a><br/>
		</c:forEach>
	</c:if>
	<c:if test="${empty finished}">
		없음
	</c:if> 
<<<<<<< HEAD
	<a href="wishList">위시리스트[임시]</a>
=======
	
>>>>>>> Muk
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