<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="author" content="zisung">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize1.css"  media="screen,projection"/>
      
	<title>자막검증게시판</title>
	    
	    
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script src="YoutubeAPI/auth.js"></script>
	    
	<script type="text/javascript">
	// css용
	$(function(){
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
		
		$('#back').on('click', function() {
			
		});
		
		$('#loginBtn').on('click',function(){
			var useremail = $('#useremail');
			var userpwd = $('#userpwd');
			
			$('#loginForm').submit();
		});
	});
		
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
			var dataForm = {
				"tableName":"Investigation"
				, "idCode":"investigationnum"
				, "useremail":useremail
				, "identificationnum":videonum
				, "recommendtable":"1"
				, "recommendation":"0"
			};
			
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
			var dataForm = {
				"tableName":"Investigation"
				, "idCode":"investigationnum"
				, "useremail":useremail
				, "identificationnum":videonum
				, "recommendtable":"1"
				, "recommendation":"1"
			};
			
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
		    <a href="index" class="brand-logo">Logo</a>
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
   
		<ul class="sidenav" id="small-navi">
		    <li><a href="eduBoard">영상게시판</a></li>
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
							<div class="input-field col s12">
								<i class="material-icons prefix">mail</i>
								<input id="useremail" type="text" class="validate" name="useremail" value="${useremail}">
								<label for="useremail">EMAIL</label>
							</div>
						</div>
					
						<div class="row">
							<div class="input-field col s12">
								<i class="material-icons prefix">mode_edit</i>
								<input id="userpwd" type="password" class="validate" name="userpwd" value="${userpwd}">
								<label for="userpwd">PASSWORD</label>
							</div>
						</div>
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
<<<<<<< HEAD
   	  
   	  <!-- 영상추가버튼 -->	
   	  <div class="fixed-action-btn">
		  <a class="btn-floating btn-large red modal-trigger tooltipped" id="requestInvestigation" data-position="top" data-tooltip="+VIDEO" href="#requestInv">
		    <i class="large material-icons">add_a_photo</i>
		  </a>
	  </div>
	
	<!-- 영상추가 모달 -->
	<div id="requestInv" class="modal">
		<div class="container">
			<div class="madal-content">
				<h5 class="center">영상추가</h5>
				<div class="row">
					<form>
						<div class="input-field col s12">
							<input type="text" class="validate" id="title" name="title"/>
							<label for="title">제목</label>
						</div>		
						<div class="input-field col s12">
							<input type="text" class="validate" id="url" name="url"/>
							<label for="url">요청URL</label>
						</div>			
						<div class="input-field col s12">
							<textarea id="content" class="materialize-textarea"></textarea>
	          				<label for="textarea1">내용</label>
						</div>
						<div class="center">	
							<button class="btn modal-close" type="button" id="back" class="btn">BACK</button>
							<input type="button" id="regist" class="btn" value="등록하기"> 
							<input type="reset" class="btn" value="초기화">
						</div>		
					</form>
				</div>				
				<h4 class="center" style="color:red;">YouTube Viral Search</h4>
				 
				 <div class="row col s12">
			        	<form action="#">
						    <div class="input-field col s9">
			            		<input type="text" id="search" placeholder="Type something..." autocomplete="off" class="form-control" />
			                </div>
			                <div class="input-field col s3">
			            	    <input type="button" id="searchBtn" value="Search" class="btn">
			            	</div>
			            </form>
			        	<div id="results"></div>
			      </div>
			  </div>
				
			</div>
		</div>
	
    <!-- Page Content -->
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
					<h4 class="center"><a href="InvestigationBoard">자막검증게시판</a></h4>
					<div class="row">
=======
   
	<input type="button" id="requestInvestigation" value="자막요청"/>
	
    <!-- Page Content -->
	<div class="container">
		<h3 class="center">자막검증게시판</h3>
		<div class="row">
		
		<c:if test="${not empty invList}">
			<c:forEach var="invList" items="${invList}">
			
			<div class="col s3 m3">
				<div class="card" style="height:400px margin-bottom:10px;">
					<div class="card-image">
							<img alt="" src="https://img.youtube.com/vi/${invList.url}/0.jpg">
							<a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
					</div>
>>>>>>> Muk
					
						<div class="card-content" style="height:150px;">
						<a href="detailInvBoard?investigationnum=${invList.investigationnum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${invList.title}</a>
					</div>
					
					<div class="card-action" style="height:70px">
						<div class="row">
							<input type="hidden" value="${invList.investigationnum}">
							<button class="btn recommendation">
								<i class="material-icons">thumb_up</i>
								<span id="recoCount">${invList.recommendation}</span>
							</button>
							
							<button class="btn decommendation">
								<i class="material-icons">thumb_down</i>
								<span id="decoCount">${invList.decommendation}</span>
							</button>
							<button class="btn disabled right decommendation" style="width:80px">
								<i class="material-icons">touch_app</i>
								<span>${invList.hitcount}</span>
							</button>	 
						</div>
					</div>
				</div>
<<<<<<< HEAD
			</section>
=======
			</div>
			</c:forEach>
		</c:if>
		</div>
		
		<div class="center">
			<ul class="pagination">
			<li class="waves-effect">
				<a href="eduBoard?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
					<i class="material-icons">first_page</i>
				</a>
			</li>
			
				<li class="waves-effect">
					<a href="eduBoard?currentPage=${navi.currentPage - 1}&searchType=${searchType}&searchWord=${searchWord}"> 
						<i class="material-icons">chevron_left</i>
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
			
				<li class="waves-effect">
					<a href="eduBoard?currentPage=${navi.currentPage + 1}&searchType=${searchType}&searchWord=${searchWord}">
						<i class="material-icons">chevron_right</i> 
					</a>
				</li>
			
				<li class="waves-effect">
					<a href="eduBoard?currentPage=${navi.currentPage + navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
						<i class="material-icons">last_page</i> 
					</a>
				</li>
			</ul>
>>>>>>> Muk
		</div>
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
	</div>
	<script type="text/javascript" src="js/materialize.min.js"></script>
</body>
</html>