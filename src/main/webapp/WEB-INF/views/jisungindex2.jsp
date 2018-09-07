<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="jisung" content="plztackle@naver.com"/>
<style type="text/css">
	body{
		margin:0 auto;
	}
	
	#navigator{
		height:30px;
		width:850px;
	}
	#navigator ul {
		list-style:none;
		margin:0px;
		padding:0px;
	}
	
	#navigator ul li{
		color:white;
		background-color:black;
		float:left;
		line-height:30px;
		vertical-align:middle;
		text-align:center;
		-position:relative;
	}
	.navilink, .submenu-link{
		text-decoration:none;
		display:block;
		width:150px;
		font-size:12px;
		font-weight:bold;
		font-family:"Trebuchet MS", Dotum, Arial;
	}
	.navilink{
		color:white;
	}
	.navimenu:hover .navilink {
		color:yellow;
		background-color:grey;
	}
	
	.submenu-link{
		color: black;
		background-color: grey;
		
		margin-top: -1px;
	}
	.submenu {
		position:absolute;
		height:0px;
		overflow:hidden;
		-webkit-transition:height .2s;
		-moz-transition:height .2s;
		-o-transtion:height .2s;
	}
	.navimenu:hover .submenu{
		height:93px;
	}
	.submenu-link:hover{
		color:yellow;
		background-color:black;
	}
	.loginmenu{
		position:absolute;
		height:0px;

		overflow:hidden;
		margin-top:-1px;
		transition-property:height 0.2s;
		 
		 
		-webkit-transition:height .2s;
		-moz-transition:height .2s;
		-o-transition:height .2s;  
		width:850px;
		
		
	}
	.loginmenu li{
		display:inline-block;
	}
	
	#login:hover .loginmenu{
		
		height:60px;
	}
	
	
</style>

<title>만들어보자</title>
</head>
<body>
	
	<nav id="navigator">
		<ul>
			<li class="navimenu">
				<a class="navilink" href="#">공부게시판</a>
			</li>
			<li class="navimenu">
				<a class="navilink" href="#">더빙게시판</a>
			</li>
			<li class="navimenu">
				<a class="navilink" href="#">검증게시판</a>
			</li>
			<li id="login" class="navimenu">
				<a class="navilink" href="#">로그인</a>
				<ul class="loginmenu">
					<li>
						<input class="login" type="text" placeholder="E-Mail">
						<input class="login" type="password" placeholder="password">
					</li>
				</ul>
			</li>
			<li class="navimenu">
				<a class="navilink" href="#">마이페이지</a>
				<ul class="submenu">
					<li><a class="submenu-link" href="#">찜 목록</a></li>
					<li><a class="submenu-link" href="#">내 더빙</a></li>
					<li><a class="submenu-link" href="#">포인트조회</a></li>
				</ul>
			</li>
		</ul>
	</nav>
	
	<h2>네비만드는중</h2>
</body>
</html>