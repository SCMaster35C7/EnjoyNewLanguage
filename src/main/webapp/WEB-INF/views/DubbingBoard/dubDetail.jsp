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
	
	<title>Insert title here</title>
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		//css
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
			$('#modal2').modal();
			$('#modal3').modal(); //회원정보수정 모달
			
			//side-nav open
			$('.sidenav').sidenav();
			
			//tooltip
			$('.tooltipped').tooltip();
			
			
			$('#loginBtn').on('click',function(){
				var useremail = $('#useremail');
				var userpwd = $('#userpwd');
				
				$('#loginForm').submit();
			});
		});
	
	//주말 
	 	var useremail = "${sessionScope.useremail}";
		var usernick = "${sessionScope.usernick}";
		var dubbingnum = "${dubbing.dubbingnum}"
		
		var soundA=new Audio("getDubbingSoundFile?voiceFile=${dubbing.voiceFile}");
		var saveTime=null;     //자막 싱크용 시간저장변수
	
		$(function() {
			$('#deletedub').on('click',function(){
				$('#deletedubbing').submit();
			})
			
			// 주말
			init();		
			$("#replyInsert").on('click', replyInsert);
			
			$('.recommendation').on('click', function() {
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}
				var target = $(this);
				var recoCount = Number(target.children("span").text());
				var decoTarget = target.parent().children(".decommendation").children("#decoCount");
				var videonum = target.parent().children("input").val();
				var dataForm = {"tableName":"dubbing",
						"idCode":"dubbingnum", 
						"useremail":useremail, 
						"identificationnum":videonum, 
						"recommendtable":"2", 
						"recommendation":"0"
				};
				
				$.ajax({
					method:'post'
					, url:'insertRecommendation'
					, data: JSON.stringify(dataForm)
					, contentType: "application/json; charset=utf-8"
					, async: false
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
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}
				var target = $(this);
				var decoCount = Number(target.children("span").text());
				var recoTarget = target.parent().children(".recommendation").children("#recoCount");
				var videonum = target.parent().children("input").val();
				var dataForm = {
					"tableName":"dubbing", 
					"idCode":"dubbingnum", 
					"useremail":useremail, 
					"identificationnum":videonum, 
					"recommendtable":"2", 
					"recommendation":"1"
				};
				
				$.ajax({
					method:'post'
					, url:'insertRecommendation'
					, data: JSON.stringify(dataForm)
					, contentType: "application/json; charset=utf-8"
					, async: false
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
			
			$("#cancelUpdate").on('click', function() {
				$("#replytext").val('');
				$("#replyInsert").val("댓글등록");
				$("#cancelUpdate").css("visibility", "hidden");
			});
		});
			
		//주말
		function init() {
			 $.ajax({
		            method : 'post',
		            url : 'replyDubAll',
		            data : 'idnum=${dubbing.dubbingnum}',
		            success : output
		    	});
		}
		
		function output(resp) {
			var result = '';
		
			result += '<div class="row">'
			result += '<table cellpadding="5" cellspacing="2" border="1" align="center" word-break:break-all;">';
			result += 	'<thead>';
			result +=		'<tr>';
			result +=			'<th>' + 'usernick' + '</th>';
			result +=			'<th class="replycontent" size="40%;">' + 'content' + '</th>';
			result +=			'<th>' + 'date' + '</th>';
			result +=			'<th colspan="2">' + '수정/취소' + '</th>';
			result +=		'</tr>';
			result += 	'</thead>';
			for (var i in resp) {
				result += 	'<tbody>';
				result +=		'<tr>';
				result +=			'<td>' + resp[i].usernick + '</td>';
				result +=			'<td class="replycontent">' + resp[i].content + '</td>';
				result +=			'<td>' + resp[i].regdate + '</td>';
				result +=			'<td colspan="2">';
				if (useremail==resp[i].useremail) {
					result += '<input class="replyUpdate btn" type="button" data-rno="'+resp[i].replynum+'" value="수정" />';
					result += '<input class="replyDelete btn" type="button" data-rno="'+resp[i].replynum+'" value="삭제" />';
				}
				result += '<img class="report" src="images/warning.jpg" style="margin: 1%;" data-rno="'+resp[i].replynum+'" />';
				result +=			'</td>';
				result +=		'</tr>';
				result += 	'</tbody>';
			}
			result += '</table>';
			result += ' </div>';
			
			$("#result").html(result);
	
			//여기서(output) 나가기 전에 이벤트 걸어야함
			 $("input:button.replyDelete").click(replyDelete);
			 $("input:button.replyUpdate").click(replyUpdate); 
			 $("img.report").click(reportReply); 
		}
		
		function reportReply() {
			//alert('신고');
			var useremail = "${sessionScope.useremail}";
			//alert(useremail);
			replynum = $(this).attr('data-rno');
			//alert(replynum);
			var sendData = {
					"useremail":useremail
					,"whichboard":  "0"
					,"replynum":  replynum
				};
				
			$.ajax({
				type : 'post',
				url : 'insertBlack',
				data : JSON.stringify(sendData),
				dataType:'text',
				contentType: "application/json; charset=UTF-8",
				success : function(resp){
					alert(JSON.stringify(resp));
					init();
				},
				error:function(resp, code, error) {
					//alert("resp : "+resp+", code : "+code+", error : "+error);
					alert("로그인이 필요합니다.");
					location.href="./";
				}
			}); 
		}
		
		function replyInsert() {
			$("#useremail").val(useremail);
			
			var btnname = $("#replyInsert").val();

			if (btnname == '댓글등록') {
				var replytext = $("#replytext").val();

				if (replytext.length == 0) {
					alert("댓글을 작성해주세요!");
					return;
				}
				
				var sendData = {
					"idnum":dubbingnum
					,"useremail":  useremail
					,"content":replytext 
				};
				
				$.ajax({
					type : 'post',
					url : 'replyDubInsert',
					data : JSON.stringify(sendData),
					dataType:'json',
					contentType: "application/json; charset=UTF-8",
					success : init
				});
				 //돌려놓기
				$("#replytext").val('');
			}else if (btnname == '댓글수정') { 	
				//댓글수정이면
				var replytext = $("#replytext").val();
				var replynum = $("#replynum").val();
			 
				//alert(replynum);
		 		var sendData = {
					"replynum" : replynum,
					"content" : replytext
				} 
		
				$.ajax({
					method : 'post',
					url : 'replyDubUpdate',
					data : JSON.stringify(sendData),
					dataType:'json',
					contentType: "application/json; charset=UTF-8",
					success : init
				}); 
		
				$("#replytext").val('');
				$("#replyInsert").val("댓글등록");
				$("#cancelUpdate").css("visibility", "hidden");
			}
		}

		function replyDelete() {
			var nick = $(this).parent().children('.nick').text();
			if ("${usernick}" != nick) {
				alert('회원님이 작성하신 리뷰만 삭제 가능합니다!');
				return;
			}
			replynum = $(this).attr('data-rno');
			$.ajax({
				method : 'get',
				url : 'replyDubDelete',
				data : 'replynum=' + replynum,
				success : init
			});
		}

		function replyUpdate() {
			replynum = $(this).attr('data-rno');

			var nick = $(this).parent().children('.nick').text(); //!!!!!!!this는 수정버튼이니까
			var replytext = $(this).parent().children('.text').text();
			alert(nick);
			if ("${usernick}" != nick) {
				alert('회원님이 작성하신 리뷰만 삭제 가능합니다!');
				return;
			}

			$("#usernick").val(nick);
			$("#replytext").val(replytext);
			$("#replyInsert").val("댓글수정");
			$("#usernick").prop('readonly', 'readonly');
			$("#cancelUpdate").css("visibility", "visible");
			
			$("#replynum").val(replynum);
		}

		function sinkTime(){
			var videoTime=(${dubbing.starttime});
			 player.playVideo();
			 player.seekTo(videoTime, true);
			 var checkpoint=true;
			var audioTime=0;
			var inter=setInterval(function() {
				if(player.getPlayerState()==1&&checkpoint){
					soundA.play();
					checkpoint=false; //위의 if문은 최초재생시 1번만 작동시키면 되므로
				}
				if(player.getCurrentTime().toFixed(2)=='${dubbing.endtime}'){
					player.pauseVideo();
					clearInterval(inter);
				}
				if((player.getCurrentTime()-videoTime)>0.5||(player.getCurrentTime()-videoTime)<-0.5){				
					soundA.currentTime=player.getCurrentTime();
				}
				videoTime=player.getCurrentTime();
			}, 10);
		}
		function goback(){
			history.back();
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
	        		<i class="medium material-icons">person</i>
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
				<li>
					<div class="user-view">
						<div class="background">
							<!--  <img src="images/">  -->
						</div>
							<a href="#user"> <!-- <img class="circle" src="images/"> --></a>
							<a href="#name"><span class="white-text name">${usernick}</span></a> 
							<a href="#email"><span class="white-text email">${useremail}</span></a>
					</div>
				</li>
				<li>
					<a href="#!"><i class="material-icons">cloud</i>FirstLink With Icon</a>
				</li>
				<li>
					<a href="#!">wishList</a>
				</li>
				<li>
					<div class="divider"></div>
				</li>
				<li><a class="subheader">회원정보관리</a></li>
				<li><a class="waves-effect modal-close modal-trigger" href="#modal3">회원정보수정</a></li>
				<li><a class="waves-effect modal-close modal-trigger" href="#modal2">회원탈퇴</a></li>
			</ul>
		</aside>
		
		<div>
			<a onclick="goback()">더빙게시판</a>
		</div>

		<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
		<!--<div id="youtube"></div>   -->
		<section>
			<div class="container">
			<h3 class="center">더빙게시판상세</h3>
				<div class="row col s12">
						<div class="video-container z-depth-2">
							<iframe id="youtube" width="960" height="490"
								src="http://www.youtube.com/embed/${dubbing.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=0&modestbranding=1"
								frameborder="0" allowfullscreen>
							</iframe>
					</div>
				</div>
				<div class="row">
					<div class="col s8">
						<h5 style="display:inline-block;">더빙타임  &nbsp; : &nbsp; ${
						dubbing.starttime} ~ ${dubbing.endtime} &nbsp; <input type="button" class="btn" value="더빙 재생하기" onclick="sinkTime()"></h5>
						<input type="hidden" value="${dubbing.dubbingnum}">
					</div>
					<div class="right" style="margin-right:15px;">
						<p>
						<button class="btn recommendation">
							<i class="material-icons">thumb_up</i>
							<span id="recoCount">${dubbing.recommendation}</span>
						</button>
										
						<button class="btn decommendation">
							<i class="material-icons">thumb_down</i>
							<span id="decoCount">${dubbing.decommendation}</span>
						</button>
						</p>
					</div>
				</div>
				
				<!--댓글 영역-->
				<div> 
					<form id="replyform" class="col s12" method="post" >
						<div class="row">
							<div class="input-field col s12 m2" style="margin-bottom:0px;">
								<input class="center" id="usernick" name="usernick" type="text" value="${sessionScope.usernick}" readonly="readonly"/>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s6">
								<textarea id=replytext name="replytext" class="materialize-textarea" placeholder="리뷰를 작성해주세요 ^ㅅ^"></textarea>
								<input hidden="useremail" id="useremail" name="useremail" value=""/>
								<input hidden="replynum" id="replynum" name="replynum" value=""/>
							</div>
							<div class="input-field col s6">								
								<input id="replyInsert" type="button" class="btn" value="댓글등록" style="margin-top:10px;"/>
								<input id="cancelUpdate" type="button"  style="visibility:hidden;" value="수정취소"/>
							</div>	
						</div>
					</form>
					
					<div id="result"> 
						<!-- 반복적으로 나오게 -->
					</div>
				</div>
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
					'onReady' : onPlayerReady,
					'onStateChange' : onPlayerStateChange
				}
			});
		}
	
		// 4. Youtube Player의 준비가 끝나면 호출할 함수
		function onPlayerReady(event) {
			event.target.playVideo();
		}
		
		// 5. Youtube Player의 state가 변하면 적용할 함수
		var playerState;
        function onPlayerStateChange(event) {
            playerState = 
            	event.data == YT.PlayerState.ENDED ? '종료됨' :
                event.data == YT.PlayerState.PLAYING ? '재생 중' :
                event.data == YT.PlayerState.PAUSED ? '일시중지 됨' :
                event.data == YT.PlayerState.BUFFERING ? '버퍼링 중' :
                event.data == YT.PlayerState.CUED ? '재생준비 완료됨' :
                event.data == -1 ? '시작되지 않음' : '예외';
            
            console.log('onPlayerStateChange 실행: ' + playerState);
        }
	</script>

	<%-- <c:if test="${sessionScope.usernick==resp[i].usernick}">
	
	</c:if> --%>
	
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