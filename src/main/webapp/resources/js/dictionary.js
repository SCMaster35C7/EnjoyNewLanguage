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