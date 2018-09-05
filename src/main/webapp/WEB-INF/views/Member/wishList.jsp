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
				<h2>[${sessionScope.useremail}(${sessionScope.usernick})님의 찜한영상
					리스트]</h2>

				<c:if test="${sessionScope.useremail!=null}">
					<c:if test="${empty videoWishList}">
						<table border="1">
							<tr>
								<td>찜한 영상이 없습니다.</td>	
							</tr>
						</table>	
					</c:if>
					<c:if test="${videoWishList != null}">
						<table border="1">
							<tr>
								<td>번호</td>
								<td>제목</td>
								<td>URL</td>
								<td>작성자</td>
								<td>작성일자</td>
							</tr>
							<c:forEach var="videoWishList" items="${videoWishList}" varStatus="status">
								<tr>
									<td>${videoWishList.videowishnum}</td>
									<td>${videoWishList.title}</td>
									<td>${videoWishList.url}</td>
									<td>${videoWishList.useremail}</td>
									<td>${videoWishList.regDate}</td>
									<td>
										<form action="deleteVideoWish" method="get">
											<input type="hidden" name="useremail" value="${sessionScope.useremail}">
											<input type="hidden" name="wishNum" value="${videoWishList.videowishnum}">
											<input type="submit" id="btnDeleteWish" value="삭제" />
										</form>
									</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</c:if>
			</div>
			<div id="tab-2" class="tab-content">
				<h2>[${sessionScope.useremail}(${sessionScope.usernick})님의 찜한자막
					리스트]</h2>

				<c:if test="${sessionScope.useremail!=null}">
					<c:if test="${empty subWishList}">
						<table border="1">
							<tr>
								<td>찜한 자막이 없습니다.</td>	
							</tr>
						</table>	
					</c:if>
					<c:if test="${subWishList != null}">
						<table border="1">
							<tr>
								<td>번호</td>
								<td>제목</td>
								<td>URL</td>
								<td>작성자</td>
								<td>작성일자</td>
							</tr>
						<c:forEach var="subWishList" items="${subWishList}" varStatus="status">
							<tr>
								<td>${subWishList.subwishNum}</td>
								<td>${subWishList.title}</td>
								<td>${subWishList.url}</td>
								<td>${subWishList.regDate}</td>
								<td>
									<form action="deleteSubWish" method="get">
										<input type="hidden" name="useremail" value="${sessionScope.useremail}">
										<input type="hidden" name="subNum" value="${subWishList.subwishNum}">
										<input type="submit" id="btnDeleteWish" value="삭제" />
									</form>
								</td>
							</tr>
						</c:forEach>
					</table>
					</c:if>
				</c:if>
			</div>
			<div id="tab-3" class="tab-content">
					<h2>[${sessionScope.useremail}(${sessionScope.usernick})님의 찜한자막
					리스트]</h2>

				<c:if test="${sessionScope.useremail!=null}">
					<c:if test="${empty dubWishList}">
						<table border="1">
							<tr>
								<td>찜한 더빙이 없습니다.</td>	
							</tr>
						</table>	
					</c:if>
					<c:if test="${dubWishList != null}">
						<%-- <table border="1">
							<tr>
								<td>번호</td>
								<td>제목</td>
								<td>URL</td>
								<td>작성자</td>
								<td>작성일자</td>
							</tr>
							<c:forEach var="wishList" items="${wishList}" varStatus="status">
								<tr>
									<td>${wishList.wishNum}</td>
									<td>${dubList[status.index].title}</td>
									<td>${dubList[status.index].url}</td>
									<td>${dubList[status.index].regDate}</td>
									<td>
										<form action="deleteDubWish" method="get">
											<input type="hidden" name="useremail" value="${sessionScope.useremail}">
											<input type="hidden" name="subNum" value="${dubList.wishNum}">
											<input type="submit" id="btnDeleteWish" value="삭제" />
										</form>
									</td>
								</tr>
							</c:forEach>
						</table> --%>
					</c:if>
				</c:if>
			</div>			
		</div>	
	</form>
</head>
</html>