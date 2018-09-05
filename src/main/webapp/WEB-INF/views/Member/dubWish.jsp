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
	
});

var dataFormDub = {
		"tableName":"dubwish", 
		"idCode":"dubbingnum", 
		"useremail":useremail, 
		"title":title,			
		"url":url,	
		"wishnum":dubbingnum,		
};

$.ajax({
	method:'post'
	, url:'dubwish'
	, data: JSON.stringify(dataFormDub)
	, contentType: "application/json; charset=utf-8"
	, async : false
	, success:function(resp) {
		
	 }
	, error:function(resp, code, error) {
		alert("resp : "+resp+", code : "+code+", error : "+error);
	}
});
</script>
</head>
<body>

</body>
</html>