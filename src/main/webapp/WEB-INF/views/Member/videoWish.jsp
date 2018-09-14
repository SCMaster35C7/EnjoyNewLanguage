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
			
			var title = $(this).attr('data-rno');
			$.ajax({
				method : 'get',
				url : 'deleteVideoWish',
				data : 'title=' + title,
				success : init
			})
			
			$('#deleteVideoWish').submit();	
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
				<c:if test="${empty vWishlist}">

					<table border="1">
						<tr>
							<td>영상위시리스트가 비어있습니다.</td>
						</tr>
					</table>
				</c:if>

				<c:if test="${vWishlist != null}">

					<table border="1">
						<tr>
							
							<td>번호</td>
							<td>제목</td>
							<td>작성일자</td>
							<td>삭제</td>
						</tr>
						<c:forEach var="vWishlist" items="${vWishlist}">
							<tr>
								
								<td>${vWishlist.rownum}</td>								
								<td><a href="detailEduBoard?videoNum=${vWishlist.identificationnum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${vWishlist.title}</a></td>
								<td>${vWishlist.regdate}</td>
								<td>
									<input type="button" id="btnDeleteVideoWish" value="삭제"/>										
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</c:if>
			
		<!-- 페이징 -->
			<div class="center">
			<ul class="pagination">
			<li class="waves-effect">
				<a href="videoWish?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
					<i class="material-icons">first_page</i>
				</a>
			</li>
			
				<li class="waves-effect">
					<a href="videoWish?currentPage=${navi.currentPage - 1}&searchType=${searchType}&searchWord=${searchWord}"> 
						<i class="material-icons">chevron_left</i>
					</a>
				</li>
			
				<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
					<c:if test="${navi.currentPage == page }">
						<li class="page-item active"><a class="page-link">${page}</a></li>
					</c:if>
					<c:if test="${navi.currentPage != page }">
						<li class="page-item"><a class="page-link"
							href="videoWish?currentPage=${page}&searchType=${searchType}&searchWord=${searchWord}">${page}</a></li>
					</c:if>
				</c:forEach>
			
				<li class="waves-effect">
					<a href="videoWish?currentPage=${navi.currentPage + 1}&searchType=${searchType}&searchWord=${searchWord}">
						<i class="material-icons">chevron_right</i> 
					</a>
				</li>
			
				<li class="waves-effect">
					<a href="videoWish?currentPage=${navi.currentPage + navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
						<i class="material-icons">last_page</i> 
					</a>
				</li>
			</ul>
		</div>		
	</div>
</body>
</html>