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
</style>
<script type="text/javascript">
$(function() {
        send();
})
function send() {
    $.ajax({
        url: 'http://127.0.0.1:8000/recommend_product/',
        type: 'get',  // get or post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
             var df = rdata.df;
             $("#chatting_pannel").append( df );
             } 
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function(request, status, error) { // callback 함수
        console.log(error);
        }
    });

}

</script>
</head>
<body>
    <div id="container" class="container">
        <h2>추천 시스템</h2>
        <div id="chatting_pannel" class="chatting_pannel">
        </div>
        <div style='margin: 0px auto;'>
            <button onclick="window.close()" class="btn btn-info">닫기</button>
        </div>
    </div>
</body>
</html>
