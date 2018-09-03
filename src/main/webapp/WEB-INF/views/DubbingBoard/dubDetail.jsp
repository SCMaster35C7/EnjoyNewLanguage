<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
 <script type="text/javascript">
 	
		//주말 
 	var useremail = "${sessionScope.useremail}";
	var usernick = "${sessionScope.usernick}";
	var dubbingnum = "${dubbing.dubbingnum}"
 			
		$(function() {
			
			// 주말
			init();
			
			$("#replyInsert").on('click', replyInsert);
			//
			
			
			$('.recommendation').on('click', function() {
				var useremail = "${sessionScope.useremail}";
				
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}
				var target = $(this);
				var recoCount = Number(target.children("span").text());
				var decoTarget = target.parent().children(".decommendation").children("#decoCount");
				var videonum = target.parent().children("input").val();
				var dataForm = {"tableName":"dubbing",
						"idCode":"dubbingnum", 
						"useremail":useremail, 
						"identificationnum":videonum, 
						"recommendta ble":"2", 
						"recommendation":"0"
				};
				
				$.ajax({
					method:'post'
					, url:'insertRecommendation'
					, data: JSON.stringify(dataForm)
					, contentType: "application/json; charset=utf-8"
					, async: false
					, success:function(resp) {
						if(resp == "success") {
							alert("영상을 좋아합니다.");
							target.children("span").html(recoCount+1);
						}else if(resp == "cancel") {
							alert("좋아요를 취소합니다.");
							target.children("span").html(recoCount-1);
						}else if(resp == "change") {
							alert("좋아요로 변경하셨습니다.");
							decoTarget.html(Number(decoTarget.text())-1);
							target.children("span").html(recoCount+1);
						}
					  }
					, error:function(resp, code, error) {
						alert("resp : "+resp+", code : "+code+", error : "+error);
					}
				});
			});
			
			$('.decommendation').on('click', function() {
				var useremail = "${sessionScope.useremail}";
				
				if(useremail.trim().length == 0) {
					location.href="login";
					return;
				}
				var target = $(this);
				var decoCount = Number(target.children("span").text());
				var recoTarget = target.parent().children(".recommendation").children("#recoCount");
				var videonum = target.parent().children("input").val();
				var dataForm = {"tableName":"dubbing", 
						"idCode":"dubbingnum", 
						"useremail":useremail, 
						"identificationnum":videonum, 
						"recommendtable":"2", 
						"recommendation":"1"
				};
				
				$.ajax({
					method:'post'
					, url:'insertRecommendation'
					, data: JSON.stringify(dataForm)
					, contentType: "application/json; charset=utf-8"
					, async: false
					, success:function(resp) {
						if(resp == "success") {
							alert("영상을 싫어합니다.");
							target.children("span").html(decoCount+1);
						}else if(resp == "cancel") {
							alert("싫어요를 취소합니다.");
							target.children("span").html(decoCount-1);
						}else if(resp == "change"){
							alert("싫어요로 변경하셨습니다.");
							recoTarget.html(Number(recoTarget.text())-1);
							target.children("span").html(decoCount+1);
						}
					  }
					, error:function(resp, code, error) {
						alert("resp : "+resp+", code : "+code+", error : "+error);
					}
				});
			});
		});
		
		//주말
		function init() {
			$.ajax({
				method : 'post',
				url : 'replyAll',
				data : 'dubbingnum=${dubbing.dubbingnum}',
				success : output
			});
		}
		
		
		function output(resp) {
			//alert(JSON.stringify(resp));
			var result = '';
		
			for ( var i in resp) {
				result += '<div class="content">'
				result += ' <p class="email" >' + resp[i].useremail + '</p> ';
				result += ' <p class="nick" >' + resp[i].usernick + '</p> ';
				result += ' <p class="text" >' + resp[i].content + '</p>';
				result += '<p class="date" >' + resp[i].regdate + '</p>';
				result += '<p class="blackcount" >' + resp[i].blackcount + '</p>';
				result += '<input class="replyUpdate" type="button" data-rno="'+resp[i].replynum+'" value="수정" />';
				result += '<input class="replyDelete" type="button" data-rno="'+resp[i].replynum+'" value="삭제" />';
				 
				result += ' </div>';
				
			
			}
			
			$("#result").html(result);
			
			
			
			
			
			//여기서(output) 나가기 전에 이벤트 걸어야함
			 $("input:button.replyDelete").click(replyDelete);
			 $("input:button.replyUpdate").click(replyUpdate); 

			
			
		}
		
		function replyInsert() {
			$("#useremail").val(useremail);
			
			var btnname = $("#replyInsert").val();

			if (btnname == '댓글등록') {
				var replytext = $("#replytext").val();
				


				if (replytext.length == 0) {
					alert("댓글을 작성해주세요!");
					return;
				}
		
				//폼 가져와
				var sendData = 
					{	"dubbingnum":dubbingnum
						,"useremail":  useremail
						,"content":replytext };
				
				$.ajax({
					type : 'post',
					url : 'replyInsert',
					data : JSON.stringify(sendData),
					dataType:'json',
					contentType: "application/json; charset=UTF-8",
					success : init
				});
				 //돌려놓기
				$("#replytext").val('');
			
			}
		
			
		
			 //댓글수정이면
			else if (btnname == '댓글수정') {
				
				var replytext = $("#replytext").val();
				
				var replynum = $("#replynum").val();
			 
				//alert(replynum);
		 		var sendData = {
					"replynum" : replynum,
					"content" : replytext,
				} 

			
		
			$.ajax({
			method : 'post',
			url : 'replyUpdate',
			data : JSON.stringify(sendData),
			dataType:'json',
			contentType: "application/json; charset=UTF-8",
			success : init

		}); 
		

		//돌려놓기
		$("#replytext").val('');
		$("#replyInsert").val("리뷰등록");
		}
		}

		function replyDelete() {
			var nick = $(this).parent().children('.nick').text();
			if ("${usernick}" != nick) {
				alert('회원님이 작성하신 리뷰만 삭제 가능합니다!');
				return;
			}
			replynum = $(this).attr('data-rno');
			$.ajax({
				method : 'get',
				url : 'replyDelete',
				data : 'replynum=' + replynum,
				success : init
			});

		}

		function replyUpdate() {

			replynum = $(this).attr('data-rno');

			var nick = $(this).parent().children('.nick').text(); //!!!!!!!this는 수정버튼이니까
			var replytext = $(this).parent().children('.text').text();

			if ("${usernick}" != nick) {
				alert('회원님이 작성하신 리뷰만 삭제 가능합니다!');
				return;
			}

			$("#usernick").val(nick);
			$("#replytext").val(replytext);
			$("#replyInsert").val("댓글수정");
			$("#usernick").prop('readonly', 'readonly');

			//히든에 리뷰넘버 넣어주기
			$("#replynum").val(replynum);
		}

		//
	</script>
</head>
<body>
	${dubbing}
	<br/>
	
	<div class="card-footer" align="center">
						<input type="hidden" value="${dubbing.dubbingnum}">
						<button class="btn recommendation">
							<img alt="" src="images/tup.png">
							<span id="recoCount">${dubbing.recommendation}</span>
						</button>
						
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn decommendation">
							<img alt="" src="images/tdown.png">
							<span id="decoCount">${dubbing.decommendation}</span>
						</button>
					
	</div>
	
	<hr/>
	<!--주말 댓글-->
	<div> 
	
		<form id="replyform"  method="post" >
			
			<input id="usernick" name="usernick" type="text" value="${sessionScope.usernick}" readonly="readonly"/>
			<input id=replytext name="replytext" type="text" placeholder="리뷰를 작성해주세요 ^ㅅ^"/>
			
		
			<input hidden="useremail" id="useremail" name="useremail" value=""/>
			<input hidden="replynum" id="replynum" name="replynum" value=""/>
			
			<input id="replyInsert" type="button" value="댓글등록"/>
		</form>
		
		<hr/>
		<div id="result"> 
		<!-- 반복적으로 나오게 -->
		</div>
	</div>
	
</body>
</html>