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
	
    <style type="text/css">
		#checkline{
			text-align: center;
			color: red;
		}
	</style>
	
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script src="YoutubeAPI/auth.js"></script>
	    
	<script type="text/javascript">
		var urlCheck = false;
		
	    // css용
	    $(function(){
			//dropdown
			$(".dropdown-trigger").dropdown();
			
			//floating actionbutton
			$(".fixed-action-btn").floatingActionButton({
				/* direction:'left' */
			});
			
			//modal open
			$('#modal1').modal(); 	//로그인모달 
			$('#modal2').modal();
			$('#modal3').modal(); 	//회원정보수정 모달
			$('#modal4').modal();   //계정복구 모달 
			
			$('#addvideo').modal(); //영상추가 모달 

			//side-nav open
			$('.sidenav').sidenav();
			
			//tooltip
			$('.tooltipped').tooltip();
			
			//캐러셀
			$('.carousel').carousel();
			
			$('#sticker').on('click', function() {
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
			
			$('.search').on('keydown', function(key) {
				if (key.keyCode == 13) {
					// naver 검색
					$.each($('.search'), function(index, item) {
						if(item.value.length != 0) {
							var searchText = item.value;
							var http="https://endic.naver.com/search.nhn?sLn=kr&dicQuery="+searchText+"&x=0&y=0&query="+searchText+"&target=endic&ie=utf8&query_utf=&isOnlyViewEE=N";
							window.open("https://endic.naver.com/search.nhn?sLn=kr&dicQuery="+searchText+"&x=0&y=0&query="+searchText+"&target=endic&ie=utf8&query_utf=&isOnlyViewEE=N","_blank", "width=700px, height=400px");	
						}
					});
				}
			});
		});
    	
	    //영상추가 
		$(function() {
			$('#checkForm').on('click', function() {
				var title = $('#title');
				var subtitle = $('#subtitle');
				
				if(title.val().trim().length == 0) {
					alert("제목을 입력해주세요.");
					title.focus();
					return;
				}
				
				// url 체크 확인 추가
				if(urlCheck == false) {
					alert("URL중복 검사 통과해주세요.");
					return;
				}
				
				if(subtitle.val().trim().length == 0) {
					alert('파일을 넣어주세요.');
					subtitle.focus();
					return;
				}
				$('#addEduVideoForm').submit();
			});
			
			$('#urlCheck').on('click', function() {
				var url = $('#url');
				var originalURL = url.val();				// 원본 URL
				
				// 영상 URL 입력 확인
				if(originalURL.trim().length == 0) {
					alert('영상 URL을 입력해주세요.');
					url.focus();
					urlCheck = false;
					return;
				}
				
				// VideoID 추출
	       		var markIndex = originalURL.indexOf("?");	// GET방식 인자를 제외한 실제 주소
	       		var findVideoId = "";
	       		if(markIndex == -1) {
	       			if(originalURL.includes("embed") == false) {
	       				alert("Youtube Video URL을 제대로 입력해주세요.");
	       				urlCheck = false;
	       				return;
	       			}
	       			
	       			var embedIndex = originalURL.indexOf("embed")+6;
	       			findVideoId = originalURL.substring(embedIndex);	//iframe에서 선택시 VideoId추출
	       		}else {
	       			if(originalURL.includes("youtube.com") == false || originalURL.indexOf("v=") == -1) {
	       				alert("Youtube Video URL을 제대로 입력해주세요.");
	       				urlCheck =false;
	       				return;
	       			}
	       			
	       			var vIndex = originalURL.indexOf("v=")+2;
	       			var firstAmpIndex = originalURL.substring(vIndex).indexOf("&");
	       			
	       			if(firstAmpIndex == -1) {
	       				findVideoId = originalURL.substring(vIndex);
	       			}else {
	       				findVideoId = originalURL.substring(vIndex, vIndex+firstAmpIndex);
	       			}
	       		}
	       		alert(findVideoId);
	       		// 영상 중복 검사
	       		$.ajax({
	       			method: 'get'
	       			, url : 'existVideo'
	       			, data: 'url='+findVideoId
	       			, dataType: 'text'
	       			, async: false
	       			, success: function(resp) {
	       				if(resp == 'success') {
	       					$('#videoId').val(findVideoId);
	       					$('#invDelete').val('false');
	       					urlCheck = true;
	       					
	       					alert("등록 가능한 영상입니다.");
	       				}else if(resp == 'eduExist') {
	       					urlCheck = false;
	       					
	       					alert("이미 등록되어 있는 영상입니다.");
	       				}else if(resp == 'invExist') {
	       					if(confirm('자막 검증 게시글에 있는 영상입니다. 그래도 등록하시겠습니까?')) {
	       						$('#videoId').val(findVideoId);
	       						$('#invDelete').val('true');
	       						urlCheck = true;
	       						
	       						alert("등록 진행");
	       					}else {
	       						urlCheck = false;
	       						alert("등록 취소");
	       					}
	       				}
	       			}, error:function(resp, code, error) {
						alert("resp : "+resp+", code:"+code+", error:"+error);
					}
	       		});
				//alert("videoID : "+$('#videoId').val());
				//alert("invDelete : "+$('#invDelete').val());
				//alert("유무 확인 : "+urlCheck);
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
    	
    	$(function(){
    		//위시리스트에 비디오 등록
    		$('.btnRegistVideoWish').on('click', function(){
    			var target = $(this);
				var useremail = "${sessionScope.useremail}";
				var videonum = target.parent().children("#videonum").val();
				var title = target.parent().parent().children('.card-content').children("a").html();
				var url = target.parent().children("#url").val();
				
				alert("title : "+title+"videonum:"+videonum+"url:"+url);
				//로그인된 세션이 있는지 확인
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}else{
					//선택된 비디오 정보를 위시리스트로 보내기
					var dataFormVideo = {
							"wishtable": 0,							
							"useremail":useremail, 
							"identificationnum":videonum,
							"title"	: title,
							"url" : url							
					};
					
					$.ajax({
						method:'post'
						, url:'insertVideoWish'
						, data: JSON.stringify(dataFormVideo)
						, contentType: "application/json; charset=utf-8"
						, async : false
						, success:function(resp) {
							if(resp == "success")
								alert("영상을 찜한 목록에 등록하였습니다.");
							else if(resp == "failure")
								alert("영상이 이미 찜한 목록에 있습니다.");
							else if(resp == "failRegist")
								alert("영상을 찜한 목록 등록하는데 실패하였습니다.")
						  }
						, error:function(resp, code, error) {
							alert("resp : "+resp+", code : "+code+", error : "+error);
						}
					});					
				}    			
    		});    		
    	});
    </script>
</head>

<body>
    <header>
		<c:if test="${plzLogin!=null}">
			<script type="text/javascript">
				$(function(){
					alert("${plzLogin}");
				});
			</script>
		</c:if>
	
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
									<input id="checkline" value="" type="text" style="border-bottom: none;" readonly="readonly"/>
								</div>
							</c:if>
						</div>
							
						<!-- 글씨뜨는거 -->
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
							    <li><a class="btn-floating modal-close modal-trigger green tooltipped" data-position="top" data-tooltip="ACCOUNT RECOVERY" href="#modal4"><i class="material-icons">sync</i></a></li>
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
	  
	  <!-- 계정복구 모달 -->
	  	<div id="modal4" class="modal">
			<div class="modal-content">
				<div class="container center">
					<h5>계정을 복구하시겠습니까?</h5>
					<form id="req" action="recoveryMail" method="post">
						<div class="input-field col s12">
							<i class="material-icons prefix">mail</i>
							<input id="recoveryEmail" type="text" name="recoveryEmail" placeholder="이메일 주소를 입력하세요."/>
						</div>
						<input type="button" class="btn" value="이메일인증" onclick="check()">
					</form>
					<!-- 이메일 인증을 하고 인증이 되면 해당 이메일 주소를 recoveryID tag에 넣고 recovery() 메소드 호출-->
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
			      <form id="addEduVideoForm" action="addEduVideo" method="post" enctype="multipart/form-data">
			      		<input type="hidden" name="useremail" value="${sessionScope.useremail}"/>
			      		<input type="hidden" id="invDelete" name="invDelete" value=""/> 
						<div class="input-field col s12">
							<input type="text" class="validate" id="title" name="title"/>
							<label for="title">영상제목입력</label>
						</div>
						<div class="row">
							<div class="input-field col s8">
								<input type="text" class="validate" id="url"/>
								<input type="hidden" id="videoId" name="url"/> 
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
						<input type="button" id="checkForm" class="btn" value="영상 등록"/>
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
				<li>
					<div class="user-view">
						<div class="background">
							<img src="images/">
              				<a href="#user"><img class="circle" src="images/"></a>
						  	<a href="#name"><span class="white-text name">${usernick}</span></a> 
						  	<a href="#email"><span class="white-text email">${useremail}</span></a>
						</div>
					</li>
					<li><a href="#!"><i class="material-icons">cloud</i>First Link With Icon</a></li>
					<li><a href="#!">wishList</a></li>
					<li><div class="divider"></div></li>
					<li><a class="subheader">회원정보관리</a></li>
					<li><a class="waves-effect modal-close modal-trigger" href="#modal3">회원정보수정</a></li>
					<li><a class="waves-effect modal-close modal-trigger" href="#modal2">회원탈퇴</a></li>
				</ul>
			</aside>	
			
			<section>
      <!-- Page Content -->
      <div class="container">
         <div class="row">
            <h4 class="left"><a href="eduBoard">추천학습영상</a></h4>
         </div>
         
         <div class="row">
            <c:if test="${not empty eduList}">
               <c:forEach var="eduList" items="${eduList}">
                  <div class="col s12 m3 l3">
                     <div class="card" style="height:440px; margin-bottom:10%;">
                     
						<div class="card-image">
							<img alt="" src="https://img.youtube.com/vi/${eduList.url}/0.jpg">
							<input type="hidden" id="url" value="${eduList.url}"/>
							<input type="hidden" id="videonum" value="${eduList.videoNum}"/>
							<a class="btn-floating halfway-fab waves-effect waves-light red tooltipped btnRegistVideoWish" data-position="bottom" data-tooltip="찜!"><i class="material-icons">add</i></a>
						</div>
                        
                        <div class="card-content" style="height:150px;">
                           <a href="detailEduBoard?videoNum=${eduList.videoNum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${eduList.title}</a>
                        </div>
                        
                        <div class="card-action" style="height:60px; padding-left:5%; padding-right:5%;">
                           <div class="row">
                              <div class="col s12 m12 l12">
                                 <input type="hidden" value="${eduList.videoNum}"/>
                                 <button class="btn recommendation">
                                    <i class="material-icons">thumb_up</i>
                                    <span id="recoCount">${eduList.recommendation}</span>
                                 </button>
                                 <button class="btn decommendation">
                                    <i class="material-icons">thumb_down</i>
                                    <span id="decoCount">${eduList.decommendation}</span>
                                 </button>
                                 <button class="btn disabled right decommendation">
                                    <i class="material-icons">touch_app</i>
                                    <span>${eduList.hitCount}</span>
                                 </button>
                              </div>
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
						<id class="material-icons">last_page</i> 
					</a>
				</li>
			</ul>
		</div>
		
	<footer class="page-footer">
    	<div class="container">
        	<div class="row">
              	<div class="col l6 s12">
                	<h5 class="white-text">One jewelry 7th Group</h5>
                	<p class="grey-text text-lighten-4">Enjoy & Try study English</p>
                	<p class="grey-text text-lighten-4">We support your English</p>
              	</div>
              	<div class="col l4 offset-l2 s12">
                <h5 class="white-text">Made By</h5>
                <ul>
                  	<li><a class="grey-text text-lighten-3" href="#!">WOO SUK</a></li>
                  	<li><a class="grey-text text-lighten-3" href="#!">AHN JISUNG</a></li>
                  	<li><a class="grey-text text-lighten-3" href="#!">LEE YEOREUM</a></li>
                  	<li><a class="grey-text text-lighten-3" href="#!">IM KWANGMUK</a></li>
                  	<li><a class="grey-text text-lighten-3" href="#!">JUNG DANA</a></li>
                	</ul>
            	</div>
       		</div>
        </div>
       	<div class="footer-copyright">
            <div class="container">
            © 2018 Copyright 일석칠조
            <a class="grey-text text-lighten-4 right" href="#!">More Links</a>
        	</div>
    	</div>
    </footer>

<script type="text/javascript" src="js/materialize.min.js"></script>
</body>
</html>