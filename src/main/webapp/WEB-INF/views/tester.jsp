<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function search(){
	
	var dan=document.getElementById('dan').value;
	var http="http://dic.daum.net/search.do?q="+dan+"&dic=eng";
	location.href=http;
}

function search2(){
	var dan2=document.getElementById('dan2').value;
	var http2="https://endic.naver.com/search.nhn?sLn=kr&dicQuery="+dan2+"&x=0&y=0&query="+dan2+"&target=endic&ie=utf8&query_utf=&isOnlyViewEE=N";
	var win= window.open(http2,'_black',"width=800px,height=500px");
	win.focus();
	//location.href=http2; 
}


</script>
</head>
<body>
<input type="text" id="dan" placeholder="검색할 단어를 입력하세요.">
<input type="button" value="검색 ㄱㄱ" onclick="search()">
<hr>
<input type="text" id="dan2" placeholder="검색할 단어를 입력하세요.">
<input type="button" value="검색 ㄱㄱ" onclick="search2()">
</body>
</html>