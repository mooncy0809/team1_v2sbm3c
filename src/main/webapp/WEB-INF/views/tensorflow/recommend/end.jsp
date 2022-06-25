<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관심 카테고리</title>
    <link href="/css/style.css" rel="Stylesheet" type="text/css">
    <script type="text/JavaScript"
                 src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Luckiest+Guy&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    <script type="text/javascript">
        $(function() {
            send();  // Django ajax 호출
            $('#btn_previous').on('click', function() { history.back(); });   // 이전
            $('#btn_redo').on('click', function() { location.href='http://localhost:9091/tensorflow/recommend/form1.do'; });      // 윈도우 닫기
        });

        function send() {
            var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
            // alert('params: ' + params);  // 수신 데이터 확인
            $.ajax({
              url: 'http://localhost:8000/recommend/end_ajax/',  // Spring Boot -> Django 호출
              type: 'get',  // get or post
              cache: false, // 응답 결과 임시 저장 취소
              async: true,  // true: 비동기 통신
              dataType: 'json', // 응답 형식: json, html, xml...
              data: params,      // 데이터
              success: function(rdata) { // 응답이 온경우
                if (rdata.index == 0) {        // 닭가슴살 추천 
                    $('#one').css('display',''); // show
                } else if(rdata.index == 1) { // 간편요리 추천 
                    $('#two').css('display','');
                } else if(rdata.index == 2) { // 샐러드 추천 
                    $('#three').css('display','');
                } else if(rdata.index == 3) { // 건강미용 추천  
                    $('#four').css('display','');                    
                } else {                            // 간식 추천 
                    $('#five').css('display','');
                } 

                $('#panel').html("");  // animation gif 삭제
                $('#panel').css('display', 'none'); // 숨겨진 태그의 출력

                // --------------------------------------------------
                // 분류 정보에 따른 상품 이미지 SELECT
                //  --------------------------------------------------
              },
              // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
              error: function(request, status, error) { // callback 함수
                console.log(error);
              }
            });

            // $('#panel').html('처리중입니다....');  // 텍스트를 출력하는 경우
            $('#panel').html("<img src='/contents/images/ani02.gif' style='width: 30%;'>");
            $('#panel').show(); // 숨겨진 태그의 출력
          }

        function recommend_product(memberno){            
            if(memberno==null){
                alert('로그인 해주세요.');
                top.location.href='http://localhost:9091/member/login.do';
            }else{
                var url ='http://127.0.0.1:8000/recommend_product/' + memberno;
                var win = window.open(url, 'AI 서비스', 'width=850px, height=670px ');
                var x = (screen.width - 500) / 2;
                var y = (screen.height - 670) / 2;
                win.moveTo(x, y); // 화면 중앙으로 이동
            }
          }
    </script>

    <style>
        *{
            text-align: center;
        }

        .td_image{
            vertical-align: middle;
            padding: 5px;
            cursor: pointer;
        }

    </style>
    
</head>
<body  style="background-color:#F5F5EE;">

<DIV style='display: none;'>
    <form name='frm' id='frm'>
        <input type='hidden' name='step1' value='${param.step1 }'>
        <input type='hidden' name='step2' value='${param.step2 }'>
        <input type='hidden' name='step3' value='${param.step3 }'>
        <input type='hidden' name='step4' value='${param.step4 }'>
        <input type='hidden' name='step5' value='${param.step5 }'>
    </form>
</DIV>
    <div>
    <button type='button' id='btn_previous'  class="btn btn-dark btn-sm" style="margin-bottom:13px;"><i class="fas fa-caret-left fa-lg"></i></button>
    &nbsp;<span style="font-family: 'Luckiest Guy', cursive; font-size:30px;">RESULT</span>&nbsp;
    <button type='button' id='btn_redo' class="btn btn-dark btn-sm" style="margin-bottom:13px;"><i class="fas fa-redo-alt"></i></button>
    </div>
    <DIV id='panel' style='margin: 30px auto; width: 90%;'></DIV>
    
    <DIV id='panel_img' style='margin: 0px auto; width: 90%;'>
        <DIV id='one' style='display: none;'> <!-- 닭가슴살 추천 필요 -->
            <a href="../../product/list_by_cateno_grid.do?categrpno=6&cateno=7" target='_top'><img id='img1' src="/recommend/cate1.png"></a>
        </DIV>
        <DIV id='two' style='display: none;'>  <!-- 간편요리 추천 -->
            <a href="../../product/list_by_cateno_grid.do?categrpno=6&cateno=8" target='_top'><img id='img1' src="/recommend/cate2.png"></a>
        </DIV>
        <DIV id='three' style='display: none;'> <!-- 샐러드 추천 필요 -->
            <a href="../../product/list_by_cateno_grid.do?categrpno=6&cateno=9" target='_top'><img id='img1' src="/recommend/cate3.png"></a>
        </DIV>
        <DIV id='four' style='display: none;'> <!-- 건강미용 추천 필요 -->
            <a href="../../product/list_by_cateno_grid.do?categrpno=6&cateno=10" target='_top'><img id='img1' src="/recommend/cate4.png"></a>
        </DIV>
        <DIV id='five' style='display: none;'> <!-- 간식 추천 필요 -->
            <a href="../../product/list_by_cateno_grid.do?categrpno=6&cateno=11" target='_top'><img id='img1' src="/recommend/cate5.png"></a>
        </DIV>
    </DIV>
    
    <form id='frm' name='frm' action='' method='GET'>
        <DIV style="text-align:center; ">
            <button type='button' id='btn_next' class="btn btn-dark btn-sm" onclick=' javascript: recommend_product(${sessionScope.memberno })'>등록하고 추천상품 보기</button>
        </DIV>
    </form>
</body>
</html>

