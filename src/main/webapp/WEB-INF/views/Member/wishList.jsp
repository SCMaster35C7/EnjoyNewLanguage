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
		
		var $menuEle = $('dt'); // 탭메뉴를 변수에 지정
		$menuEle. click(function() { // 탭메뉴 클릭 이벤트
		    $('dd').addClass('hidden');
		    $(this).next().removeClass('hidden');
		})
	});	
	
	function deleteWish() {
		$('#deleteWish').submit();
	}
</script>

<style type="text/css">
dl {
	position: relative;
}

dt {
	height: 30px;
	float: left;
	width: 50px;
	z-index: 9;
	position: relative;
}

dd {
	position: absolute;
	padding-top: 30px;
	background-color: #f3f3f3;
	width: 250px;
	height: 200px;
}

dd.hidden {
	display: none;
}
</style>
</head>
<body>
<h2>[${sessionScope.useremail}(${sessionScope.usernick})님의 위시리스트]</h2>
	<dl>
		<dt>영상</dt>
		<dd>
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
							<td>제목</td>
							<td>작성일자</td>
						</tr>
						<c:forEach var="vWishlist" items="${vWishlist}">
							<tr>
								<td><a
									href="detailEduBoard?videoNum=${vWishlist.identificationnum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${vWishlist.title}</a></td>
								<td>${vWishlist.regdate}</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</c:if>
		</dd>

		<dt>자막</dt>
		<dd class="hidden">
		

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
							<td>제목</td>
							<td>작성일자</td>
						</tr>
						<c:forEach var="sWishlist" items="${sWishlist}">
							<tr>
								<td><a
									href="detailSubBoard?videoNum=${sWishlist.identificationnum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${sWishlist.title}</a></td>
								<td>${sWishlist.regdate}</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</c:if>
		</dd>
		<dt>더빙</dt>
		<dd class="hidden">			
			<c:if test="${sessionScope.useremail!=null}">
				<c:if test="${empty dWishlist}">

					<table border="1">
						<tr>
							<td>더빙위시리스트가 비어있습니다.</td>
						</tr>
					</table>
				</c:if>

				<c:if test="${dWishlist != null}">

					<table border="1">
						<tr>
							<td>제목</td>
							<td>작성일자</td>
						</tr>
						<c:forEach var="dWishlist" items="${dWishlist}">
							<tr>
								<td><a
									href="dubDetail?videoNum=${dWishlist.identificationnum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${dWishlist.title}</a></td>
								<td>${dWishlist.regdate}</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</c:if>
		</dd>
	</dl>
</head>
</html>