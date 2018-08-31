<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="zisung">
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<!--Import Google Icon Font-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!--Import materialize.css-->
    <!--   <link href="https://cdnjs.cloudflare.com/ajax/libs/material-design-lite/1.1.0/material.min.css" rel="stylesheet"/>
       <link href="https://cdn.datatables.net/1.10.19/css/dataTables.material.min.css" rel="stylesheet"/>  -->
      <link type="text/css" rel="stylesheet" href="css/jquery.dataTables.css"  media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="css/materialize1.css"/>
      
      <!-- dataTables -->
      

      <!--Let browser know website is optimized for mobile-->
<title>subtitlesList</title>

<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>	
<script>

	
	$(function(){
	 	//$('#dubbing').DataTable();
		 $('select').formSelect();
		
		//dropdown
		$(".dropdown-trigger").dropdown();
		
		//floating actionbutton
		$(".fixed-action-btn").floatingActionButton({
			/* direction:'left' */
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
	  <li><a href="#!">one</a></li>
	  <li><a href="#!">two</a></li>
	  <li class="divider"></li>
	  <li><a href="#!">three</a></li>
	</ul>
	
	<!-- nav -->
	<nav class="nav-extended">
	  <div class="nav-wrapper">
	    <a href="#!" class="brand-logo">Logo</a>
	    <a href="#" data-target="small-navi"  class="sidenav-trigger"><i class="material-icons">menu</i></a>
	    <ul class="right hide-on-med-and-down">
	      <li><a href="#">공부게시판</a></li>
	      <li><a href="#">더빙게시판</a></li>
	      <li><a href="#">마이페이지</a></li>
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
	    <li><a href="#">공부게시판</a></li>
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
						<div class="col s10">
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
						
						<span class="flow-text">
							<button class="btn waves-effect waves-light modal-close">LOGOUT
								<i class="material-icons right">settings_power</i>
							</button>
						</span>
						</div>
						
						
						<div class="fixed-action-btn">
								<a class="btn-floating btn-large red waves-effect waves-light tooltipped" data-position="left" data-tooltip="ACCOUNT?">
								<i class="large material-icons">person</i>
								</a>
								<ul>
								    <li><a class="btn-floating blue tooltipped" data-position="top" data-tooltip="JOIN US!"><i class="material-icons">person_add</i></a></li>
								    <li><a class="btn-floating green tooltipped" data-position="top" data-tooltip="ACCOUNT RECOVERY"><i class="material-icons">sync</i></a></li>
								    <li><a class="btn-floating yellow darken-1 tooltipped" data-position="top" data-tooltip="QUIT US"><i class="material-icons">clear</i></a></li>
								</ul>
						</div>
				</div>
				</form>
			</div>
		</div>	
	  </div>
	  
	  <div class="container">
	 	<h3 class="center">자막검증게시판메인</h3>
			 <div class="row">
		    	<div class="col s3 m3">
		      		<div class="card">
			      		 <div class="card-image">
			          		<img src="images/ronaldo.jpg">
			          			<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
			        			</div>
			        	<div class="card-content">
			          		<span class="card-title">Card Title</span>
			          		<p>I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.</p>
			        	</div>
			        	<div class="card-action">
			        		<a class="btn-floating btn-small"><i class="material-icons">thumb_up</i>
			        			<p>숫자</p>
			        		</a>
			        		<a class="btn-floating btn-small"><i class="material-icons">thumb_down</i><span>1</span></a>
			        	</div>
			  		</div>
			 	</div>
	    
	    		<div class="col s3 m3">
		      		<div class="card">
			      		 <div class="card-image">
			          		<img src="images/ronaldo.jpg">
			          			<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
			        	</div>
			        	<div class="card-content">
			          		<span class="card-title">Card Title</span>
			          		<p>I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.</p>
			        	</div>
			  		</div>
			 	</div>
			 	
			 	<div class="col s3 m3">
		      		<div class="card">
			      		 <div class="card-image">
			          		<img src="images/ronaldo.jpg">
			          			<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
			        	</div>
			        	<div class="card-content">
			          		<span class="card-title">Card Title</span>
			          		<p>I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.</p>
			        	</div>
			  		</div>
			 	</div>
			 	
			 	<div class="col s3 m3">
		      		<div class="card">
			      		 <div class="card-image">
			          		<img src="images/ronaldo.jpg">
			          			<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
			        	</div>
			        	<div class="card-content">
			          		<span class="card-title">Card Title</span>
			          		<p>I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.</p>
			        	</div>
			  		</div>
			 	</div>
  			</div>
 		
 			 <div class="row">
		    	<div class="col s3 m3">
		      		<div class="card">
			      		 <div class="card-image">
			          		<img src="images/ronaldo.jpg">
			          			<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
			        	</div>
			        	<div class="card-content">
			          		<span class="card-title">Card Title</span>
			          		<p>I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.</p>
			        	</div>
			  		</div>
			 	</div>
	    
	    		<div class="col s3 m3">
		      		<div class="card">
			      		 <div class="card-image">
			          		<img src="images/ronaldo.jpg">
			          			<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
			        	</div>
			        	<div class="card-content">
			          		<span class="card-title">Card Title</span>
			          		<p>I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.</p>
			        	</div>
			  		</div>
			 	</div>
			 	
			 	<div class="col s3 m3">
		      		<div class="card">
			      		 <div class="card-image">
			          		<img src="images/ronaldo.jpg">
			          			<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
			        	</div>
			        	<div class="card-content">
			          		<span class="card-title">Card Title</span>
			          		<p>I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.</p>
			        	</div>
			  		</div>
			 	</div>
			 	
			 	<div class="col s3 m3">
		      		<div class="card">
			      		 <div class="card-image">
			          		<img src="images/ronaldo.jpg">
			          			<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
			        	</div>
			        	<div class="card-content">
			          		<span class="card-title">Card Title</span>
			          		<p>I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.</p>
			        	</div>
			  		</div>
			 	</div>
  			</div>
 		</div>
 		
 		<div class="center">
	 		 <ul class="pagination">
			    <li class="disabled"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
			    <li class="active"><a href="#!">1</a></li>
			    <li class="waves-effect"><a href="#!">2</a></li>
			    <li class="waves-effect"><a href="#!">3</a></li>
			    <li class="waves-effect"><a href="#!">4</a></li>
			    <li class="waves-effect"><a href="#!">5</a></li>
			    <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
	 		 </ul>
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
 
            
          
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/materialize.min.js"></script>
</body>
</html>