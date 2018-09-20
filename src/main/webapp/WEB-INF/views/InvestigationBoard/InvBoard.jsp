<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="author" content="zisung">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize1.css"  media="screen,projection"/>
      
	<title data-langNum2="201">자막검증게시판</title>
	
	<style type="text/css">
		#checkline{
			text-align: center;
			color: red;
		}
	</style>    
	    
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="js/LanguageSet.js"></script>
	<script src="YoutubeAPI/auth.js"></script>
	    
	<script type="text/javascript">
	// css용
	$(function(){
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

		
		//$('#requestInv').modal();
		//side-nav open
		$('.sidenav').sidenav();
		
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
		 //위시리스트에 비디오 등록
	      $('.btnRegistSubWish').on('click', function(){
	         var target = $(this);
	         var useremail = "${sessionScope.useremail}";
	         var investigationnum = target.parent().children("#investigationnum").val();
	         var title = target.parent().parent().children('.card-content').children("span").children("a").html();
	         var url = target.parent().children("#url").val();
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
	                  "wishtable": 1,                     
	                  "useremail":useremail, 
	                  "identificationnum":investigationnum,
	                  "title"   : title,
	                  "url" : url                     
	            };
	            console.log(dataFormSub);
	            
	            $.ajax({
	               method:'post'
	               , url:'insertSubWish'
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

	$(function() {
		  $('#requestInvestigation').on('click', function() {
			var useremail = "${sessionScope.useremail}";
			
			if(useremail.trim().length == 0) {
				$('#modal1').modal('open');
				return;
			}
			$('#requestInv').modal();
		});  
		
		$('.recommendation').on('click', function() {
			var useremail = "${sessionScope.useremail}";
			
			if(useremail.trim().length == 0) {
				location.href="login";
				return;
			}
			var target = $(this);
			var recoCount = Number(target.children("span").text());
			var decoTarget = target.parent().children(".decommendation").children("#decoCount");
			var videonum = target.parent().children("input").val();
			var dataForm = {
				"tableName":"Investigation"
				, "idCode":"investigationnum"
				, "useremail":useremail
				, "identificationnum":videonum
				, "recommendtable":"1"
				, "recommendation":"0"
			};
			
			$.ajax({
				method:'post'
				, url:'insertRecommendation'
				, data: JSON.stringify(dataForm)
				, contentType: "application/json; charset=utf-8"
				, async : false
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
			var useremail = "${sessionScope.useremail}";
			
			if(useremail.trim().length == 0) {
				location.href="login";
				return;
			}
			var target = $(this);
			var decoCount = Number(target.children("span").text());
			var recoTarget = target.parent().children(".recommendation").children("#recoCount");
			var videonum = target.parent().children("input").val();
			var dataForm = {
				"tableName":"Investigation"
				, "idCode":"investigationnum"
				, "useremail":useremail
				, "identificationnum":videonum
				, "recommendtable":"1"
				, "recommendation":"1"
			};
			
			$.ajax({
				method:'post'
				, url:'insertRecommendation'
				, data: JSON.stringify(dataForm)
				, contentType: "application/json; charset=utf-8"
				, async : false
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
	});
    </script>
      <script>
    var koPage={
    		101:'영상추가'	
    	   ,102:'자막검증게시판'
    	   ,201:'자막검증게시판'
    }
    var jpPage={
    		101:'映像追加'
    	   ,102:'字幕検証掲示板'
    	   ,201:'字幕検証掲示板'
    }
    
    function languageChange_Page(lang){
		if(lang=='kor'){
			$('[data-langNum2]').each(function() {
			    var $this = $(this); 
			    $this.html(koPage[$this.data('langnum2')]); 
			});
			$('#reset').attr('value','초기화');
			$('#regist').attr('value','등록하기');			
		}else if(lang=='jp'){
			$('[data-langNum2]').each(function() {
			    var $this = $(this); 
			    $this.html(jpPage[$this.data('langnum2')]); 
			});
			$('#reset').attr('value','初期化');
			$('#regist').attr('value','登録する');
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
			    <a href="${pageContext.request.contextPath}" class="brand-logo">Logo</a>
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
			      	<li><a href="myPage" style="margin-right:20px;" data-langNum="4"></a></li>
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
					<a class="waves-effect modal-close modal-trigger" href="#modal3" data-langNum="13"></a>
				</li>
				<li>
					<a class="waves-effect modal-close modal-trigger" href="#modal2" data-langNum="14"></a>
				</li>
			</ul>
		</aside>	
		
		<!-- 영상추가버튼 -->	
   	<div class="fixed-action-btn">
		<a class="btn-floating btn-large red modal-trigger tooltipped" id="requestInvestigation" data-position="top" data-tooltip="+VIDEO" href="#requestInv">
			<i class="large material-icons">add_a_photo</i>
		</a>
	</div>
	
	<!-- 영상추가 모달 -->
	<div id="requestInv" class="modal">
		<div class="container">
			<div class="madal-content">
				<h5 class="center" data-langNum2="101">영상추가</h5>
				<div class="row">
					<form>
						<div class="input-field col s12">
							<input type="text" class="validate" id="title" name="title"/>
							<label for="title">Title</label>
						</div>		
						<div class="input-field col s12">
							<input type="text" class="validate" id="url" name="url"/>
							<label for="url">URL</label>
						</div>			
						<div class="input-field col s12">
							<textarea id="content" class="materialize-textarea"></textarea>
	          				<label for="textarea1">Content</label>
						</div>
						<div class="center">	
							<button class="btn modal-close" type="button" class="btn">BACK</button>
							<input type="button" id="regist" class="btn" value="등록하기"> 
							<input type="reset" id="reset" class="btn" value="초기화">
						</div>		
					</form>
				</div>				
				<h4 class="center" style="color:red;">YouTube Viral Search</h4>
				 
				<div class="row col s12">
					<div class="input-field col s9">
			        	<input type="text" id="search" placeholder="Type something..." autocomplete="off" class="form-control" />
			        </div>
			        <div class="input-field col s3">
			        	<input type="button" id="searchBtn" value="Search" class="btn">
			        </div>
			       	<div id="results"></div>
				</div>
			</div>
		</div>
	</div>
		
				
			<section>	
				<div class="container">
					<div class="row">
            			<h4 class="left"><a href="InvestigationBoard" data-langNum2="102"></a></h4>
            		</div>	
					<div class="row">
					<c:if test="${not empty invList}">
						<c:forEach var="invList" items="${invList}">
						
						<div class="col s12 m3 l3">
							<div class="card" style="height:400px margin-bottom:10px;">
										<div class="card-image">
											<img alt="" src="https://img.youtube.com/vi/${invList.url}/0.jpg">
											<input type="hidden" id="url" value="${invList.url}"/>
									        <input type="hidden" id="investigationnum"value="${invList.investigationnum}"/>
											<a class="btn-floating halfway-fab waves-effect waves-light red tooltipped btnRegistSubWish" data-position="bottom" data-tooltip="Wish!"><i class="material-icons">add</i></a>
										</div>
								
								<div class="card-content" style="height:150px; word-break:break-all;">
									<span>
										<a href="detailInvBoard?investigationnum=${invList.investigationnum}&currentPage=${navi.currentPage}&searchType=${searchType}&searchWord=${searchWord}">${invList.title}</a>
									</span>
								</div>
								
								<div class="card-action" style="height:70px">
										<input type="hidden" value="${invList.investigationnum}">
									<div class="row">
											<button class="btn recommendation" style="width:65px; padding-right:4px; padding-left:4px;">
												<i class="material-icons">thumb_up</i>
												<span id="recoCount">${invList.recommendation}</span>
											</button>
											<button class="btn decommendation" style="width:65px; padding-right:4px; padding-left:4px;">
												<i class="material-icons">thumb_down</i>
												<span id="decoCount">${invList.decommendation}</span>
											</button>
											<button class="btn disabled right decommendation" style="width:80px">
												<i class="material-icons">touch_app</i>
												<span>${invList.hitcount}</span>
											</button>
											</div>
										</div>
									</div>
								</div>
						</c:forEach>
					</c:if>
				</div>
				</div>
					
				<div class="center">
					<ul class="pagination">
						<li class="waves-effect">
							<a href="InvestigationBoard?currentPage=${navi.currentPage - navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
								<i class="material-icons">first_page</i>
							</a>
						</li>
					
						<li class="waves-effect">
							<a href="InvestigationBoard?currentPage=${navi.currentPage - 1}&searchType=${searchType}&searchWord=${searchWord}"> 
								<i class="material-icons">chevron_left</i>
							</a>
						</li>
					
						<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
							<c:if test="${navi.currentPage == page }">
								<li class="page-item active"><a class="page-link">${page}</a></li>
							</c:if>
							<c:if test="${navi.currentPage != page }">
								<li class="page-item"><a class="page-link"
									href="InvestigationBoard?currentPage=${page}&searchType=${searchType}&searchWord=${searchWord}">${page}</a></li>
							</c:if>
						</c:forEach>
						
						<li class="waves-effect">
							<a href="InvestigationBoard?currentPage=${navi.currentPage + 1}&searchType=${searchType}&searchWord=${searchWord}">
								<i class="material-icons">chevron_right</i> 
							</a>
						</li>
						
						<li class="waves-effect">
							<a href="InvestigationBoard?currentPage=${navi.currentPage + navi.PAGE_PER_GROUP}&searchType=${searchType}&searchWord=${searchWord}">
								<i class="material-icons">last_page</i> 
							</a>
						</li>
					</ul>
				</div>
			</section>
		</div>
	
	<footer class="page-footer">
    	<div class="container">
        	<div class="row">
              	<div class="col l6 s12">
                	<h5 class="white-text">One jewelry 7th Group</h5>
                	<p class="grey-text text-lighten-4">Enjoy & Try study English</p>
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
          
	<script type="text/javascript" src="js/materialize.min.js"></script>
	<script type="text/javascript" src="YoutubeAPI/search.js"></script>
	<script src="https://apis.google.com/js/client.js?onload=init"></script>
	<script>
    	$(function() {
       		$("#searchBtn").on('click', function() {
       			if($('#search').val().length == 0) {
       				alert("검색어를 입력하세요.");
       				$('#search').focus();
       				return;
       			}

        		init();
        		search();
        	});
       		
       		$("#regist").on('click', function() {
	       		var title = $("#title");
	       		if(title.val().trim().length == 0) {
	       			alert("Please enter a title");
	       			title.focus();
	       			return;
	       		}
	       		
	       		var url = $("#url");
	       		if(url.val().trim().length == 0) {
	       			alert("Please enter a URL");
	       			url.focus();
	       			return;
	       		}
	       		var content = $('#content').val();
	       		
	       		var originalURL = url.val();				// 원본 URL
	       		var markIndex = originalURL.indexOf("?");	// GET방식 인자를 제외한 실제 주소
	       		var findVideoId = "";
	       		
	       		if(markIndex == -1) {
	       			if(originalURL.includes("embed") == false) {
	       				alert("Enter Youtube Video URL correctly");
	       				return;
	       			}
	       			
	       			var embedIndex = originalURL.indexOf("embed")+6;
	       			findVideoId = originalURL.substring(embedIndex);	//iframe에서 선택시 VideoId추출
	       		}else {
	       			if(originalURL.includes("youtube.com") == false || originalURL.indexOf("v=") == -1) {
	       				alert("Enter Youtube Video URL correctly");
	       				return;
	       			}
	       			var vIndex = originalURL.indexOf("v=")+2;
	       			var firstAmpIndex = originalURL.substring(vIndex).indexOf("&");
	       			
	       			if(firstAmpIndex == -1) {
	       				findVideoId = originalURL.substring(vIndex);
	       				//alert(findVideoId);
	       			}else {
	       				findVideoId = originalURL.substring(vIndex, vIndex+firstAmpIndex);
	       			}
	       		}
       		
	       		var dataForm = {
	       			"useremail":"${sessionScope.useremail}",
	       			"title":title.val(),
	       			"url":findVideoId,
	       			"content":content
	       		};
	       		
				$.ajax({
					method:'post'
					, url: 'requestInvestigation'
					, data: JSON.stringify(dataForm)
					, dataType: "json"
					, contentType:"application/json; charset=utf-8"
					, success:function(resp) {
						if(resp.result == "success") {
							location.href="InvestigationBoard";
						}else if(resp.result == "invExist") {
							if(confirm("The Video has already been requested. Do you want to go to the corresponding Video?")) {
								location.href = "detailInvBoard?investigationnum="+resp.investigationnum;
							}
						}else if(resp.result == "eduExist") {
							if(confirm("Registered on the training video. Do you want to go to the corresponding Video?")) {
								location.href = "detailEduBoard?videoNum="+resp.videonum;
							}
						}
					}, error:function(resp, code, error) {
						alert("resp : "+resp+", code : "+code+", error : "+error);
					}
				});
	       	});
		});
	</script>
	<script type="text/javascript" src="js/LoginMenu.js"></script>
</body>
</html>