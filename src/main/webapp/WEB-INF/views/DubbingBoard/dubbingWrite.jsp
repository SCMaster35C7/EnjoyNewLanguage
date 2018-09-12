<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DJ DJ 더빙 시작</title>
<link type="text/css" rel="stylesheet" href="css/materialize1.css"
	media="screen,projection" />
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script>
	var saveTime = null; //자막 싱크용 시간저장변수
	var videoStartTime = 0; //비디오 시작타임, 파일이름생성에 쓰인다.
	var cherkPoint = true;

	$(function() {
		/* 	var win = window.open('dubbingDirections', '_black',
					"width=500px,height=350px");
			win.focus(); */
		$('#directions').modal();

		$('#record').on('click', function() {
			saveVideoStartTime();
			cherkPoint = (!cherkPoint);
		});
	});
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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
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

	<hr />

	<div>
		<form id="savedubbing" action="savedubbing" method="post"
			enctype="multipart/form-data">
			<input type="file" id="saveFile" name="saveFile"><br> <input
				type="text" name="title" placeholder="더빙제목"><br> <input
				type="text" name="content" placeholder="간단한 코맨트를 남겨주세요."><br>
			<input type="button" onclick="submitDubbing()" value="등록!"> <input
				type="hidden" name="url" value="${edu.url}"> <input
				type="hidden" name="useremail" value="${sessionScope.useremail}">
		</form>

	</div>
	<div class="container">

		<div class="form-horizontal">
			<div class="form-group">
				<div class="col-sm-3"></div>
				<div class="col-sm-2">
					<label> <input type="checkbox" class="filled-in"
						id="microphone" /> <span>Microphone</span>
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
		<h3>Recordings</h3>
		<div id="recording-list"></div>
	</div>

	<div id="directions" class="modal">
		<div class="container">
			<h2>더빙 사용자를 위한 사용 설명서</h2>
			<h4>1. 영상에서 원하는 지점까지 이동하신다음 일시정지하세요.</h4>
			<h4>2. Microphone을 체크하시고 마이크 감도를 조절하세요.</h4>
			<h4>3. RECORD 버튼을 누르고 더빙을 즐겨주세요.</h4>
			<h4>4. STOP 버튼을 누르시면 더빙파일을 감상, 다운받기가 가능합니다.</h4>
			<h4>5. 마음에 드는 파일을 파일명을 변경하지마시고 업로드해주세요.</h4>
		</div>
	</div>

	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

	<script>
		Mp3LameEncoderConfig = {
			memoryInitializerPrefixURL : "js/"
		};
	</script>
	<script src="audio/Mp3LameEncoder.min.js"></script>
	<script src="audio/EncoderEasy.js"></script>
</body>
</html>