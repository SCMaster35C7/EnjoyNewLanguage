<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="zisung">
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="css/materialize1.css"  media="screen,projection"/>
   
<title>Enjoy Language</title>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

   function tabSetting() {
        // 탭 컨텐츠 hide 후 현재 탭메뉴 페이지만 show
        $('.tabPage').hide();
        $($('.current').find('a').attr('href')).show();
 
        // Tab 메뉴 클릭 이벤트 생성
        $('li').click(function (event) {
            var tagName = event.target.tagName; // 현재 선택된 태그네임
            var selectedLiTag = (tagName.toString() == 'A') ? $(event.target).parent('li') : $(event.target); // A태그일 경우 상위 Li태그 선택, Li태그일 경우 그대로 태그 객체
            var currentLiTag = $('li[class~=current]'); // 현재 current 클래그를 가진 탭
            var isCurrent = false; 
             
            // 현재 클릭된 탭이 current를 가졌는지 확인
            isCurrent = $(selectedLiTag).hasClass('current');
             
            // current를 가지지 않았을 경우만 실행
            if (!isCurrent) {
                $($(currentLiTag).find('a').attr('href')).hide();
                $(currentLiTag).removeClass('current');
 
                $(selectedLiTag).addClass('current');
                $($(selectedLiTag).find('a').attr('href')).show();
            }
 
            return false;
        });
    }
 
    $(function () {
        // 탭 초기화 및 설정
        tabSetting();
    });
    //iframe 크기 조절관련 제이쿼리
    $(function(){
    	$("iframe.myFrame").load(function(){ //iframe 컨텐츠가 로드 된 후에 호출됩니다.
    		var frame = $(this).get(0);
    		var doc = (frame.contentDocument) ? frame.contentDocument : frame.contentWindow.document;
    		$(this).height(doc.body.scrollHeight);
    		$(this).width(doc.body.scrollWidth);
    	});
    });
/*     //위시리스트 탭 클릭시 ajax 작동
    $(function(){
    	$("iframe.myFrame").load(function(){ //iframe 컨텐츠가 로드 된 후에 호출됩니다.
    		var frame = $(this).get(0);
    		var doc = (frame.contentDocument) ? frame.contentDocument : frame.contentWindow.document;
    		$(this).height(doc.body.scrollHeight);
    		$(this).width(doc.body.scrollWidth);
    	
    		$.ajax{
    			URL	: "subWish"
    			data : ""
    			type : ""
    		}
    	});
    });
 */
</script>

<style type="text/css">
.tabWrap { width: 900px; height: 500px; }
    .tab_Menu { margin: 0px; padding: 0px; list-style: none; }
    .tabMenu { width: 150px; margin: 0px; text-align: center;
               padding-top: 10px; padding-bottom: 10px; float: left; }
        .tabMenu a { color: #000000; font-weight: bold; text-decoration: none; }
    .current { background-color: #FFFFFF;
               border: 1px solid blue; border-bottom:hidden; }
    .tabPage { width: 900px; height: 470px; float: left;
               border: 1px solid blue; }
</style>
</head>
<body>
<h2>[${sessionScope.useremail}(${sessionScope.usernick})님의 위시리스트]</h2>

<div class="tabWrap">
    <ul class="tab_Menu">
        <li class="tabMenu current">
            <a href="#tabContent01" >영상</a>
        </li>
        <li class="tabMenu">
            <a href="#tabContent02" >자막</a>
        </li>
        <li class="tabMenu">
            <a href="#tabContent03" >더빙</a>
        </li>
    </ul>
    <div class="tab_Content_Wrap">
        <div id="tabContent01" class="tabPage">
			<iframe style="width: 100%; height: 100%;" src="http://localhost:9999/Youtube/particularList?wishtable=0&useremail=${sessionScope.useremail}&distinguishNum=1" class="myFrame">
  				<p>크롬으로 실행해야 제대로 화면에 표시됩니다.</p>
			</iframe>			
        </div>
        <div id="tabContent02" class="tabPage">
           <iframe style="width: 100%; height: 100%;" src="http://localhost:9999/Youtube/particularList?wishtable=1&useremail=${sessionScope.useremail}&distinguishNum=2" class="myFrame">
  				<p>크롬으로 실행해야 제대로 화면에 표시됩니다.</p>
			</iframe>
        </div>
        <div id="tabContent03" class="tabPage">
            <iframe style="width: 100%; height: 100%;" src="http://localhost:9999/Youtube/particularList?wishtable=2&useremail=${sessionScope.useremail}&distinguishNum=3" class="myFrame">
  				<p>크롬으로 실행해야 제대로 화면에 표시됩니다.</p>
			</iframe>
        </div>
    </div>
</div>   
</head>
</html>