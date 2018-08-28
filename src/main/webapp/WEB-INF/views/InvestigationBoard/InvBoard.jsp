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
<title>자막검증게시판</title>
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
			$('#requestInvestigation').on('click', function() {
				var useremail = "${sessionScope.useremail}";
				
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}
				location.href = "requestInvestigation";
			});
			
			$('.recommendation').on('click', function() {
				var useremail = "${sessionScope.useremail}";
				
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}
				var target = $(this);
				var recoCount = Number(target.children("span").text());
				var decoTarget = target.parent().children(".decommendation").children("#decoCount");
				var videonum = target.parent().children("input").val();
				var dataForm = {"useremail":useremail, "identificationnum":videonum, "recommendtable":"0", "recommendation":"0"};
				
				$.ajax({
					method:'post'
					, url:'insertRecommendation'
					, data: JSON.stringify(dataForm)
					, contentType: "application/json; charset=utf-8"
					, async : false
					, success:function(resp) {
						if(resp == "success") {
							alert("영상을 좋아합니다.");
							target.children("span").html(recoCount+1);
						}else if(resp == "cancel") {
							alert("좋아요를 취소합니다.");
							target.children("span").html(recoCount-1);
						}else if(resp == "change") {
							alert("좋아요로 변경하셨습니다.");
							decoTarget.html(Number(decoTarget.text())-1);
							target.children("span").html(recoCount+1);
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
				var decoCount = Number(target.children("span").text());
				var recoTarget = target.parent().children(".recommendation").children("#recoCount");
				var videonum = target.parent().children("input").val();
				var dataForm = {"useremail":useremail, "identificationnum":videonum, "recommendtable":"0", "recommendation":"1"};
				
				$.ajax({
					method:'post'
					, url:'insertRecommendation'
					, data: JSON.stringify(dataForm)
					, contentType: "application/json; charset=utf-8"
					, async : false
					, success:function(resp) {
						if(resp == "success") {
							alert("영상을 싫어합니다.");
							target.children("span").html(decoCount+1);
						}else if(resp == "cancel") {
							alert("싫어요를 취소합니다.");
							target.children("span").html(decoCount-1);
						}else if(resp == "change"){
							alert("싫어요로 변경하셨습니다.");
							recoTarget.html(Number(recoTarget.text())-1);
							target.children("span").html(decoCount+1);
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
            <div><h2>자막 검증 게시판</h2></div>
    </header>
   <br/>
   
	<input type="button" id="requestInvestigation" value="자막요청"/>
	
    <!-- Page Content -->
	<div class="container">
		<div class="row">
		<c:if test="${not empty invList}">
			<c:forEach var="invList" items="${invList}">
		<!-- <h1 class="my-4">Welcome to Modern Business</h1>-->
		<!-- Marketing Icons Section -->
			<div class="col-lg-4 mb-4">
				<div class="card h-100">
					<h4 class="card-header" align="center">
						<a href="detailEduBoard?videoNum=${invList.investigationnum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${invList.title}</a>
					</h4>
					
					<div class="card-body">
						<p class="card-text" align="center">
							<img alt="" src="https://img.youtube.com/vi/${invList.url}/0.jpg">
						</p>
					</div>
					
					<div class="card-footer" align="center">
						<input type="hidden" value="${invList.investigationnum}">
						<button class="btn recommendation">
							<img alt="" src="images/tup.png">
							<span id="recoCount">${invList.recommendation}</span>
						</button>
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn decommendation">
							<img alt="" src="images/tdown.png">
							<span id="decoCount">${invList.decommendation}</span>
						</button>
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						조회수 ${invList.hitcount}
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
	</div>
	<!-- /.row -->
  	<br/><br/><br/><br/>

	<script type="text/javascript" src="YoutubeAPI/search.js"></script>
    <script src="https://apis.google.com/js/client.js?onload=init"></script>
  </body>
</html>