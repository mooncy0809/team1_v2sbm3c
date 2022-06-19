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
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    <script type="text/javascript">
        $(function() {
            send();  // Django ajax 호출
            $('#btn_previous').on('click', function() { history.back(); });   // 이전
            $('#btn_close').on('click', function() { window.close(); });      // 윈도우 닫기
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
               print(rdata.index);
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
            $('#panel').html("<img src='/recommend/ani04.gif' style='width: 10%;'>");
            $('#panel').show(); // 숨겨진 태그의 출력
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
<body>

<DIV style='display: none;'>
    <form name='frm' id='frm'>
        <input type='hidden' name='step1' value='${param.step1 }'>
        <input type='hidden' name='step2' value='${param.step2 }'>
        <input type='hidden' name='step3' value='${param.step3 }'>
        <input type='hidden' name='step4' value='${param.step4 }'>
        <input type='hidden' name='step5' value='${param.step5 }'>
    </form>
</DIV>

<DIV class="container">
    <H2>참여해주셔서 감사합니다.</H2>
    <H2>추천 카테고리</H2>

    <DIV id='panel' style='margin: 30px auto; width: 90%;'></DIV>
    
    <DIV id='panel_img' style='margin: 0px auto; width: 90%;'>
        <DIV id='one' style='display: none;'> <!-- 닭가슴살 추천 필요 -->
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/recommend/images/v11.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/recommend/images/v12.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/recommend/images/v13.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img4' src="/recommend/images/v14.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img5' src="/recommend/images/v15.jpg" style='float:left; height: 200px'>
                    </TD>
                </TR>          
            </TABLE>
            <h2>닭가슴살 카테고리에서 쇼핑추천!</h2>
        </DIV>
        <DIV id='two' style='display: none;'>  <!-- 간편요리 추천 -->
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/recommend/images/v21.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/recommend/images/v22.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/recommend/images/v23.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img4' src="/recommend/images/v24.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img5' src="/recommend/images/v25.jpg" style='float:left; height: 200px'>
                    </TD>
                </TR>          
            </TABLE>
            <h2>간편요리 카테고리에서 쇼핑추천!</h2>
        </DIV>
        <DIV id='three' style='display: none;'> <!-- 샐러드 추천 필요 -->
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/recommend/images/v31.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/recommend/images/v32.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/recommend/images/v33.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img4' src="/recommend/images/v34.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img5' src="/recommend/images/v35.jpg" style='float:left; height: 200px'>
                    </TD>
                </TR>          
            </TABLE>
            <h2>샐러드 카테고리에서 쇼핑추천!</h2>
        </DIV>
        <DIV id='four' style='display: none;'> <!-- 건강미용 추천 필요 -->
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/recommend/images/v41.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/recommend/images/v42.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/recommend/images/v43.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img4' src="/recommend/images/v44.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img5' src="/recommend/images/v45.jpg" style='float:left; height: 200px'>
                    </TD>
                </TR>          
            </TABLE>
            <h2>건강미용 카테고리에서 쇼핑추천!</h2>
        </DIV>
        <DIV id='five' style='display: none;'> <!-- 간식 추천 필요 -->
            <TABLE style='margin: 0px auto;'>
                <TR>
                    <TD class='td_image'>
                        <img id='img1' src="/recommend/images/v51.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img2' src="/recommend/images/v52.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img3' src="/recommend/images/v53.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                    
                        <img id='img4' src="/recommend/images/v54.jpg" style='float:left; height: 200px'>
                    </TD>
                    <TD class='td_image'>
                        <img id='img5' src="/recommend/images/v55.jpg" style='float:left; height: 200px'>
                    </TD>
                </TR>          
            </TABLE>
            <h2>간식 카테고리에서 쇼핑추천!</h2>
        </DIV>
    </DIV>
    
    <form id='frm' name='frm' action='' method='GET'>
        <br>
        <DIV style="text-align:center;">
            <button type='button' id='btn_previous' class="btn btn-info">이전</button>
            <button type='button' id='btn_close' class="btn btn-info">종료</button>
        </DIV>
    </form>
</DIV>
</body>
</html>

