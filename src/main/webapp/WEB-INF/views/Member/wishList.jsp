<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Enjoy Language</title>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		$('#btnDeleteWish').on('click', deleteWish);	//삭제버튼 클릭시 작업
		
		$('#btnCancel').on('click', function() {		//취소버튼 클릭시 이동
			location.href = "${pageContext.request.contextPath}/"
		});
	});	
	
	function deleteWish() {
		$('#deleteWish').submit();
	}
</script>
<<<<<<< HEAD
=======



>>>>>>> Muk
<style type="text/css">
body {
	margin-top: 100px;
	font-family: 'Trebuchet MS', serif;
	line-height: 1.6
}

.container {
	width: 500px;
	margin: 0 auto;
}

ul.tabs {
	margin: 0px;
	padding: 0px;
	list-style: none;
}

ul.tabs li {
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current {
	background: #ededed;
	color: #222;
}

.tab-content {
	display: none;
	background: #ededed;
	padding: 15px;
}

.tab-content.current {
	display: inherit;
}
</style>
</head>
<body>
	<form action="showWish" id="showWish" method="get">
		<div class="container">

			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">영상</li>
				<li class="tab-link" data-tab="tab-2">자막</li>
				<li class="tab-link" data-tab="tab-3">더빙</li>				
			</ul>

			<div id="tab-1" class="tab-content current">
<<<<<<< HEAD
				<h2>[${sessionScope.useremail}(${sessionScope.usernick})님의 위시리스트]</h2>

				<c:if test="${sessionScope.useremail!=null}">
					<c:if test="${empty vWishList}">
=======
				<h2>[${sessionScope.useremail}(${sessionScope.usernick})님의 찜한영상
					리스트]</h2>

				<c:if test="${sessionScope.useremail!=null}">
					<c:if test="${empty WishList}">
>>>>>>> Muk
						<table border="1">
							<tr>
								<td> 영상위시리스트가 비어있습니다.</td>	
							</tr>
						</table>	
					</c:if>
<<<<<<< HEAD
					<c:if test="${vWishList != null}">
=======
					<c:if test="${WishList != null}">
>>>>>>> Muk
						<table border="1">
							<tr>
								<td>번호</td>
								<td>제목</td>
								<td>URL</td>
								<td>작성자</td>
								<td>작성일자</td>
							</tr>
<<<<<<< HEAD
							<c:forEach var="vWishList" items="${vWishList}">
								<tr>
									<td>${vWishList.videoNum}</td>
									<td><a href="detailWishList?videoNum=${vWishList.videoNum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${vWishList.title}</a></td>
									<td>${vWishList.url}</td>
									<td>${vWishList.useremail}</td>
									<td>${vWishList.regDate}</td>
									<td>
										<form action="deleteVideoWish" method="get">
											<input type="hidden" name="useremail" value="${sessionScope.useremail}">
											<input type="hidden" name="videoNum" value="${vWishList.videoNum}">
											<input type="button" id="btnDeleteWish" value="삭제" />
											<input type="button" id="btnCancel" value="취소" />
=======
							<c:forEach var="WishList" items="${WishList}" varStatus="status">
								<tr>
									<td>${WishList.wishnum}</td>
									<td>${WishList.title}</td>
									<td>${WishList.url}</td>
									<td>${WishList.useremail}</td>
									<td>${WishList.regDate}</td>
									<td>
										<form action="deleteVideoWish" method="get">
											<input type="hidden" name="useremail" value="${sessionScope.useremail}">
											<input type="hidden" name="videoNum" value="${WishList.videoNum}">
											<input type="submit" id="btnDeleteWish" value="삭제" />
>>>>>>> Muk
										</form>
									</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</c:if>
			</div>
			<div id="tab-2" class="tab-content">
			</div>			
			<div id="tab-3" class="tab-content">			
			</div>			
		</div>	
	</form>
</head>
</html>