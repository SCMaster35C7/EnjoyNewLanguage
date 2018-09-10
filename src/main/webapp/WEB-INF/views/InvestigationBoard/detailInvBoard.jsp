<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="zisung">
	<!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize1.css"  media="screen,projection"/>

    <!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	
	<title>Insert title here</title>
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		//css
		$(function() {
			$('select').formSelect();
			
			//dropdown
			$(".dropdown-trigger").dropdown();
			
			//floating actionbutton
			$(".fixed-action-btn").floatingActionButton({
				/* direction:'left' */
			});
			
			//modal open
			$('#modal1').modal();
			
			$('#back').on('click', function() {
				
			});
			
			//side-nav open
			$('.sidenav').sidenav();
			
			//tooltip
			$('.tooltipped').tooltip();
			
			//캐러셀
			$('.carousel').carousel();
			
			$('#loginBtn').on('click',function(){
				var useremail = $('#useremail');
				var userpwd = $('#userpwd');
				
				$('#loginForm').submit();
			});
		});
		
	
		var useremail = "${sessionScope.useremail}";
		var usernick = "${sessionScope.usernick}";
		var investigationnum = "${inv.investigationnum}"
          
	    $(function() {
	    	initReply();
	    	initSubtitle();
	         
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
	   		
			$("#cancelUpdate").on('click', function() {
				$("#replytext").val('');
				$("#replyInsert").val("댓글등록");
				$("#cancelUpdate").css("visibility", "hidden");
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
							initSubtitle();
						}
					}
					, error: function(resp, code, error) {
	                  	alert("resp : "+resp+", code : "+code+", error : "+error);
	            	}
				});
			});
		});
		
		function initReply() {
	        $.ajax({
	            method : 'post',
	            url : 'replyInvAll',
	            data : 'idnum=${inv.investigationnum}',
	            async: false,
	            success : outputReply
	    	});
	    }
		
		function initSubtitle() {
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
	      		if (usernick==resp[i].usernick) {
					result += '<input class="replyUpdate" type="button" data-rno="'+resp[i].replynum+'" value="수정" />';
					result += '<input class="replyDelete" type="button" data-rno="'+resp[i].replynum+'" value="삭제" />';
				}
				result += '<img class="report" src="images/절미2.jpg"  data-rno="'+resp[i].replynum+'" />';
	          	result += ' </div>';
			}
	         
	       	$("#result").html(result);
	       	$("input:button.replyDelete").click(replyDelete);
	       	$("input:button.replyUpdate").click(replyUpdate);
	       	$("img.report").click(reportReply); 
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
	    	
	    	initSubtitle();
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

		function reportReply() {
			//alert('신고');
			var useremail = "${sessionScope.useremail}";
			//alert(useremail);
			replynum = $(this).attr('data-rno');
			//alert(replynum);
			var sendData = {
					"useremail":useremail
					,"whichboard":  "1"
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
					initReply();
				},
				error:function(resp, code, error) {
					//alert("resp : "+resp+", code : "+code+", error : "+error);
					alert("로그인이 필요합니다.");
					location.href="./";
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
					success : initReply
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
					success : initReply
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
				url : 'replyInvDelete',
				data : 'replynum=' + replynum,
				dataType : 'text',
				success : initReply
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
		
		function goback(){
			history.back();
		}
	</script>
</head>
<body>
	<header>
	<!-- Dropdown Structure -->
		<ul id="dropdown1" class="dropdown-content">
		  <li><a href="myPage">마이페이지</a></li>
		  <li><a href="TryRetake?videoNum=9">재시험테스트</a>
		  		<c:if test="${plzLogin!=null}">
					<script type="text/javascript">
							$(function(){
								alert("${plzLogin}");
							});
					</script>
				</c:if>
		  </li>
		  <li class="divider"></li>
		  <li><a href="searchTest">Youtube Search테스트</a></li>
		</ul>
	<!-- nav -->
		<nav class="nav-extended">
		  <div class="nav-wrapper">
		    <!-- sidenav trigger -->
		    <ul class="left">
		    	<li>
		    		<a href="#" data-target="slide-out" class="sidenav-trigger" style="display:inline">
		    			<i class="material-icons">menu</i>
		    		</a>
		    	</li>
		    </ul>
		    <a href="${pageContext.request.contextPath}" class="brand-logo">Logo</a>
		    <a href="#" data-target="small-navi"  class="sidenav-trigger"><i class="material-icons">menu</i></a>
		    <ul class="right hide-on-med-and-down">
		      	<c:if test="${not empty sessionScope.useremail }">
			      <li>
					<a href="logout">${sessionScope.useremail }님아logout</a>
			      </li>
				</c:if>
			      <li><a href="eduBoard">영상게시판</a></li>
			      <li><a href="dubbingBoard">더빙게시판</a></li>
			      <li><a href="InvestigationBoard">자막검증게시판</a></li>
		      <!-- Dropdown Trigger -->
		      	  <li><a class="dropdown-trigger" href="#" data-target="dropdown1">Dropdown<i class="material-icons right">arrow_drop_down</i></a></li>
		    </ul>
		  </div>
	
		  <div class="nav-content">
				<a class="btn-floating btn-large halfway-fab pulse modal-trigger tooltipped" data-position="left" data-tooltip="LOGIN!" href="#modal1">
	        		<i class="medium material-icons">person</i>
	     		</a>
		  </div>
		</nav>
	</header>
	
	 <!-- 창 축소시 사이드 nav -->
		  <ul class="sidenav" id="small-navi">
		    <li><a href="eduBoard.jsp">영상게시판</a></li>
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
							</div>
						</c:if>
					</div>
					
					<c:if test="${not empty sessionScope.useremail }">
						<h4 class="center">${sessionScope.useremail}환영합니다.</h4>
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
								<button class="btn waves-effect waves-light modal-close" id="back" type="button">BACK
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
								    <li><a class="btn-floating green tooltipped" data-position="top" data-tooltip="ACCOUNT RECOVERY"><i class="material-icons">sync</i></a></li>
								    <li><a class="btn-floating yellow darken-1 tooltipped" data-position="top" data-tooltip="QUIT US"><i class="material-icons">clear</i></a></li>
								</ul>
						</div>
					</div>
				</form>
			</div>
		</div>	
	  </div>
	  
	  <div class="wrapper">
			 <!-- sidenav -->	  
			<aside>	  	  
			  	  <ul id="slide-out" class="sidenav" style="margin-top:64px;">
					<li><div class="user-view">
							<div class="background">
								<img src="images/">
							</div>
							<a href="#user"><img class="circle" src="images/"></a>
							<a href="#name"><span class="white-text name">${usernick}</span></a> 
							<a href="#email"><span class="white-text email">${useremail}</span></a>
						</div>
					</li>
					<li><a href="#!"><i class="material-icons">cloud</i>First
							Link With Icon</a></li>
					<li><a href="#!">wishList</a></li>
					<li><div class="divider"></div></li>
					<li><a class="subheader">회원정보관리</a></li>
					<li><a class="waves-effect" href="updateMember">회원정보수정</a></li>
					<li><a class="waves-effect" href="#">회원탈퇴</a></li>
				</ul>
			</aside>
		
			
			<section>
				<div class="container">
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

	<table border="1">
		<tr>
			<th>동영상 재생/멈춤</th>
			<td><input type="button" class="btn" id="playYoutube" value="재생"> <input
				type="button" class="btn" id="pauseYoutube" value="멈춤"></td>
		</tr>
		<tr>
			<th>동영상 현재 시간 출력</th>
			<td><input type="button" class="btn" id="currentTime" value="영상 시간 출력" /></td>
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
              <input id="cancelUpdate" type="button"  style="visibility:hidden;" value="수정취소"/>
            </form>

            <hr />
            <div id="result">
              <!-- 반복적으로 나오게 -->
            </div>
					</div>
				</div>
			</section>
	</div>

<footer class="page-footer">
       <div class="container">
         <div class="row">
            <div class="col l6 s12">
              <h5 class="white-text">Footer Content</h5>
                <p class="grey-text text-lighten-4">You can use rows and columns here to organize your footer content.</p>
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
             © 2014 Copyright Text
            <a class="grey-text text-lighten-4 right" href="#!">More Links</a>
          </div>
       </div>
</footer>
	
<script type="text/javascript" src="js/materialize.js"></script>	
</body>
</html>