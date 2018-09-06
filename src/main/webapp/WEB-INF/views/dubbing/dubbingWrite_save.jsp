<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DJ DJ 더빙 시작</title>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script>
	var saveTime=null;     //자막 싱크용 시간저장변수
		
		$(function() {
			$('#playYoutube').on('click', playYoutube);
			$('#pauseYoutube').on('click', pauseYoutube);
			$('#currentTime').on('click', youtubeCurrentTime);
			$('#mute').on('click', mute);
			$('#unMute').on('click', unMute);		
			$('#soundVolum').on('click', soundVolum);
			$('#seekTo').on('click', seekTo);		
		});
	  
		// 자막가져오기
		function getSubList() {		
			$.ajax({
				method : 'get',
				url : 'getSubtitles',
				data : "savedfileName=" + '${edu.savedfile}',
				contentType : 'application/json; charset=UTF-8',
				dataType : 'json',
				success : makeSubList,
				error : function() {
					console.log('error!!');
				}

			})
		}
		
		function makeSubList(s) {
			console.log(s); 
			var subtitles="";
			setInterval(function() {
				//0.01초 단위로 영상 재생시간을 채크하고 이를 소숫점2자리까지 잘라서 자막의 소숫점 2자리까지의 싱크타임과 비교, 맞을 경우 해당 문장의 배경색을 바꿈
			var time=player.getCurrentTime().toFixed(2);
			//console.log(time);
			var text=s[time];
			console.log(text);
			if(text!=null){
			$('#textbox').html(text);	
			}
			},10);
			
		}
		
		
	
		
	</script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>

<body>
	<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
	<!--<div id="youtube"></div>   -->
	<iframe id="youtube" width="960" height="490"
		src="http://www.youtube.com/embed/${edu.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=0&modestbranding=1"
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
			//console.log('재생률: '+(player.getCurrentTime()/player.getDuration()));	// 현재 상영 시간 출력
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
		<input type="button" onclick="getSubList()" value="자막보기">

	</div>


	<div id="textbox"></div>
	<div>
	<form id="savedubbing" action="savedubbing" method="post" enctype="multipart/form-data">
	<input type="file" name="saveFile"><br>
	<input type="text" name="title" placeholder="더빙제목"><br>
	<input type="text" name="content" placeholder="간단한 코맨트를 남겨주세요."><br>
	<input type="submit" value="등록!">
	<input type="hidden" name="url" value="${edu.url}">
	<input type="hidden" name="useremail" value="${sessionScope.useremail}">
	
	</form>
	
	</div>
	<div class="container">
      <h1><a href="https://github.com/higuma/mp3-lame-encoder-js">Mp3LameEncoder.js</a> demo</h1>
      <p>Audio recording to MPEG-1 Audio Layer III (.mp3) test with Web Audio API</p>
      <hr>
      <div class="form-horizontal">
        <div class="form-group">
          <label class="col-sm-3 control-label">Audio input</label>
          <div class="col-sm-2">Test tone</div>
          <div class="col-sm-3">
            <input id="test-tone-level" type="range" min="0" max="100" value="0">
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-3"></div>
          <div class="col-sm-2">
            <input id="microphone" type="checkbox"> Microphone
          </div>
          <div class="col-sm-3">
            <input id="microphone-level" type="range" min="0" max="100" value="0" class="hidden">
          </div>
        </div><br>
        <div class="form-group">
          <label class="col-sm-3 control-label">Encoding process</label>
          <div class="col-sm-9">
            <input type="radio" name="encoding-process" mode="separate" checked> Encode with worker after recording (safer)
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-3"></div>
          <div class="col-sm-9">
            <input type="radio" name="encoding-process" mode="background"> Encode with worker on recording background (intermediate)
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-3"></div>
          <div class="col-sm-9">
            <input type="radio" name="encoding-process" mode="direct"> Encode on recoring directly without worker (risky)
          </div>
        </div><br>
        <div class="form-group">
          <label class="col-sm-3 control-label">Recording buffer size</label>
          <div class="col-sm-2">
            <input id="buffer-size" type="range" min="0" max="6">
          </div>
          <div id="buffer-size-text" class="col-sm-7"></div>
        </div>
        <div class="form-group">
          <div class="col-sm-3"></div>
          <div class="col-sm-9 text-warning"><strong>Warning: </strong><span>setting size below browser default may fail recording.</span></div>
        </div><br>
        <div class="form-group">
          <label class="col-sm-3 control-label">MP3 bit rate</label>
          <div class="col-sm-2">
            <input id="bit-rate" type="range" min="0" max="9" value="5">
          </div>
          <div id="bit-rate-text" class="col-sm-7">160kbps</div>
        </div><br>
        <div class="form-group">
          <div class="col-sm-3 control-label"><span id="recording" class="text-danger hidden"><strong>RECORDING</strong></span>&nbsp; <span id="time-display">00:00</span></div>
          <div class="col-sm-3">
            <button id="record" class="btn btn-danger">RECORD</button>
            <button id="cancel" class="btn btn-default hidden">CANCEL</button>
          </div>
          <div class="col-sm-6"><span id="date-time" class="text-info"></span></div>
        </div>
      </div>
      <hr>
      <h3>Recordings</h3>
      <div id="recording-list"></div>
    </div>
  
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script>Mp3LameEncoderConfig = { memoryInitializerPrefixURL: "js/" };</script>
    <script src="js/Mp3LameEncoder.min.js"></script>
    <script src="js/EncoderDemo.js"></script>


</body>
</html>