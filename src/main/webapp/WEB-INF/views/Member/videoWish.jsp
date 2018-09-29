<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="zisung">
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
		$('#btnDeleteVideoWish').on('click', function() {
			
			var wishnum = $(this).attr('data-rno');
			$.ajax({
				type : 'get',
				url : 'replyDelete',
				data : 'wishnum=' + wishnum,
				success : init
			})
		});	
		//취소버튼 클릭시 이동
		$('#btnCancel').on('click', function() {		
			location.href = "${pageContext.request.contextPath}/"
		});		
	});	
	
	/* $(function() {

		var dataFormVideo = {
			"tableName" : "videowish",
			"idCode" : "videonum",
			"useremail" : useremail,
			"title" : title,
			"url" : url,
			"wishnum" : videonum
		};

		$.ajax({
			method : 'post',
			url : 'insertVideoWish',
			data : JSON.stringify(dataFormVideo),
			contentType : "application/json; charset=utf-8",
			async : false,
			success : function(resp) {
				alert("영상위시리스트에 등록되었습니다.");
				
			},
			error : function(resp, code, error) {
				alert("resp : " + resp + ", code : " + code + ", error : " + error);
			}
		});
	}); */
</script>
</head>
<body>
	<div id="wrapper">
		<c:if test="${sessionScope.useremail!=null}">
			<table border="1">
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성일자</td>
					<td>삭제</td>
				</tr>
				<c:if test="${empty vWishlist}">
					<tr>
						<td>영상위시리스트가 비어있습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty vWishlist}">
					<c:forEach var="vWishlist" items="${vWishlist}">
						<tr>								
							<td>${vWishlist.rnum}</td>								
							<td><a href="detailEduBoard?videoNum=${vWishlist.identificationnum}&currentPage=${navi.currentPage}&useremail=${useremail}&wishtable=0" target="_parent">${vWishlist.title}</a></td>
							<td>${vWishlist.regdate}</td>
							<td>
								<input type="button" class="btn waves-effect waves-light" id="btnDeleteVideoWish" value="삭제"/>										
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</c:if>
			
		<!-- 페이징 -->
			<div class="center">
			<ul class="pagination">
			<li class="waves-effect">
				<a href="particularList?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&useremail=${useremail}&wishtable=0&distinguishNum=1">
					<i class="material-icons">first_page</i>
				</a>
			</li>
			
				<li class="waves-effect">
					<a href="particularList?currentPage=${navi.currentPage - 1}&useremail=${useremail}&wishtable=0&distinguishNum=1"> 
						<i class="material-icons">chevron_left</i>
					</a>
				</li>
			
				<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
					<c:if test="${navi.currentPage == page }">
						<li class="page-item active"><a class="page-link">${page}</a></li>
					</c:if>
					<c:if test="${navi.currentPage != page }">
						<li class="page-item"><a class="page-link"
							href="particularList?currentPage=${page}&useremail=${useremail}&wishtable=0&distinguishNum=1">${page}</a></li>
					</c:if>
				</c:forEach>
			
				<li class="waves-effect">
					<a href="particularList?currentPage=${navi.currentPage + 1}&useremail=${useremail}&wishtable=0&distinguishNum=1">
						<i class="material-icons">chevron_right</i> 
					</a>
				</li>
			
				<li class="waves-effect">
					<a href="particularList?currentPage=${navi.currentPage + navi.PAGE_PER_GROUP}&useremail=${useremail}&wishtable=0&distinguishNum=1">
						<i class="material-icons">last_page</i> 
					</a>
				</li>
			</ul>
		</div>		
	</div>
</body>
</html>