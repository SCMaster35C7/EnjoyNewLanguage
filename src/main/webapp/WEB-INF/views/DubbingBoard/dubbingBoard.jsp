<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>더빙~~~~</title>
</head>
<body>

		글번호  &nbsp 글제목 &nbsp 닉넴 &nbsp 조회수 &nbsp 날짜 &nbsp 추천 &nbsp 비추천 <br/>
	<c:forEach var="dub" items="${dubbing}">
		${dub.dubbingnum} &nbsp
		 
		 <a href="dubDetail?dubbingnum=${dub.dubbingnum}"> ${dub.title} </a>
		 
		 &nbsp ${dub.usernick}  &nbsp ${dub.hitcount}  &nbsp ${dub.regdate} 
		 &nbsp ${dub.recommendation}  &nbsp ${dub.decommendation}<br/>
	</c:forEach>
</body>
</html>