<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>챗봇</title>

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style type="text/css">
        *{
            margin:0;
            padding:0;
        }
        .container {
            width: 100%;
            margin: 0 auto;
            padding: 10px
        }
        .container h2{
            text-align: left;
            padding: 5px 5px 5px 15px; /* top, right, bottom, left */
            color: #FFBB00;
            border-left: 3px solid #FFBB00;
            margin-bottom: 20px;
        }
        .chatting_pannel {
            background-color: #EFEFEF;
            width: 100%;
            height: 400px;
            overflow-y: scroll; /* scrollbar가 자동으로 생김 */
            padding: 5px;
        }
        .chatting_pannel p{
            font-size: 16px;
            border-radius: 10px;
            display: inline-block;
            padding: 2px 5px;
        }
        input {
            width: 60%;
            height: 25px;
        }
        .send_msg{
            text-align: right;
            color: #000000;
            background-color: yellow;
        }
        .receive_msg{
            text-align: left;
            color: #FFFFFF;
            background-color: #7a7373;
        }

        A:link{  /* 방문전 상태 */
            text-decoration: none; /* 밑줄 삭제 */
            color: #555555;
        }

        A:visited{  /* 방문후 상태 */
            text-decoration: none; /* 밑줄 삭제 */
            color: #555555;
        }

        A:hover{  /* A 태그에 마우스가 올라간 상태 */
            text-decoration: underline; /* 밑줄 출력 */
            color: #7777FF;
        }

        A:active{  /* A 태그를 클릭한 상태 */
            text-decoration: underline; /* 밑줄 출력 */
            color: #7777FF;
        }
</style>
<script type="text/javascript">
function chatting_intent(){
          var url = './chatbot_intent/chatting/';  // URL: path('chatbot_intent/chatting/', views.chatting_intent),  # chatting.html
          var win = window.open(url, '챗봇 intent', 'width=700px, height=630px');

          var x = (screen.width - 700) / 2;
          var y = (screen.height - 630) / 2;

          win.moveTo(x, y); // 화면 중앙으로 이동
        }
 </script>
<script type="text/javascript">
$(function() {
    // 키이벤트 처리
    $('#chatting').on('keydown', function(key) {
      if (key.keyCode == 13) { // Enter
        // alert('enter input');
        send();
      }
    });
})
function send() {
    var msg = $("#chatting").val();
    $("#chatting_pannel").append("<div style='text-align: right'><p class='send_msg'>문의: " + msg + "</p></div>");
    $('#chatting').val("");
    // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    var params = 'msg=' + msg;
    // alert('params: ' + params);  
    $.ajax({
        url: 'http://127.0.0.1:8000/chatbot_intent/chatting_query',
        type: 'get',  // get or post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
            // alert(rdata.result);
            var msg = rdata.result;
            if(msg != null && msg.trim() != ''){
                $("#chatting_pannel").append("<p class='receive_msg'>안내 센터: " + msg + "</p><br>");
            }
            $('#panel').html(str); 
        },

        error: function(request, status, error) { 
        console.log(error);
        }
    });

}

</script>
</head>
<body>
    <div id="container" class="container">
        <h2>실시간 문의</h2>
        <div id="chatting_pannel" class="chatting_pannel">
        </div>
        <div style='margin: 0px auto;'>
            메시지
            <input id="chatting" name='chatting' placeholder="보내실 메시지를 입력하세요."
                       value="반가워요">
            <button onclick="send()" id="sendBtn" class="btn btn-info">보내기</button>
            <button onclick="window.close()" class="btn btn-info">닫기</button>
        </div>
    </div>
</body>
</html>

