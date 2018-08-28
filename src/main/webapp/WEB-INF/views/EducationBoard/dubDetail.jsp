<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	${dubbing}
	<br/>
	<a href="recomm?dubbingnum=${dubbing.dubbingnum}">추천!</a>
	<br/>
	<a href="decomm">비추천ㅠ</a>
	<br/>
</body>
</html>