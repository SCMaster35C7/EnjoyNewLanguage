<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

function naver(){
	var searchText=document.getElementById('searchText').value;
	var http="https://endic.naver.com/search.nhn?sLn=kr&dicQuery="+searchText+"&x=0&y=0&query="+searchText+"&target=endic&ie=utf8&query_utf=&isOnlyViewEE=N";
	window.resizeTo(750, 500);
	location.href=http;
}

function daum(){
	var searchText=document.getElementById('searchText').value;
	var http="http://dic.daum.net/search.do?q="+searchText+"&dic=eng";
	window.resizeTo(750, 500);
	location.href=http;
}
</script>
</head>
<body>
<input type="text" id="searchText" placeholder="단어를 입력하세요."><br>
<img alt="" onclick="naver()"  src="images/naver.jpg" width="150px">
<img alt="" onclick="daum()"  src="images/daum.jpg" width="150px">
</body>
</html>