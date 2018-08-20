<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Enjoy Language</title>
	
	<script type="text/javascript" src="scripts/jquery-3.3.1.min.js"></script>
	<script>
		$(function() {		

			$('#mute').on('click', mute);
			$('#unMute').on('click', unMute);
	
			$('#soundVolum').on('click', soundVolum);
			$('#seekTo').on('click', seekTo);
		});
		
		
		function getSubList() {
			var level = $('#level').val();
			var jamacURL = '${jamacURL}';

			$.ajax({
				method : 'get',
				url : 'getSubtitlesList',
				data : 'level=' + level + "&jamacURL=" + 't',
				contentType : 'application/json; charset=UTF-8',
				dataType : 'json',
				success : makeSubList,
				error : function() {
					console.log('error!!');
				}

			})

		}
		
		
		
		
		function makeSubList(s) {
			var subtitles="";
			
			for (var i = 0; i < s.quiz.length; i++) {
				
				//<a class="gotime"></a>
				 subtitles+='<a onclick='+'"'+'seekTo('+s.playtime[i]+')'+'"'+'>';
				for (var j = 0; j < s.quiz[i].length; j++) {
					if(s.quiz[i][j].indexOf('★')==0){
						var longer=s.quiz[i][j].replace("★★", "");
						var textlong;
						if(longer>1){
							textlong=longer/2;
						}else{
							textlong=1;
						}
						subtitles += '<input type="text" size='+'"'+textlong+'"'+'px> ';
					}else{
						subtitles+=s.quiz[i][j];
						subtitles+=' ';
					}
				}
				subtitles+='</a><br>';
			}
			$('#jamaclist').html(subtitles);
			

		}
	</script>
</head>

<body>
	<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->

	<!--<div id="youtube"></div>   -->
	<iframe id="youtube" width="960" height="490" src="http://www.youtube.com/embed/${edu.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=0&modestbranding=1" frameborder="0" allowfullscreen ></iframe>


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
				// height : '490',
				// width : '960',
				// videoId : '3MteSlpxCpo',
				events : {
					'onReady' : onPlayerReady,
					//'onStateChange' : onPlayerStateChange
				}
			});
		}
		
		// 4. Youtube Player의 준비가 끝나면 호출할 함수
		function onPlayerReady(event) {
			event.target.playVideo();
			/*
		     player.loadVideoById({'videoId': '3MteSlpxCpo',
	               'startSeconds': 60,
	               'endSeconds': 65,
	               'suggestedQuality': 'large'});
			*/
		     //player.playVideo();
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
			//var youtube = $('#youtube');
			console.log(player.getCurrentTime());	// 현재 상영 시간 출력
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
			//var start = document.getElementById("start");
			/*
			if(isNaN(start.value) == true) {
				alert("초를 입력해주세요.");
				start.focus();
				return;
			}
			*/
			console.log(start);
			//player.seekTo(start.value, true);
		}
	</script>
	
	<hr />
	<!-- 재생속도 조절 -->
	<table border="1">

		<tr>
			<th>동영상 재생/멈춤</th>
			<td>
				<input type="button" id="playYoutube" value="재생">
				<input type="button" id="pauseYoutube" value="멈춤">
			</td>
		</tr>
		<tr>
			<th>동영상 현재 시간 출력</th>
			<td>
				<input type="button" id="currentTime" value="영상 시간 출력"/>
			</td>
		</tr>
		<tr>
			<th>동영상 음소거/음소거 제거</th>
			<td>
				<input type="button" id="mute" value="음소거"/>
				<input type="button" id="unMute" value="음소거 제거"/>
			</td>
		</tr>
		<tr>
			<th>동영상 소리 설정</th>
			<td>
				<input type="number" id="soundValue" max="100" min="0"/>
				<input type="button" id="soundVolum" value="소리조절"/>
			</td>
		</tr>
		<!-- 
		<tr>
			<th>동영상 재생시간 이동</th>
			<td>
				<input type="text" id="start"/>
				<input type="button" id="seekTo" value="영상이동"/>
			</td>
		</tr>
		 -->
	</table>
	
	<div id="jamaclist">
	
	
	</div>
	
</body>
</html>
