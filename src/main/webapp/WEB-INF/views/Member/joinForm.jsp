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
	<title>Join Form</title>
	
	<style type="text/css">
    	#wrapper{
   			width: 500px;
   			margin: auto;
    	}
    </style>
    
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="js/LanguageSet.js"></script>
	<script type="text/javascript" >
		$(function(){
			 SetLanguage();
    		//기본와꾸
    		/* $('select').formSelect(); */
			
			//dropdown
			$(".dropdown-trigger").dropdown();
			
			//floating actionbutton
			$(".fixed-action-btn").floatingActionButton({
			});
			
			//modal open
			$('#modal1').modal();
			$('#modal2').modal(); //회원탈퇴 모달
			$('#modal3').modal(); //회원정보수정 모달
			$('#modal4').modal(); //계정복구 모달
			$('#modal5').modal();
			
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
    		
    		//이메일 중복검사
    		$('#useremail2').keyup(function(){
    			var useremail = $(this).val();
    			
    			if (useremail.match('@')) {
    				$.ajax({
    						method	:	'post'
    						,url	: 'emailCheck'
    						,data	: "useremail="+useremail
    						,dataType	: 'text'
    						,success	: function(resp){
    							if (resp=="이미 가입한 이메일 입니다") {
									$("#emailcheck").text(resp);
									$("#emailcheck").attr("data-error","이미 가입한 이메일 입니다");
									$("#emailcheck").removeAttr("data-success");
									$('#useremail2').attr("style", "border-bottom: 1px solid red;-webkit-box-shadow: 0 1px 0 0 red; box-shadow: 0 1px 0 0 red;");
								}else if (resp=="사용 가능한 이메일 입니다") {
    		            	 		$("#emailcheck").text(resp);
    		            	 		$("#emailcheck").attr("data-success","사용 가능한 이메일 입니다");
    		            	 		$("#emailcheck").removeAttr("data-error");
    		            	 		$('#useremail2').attr("style", "border-bottom: 1px solid green;-webkit-box-shadow: 0 1px 0 0 green; box-shadow: 0 1px 0 0 green;");
								}
						}, error:function(resp, code, error) {
							alert("resp : "+resp+", code:"+code+", error:"+error);
						}
    				});
				} else {
					$("#emailcheck").text('올바른 이메일 형식으로 해주세요~');
					$("#emailcheck").attr("data-error","올바른 이메일 형식으로 해주세요~");
					$("#emailcheck").removeAttr("data-success");
					$('#useremail2').attr("style", "border-bottom: 1px solid red;-webkit-box-shadow: 0 1px 0 0 red; box-shadow: 0 1px 0 0 red;");
				}
    		});
    	
    		//닉네임중복검사
			$('#usernick2').keyup(function(){
    			var usernick = $(this).val();   			
    				
    			$.ajax({
    				method	:	'post'
    				,url	: 'nickCheck'
    				,data	: "usernick="+usernick
    				,dataType	: 'text'
    				,success	: function(resp){
    					if (resp=="중복된 닉네임 입니다") {
							$("#nickcheck").text(resp);
							$("#nickcheck").attr("data-error","이미 가입한 이메일 입니다");
							$("#nickcheck").removeAttr("data-success");
							$('#usernick2').attr("style", "border-bottom: 1px solid red;-webkit-box-shadow: 0 1px 0 0 red; box-shadow: 0 1px 0 0 red;");
						}else if (resp=="사용 가능한 닉네임 입니다") {
    		       	 		$("#nickcheck").text(resp);
    		       	 		$("#nickcheck").attr("data-success","사용 가능한 이메일 입니다");
    		       	 		$("#nickcheck").removeAttr("data-error");
    		       	 		$('#usernick2').attr("style", "border-bottom: 1px solid green;-webkit-box-shadow: 0 1px 0 0 green; box-shadow: 0 1px 0 0 green;");
						}
					}, error:function(resp, code, error) {
						alert("resp : "+resp+", code:"+code+", error:"+error);
					}    					
    			});    			
			});
    		
			$('#InputPassword1').keyup(function(){
    			var pwd1 = $(this).val();
    			
    			$pattern = '^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
    				
    			if(pwd1.match($pattern)){
    				$("#pwdcheck").text('좋은 비밀번호네요~*^^*');
	    			$("#pwdcheck").attr("data-success","좋은 비밀번호네요~*^^*");
		         	$("#pwdcheck").removeAttr("data-error");
		      	 	$('#InputPassword1').attr("style", "border-bottom: 1px solid green;-webkit-box-shadow: 0 1px 0 0 green; box-shadow: 0 1px 0 0 green;");
    			}else {
    				$("#pwdcheck").text('비밀번호는 대/소문자,  숫자, 특수 문자 포함, 8자 이상');
				}
			});
				
			$('#InputPassword2').keyup(function(){
				var pwd1 = $('#InputPassword1').val();
				var pwd2 = $(this).val();
					
				if (pwd1==pwd2) {
	             	$('#InputPassword2').attr("style", "border-bottom: 1px solid green;-webkit-box-shadow: 0 1px 0 0 green; box-shadow: 0 1px 0 0 green;");
				} else {
					$('#InputPassword2').attr("style", "border-bottom: 1px solid red;-webkit-box-shadow: 0 1px 0 0 red; box-shadow: 0 1px 0 0 red;");
				}
			});
				
			$('#joinbtn').on('click', function(){
				var emailcheck = $("#emailcheck").text();
				var nickcheck = $("#nickcheck").text();
				var pwdcheck = $("#pwdcheck").text();
				var InputPassword1 = $("#InputPassword1").val();
				var InputPassword2 = $("#InputPassword2").val();
				var birth = $("#birth").val();
				//날짜
				//오늘
				var t = new Date();
				var today =  formatDate(t);
				
				function formatDate(date) {
					var d = new Date(date);
					month = '' + (d.getMonth() + 1); 
					day = '' + d.getDate();
					year = d.getFullYear(); 
					if (month.length < 2) month = '0' + month; 
					if (day.length < 2) day = '0' + day; 
					return [year, month, day].join('-'); 
				} 
				
				//길이체크
				if (emailcheck.length<=0||emailcheck=='올바른 이메일 형식으로 해주세요~'||emailcheck=='이미 가입한 이메일 입니다') {
					alert('이메일 다시 한 번 확인해주세요');
					$("#useremail2").select();
					$("#useremail2").focus();
					
					return false;
				} else if (nickcheck.length<=0||nickcheck=='중복된 닉네임 입니다') {
					alert('닉네임 다시 한 번 확인해주세요');
					$("#usernick").select();
					$("#usernick").focus();
					
					return false;
				} else if (pwdcheck=='비밀번호는 대/소문자,  숫자, 특수 문자 포함, 8자 이상') {
					alert('비밀번호를 다시 한 번 확인해주세요');
					$("#InputPassword1").select();
					$("#InputPassword1").focus();
							
					return false;
				}  else if (birth>today) {
					alert('생년월일을 다시 한 번 확인해주세요');
					$("#birth").select();
					$("#birth").focus();
					
					return false;
				}
				var InputPassword = $("#InputPassword2").val();
				$("#userpwd2").val(InputPassword); 
				return true;
			});	
    	});
    </script>
    <script>
	var koPage={
			101:'회원가입'
	       ,102:'비밀번호 확인을 위해 다시 한번 입력해주세요.'
	       ,103:'여성'
	       ,104:'남성'
	       ,105:'회원가입'
	       ,106:'가입취소'
	}
	var jpPage={
			101:'会員加入'
		   ,102:'暗証番号確認を向けてもう一度入力してください。'
		   ,103:'女性'
		   ,104:'男性'
		   ,105:'会員加入'
		   ,106:'加入の取り消し'
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
					<a class="waves-effect modal-close modal-trigger sidenav-close" href="#modal3" data-langNum="13"></a>
				</li>
				<li>
					<a class="waves-effect modal-close modal-trigger sidenav-close" href="#modal2" data-langNum="14"></a>
				</li>
			</ul>
		</aside>

<!-- ************************************************************************************************************************* -->
		<section>	
			
			<div class="container">
				<div class="section">
					<h4 class="center" data-langNum2="101">회원가입</h4>
				</div>
			</div>
			<div class="col-md-6 col-md-offset-3" id="wrapper">
				<form id="joinForm" name="joinForm" action="mailSending" method="post">
					<div class="row">
						<div class="input-field col s12">
							<input type="text" id="useremail2" name="useremail"
								class="validate"> <label for="useremail2">Email</label> <span
								class="helper-text" id="emailcheck"></span>
						</div>
					</div>
		
					<div class="row">
						<div class="input-field col s12">
							<input type="text" id="usernick2" name="usernick"> 
							<label for="useremail2">Nickname</label> 
							<span class="helper-text" id="nickcheck"></span>
						</div>
					</div>
		
					<div class="row">
						<div class="input-field col s12">
							<input type="password" id="InputPassword1"> 
							<label for="useremail2">Password</label>
							<span class="helper-text" id="pwdcheck"></span>
						</div>
					</div>
					<br /><br />
					
					<div class="row">
						<div class="input-field col s12">
							<input type="password" id="InputPassword2"> 
							<label for="useremail2">Confirm Password</label> 
							<span class="helper-text" id="pwdcheck" data-langNum2="102">비밀번호 확인을 위해 다시한번 입력 해 주세요</span>
							<input type="hidden" name="userpwd" id="userpwd2" value="" />
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col s12">
							<input type="date" id="birth" name="birth"> 
							<label for="InputBirthDate">Birth</label>
						</div>
					</div>
					
					<br /> <br />
					<div class="row">
						<label for="gender">&nbsp;&nbsp;&nbsp;Gender</label>
						<p>
							<label> 
								<input class="genders" name="gender" id="female" value="f" type="radio" checked /> 
								<span data-langNum2="103">여성</span>
							</label>
						</p>
						<p>
							<label> 
								<input class="genders" name="gender" id="male" value="m" type="radio" /> 
								<span data-langNum2="104">남성</span>
							</label>
						</p>
					</div>
					<br /><br />
				<br /><br />
			
					<div class="form-group text-center" align="center">
						<button type="submit" class="btn btn-info" id="joinbtn" data-langNum2="105">
							회원가입<i class="fa fa-check spaceLeft"></i>
						</button>
						<button type="reset" class="btn btn-warning" data-langNum2="106">
							가입취소<i class="fa fa-times spaceLeft"></i>
						</button>
					</div>
				</form>
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
	<script type="text/javascript" src="js/LoginMenu.js"></script>       
</body>
</html>
