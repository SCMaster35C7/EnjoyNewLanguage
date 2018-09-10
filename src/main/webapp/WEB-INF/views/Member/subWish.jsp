<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function () {
	var dataFormSub = {
			
			"idCode":"subtitlenum", 
			"useremail":useremail, 
			"title":title,			
			"url":url,	
			"regDate":regDate		
	};

	$.ajax({
		method:'post'
		, url:'insertSubWish'
		, data: JSON.stringify(dataFormSub)
		, contentType: "application/json; charset=utf-8"
		, async : false
		, success:function(resp) {
			
			if(resp != 1){
				alert("자막이 등록되었습니다.");
			}else{
				alert("중복된 자막이 있습니다.");
			}
		 }
		, error:function(resp, code, error) {
			alert("resp : "+resp+", code : "+code+", error : "+error);
		}
	});
});



</script>
</head>
<body>

</body>
</html>