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
    
    <script type="text/javascript">
		$(function() {
			$('#addEduVideo').on('click', function() {
				location.href = "addEduVideo";
			});
		});
    </script>
</head>
<body>
    <header>
            <div><h2>공부영상게시판</h2></div>
    </header>
   <br/>
   
   	<c:if test="${(not empty sessionScope.admin) and sessionScope.admin == 0}">
		<input type="button" id="addEduVideo" value="영상추가"/>
	</c:if>
	
    <!-- Page Content -->
	<div class="container">
		<c:if test="${not empty eduList}">
			<c:forEach var="eduList" items="${eduList}">
		<!-- <h1 class="my-4">Welcome to Modern Business</h1>-->
		<!-- Marketing Icons Section -->
		<div class="row">
			<div class="col-lg-4 mb-4">
				<div class="card h-100">
					<h4 class="card-header" align="center">
						<a href="detailEduBoard?videoNum=${eduList.videoNum}">${eduList.title}</a>
					</h4>
					
					<div class="card-body">
						<p class="card-text" align="center">
						
							<img alt="" src="">
						
						</p>
					</div>
					
					<div class="card-footer" align="center">
						<!-- <a href="#" class="btn btn-primary"> -->
							<img alt="" src="images/tup.png">${eduList.recommendation}
						<!-- </a> -->
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<!-- <a href="#" class="btn btn-primary"> -->
							<img alt="" src="images/tdown.png">${eduList.decommendation}
						<!-- </a> -->
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<!--  <a href="#" class="btn btn-primary"> -->
							조회수 ${eduList.hitCount}
						<!-- </a> -->
					</div>
					
				</div>
			</div>
		</div>
			</c:forEach>
		</c:if>
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
	<c:if test="${not empty eduList}">
		<c:forEach var="eduList" items="${eduList}">
			<tr>
				<td><a href="detailEduBoard?videoNum=${eduList.videoNum}">${eduList.videoNum}번 영상  시청</a></td>
				<td>${eduList.regDate}</td>
				<td>${eduList.hitCount}</td>
				<td>${eduList.recommendation}</td>
				<td>${eduList.decommendation}</td>
			</tr>
		</c:forEach>
	</c:if>
  </body>
</html>