
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
					
					var addVideo = '<div class="container">';
					addVideo += '<div class="item">';
					addVideo += '<h6>' + title + '</h6>';
					addVideo += '<iframe class="video w100" width="640" height="360" src="http://www.youtube.com/embed/'+ videoId
								+ '?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1" frameborder="0" allowfullscreen></iframe>';
					addVideo += '<input type="button" class="decideURL btn" data-rno="http://www.youtube.com/embed/'
								+ videoId + '" value="영상 선택"/> <br/>';
					addVideo += '</div>';
					addVideo += '</div>';

					$("#results").append(addVideo);
				});
				var prevPage = response.prevPageToken;
				var nextPage = response.nextPageToken;

				if (prevPage) {
					$("#results").append(
							"<input type='button' id='prevPage' value='이전'/>");
					$("#prevPage").on('click', function() {
						console.log('p: ' + prevPage);
						search(prevPage);
					});
				}

				if (nextPage) {
					$("#results").append(
							"<input type='button' id='nextPage' value='다음'/>");
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