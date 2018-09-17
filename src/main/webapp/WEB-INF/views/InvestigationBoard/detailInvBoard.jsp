<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="author" content="zisung">
   
   <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize1.css"  media="screen,projection"/>

    <!--Let browser know website is optimized for mobile-->
   <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
   
   <style>
   .scroll-box {
       overflow-y: scroll;
        height: 300px;
        padding: 1rem
       }
   </style>
   
   <title>자막 검증 상세 정보</title>
   <script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
   <script type="text/javascript">
      //css
      $(function() {
         $('select').formSelect();
         
         //dropdown
         $(".dropdown-trigger").dropdown();
         
         //floating actionbutton
         $(".fixed-action-btn").floatingActionButton({
            /* direction:'left' */
         });
         
         //modal open
         $('#modal1').modal();
         
         //side-nav open
         $('.sidenav').sidenav();
         
         //tooltip
         $('.tooltipped').tooltip();
         
         //캐러셀
         $('.carousel').carousel();
         
         $('#loginBtn').on('click',function(){
            var useremail = $('#useremail');
            var userpwd = $('#userpwd');
            
            $('#loginForm').submit();
         });
         
         $('.search').on('keydown', function(key) {
            if (key.keyCode == 13) {
               // naver 검색
               $.each($('.search'), function(index, item) {
                  if(item.value.length != 0) {
                     var searchText = item.value;
                     var http="https://endic.naver.com/search.nhn?sLn=kr&dicQuery="+searchText+"&x=0&y=0&query="+searchText+"&target=endic&ie=utf8&query_utf=&isOnlyViewEE=N";
                     window.open("https://endic.naver.com/search.nhn?sLn=kr&dicQuery="+searchText+"&x=0&y=0&query="+searchText+"&target=endic&ie=utf8&query_utf=&isOnlyViewEE=N","_blank", "width=700px, height=400px");   
                  }
               });
            }
         });
      });
      
   
      var useremail = "${sessionScope.useremail}";
      var usernick = "${sessionScope.usernick}";
      var investigationnum = "${inv.investigationnum}"
          
       $(function() {
          initReply();
          initSubtitle();
            
           $("#replyInsert").on('click', replyInsert);
 
           $('.recommendation').on('click', function() {
                 if(useremail.trim().length == 0) {
                  location.href="login";
                  return;
                 }
                 var target = $(this);
                 var recoCount = Number(target.children("span").text());
                 var decoTarget = target.parent().children(".decommendation").children("#decoCount");
                 var videonum = target.parent().children("input").val();
                 var dataForm = {
                    "tableName":"investigation",
                   "idCode":"investigationnum", 
                   "useremail":useremail, 
                   "identificationnum":videonum, 
                   "recommendtable":"1", 
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
              if(useremail.trim().length == 0) {
                     location.href="login";
                     return;
               }
               var target = $(this);
               var decoCount = Number(target.children("span").text());
               var recoTarget = target.parent().children(".recommendation").children("#recoCount");
               var videonum = target.parent().children("input").val();
               var dataForm = {
                  "tableName":"investigation", 
                   "idCode":"investigationnum", 
                   "useremail":useremail, 
                   "identificationnum":videonum, 
                   "recommendtable":"1", 
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
            
         $("#cancelUpdate").on('click', function() {
            $("#replytext").val('');
            $("#replyInsert").val("댓글등록");
            $("#cancelUpdate").css("visibility", "hidden");
         });
            
         $('#registSubtitle').on('click', function() {
            var form = $('#fileForm')[0];
            var formData = new FormData(form);
            var subtitleName = $('#subtitleName');
            
                 if(useremail.trim().length == 0) {
                    $('#modal1').modal().open();
                  return;
                 }
            
            if(subtitleName.val().trim().length == 0) {
               alert("자막 파일명을 입력해주세요.");
               subtitleName.focus();
               return;
            }
            
            if($('#subtitleFile')[0].files[0]  == undefined) {
               alert("파일을 등록해주세요.");
               $('#subtitleFile').focus();
               return;
            }
            
            var fileName = $('#subtitleFile')[0].files[0].name;
            if(fileName.substring(fileName.lastIndexOf('.')+1) != "srt") {
               alert("srt 파일만 자막 등록이 가능합니다.");
               $('#subtitleFile').focus();
               return;
            }
            
            formData.append("file", $('#subtitleFile')[0].files[0]);
            formData.append("useremail", useremail);
            formData.append("investigationNum", investigationnum);
            formData.append("subtitleName", subtitleName.val());
            
            $.ajax({
               url:'registSubtitle'
               , type:'post'
               , processData: false
               , contentType: false
               , data: formData
               , success: function(resp) {
                  if(resp == 'failure') {
                     alert("파일을 넣어주세요.")
                  }else if(resp == 'success') {
                     subtitleName.val('');
                     $('#subtitleFile').val('');
                     initSubtitle();
                  }
               }
               , error: function(resp, code, error) {
                        alert("resp : "+resp+", code : "+code+", error : "+error);
                  }
            });
         });
      });
      
      function initReply() {
           $.ajax({
               method : 'post',
               url : 'replyInvAll',
               data : 'idnum=${inv.investigationnum}',
               async: false,
               success : outputReply
          });
       }
      
      function initSubtitle() {
           $.ajax({
               method : 'post',
               url : 'invSubAll',
               data : 'investigationnum=${inv.investigationnum}',
               async: false,
               success : outputSubtitle
           });
      }
         
       function outputReply(resp) {
             var result = '';
       
             for ( var i in resp) {
                result += '<div class="content">'
                result += ' <p class="email" >' + resp[i].useremail + '</p>';
                result += ' <p class="nick" >' + resp[i].usernick + '</p>';
                result += ' <p class="text" >' + resp[i].content + '</p>';
                result += '<p class="date" >' + resp[i].regdate + '</p>';
                result += '<p class="blackcount" >' + resp[i].blackcount + '</p>';
               if (usernick==resp[i].usernick) {
               result += '<input class="replyUpdate" type="button" data-rno="'+resp[i].replynum+'" value="수정" />';
               result += '<input class="replyDelete" type="button" data-rno="'+resp[i].replynum+'" value="삭제" />';
            }
            result += '<img class="report" src="images/절미2.jpg"  data-rno="'+resp[i].replynum+'" />';
                result += ' </div>';
         }
            
             $("#result").html(result);
             $("input:button.replyDelete").click(replyDelete);
             $("input:button.replyUpdate").click(replyUpdate);
             $("img.report").click(reportReply); 
       }
       
       function outputSubtitle(resp) {
          console.log(resp);
          
          var result = '';
         for ( var i in resp) {
            result += '<div class="row">';
            result += '  <div class="subtitle" style="display:inline-block;">';
            result += '    <span class="">'+resp[i].usernick+'</span>'
            result += '    <span class="">'+resp[i].subtitleName+'</span>'
            result += '  </div>';
            result += '  <div class="right" style="display:inline-block;">';
            result += '     <a class="subStart btn-floating tooltipped" data-position="top" data-tooltip="PLAY" style="margin-left:85px;" data-rno="'+resp[i].subtitleNum+'"><i class="material-icons">play_arrow</i></a>';
            if(useremail == resp[i].useremail) {
               result += '   <a class="subDelete btn-floating" data-rno="'+resp[i].subtitleNum+'"><i class="material-icons">clear</i></a>';
            }
            result += '     <button class="btn subRecommendation " style="padding-left:4px; padding-right:4px;" type="button" data-rno="'+resp[i].subtitleNum+'">';
            result += '        <i class="material-icons">thumb_up</i> <span class="subRecoCount">'+resp[i].recommendation+'</span>';
            result += '     </button>';
            result += '     <button class="btn subDecommendation " style="padding-left:4px; padding-right:4px;" type="button" data-rno="'+resp[i].subtitleNum+'">';
            result += '      <i class="material-icons">thumb_down</i> <span class="subDecoCount">'+resp[i].decommendation+'</span>';
            result += '     </button>';
            result += '  </div>';
            result += '</div>';
            result += '<br>';
         }
         
      
         
         $("#subtitleList").html(result);
         $(".subStart").on('click', subStart);
         $(".subDelete").on('click', subDelete);
         $(".subRecommendation").on('click', subRecommendation);
         $(".subDecommendation").on('click', subDecommendation);
      }
       
         function subStart() {
            alert("자막 실행");
            
            var subnum = $(this).attr('data-rno');
            
            $.ajax({
               method: 'get'
               , url: 'getSubtitles'
               , data: 'subtitleNum='+subnum
               , success: makeSubList
               , error: function(resp, code, error) {
                  alert(resp+", code:"+code+", error:"+error)
               }
            });
         }
         
         function makeSubList(s) {
         console.log(s); 
         var subtitles="";
         setInterval(function() {
            //0.01초 단위로 영상 재생시간을 채크하고 이를 소숫점2자리까지 잘라서 자막의 소숫점 2자리까지의 싱크타임과 비교, 맞을 경우 해당 문장의 배경색을 바꿈
            var time=player.getCurrentTime().toFixed(2);
            var text=s[time];
            
            if(text!=null){
               $('#textbox').html(text);   
            }
         },10);
      }
       
       function subDelete() {
          var subnum = $(this).attr('data-rno');
          
          var dataForm = {
             'subtitleNum':subnum
             , "recommendtable":"3"
          };
          
          $.ajax({
             method: 'get'
             , url: 'invSubDelete'
             , data: dataForm
             , async: false
             , success: function(resp) {
                //alert(resp);
             }
          });
          
          initSubtitle();
       }
       
       function subRecommendation() {
          if(useremail.trim().length == 0) {
               location.href="login";
               return;
              }
              var target = $(this);
              var subRecoCount = Number(target.children("span").text());
              var subDecoTarget = target.parent().children(".subDecommendation").children(".subDecoCount");
              var subnum = $(this).attr('data-rno');
              var dataForm = {
                "tableName":"InvestigationSubtitle", 
                "idCode":"subtitleNum", 
                "useremail":useremail, 
                "identificationnum":subnum, 
                "recommendtable":"3", 
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
                        target.children("span").html(subRecoCount+1);
                     }else if(resp == "cancel") {
                        alert("좋아요를 취소합니다.");
                        target.children("span").html(subRecoCount-1);
                     }else if(resp == "change") {
                        alert("좋아요로 변경하셨습니다.");
                        subDecoTarget.html(Number(subDecoTarget.text())-1);
                        target.children("span").html(subRecoCount+1);
                     }
                  }
                  , error:function(resp, code, error) {
                     alert("resp : "+resp+", code : "+code+", error : "+error);
                  }
            });
       }
       
       function subDecommendation() {
          if(useremail.trim().length == 0) {
                  location.href="login";
                  return;
            }
            var target = $(this);
            var subDecoCount = Number(target.children("span").text());
            var subRecoTarget = target.parent().children(".subRecommendation").children(".subRecoCount");
          var subnum = $(this).attr('data-rno');
            var dataForm = {
               "tableName":"InvestigationSubtitle", 
                "idCode":"subtitleNum", 
                "useremail":useremail, 
                "identificationnum":subnum, 
                "recommendtable":"3", 
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
                        target.children("span").html(subDecoCount+1);
                     }else if(resp == "cancel") {
                        alert("싫어요를 취소합니다.");
                        target.children("span").html(subDecoCount-1);
                     }else if(resp == "change"){
                        alert("싫어요로 변경하셨습니다.");
                        subRecoTarget.html(Number(subRecoTarget.text())-1);
                        target.children("span").html(subDecoCount+1);
                     }
                 }
                  , error:function(resp, code, error) {
                     alert("resp : "+resp+", code : "+code+", error : "+error);
               }
           });
       }

      function reportReply() {
         //alert('신고');
         var useremail = "${sessionScope.useremail}";
         //alert(useremail);
         replynum = $(this).attr('data-rno');
         //alert(replynum);
         var sendData = {
               "useremail":useremail
               ,"whichboard":  "1"
               ,"replynum":  replynum
            };
            
         $.ajax({
            type : 'post',
            url : 'insertBlack',
            data : JSON.stringify(sendData),
            dataType:'text',
            contentType: "application/json; charset=UTF-8",
            success : function(resp){
               alert(JSON.stringify(resp));
               initReply();
            },
            error:function(resp, code, error) {
               //alert("resp : "+resp+", code : "+code+", error : "+error);
               alert("로그인이 필요합니다.");
               location.href="./";
            }
         }); 
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

            var sendData = {
               "idnum" : investigationnum,
               "useremail" : useremail,
               "content" : replytext
            };

            $.ajax({
               type : 'post',
               url : 'replyInvInsert',
               data : JSON.stringify(sendData),
               dataType : 'text',
               contentType : "application/json; charset=UTF-8",
               success : initReply
            });
            //돌려놓기
            $("#replytext").val('');
         } else if (btnname == '댓글수정') {
            var replytext = $("#replytext").val();
            var replynum = $("#replynum").val();
            var sendData = {
               "replynum" : replynum,
               "content" : replytext,
            }

            $.ajax({
               method : 'post',
               url : 'replyInvUpdate',
               data : JSON.stringify(sendData),
               dataType : 'text',
               contentType : "application/json; charset=UTF-8",
               success : initReply
            });

            $("#replytext").val('');
            $("#replyInsert").val("리뷰등록");
            $("#cancelUpdate").css("visibility", "hidden");
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
            url : 'replyInvDelete',
            data : 'replynum=' + replynum,
            dataType : 'text',
            success : initReply
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
         $("#cancelUpdate").css("visibility", "visible");
         
         $("#replynum").val(replynum);
      }
   </script>
</head>

<body>
   <header>
      <c:if test="${plzLogin!=null}">
         <script type="text/javascript">
            $(function(){
               alert("${plzLogin}");
            });
         </script>
      </c:if>

      <!-- nav -->
      <nav class="nav-extended">
        <div class="nav-wrapper">
          <!-- sidenav trigger -->
          <ul class="left">
             <li>
                <a href="#" data-target="slide-out" class="sidenav-trigger" style="display:inline">
                   <i class="material-icons">menu</i>
                </a>
             </li>
          </ul>
          <a href="${pageContext.request.contextPath}" class="brand-logo">Logo</a>
          <a href="#" data-target="small-navi"  class="sidenav-trigger"><i class="material-icons">menu</i></a>
          
         <ul class="right hide-on-med-and-down">
                 <li>
                    <div class="header-search-wrapper hide-on-med-and-down" style="display:inline-block; width:300px; margin-left:-5%;">
                           <i class="material-icons" style="margin-left:-50px;">search</i>
                           <input type="search" name="search" class="header-search-input z-depth-2 search" placeholder="SEARCH WORD"/>
                       </div>
                 </li>       
                  <li><a href="eduBoard">영상게시판</a></li>
                  <li><a href="dubbingBoard">더빙게시판</a></li>
                  <li><a href="InvestigationBoard">자막검증게시판</a></li>
                  <li><a href="myPage">마이페이지</a></li>
             </ul>
        </div>
   
        <div class="nav-content">
            <a class="btn-floating btn-large halfway-fab pulse modal-trigger tooltipped" data-position="bottom" data-tooltip="LOGIN!" href="#modal1">
                 <i class="medium material-icons">person</i>
              </a>
        </div>
      </nav>
   </header>
   
   <!-- 창 축소시 사이드 nav -->
   <ul class="sidenav" id="small-navi">
      <li>
           <div class="input-field">
                <input class="search" type="search" required>
                <label class="label-icon" for="search"><i class="material-icons">search</i></label>
                <i class="material-icons">close</i>
             </div>
      </li>       
      <li><a href="eduBoard">영상게시판</a></li>
      <li><a href="dubbingBoard">더빙게시판</a></li>
      <li><a href="InvestigationBoard">자막게시판</a></li>
      <li><a href="myPage">마이페이지</a></li>
   </ul>
          
   <!-- 로그인 MODAL -->
   <div id="modal1" class="modal">
      <div class="modal-content">
         <div class="container">
            <form class="col s12" id=loginForm action="login" method="POST">
               <div class="row">
                  <h4 class="center-align">LOGIN</h4>
                  <div class="row">
                     <c:if test="${empty sessionScope.useremail }">
                        <div class="input-field col s12">
                           <i class="material-icons prefix">mail</i>
                           <input id="useremail" type="text" class="validate" name="useremail" value="${useremail}">
                           <label for="useremail">EMAIL</label>
                        </div>
                     </c:if>
                  </div>
            
                  <div class="row">
                     <c:if test="${empty sessionScope.useremail }">
                        <div class="input-field col s12">
                           <i class="material-icons prefix">mode_edit</i>
                           <input id="userpwd" type="password" class="validate" name="userpwd" value="${userpwd}">
                           <label for="userpwd">PASSWORD</label>
                           <input id="checkline" value="" type="text" style="border-bottom: none;" readonly="readonly"/>
                        </div>
                     </c:if>
                  </div>
               
                  <!-- 글씨뜨는거 -->
                  <c:if test="${not empty sessionScope.useremail }">
                     <h4 class="center">${sessionScope.useremail}환영합니다.</h4>
                  </c:if>
               </div>   
            
               <div class="row">
                  <div class="col s10">
                     <c:if test="${empty sessionScope.useremail }">
                        <span class="flow-text">
                           <button class="btn waves-effect waves-light" type="button" id="loginBtn">ENTER
                              <i class="material-icons right">send</i>
                           </button>
                        </span>
                     </c:if>
                  
                     <span class="flow-text">
                        <button class="btn waves-effect waves-light modal-close" id="back" type="button">BACK
                           <i class="material-icons right">keyboard_return</i>
                        </button>
                     </span>
                     <c:if test="${not empty sessionScope.useremail }">
                        <span class="flow-text">
                           <a href="logout" class="btn waves-effect waves-light modal-close">LOGOUT
                              <i class="material-icons right">power_settings_new</i>
                           </a>
                        </span>
                     </c:if>
                  </div>
                  
                  <div class="fixed-action-btn">
                     <a class="btn-floating btn-large red waves-effect waves-light tooltipped" data-position="left" data-tooltip="ACCOUNT?">
                     <i class="large material-icons">person</i>
                     </a>
                     <ul>
                         <li><a href="joinForm" class="btn-floating blue tooltipped" data-position="top" data-tooltip="JOIN US!"><i class="material-icons">person_add</i></a></li>
                         <li><a class="btn-floating green tooltipped" data-position="top" data-tooltip="ACCOUNT RECOVERY"><i class="material-icons">sync</i></a></li>
                         <li><a class="btn-floating yellow darken-1 tooltipped" data-position="top" data-tooltip="QUIT US"><i class="material-icons">clear</i></a></li>
                     </ul>
                  </div>
               </div>
            </form>
         </div>
      </div>   
   </div>
     
   <div class="wrapper">
      <!-- sidenav -->     
      <aside>          
         <ul id="slide-out" class="sidenav" style="margin-top:64px;">
            <li>
               <div class="user-view">
                  <div class="background">
                     <img src="images/">
                  </div>
                  <a href="#user"><img class="circle" src="images/"></a>
                  <a href="#name"><span class="white-text name">${usernick}</span></a> 
                  <a href="#email"><span class="white-text email">${useremail}</span></a>
               </div>
            </li>
            <li><a href="#!"><i class="material-icons">cloud</i>First Link With Icon</a></li>
            <li><a href="#!">wishList</a></li>
            <li><div class="divider"></div></li>
            <li><a class="subheader">회원정보관리</a></li>
            <li><a class="waves-effect" href="updateMember">회원정보수정</a></li>
            <li><a class="waves-effect" href="#">회원탈퇴</a></li>
         </ul>
      </aside>
      
      <section>
         <div class="container" style="width:98%;">
         <!-- 1. <iframe>태그로 대체될 <div>태그이다. 해당 위치에 Youtube Player가 붙는다. -->
         <!--<div id="youtube"></div>   -->
            <div class="row">
               <div class="col s8 m8">
                  <div class="video-container z-depth-2" >
                     <iframe id="youtube" width="960" height="490"
                        src="http://www.youtube.com/embed/${inv.url}?enablejsapi=1&rel=0&showinfo=0&autohide=1&controls=1&modestbranding=1"
                        frameborder="0" allowfullscreen>
                     </iframe>
                  </div>
                     
                  <div class="row" style="margin-top:15px;">
                     <div class="col s8 m8 l8"><h6 id="textbox" class="center z-depth-2" style="height:36px; display:inline-block; width:680px; padding:5px; margin-top:0px;"></h6></div>
                     <div class="right" style="margin-right:15px;">
                        <input type="hidden" value="${inv.investigationnum}">
                        <button class="btn recommendation" type="button">
                           <i class="material-icons">thumb_up</i>
                           <span id="recoCount">${inv.recommendation}</span>
                        </button>
                        <button class="btn decommendation" type="button">
                           <i class="material-icons">thumb_down</i> 
                           <span id="decoCount">${inv.decommendation}</span>
                        </button>
                     </div>
                  </div>
                  </div>
                     <div class="col s4 m4 l4">
                           <div class="card" style="height:520px; margin-top:0px;">
                           <div class="card-content">
                              <span class="card-title activator grey-text text-darken-4">
                                 자막목록
                              </span>
                           </div>
                           <div class="card-content scroll-box">
                                  <div id="subtitleList"></div>
                             </div>
                             <div class="card-action" style="padding:10px;">
                                  <form id="fileForm" class="col s12 center" method="post" enctype="multipart/form-data" action="">
                                  <div class="file-field">
                                      <div class="btn right" style="margin-left:30px;">
                                           <span>File</span>
                                           <input type="file" id="subtitleFile">
                                       </div>
                                   
                                       <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text">
                                       </div>
                                   </div>   
                                  <div class="row">
                                     <div class="input-field col s9" style="margin-left:10px;">
                                           <input id="subtitleName" type="text" class="validate"/>
                                           <label for="subtitleName">등록 파일명</label>
                                         </div>
                                     
                                     <div class="input-field col s2" style="margin-top:25px;">
                                       <input type="button" id="registSubtitle" class="btn" style="margin-left:5px; padding-left:2px; padding-right:2px;" value="자막등록"/>
                                     </div>
                                  </div>   
                              </form>
                             </div>
                         </div>
                      </div>
   <script>
      // 2.  Youtube Player IFram