<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<title>마이페이지</title>
<script type="text/javascript" src="js/Chart.js"></script>
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
			
			$('#back').on('click', function() {
				
			});
			
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
		
		
	</script>
<style>

</style>
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
		    <a href="${pageContext.request.contextPath}" class="brand-logo" style="margin-left:14px;">Logo</a>
		    <a href="#" data-target="small-navi"  class="sidenav-trigger"><i class="material-icons">menu</i></a>
		    <ul class="right hide-on-med-and-down">
		      	<c:if test="${not empty sessionScope.useremail }">
			      <li>
					<a href="logout">${sessionScope.useremail }님아logout</a>
			      </li>
				</c:if>
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
		    <li><a href="eduBoard.jsp">영상게시판</a></li>
		    <li><a href="dubbingBoard">더빙게시판</a></li>
		    <li><a href="InvestigationBoard">자막게시판</a></li>
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
							<span class="flow-text">
								<button class="btn waves-effect waves-light" type="button" id="loginBtn">ENTER
									<i class="material-icons right">send</i>
								</button>
							</span>
						
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
								    <li><a class="btn-floating green tooltipped" data-position="top" data-tooltip="ACCOUNT RECOVERY"><i class="material-icons">sync</i></a></li>
								    <li><a class="btn-floating yellow darken-1 tooltipped" data-position="top" data-tooltip="QUIT US"><i class="material-icons">clear</i></a></li>
								</ul>
						</div>
					</div>
				</form>
			</div>
		</div>	
	  </div>

	
		<div class="wrapper">
			 <!-- sidenav -->	  
			<aside>	  	  
			  	  <ul id="slide-out" class="sidenav" style="margin-top:64px;">
					<li><div class="user-view">
							<div class="background">
								<img src="images/office.jpg">
							</div>
							<a href="#user"><img class="circle" src="images/yuna.jpg"></a>
							<a href="#name"><span class="white-text name">John Doe</span></a> 
							<a href="#email"><span class="white-text email">jdandturk@gmail.com</span></a>
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
					<h5>이름 : ${usernick}</h5>
						<div class="row">
							<div class="col s12 m8">
								<div class="card">
									<div class="waves-effect waves-block waves-light">
										<div class="trending-line-chart-wrapper">
			 								<canvas id="myChart"></canvas>
	                                    </div>
									</div>
								</div>
							</div>
							<div class="col s12 m4 l4">
								<div class="card">
									<div class="waves-effect waves-block waves-light">
										<div class="trending-line-chart-wrapper">
				 							<canvas id="circle"></canvas>
		                                 </div>
									</div>
								</div>	
							</div>
						</div>
						
				</div>
			</section>
		</div>	
		
		 
		
		
		<br/><br/>
		
		<c:if test="${myInfo!=null }">
		
		승률 : ${myInfo.winningRate} (승 : ${myInfo.allSuccess}/ 패 :  ${myInfo.allFailure}/ 도전: ${myInfo.allChallenge})
		<br/>
		</c:if>
		<c:if test="${myInfo==null }">
		승률 데이터 없음 하셈	
		<br/>
		</c:if>
	
	
		보고있는 영상 : 
		<c:if test="${not empty notfinished}">
			<c:forEach var="nf" items="${notfinished}">
				<a href="detailEduBoard?videoNum=${nf.videoNum}">${nf.title}</a> 
			</c:forEach>
		</c:if>
		
		<c:if test="${empty notfinished}">
			없음
		</c:if> 
		<br/>
		완료한 영상 : 
		
		<c:if test="${not empty finished}">
			<c:forEach var="f" items="${finished}">
				<a href="detailEduBoard?videoNum=${f.videoNum}"> ${f.title}</a><br/>
			</c:forEach>
		</c:if>
		<c:if test="${empty finished}">
			없음
		</c:if> 
		
		<br/>
	
	
 		<c:forEach var="m" items="${levelMap}">
		 
		
			<c:if test="${m.key==1}">
				레벨1 : ${m.value}
			</c:if>
			
			<c:if test="${m.key==2}">
				레벨2 : ${m.value}
			</c:if>
			
			<c:if test="${m.key==3}">
				레벨3 : ${m.value}
			</c:if>
			
			<c:if test="${m.key==4}">
				레벨4 : ${m.value}
			</c:if>
			
			<c:if test="${m.key==5}">
				레벨5 : ${m.value}
			</c:if>
		
		</c:forEach> 
		
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
<script>
		//chart.js
		var ctx = document.getElementById("myChart");
		 var myChart = new Chart(ctx, {
			    type: 'bar',
			    data: {
			        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
			        datasets: [{
			            label: '# of Votes',
			            data: [12, 19, 3, 5, 2, 3],
			            backgroundColor: [
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)',
			                'rgba(255, 159, 64, 0.2)'
			            ],
			            borderColor: [
			                'rgba(255,99,132,1)',
			                'rgba(54, 162, 235, 1)',
			                'rgba(255, 206, 86, 1)',
			                'rgba(75, 192, 192, 1)',
			                'rgba(153, 102, 255, 1)',
			                'rgba(255, 159, 64, 1)'
			            ],
			            borderWidth: 1
			        }]
			    },
			    options: {
			        scales: {
			            yAxes: [{
			                ticks: {
			                    beginAtZero:true
			                }
			            }]
			        }
			    }
			});
		 
		 var ctx2 = document.getElementById("circle");
		 var circle = new Chart(ctx2, {
			    type: 'doughnut',
			    data: {
			    	labels: ["Red", "Blue", "Yellow"],
			    	datasets: [{
				        data: [10, 20, 30],
				        backgroundColor: [
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			            ]
				    }]
				    
			    }
			});
		 
		
</script>	
</body>
</html>