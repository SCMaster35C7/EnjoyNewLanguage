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
<title data-langNum2=201>공부게시판 상세</title>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/annyang/2.6.0/annyang.min.js"></script>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="js/LanguageSet.js"></script>
<script>
	//css용
	$(function() {
		SetLanguage();
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
		$('#modal4').modal(); //계정복구 모달
		$('#modal5').modal(); //

		//side-nav open
		$('.sidenav').sidenav();
		
		$('#small-navi').sidenav({
            edge:'right'
         });

		//tooltip
		$('.tooltipped').tooltip();

		//캐러셀
		$('.carousel').carousel();
		
		$('#sticker').on('click', function() {
			$('#checkline').val('');
		});
		
		$('#onoff').change(function(){
			console.log(focusingReady);
			focusings(focusingReady);
			if (focusingReady) {
				focusingReady = false;
				clearInterval(focusings());
			}
		});
		
		$('.TestType').on('click',function(){
			
			if(this.value=='text'){
				$('#level').attr('placeholder','Choice Level 1~5');
				$('#level').attr('max',5);
				$('#level').prop('readonly',null);
			}else{
				$('#level').attr('placeholder','Choice Level 1~4');
				$('#level').attr('max',4);
				$('#level').prop('readonly',null);
			}
		})
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

		var correct = "";
		var quizIndex = "";
		var TestType = false; //문제유형용 변수 false : text, true : mic
		var saveTime = null; //자막 싱크용 시간저장변수
		var TestSuccess = false; //시험을 끝까지 다 마쳤는지 확인
		var TestFinish = false; //음성시험의 경우 채점이 끝났을때 더는 진행이 안되도록 하기 위한 변수
		var focusingReady = false;
	
		//음성인식 서비스 ,textbar: 클릭한 입력창
		function startAnnyang(textbar) {
			annyang.start({
				autoRestart : false,
				continuous : false
			});
			var recognition = annyang.getSpeechRecognizer();
			recognition.onresult = function(event) {
				var resultText = event.results[0][0];
				annyang.abort();
				textbar.value = resultText.transcript; //input에 돌아온 리턴값 입력
				textbar.style.backgroundColor = ""; //문자입력시 배경 없에기
			}
		}
		// 문제 가져오기	
		function getSubList() {
			var level = $('#level').val(); //난이도
			var ChoiceType = document.getElementsByClassName('TestType'); //문제유형
	
			if (ChoiceType[0].checked) {
				if (level<1 ||level>5) {
					alert('The text test mode can be challenging from 1 to 5 level.');
					return;
				}
				TestType = false; //text 모드
			} else {
				if (level<1||level>4) {
					alert('Voice test mode can be challenging from 1 to 4 level.');
					return;
				}
				TestType = true; // mic 모드
			}
			// 스크립트 상위에 선언해둔 TestType 이란 변수를 이용하여 마이크 스크립트를 작동시킬지 체크	
	
			$.ajax({
				method : 'get',
				url : 'getSubtitlesList',
				data : 'level=' + level + "&savedfileName=" + '${edu.savedfile}',
				contentType : 'application/json; charset=UTF-8',
				dataType : 'json',
				success : makeSubList,
				error : function() {
					console.log('error!!');
				}
			})
		}
		//문제 생성 s: ajax로 가져온 SubtitlesList 자료
		function makeSubList(s) {
			correct = s.correct; //정답 배열 스크립트 맨위에 저장(채점시 용도)
			quizIndex = s.quizIndex; //퀴즈 (1차원배열 자료의)의 index 값
			var subtitles = '<div class="row">';
			var readonly = ""; //mic 시험의 경우 text를 입력할 수 없도록 처리
			if (TestType) {
				readonly = 'readonly="readonly"';
			} else {
				readonly = "";
			}
			//음성입력일시 input 창을 readonly로, 텍스트 입력일시 입력가능하게	
			for (var i = 0; i < s.quiz.length; i++) {
				// <a> 태그 : 자막 줄 별 시간정보, 클릭시 해당시간으로 영상 이동
				subtitles += '<div id="T'+s.playtime[i]+'" class="row"><a onclick=' + '"' + 'seekTo(' + s.playtime[i] + ')' + '"' + '>'+ s.playtimeView[i] + '</a>';
				subtitles += ' <div class="col s12">';
				for (var j = 0; j < s.quiz[i].length; j++) {
					if (s.quiz[i][j].indexOf('★') == 0) {
						var longer = s.quiz[i][j].replace("★★", ""); //controller 에서 별처리한 문제 빈칸을 입력칸으로 가공
	
						subtitles += ' <div class="input-field inline" style="margin: 1%;"><input class="answer"'+readonly+' type="text" size='+'"'+longer+'"'+'px style="margin: 1%;"></div>';
					} else {
						subtitles += s.quiz[i][j];
						subtitles += ' ';
					}
				}
				subtitles += '</div></div><br>';
			}
			subtitles += '</div>';
			$('#jamaclist').html(subtitles); //jamaclist div 에 가공이 끝난 문제를 뿌림
			focusingReady = true;
			$('#TestControlForm').show();
			$('#testMakeForm').hide();
			focusings(true);
			//음성 방식 test일시 추가되는 부분
			if (TestType) {
				$('.answer').on('click', function() {
					if (!TestFinish) {
						var textbar = this;
						startAnnyang(textbar);
						textbar.style.backgroundColor = "#d6f4c1";
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
	
		//채점 시스템
		function mark() {
			TestFinish = true;
	
			if ((player.getCurrentTime() / player.getDuration()) < 0.8) {
				alert('Play the video to the end! \nYou need to play the video at least 80 percent for scoring!');
				return null;
			}
			console.log((player.getCurrentTime() / player.getDuration()));
			console.log(TestSuccess);
			var answer = $('.answer'); //class명으로 긁어와서 배열로 생성
			var WronganswerList = []; //오답리스트(오답의 2차원배열값을 저장)
			var CorrectanswerList = []; //정답 리스트(오답의 정답 단어를 저장)
			var correctCount = 0; //맞춘문제 갯수
			var level = $('#level').val();
	
			for (var i = 0; i < correct.length; i++) {
				if(answer[i].value.indexOf("'")!=(-1)){
					if(answer[i].value.length==correct[i].length){
						if(answer[i].value.replace("'","").toLowerCase()==correct[i].replace("'","").toLowerCase()){
							correctCount++;
							answer[i].style.color = "blue";
							answer[i].readOnly = true;
						}else{
						    answer[i].readOnly = true;
							answer[i].style.color = "red";
							answer[i].value = ('R: ' + correct[i] + ", W: " + answer[i].value);
							WronganswerList.push(quizIndex[i]);
							CorrectanswerList.push(correct[i]);
							answer[i].size = (correct[i].length * 4);
							answer[i].readOnly = true;
						}
					}
				}
				else{
				
				if (correct[i].toLowerCase() == answer[i].value.toLowerCase()) {
					correctCount++;
					answer[i].style.color = "blue";
					answer[i].readOnly = true;
				} else {
					answer[i].readOnly = true;
					answer[i].style.color = "red";
					answer[i].value = ('R: ' + correct[i] + ", W: " + answer[i].value);
					WronganswerList.push(quizIndex[i]);
					CorrectanswerList.push(correct[i]);
					answer[i].size = (correct[i].length * 4);
					answer[i].readOnly = true;
				}
			    }
			}
	
			$.ajax({
				method : 'post',
				url : 'ScoreResult',
				data : {
					'testlevel' : level,
					'correctCount' : correctCount,
					'WronganswerList' : WronganswerList,
					'CorrectanswerList' : CorrectanswerList,
					'useremail' : '${sessionScope.useremail}',
					'url' : '${edu.url}',
					'testType' : TestType
				},
				traditional : true,
				success : function(resp) {
					if (resp == "ok") {
						alert('Scoring completed!!\nTest result: Pass \n Total questions: '
						+ correct.length
						+ "\nCorrect count: "
						+ (correct.length - WronganswerList.length)
						+ "\nCorrect rate: "
						+ (((correct.length - WronganswerList.length)) / correct.length)
										.toFixed(3));
					} else {
						alert('Scoring completed!!\nTest result: Fail \n Total questions: '
						+ correct.length
						+ "\nCorrect count: "
						+ (correct.length - WronganswerList.length)
						+ "\nCorrect rate: "
						+ (((correct.length - WronganswerList.length)) / correct.length)
								.toFixed(3));
					}
				},
				error : function() {
					alert('Scoring failed!');
					console.log('error!!');
				}
			});
		}
		
  function deleteEdu(){
	  
	  var eduNum=${edu.videoNum};
	  console.log(eduNum);
	  $.ajax({
		  method:'post'
		 ,url: 'deleteEdu'
		 ,data: 'eduNum='+eduNum
		 ,success:function(){
			 location.href="eduBoard";
		 }
		  
	  })
  }
	</script>
	 <script>
    var koPage={
    		101:'문자입력'	
    	   ,102:'음성입력'
    	   ,201:'공부게시판 상세'
    	  
    }
    var jpPage={
    		101:'文字入力'
    	   ,102:'音声入力' 
    	   ,201:'学習掲示板の詳細'
    }
    
    function languageChange_Page(lang){
		if(lang=='kor'){
			$('[data-langNum2]').each(function() {
			    var $this = $(this); 
			    $this.html(koPage[$this.data('langnum2')]); 
			});
			$('#mq').attr('data-tooltip','문제 생성');
		}else if(lang=='jp'){
			$('[data-langNum2]').each(function() {
			    var $this = $(this); 
			    $this.html(jpPage[$this.data('langnum2')]); 
			});
			$('#mq').attr('data-tooltip','問題生成');
		}
    }
    </script>
</head>
<style>
.scroll-box {
	overflow-y: scroll;
	height: 300px;
	padding: 1rem
}
</style>
<body>
<header>
		<c:if test="${plzLogin!=null}">
			<script type="text/javascript">
				$(function(){
					alert("${plzLogin}");
				});
			</script>
		</c:if>
<!-- Dropdown Structure -->
      <ul id="dropdown1" class="dropdown-content">
        <li><a onclick="languageChange('kor')" style="padding-left:6px; padding-right:6px;"><img src="images/korea.png" hspace="8" style="vertical-align:middle; width:32px; height:32px;"><span style="margin-left:4px;">KOR</span></a></li>
        <li><a onclick="languageChange('jp')" style="padding-left:6px; padding-right:6px;"><img src="images/japan.png" hspace="8" style="vertical-align:middle; width:32px; height:32px;"/><span style="margin-left:4px;">JPN</span></a></li>
      </ul>

		<!-- nav -->
		<nav class="nav-extended">
		  	<div class="nav-wrapper">
			    <!-- sidenav trigger -->
			    <ul class="left">
			    	<li>
			    		<a href="#" data-target="slide-out" class="sidenav-trigger" style="display:inline"><i class="material-icons">menu</i></a>
			    	</li>
			    </ul>
			    <a href="${pageContext.request.contextPath}" class="brand-logo"><img src="images/fulllogo.png" style="margin-top:5px;"></a>
			    <a href="#" data-target="small-navi"  class="sidenav-trigger"><i class="material-icons">menu</i></a>
			    
			    <ul class="right hide-on-med-and-down">
				  	<li>
				  		<div class="header-search-wrapper hide-on-med-and-down" style="display:inline-block; width:200px; margin-left:-5%;">
	                  		<i class="material-icons" style="margin-left:-50px;">search</i>
	                  		<input type="search" name="search" class="header-search-input z-depth-2 search" placeholder="SEARCH WORD"/>
	              		</div>
				  	</li>		 
			      	<li><a href="eduBoard" data-langNum="1"></a></li>
			      	<li><a href="dubbingBoard" data-langNum="2"></a></li>
			      	<li><a href="InvestigationBoard" data-langNum="3"></a></li>
			      	<li><a href="myPage" data-langNum="4"></a></li>
			      	<li><a class="dropdown-trigger" style="margin-right:20px;" href="#!" data-target="dropdown1">Language<i class="material-icons right">language</i></a></li>
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
		<li><a href="eduBoard" data-langNum="1"></a></li>
		<li><a href="dubbingBoard" data-langNum="2"></a></li>
		<li><a href="InvestigationBoard" data-langNum="3"></a></li>
		<li><a href="myPage" data-langNum="4"></a></li>
		<li><div class="divider"></div></li>
        <li><a onclick="languageChange('kor')">KOR</a></li>
        <li><a onclick="languageChange('jp')">JPN</a></li>
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
							<h4 class="center">${sessionScope.useremail} <span data-langNum="5"></span></h4>
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
								<button class="btn waves-effect waves-light modal-close" type="button">BACK
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
								    <li><a class="btn-floating pink modal-close modal-trigger tooltipped" data-position="top" data-tooltip="RESEND CERTIFICATION MAIL" href="#modal5"><i class="material-icons">mail</i></a></li>
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
				<h5 data-langNum="6"></h5>
				<form id="updateMember" action="updateMember" method="post">
					<div class="row" style="margin-top:10%;">
						<div class="col s6">
							<table class="highlight">
								<tr>
									<th>EMAIL</th>
									<td>${sessionScope.useremail}</td>
								</tr>
								<tr>
									<th data-langNum="7"></th>
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
									<th data-langNum="8"></th>
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
	  
	  <!-- 계정복구 모달 -->
	  	<div id="modal4" class="modal">
			<div class="modal-content">
				<div class="container center">
					<h5 data-langNum="16">계정을 복구하시겠습니까?</h5>
					<form id="req" action="recoveryMail" method="post">
						<div class="input-field col s12">
							<i class="material-icons prefix">mail</i>
							<input id="recoveryEmail" type="text" name="recoveryEmail" placeholder="이메일 주소를 입력하세요."/>
						</div>
						<input id="Ecertification" type="button" class="btn" value="이메일인증" onclick="check()">
					</form>
					<!-- 이메일 인증을 하고 인증이 되면 해당 이메일 주소를 recoveryID tag에 넣고 recovery() 메소드 호출-->
				</div>
			</div>
		</div>
	  <!-- 회원탈퇴 모달 -->
	  <div id="modal2" class="modal">
		<div class="modal-content">
			<div class="container center">
				<h5 data-langNum="9"></h5>
				
				<div class="row">
					<form action="insertCloseID" method="post" id="submitform">
						<div class="input-field col s12">
			          		<i class="material-icons prefix">mail</i>
			          		<input id="checkuseremail" name="useremail" type="text" class="validate">
			          		<label for="checkuseremail">USERMAIL</label>
			        	</div>
				        <div class="input-field col s12">
				          <i class="material-icons prefix">mode_edit</i>
				          <input id="pwd" type="password" class="validate">
				          <label for="pwd">PASSWORD</label>
				        </div>
					</form>
				<div class="row">
					<span class="flow-text">
						<button class="btn waves-effect waves-light modal-close" type="button">BACK
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
				<p style="color:red;" data-langNum="10"></p>
				<p style="margin-top:0;" data-langNum="11"></p>
			</div>
	  	</div>
	  </div>
	  
	  <!-- 인증메일 다시보내기 모달 -->
	  <div id="modal5" class="modal">
		<div class="modal-content">
			<div class="container center">
				<h5 data-langNum="15"></h5>
				
				<div class="row">
					<form action="resendEmail" method="post" id="resendForm">
						<div class="input-field col s12">
			          		<i class="material-icons prefix">mail</i>
			          		<input id="resendemail" name="useremail" type="text" class="validate">
			          		<label for="checkuseremail">USERMAIL</label>
			        	</div>
				        <div class="input-field col s12">
				          <i class="material-icons prefix">mode_edit</i>
				          <input id="resendpwd" type="password" class="validate">
				          <label for="pwd">PASSWORD</label>
				        </div>
					</form>
				<div class="row">
					<span class="flow-text">
						<button class="btn waves-effect waves-light modal-close"  type="button">BACK
							<i class="material-icons right">keyboard_return</i>
						</button>
					</span>
					<span class="flow-text">
						<button class="btn" onclick="checkResend()">RESEND
							<i class="material-icons right">mood_bad</i>
						</button>
					</span>	
				</div>	
			</div>
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
		        		<div class="background"><!-- <img src="images/"> --></div>
				        <!-- <a href="#user"><img class="circle" src="images/"></a> -->
				        <a href="#name"><span class="white-text name">${usernick}</span></a> 
				        <a href="#email"><span class="white-text email">${useremail}</span></a>
					</div>
				</li>
				<li>
					<a href="#!" class="sidenav-close">
					<i class="material-icons">cloud</i>First Link With Icon</a>
				</li>
				<li>
					<a href="#!" class="sidenav-close">wishList</a>
				</li>
				<li>
					<div class="divider"></div>
				</li>
				<li>
					<a class="subheader" data-langNum="12"></a>
				</li>
				<li>
					<a class="waves-effect modal-close modal-trigger sidenav-close" href="#modal3" data-langNum="13"></a>
				</li>
				<li>
					<a class="waves-effect modal-close modal-trigger sidenav-close" href="#modal2" data-langNum="14"></a>
				</li>
			</ul>
		</aside>			
	
		<section>	
			<div class="container" style="width:98%;">
				<div style="margin-top: 2%"></div>
					<div class="row">
						<div class="col s12 m8 l8">
						<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
						<!--<div id="youtube"></div>   -->
							<div class="video-container z-depth-2">
								<iframe id="youtube" width="960" height="490"
									src="https://www.youtube.com/embed/${edu.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1"
									frameborder="0" allowfullscreen> </iframe>
							</div>
						</div>
					<div class="col s12 m4 l4">
						<div class="card" style="height:466px;; margin-top: 0px;">
		                     <c:if test="${(not empty sessionScope.admin) and sessionScope.admin == 0}">
		                    <div id="deleteEdu">
		                    <i class="medium material-icons left tooltipped" data-tooltip="Delete Video" style="color: grey" onclick="deleteEdu()">delete</i> 
		                    </div>
		                    </c:if>
		                    
							<div id=TestControlForm class="card-content" style="display: none">
								<span class="card-title activator grey-text text-darken-4">
									<!-- 문제 <i class="material-icons reft tooltipped" data-position="left" data-tooltip="focus on/off" style="color:black" onclick=" focusing()">sync</i> -->
									<i class="material-icons right tooltipped" data-position="left"
									data-tooltip="Mark" style="color: red" onclick="mark()">spellcheck</i>
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
		
				function seekTo(start) {
					player.seekTo(start, true);
				}
			</script>
			<div id="testMakeForm" class="container" style="margin-top: -20%;">
				<div>
					<label> <input type="radio" class="TestType" name="TestType"
						value="text"> <span data-langNum2=101>문자입력</span>
					</label> <label> <input type="radio" class="TestType" name="TestType"
						value="mic"> <span data-langNum2=102>음성입력</span>
					</label>
					
						<div class="input-field inline">
							<input type="number" placeholder="Choice Test Type" id="level"
								size="10px" readonly="readonly">
						</div>
						<i class="material-icons medium tooltipped" style="margin-left:10px; margin-right:30px;" data-position="left"
							data-tooltip="문제 생성" style="color: orange" onclick="getSubList()" id="mq">subtitles</i>
						
					
				</div>
			</div>
		</section>
	</div>
	
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

	<script type="text/javascript" src="js/materialize.min.js"></script>
	<script type="text/javascript" src="js/LoginMenu.js"></script>
</body>
</html>
