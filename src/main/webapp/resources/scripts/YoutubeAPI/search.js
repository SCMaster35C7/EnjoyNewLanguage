// Youtube 검색 메소드
function search(pageCode) {
	console.log("search 시작");

	// console.log($("#search").val());

	// Youtube Data(v3) API Request 준비
	var request;
	if (!pageCode) {
		request = gapi.client.youtube.search.list({
			part : "snippet",
			type : "video",
			q : encodeURIComponent($("#search").val()).replace(/%20/g, "+"),
			maxResults : 3,
			order : "viewCount"
		});
	} else {
		request = gapi.client.youtube.search.list({
			part : "snippet",
			type : "video",
			q : encodeURIComponent($("#search").val()).replace(/%20/g, "+"),
			maxResults : 3,
			order : "viewCount",
			pageToken : pageCode
		});
	}

	// Request 실행
	request.execute(function(response) {
				var results = response.result;
				// console.log(response);
				$("#results").empty();
				$.each(results.items,function(index, item) {
					var title = item.snippet.title;
					var videoId = item.id.videoId;
					
					var addVideo = '<div class="container" style="width:90%; margin-bottom:10%;">';
		               addVideo += '<div class="item">';
		               addVideo += '<h6 class="center">' + title + '</h6>';
		               addVideo += '<div class="video-container z-depth-2">';
		               addVideo += '<iframe class="video w100" width="640" height="360" src="https://www.youtube.com/embed/'+ videoId
		                        + '?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1" frameborder="0" allowfullscreen></iframe>';
		               addVideo += '</div>';
		               addVideo += '<input type="button" class="decideURL btn right" style="margin-top:5px;" data-rno="http://www.youtube.com/embed/'
		                        + videoId + '" value="Choice"/>';
		               addVideo += '</div>';
		               addVideo += '</div>';
		               addVideo += '<br>';

					$("#results").append(addVideo);
				});
				var prevPage = response.prevPageToken;
				var nextPage = response.nextPageToken;

				if (prevPage) {
					$("#results").append(
						"<input type='button' class='btn' id='prevPage' value='Prev' style='margin-right:1%;'/>");
					$("#prevPage").on('click', function() {
						console.log('p: ' + prevPage);
						search(prevPage);
					});
				}

				if (nextPage) {
					$("#results").append(
							"<input type='button' class='btn' id='nextPage' value='Next'/>");
					$("#nextPage").on('click', function() {
						console.log('n: ' + nextPage);
						search(nextPage);
					});
				}
				resetVideoHeight();
				// 비디오 선택시 videoId URL란에 추가해줌
				addEventDecideURL();
			});
	$(window).on("resize", resetVideoHeight);
}

// 비디오 크기 조정 메소드
function resetVideoHeight() {
	$(".video").css("height", $("#results").width() * 8 / 16);
}

// 비디오 선택시 URL에 추가해주는 메소드
function addEventDecideURL() {
	$('.decideURL').on('click', function() {
		console.log('click!!');
		var videoId = $(this).attr('data-rno');
		$('#url').val(videoId);
		if (pageName == 'VideoSearch') {
			DubbingWrite();
		}
	});
}

// Youtube API초기화 메소드
function init() {
	gapi.client.setApiKey("AIzaSyDRzWYGUmo0xtzfb1F-aW4hTHMwuKT4cRg");
	gapi.client.load("youtube", "v3", function() {
	});
}