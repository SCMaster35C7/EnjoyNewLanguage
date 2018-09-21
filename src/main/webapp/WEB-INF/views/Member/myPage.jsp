<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="author" content="zisung">
   <!--Import Google Icon Font-->
   <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
   <!--Import materialize.css-->
   <link type="text/css" rel="stylesheet" href="css/materialize1.css"  media="screen,projection"/>
	
	<style type="text/css">
		.tabWrap { width: 900px; height: 500px; }
    	.tab_Menu { margin: 0px; padding: 0px; list-style: none; }
    	.tabMenu { width: 150px; margin: 0px; text-align: center;
               padding-top: 10px; padding-bottom: 10px; float: left; }
        .tabMenu a { color: #000000; font-weight: bold; text-decoration: none; }
    	.current { background-color: #FFFFFF;
               border: 1px solid blue; border-bottom:hidden; }
    	.tabPage { width: 900px; height: 400px; float: left;
               border: 1px solid blue; }
	</style>
   <!--Let browser know website is optimized for mobile-->
   <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
   
   <title  data-langNum2="201"></title>
   <script type="text/javascript" src="js/Chart.js"></script>
   <script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
   <script type="text/javascript" src="js/LanguageSet.js"></script>
   <script>
      $(function() {
    	  SetLanguage();
       /*   $('select').formSelect(); */
         
         //dropdown
         $(".dropdown-trigger").dropdown();
         
         //floating actionbutton
         $(".fixed-action-btn").floatingActionButton({
            /* direction:'left' */
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
      });
      
      function tabSetting() {
  	  	// 탭 컨텐츠 hide 후 현재 탭메뉴 페이지만 show
  	    $('.tabPage').hide();
  	    $($('.current').find('a').attr('href')).show();
  	 
  	    // Tab 메뉴 클릭 이벤트 생성
  	    $('.moveWishList').click(function (event) {
  		    var tagName = event.target.tagName; // 현재 선택된 태그네임
  		    var selectedLiTag = (tagName.toString() == 'A') ? $(event.target).parent('li') : $(event.target); // A태그일 경우 상위 Li태그 선택, Li태그일 경우 그대로 태그 객체
  		    var currentLiTag = $('li[class~=current]'); // 현재 current 클래스를 가진 탭
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
   </script>
    <script>
    var koPage={
    		101:'님의 마이페이지'	
    	   ,102:'레벨별 성취도'
    	   ,103:'승률'
    	   ,104:'승'
    	   ,105:'패'
    	   ,106:'도전'
    	   ,107:'데이터가 없습니다.'
    	   ,108:'보고있는 영상'
    	   ,109:'학습중인 영상이 없습니다.'
    	   ,110:'학습완료한 영상'
    	   ,111:'재시험'
    	   ,112:'학습중인 영상이 없습니다.'
    	   ,201:'마이페이지'
    }
    var jpPage={
    		101:'のマイページ'
    	   ,102:'レベル別の達成度'
    	   ,103:'勝率'
    	   ,104:'勝'
    	   ,105:'敗'
    	   ,106:'挑戦'
    	   ,107:'データがありません。'
    	   ,108:'見ている映像'
    	   ,109:'学習中の映像がありません。'
    	   ,110:'学習完了した映像'
    	   ,111:'再試験'
    	   ,112:'学習中の映像がありません。'
    	   ,201:'マイページ'
    }
    
    function languageChange_Page(lang){
		if(lang=='kor'){
			$('[data-langNum2]').each(function() {
			    var $this = $(this); 
			    $this.html(koPage[$this.data('langnum2')]); 
			});
			$('#checkForm').attr('value','영상등록');
			$('#reputin').attr('value','재입력');
			$('#urlCheck').attr('value','중복 확인');
			
		}else if(lang=='jp'){
			$('[data-langNum2]').each(function() {
			    var $this = $(this); 
			    $this.html(jpPage[$this.data('langnum2')]); 
			});
			$('#checkForm').attr('value','映像登録');
			$('#reputin').attr('value','再入力');
			$('#urlCheck').attr('value','重複確認');
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


      <section>
         <br />
         <div class="container">
            <h4>${usernick}<span data-langNum2="101"></span></h4>
            <br />
            <div class="row">
               <div class="col s12 m6 l6">
                  <div class="card">
                     <div class="waves-effect waves-block waves-light">
                        <h5 data-langNum2="102">레벨별 성취도</h5>
                        <div class="trending-line-chart-wrapper">
                           <canvas id="myChart"></canvas>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="col s12 m6 l6">
                  <div class="card">
                     <div class="waves-effect waves-block waves-light">
                        <span> <c:if test="${myInfo!=null }">
                              <div align="center">
                                 <h5><span data-langNum2="103"></span> : ${myInfo.winningRate}% (<span data-langNum2="104"></span> :
                                    ${myInfo.allSuccess}/ <span data-langNum2="105"></span> : ${myInfo.allFailure}/ <span data-langNum2="106"></span>:
                                    ${myInfo.allChallenge})</h5>
                              </div>
                           </c:if> <c:if test="${myInfo==null }">
                                    <span data-langNum2="107"></span> 
                                    <br />
                           </c:if>
                        </span>
                        <div class="trending-line-chart-wrapper">
                           <canvas id="circle"></canvas>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            
            <div class="row">
				<div class="tabWrap">
				    <ul class="tab_Menu">
				        <li class="tabMenu current moveWishList">
				            <a href="#tabContent01" >영상</a>
				        </li>
				        <li class="tabMenu moveWishList">
				            <a href="#tabContent02" >자막</a>
				        </li>
				        <li class="tabMenu moveWishList">
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
            </div>
            
             <div class="row" >
               <div id="table1" class="col s12 m6 l6">
                  <table class="highlight">
                     <thead>
                        <tr>
                              <th data-langNum2="108">보고있는 영상</th>
                                 <td class="right">
                                    <div class="center">
                                       <ul class="pagination">
                           
                                       <li class="waves-effect">
                                          <a href="myPage?currentPage=${unfinishedfinishedNavi.currentPage - 1}"> 
                                             <i class="material-icons">chevron_left</i>
                                          </a>
                                       </li>
                           
                                       <c:forEach var="page" begin="${unfinishedNavi.startPageGroup}" end="${unfinishedNavi.endPageGroup}" step="1">
                                          <c:if test="${unfinishedNavi.currentPage == page }">
                                             <li class="page-item active"><a class="page-link">${page}</a></li>
                                          </c:if>
                                          <c:if test="${unfinishedNavi.currentPage != page }">
                                             <li class="page-item"><a class="page-link"
                                                href="myPage?currentPage=${page}">${page}</a></li>
                                          </c:if>
                                       </c:forEach>
                           
                                       <li class="waves-effect">
                                          <a href="myPage?currentPage=${unfinishedNavi.currentPage + 1}">
                                             <i class="material-icons">chevron_right</i> 
                                          </a>
                                       </li>
                                       </ul>
                                 </div>
                                 </td>
                        </tr>
                     </thead>
                     <tbody>
                        <c:if test="${not empty unfinished}">
                           <c:forEach var="nf" items="${unfinished}">
                              <tr>
                                 <td><a href="detailEduBoard?videoNum=${nf.videoNum}">${nf.title}</a></td>
                              </tr>
                           </c:forEach>
                        </c:if>
                        <c:if test="${empty unfinished}">
                           <td data-langNum2="109">학습중인 영상이 없습니다.</td>
                        </c:if>
                     </tbody>
                  </table>
               </div>
               
                  <section>   
               <div class="col s12 m6 l6">
               <div id="table2">
                  <table class="highlight">
                     <thead>
                        <tr>
                           <th data-langNum2="110">학습완료 한 영상</th>
                           <td class="right">
                              <div class="center">
                           <ul class="pagination">

                           
                              <li class="waves-effect">
                                 <a href="myPage?currentPage=${finishedNavi.currentPage - 1}"> 
                                    <i class="material-icons">chevron_left</i>
                                 </a>
                              </li>
                           
                              <c:forEach var="page" begin="${finishedNavi.startPageGroup}" end="${finishedNavi.endPageGroup}" step="1">
                                 <c:if test="${finishedNavi.currentPage == page }">
                                    <li class="page-item active"><a class="page-link">${page}</a></li>
                                 </c:if>
                                 <c:if test="${finishedNavi.currentPage != page }">
                                    <li class="page-item"><a class="page-link"
                                       href="myPage?currentPage=${page}">${page}</a></li>
                                 </c:if>
                              </c:forEach>
                           
                              <li class="waves-effect">
                                 <a href="myPage?currentPage=${finishedNavi.currentPage + 1}">
                                    <i class="material-icons">chevron_right</i> 
                                 </a>
                              </li>
                           
                           </ul>
                        </div>
                           </td>
                        </tr>
                     </thead>
                     <tbody>
                        <c:if test="${not empty finished}">
                           <c:forEach var="f" items="${finished}">
                              <tr>
                                 <td><a href="detailEduBoard?videoNum=${f.videoNum}">${f.title}</a></td>
                                 <td><a href="TryRetake?videoNum=${f.videoNum}"
                                    class="waves-effect waves-light btn right" data-langNum2="111"></a></td>
                              </tr>
                           </c:forEach>
                        </c:if>

                        <c:if test="${empty finished}">
                           <td data-langNum2="112">학습중인 영상이 없습니다.</td>
                        </c:if>
                     </tbody>
                  </table>
               </div>
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
   <script>
      //chart.js
      var ctx = document.getElementById("myChart");
       var myChart = new Chart(ctx, {
             type: 'bar',
             data: {
                 labels: ["lv.1", "lv.2", "lv.3", "lv.4", "lv.5"],
                 datasets: [{
                     data:${levelArray},
                     backgroundColor: [
                         'rgba(255, 99, 132, 0.2)',
                         'rgba(54, 162, 235, 0.2)',
                         'rgba(255, 206, 86, 0.2)',
                         'rgba(75, 192, 192, 0.2)',
                         'rgba(153, 102, 255, 0.2)'
                     ],
                     borderColor: [
                         'rgba(255,99,132,1)',
                         'rgba(54, 162, 235, 1)',
                         'rgba(255, 206, 86, 1)',
                         'rgba(75, 192, 192, 1)',
                         'rgba(153, 102, 255, 1)'
                     ],
                     borderWidth: 1
                 }]
             },
             options: {
                legend: {
                   display: false
                      },
                 scales: {
                     yAxes: [{
                         ticks: {
                             beginAtZero:true
                         }
                     }]
                 }
             }
         });
       
       var ctx2 = document.getElementById("circle");
       var circle = new Chart(ctx2, {
             type: 'doughnut',
             data: {
                labels: ["Win", "Lose"],
                datasets: [{
                    data: ${winningRate},
                    backgroundColor: [
                         'rgba(54, 162, 235, 0.2)',
                         'rgba(255, 99, 132, 0.2)'
                     ],
                     borderColor: [
                         'rgba(54, 162, 235, 1)',
                         'rgba(255, 99, 132, 1)'
                     ],
                     borderWidth: 1
                }]
                
             }
         });
   </script>   
</body>
</html>