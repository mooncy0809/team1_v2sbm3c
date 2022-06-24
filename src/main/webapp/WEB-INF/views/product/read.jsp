<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="productno" value="${productVO.productno }" />
<c:set var="cateno" value="${productVO.cateno }" />
<c:set var="ptitle" value="${productVO.ptitle }" />        
<c:set var="price" value="${productVO.price }" />
<c:set var="dc" value="${productVO.dc }" />
<c:set var="saleprice" value="${productVO.saleprice }" />
<c:set var="point" value="${productVO.point }" />
<c:set var="salecnt" value="${productVO.salecnt }" />
<c:set var="pfile1" value="${productVO.pfile1 }" />
<c:set var="pfile1saved" value="${productVO.pfile1saved }" />
<c:set var="pthumb1" value="${productVO.pthumb1 }" />
<c:set var="pcontent" value="${productVO.pcontent }" />
<c:set var="pword" value="${productVO.pword }" />
<c:set var="psize1_label" value="${productVO.psize1_label }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>하루삼끼</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css">

<style type="text/css">
.star {
  color:#f90;
  font-size: 2.3rem;
}
</style>

<script type="text/javascript">
  $(function(){

      let review_list; // 댓글 목록

      var frm_review = $('#frm_review');
      
      //$('#btn_login').on('click', login_ajax);
     // $('#btn_loadDefault').on('click', loadDefault);
      list_by_productsno_join(); // 댓글 목록

      $('#btn_add').on('click', list_by_productsno_join_add);  // [더보기] 버튼
      
  });


  
  function buy_ajax(productno) {
      var f = $('#frm_login');
      $('#productno', f).val(productno);  // 쇼핑카트 등록시 사용할 상품 번호를 저장.
       //console.log('-> productno: ' + $('#productno', f).val()); 
      
       //console.log('-> id:' + '${sessionScope.id}');
      if ('${sessionScope.id}' != '' || $('#login_yn').val() == 'YES') {  // 로그인이 되어 있다면
          buy_ajax_post();  // 
      } else { // 로그인 안된 경우
          location.href='/cart/list_by_memberno.do';
      }

    }

  <%-- 쇼핑카트 상품 등록 --%>
  function buy_ajax_post() {
      var f = $('#frm_login');
      var productno = $('#productno', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
      var params = "";
      var order_cnt = $('#order_cnt');
      var ordercnt = $( '#ordercnt', order_cnt ).val();
      // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
      params += 'productno=' + productno; 
      params += '&ordercnt=' + ordercnt ;
      params += '&${ _csrf.parameterName }=${ _csrf.token }';
      // console.log('-> cart_ajax_post: ' + params);
      // return;
      
      $.ajax(
        {
          url: '/cart/create.do',
          type: 'post',  // get, post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function(rdata) { // 응답이 온경우
            var str = '';
            //console.log('-> cart_ajax_post cnt: ' + rdata.cnt);  // 1: 쇼핑카트 등록 성공
            
            if (rdata.cnt == 1) {
                location.href='../order_pay/create.do';
            } else {
              alert('오류오류');
            }
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function(request, status, error) { // callback 함수
            console.log(error);
          }
        }
      );  //  $.ajax END

  }
    
  
  <%-- 쇼핑 카트에 상품 추가 --%>
  function cart_ajax(productno) {
    var f = $('#frm_login');
    $('#productno', f).val(productno);  // 쇼핑카트 등록시 사용할 상품 번호를 저장.
    
     //console.log('-> productno: ' + $('#productno', f).val()); 
    
     //console.log('-> id:' + '${sessionScope.id}');
    if ('${sessionScope.id}' != '' || $('#login_yn').val() == 'YES') {  // 로그인이 되어 있다면
        
        cart_ajax_post();  // 쇼핑카트에 바로 상품을 담음
    } else { // 로그인 안된 경우
        location.href='/cart/list_by_memberno.do';
    }

  }

  <%-- 쇼핑카트 상품 등록 --%>
  function cart_ajax_post() {
    var f = $('#frm_login');
    var productno = $('#productno', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
    var params = "";
    var order_cnt = $('#order_cnt');
    var ordercnt = $( '#ordercnt', order_cnt ).val();
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params += 'productno=' + productno; 
    params += '&ordercnt=' + ordercnt ;
    params += '&${ _csrf.parameterName }=${ _csrf.token }';

    // console.log('-> cart_ajax_post: ' + params);
    // return;
    
    $.ajax(
      {
        url: '/cart/create.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          //console.log('-> cart_ajax_post cnt: ' + rdata.cnt);  // 1: 쇼핑카트 등록 성공
          
          if (rdata.cnt == 1) {
            var sw = confirm('선택한 상품이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?');
            if (sw == true) {
              // 쇼핑카트로 이동
              location.href='/cart/list_by_memberno.do';
            }           
          } else {
            alert('선택한 상품을 장바구니에 담지못했습니다.<br>잠시후 다시 시도해주세요.');
            
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  }

  // contentsno 별 소속된 리뷰 목록
  function list_by_productsno_join() {
    var params = 'productno=' + ${productno };

    $.ajax({
      url: "../review/list_by_productsno_join.do", // action 대상 주소
      type: "get",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = '';
        
        $('#review_list').html(''); // 패널 초기화, val(''): 안됨

     // -------------------- 전역 변수에 리뷰 목록 추가 --------------------
        review_list = rdata.list;
        // -------------------- 전역 변수에 리뷰 목록 추가 --------------------
        // alert('rdata.list.length: ' + rdata.list.length);
        
        var last_index=1; 
        if (rdata.list.length >= 2 ) { // 글이 2건 이상이라면 2건만 출력
          last_index = 2
        }
        
        for (i=0; i < last_index; i++) {
          var row = rdata.list[i];

          if (row.score == 1) {
              msg += "<label for='5-stars' class='star'>&#9733;</label>"
          } else if (row.score == 2){
              msg += "<label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label>";
          }else if (row.score == 3){
              msg += "<label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label>";
          }else if (row.score == 4){
              msg += "<label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label>";
          }else if (row.score == 5){
              msg += "<label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label>";
          }
          
          msg += "<DIV id='"+row.reviewno+"' style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
          msg += "<span style='font-weight: bold;'><A href='../review/read.do?reviewno="+ row.reviewno + "'" +" target='_blank' onclick='window.open(this.href, 'popup test', 'width=430, height=500, location=no, status=no, scrollbars=yes'); return false;'>" + row.rtitle + "</A>" + " /  "+ "작성자: "+row.mname + "</span>";
          msg += "&nbsp; <i class='fa-solid fa-eye' >"+ row.cnt + "</i>";
          msg += "  " + row.rdate;
          
          if ('${sessionScope.memberno}' == row.memberno) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
            msg += " <A href='javascript:review_delete("+row.reviewno+")'><IMG src='/review/images/delete.png'></A>";
          }
          
          if(row.thumb1.length >= 1){
              msg += "  " + "<br>";
              msg += "<IMG src='/review/storage/"+row.thumb1 + "'" + 'style="width: 120px; height: 80px;">'
          }
          msg += "  " + "<br>";
          msg += row.rcontent;
          msg += "</DIV>";
        }
        // alert(msg);
        $('#review_list').append(msg);
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });
    
  }

//댓글 삭제 레이어 출력
  function review_delete(reviewno) {
    // alert('replyno: ' + replyno);
    var frm_review_delete = $('#frm_review_delete');
    $('#reviewno', frm_review_delete).val(reviewno); // 삭제할 댓글 번호 저장
    $('#modal_panel_delete').modal();             // 삭제폼 다이얼로그 출력
  }

  // 댓글 삭제 처리
  function review_delete_proc(reviewno) {
    // alert('replyno: ' + replyno);
    var params = $('#frm_review_delete').serialize();
    $.ajax({
      url: "../review/delete.do", // action 대상 주소
      type: "post",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";
        
        $('#btn_frm_review_delete_close').trigger("click"); // 삭제폼 닫기, click 발생 
            
        $('#' + reviewno).remove(); // 태그 삭제
              
            return; // 함수 실행 종료
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });
  }

//// [더보기] 버튼 처리
  function list_by_productsno_join_add() {
    // alert('list_by_contentsno_join_add called');
    
    let cnt_per_page = 2; // 2건씩 추가
    let reviewPage=parseInt($("#review_list").attr("data-reviewPage"))+cnt_per_page; // 2
    $("#review_list").attr("data-reviewPage", reviewPage); // 2
    
    var last_index=reviewPage + 2; // 4
    
    var msg = '';
    for (i=reviewPage; i < last_index; i++) {
      var row = review_list[i];

      if (row.score == 1) {
          msg += "<label for='5-stars' class='star'>&#9733;</label>"
      } else if (row.score == 2){
          msg += "<label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label>";
      }else if (row.score == 3){
          msg += "<label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label>";
      }else if (row.score == 4){
          msg += "<label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label>";
      }else if (row.score == 5){
          msg += "<label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label> <label for='5-stars' class='star'>&#9733;</label>";
      }
      
      msg += "<DIV id='"+row.reviewno+"' style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
      msg += "<span style='font-weight: bold;'><A href='../review/read.do?reviewno="+ row.reviewno + "'" +" target='_blank' onclick='window.open(this.href, 'popup test', 'width=430, height=500, location=no, status=no, scrollbars=yes'); return false;'>" + row.rtitle + "</A>" + " /  "+ "작성자: "+row.mname + "</span>";
      /* msg += "<span style='font-weight: bold;'>" + row.id + "</span>"; */
      msg += "&nbsp; <i class='fa-solid fa-eye' >"+ row.cnt + "</i>";
      msg += "  " + row.rdate;
      
      if ('${sessionScope.memberno}' == row.memberno) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
        msg += " <A href='javascript:review_delete("+row.reviewno+")'><IMG src='/review/images/delete.png'></A>";
      }
      msg += "  " + "<br>";
      msg += "<IMG src='/review/storage/"+row.thumb1 + "'" + 'style="width: 120px; height: 80px;">'
      msg += "  " + "<br>";     
      msg += row.rcontent;
      msg += "</DIV>";

      // alert('msg: ' + msg);
      $('#review_list').append(msg);
    }    
  }
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top2.jsp" flush='false' />
<DIV class='content_body' style="width:70%;">
<!-- Modal 알림창 시작 -->
<div class="modal fade" id="modal_panel" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" id="modal_x" class="close" data-dismiss="modal">×</button>
        <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
      </div>
      <div class="modal-body">
        <p id='modal_content'></p>  <!-- 내용 -->
      </div>
      <div class="modal-footer">
        <button type="button" id="modal_close" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div> <!-- Modal 알림창 종료 -->

<!-- -------------------- 리뷰 삭제폼 시작 -------------------- -->
<div class="modal fade" id="modal_panel_delete" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
<!--       <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h4 class="modal-title">리뷰 삭제</h4>제목
      </div> -->
      <div class="modal-body">
        <form name='frm_review_delete' id='frm_review_delete'>
          <input type='hidden' name='reviewno' id='reviewno' value=${reviewno }>
          
           <h4>리뷰를 삭제하시겠습니까?</h4>
          
          <DIV id='modal_panel_delete_msg' style='color: #AA0000; font-size: 1.1em;'></DIV>
        </form>
      </div>
      <div class="modal-footer">
        <button type='button' class='btn btn-danger' 
                     onclick="review_delete_proc(frm_review_delete.reviewno.value); frm_review_delete.passwd.value='';">삭제</button>

        <button type="button" class="btn btn-default" data-dismiss="modal" 
                     id='btn_frm_review_delete_close'>Close</button>
      </div>
    </div>
  </div>
</div>
<!-- -------------------- 리뷰 삭제폼 종료 -------------------- -->
 


<DIV class='content_body'>
  <ASIDE class="aside_right" > 
    <A href="javascript:history.back();">뒤로가기</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <c:choose>
        <c:when test="${param.pword != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='pword' id='pword' value='${param.pword }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='pword' id='pword' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit' style="background-color: #E2E8DE;
    border-color: #E2E8DE;">검색</button>
      <c:if test="${param.pword.length() > 0 }">
        <button type='button'  style="background-color: #E2E8DE;
    border-color: #E2E8DE;"
                     onclick="location.href='./list_by_cateno_search_paging.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
        <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
          <input type="hidden" name="productno" id="productno" value="productno">
          </FORM>
  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 50%; float: left; margin-right: 10px;">
            <c:choose>
              <c:when test="${pthumb1.endsWith('jpg') || pthumb1.endsWith('png') || pthumb1.endsWith('gif')}">
                <%-- /static/product/storage/ --%>
                <IMG src="/product/storage/${pfile1saved }" style="width: 90%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/product/images/none1.png" style="width: 90%;"> 
              </c:otherwise>
            </c:choose>
        </DIV>
        <DIV style="/* width: 48%; height: 260px; float: left; */ margin-right: 10px; margin-bottom: 30px;">
          <span style="font-size: 1.5em; font-weight: bold;">${ptitle }</span><br><hr style="border-top: 1px solid #bbb;">
          판매가격 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <span style="font-size: 1.5em; font-weight: bold;"><fmt:formatNumber value="${saleprice}" pattern="#,###" /> 원</span>
                    <del><fmt:formatNumber value="${price}" pattern="#,###" /> 원</del>&nbsp;&nbsp;<span style="color: #FF0000; font-size: 2.0em;">${dc} %</span>
                    <br><hr style="border-top: 1px solid #bbb;">
          포인트 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 1.2em;"> <fmt:formatNumber value="${point}" pattern="#,###" /> 원</span><br>
<%--           <span style="font-size: 1.0em;">(보유수량: <fmt:formatNumber value="${salecnt}" pattern="#,###" /> 개)</span><br>
    --%>       <hr style="border-top: 1px solid #bbb;">
          <span style="font-size: 1.0em;">수량</span><br>
          <form name='order_cnt' id='order_cnt' method='POST' action='../cart/create.do'>
          <input type='number' name='cnt' id='ordercnt' value='1' required="required" 
                     min="1" max="99999" step="1" class="form-control" style='width: 30%;'/><br>
          <button type='button' onclick="cart_ajax(${productno })" class="btn btn-info">장바구니</button>           
          <button type='button' onclick="buy_ajax(${productno})" class="btn btn-info">바로 구매</button>
          <button type='button' onclick="" class="btn btn-info">관심 상품</button>
          </form>
        </DIV> 

<%--         <DIV>${pcontent }</DIV>
      </li>
      <li class="li_none">
        <DIV style='text-decoration: none;'>
          검색어(키워드): ${pword }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${pfile1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/product/storage&filename=${pfile1saved}&downname=${pfile1}'>${pfile1}</A> (${psize1_label})  
          </c:if>
        </DIV>
      </li>  --%>  
    </ul>
  </fieldset>

</DIV>

<!-- ------------------------------ 리뷰 영역 시작 ------------------------------ -->
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
<DIV style='width: 80%; margin: 0px auto;'>
    <div style="width:70%; font-size: 1.2em; font-weight: bold;">리뷰</div>
    <HR>
    <DIV id='review_list' data-reviewpage='0'>  <%-- 댓글 목록 --%>
    
    </DIV>
    <DIV id='review_list_btn' style='border: solid 1px #EEEEEE; margin: 0px auto; width: 100%; background-color: #EEFFFF;'>
        <button id='btn_add' style='width: 100%;'>더보기 ▽</button>
    </DIV> 
  
</DIV>
</DIV>
<!-- ------------------------------ 리뷰 영역 종료 ------------------------------  -->
 
<jsp:include page="../menu/bottom2.jsp" flush='false' />
</body>
 
</html>
