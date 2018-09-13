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
	
	<title>Enjoy Language</title>
	
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script>
		$(function() {
			$('select').formSelect();
			
			//dropdown
			$(".dropdown-trigger").dropdown();
			
			//floating actionbutton
			$(".fixed-action-btn").floatingActionButton({
				/* direction:'left' */
			});
			
			//modal open
			$('#modal1').modal();
			
			//side-nav open
			$('.sidenav').sidenav();
			
			//tooltip
			$('.tooltipped').tooltip();
			
			//캐러셀
			$('.carousel').carousel();
			
			$('#loginBtn').on('click',function(){
				var useremail = $('#useremail');
				var userpwd = $('#userpwd');
				
				$('#loginForm').submit();
			});
		});
		
		function dictionary(){
			var win= window.open('dictionaryBoard','_black',"width=340px,height=250px");
			win.focus();
		}
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
		  <li><a onclick="dictionary()">Dictionary</a></li>
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
		    <a href="${pageContext.request.contextPath}" class="brand-logo">Logo</a>
		
		    <a href="#" data-target="small-navi"  class="sidenav-trigger"><i class="material-icons">menu</i></a>
		    <ul class="right hide-on-med-and-down" >
			  <li>
			  		<div class="header-search-wrapper hide-on-med-and-down" style="display:inline-block; width:300px; margin-left:-5%;">
                  		<i class="material-icons" style="margin-left:-50px;">search</i>
                  		<input  type="search" name="Search" class="header-search-input z-depth-2" placeholder="SEARCH WORD"/>
             		</div>
			  </li>		 
		      <li><a href="eduBoard">영상게시판</a></li>
		      <li><a href="dubbingBoard">더빙게시판</a></li>
		      <li><a href="InvestigationBoard">자막검증게시판</a></li>
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
		    <li>
			  		<form>
        <div class="input-field">
          <input id="search" type="search" required>
          <label class="label-icon" for="search"><i class="material-icons">search</i></label>
          <i class="material-icons">close</i>
        </div>
      </form>
			  </li>		 
		    <li><a href="eduBoard">영상게시판</a></li>
		    <li><a href="dubbingBoard">더빙게시판</a></li>
		    <li><a href="InvestigationBoard">자막게시판</a></li>
		    <li><a href="myPage">마이페이지</a></li>
		    
	  	  </ul>

	  	  
	  <!-- 로그인 MODAL -->
		<div id="modal1" class="modal">
			<div class="modal-content">
			<div class="container">
			
				<form class="col s12" id=loginForm action="login" method="POST">
				<div class="row">
					<h4 class="center-align">LOGIN</h4>
				
					<div class="row">
						<c:if test="${empty sessionScope.useremail }">
							<div class="input-field col s12">
								<i class="material-icons prefix">mail</i>
								<input id="useremail" type="text" class="validate" name="useremail" value="${useremail}">
								<label for="useremail">EMAIL</label>
							</div>
						</c:if>
					</div>
				
					<div class="row">
					<c:if test="${empty sessionScope.useremail }">
							<div class="input-field col s12">
								<i class="material-icons prefix">mode_edit</i>
								<input id="userpwd" type="password" class="validate" name="userpwd" value="${userpwd}">
								<label for="userpwd">PASSWORD</label>
							</div>
						</c:if>
					</div>
					
					<c:if test="${not empty sessionScope.useremail }">
						<h4 class="center">${sessionScope.useremail}환영합니다.</h4>
					</c:if>
				</div>	
				
					<div class="row">
						<div class="col s10">
							<c:if test="${empty sessionScope.useremail }">
								<span class="flow-text">
									<button class="btn waves-effect waves-light" type="button" id="loginBtn">ENTER
										<i class="material-icons right">send</i>
									</button>
								</span>
							</c:if>
						
							<span class="flow-text">
								<button class="btn waves-effect waves-light modal-close" id="back" type="button">BACK
									<i class="material-icons right">keyboard_return</i>
								</button>
							</span>
							<c:if test="${not empty sessionScope.useremail }">
								<span class="flow-text">
									<a href="logout" class="btn waves-effect waves-light modal-close">LOGOUT
										<i class="material-icons right">power_settings_new</i>
									</a>
								</span>
							</c:if>
						</div>
						
						<div class="fixed-action-btn">
								<a class="btn-floating btn-large red waves-effect waves-light tooltipped" data-position="left" data-tooltip="ACCOUNT?">
								<i class="large material-icons">person</i>
								</a>
								<ul>
								    <li><a href="joinForm" class="btn-floating blue tooltipped" data-position="top" data-tooltip="JOIN US!"><i class="material-icons">person_add</i></a></li>
								    <li><a href="recovery" class="btn-floating green tooltipped" data-position="top" data-tooltip="ACCOUNT RECOVERY"><i class="material-icons">sync</i></a></li>
								    <li><a href="closeID" class="btn-floating yellow darken-1 tooltipped" data-position="top" data-tooltip="QUIT US"><i class="material-icons">clear</i></a></li>
								</ul>
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
		    <li>
          <div class="user-view">
		        <div class="background">
		        <!-- <img src="images/"> -->
		        </div>
		        <!-- <a href="#user"><img class="circle" src="images/"></a> -->
		        <a href="#name"><span class="white-text name">${usernick}</span></a> 
		        <a href="#email"><span class="white-text email">${useremail}</span></a>
					</div>
				</li>
				<li>
					<a href="#!">
					<i class="material-icons">cloud</i>First Link With Icon</a>
				</li>
				<li>
					<a href="#!">wishList</a>
				</li>
				<li>
					<div class="divider"></div>
				</li>
				<li>
					<a class="subheader">회원정보관리</a>
				</li>
				<li>
					<a class="waves-effect" href="updateMember">회원정보수정</a>
				</li>
				<li>
					<a class="waves-effect" href="#">회원탈퇴</a>
				</li>
			</ul>
		</aside>
			
		<section>	
			<div class="container">
			  	<h3 class="center">인기 항목</h3>
			</div>
								
			<div class="carousel" >
				<c:forEach var="eList" items="${eList}">
					<a class="carousel-item" href="#one!" style="width:500px; height:auto;">
						<iframe class="video w100" width="640" height="360" src="http://www.youtube.com/embed/${eList.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1" frameborder="0" allowfullscreen></iframe>;
					</a>
				</c:forEach>
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
