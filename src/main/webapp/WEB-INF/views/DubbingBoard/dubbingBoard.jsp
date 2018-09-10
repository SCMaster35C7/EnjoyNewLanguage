<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="zisung">
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

<!--Import Google Icon Font-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!--Import materialize.css-->
    <!--   <link href="https://cdnjs.cloudflare.com/ajax/libs/material-design-lite/1.1.0/material.min.css" rel="stylesheet"/>
       <link href="https://cdn.datatables.net/1.10.19/css/dataTables.material.min.css" rel="stylesheet"/>  -->
      <link type="text/css" rel="stylesheet" href="css/jquery.dataTables.css"  media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="css/materialize1.css"/>

<title>더빙게시판</title>

<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>	
<script>
$(document).ready(function() {
    var table = $('#dubbing').DataTable();
 
    /* $('a.toggle-vis').on( 'click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = table.column( $(this).attr('data-column') );
 
        // Toggle the visibility
        column.visible( ! column.visible() );
    } ); */
    
} );
	
	$(function(){
	 	//$('#dubbing').DataTable();
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
	});

	$(function () {
		
		$('.btnRegistDubWish').on('click', function(){
			var target = $(this);
			var useremail = "${sessionScope.useremail}";
			/* var videonum = target.parent().children("#videonum").val();
			var title = target.parent().parent().children('.card-content').children("a").html();
			var url = target.parent().children("#url").val(); */
			
			alert("title : "+title+"videonum:"+videonum+"url:"+url);
			//로그인된 세션이 있는지 확인
			if(useremail.trim().length == 0) {
				location.href="login";
				return;
			}else{
				//선택된 비디오 정보를 위시리스트로 보내기
		
				var dataFormDub = {
					"wishtable":2, 
					"useremail":useremail, 
					"title":title,			
					"url":url						
				};

				$.ajax({
					method:'post'
					, url:'insertDubwish'
					, data: JSON.stringify(dataFormDub)
					, contentType: "application/json; charset=utf-8"
					, async : false
					, success:function(resp) {
						if(resp == "success")
							alert("더빙을 찜한 목록에 등록하여습니다.");
						else if(resp == "failure")
							alert("더빙이 찜한 목록에 있습니다.");
						else if(resp == "failRegist")
							alert("더빙을 찜한 목록에 등록하는데 실패하였습니다.")
					 }	
					, error:function(resp, code, error) {
						alert("resp : "+resp+", code : "+code+", error : "+error);
					}
				});
			}
		});
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
	  
	   <!-- table -->
	  <!--start container-->
         <div class="container">
          <div class="section">
          <h4 class="center">자막검증게시판</h4>
            <!--DataTables example-->
                  <table id="dubbing">
                    <thead>
                        <tr>
                            <th>글번호</th>
                            <th>글제목</th>
                            <th>닉네임</th>
                            <th>조회수</th>
                            <th>날짜</th>
                            <th>추천</th>
                            <th>비추천</th>
                        </tr>
                    </thead>
                 
                    <tbody>
                    	<c:forEach var="dub" items="${dubbing}">
                        <tr>
                            <td>${dub.dubbingnum}</td>
                            <td><a href="dubDetail?dubbingnum=${dub.dubbingnum}"> ${dub.title} </a></td>
                            <td>${dub.usernick}</td>
                            <td>${dub.hitcount}</td>
                            <td>${dub.regdate}</td>
                            <td>${dub.recommendation}</td>
                            <td>${dub.decommendation}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
         
         	<a href="slide">슬라이드 만들거임 -다나-</a> <br/>
	
	<a href="myPage">마이페이지 만들거임 -다나-</a> <br/><br/>
	<a href="TryRetake?videoNum=9">재시험 테스트</a>
	<c:if test="${plzLogin!=null}">
		<script type="text/javascript">
			$(function(){
				alert("${plzLogin}");
			});
		</script>
	</c:if>
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
	글번호  &nbsp 글제목 &nbsp 닉넴 &nbsp 조회수 &nbsp 날짜 &nbsp 추천 &nbsp 비추천 <br/>
	<c:forEach var="dub" items="${dubbing}">
		${dub.dubbingnum} &nbsp
		 
		 <a href="dubDetail?dubbingnum=${dub.dubbingnum}"> ${dub.title} </a>
		 
		 &nbsp ${dub.usernick}  &nbsp ${dub.hitcount}  &nbsp ${dub.regdate} 
		 &nbsp ${dub.recommendation}  &nbsp ${dub.decommendation}<br/>
	</c:forEach>
	<a href="VideoSearch">더빙할 영상 찾기</a>
</body>
</html>