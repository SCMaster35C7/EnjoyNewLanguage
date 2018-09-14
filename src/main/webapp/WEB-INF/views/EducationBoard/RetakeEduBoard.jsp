<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="zisung">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="css/materialize1.css"
	media="screen,projection" />
<title>Enjoy Language</title>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/annyang/2.6.0/annyang.min.js"></script>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script>
	
	var correct="";
	var quizIndex="";
	var TestType=false;  //문제유형용 변수 false : text, true : mic
	var saveTime=null;     //자막 싱크용 시간저장변수
	var TestSuccess=false;  //시험을 끝까지 다 마쳤는지 확인
	var TestFinish=false;  //음성시험의 경우 채점이 끝났을때 더는 진행이 안되도록 하기 위한 변수
	var focusingReady = false;
	
		$(function() {
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
			
			$('#onoff').change(function(){
				console.log(focusingReady);
				focusings(focusingReady);
				if (focusingReady) {
					focusingReady = false;
					clearInterval(focusings());
				}
			});
		});
		
		function startAnnyang(textbar) {
			annyang.start({autoRestart: false,continuous: false});
			var recognition = annyang.getSpeechRecognizer();
			recognition.onresult=function(event){
				var resultText=event.results[0][0];
				annyang.abort();
				textbar.value=resultText.transcript; //input에 돌아온 리턴값 입력
				textbar.style.backgroundColor="";   //문자입력시 배경 없에기
			}
		}
		//재시험 문제 가져오기	
		function getRetakeTest() {
			var jamacURL = '${jamacURL}';   //자막주소
			var ChoiceType = document.getElementsByClassName('TestType'); //문제유형
			if(ChoiceType[0].checked){
				TestType=false; //text 모드
			}else{
				TestType=true; // mic 모드
			}
			// 스크립트 상위에 선언해둔 TestType 이란 변수를 이용하여 마이크 스크립트를 작동시킬지 체크	
			
			$.ajax({
				method : 'get',
				url : 'MakeRetakeTest',
				data :"savedfileName=" + '${edu.savedfile}'+"&testType="+TestType+"&url="+'${edu.url}',
				contentType : 'application/json; charset=UTF-8',
				dataType : 'json',
				success : makeSubList,
				error : function() {
					alert('해당 유형으로 시험을 시행한 적이 없습니다.');
					console.log('error!!');
				}

			})
		}
		
		function makeSubList(s) {
			correct=s.correct; //정답 배열 스크립트 맨위에 저장(채점시 용도)
			quizIndex=s.quizIndex;
			var subtitles='<div class="row">';
			var readonly="";
			if(TestType){
				readonly = 'readonly="readonly"';
			}else{
				readonly="";
			}
			//음성입력일시 input 창을 readonly로, 텍스트 입력일시 입력가능하게	
			for (var i = 0; i < s.quiz.length; i++) {		
				// <a> 태그 : 자막 줄 별 시간정보, 클릭시 해당시간으로 영상 이동
				 subtitles+='<div id="T'+s.playtime[i]+'" class="row"><a onclick='+'"'+'seekTo('+s.playtime[i]+')'+'"'+'>'+s.playtimeView[i]+'</a> ';
				 subtitles += ' <div class="col s12">';
				 for (var j = 0; j < s.quiz[i].length; j++) {
					if(s.quiz[i][j].indexOf('★')==0){
						var longer=s.quiz[i][j].replace("★★", "");
	
						subtitles += '<div class="input-field inline" style="margin: 1%;"><input class="answer"'+readonly+' type="text" size='+'"'+longer+'"'+'px style="margin: 1%;"></div>';
					}else{
						subtitles+=s.quiz[i][j];
						subtitles+=' ';
					}
				}
				subtitles+='</div></div><br>';
			}
			subtitles += '</div>';
			$('#jamaclist').html(subtitles);
			focusingReady = true;
			$('#TestControlForm').show();
			$('#testMakeForm').hide();
			focusings(true);
		
			
			//음성 방식 test일시 추가되는 부분
			if(TestType){
			$('.answer').on('click',function(){		
				if(!TestFinish){
				var textbar=this;
				startAnnyang(textbar);
				textbar.style.backgroundColor="#d6f4c1";
				}
			})
			}
		}
		
		  //자막에 포커싱 걸기
		function focusings(bool) {
			focusingReady = (!focusingReady);
			if (bool) {
				timer = setInterval(
						function focusings() {
							//0.01초 단위로 영상 재생시간을 채크하고 이를 소숫점2자리까지 잘라서 자막의 소숫점 2자리까지의 싱크타임과 비교, 맞을 경우 해당 문장의 배경색을 바꿈
							var time = 'T'
									+ parseFloat(player.getCurrentTime().toFixed(2));
							var TimeText = document.getElementById(time);
							if (TimeText != null) {
								if (saveTime != null) {
									saveTime.style.backgroundColor = "";
								}
								TimeText.style.backgroundColor = "#8dabfe";
								TimeText.tabIndex = -1;
								TimeText.focus();
								saveTime = TimeText;
							}
						}, 10);
			} else {
				clearInterval(timer);
			}
		}
		
		function mark(){
			TestFinish=true;
			
			if((player.getCurrentTime()/player.getDuration())<0.8){
				alert('영상을 끝까지 재생해주세요!! \n영상을 80%이상 재생하셔야 채점이 가능합니다!!');
				return null;
			}
			console.log((player.getCurrentTime()/player.getDuration()));
			console.log(TestSuccess);
			var answer=$('.answer');
			var CorrectanswerList=[];
			var WronganswerCount=0;

			var level=$('#level').val();
		
		console.log(correct.length);
		console.log(answer.length);
			for(var i=0;i<correct.length;i++){
				if(correct[i]==answer[i].value){
					CorrectanswerList.push(quizIndex[i]);
					answer[i].style.color= "blue";
					answer[i].readOnly=true;				
				}else{
					answer[i].readOnly=true;
					answer[i].style.color= "red";
					answer[i].value=('정답: '+correct[i]+", 오답: "+answer[i].value);
					WronganswerCount++;
					answer[i].size=(correct[i].length*4);
					answer[i].readOnly=true;
				}
			}
			console.log(CorrectanswerList);
			//재시험결과 ajax로 전송, 맞은 문제의 경우 오답리스트에서 삭제
			$.ajax({
				method : 'post',
				url : 'RetakeResult',
				data : {
					    'WronganswerCount': WronganswerCount,
					    'CorrectanswerList':CorrectanswerList,
				        'url':'${edu.url}',
				        'useremail':'${sessionScope.useremail}',
				        'testType':TestType
				},
				 traditional : true,
				success : function(resp){
					if(resp=="ok"){
					alert('채점완료!!\n시험결과: 합격 \n 총문제수: '+correct.length+"\n정답갯수: "+(correct.length-WronganswerCount)+"\n정답률: "+(((correct.length-WronganswerCount))/correct.length).toFixed(3));
					}
					else{
					alert('채점완료!!\n시험결과: 불합격 \n 총문제수: '+correct.length+"\n정답갯수: "+(correct.length-WronganswerCount)+"\n정답률: "+(((correct.length-WronganswerCount))/correct.length).toFixed(3));
					}
				},
				error : function() {
					alert('채점에 실패했습니다.');
					console.log('error!!');
				}
				
			})
		}
		
		function goback() {
			history.back();
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
		<!-- Dropdown Structure -->
		<ul id="dropdown1" class="dropdown-content">
			<li><a href="myPage">마이페이지</a></li>
			<li><a href="TryRetake?videoNum=9">재시험테스트</a> <c:if
					test="${plzLogin!=null}">
					<script type="text/javascript">
						$(function() {
							alert("${plzLogin}");
						});
					</script>
				</c:if></li>
			<li class="divider"></li>
			<li><a href="searchTest">Youtube Search테스트</a></li>
		</ul>

		<!-- nav -->
		<nav class="nav-extended">
			<div class="nav-wrapper">
				<a href="${pageContext.request.contextPath}" class="brand-logo">Logo</a>
				<a href="#" data-target="small-navi" class="sidenav-trigger"><i
					class="material-icons">menu</i></a>
				<ul class="right hide-on-med-and-down">
					<c:if test="${not empty sessionScope.useremail }">
						<li><a href="logout">${sessionScope.useremail }Logout</a></li>
					</c:if>
					<li><a href="eduBoard">영상게시판</a></li>
					<li><a href="dubbingBoard">더빙게시판</a></li>
					<li><a href="InvestigationBoard">자막검증게시판</a></li>
					<!-- Dropdown Trigger -->
					<li><a class="dropdown-trigger" href="#"
						data-target="dropdown1">Dropdown<i
							class="material-icons right">arrow_drop_down</i></a></li>
				</ul>
			</div>


			<div class="nav-content">
				<a
					class="btn-floating btn-large halfway-fab pulse modal-trigger tooltipped"
					data-position="left" data-tooltip="LOGIN!" href="#modal1"> <i
					class="medium material-icons">person</i>
				</a>
			</div>
		</nav>
	</header>
	<!-- 축소시 사이드 nav -->
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
							<c:if test="${empty sessionScope.useremail }">
								<div class="input-field col s12">
									<i class="material-icons prefix">mail</i> <input id="useremail"
										type="text" class="validate" name="useremail"
										value="${useremail}"> <label for="useremail">EMAIL</label>
								</div>
							</c:if>
						</div>

						<div class="row">
							<c:if test="${empty sessionScope.useremail }">
								<div class="input-field col s12">
									<i class="material-icons prefix">mode_edit</i> <input
										id="userpwd" type="password" class="validate" name="userpwd"
										value="${userpwd}"> <label for="userpwd">PASSWORD</label>
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
								<button class="btn waves-effect waves-light" type="button"
									id="loginBtn">
									ENTER <i class="material-icons right">send</i>
								</button>
							</span> <span class="flow-text">
								<button class="btn waves-effect waves-light modal-close"
									id="back" type="button">
									BACK <i class="material-icons right">keyboard_return</i>
								</button>
							</span>
							<c:if test="${not empty sessionScope.useremail }">
								<span class="flow-text"> <a href="logout"
									class="btn waves-effect waves-light modal-close">LOGOUT <i
										class="material-icons right">power_settings_new</i>
								</a>
								</span>
							</c:if>
						</div>

						<div class="fixed-action-btn">
							<a
								class="btn-floating btn-large red waves-effect waves-light tooltipped"
								data-position="left" data-tooltip="ACCOUNT?"> <i
								class="large material-icons">person</i>
							</a>
							<ul>
								<li><a href="joinForm" class="btn-floating blue tooltipped"
									data-position="top" data-tooltip="JOIN US!"><i
										class="material-icons">person_add</i></a></li>
								<li><a class="btn-floating green tooltipped"
									data-position="top" data-tooltip="ACCOUNT RECOVERY"><i
										class="material-icons">sync</i></a></li>
								<li><a class="btn-floating yellow darken-1 tooltipped"
									data-position="top" data-tooltip="QUIT US"><i
										class="material-icons">clear</i></a></li>
							</ul>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="container" style="width:98%;">
		 <i class="material-icons" onclick="goback()" style="size: 100px;">storage</i>
		<div class="row">
			<div class="col s4 m8">
	<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
	<!--<div id="youtube"></div>   -->
	<div class="video-container z-depth-2">
	<iframe id="youtube" width="960" height="490"
		src="http://www.youtube.com/embed/${edu.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1"
		frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
    <div class="col s4 m4">
				<div class="card" style="height: 450px; margin-top: 0px;">

					<div id=TestControlForm class="card-content" style="display: none">

						<span class="card-title activator grey-text text-darken-4">
							<!-- 문제 <i class="material-icons reft tooltipped" data-position="left" data-tooltip="focus on/off" style="color:black" onclick=" focusing()">sync</i> -->
							<i class="material-icons right tooltipped" data-position="left"
							data-tooltip="채점" style="color: red" onclick="mark()">spellcheck</i>
						</span>
						<div class="switch">
							<h5>Focus</h5> <label> Off <input id="onoff"type="checkbox" checked="checked"> <span
								class="lever"></span> On
							</label>
						</div>
					</div>
					<div class="card-content scroll-box">
						<p id="jamaclist"></p>

					</div>

				</div>
			</div>
		</div>
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
            playerState = event.data == YT.PlayerState.ENDED ? '종료됨' :
                    event.data == YT.PlayerState.PLAYING ? '재생 중' :
                    event.data == YT.PlayerState.PAUSED ? '일시중지 됨' :
                    event.data == YT.PlayerState.BUFFERING ? '버퍼링 중' :
                    event.data == YT.PlayerState.CUED ? '재생준비 완료됨' :
                    event.data == -1 ? '시작되지 않음' : '예외';
            
            console.log('onPlayerStateChange 실행: ' + playerState);
        }
        		
		function seekTo(start) {
			player.seekTo(start, true);
		}
	</script>
<div id="testMakeForm" class="container">
			<label> 
				<input type="radio" class="TestType" name="TestType"
						value="text"> <span>문자입력</span>
			</label> 
			<label> 
			<input type="radio" class="TestType" name="TestType"
						value="mic"> <span>음성입력</span>
			</label>
		
				<i class="material-icons medium tooltipped" style="margin-left:10px; margin-right:30px;" data-position="left"
					data-tooltip="문제 생성" style="color: orange" onclick="getRetakeTest()">subtitles</i>
</div>
	

	<!-- <div id="jamaclist"></div> -->
<footer class="page-footer">
		<div class="container">
			<div class="row">
				<div class="col l6 s12">
					<h5 class="white-text">Footer Content</h5>
					<p class="grey-text text-lighten-4">You can use rows and
						columns here to organize your footer content.</p>
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
				© 2014 Copyright Text <a class="grey-text text-lighten-4 right"
					href="#!">More Links</a>
			</div>
		</div>
	</footer>

	<script type="text/javascript" src="js/materialize.min.js"></script>

</body>
</html>
