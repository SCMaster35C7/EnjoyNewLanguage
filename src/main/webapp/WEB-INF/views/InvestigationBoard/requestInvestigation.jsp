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
	<table border="1">
		<tr>
			<th>제목</th>
			<td><input type="text" id="title"/></td>
		</tr>
		<tr>
			<th>요청 URL</th>
			<td>
				<input type="text" id="url" /> 
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="20" cols="25" id="content" ></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" id="back" value="돌아가기">
				<input type="button" id="regist" value="등록하기"> 
				<input type="reset" value="초기화"></td>
		</tr>
	</table>

	<hr/>
	 <h1 class="w100 text-center"><a href="index.html">YouTube Viral Search</a></h1>
	 <div class="row">
     	<div class="col-md-6 col-md-offset-3">
        	<form action="#">
            	<p><input type="text" id="search" placeholder="Type something..." autocomplete="off" class="form-control" /></p>
                <p><input type="button" id="searchBtn" value="Search" class="form-control btn btn-primary w100"></p>
            </form>
        	<div id="results"></div>
      	</div>
  	</div>
  	
  	<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="YoutubeAPI/search.js"></script>
	<script src="https://apis.google.com/js/client.js?onload=init"></script>
    <script>
    	$(function() {
    		$(document).keyup(function(event){
    			if(event.keyCode=='13'){
    				if($('#search').val().length == 0) {
           				alert("검색어를 입력하세요.");
           				$('#search').focus();
           				return;
           			}
            		init();
            		search();
    			}
    		});  		
    		
       		$("#searchBtn").on('click', function() {
       			if($('#search').val().length == 0) {
       				alert("검색어를 입력하세요.");
       				$('#search').focus();
       				return;
       			}

        		init();
        		search();
        	});
       		
       		$("#regist").on('click', function() {
	       		var title = $("#title");
	       		if(title.val().trim().length == 0) {
	       			alert("제목을 입력해주세요.");
	       			title.focus();
	       			return;
	       		}
	       		
	       		var url = $("#url");
	       		if(url.val().trim().length == 0) {
	       			alert("URL을 입력해주세요.");
	       			url.focus();
	       			return;
	       		}
	       		var content = $('#content').val();
	       		
	       		var originalURL = url.val();				// 원본 URL
	       		var markIndex = originalURL.indexOf("?");	// GET방식 인자를 제외한 실제 주소
	       		var findVideoId = "";
	       		
	       		if(markIndex == -1) {
	       			if(originalURL.includes("embed") == false) {
	       				alert("Youtube Video URL을 제대로 입력해주세요.");
	       				return;
	       			}
	       			
	       			var embedIndex = originalURL.indexOf("embed")+6;
	       			findVideoId = originalURL.substring(embedIndex);	//iframe에서 선택시 VideoId추출
	       		}else {
	       			if(originalURL.includes("youtube.com") == false) {
	       				alert("URL을 제대로 입력해주세요.");
	       				return;
	       			}
	       			https://www.youtube.com/watch?v=XfjXGXVnp8E
	       			var vIndex = originalURL.indexOf("v=")+2;
	       			var firstAmpIndex = originalURL.substring(vIndex).indexOf("&");
	       			
	       			if(firstAmpIndex == -1) {
	       				findVideoId = originalURL.substring(vIndex);
	       				alert(findVideoId);
	       			}else {
	       				findVideoId = originalURL.substring(vIndex+firstAmpIndex, firstAmpIndex);
	       			}
	       		}
	       		
	       		//$('#videoId').val(findVideoId);
       			// alert($('#videoId').val());
				
       			var dataForm = {
       				"useremail":"${sessionScope.useremail}",
       				"title":title.val(),
       				"url":findVideoId,
       				"content":content
       			};
       			alert(JSON.stringify(dataForm));
       			
				$.ajax({
					method:'post'
					, url: 'requestInvestigation'
					, data: JSON.stringify(dataForm)
					, dataType: "json"
					, contentType:"application/json; charset=utf-8"
					, success:function(resp) {
						
						if(resp.result == "success") {
							location.href="InvestigationBoard";
						}else if(resp.result == "failure") {
							if(confirm("이미 자막 요청된 영상입니다. 해당 영상으로 이동하시겠습니까?")) {
								location.href = "detailInvBoard?investigationnum="+resp.investigationnum;
							}
						}
					}
					, error:function(resp, code, error) {
						alert("resp : "+resp+", code : "+code+", error : "+error);
					}
				});
       		});
        });
	</script>
</body>
</html>