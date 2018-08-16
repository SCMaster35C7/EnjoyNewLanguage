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
			
		});
	</script>
</head>

<body>
	<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
	<iframe id="youtube" width="960" height="490" src="${edu.url}" frameborder="0" allowfullscreen></iframe>

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
	</script>
	
	<hr />
	<!-- 재생속도 조절 -->
	<table border="1">
		
	</table>
</body>
</html>
