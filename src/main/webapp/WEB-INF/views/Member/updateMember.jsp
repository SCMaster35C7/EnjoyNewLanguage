<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Enjoy Language</title>
</head>
<body>	

<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
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
						/* if(resp=='true'){
							$("#nickcheck").text("사용가능!!!!! 아이디입니다.");
						}else{
							$("#nickcheck").html('<span style="color: red; font-weight: bold;">중복된 아이디입니다.</span>');
						}  */
						
	            	 	
				}, error:function(resp, code, error) {
					alert("resp : "+resp+", code:"+code+", error:"+error);
				}    					
			});    			
	});
	
	$('#btnUpdate').on('click', function(){
		
		var usernick = $("#usernick").val();
		var nickcheck = $("#nickcheck").text();
		
		$pattern = '^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';			
		
		
		if (nickcheck.length<=0||nickcheck=='중복된 닉네임 입니다') {
				alert('닉네임 다시 한 번 확인해주세요');
				$("#usernick").select();
				$("#usernick").focus();
				return;
		}
		
		if($('#currpwd').val() == $('#newpwd').val()){
			alert('새로입력한 비밀번호와 현재 비밀번호가 달라야 합니다.');
			return;
		}
		
		if($('#newpwd').val() != $('#checkpwd').val()){
			alert('새로입력한 비밀번호와 비밀번호 확인 값은 같아야 합니다.');
			return;
		}
		
		if($('#newpwd').val().match($pattern)){
			
			alert('비밀번호 수정이 완료되었습니다. 다시 로그인해주세요');
			
		} else {
			alert('비밀번호는 대/소문자, 숫자, 특수 문자 포함, 8자 이상');
		
			return;
		}
		
		$('#updateMember').submit();
	
	});
	
	$('#btnCancel').on('click', function(){
		
		location.href = "${pageContext.request.contextPath}/"
	});
	
});
</script>
<c:if test="${not empty msg}">
<script>
$(function(){
	alert("${msg}");
	location.href = "${pageContext.request.contextPath}/";
	
});
</script>
</c:if>

</head>
<body>
	<h1>회원정보수정</h1>
	<form id="updateMember" action="updateMember" method="post">
	<table border="1" >
		<tr>
			<td>아이디[이메일] :</td>
			<td>${sessionScope.useremail}</td>
		</tr>
		
		<tr>
			<td>닉네임 :</td>
			<td>${sessionScope.usernick}</td>
		</tr>
		
		<tr>
			<td>바꿀 닉네임</td>
			<td><input type="text" id="usernick" name="usernick" placeholder="바꿀 닉네임을 입력" />
			&nbsp;&nbsp;<span id="nickcheck"></span>&nbsp;&nbsp; 
			</td>
		</tr>
		 
		<tr>
			<td>현재 비밀번호 :</td>
			<td><input id="currpwd" type="password" name="currpwd" placeholder="현재 비밀번호 입력" /></td>
		</tr>
		
		<tr>
			<td>새 비밀번호 입력 :</td>
			<td><input id="newpwd" type="password" name="newpwd" placeholder="새 비밀번호 입력" /></td>
		</tr>
		<tr>
			<td>새 비밀번호 확인 :</td>
			<td><input id="checkpwd" type="password"  placeholder="새 비밀번호 확인" /></td>
		</tr>
		
		<tr>
			<td>성별 :</td>
			<td>${sessionScope.gender}</td>
		</tr>

		<tr>
			<td>생일 :</td>
			<td>${sessionScope.birth}</td>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
			<input type="button" value="수정" id="btnUpdate" />
			<input type="button" value="취소" id="btnCancel" />
			</td>			
		</tr>
	</table>	
	</form>

</body>
</html>