<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		//주말 
	 	var useremail = "${sessionScope.useremail}";
		var usernick = "${sessionScope.usernick}";
		var dubbingnum = "${dubbing.dubbingnum}"
		
		//var soundA=new Audio("getDubbingSoundFile?voiceFile=${dubbing.voiceFile}");
		var saveTime=null;     //자막 싱크용 시간저장변수
	
		$(function() {
			// 주말
			init();
				
			$('#playYoutube').on('click', playYoutube);
			$('#pauseYoutube').on('click', pauseYoutube);
			$('#currentTime').on('click', youtubeCurrentTime);
			$('#mute').on('click', mute);
			$('#unMute').on('click', unMute);		
			$('#soundVolum').on('click', soundVolum);
			$('#seekTo').on('click', seekTo);		
			
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
			//alert(JSON.stringify(resp));
			var result = '';
		
			for ( var i in resp) {
				result += '<div class="content">'
				result += ' <p class="email" >' + resp[i].useremail + '</p> ';
				result += ' <p class="nick" >' + resp[i].usernick + '</p> ';
				result += ' <p class="text" >' + resp[i].content + '</p>';
				result += '<p class="date" >' + resp[i].regdate + '</p>';
				result += '<p class="blackcount" >' + resp[i].blackcount + '</p>';
				if (usernick==resp[i].usernick) {
					result += '<input class="replyUpdate" type="button" data-rno="'+resp[i].replynum+'" value="수정" />';
					result += '<input class="replyDelete" type="button" data-rno="'+resp[i].replynum+'" value="삭제" />';
				}
				result += '<img class="report" src="images/절미2.jpg"  data-rno="'+resp[i].replynum+'" />';
				result += ' </div>';
			}
			
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
						alert("resp : "+resp+", code : "+code+", error : "+error);
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
					"dubbingnum":dubbingnum
					,"useremail":  useremail
					,"content":replytext 
				};
				
				$.ajax({
					type : 'post',
					url : 'replyInsert',
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
					"content" : replytext,
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
				$("#replyInsert").val("리뷰등록");
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
		
		// 자막가져오기
		function getSubList() {		
			$.ajax({
				method : 'get',
				url : 'getSubtitles',
				data : "savedfileName=" + '${savedfileName}',
				contentType : 'application/json; charset=UTF-8',
				dataType : 'json',
				success : makeSubList,
				error : function() {
					console.log('error!!');
				}
			});
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
		
		function sinkTime(){
			var videoTime=(${dubbing.starttime}-1);	
			 player.playVideo();
			 player.seekTo(videoTime, true);
			//잠시만 주석 soundA.play();
			//var audioTime=0;
			setInterval(function() {
				if(player.getCurrentTime().toFixed(2)=='${dubbing.endtime}'){
					player.pauseVideo();
				}
				
				//console.log(player.getCurrentTime()+" , "+soundA.currentTime);
				if((player.getCurrentTime()-videoTime)>0.5||(player.getCurrentTime()-videoTime)<-0.5){				
					//soundA.currentTime=player.getCurrentTime();
				}
				videoTime=player.getCurrentTime();
			}, 10);
		}
	</script>
</head>
<body>
	<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
	<!--<div id="youtube"></div>   -->
	<iframe id="youtube" width="960" height="490"
		src="http://www.youtube.com/embed/${dubbing.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=0&modestbranding=1"
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
            sinkTime();
            //soundA.play();
            console.log( player.getVideoEmbedCode());
        }
		
        function pauseYoutube() {
        	player.pauseVideo();
        	//잠시만 soundA.pause();
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
		
		function seekTo() {
			var start=$('#start').val();
			console.log(start);
			//soundA.pause();
			//soundA.currentTime=(start-1.5);
			player.seekTo(start, true);
			//soundA.play();
		}
	</script>

	<hr />
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
				<input type="button" id="currentTime" value="영상 시간 출력" />
			</td>
		</tr>
		<tr>
			<th>동영상 음소거/음소거 제거</th>
			<td>
				<input type="button" id="mute" value="음소거" />
				<input type="button" id="unMute" value="음소거 제거" />
			</td>
		</tr>
		<tr>
			<th>동영상 소리 설정</th>
			<td>
				<input type="number" id="soundValue" max="100" min="0" /> 
				<input type="button" id="soundVolum" value="소리조절" />
			</td>
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
	
	<div>
		<input type="button" value="더빙 구경하기!" onclick="sinkTime()"> 
	</div>

	<div id="textbox"></div>
	
	<div class="card-footer" align="center">
		<input type="hidden" value="${dubbing.dubbingnum}">
		<button class="btn recommendation">
			<img alt="" src="images/tup.png">
			<span id="recoCount">${dubbing.recommendation}</span>
		</button>
						
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button class="btn decommendation">
			<img alt="" src="images/tdown.png">
			<span id="decoCount">${dubbing.decommendation}</span>
		</button>
	</div>
	
	<%-- <c:if test="${sessionScope.usernick==resp[i].usernick}">
	
	</c:if> --%>
	
	
	<hr/>
	<!--주말 댓글-->
	<div> 
		<form id="replyform"  method="post" >
			<input id="usernick" name="usernick" type="text" value="${sessionScope.usernick}" readonly="readonly"/>
			<input id=replytext name="replytext" type="text" placeholder="리뷰를 작성해주세요 ^ㅅ^"/>
		
			<input hidden="useremail" id="useremail" name="useremail" value=""/>
			<input hidden="replynum" id="replynum" name="replynum" value=""/>
			
			<input id="replyInsert" type="button" value="댓글등록"/>
			<input id="cancelUpdate" type="button"  style="visibility:hidden;" value="수정취소"/>
		</form>
		
		
		
		<hr/>
		<div id="result"> 
			<!-- 반복적으로 나오게 -->
		</div>
	</div>
</body>
</html>