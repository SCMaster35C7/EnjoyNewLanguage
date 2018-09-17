<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DJ DJ 더빙 시작</title>
<meta name="author" content="zisung">
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="css/materialize1.css" media="screen,projection" />
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script>
	var saveTime = null; //자막 싱크용 시간저장변수
	var videoStartTime = 0; //비디오 시작타임, 파일이름생성에 쓰인다.
	var cherkPoint = true;

	$(function() {
		$('#record').on('click', function() {
			saveVideoStartTime();
			cherkPoint = (!cherkPoint);
		});
		$('#directions').modal();
		$('#directions').modal('open');
		
		//modal open
		$('#modal1').modal();
		$('#modal2').modal(); //회원탈퇴 모달
		$('#modal3').modal(); //회원정보수정 모달
		$('#modal4').modal(); //계정복구 모달

		
		//floating actionbutton
		$(".fixed-action-btn").floatingActionButton({
			/* direction:'left' */
		});		
		//side-nav open
		$('.sidenav').sidenav();
		
		//tooltip
		$('.tooltipped').tooltip();
		
		//캐러셀
		$('.carousel').carousel();
		
		$('#sticker').on('click', function() {
			$('#checkline').val('');
		});
		
		$('#loginBtn').on('click',function(){
			var useremail = $('#useremail');
			var userpwd = $('#userpwd');
			

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
		

	function closeModal(){
		var elem=document.getElementById('directions');
		var instance = M.Modal.getInstance(elem);
		instance.close();
		//$('#directions').modal('hide');
	}
	
	function saveVideoStartTime() {
		if (cherkPoint) {
			player.playVideo();
			videoStartTime = player.getCurrentTime().toFixed(2);
		}
	}
	function submitDubbing() {
		var fileValue = $("#saveFile").val().split("\\");
		var fileName = fileValue[fileValue.length - 1];
		var fileType = fileName.substring(fileName.length - 3);
		if (!(fileType == 'mp3' || fileType == 'wav')) {
			alert('mp3 또는 wav 타입의 음성파일만 올려주세요!!');
			return;
		}
		var submitForm = document.getElementById('savedubbing');
		submitForm.submit();
	}
</script>
<style>
.scroll-box {
	overflow-y: scroll;
	height: 300px;
	padding: 1rem
}
</style>

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
				  		<div class="header-search-wrapper hide-on-med-and-down" style="display:inline-block; width:200px; margin-left:-5%;">
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
        	<div class="input-field">
          		<input class="search" type="search" style="margin-left: 15%;" required>
          		<label class="label-icon" for="search"><i class="material-icons">search</i></label>
          		<i class="material-icons">close</i>
       		</div>
		</li>		 
		<li><a href="eduBoard">영상게시판</a></li>
		<li><a href="dubbingBoard">더빙게시판</a></li>
		<li><a href="InvestigationBoard">자막게시판</a></li>
		<li><a href="myPage">마이페이지</a></li>
	</ul>

<!-- 첫 설명서 모달 -->
	<div id="directions" class="modal" style="width:50%; ">
		<div class="container">
	    	<div class="modal-content" style="margin-left: -20%; margin-right: -20%;">
		
				<h4>더빙 사용자를 위한 사용 설명서</h4>
				<h6>1. 영상에서 원하는 지점까지 이동하신다음 일시정지하세요.</h6>
				<h6>2. Microphone을 체크하시고 마이크 감도를 조절하세요.</h6>
				<h6>3. RECORD 버튼을 누르고 더빙을 즐겨주세요.</h6>
				<h6>4. STOP 버튼을 누르시면 더빙파일을 감상, 다운받기가 가능합니다.</h6>
				<h6>5. 마음에 드는 파일을 파일명을 변경하지마시고 업로드해주세요.</h6>
				<br/>
				<h4 style="margin-left: 5%;"><a onclick="closeModal()" >OK! Let's Start Dubbing!</a></h4>
			</div>
		</div>
	</div>

	  	  
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
					<a class="waves-effect modal-close modal-trigger" href="#modal3">회원정보수정</a>
				</li>
				<li>
					<a class="waves-effect modal-close modal-trigger" href="#modal2">회원탈퇴</a>
				</li>
			</ul>
		</aside>
		
       <section>
       <div class="row">
			<div class="container" style="width:98%;">
			<h5 class="left">Enjoy~ Dubbing!</h5>
			<div class="row"></div>
				<div class="col s12 m8 l8">
						<div class="video-container z-depth-2">
	<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
	<!--<div id="youtube"></div>   -->
	<iframe id="youtube" width="960" height="490"src="http://www.youtube.com/embed/${edu.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1" frameborder="0" allowfullscreen>
	</iframe>
	         </div>
		  </div>
		</div>
	
		   
   <div class="col s12 m4 l4">
	  <div class="card">
	   <div class="card-content  scroll-box" style="height:450px; width:100%; margin-top:0px;">
              
              <div class="container">
		<div class="form-horizontal">
			<div class="form-group">
				<!-- <div class="col-sm-3"></div> -->
				<div class="col-sm-2">
					<label> <input type="checkbox" class="filled-in" id="microphone" /> <span>Microphone</span>
					</label>
				</div>
				<div class="col-sm-3">
					<input id="microphone-level" type="range" min="0" max="100"
						value="0" class="hidden">
				</div>
			</div>
			<br>
			<div class="form-group">
				<div class="col-sm-3 control-label">
					<span id="recording" class="text-danger hidden"><strong>RECORDING</strong></span>&nbsp;
					<span id="time-display">00:00</span>
				</div>
				<div class="col-sm-3">
					<button id="record" class="btn btn-danger">RECORD</button>
					<button id="cancel" class="btn btn-default hidden">CANCEL</button>
				</div>
				<div class="col-sm-6">
					<span id="date-time" class="text-info"></span>
				</div>
			</div>
		</div>
		<hr>
		<h5>Dubbing LIST</h5>
		<div id="recording-list"></div>
	</div>
              
          
      </div>
	</div>
  </div>
</div>
<!-- 하단 녹음 입력부분 -->
	<div style="margin-top: 2%;">
    <form id="savedubbing" action="savedubbing" method="post" enctype="multipart/form-data">
	  <div class="file-field">
		<div class="btn left" style="margin-left:30px;">
	        <span>File</span>
		    <input type="file" id="saveFile" name="saveFile" >
		</div>
		<div class="file-path-wrapper" style="width: 15%;">
		    <input class="file-path validate" type="text">
		</div>
	 </div>	
	<div class="row">
	 <div class="input-field col s3" style="margin-left:1%;">
	  <input name="title" type="text" class="validate"/>
		<label for="subtitleName">등록 파일명</label>
	 </div>
    </div>	
    <div class="row">
	 <div class="input-field col s4" style="margin-left:1%; margin-top:-20px;">
	  <input name="content" type="text" class="validate"/>
		<label for="subtitleName">간단 코멘트</label>
		 
	 </div>
	 <i class="small material-icons left tooltipped" data-tooltip="등록" onclick="submitDubbing()" style="color: #097cdb">description</i>
    </div>
	
	 <input type="hidden" name="url" value="${edu.url}"> 
	 <input type="hidden" name="useremail" value="${sessionScope.useremail}">
		</form>

	</div>
		   
		   
		</section>
	</div>
	
	
	<script>
		// 2.  Youtube Player IFrame API 코드를 비동기 방식으로 가져온다.
		var tag = document.createElement('script');

		tag.src = "https://www.youtube.com/iframe_api";
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

		// 3. API코등 다운로드 끝나면 <iframe> 태그를 생성하면서 Youtube Player를 만들어준다.
		var player;
		function onYouTubeIframeAPIReady() {
			player = new YT.Player('youtube', {
				//height : '490',
				//width : '960',
				//videoId : '3MteSlpxCpo',
				events : {
					'onStateChange' : onPlayerStateChange
				}
			});
		}
		// 5. Youtube Player의 state가 변하면 적용할 함수
		var playerState;
		function onPlayerStateChange(event) {
			playerState = event.data == YT.PlayerState.ENDED ? '종료됨'
					: event.data == YT.PlayerState.PLAYING ? '재생 중'
							: event.data == YT.PlayerState.PAUSED ? '일시중지 됨'
									: event.data == YT.PlayerState.BUFFERING ? '버퍼링 중'
											: event.data == YT.PlayerState.CUED ? '재생준비 완료됨'
													: event.data == -1 ? '시작되지 않음'
															: '예외';

			console.log('onPlayerStateChange 실행: ' + playerState);
		}
	</script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

	<script>
		Mp3LameEncoderConfig = {
			memoryInitializerPrefixURL : "js/"
		};
	</script>
	<script src="audio/Mp3LameEncoder.min.js"></script>
	<script src="audio/EncoderEasy.js"></script>
	<footer class="page-footer">
    	<div class="container">
        	<div class="row">
              	<div class="col l6 s12">
                	<h5 class="white-text">One jewelry 7th Group</h5>
                	<p class="grey-text text-lighten-4">Enjoy & Try study English</p>
                	<p></p>
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
    <script type="text/javascript" src="js/materialize.js"></script>
</body>
</html>