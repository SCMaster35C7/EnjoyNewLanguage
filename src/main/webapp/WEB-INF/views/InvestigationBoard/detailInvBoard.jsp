<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		var useremail = "${sessionScope.useremail}";
		var usernick = "${sessionScope.usernick}";
		var investigationnum = "${inv.investigationnum}"
          
	    $(function() {
	    	init();
	         
	        $("#replyInsert").on('click', replyInsert);
	        $('#playYoutube').on('click', playYoutube);
	        $('#pauseYoutube').on('click', pauseYoutube);
	        $('#currentTime').on('click', youtubeCurrentTime);
	        $('#mute').on('click', mute);
	        $('#unMute').on('click', unMute);      
	        $('#soundVolum').on('click', soundVolum);
	        $('#seekTo').on('click', seekTo);      
	        
	        $('.recommendation').on('click', function() {
	           	if(useremail.trim().length == 0) {
	            	location.href="login";
	            	return;
	           	}
	           	var target = $(this);
	           	var recoCount = Number(target.children("span").text());
	           	var decoTarget = target.parent().children(".decommendation").children("#decoCount");
	           	var videonum = target.parent().children("input").val();
	           	var dataForm = {
	           		"tableName":"investigation",
	                "idCode":"investigationnum", 
	                "useremail":useremail, 
	                "identificationnum":videonum, 
	                "recommendtable":"1", 
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
	            	"tableName":"investigation", 
	                "idCode":"investigationnum", 
	                "useremail":useremail, 
	                "identificationnum":videonum, 
	                "recommendtable":"1", 
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
	   		
			$('#registSubtitle').on('click', function() {
				var form = $('#fileForm')[0];
				var formData = new FormData(form);
				var subtitleName = $('#subtitleName');
				
				if(subtitleName.val().trim().length == 0) {
					alert("자막 파일명을 입력해주세요.");
					subtitleName.focus();
					return;
				}
				
				var fileName = $('#subtitleFile')[0].files[0].name;
				if(fileName.substring(fileName.lastIndexOf('.')+1) != "srt") {
					alert("srt 파일만 자막 등록이 가능합니다.");
					$('#subtitleFile').focus();
					return;
				}
				
				formData.append("file", $('#subtitleFile')[0].files[0]);
				formData.append("useremail", useremail);
				formData.append("investigationNum", investigationnum);
				formData.append("subtitleName", subtitleName.val());
				
				$.ajax({
					url:'registSubtitle'
					, type:'post'
					, processData: false
					, contentType: false
					, data: formData
					, success: function(resp) {
						if(resp == 'failure') {
							alert("파일을 넣어주세요.")
						}else if(resp == 'success') {
							subtitleName.val('');
							$('#subtitleFile').val('');
							init();
						}
					}
					, error: function(resp, code, error) {
	                  	alert("resp : "+resp+", code : "+code+", error : "+error);
	            	}
				});
			});
		});
		
		function init() {
	        $.ajax({
	            method : 'post',
	            url : 'replyInvAll',
	            data : 'idnum=${inv.investigationnum}',
	            async: false,
	            success : outputReply
	    	});
	        
	        $.ajax({
	            method : 'post',
	            url : 'invSubAll',
	            data : 'investigationnum=${inv.investigationnum}',
	            async: false,
	            success : outputSubtitle
	        });
	    }
	      
	    function outputReply(resp) {
	       var result = '';
	    
	       for ( var i in resp) {
	          result += '<div class="content">'
	          result += ' <p class="email" >' + resp[i].useremail + '</p>';
	          result += ' <p class="nick" >' + resp[i].usernick + '</p>';
	          result += ' <p class="text" >' + resp[i].content + '</p>';
	          result += '<p class="date" >' + resp[i].regdate + '</p>';
	          result += '<p class="blackcount" >' + resp[i].blackcount + '</p>';
	          result += '<input class="replyUpdate" type="button" data-rno="'+resp[i].replynum+'" value="수정" />';
	          result += '<input class="replyDelete" type="button" data-rno="'+resp[i].replynum+'" value="삭제" />';
	          result += ' </div>';
	       }
	         
	       $("#result").html(result);
	       $("input:button.replyDelete").click(replyDelete);
	       $("input:button.replyUpdate").click(replyUpdate); 
	    }
	    
	    function outputSubtitle(resp) {
	    	console.log(resp);
	    	
	    	var result = '';
			for ( var i in resp) {
				result += '<div class="subtitle">'
				result += ' <span class="">'+resp[i].usernick+'</span>'
				result += ' <span class="">'+resp[i].subtitleName+'</span>'
				result += '	<input class="subStart" type="button" value="자막 실행" data-rno="'+resp[i].subtitleNum+'"/>';
				if(useremail == resp[i].useremail) {
					result += '	<input class="subDelete" type="button" value="자막 삭제" data-rno="'+resp[i].subtitleNum+'"/>';
				}
				result += '	<button class="btn subRecommendation" type="button" data-rno="'+resp[i].subtitleNum+'">';
				result += '		<img alt="" src="images/tup.png"> <span class="subRecoCount">'+resp[i].recommendation+'</span>';
				result += '	</button>';
				result += '	<button class="btn subDecommendation" type="button" data-rno="'+resp[i].subtitleNum+'">';
				result += '		<img alt="" src="images/tdown.png"> <span class="subDecoCount">'+resp[i].decommendation+'</span>';
				result += '	</button>';
				result += '</div>';
			}

			$("#subtitleList").html(result);
			$(".subStart").on('click', subStart);
			$(".subDelete").on('click', subDelete);
			$(".subRecommendation").on('click', subRecommendation);
			$(".subDecommendation").on('click', subDecommendation);
		}
	    
	   	function subStart() {
	   		alert("자막 실행");
	   		
	   		var subnum = $(this).attr('data-rno');
	   		
	   		$.ajax({
	   			method: 'get'
	   			, url: 'getSubtitles'
	   			, data: 'subtitleNum='+subnum
	   			, success: makeSubList
	   			, error: function(resp, code, error) {
	   				alert(resp+", code:"+code+", error:"+error)
	   			}
	   		});
	   	}
	   	
	   	function makeSubList(s) {
			console.log(s); 
			var subtitles="";
			setInterval(function() {
				//0.01초 단위로 영상 재생시간을 채크하고 이를 소숫점2자리까지 잘라서 자막의 소숫점 2자리까지의 싱크타임과 비교, 맞을 경우 해당 문장의 배경색을 바꿈
				var time=player.getCurrentTime().toFixed(2);
				var text=s[time];
				
				if(text!=null){
					$('#textbox').html(text);	
				}
			},10);
		}
	    
	    function subDelete() {
	    	var subnum = $(this).attr('data-rno');
	    	
	    	var dataForm = {
	    		'subtitleNum':subnum
	    		, "recommendtable":"3"
	    	};
	    	
	    	$.ajax({
	    		method: 'get'
	    		, url: 'invSubDelete'
	    		, data: dataForm
	    		, async: false
	    		, success: function(resp) {
	    			//alert(resp);
	    		}
	    	});
	    	
	    	init();
	    }
	    
	    function subRecommendation() {
	    	if(useremail.trim().length == 0) {
            	location.href="login";
            	return;
           	}
           	var target = $(this);
           	var subRecoCount = Number(target.children("span").text());
           	var subDecoTarget = target.parent().children(".subDecommendation").children(".subDecoCount");
           	var subnum = $(this).attr('data-rno');
           	var dataForm = {
                "tableName":"InvestigationSubtitle", 
                "idCode":"subtitleNum", 
                "useremail":useremail, 
                "identificationnum":subnum, 
                "recommendtable":"3", 
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
                     	target.children("span").html(subRecoCount+1);
                  	}else if(resp == "cancel") {
                     	alert("좋아요를 취소합니다.");
                     	target.children("span").html(subRecoCount-1);
                  	}else if(resp == "change") {
                     	alert("좋아요로 변경하셨습니다.");
                     	subDecoTarget.html(Number(subDecoTarget.text())-1);
                     	target.children("span").html(subRecoCount+1);
                  	}
               	}
               	, error:function(resp, code, error) {
                  	alert("resp : "+resp+", code : "+code+", error : "+error);
               	}
            });
	    }
	    
	    function subDecommendation() {
	    	if(useremail.trim().length == 0) {
               	location.href="login";
               	return;
            }
            var target = $(this);
            var subDecoCount = Number(target.children("span").text());
            var subRecoTarget = target.parent().children(".subRecommendation").children(".subRecoCount");
	    	var subnum = $(this).attr('data-rno');
            var dataForm = {
            	"tableName":"InvestigationSubtitle", 
                "idCode":"subtitleNum", 
                "useremail":useremail, 
                "identificationnum":subnum, 
                "recommendtable":"3", 
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
                     	target.children("span").html(subDecoCount+1);
                  	}else if(resp == "cancel") {
                     	alert("싫어요를 취소합니다.");
                     	target.children("span").html(subDecoCount-1);
                  	}else if(resp == "change"){
                     	alert("싫어요로 변경하셨습니다.");
                     	subRecoTarget.html(Number(subRecoTarget.text())-1);
                     	target.children("span").html(subDecoCount+1);
                  	}
                 }
               	, error:function(resp, code, error) {
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
					"idnum" : investigationnum,
					"useremail" : useremail,
					"content" : replytext
				};

				$.ajax({
					type : 'post',
					url : 'replyInvInsert',
					data : JSON.stringify(sendData),
					dataType : 'text',
					contentType : "application/json; charset=UTF-8",
					success : init
				});
				//돌려놓기
				$("#replytext").val('');
			} else if (btnname == '댓글수정') {
				var replytext = $("#replytext").val();
				var replynum = $("#replynum").val();
				var sendData = {
					"replynum" : replynum,
					"content" : replytext,
				}

				$.ajax({
					method : 'post',
					url : 'replyInvUpdate',
					data : JSON.stringify(sendData),
					dataType : 'text',
					contentType : "application/json; charset=UTF-8",
					success : init
				});

				$("#replytext").val('');
				$("#replyInsert").val("리뷰등록");
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
				url : 'replyInvDelete',
				data : 'replynum=' + replynum,
				dataType : 'text',
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

			//히든에 리뷰넘버 넣어주기
			$("#replynum").val(replynum);
		}
	</script>
</head>
<body>
	<!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
	<!--<div id="youtube"></div>   -->
	<iframe id="youtube" width="960" height="490"
		src="http://www.youtube.com/embed/${inv.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=0&modestbranding=1"
		frameborder="0" allowfullscreen>
	</iframe>

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
        // player.stopVideo();   완전 멈춰서 처음부터 시작함
      }
        
      function youtubeCurrentTime() {
         //console.log('재생률: '+(player.getCurrentTime()/player.getDuration()));   // 현재 상영 시간 출력
         // console.log(player.getDuration());   // 총 시간 출력
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

	<div class="card-footer" align="center">
		<input type="hidden" value="${inv.investigationnum}">
		<button class="btn recommendation" type="button">
			<img alt="" src="images/tup.png"> <span id="recoCount">${inv.recommendation}</span>
		</button>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button class="btn decommendation" type="button">
			<img alt="" src="images/tdown.png"> <span id="decoCount">${inv.decommendation}</span>
		</button>
	</div>
	<hr />
	
	<div>
		<form id="fileForm" method="post" enctype="multipart/form-data" action="">
			파일명<input type="text" id="subtitleName"/>
			<input type="file" id="subtitleFile"/>
			<input type="button" id="registSubtitle" value="자막 등록"/>
		</form>
	</div>
	
	<div id="subtitleList"></div>
	<hr />
	
	<div id="textbox"></div>
	<hr/>
	
	<div>
		<form id="replyform" method="post">
			<input id="usernick" name="usernick" type="text" value="${sessionScope.usernick}" readonly="readonly" /> 
			<input id="replytext" name="replytext" type="text" placeholder="리뷰를 작성해주세요 ^ㅅ^" /> 
			<input type="hidden" id="useremail" name="useremail" value="" /> 
			<input type="hidden" id="replynum" name="replynum" value="" /> 
			<input id="replyInsert" type="button" value="댓글등록" />
		</form>
		
		<hr />
		<div id="result">
			<!-- 반복적으로 나오게 -->
		</div>
	</div>
</body>
</html>