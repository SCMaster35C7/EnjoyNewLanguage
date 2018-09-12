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
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>


<!-- ************************************************************************* -->
    	
    	<script type="text/javascript" >
    	$(function(){
    		
    		//기본와꾸
    		$('select').formSelect();
			
			//dropdown
			$(".dropdown-trigger").dropdown();
			
			//floating actionbutton
			$(".fixed-action-btn").floatingActionButton({
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
    		
    		
    		//이메일 중복검사
    		$('#useremail2').keyup(function(){
    			
    			var useremail = $(this).val();
    			
    			if (useremail.match('@')) {
    				console.log("@@@");
    				
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
			$('#usernick').keyup(function(){
    			
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
									$('#usernick').attr("style", "border-bottom: 1px solid red;-webkit-box-shadow: 0 1px 0 0 red; box-shadow: 0 1px 0 0 red;");
								}else if (resp=="사용 가능한 닉네임 입니다") {
    		            	 		$("#nickcheck").text(resp);
    		            	 		$("#nickcheck").attr("data-success","사용 가능한 이메일 입니다");
    		            	 		$("#nickcheck").removeAttr("data-error");
    		            	 		$('#usernick').attr("style", "border-bottom: 1px solid green;-webkit-box-shadow: 0 1px 0 0 green; box-shadow: 0 1px 0 0 green;");
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
    					 }
    				 
    				 else {
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
    <style type="text/css">
    	#wrapper{
    		width: 500px;
    		margin: auto;
    	}
    </style>
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
						<div class="input-field col s12">
							<i class="material-icons prefix">mail</i>
							<input id="useremail" type="text" class="validate" name="useremail" value="${useremail}">
							<label for="useremail">EMAIL</label>
						</div>
					</div>
				
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">mode_edit</i>
							<input id="userpwd" type="password" class="validate" name="userpwd" value="${userpwd}">
							<label for="userpwd">PASSWORD</label>
						</div>
					</div>
				</div>	
				
					<div class="row">
						<div class="col s10">
							<span class="flow-text">
								<button class="btn waves-effect waves-light" type="button" id="loginBtn">ENTER
									<i class="material-icons right">send</i>
								</button>
							</span>
						
							<span class="flow-text">
								<button class="btn waves-effect waves-light modal-close" id="back" type="button">BACK
									<i class="material-icons right">keyboard_return</i>
								</button>
							</span>
							
							<span class="flow-text">
								<button class="btn waves-effect waves-light modal-close">LOGOUT
									<i class="material-icons right">settings_power</i>
								</button>
							</span>
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

<!-- ************************************************************************************************************************* -->

	<div class="container">
		<div class="section">
			<h4 class="center">회원가입</h4>
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
					<input type="text" id="usernick" name="usernick"> <label
						for="useremail2">Nickname</label> <span class="helper-text"
						id="nickcheck"></span>
				</div>
			</div>

			<div class="row">
				<div class="input-field col s12">
					<input type="password" id="InputPassword1"> <label
						for="useremail2">Password</label> <span class="helper-text"
						id="pwdcheck"></span>
				</div>
			</div>

			<div class="row">
				<div class="input-field col s12">
					<input type="password" id="InputPassword2"> <label
						for="useremail2">Confirm Password</label> <span
						class="helper-text" id="pwdcheck">비밀번호 확인을 위해 다시한번 입력 해 주세요</span>
					<input type="hidden" name="userpwd" id="userpwd2" value="" />
				</div>
			</div>

			<br /> <br />
			<div class="row">
				<label for="gender">&nbsp;&nbsp;&nbsp;Gender</label>
				<p>
					<label> <input class="genders" name="gender" id="female"
						value="f" type="radio" checked /> <span>여성</span>
					</label>
				</p>
				<p>
					<label> <input class="genders" name="gender" id="male"
						value="m" type="radio" /> <span>남성</span>
					</label>
				</p>
			</div>

			<br />
			<br />
			<div class="row">
				<div class="input-field col s12">
					<input type="date" id="birth" name="birth"> <label
						for="InputBirthDate">Birth</label>
				</div>
			</div>

			<br />
	</div>
	<br />
	<br />
	<div class="form-group text-center" align="center">
		<button type="submit" class="btn btn-info" id="joinbtn">
			회원가입<i class="fa fa-check spaceLeft"></i>
		</button>
		<button type="reset" class="btn btn-warning">
			가입취소<i class="fa fa-times spaceLeft"></i>
		</button>
	</div>
	</form>

	<br/>
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
  	<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="js/materialize.min.js"></script>       
  </body>
</html>
