<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script>
		$(function() {
			$('#checkForm').on('click', function() {
				var title = $('#title');
				var url = $('#url');
				var subtitle = $('#subtitle');
				
				if(title.val().trim().length == 0) {
					alert('영상 제목을 입력해주세요.');
					title.focus();
					return false;
				}
				
				if(url.val().trim().length == 0) {
					alert('영상 URL을 입력해주세요.');
					url.focus();
					return false;
				}
				
				
				if(subtitle.val().trim().length == 0) {
					alert('파일을 넣어주세요.');
					subtitle.focus();
					return false;
				}
				
				return true;
			});
		});
	</script>
</head>
<body>
	<h2>[Education Video 삽입]</h2>
	
	<form action="addEduVideo" method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>영상 제목 입력</td>
				<td><input type="text" id="title" name="title"/></td>
			</tr>
			<tr>
				<td>URL 입력</td>
				<td>
					<input type="text" id="url" name="url"/>
					<input type="button" id="urlCheck" value="중복 확인"/>	
				</td>
			</tr>
			<tr>
				<td>자막 파일 등록</td>
				<td><input type="file" id="subtitle" name="subtitle"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" id="checkForm" value="영상 등록"/>
					<input type="reset" value="전체 재입력"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>