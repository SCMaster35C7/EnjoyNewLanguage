<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>더빙게시판</title>

<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>	

<script>
$(document).ready(function() {
    var table = $('#dubbing').DataTable();
 
    /* $('a.toggle-vis').on( 'click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = table.column( $(this).attr('data-column') );
 
        // Toggle the visibility
        column.visible( ! column.visible() );
    } ); */
    
});
	
	$(function(){
	 	//$('#dubbing').DataTable();
		 $('select').formSelect();
		
		//dropdown
		$(".dropdown-trigger").dropdown();
		
		//floating actionbutton
		$(".fixed-action-btn").floatingActionButton({
		});
		
		//modal open
		$('#modal1').modal();
		$('#modal2').modal();
		$('#modal3').modal(); //회원정보수정 모달
		
		$('#back').on('click', function() {
			
		});
		
		//side-nav open
		$('.sidenav').sidenav();
		
		//tooltip
		$('.tooltipped').tooltip();
		
		//캐러셀
		$('.carousel').carousel();
		

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
	
	
		$('#VideoSearchbtn').on('click', function() {
			var useremail = "${sessionScope.useremail}";
			
			if(useremail.trim().length == 0) {
				$('#modal1').modal('open');
				return;
			}
				$('#VideoSearch').modal();
				$(document).keyup(function(event){
	    			if(event.keyCode=='13'){
	    				if($('#search').val().length == 0) {
	           				alert("검색어를 입력하세요.");
	           				$('#search').focus();
	           				return;
	           			}
	            		init();
	            		search();
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
		      <li>
				  <div class="header-search-wrapper hide-on-med-and-down" style="display:inline-block; width:300px; margin-left:-5%;">
	                  <i class="material-icons" style="margin-left:-50px;">search</i>
	                  <input type="search" name="search" class="header-search-input z-depth-2 search" placeholder="SEARCH WORD"/>
	              </div>
			  </li>		 
		      <li><a href="eduBoard">영상게시판</a></li>
		      <li><a href="dubbingBoard">더빙게시판</a></li>
		      <li><a href="InvestigationBoard">자막검증게시판</a></li>
		      <li><a href="myPage" style="margin-right:20px;">마이페이지</a></li>
		    </ul>
		  </div>

	
		<div class="nav-content">
			<a class="btn-floating btn-large halfway-fab pulse modal-trigger tooltipped" data-position="left" data-tooltip="LOGIN!" href="#modal1">
        	<i class="medium material-icons" id="sticker">person</i>
     		 </a>
		</div>
	</nav>
	</header>
	  
	  <!-- 창 축소시 사이드 nav -->
			<ul class="sidenav" id="small-navi">
				<li>
		        	<div class="input-field" style="width:70%; margin-left:15%;">
		          		<input class="search" type="search" required>
		          		<label class="label-icon" for="search" style="margin-left:-18%;"><i class="material-icons">search</i></label>
		          		<i class="material-icons">close</i>
		       		</div>
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
								    <li><a class="btn-floating yellow darken-1 modal-close modal-trigger tooltipped"  data-position="top" data-tooltip="QUIT US" href="#modal2"><i class="material-icons">clear</i></a></li>
								</ul>
						</div>
				</div>
				</form>
			</div>
		</div>	
	  </div>
	  
	  <!-- 회원수정모달 -->
	  <div id="modal3" class="modal">
		<div class="modal-content">
			<div class="container center">
				<h5>회원정보수정</h5>
				<form id="updateMember" action="updateMember" method="post">
					<div class="row" style="margin-top:10%;">
						<div class="col s6">
							<table class="highlight">
								<tr>
									<th>EMAIL</th>
									<td>${sessionScope.useremail}</td>
								</tr>
								<tr>
									<th>성별</th>
									<td>${sessionScope.gender}</td>
								</tr>
							</table>
						</div>
						<div class="col s6">
							<table class="highlight">
								<tr>
									<th>NICK</th>
									<td>${sessionScope.usernick}</td>
								</tr>
								<tr>
									<th>생일</th>
									<td>${sessionScope.birth}</td>
								</tr>
							</table>
						</div>
						
						<div class="input-field col s12">
							<i class="material-icons prefix">mail</i>
							<input type="text" id="usernick" name="usernick" placeholder="변경 닉네임 입력" />
							<span id="nickcheck"></span>
						</div>
						<div class="input-field col s12">
							<i class="material-icons prefix">create</i>
							<input id="currpwd" type="password" name="currpwd" placeholder="현재 비밀번호 입력" />
						</div>
						<div class="input-field col s12">
							<i class="material-icons prefix">border_color</i>
							<input id="newpwd" type="password" name="newpwd" placeholder="새 비밀번호 입력" />
						</div>
						<div class="input-field col s12">
							<i class="material-icons prefix">check</i>
							<input id="checkpwd" type="password"  placeholder="새 비밀번호 확인" />
						</div>
						
						<div class="col s12">
							<input type="button" class="btn" value="수정" id="btnUpdate" />
							<input type="button" class="btn" value="취소" id="btnCancel" />
						</div>
					</div>	
				</form>
			</div>
		</div>
	</div>	
	  
	  <!-- 회원탈퇴 모달 -->
	  <div id="modal2" class="modal">
		<div class="modal-content">
			<div class="container center">
				<h5>탈퇴하시겠습니까?</h5>
				
				<div class="row">
					<form action="insertCloseID" method="post" id="submitform">
						<div class="input-field col s12">
			          		<i class="material-icons prefix">mail</i>
			          		<input id="useremail" name="useremail" type="text" class="validate">
			          		<label for="useremail">USERMAIL</label>
			        	</div>
					</form>
			        <div class="input-field col s12">
			          <i class="material-icons prefix">mode_edit</i>
			          <input id="pwd" type="password" class="validate">
			          <label for="pwd">PASSWORD</label>
			        </div>
				<div class="row">
					<span class="flow-text">
						<button class="btn waves-effect waves-light modal-close" id="back" type="button">BACK
							<i class="material-icons right">keyboard_return</i>
						</button>
					</span>
					<span class="flow-text">
						<button class="btn" onclick="closeID()">QUIT
							<i class="material-icons right">mood_bad</i>
						</button>
					</span>	
				</div>	
			</div>
				<p style="color:red;">회원탈퇴 후 한달 이내에 계정을 복구할 수 있습니다.</p>
				<p style="margin-top:0;">기간 이후에는 회원정보가 영구 삭제됩니다.</p>
			</div>
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
					<li><a class="waves-effect modal-close modal-trigger" href="#modal3">회원정보수정</a></li>
					<li><a class="waves-effect modal-close modal-trigger" href="#modal2">회원탈퇴</a></li>
				</ul>
			</aside>
			
			<section>	
		         <div class="container">
		          <div class="section">
		          <h4 class="center">더빙게시판</h4>
		            <!--DataTables example-->
		                  <table id="dubbing">
		                    <thead>
		                        <tr>
		                            <th>글번호</th>
		                            <th>글제목</th>
		                            <th>닉네임</th>
		                            <th>조회수</th>
		                            <th>날짜</th>
		                            <th>추천</th>
		                            <th>비추천</th>
		                        </tr>
		                    </thead>
		                 
		                    <tbody>
		                    	<c:forEach var="dub" items="${dubbing}">
		                        <tr>
		                            <td>${dub.dubbingnum}</td>
		                            <td><a href="dubDetail?dubbingnum=${dub.dubbingnum}"> ${dub.title} </a></td>
		                            <td>${dub.usernick}</td>
		                            <td>${dub.hitcount}</td>
		                            <td>${dub.regdate}</td>
		                            <td>${dub.recommendation}</td>
		                            <td>${dub.decommendation}</td>
		                        </tr>
		                        </c:forEach>
		                    </tbody>
		                  </table>
		                </div>
		              </div>
		        </section>
         </div>
		
	<!-- 더빙영상찾기버튼 -->
		<div class="fixed-action-btn">
		  <a class="btn-floating btn-large red modal-trigger tooltipped" id="VideoSearchbtn" data-position="top" data-tooltip="SEARCH" href="#VideoSearch">
		    <i class="large material-icons">search</i>
		  </a>
	  	</div>	
	
	<!-- 더빙영상검색모달 -->
	
	<div id="VideoSearch" class="modal">
		<div class="container">
			<div class="madal-content">
				<h5 class="center">더빙영상검색</h5>
				<input type="hidden" id="url" /> 

	 			<h4 class="center" style="color:red;">YouTube Viral Search</h4>
				 <div class="row col s12">
			     
			     		<div class="input-field col s9">
			           		<p><input type="text" id="search" placeholder="Type something..." autocomplete="off" class="form-control" /></p>
			            </div>
			            <div class="input-field col s3">
			                <p><input type="button" id="searchBtn" value="Search" class="btn"></p>
			            </div>
			      
			        	<div id="results"></div>
			      	</div>
			  	</div>
			</div>
		</div>
		
		<!-- 다나? -->
	<c:if test="${plzLogin!=null}">
		<script type="text/javascript">
			$(function(){
				alert("${plzLogin}");
			});
		</script>
	</c:if>
  
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
<script type="text/javascript" src="YoutubeAPI/search.js"></script>
	<script src="https://apis.google.com/js/client.js?onload=init"></script>
    <script>
    var pageName='VideoSearch';
    	$(function() {
       		$("#searchBtn").on('click', function() {
       			if($('#search').val().length == 0) {
       				alert("검색어를 입력하세요.");
       				$('#search').focus();
       				return;
       			}
        		init();
        		search();
        	});  		
        });
    	
    	function DubbingWrite(){
   			var originalURL = $('#url').val();				// 원본 URL
       		var findVideoId = "";
       		var embedIndex = originalURL.indexOf("embed")+6;
       		
   			findVideoId = originalURL.substring(embedIndex);	//iframe에서 선택시 VideoId추출
       		location.href="DubbingWrite?url="+findVideoId;
       		
       		console.log('originalURL: '+originalURL);
       		console.log('findVideoId: '+findVideoId);
   		}
	</script>	
</body>
</html>