<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>영상 검색</title>
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	
	<input type="hidden" id="url" /> 

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
    var pageName='VideoSearch';
    	$(function() {
       		$("#searchBtn").on('click', function() {
       			if($('#search').val().length == 0) {
       				alert("검색어를 입력하세요.");
       				$('#search').focus();
       				return;
       			}

        		init();
        		search();
        	});
         	
       		
        });
    	
    	function DubbingWrite(){
   			var originalURL = $('#url').val();				// 원본 URL
       		var findVideoId = "";
       		var embedIndex = originalURL.indexOf("embed")+6;
       		
   			findVideoId = originalURL.substring(embedIndex);	//iframe에서 선택시 VideoId추출
       		location.href="DubbingWrite?url="+findVideoId;
       		
       		console.log('originalURL: '+originalURL);
       		console.log('findVideoId: '+findVideoId);
   		}
	</script>
</body>
</html>