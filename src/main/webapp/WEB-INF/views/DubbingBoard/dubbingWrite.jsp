<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DJ DJ 더빙 시작</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<style>
      
      .soundBite input {
        margin-right: 4px;
      }
   </style>
<!-- <script src="js/audiorecord.js"></script> -->
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

<div>
		<p>
			<button id=startRecord>start</button>
			<button id=stopRecord disabled>stop</button>
		</p>	
		<p>
			<audio id=recordedAudio></audio>
			<a id=audioDownload></a>
		</p>
</div>


<!-- 녹음 기능 -->
	<p>
        <button class="btn btn-primary" onclick="startRecording(this);">Record</button>
        <button class="btn btn-warning" onclick="stopRecording(this);" disabled>Stop</button>
    </p>
    <table id="recordingslist">
    	<tr>
        </tr>
    </table>

	<script src="js/lib/recorder.js"></script>
    <script src="js/recordLive.js"></script>
    <script src="js/sequencer.js"></script>
    <script src="js/drone.js"></script>
    
    <script type="text/javascript">
      $(window).load(function()
      {
        $('.editor.container').addClass('invisible');
        onDocumentLoaded();
      });
    </script>
</body>
</html>