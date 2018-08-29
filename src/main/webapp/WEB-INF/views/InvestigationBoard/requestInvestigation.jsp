<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자막 요청 게시글 작성</title>
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	<form action="requestInvestigation" method="post" id="reqForm">
		<table border="1">
			<tr>
				<th>제목</th>
				<td>
					<input type="text" id="title" name="title"/>
				</td>
			</tr>
			<tr>
				<th>요청 URL</th>
				<td>
					<input type="text" id="url" name="url"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="20" cols="25" id="content" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button id="back">돌아가기</button>
					<input type="submit" value="등록하기">
					<input type="reset" value="초기화">
				</td>
			</tr>
		</table>
	</form>
	
	<hr/>
	 <h1 class="w100 text-center"><a href="index.html">YouTube Viral Search</a></h1>
	 <div class="row">
     	<div class="col-md-6 col-md-offset-3">
        	<form action="#">
            	<p><input type="text" id="search" placeholder="Type something..." autocomplete="off" class="form-control" /></p>
                    <p><input type="submit" id="sea" value="Search" class="form-control btn btn-primary w100"></p>
            </form>
        	<div id="results"></div>
      	</div>
  	</div>
  	
  	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="YoutubeAPI/search.js"></script>
	<script src="https://apis.google.com/js/client.js?onload=init"></script>
    <script>
    	$(function() {
       		$("#sea").on('click', function() {
        		init();
        		search();
        	});
        });
	</script>
</body>
</html>