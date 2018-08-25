<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>공부영상게시판</title>
   <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <link href="css/modern-business.css" rel="stylesheet">
    
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="YoutubeAPI/auth.js"></script>
    
    <script type="text/javascript">
		$(function() {
			$('#addEduVideo').on('click', function() {
				location.href = "addEduVideo";
			});
			
			$('.recommendation').on('click', function() {
				var useremail = "${sessionScope.useremail}";
				
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}
				var target = $(this);
				var recoCount =  Number(target.children("span").text())+1;
				var videonum = target.parent().children("input").val();
				var dataForm = {"useremail":useremail, "identificationnum":videonum, "recommendtable":"0", "recommendation":"0"};
				
				$.ajax({
					method:'post'
					, url:'insertRecommendation'
					, data: JSON.stringify(dataForm)
					, contentType: "application/json; charset=utf-8"
					, success:function(resp) {
						if(resp == "success") {
							target.children("span").html(recoCount);
						}else {
							alert("이미 추천/비추천을 하셨습니다.");
						}
					  }
					, error:function(resp, code, error) {
						alert("resp : "+resp+", code : "+code+", error : "+error);
					}
				});
			});
			
			$('.decommendation').on('click', function() {
				var useremail = "${sessionScope.useremail}";
				
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}
				var target = $(this);
				var recoCount = Number(target.children("span").text())+1;
				var videonum = target.parent().children("input").val();
				var dataForm = {"useremail":useremail, "identificationnum":videonum, "recommendtable":"0", "recommendation":"1"};
				
				$.ajax({
					method:'post'
					, url:'insertRecommendation'
					, data: JSON.stringify(dataForm)
					, contentType: "application/json; charset=utf-8"
					, success:function(resp) {
						if(resp == "success") {
							target.children("span").html(recoCount);
						}else {
							alert("이미 추천/비추천을 하셨습니다.");
						}
					  }
					, error:function(resp, code, error) {
						alert("resp : "+resp+", code : "+code+", error : "+error);
					}
				});
			});
		});
    </script>
</head>
<body>
    <header>
            <div><h2>공부영상게시판</h2></div>
    </header>
    <div id="temp">안녕</div>
   <br/>
   
   	<c:if test="${(not empty sessionScope.admin) and sessionScope.admin == 0}">
		<input type="button" id="addEduVideo" value="영상추가"/>
	</c:if>
	
    <!-- Page Content -->
	<div class="container">
		<div class="row">
		<c:if test="${not empty eduList}">
			<c:forEach var="eduList" items="${eduList}">
		<!-- <h1 class="my-4">Welcome to Modern Business</h1>-->
		<!-- Marketing Icons Section -->
			<div class="col-lg-4 mb-4">
				<div class="card h-100">
					<h4 class="card-header" align="center">
						<a href="detailEduBoard?videoNum=${eduList.videoNum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${eduList.title}</a>
					</h4>
					
					<div class="card-body">
						<p class="card-text" align="center">
							<img alt="" src="https://img.youtube.com/vi/${eduList.url}/0.jpg">
						</p>
					</div>
					
					<div class="card-footer" align="center">
						<input type="hidden" value="${eduList.videoNum}">
						<button class="btn recommendation">
							<img alt="" src="images/tup.png">
							<span>${eduList.recommendation}</span>
						</button>
						
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn decommendation">
							<img alt="" src="images/tdown.png">
							<span>${eduList.decommendation}</span>
						</button>
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						조회수 ${eduList.hitCount}
					</div>
				</div>
			</div>
			</c:forEach>
		</c:if>
		</div>
		<div class="row">
			<ul class="pagination justify-content-center">
				<li class="page-item">
					<a class="page-link" href="eduBoard?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}"> 
					<span>&laquo;</span>
					<span class="sr-only">PreviousPage</span>
					</a>
				</li>
				<li class="page-item">
					<a class="page-link" href="eduBoard?currentPage=${navi.currentPage - 1}&searchType=${searchType}&searchWord=${searchWord}"> 
					<span>&lt;</span> 
					<span class="sr-only">Previous</span>
					</a>
				</li>
			
				<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
					<c:if test="${navi.currentPage == page }">
						<li class="page-item active"><a class="page-link">${page}</a></li>
					</c:if>
					<c:if test="${navi.currentPage != page }">
						<li class="page-item"><a class="page-link"
							href="eduBoard?currentPage=${page}&searchType=${searchType}&searchWord=${searchWord}">${page}</a></li>
					</c:if>
				</c:forEach>
			
				<li class="page-item">
					<a class="page-link" href="eduBoard?currentPage=${navi.currentPage + 1}&searchType=${searchType}&searchWord=${searchWord}">
					<span>&gt;</span> 
					<span class="sr-only">Next</span>
					</a>
				</li>
			
				<li class="page-item">
					<a class="page-link" href="eduBoard?currentPage=${navi.currentPage + navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
					<span>&raquo;</span> 
					<span class="sr-only">NextPage</span>
					</a>
				</li>
			</ul>
		</div>
		
		<div>
		<c:if test="${(sessionScope.admin) != 0 and (not empty sessionScope.admin)}">
			<div>
				<input type="button" value="주류 정보 입력" id="insertAlcohol"
					class="btn btn-primary">
				<script>
					document.getElementById("insertAlcohol").onclick = function() {
						//alert("주류 데이터를 넣을거야!");
						location.href = "inputAlcoholForm";
					}
				</script>
			</div>
		</c:if>
		</div>
	</div>
	<!-- /.row -->
  	<br/><br/><br/><br/>



	<!-- Footer -->
   <!--  <footer class="py-5 bg-dark">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Your Website 2018</p>
      </div>
      /.container
    </footer> -->
  </body>
</html>