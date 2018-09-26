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
$(document).ready(function(){    
    $("#btnDeleteparticularList").on("click", function(){ //삭제하기 버튼
    	deleteparticularList();
    });
});

function deleteparticularList(){
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/sample/deleteBoard.do' />");
    comSubmit.addParam("IDX", $("#IDX").val());
    comSubmit.submit();
     
}
</script>
</head>
<body>

 	<c:if test="${sessionScope.useremail!=null}">
				<c:if test="${empty vWishlist}">
               <table border="1">
                  <tr>
                     <td>자막위시리스트가 비어있습니다.</td>
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
								<td>${vWishlist.rnum}</td>									
								<td><a href="detailInvBoard?investigationnum=${vWishlist.identificationnum}&currentPage=${navi.currentPage}&useremail=${useremail}&wishtable=1" target="_parent">${vWishlist.title}</a></td>
								<td>${vWishlist.regdate}</td>
								<td>
									<form action="deleteWish" method="get" >
										<input type="button" class="btn waves-effect waves-light" id="btnDeleteparticularList" value="삭제"/>										
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
				<a href="particularList?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&useremail=${useremail}&wishtable=1&distinguishNum=2">
					<i class="material-icons">first_page</i>
				</a>
			</li>
			
				<li class="waves-effect">
					<a href="particularList?currentPage=${navi.currentPage - 1}&useremail=${useremail}&wishtable=1&distinguishNum=2"> 
						<i class="material-icons">chevron_left</i>
					</a>
				</li>
			
				<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
					<c:if test="${navi.currentPage == page }">
						<li class="page-item active"><a class="page-link">${page}</a></li>
					</c:if>
					<c:if test="${navi.currentPage != page }">
						<li class="page-item"><a class="page-link"
							href="particularList?currentPage=${page}&useremail=${useremail}&wishtable=1&distinguishNum=2">${page}</a></li>
					</c:if>
				</c:forEach>
			
				<li class="waves-effect">
					<a href="particularList?currentPage=${navi.currentPage + 1}&useremail=${useremail}&wishtable=1&distinguishNum=2">
						<i class="material-icons">chevron_right</i> 
					</a>
				</li>
			
				<li class="waves-effect">
					<a href="particularList?currentPage=${navi.currentPage + navi.PAGE_PER_GROUP}&useremail=${useremail}&wishtable=1&distinguishNum=2">
						<i class="material-icons">last_page</i> 
					</a>
				</li>
			</ul>
		</div>
</body>
</html>