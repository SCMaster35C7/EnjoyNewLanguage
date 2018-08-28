function tplawesome(e,t){
	res=e;
	for(var n=0;n<t.length;n++){
		res=res.replace(/\{\{(.*?)\}\}/g, function(e,r) {
			return t[n][r];
		});
	}
	return res;
}

function search() {
	$("form").off();
    $("form").on("submit", function(e) {
    	console.log("search 시작");
		e.preventDefault();
		
		// prepare the request
		console.log($("#search").val());
		var request = gapi.client.youtube.search.list({
			part : "snippet",
			type : "video",
			q : encodeURIComponent($("#search").val()).replace(/%20/g, "+"),
			maxResults : 3,
			order : "viewCount"
		});
		
		// execute the request
		request.execute(function(response) {
			var results = response.result;
			console.log(response);
			$("#results").html("");
			$.each(results.items, function(index, item) {
				var title = item.snippet.title;
				var videoId = item.id.videoId;
				
				//alert(title);
				//alert(videoId);
				
				var addVideo = '<div class="item">';
				addVideo += '<h2>'+title+'</h2>';
				addVideo += '<iframe class="video w100" width="640" height="360" src="http://www.youtube.com/embed/'+videoId+'?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=0&modestbranding=1" frameborder="0" allowfullscreen></iframe>';
				addVideo += '</div>';
				addVideo += '<button class="decideURL" data-rno='+videoId+'>영상 선택</button>';
				
				$("#results").append(addVideo);
				/*
				$.get("addVideo", function(data) {
					$("#results").append(tplawesome(data, [ {
						"title" : item.snippet.title,
						"videoid" : item.id.videoId
					} ]));
				});
				*/
			});
			resetVideoHeight();
			addEventDecideURL();
		});
	});

	$(window).on("resize", resetVideoHeight);
}

function resetVideoHeight() {
	$(".video").css("height", $("#results").width() * 9 / 16);
}
function addEventDecideURL() {
	$('.decideURL').on('click', function() {
		var videoId = $(this).attr('data-rno');
		$('#url').val(videoId);
		alert(videoId);
	});
}

function init() {
	gapi.client.setApiKey("AIzaSyDRzWYGUmo0xtzfb1F-aW4hTHMwuKT4cRg");
	gapi.client.load("youtube", "v3", function() {
		// yt api is ready
	});
}