<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>횐가입</title>



<!-- ************************************************************************* -->


    <!-- Bootstrap -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- 글씨체 -->
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
    
    <script  src="JQuery/jquery-3.3.1.min.js"></script>
    	
    	
    	<script type="text/javascript" >
    	$(function(){
    		
    		//이메일 중복검사
    		$('#useremail').keyup(function(){
    			
    			var useremail = $(this).val();
    			
    			if (useremail.match('@')) {
    				console.log("@@@");
    				
    				$.ajax({
    						method	:	'post'
    						,url	: 'emailCheck'
    						,data	: "useremail="+useremail
    						,dataType	: 'text'
    						,success	: function(resp){
    							
    		            	 	$("#emailcheck").text(resp);
						}, error:function(resp, code, error) {
							alert("resp : "+resp+", code:"+code+", error:"+error);
						}
						
    					
    				});
    				
    				
				} else {
					$("#emailcheck").text('올바른 이메일 형식으로 해주세요~');
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
    							
    		            	 	$("#nickcheck").text(resp);
						}, error:function(resp, code, error) {
							alert("resp : "+resp+", code:"+code+", error:"+error);
						}
						
    					
    				});
    				
    				
				
    			
    			
    		});
    		
    	});
    </script>
    
	<style type="text/css">
		
		article{
				font-family: 'Nanum Gothic', sans-serif; /* 글씨체 */
		}
		
		.container{
			width: 500px;
		}
		
		.wrapper{
				
				position: relative;
				left: 25%;
			}
			
			#useremail, #InputPassword1, #InputPassword2{
				width: 400px;
			}
			
			#usernick, #birth{
				width: 200px;
			}
			
			
	</style>
		
  </head>
<body>
<article class="container">
        <div class="page-header">
          <h1>회원가입!!!  <small>basic form</small></h1>
          <hr/>
        </div>
        <div class="col-md-6 col-md-offset-3">
          <form id="joinForm" name="joinForm" action="mailSending" method="post">
         
            <div class="form-group">
              <label for="InputEmail">* 이메일 주소</label>
              <input type="text" class="form-control" id="useremail" name="useremail" placeholder="이메일 주소">
           		<p class="help-block" id="emailcheck" style="width:400px;"></p>
            </div>
            
            <div class="form-group">
              <label for="usernick">* 닉네임</label>
              <input type="text" class="form-control" id="usernick" name="usernick" placeholder="닉네임">
           		 <p class="help-block" id="nickcheck" style="width:400px;"></p>
            </div>
            
            
            <div class="form-group">
              <label for="InputPassword1">* 비밀번호</label>
              <input type="password" class="form-control" id="InputPassword1" placeholder="비밀번호">
            </div>
            <div class="form-group">
              <label for="InputPassword2">* 비밀번호 확인</label>
              <input type="password" class="form-control" id="InputPassword2" placeholder="비밀번호 확인">
              <p class="help-block" style="width:400px;">비밀번호 확인을 위해 다시한번 입력 해 주세요</p>
              <input type="hidden" name="userpwd" id="userpwd" value="1111"/>
            </div>
            
            
            <div class="form-group">
              <label for="gender">* 성별</label>
              <br/>
            <label class="btn btn-primary active">
                  <span class="fa fa-check">여자</span>
                  <input id="female" name="gender" value="f" type="checkbox" autocomplete="off" >
                  &nbsp;
                  <span class="fa fa-check">남자</span>
                  <input id="male" name="gender" value="m" type="checkbox" autocomplete="off" >
              </label>
            </div>
            
            <div class="form-group">
              <label for="InputBirthDate">* 생년월일</label>
              <input type="date" class="form-control" id="birth" name="birth">
            </div>
            
            <br/>
            
            <div class="form-group">
                <label>* 약관 동의</label>
              <div data-toggle="buttons" style="width:400px;">
              <label class="btn btn-primary active">
                  <span class="fa fa-check"></span>
                  <input id="agree" type="checkbox" autocomplete="off" >
              </label>
              <a href="#">이용약관</a>에 동의합니다.
              </div>
            </div>
            
          
        </div>
		<br/><br/>
		<div class="form-group text-center" align="center">
              <button type="submit" class="btn btn-info">회원가입<i class="fa fa-check spaceLeft"></i></button>
              <button type="reset" class="btn btn-warning">가입취소<i class="fa fa-times spaceLeft"></i></button>
            </div>
            
            
            </form>
 		</article>
 		
 		
 	<!-- <div class="container">
  <h4>메일 보내기</h4>
  <form action="mailSending" method="post">
    <div align="center">받는 사람 이메일
      <input type="text" name="tomail" size="120" style="width:100%" placeholder="상대의 이메일" class="form-control" >
    </div>     
    <div align="center">제목
      <input type="text" name="title" size="120" style="width:100%" placeholder="제목을 입력해주세요" class="form-control" >
    </div>
    <p>
    <div align="center">내용 
      <textarea name="content" cols="120" rows="12" style="width:100%; resize:none" placeholder="내용#" class="form-control"></textarea>
    </div>
    <p>
    <div align="center">
      <input type="submit" value="메일 보내기" class="btn btn-warning">
    </div>
  </form>
</div>
    <button style=" color: white;background-color: #4c586f;border: none;width:200px;height:50px;text-align: center;text-decoration: none;  font-size: 25px;border-radius:10px;">인증하기♥</button>
  --> 
  </body>
</html>
