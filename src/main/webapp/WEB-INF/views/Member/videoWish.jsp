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

/* var dataFormVideo = {
		"tableName":"videowish", 
		"idCode":"videonum", 
		"useremail":useremail, 
		"title":title,			
		"url":url,	
		"wishnum":videonum,		
}; */

/* $.ajax({
	method:'post'
	, url:'videoWish'
	, data: JSON.stringify(dataFormVideo)
	, contentType: "application/json; charset=utf-8"
	, async : false
	, success:function(resp) {
		
		for(var i in )
		
			if(==0){
			
			}else{
			
			}	
		
	 }
	, error:function(resp, code, error) {
		alert("resp : "+resp+", code : "+code+", error : "+error);
	} */
});
</script>
</head>
<body>
	<div id="wrapper">
		<h2>[ 영상위시리스트 ]</h2>		
		<div>			
			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>URL</th>
					<th>작성자</th>
					<th>작성일자</th>
				</tr>

				<c:if test="${empty WishList}">
					<tr>
						<td colspan="5"> 글이 없습니다.</td>
					</tr>
				</c:if>

			<%-- 글 목록  뿌리기 --%>
				<c:if test="${not empty list}">
					<c:forEach var="WishList" items="${WishList}" varStatus="status">
						<tr>
							<td class="center">${status.count + navi.startRecord}</td>
							<c:if test="${not empty sessionScope.useremail}">
								<td class="title">								
									<a href="detailWhat?wishnum=${WishList.videoNum}">${WishList.title}</a>									
								</td>
							</c:if>							
							<td>${WishList.useremail}</td>
							<td>${WishList.regDate}</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			
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
							<li class="page-item">
								<a class="page-link" href="videoWish?currentPage=${page}&searchType=${searchType}&searchWord=${searchWord}">${page}</a>
							</li>						
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
	</div>
</body>
</html>