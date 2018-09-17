<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

</script>
</head>
<body>
 <c:if test="${sessionScope.useremail!=null}">
				<c:if test="${empty sWishlist}">

					<table border="1">
						<tr>
							<td>자막위시리스트가 비어있습니다.</td>
						</tr>
					</table>
				</c:if>

				<c:if test="${sWishlist != null}">

					<table border="1">
						<tr>
							<td>번호</td>
							<td>제목</td>
							<td>작성일자</td>
							<td>삭제</td>
						</tr>
						<c:forEach var="sWishlist" items="${sWishlist}">
							<tr>
								<td>${sWishList.rownum}</td>
								<td><a href="detailSubBoard?videoNum=${sWishlist.identificationnum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${sWishlist.title}</a></td>
								<td>${sWishlist.regdate}</td>
								<td>
									<form action="deleteWish" method="get" >
								<%--    <input type="hidden" name="" value="${sessionScope.Member.userid}">
										<input type="hidden" name="" value="${vWishList.title}"> --%>
										<input type="button" id="btnDeleteSubWish" value="삭제"/>										
									</form>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</c:if>
			
			<div class="center">
			<ul class="pagination">
			<li class="waves-effect">
				<a href="subWish?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
					<i class="material-icons">first_page</i>
				</a>
			</li>
			
				<li class="waves-effect">
					<a href="subWish?currentPage=${navi.currentPage - 1}&searchType=${searchType}&searchWord=${searchWord}"> 
						<i class="material-icons">chevron_left</i>
					</a>
				</li>
			
				<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
					<c:if test="${navi.currentPage == page }">
						<li class="page-item active"><a class="page-link">${page}</a></li>
					</c:if>
					<c:if test="${navi.currentPage != page }">
						<li class="page-item"><a class="page-link"
							href="subWish?currentPage=${page}&searchType=${searchType}&searchWord=${searchWord}">${page}</a></li>
					</c:if>
				</c:forEach>
			
				<li class="waves-effect">
					<a href="subWish?currentPage=${navi.currentPage + 1}&searchType=${searchType}&searchWord=${searchWord}">
						<i class="material-icons">chevron_right</i> 
					</a>
				</li>
			
				<li class="waves-effect">
					<a href="subWish?currentPage=${navi.currentPage + navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
						<i class="material-icons">last_page</i> 
					</a>
				</li>
			</ul>
		</div>
</body>
</html>