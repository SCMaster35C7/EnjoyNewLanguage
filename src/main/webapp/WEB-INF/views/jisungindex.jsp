<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <title>main</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">



    <!-- 스타일 -->
    <link href="css/bootstrap-ko.css" rel="stylesheet">
    
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
        
      }
      
      .box1{
      	width : 200px;
      	padding:20px;
    
      	margin-right:10px;
      	background:yellow;
      	float:left;
      }
      
      .box2{
      	padding:20px;
      	margin-right:10px;
      	background:red;
      	float:left;
      }
      .box3{
      	padding:20px;
      	margin-right:10px;
      	background:blue;
      	float:left;
      }
      
      .box4{
      	width:800px;
      	padding:20px;
      	margin-right:10px;
      	background:pink;
      	float: right;
      }
      
     #hi{
     	clear:both;
     	margin : 0 auto;
     	text-align : right;
     	background : black;
     	color : white;
     }
     
   	 .left{
   	 	diplay : inline-block;
   	 	margin : 20px;
   	 	text-align:left;
   	 }	
     .right{
     
     	display : inline-block;     	
     	margin : 20px;
     	
     }
    </style>
    <!-- 화면넓이 -->
    <link href="css/bootstrap-responsive.css" rel="stylesheet">

    <!-- IE6~8에서 HTML5 태그를 지원하기위한 HTML5 shim -->
    <!--[if lt IE 9]>
      <script src="../assets/js/html5shiv.js"></script>
    <![endif]-->

    <!-- 파비콘과 앱 아이콘 -->
  
  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">프로젝트명</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="#">대문</a></li>
              <li><a href="#about">소개</a></li>
              <li><a href="#contact">연락처</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">드롭다운 <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="#">행동</a></li>
                  <li><a href="#">다른 행동</a></li>
                  <li><a href="#">여기에는 또 다른</a></li>
                  <li class="divider"></li>
                  <li class="nav-header">탐색 제목</li>
                  <li><a href="#">따로 떨어진 링크</a></li>
                  <li><a href="#">따로 떨어진 링크 하나 더</a></li>
                </ul>
              </li>
            </ul>
            <form class="navbar-form pull-right">
              <input class="span2" type="text" placeholder="이메일">
              <input class="span2" type="password" placeholder="암호">
              <button type="submit" class="btn">로그인</button>
            </form>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">

      <!-- 핵심 마케팅 문구나 공고를 위한 히어로 유닛 -->
      <div class="hero-unit">
        <h1>헬로우, 월드!</h1>
        <p>간단한 마케딩이나 정보 웹사이트를 위한 틀이다. 히어로 유닛이라는 커다란 공간과 세가지 부수적인 내용이 들어있다. 여러분 고유의 웹사이트를 만들 출발점으로 활용하라.</p>
        <p><a href="#" class="btn btn-primary btn-large">더 알아보기 <span class="en-font-family">&raquo;</span></a></p>
      </div>

      <!-- 열들이 있는 행 예제 -->
      <div class="row">
        <div class="span4">
          <h2>제목</h2>
          <p>보건복지가족부장관 또는 시·도지사는 이 법에 따른 권한의 일부를 대통령령으로 정하는 바에 따라 시·도지사 또는 시장·군수·구청장에게 위임할 수 있다. 필요시 보육시설 유형과 지역적 여건을 고려하여 그 기준을 다르게 정할 수 있다. </p>
          <p><a class="btn" href="#">자세히 보기 <span class="en-font-family">&raquo;</span></a></p>
        </div>
        <div class="span4">
          <h2>제목</h2>
          <p>보건복지가족부장관 또는 시·도지사는 이 법에 따른 권한의 일부를 대통령령으로 정하는 바에 따라 시·도지사 또는 시장·군수·구청장에게 위임할 수 있다. 필요시 보육시설 유형과 지역적 여건을 고려하여 그 기준을 다르게 정할 수 있다. </p>
          <p><a class="btn" href="#">자세히 보기 <span class="en-font-family">&raquo;</span></a></p>
       </div>
        <div class="span4">
          <h2>제목</h2>
          <p>국가나 지방자치단체는 국공립보육시설을 설치·운영하여야 한다. 이 경우 국공립보육시설은 제11조의 보육계획에 따라 도시 저소득주민 밀집 주거지역 및 농어촌지역 등 취약지역에 우선적으로 설치하여야 한다. 자격을 검정하고 자격증을 교부하여야 한다.</p>
          <p><a class="btn" href="#">자세히 보기 <span class="en-font-family">&raquo;</span></a></p>
        </div>
      </div>

      <hr>
      
      <!-- 행 칸 크기 실험  -->
      <div class="row">
      	<div class="span4">4</div>
      	<div class="span8">8</div>
      	<div class="span4">4</div>
      	<div class="span4 offset4">4</div>
      </div>

      <footer>
        <p>&copy; 회사 2013</p>
      </footer>

    </div> <!-- /container -->
    
    <div class="box1">박스1 </div>
    <div class="box2">박스2 </div>
    <div class="box3">박스3 </div>
    
    <div class="box4">박스4 </div>
    
    <div id="hi">
    <nav>
    
    	<ul>
    		<li class="left">하이</li>
    		<li class="right">안녕</li>
    		<li  class="right">이건</li>
    		<li class="right">네비</li>
    		<li class="right"><span>게이터</span></li> 
    	</ul>
    </nav>
    </div>

    <!-- 자바스크립트
    ================================================== -->
    <!-- 페이지를 빨리 읽어들이도록 문서 마지막에 배치 -->
    <script type="text/javascript" src="script/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
  </body>
</html>
