<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="author" content="zisung">
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<!--Import materialize.css-->
	<link type="text/css" rel="stylesheet" href="css/materialize1.css"  media="screen,projection"/>
	<title>Insert title here</title>
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
	$(function() {
		//삭제버튼 클릭시 작업
		$('#btnDeleteWish').on('click', function() {
			var wishnum = $(this).attr('data-num');
			
			$.ajax({
				method : 'get',
				url : 'deleteWish',
				data : "wishtable="+2+"&identificationnum="+wishnum+"&useremail=${useremail}",
				success: function(resp) {
					console.log(resp);
					if(resp == "success") {
							location.href = "particularList?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&useremail=${useremail}&wishtable=2&distinguishNum=3";
					}else {
						alert("찜한 목록 삭제 실패");
					}
				}
			});
		});
	});	
	</script>
</head>

<body>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성일자</td>
			<td>삭제</td>
		</tr>
		<c:if test="${empty vWishlist}">
			<tr>
				<td>자막위시리스트가 비어있습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty vWishlist}">
			<c:forEach var="vWishlist" items="${vWishlist}">
				<tr>
					<td>${vWishlist.rnum}</td>	
					<td><a href="dubDetail?dubbingnum=${vWishlist.identificationnum}&currentPage=${navi.currentPage}&useremail=${useremail}&wishtable=2" target="_parent">${vWishlist.title}</a></td>
					<td>${vWishlist.regdate}</td>
					<td>
						<input type="button" class="btn waves-effect waves-light" id="btnDeleteWish" data-num="${vWishlist.identificationnum}" value="삭제"/>										
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
			
	<div class="center">
		<ul class="pagination">
			<li class="waves-effect">
				<a href="particularList?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&useremail=${useremail}&wishtable=2&distinguishNum=3">
					<i class="material-icons">first_page</i>
				</a>
			</li>
			
			<li class="waves-effect">
				<a href="particularList?currentPage=${navi.currentPage - 1}&useremail=${useremail}&wishtable=2&distinguishNum=3"> 
					<i class="material-icons">chevron_left</i>
				</a>
			</li>
			
			<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
				<c:if test="${navi.currentPage == page }">
					<li class="page-item active"><a class="page-link">${page}</a></li>
				</c:if>
				<c:if test="${navi.currentPage != page }">
					<li class="page-item"><a class="page-link"
						href="particularList?currentPage=${page}&useremail=${useremail}&wishtable=2&distinguishNum=3">${page}</a></li>
				</c:if>
			</c:forEach>
			<li class="waves-effect">
				<a href="particularList?currentPage=${navi.currentPage + 1}&useremail=${useremail}&wishtable=2&distinguishNum=3">
					<i class="material-icons">chevron_right</i> 
				</a>
			</li>
			
			<li class="waves-effect">
				<a href="particularList?currentPage=${navi.currentPage + navi.PAGE_PER_GROUP}&useremail=${useremail}&wishtable=2&distinguishNum=3">
					<i class="material-icons">last_page</i> 
				</a>
			</li>
		</ul>
	</div>
</body>
</html>