<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Enjoy Language</title>
	
	<script
		src="//cdnjs.cloudflare.com/ajax/libs/annyang/2.6.0/annyang.min.js"></script>
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script>
		var correct="";
		var quizIndex="";
		var TestType=false;  	//문제유형용 변수 false : text, true : mic
		var saveTime=null;     	//자막 싱크용 시간저장변수
		var TestSuccess=false;  //시험을 끝까지 다 마쳤는지 확인
		var TestFinish=false;  	//음성시험의 경우 채점이 끝났을때 더는 진행이 안되도록 하기 위한 변수
		
		$(function() {
			$('#playYoutube').on('click', playYoutube);
			$('#pauseYoutube').on('click', pauseYoutube);
			$('#currentTime').on('click', youtubeCurrentTime);
			$('#mute').on('click', mute);
			$('#unMute').on('click', unMute);		
			$('#soundVolum').on('click', soundVolum);
			$('#seekTo').on('click', seekTo);		
		});
		
	    //음성인식 서비스 ,textbar: 클릭한 입력창
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
	    
		// 문제 가져오기	
		function getSubList() {
			var level = $('#level').val(); //난이도
			var ChoiceType = document.getElementsByClassName('TestType'); //문제유형
		
			
			if(ChoiceType[0].checked){
				if(level<1 ||level>5){
					alert('텍스트 테스트 모드는 1~5 Level 까지 도전 가능합니다.');
					return;
				}			
				TestType=false; //text 모드
			}else{
				if(level<1||level>4){
					alert('음성 테스트 모드는 1~4 Level 까지 도전 가능합니다.');
					return;
				}
				TestType=true; // mic 모드
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
			correct=s.correct; //정답 배열 스크립트 맨위에 저장(채점시 용도)
			quizIndex=s.quizIndex; //퀴즈 (1차원배열 자료의)의 index 값
			var subtitles="";
			var readonly="";   //mic 시험의 경우 text를 입력할 수 없도록 처리
			if(TestType){
				readonly = 'readonly="readonly"';
			}else{
				readonly="";
			}
			//음성입력일시 input 창을 readonly로, 텍스트 입력일시 입력가능하게	
			for (var i = 0; i < s.quiz.length; i++) {		
				// <a> 태그 : 자막 줄 별 시간정보, 클릭시 해당시간으로 영상 이동
				 subtitles+='<div id="T'+s.playtime[i]+'"><a onclick='+'"'+'seekTo('+s.playtime[i]+')'+'"'+'>'+s.playtimeView[i]+'</a> ';
				for (var j = 0; j < s.quiz[i].length; j++) {
					if(s.quiz[i][j].indexOf('★')==0){
						var longer=s.quiz[i][j].replace("★★", "");  //controller 에서 별처리한 문제 빈칸을 입력칸으로 가공
						var textlong;
						if(longer>1){
							textlong=longer/2;  
						}else{
							textlong=1;  // 0.5는 불가능하여 오히려 더 큰사이즈가 되므로 최소 1
						}
						subtitles += '<input class="answer"'+readonly+' type="text" size='+'"'+textlong+'"'+'px> ';
					}else{
						subtitles+=s.quiz[i][j];
						subtitles+=' ';
					}
				}
				subtitles+='</div><br>';
			}
			
			$('#jamaclist').html(subtitles); //jamaclist div 에 가공이 끝난 문제를 뿌림
			setInterval(function() {
				//0.01초 단위로 영상 재생시간을 채크하고 이를 소숫점2자리까지 잘라서 자막의 소숫점 2자리까지의 싱크타임과 비교, 맞을 경우 해당 문장의 배경색을 바꿈
				var time='T'+parseFloat(player.getCurrentTime().toFixed(2));
				//console.log(time);
				
				var TimeText=document.getElementById(time);
				if(TimeText!=null){
					if(saveTime!=null){
					    saveTime.style.backgroundColor="";
					}
					TimeText.style.backgroundColor="red";
					saveTime=TimeText;
				}
			},10);
			
			//음성 방식 test일시 추가되는 부분
			if(TestType){
				$('.answer').on('click',function(){		
					if(!TestFinish){
						var textbar=this;
						startAnnyang(textbar);
						textbar.style.backgroundColor="#d6f4c1";
					}
				});
			}
		}
			
		//채점 시스템
		function mark(){
			TestFinish=true;
			
			if((player.getCurrentTime()/player.getDuration())<0.8){
				alert('영상을 끝까지 재생해주세요!! \n영상을 80%이상 재생하셔야 채점이 가능합니다!!');
				return null;
			}
			console.log((player.getCurrentTime()/player.getDuration()));
			console.log(TestSuccess);
			var answer=$('.answer');  //class명으로 긁어와서 배열로 생성
			var WronganswerList=[];   //오답리스트(오답의 2차원배열값을 저장)
			var CorrectanswerList=[]; //정답 리스트(오답의 정답 단어를 저장)
			var correctCount=0;       //맞춘문제 갯수
			var level=$('#level').val();
		
			
			for(var i=0;i<correct.length;i++){
				if(correct[i]==answer[i].value){
					correctCount++;
					answer[i].style.color= "blue";
					answer[i].readOnly=true;				
				}else{
					answer[i].readOnly=true;
					answer[i].style.color= "red";
					answer[i].value=('정답: '+correct[i]+", 오답: "+answer[i].value);
					WronganswerList.push(quizIndex[i]);
					CorrectanswerList.push(correct[i]);
					answer[i].size=(correct[i].length*4);
					answer[i].readOnly=true;
				}
			}
		 	
			$.ajax({
				method : 'post',
				url : 'ScoreResult',
				data : {
					'testlevel':level,
					'correctCount':correctCount,
					'WronganswerList': WronganswerList,
					'CorrectanswerList':CorrectanswerList,
				    'useremail':'${sessionScope.useremail}',
				    'url':'${edu.url}',
				    'testType':TestType
				},
				traditional : true,
				success : function(resp){
					if(resp=="ok"){
					alert('채점완료!!\n시험결과: 합격 \n 총문제수: '+correct.length+"\n정답갯수: "+(correct.length-WronganswerList.length)+"\n정답률: "+(((correct.length-WronganswerList.length))/correct.length).toFixed(3));
					}
					else{
					alert('채점완료!!\n시험결과: 불합격 \n 총문제수: '+correct.length+"\n정답갯수: "+(correct.length-WronganswerList.length)+"\n정답률: "+(((correct.length-WronganswerList.length))/correct.length).toFixed(3));
					}
				},
				error : function() {
					alert('채점에 실패했습니다.');
					console.log('error!!');
				}
			});
		}	
	</script>
</head>

<body>
	<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
	<!--<div id="youtube"></div>   -->
	<iframe id="youtube" width="960" height="490"
		src="http://www.youtube.com/embed/${inv.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=0&modestbranding=1"
frameborder="0" allowfullscreen></iframe>

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
        
        // youtube 기능 함수 나열 =======================================================
        
		function playYoutube() {
            // 플레이어 자동실행 (주의: 모바일에서는 자동실행되지 않음)
            player.playVideo();
            console.log( player.getVideoEmbedCode());
        }
		
        function pauseYoutube() {
        	player.pauseVideo();
        	// player.stopVideo();	완전 멈춰서 처음부터 시작함
        }
        
		function youtubeCurrentTime() {
			console.log('재생률: '+(player.getCurrentTime()/player.getDuration()));	
			// 현재 상영 시간 출력
			// console.log(player.getDuration());	// 총 시간 출력
		}
		
		function mute() {
			player.mute();
		}
		
		function unMute() {
			player.unMute();
		}
		
		function soundVolum() {
			var soundValue = document.getElementById("soundValue");
			
			if(isNaN(soundValue.value) == true) {
				alert("볼륨 값을 입력해주세요.");
				soundValue.focus();
				return;
			}
			player.setVolume(soundValue.value, true);
		}
		
		function seekTo(start) {
			player.seekTo(start, true);
		}
	</script>

	<hr />
	<table border="1">
		<tr>
			<th>동영상 재생/멈춤</th>
			<td><input type="button" id="playYoutube" value="재생"> <input
				type="button" id="pauseYoutube" value="멈춤"></td>
		</tr>
		<tr>
			<th>동영상 현재 시간 출력</th>
			<td><input type="button" id="currentTime" value="영상 시간 출력" /></td>
		</tr>
		<tr>
			<th>동영상 음소거/음소거 제거</th>
			<td><input type="button" id="mute" value="음소거" /> <input
				type="button" id="unMute" value="음소거 제거" /></td>
		</tr>
		<tr>
			<th>동영상 소리 설정</th>
			<td><input type="number" id="soundValue" max="100" min="0" /> <input
				type="button" id="soundVolum" value="소리조절" /></td>
		</tr>
		<tr>
			<th>동영상 재생시간 이동</th>
			<td><input type="text" id="start" /> <input type="button"
				id="seekTo" value="영상이동" /></td>
		</tr>
	</table>

	<div>
		<input type="radio" class="TestType" name="TestType" value="text">
		문자입력 <input type="radio" class="TestType" name="TestType" value="mic">
		음성입력 <input type="number" placeholder="난이도를 1~5 입력해주세요." id="level">
		<input type="button" onclick="getSubList()" value="문제생성"> <input
			type="button" onclick="mark()" value="채점하기">
	</div>
	
	<div id="subtitle">
	
	</div>
	
	<div id="reply">
		<h2>댓글 달아주세요</h2>
		<input type="text" id="replyContent"/>
		<input type="button" id="inputReply" value="댓글입력">
	</div>
</body>
</html>