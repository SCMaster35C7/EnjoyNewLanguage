<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="zisung">

<!--Import Google Icon Font-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="css/materialize1.css"  media="screen,projection"/>

      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>main</title>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		//dropdown
		$(".dropdown-trigger").dropdown();
		
		//floating actionbutton
		$(".fixed-action-btn").floatingActionButton({
			
		});
		
		//modal open
		$('#modal1').modal();
		
		$('#back').on('click', function() {
			
		});
		
		//side-nav open
		$('.sidenav').sidenav();
		
		//tooltip
		$('.tooltipped').tooltip();
		
		//캐러셀
		$('.carousel').carousel();
	});
</script>
</head>
<body>
	<header>
	<!-- Dropdown Structure -->
	<ul id="dropdown1" class="dropdown-content">
	  <li><a href="myPage">마이페이지</a></li>
	  <li><a href="TryRetake?videoNum=9">재시험테스트</a>
	  		<c:if test="${plzLogin!=null}">
				<script type="text/javascript">
						$(function(){
							alert("${plzLogin}");
						});
				</script>
			</c:if>
	  </li>
	  <li class="divider"></li>
	  <li><a href="searchTest">Youtube Search테스트</a></li>
	</ul>
	
	<!-- nav -->
	<nav class="nav-extended">
	  <div class="nav-wrapper">
	     <!-- sidenav trigger -->
		    <ul class="left">
		    	<li>
		    		<a href="#" data-target="slide-out" class="sidenav-trigger" style="display:inline">
		    			<i class="material-icons">menu</i>
		    		</a>
		    	</li>
		    </ul>
	    <a href="#!" class="brand-logo">Logo</a>
	    <a href="#" data-target="small-navi"  class="sidenav-trigger"><i class="material-icons">menu</i></a>
	    <ul class="right hide-on-med-and-down">
	      <li><a href="eduboard">영상게시판</a></li>
	      <li><a href="dubbingBoard">더빙게시판</a></li>
	      <li><a href="InvestigationBoard">자막게시판</a></li>
	      <!-- Dropdown Trigger -->
	      <li><a class="dropdown-trigger" href="#" data-target="dropdown1">Dropdown<i class="material-icons right">arrow_drop_down</i></a></li>
	    </ul>
	  </div>

	
		<div class="nav-content">
			<a class="btn-floating btn-large halfway-fab pulse modal-trigger tooltipped" data-position="left" data-tooltip="LOGIN!" href="#modal1">
        	<i class="medium material-icons">person</i>
     		 </a>
		</div>
	</nav>
	</header>
	  
	  <!-- 창 축소시 사이드 nav -->
	  <ul class="sidenav" id="small-navi">
	    <li><a href="eduboard.jsp">공부게시판</a></li>
	    <li><a href="#">더빙게시판</a></li>
	    <li><a href="#">마이페이지</a></li>
  	  </ul>
		
		<!-- 로그인 MODAL -->
		<div id="modal1" class="modal">
			<div class="modal-content">
			<div class="container">
			
				<form class="col s12">
				<div class="row">
					<h4 class="center-align">LOGIN</h4>
				
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">mail</i>
							<input id="email" type="text" class="validate">
							<label for="email">EMAIL</label>
						</div>
					</div>
				
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">mode_edit</i>
							<input id="icon_prefix" type="password" class="validate">
							<label for="icon_prefix">PASSWORD</label>
						</div>
					</div>
				</div>	
				
					<div class="row">
						<div class="col s8">
						<span class="flow-text">
							<button class="btn waves-effect waves-light" type="submit" name="action">ENTER
							<i class="material-icons right">send</i>
							</button>
						</span>
					
						<span class="flow-text">
							<button class="btn waves-effect waves-light modal-close" id="back" type="button">BACK
								<i class="material-icons right">keyboard_return</i>
							</button>
						</span>
						</div>
						
						<div class="col s2 offset-s2">
						<span class="flow-text">
							<a class="btn-floating btn-large red waves-effect waves-light tooltipped" data-position="top" data-tooltip="JOIN US!">
							<i class="large material-icons">person_add</i>
							</a>
						</span>	
						</div>
					
				</div>
				</form>
			</div>
		</div>	
	  </div>
	
	 <!-- 메인 -->
		<div class="wrapper">
			 <!-- sidenav -->	  
			<aside>	  	  
			  	  <ul id="slide-out" class="sidenav" style="margin-top:64px;">
					<li><div class="user-view">
							<div class="background">
								<img src="images/">
							</div>
							<a href="#user"><img class="circle" src="images/"></a>
							<a href="#name"><span class="white-text name">${usernick}</span></a> 
							<a href="#email"><span class="white-text email">${useremail}</span></a>
						</div>
					</li>
					<li><a href="#!"><i class="material-icons">cloud</i>First
							Link With Icon</a></li>
					<li><a href="#!">wishList</a></li>
					<li><div class="divider"></div></li>
					<li><a class="subheader">회원정보관리</a></li>
					<li><a class="waves-effect" href="updateMember">회원정보수정</a></li>
					<li><a class="waves-effect" href="#">회원탈퇴</a></li>
				</ul>
			</aside>	 
	 		 <section>
				  <div class="container">
				  	<h3 class="center">인기 항목</h3>
				  </div>
				
				  <div class="carousel">
					<a class="carousel-item" href="#one!"><img src="images/liverpool.jpg"></a>
					<a class="carousel-item" href="#two!"><img src="images/torres.jpg"></a>
					<a class="carousel-item" href="#three!"><img src="images/berna.jpg"></a>
				    <a class="carousel-item" href="#four!"><img src="images/ronaldo.jpg"></a>
				    <a class="carousel-item" href="#five!"><img src="images/kaka.jpeg"></a>
			  	  </div>
  	 		 </section>
  	  </div>
	
	
	<footer class="page-footer">
          <div class="container">
            <div class="row">
              <div class="col l6 s12">
                <h5 class="white-text">Footer Content</h5>
                <p class="grey-text text-lighten-4">You can use rows and columns here to organize your footer content.</p>
              </div>
              <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Links</h5>
                <ul>
                  <li><a class="grey-text text-lighten-3" href="#!">Link 1</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Link 2</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Link 3</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Link 4</a></li>
                </ul>
              </div>
            </div>
          </div>
          <div class="footer-copyright">
            <div class="container">
            © 2014 Copyright Text
            <a class="grey-text text-lighten-4 right" href="#!">More Links</a>
            </div>
          </div>
        </footer>


<script type="text/javascript" src="js/materialize.js"></script>
</body>
</html>