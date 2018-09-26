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
	<script type="text/javascript" src="js/LanguageSet.js"></script>
	<script type="text/javascript">
		
	  $(document).ready(function() {
	    $('input#replytext').characterCounter();
	  });
	    //css
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
			 //위시리스트에 더빙 등록
		      $('.btnRegistSubWish').on('click', function(){
		         var useremail = "${sessionScope.useremail}";
		         var investigationnum = '${dubbing.dubbingnum}';
		         var title = '${dubbing.title}';
		         var url = '${dubbing.url}';
		         var rnum = "${WishList.rnum}";
		         
		         alert("title : "+title+"investigationnum:"+investigationnum+"url:"+url);
		         //로그인된 세션이 있는지 확인
		         if(useremail.trim().length == 0) {
		            location.href="login";
		            return;
		         }else{
		            //선택된 비디오 정보를 위시리스트로 보내기
		            var dataFormSub = {
		                  "rnum" : rnum + 1,
		                  "wishtable": 2,                     
		                  "useremail":useremail, 
		                  "identificationnum":investigationnum,
		                  "title"   : title,
		                  "url" : url                     
		            };
		            console.log(dataFormSub);
		            
		            $.ajax({
		               method:'post'
		               , url:'insertDubWish'
		               , data: JSON.stringify(dataFormSub)
		               , contentType: "application/json; charset=utf-8"
		               , async : false
		               , success:function(resp) {
		                  if(resp == "success")
		                     alert("자막을 찜한 목록에 등록하였습니다.");
		                  else if(resp == "failure")
		                     alert("자막이 이미 찜한 목록에 있습니다.");
		                  else if(resp == "failRegist")
		                     alert("자막을 찜한 목록 등록하는데 실패하였습니다.")
		                 }
		               , error:function(resp, code, error) {
		                  alert("resp : "+resp+", code : "+code+", error : "+error);
		               }
		            });               
		         }             
		      });
			
		});
	 	var useremail = "${sessionScope.useremail}";
		var usernick = "${sessionScope.usernick}";
		var dubbingnum = "${dubbing.dubbingnum}"	
		var soundA=new Audio("getDubbingSoundFile?voiceFile=${dubbing.voiceFile}");
		var saveTime=null;     //자막 싱크용 시간저장변수
	
		$(function() {
			init();		
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
							alert("I like this video");
							target.children("span").html(recoCount+1);
						}else if(resp == "cancel") {
							alert("Cancel");
							target.children("span").html(recoCount-1);
						}else if(resp == "change") {
							alert("I changed it to 'like'");
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
							alert("I hate this video");
							target.children("span").html(decoCount+1);
						}else if(resp == "cancel") {
							alert("Cancel");
							target.children("span").html(decoCount-1);
						}else if(resp == "change"){
							alert("I changed it to 'hate'");
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
				$("#replyInsert").val("Register");
				$("#cancelUpdate").css("visibility", "hidden");
				$('#replylabel').show();
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
			var lngType = sessionStorage.getItem("lngType");
			var uc='';
			var report='';
			var update='';
			var del='';
			if(lngType=='kor'){
				uc='수정/취소';
				report='신고';
				update='수정';
				del='삭제';
			}else if(lngType=='jp'){
				uc='修整/キャンセル';
				report='申告';
				update='修整';
				del='削除';
			}
			var result = '';
		
			result += '<div class="row">'
			result += '<table cellpadding="5" cellspacing="2" border="1" align="center" word-break:break-all;" style="width: 80%; margin-left: 3%;">';
			result += 	'<thead>';
			result +=		'<tr>';
			result +=			'<th>' + 'usernick' + '</th>';
			result +=			'<th class="replycontent" style="width: 50%;">' + 'content' + '</th>';
			result +=			'<th>' + 'date' + '</th>';
			result +=			'<th colspan="2">' + uc + '</th>';
			result +=			'<th>' + report + '</th>';
			result +=		'</tr>';
			result += 	'</thead>';
			for (var i in resp) {
				result += 	'<tbody>';
				result +=		'<tr>';
				result +=			'<td>' + resp[i].usernick + '</td>';
				result +=			'<td class="replycontent">' + resp[i].content + '</td>';
				result +=			'<td>' + resp[i].regdate + '</td>';
				result +=			'<td colspan="2">';
				if ('${sessionScope.useremail}'==resp[i].useremail) {
					result += '<input class="replyUpdate btn" type="button" style="margin-right:1%;" data-rno="'+resp[i].replynum+'" value="'+update+'" />';
					result += '<input class="replyDelete btn" type="button" data-rno="'+resp[i].replynum+'" value="'+del+'" />';
				}
				result +=			'</td>';
				result +=		'<td>';
				result +=   '<i class="small material-icons report" style="color:#fbc02d;" data-rno="'+resp[i].replynum+'">'+'error'+'</i>';
				result +=		'</td></tr>';
				result += 	'</tbody>';
			}
			result += '</table>';
			result += ' </div>';
			
			$("#result").html(result);
	
			//여기서(output) 나가기 전에 이벤트 걸어야함
			 $("input:button.replyDelete").click(replyDelete);
			 $("input:button.replyUpdate").click(replyUpdate); 
			 $("i.report").click(reportReply); 
		}
		
		function reportReply() {
			var useremail = "${sessionScope.useremail}";
			replynum = $(this).attr('data-rno');
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
					//alert("resp : "+resp+", code : "+code+", error : "+error);
					alert("You need Login!");
					location.href="./";
				}
			}); 
		}
		
		function replyInsert() {
			$("#useremail").val(useremail);
			
			var btnname = $("#replyInsert").val();

			if (btnname == 'Register') {
				var replytext = $("#replytext").val();

				if (replytext.length == 0) {
					alert("Please write a comment");
					return;
				}
				
				var sendData = {
					"idnum":dubbingnum
					,"useremail":  useremail
					,"content":replytext 
				};
				
				$.ajax({
					type : 'post',
					url : 'replyDubInsert',
					data : JSON.stringify(sendData),
					dataType:'json',
					contentType: "application/json; charset=UTF-8",
					success : init
				});
				 //돌려놓기
				$("#replytext").val('');
			}else if (btnname == 'Modify') { 	
				$('#replylabel').show();
				//댓글수정이면
				var replytext = $("#replytext").val();
				var replynum = $("#updatereplynum").val();
		 		var sendData = {
					"replynum" : replynum,
					"content" : replytext
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
				$("#replyInsert").val("Register");
				$("#cancelUpdate").css("visibility", "hidden");
			}
		}

		function replyDelete() {
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
			var replytext = $(this).parent().parent().children('.replycontent').text();	
			$('#replylabel').hide();
            $('#updatereplynum').val(replynum);
			$("#replytext").val(replytext);
			$("#replyInsert").val("Modify");
			$("#cancelUpdate").css("visibility", "visible");

		}

		function sinkTime(){
			var videoTime=('${dubbing.starttime}');
			 player.playVideo();
			 player.seekTo(videoTime, true);
			 var checkpoint=true;
			var audioTime=0;
			var inter=setInterval(function() {
				if(player.getPlayerState()==1&&checkpoint){
					soundA.play();
					checkpoint=false; //위의 if문은 최초재생시 1번만 작동시키면 되므로
				}
				if(player.getCurrentTime().toFixed(2)=='${dubbing.endtime}'){
					player.pauseVideo();
					clearInterval(inter);
				}
				if((player.getCurrentTime()-videoTime)>0.5||(player.getCurrentTime()-videoTime)<-0.5){				
					soundA.currentTime=player.getCurrentTime();
				}
				videoTime=player.getCurrentTime();
			}, 10);
		}
		
		function deleteDubbing(){
			var dubbingnum=${dubbing.dubbingnum};
			$.ajax({
				method:'post'
			   ,url: 'deleteDubbing'
			   ,data: 'dubbingnum='+dubbingnum
			})
		}	
		function goback(){
			history.back();
		}
	</script>
	<script>
	var koPage={		
	        109:'의'
	       ,110:'리뷰를 작성해주세요 ^ㅅ^'
	       ,111:'녹음:'
	}
	var jpPage={
		    109:'の'
		   ,110:'ビューを作成してください ^_^'
		   ,111:'録音:'
	}
	function languageChange_Page(lang){
		if(lang=='kor'){
			$('[data-langNum2]').each(function() {
			    var $this = $(this); 
			    $this.html(koPage[$this.data('langnum2')]); 
			});
			
		}else if(lang=='jp'){
			$('[data-langNum2]').each(function() {
			    var $this = $(this); 
			    $this.html(jpPage[$this.data('langnum2')]); 
			});
		}
	}
	</script>
	
</head>
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
        <li><a onclick="languageChange('jp')" style="padding-left:6px; padding-right:6px;"><img src="images/japan.png" hspace="8" style="vertical-align:middle; width:32px; height:32px;"/><span style="margin-left:4px;">JAP</span></a></li>
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
		<li><a onclick="languageChange('kor')">KOR</a></li>
        <li><a onclick="languageChange('jp')">JAP</a></li>
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
						<button class="btn waves-effect waves-light modal-close" type="button">BACK
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
					<a href="#!">
					<i class="material-icons">cloud</i>First Link With Icon</a>
				</li>
				<li>
					<a href="#!">wishList</a>
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
            <div style="margin-top:2%;"></div>
               <div class="row">
                  <div class="col s12 m8 l8">
                     <div class="video-container z-depth-2">
                           <iframe id="youtube" width="960" height="490"
                              src="http://www.youtube.com/embed/${dubbing.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1"
                              frameborder="0" allowfullscreen>
                           </iframe>
                     </div>
                  </div>
                   <div class="col s12 m4 l4">
                       <div class="card" style="height:466px; margin-top:0px;">
                           <div class="card-content">
                              <span class="card-title activator grey-text text-darken-4">
                                 ${dubbing.title}
                                 <c:if test="${sessionScope.useremail eq dubbing.useremail}">
                                 <i class="small material-icons right tooltipped" data-tooltip="더빙 삭제" style="color: #c62828" onclick="deleteDubbing()">delete</i> 
                              </c:if>   
                              </span>
                        
                        
                   <!-- 카드패널 -->
                           
                              <h6 style="margin-top:10%;" data-langNum2="111"><span data-langNum2="111"></span> ${dubbing.usernick}</h6>
                              <h6 style="margin-top:10%;">${dubbing.usernick}<span data-langNum2="109">의</span> Comment </h6>
                            
                           <div class="card">
                              <p style="margin-top:8%;">${dubbing.content}</p>
                           </div>
                        
                        <div style="margin-top:10%;">
                           <h6>PlayTime</h6> 
                              <div class="row">
                                 <div class="col s8 m6 l6">
                                    <div class="card" style="width:100%;">
                                    <h5 class="center" style="height:36px;">${dubbing.starttime} ~ ${dubbing.endtime}</h5>
                                    </div>
                                 </div>
                                 <div class="col s4 m4 l4 right" style="margin-top:4%;">
                                    <a type="button" class="waves-effect waves-light btn red right" style="padding-left:8px; padding-right:8px;" onclick="sinkTime()">
                                       <i class="material-icons right">play_arrow</i>Play
                                    </a>
                                    <input type="hidden" value="${dubbing.dubbingnum}">
                                 </div>
                              </div>    
                        </div>
                   
                        <div class="card-action" style="margin-top:20%; padding:10px;">
                           <div class="row left">
                              <button class="btn recommendation">
                                 <i class="material-icons">thumb_up</i>
                                 <span id="recoCount">${dubbing.recommendation}</span>
                              </button>
                                                
                              <button class="btn decommendation">
                                 <i class="material-icons">thumb_down</i>
                                 <span id="decoCount">${dubbing.decommendation}</span>
                              </button>
                           </div>   
                     		<a class="btn-floating waves-effect waves-light right red tooltipped btnRegistSubWish" data-position="bottom" data-tooltip="Wish!"><i class="material-icons">add</i></a>
                        </div>
                      </div><!-- card-content -->
                    </div>
              </div>
          </div><!-- row -->
       
            <!--댓글 영역-->
               <div class="row">
                  <div class="col s12"  style="margin-left:3%;">
                     <div class="input-field col s6 m4 l4">
                        <input  type="text" id="replytext" class="materialize-textarea" data-length="40" maxlength="40">
                        <label id="replylabel" for="replytext"data-langNum2="110">리뷰를 작성해주세요 ^ㅅ^</label>      
                     </div>
                        <input id="replyInsert" type="button" class="btn" value="Register" style="margin-top:10px;"/>
                        <input id="cancelUpdate" type="button" class="btn"  style="visibility:hidden; margin-top:10px;" value="Cancel"/>   
                  </div>
                     
                  <input type="hidden" id="useremail" value="${sessionScope.useremail}">
                  <input type="hidden" id="updatereplynum">
                  
                  <div id="result"> 
                     <!-- 반복적으로 나오게 -->
                  </div>
               </div>
            </div>
      </section>
		
	<!-- ----------------------------------------------------- -->	
		<%-- <section>
		<div class="row">
			<div class="container" style="width:98%;">
			<div class="row">
			</div>
				<div class="col s12 m8 l8">
						<div class="video-container z-depth-2">
							<iframe id="youtube" width="960" height="490"
								src="http://www.youtube.com/embed/${dubbing.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1"
								frameborder="0" allowfullscreen>
							</iframe>
					</div>
				</div>
			</div>	
			
		 <div class="col s12 m4 l4">
	       <div class="card">
	         <div class="card-content  scroll-box" style="height:450px; width:100%; margin-top:0px;">
			 <!-- 카드패널 -->
			<div class="row">
			<div class="col s8">
			 <h5 style="display:inline-block;">${dubbing.title}</h5>
			 
			 <c:if test="${sessionScope.useremail eq dubbing.useremail}">
			<i class="medium material-icons right tooltipped" data-tooltip="더빙 삭제" style="color: grey" onclick="deleteDubbing()">delete</i> 
			</c:if>	
			</div>
			</div>
			  <span data-langNum2="111">녹음:</span> ${dubbing.usernick}<br><br>
			 <span data-langNum2="109">작성자의 한마디:</span> <br> 
			 ${dubbing.content}
			<div class="row">
				<h6 style="display:inline-block;">PlayTime  &nbsp; : &nbsp; ${
				dubbing.starttime} ~ ${dubbing.endtime} &nbsp; <input type="button" class="btn" value="Play!" onclick="sinkTime()"></h6>
				<input type="hidden" value="${dubbing.dubbingnum}">			
			</div>
			 
			         <div class="right" style="margin-right:15px; margin-top: 35%;">
						<p>
						<button class="btn recommendation">
							<i class="material-icons">thumb_up</i>
							<span id="recoCount">${dubbing.recommendation}</span>
						</button>
										
						<button class="btn decommendation">
							<i class="material-icons">thumb_down</i>
							<span id="decoCount">${dubbing.decommendation}</span>
						</button>
						</p>
			         </div>
			 
			     </div>
			     <a class="btn-floating halfway-fab waves-effect waves-light red tooltipped btnRegistSubWish" data-position="bottom" data-tooltip="Wish!"><i class="material-icons">add</i></a>
			     
			</div>
		 </div><!-- 카드패널 -->
		 
				<!--댓글 영역-->
				<div class="row"> 
						<div class="row"  style="margin-left: 3%;">
							<div class="input-field col s4">
								<input  type="text" id="replytext" class="materialize-textarea" data-length="40" maxlength="40">
								<label id="replylabel" for="replytext" data-langNum2="110">리뷰를 작성해주세요 ^ㅅ^</label>		
							</div>
							<input id="replyInsert" type="button" class="btn" value="Register" style="margin-top:10px;"/>
							<input id="cancelUpdate" type="button" class="btn"  style="visibility:hidden; margin-top:10px;" value="Cancel"/>	
						</div>
						
					<input type="hidden" id="useremail" value="${sessionScope.useremail}">
					<input type="hidden" id="updatereplynum">
					
					<div id="result"> 
						<!-- 반복적으로 나오게 -->
					</div>
				</div>
			</div>
		</section> --%>
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
            playerState = 
            	event.data == YT.PlayerState.ENDED ? '종료됨' :
                event.data == YT.PlayerState.PLAYING ? '재생 중' :
                event.data == YT.PlayerState.PAUSED ? '일시중지 됨' :
                event.data == YT.PlayerState.BUFFERING ? '버퍼링 중' :
                event.data == YT.PlayerState.CUED ? '재생준비 완료됨' :
                event.data == -1 ? '시작되지 않음' : '예외';
            
            console.log('onPlayerStateChange 실행: ' + playerState);
        }
	</script>

	<%-- <c:if test="${sessionScope.usernick==resp[i].usernick}">
	
	</c:if> --%>
	
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
  <script type="text/javascript" src="js/materialize.js"></script>	
  <script type="text/javascript" src="js/LoginMenu.js"></script>
</body>
</html>