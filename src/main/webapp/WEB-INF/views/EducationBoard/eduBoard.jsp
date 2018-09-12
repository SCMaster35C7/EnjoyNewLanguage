<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<title>공부영상게시판</title>
    
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
			$('#modal1').modal(); //로그인모달 
			$('#addvideo').modal();  //영상추가 모달 
			
			//side-nav open
			$('.sidenav').sidenav();
			
			//tooltip
			$('.tooltipped').tooltip();
			
			//캐러셀
			$('.carousel').carousel();
			
			$('#back').on('click', function() {
				
			});
			
			$('#sticker').on('click', function() {
				//alert('emf어오냐');
				$('#checkline').val('');
			});
			
$('#loginBtn').on('click', function() {
				
				var useremail = $('#useremail').val();
				var userpwd = $('#userpwd').val();
				
				var sendData = {	
						"useremail":useremail
						,"userpwd": userpwd
				};
				
				$.ajax({
					method	:	'post'
					, url	: 'statusCheck'
					, data	: JSON.stringify(sendData)
					, dataType	: 'text'
					, contentType: 'application/json; charset=utf-8'
					, success	: function(resp){
						if (resp=="checkEmail") {
							$("#checkline").val('이메일 인증 먼저 해주세요!');
						}else if (resp=="loginFailure") {
							//alert('담으로가자');
							//$('#loginForm').submit();
							$("#checkline").val('아이디나 비밀번호가 틀렸습니다!');
						} else {
							window.location.reload();
						}
					}, error:function(resp, code, error) {
						alert("resp : "+resp+", code:"+code+", error:"+error);
					}
				});//ajax
			});
		});
    	
	    //영상추가 
		$(function() {
			$('#checkForm').on('click', function() {
				var title = $('#title');
				var url = $('#url');
				var subtitle = $('#subtitle');
				
				if(title.val().trim().length == 0) {
					alert('영상 제목을 입력해주세요.');
					title.focus();
					return false;
				}
				
				if(url.val().trim().length == 0) {
					alert('영상 URL을 입력해주세요.');
					url.focus();
					return false;
				}
				
				
				if(subtitle.val().trim().length == 0) {
					alert('파일을 넣어주세요.');
					subtitle.focus();
					return false;
				}
				
				return true;
			});
		});
    
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
				var recoCount = Number(target.children("span").text());
				var decoTarget = target.parent().children(".decommendation").children("#decoCount");
				var videonum = target.parent().children("input").val();
				var dataForm = {
						"tableName":"educationvideo", 
						"idCode":"videonum", 
						"useremail":useremail, 
						"identificationnum":videonum,
						"recommendtable":"0",
						"recommendation":"0"
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
						"tableName":"educationvideo",
						"idCode":"videonum",  
						"useremail":useremail, 
						"identificationnum":videonum, 
						"recommendtable":"0", 
						"recommendation":"1"
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
    <style type="text/css">
		#checkline{
			text-align: center;
			color: red;
		}
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
	    <a href="${pageContext.request.contextPath}" class="brand-logo">Logo</a>
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
        	<i class="medium material-icons" id="sticker">person</i>
     		 </a>
		</div>
	</nav>
	</header>
   
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
					
					<!-- 글씨뜨는거 -->
						 <input id="checkline" value="" type="text" style="border-bottom: none;"  />
					
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
								    <li><a class="btn-floating green tooltipped" data-position="top" data-tooltip="ACCOUNT RECOVERY"><i class="material-icons">sync</i></a></li>
								    <li><a class="btn-floating yellow darken-1 tooltipped" data-position="top" data-tooltip="QUIT US"><i class="material-icons">clear</i></a></li>
								</ul>
						</div>
					</div>
				</form>
			</div>
		</div>	
	  </div>
   
   <!-- admin 영상추가 -->	
	<c:if test="${(not empty sessionScope.admin) and sessionScope.admin == 0}">
		<div class="fixed-action-btn">
		  	<a class="btn-floating btn-large red modal-trigger tooltipped" data-position="top" data-tooltip="+VIDEO" href="#addvideo">
		    	<i class="large material-icons">add_a_photo</i>
		  	</a>
		</div>
	</c:if>
   
  	<!-- 영상추가 모달 -->
  	<div id="addvideo" class="modal">
  		<div class="container">
  		<div class="modal-content">
		      <h5 class="center">교육 영상 삽입</h5>
		      <div class="row">
			      <form action="addEduVideo" method="post" enctype="multipart/form-data">
						<div class="input-field col s12">
							<input type="text" class="validate" id="title" name="title"/>
							<label for="title">영상제목입력</label>
						</div>
						<div class="row">
							<div class="input-field col s8">
								<input type="text" class="validate" id="url" name="url"/>
								<label for="url">URL입력</label>
							</div>
							<div class="input-field col s4">
								<input type="button" class="btn" id="urlCheck" value="중복 확인"/>
							</div>	
						</div>	
							<div class="file-field input-field">
								<div class="btn">
									<span>FILE</span>
									<input type="file" id="subtitle" name="subtitle"/>
								</div>
								<div class="file-path-wrapper">
									<input class="file-path validate" type="text">
								</div>	
							</div>
					</form>	
							<div class="center">
								<input type="submit" id="checkForm" class="btn" value="영상 등록"/>
								<input type="reset" class="btn" value="재입력"/>
							</div>
				</div>
		 </div>
		 </div>
		    <div class="modal-footer">
		      <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Close</a>
			</div>
  	</div>		
	
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
    <!-- Page Content -->
	<div class="container">
		<h4 class="center"><a href="eduBoard">공부게시판메인</a></h4>
		<div class="row">
			
		<c:if test="${not empty eduList}">
			<c:forEach var="eduList" items="${eduList}">
			
			<div class="col s12 m3 l3">
				<div class="card" style="height:400px margin-bottom:10px;">
					<div class="card-image">
						<img alt="" src="https://img.youtube.com/vi/${eduList.url}/0.jpg">
						<a class="btn-floating halfway-fab waves-effect waves-light red tooltipped" data-position="bottom" data-tooltip="찜!"><i class="material-icons">add</i></a>
					</div>
					<div class="card-content" style="height:150px;">
							<a href="detailEduBoard?videoNum=${eduList.videoNum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${eduList.title}</a>
					</div>
						
					<div class="card-action" style="height:70px">
						<div class="row s12 m12">
							<input type="hidden" value="${eduList.videoNum}"/>
							<button class="btn recommendation"  style="width:65px; padding-right:4px; padding-left:4px;">
								<i class="material-icons">thumb_up</i>
								<span id="recoCount">${eduList.recommendation}</span>
							</button>
							<button class="btn decommendation" style="width:65px; padding-right:4px; padding-left:4px;">
								<i class="material-icons">thumb_down</i>
								<span id="decoCount">${eduList.decommendation}</span>
							</button>
							<button class="btn disabled right decommendation" style="width:80px">
								<i class="material-icons">touch_app</i>
								<span>${eduList.hitCount}</span>
							</button>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
		</c:if>
		</div>
		
		</div>
		</section>
		</div>
		<!-- pagination -->
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


<script type="text/javascript" src="js/materialize.min.js"></script>
</body>
</html>