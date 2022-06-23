<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>챗봇 intent</title>
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css">

<style type="text/css">
#chatWrap {
    width: 400px;
    border: 1px solid #ddd;
}

#chatHeader {
    height: 60px;
    text-align: center;
    line-height: 60px;
    font-size: 25px;
    font-weight: 900;
    border-bottom: 1px solid #ddd;
}

#chatLog {
    height: 393px;
    overflow-y: auto; /* scrollbar가 자동으로 생김 */
    padding: 5px;
}

.myMsg {
    text-align: right;
}

.anotherMsg {
    text-align: left;
    margin-bottom: 5px;
}

.msg {
    display: inline-block;
    border-radius: 15px;
    padding: 7px 15px;
    margin-bottom: 10px;
    margin-top: 5px;

}

.anotherMsg > .msg {
    background-color: #f1f0f0;

}

.myMsg > .msg {
    background-color: gray;
    color: #fff;
}

.anotherName {
    font-size: 12px;
    display: block;
}

#chatForm {
    display: block;
    width: 100%;
    height: 50px;
    border-top: 2px solid #f0f0f0;
}

#message {
    width: 85%;
    height: calc(100% - 1px);
    border: none;
    padding-bottom: 0;
}

#message:focus {
    outline: none;
}

#chatForm > input[type=submit] {
    outline: none;
    border: none;
    background: none;
    color: #0084FF;
    font-size: 17px;
}

        *{
            margin:0;
            padding:0;
        }
        .chatting_pannel {
            background-color: white;
            width: 100%;
            height: 410px;
            overflow-y: auto; /* scrollbar가 자동으로 생김 */
            padding: 10px;
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
    $("#chatLog").append("<div class='myMsg'><span class='msg'>" + msg + "</span></div>");
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
                $("#chatLog").append("<div class='anotherMsg'><span class='anotherName'><img src='/chatbot/images/protein.png'style='width:100px;'></span><span class='msg'>" + msg + "</span></div><br>");
            }
            $('#panel').html(str);  // document.getElementById('panel').innerHTML=str;
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function(request, status, error) { // callback 함수
        console.log(error);
        }
    });
    // $('#panel').html('처리중입니다....');  // 텍스트를 출력하는 경우
    // $('#panel').html("<img src='{% static '/images/ani04.gif' %}' style='width: 10%;'>");
    // $('#panel').show(); // 숨겨진 태그의 출력
}

function send2(msg2) { 
    var msg = $("#chatting").val();
    $("#chatLog").append("<div class='myMsg'><span class='msg'>" + msg2 + "</span></div>");
    $('#chatting').val("");
    // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    var params = 'msg=' + msg2;
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
                $("#chatLog").append("<div class='anotherMsg'><span class='anotherName'><img src='/chatbot/images/protein.png' style='width:100px;'></span><span class='msg'>" + msg + "</span></div><br>");
            }
            $('#panel').html(str);  // document.getElementById('panel').innerHTML=str;
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function(request, status, error) { // callback 함수
        console.log(error);
        }
    });
    // $('#panel').html('처리중입니다....');  // 텍스트를 출력하는 경우
    // $('#panel').html("<img src='{% static '/images/ani04.gif' %}' style='width: 10%;'>");
    // $('#panel').show(); // 숨겨진 태그의 출력
}
// function receive() {
//     var msg = '감사합니다.';
//     if(msg != null && msg.trim() != ''){
//         $("#chatting_pannel").append("<p class='receive_msg'>안내 센터: " + msg + "</p><br>");
//     }
// }
</script>
</head>
<body>
    <div id="chatWrap">
        <div id="chatHeader">CHATTING</div>
        <div id="chatLog" class="chatting_pannel">
         <div class="anotherMsg">
                    <span class="anotherName"><img src="/chatbot/images/protein.png" style="width:100px;"></span>
                    <span class="msg">안녕하세요.고객님! <br> 하루삼끼 AI 챗봇 로틴이에요. <br> 무엇이 궁금하신가요?
                     </span>
                     <br>
                     <span class="msg" style="background-color:#c0c0c0; width:200px; ">
                              <span style="font-weight:bold;font-size:18px;">인기 키워드</span><br>
                                    <button onclick="send2('상품 주문하기')" style="border:1px;background-color:#c0c0c0;"><i class="fa-solid fa-dice-one">&nbsp;&nbsp;</i>상품 주문하기</button><hr style="margin:5px;">
                                    <button onclick="send2('추천상품 시스템')" style="border:1px;background-color:#c0c0c0; "><i class="fa-solid fa-dice-two">&nbsp;&nbsp;</i>추천 시스템</button><hr style="margin:5px;">
                                    <button onclick="send2('삼대몇? 바로가기')" style="border:1px;background-color:#c0c0c0;"><i class="fa-solid fa-dice-three">&nbsp;&nbsp;</i>삼대몇? 바로가기</button><br>       
                     </span>
         </div>
        </div>
        <div style='padding:0px 10px 3px 10px;  vertical-align: middle;'>
            <input id="chatting" name='chatting' style="height:30px; width:341px;"placeholder="보내실 메시지를 입력하세요.">
            <button onclick="send()" id="sendBtn" style="margin-bottom:5px;" class="btn btn-dark btn-sm" ><i class="fas fa-paper-plane"></i></button>
        </div>
    </div>
</body>
</html>

