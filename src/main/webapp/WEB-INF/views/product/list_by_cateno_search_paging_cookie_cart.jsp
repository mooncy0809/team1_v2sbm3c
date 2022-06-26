<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>상품 목록, Cart</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">

  <%-- $(function() {
    // var productno = 0;
    // $('#btn_cart').on('click', function() { cart_ajax(productno)});
    //$('#btn_login').on('click', login_ajax);
    //$('#btn_loadDefault').on('click', loadDefault);
  });
  
    로그인
    function login_ajax() {
      var params = "";
      params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
      // params += '&${ _csrf.parameterName }=${ _csrf.token }';
      // console.log(params);
      // return;
      
      $.ajax(
        {
          url: '/member/login_ajax.do',
          type: 'post',  // get, post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function(rdata) { // 응답이 온경우
            var str = '';
            //console.log('-> login cnt: ' + rdata.cnt);  // 1: 로그인 성공
            
            if (rdata.cnt == 1) {
              // 쇼핑카트에 insert 처리 Ajax 호출
              $('#div_login').hide();
              // alert('로그인 성공');
              $('#login_yn').val('YES'); // 로그인 성공 기록
              cart_ajax_post(); // 쇼핑카트에 insert 처리 Ajax 호출     
              
            } else {
              alert('로그인에 실패했습니다.<br>잠시후 다시 시도해주세요.');
              
            }
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function(request, status, error) { // callback 함수
            console.log(error);
          }
        }
      );  //  $.ajax END

    }

  쇼핑 카트에 상품 추가
  function cart_ajax(productno) {
    var f = $('#frm_login');
    $('#productno', f).val(productno);  // 쇼핑카트 등록시 사용할 상품 번호를 저장.
    
    // console.log('-> productno: ' + $('#productno', f).val()); 
    
    // console.log('-> id:' + '${sessionScope.id}');
    if ('${sessionScope.id}' != '' || $('#login_yn').val() == 'YES') {  // 로그인이 되어 있다면
        cart_ajax_post();  // 쇼핑카트에 바로 상품을 담음
    } else { // 로그인 안된 경우
        location.href='/cart/list_by_memberno.do';
    }

  }

  쇼핑카트 상품 등록
  function cart_ajax_post() {
    var f = $('#frm_login');
    var productno = $('#productno', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
    
    var params = "";
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params += 'productno=' + productno;
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

  } --%>

  
</script>
 
</head> 
  
<body>
<jsp:include page="../menu/top2.jsp" />
 
<DIV class='title_line'>
  <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../cate/list_by_categrpno.do?categrpno=${categrpVO.categrpno }" class='title_link'>${categrpVO.name }</A> >
  <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }&now_page=${now_page}" class='title_link'>${cateVO.name }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?cateno=${cateVO.cateno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <input type='text' name='pword' id='pword' value='${param.pword }' style='width: 20%;'>
      <button type='submit'>검색</button>
      <c:if test="${param.pword.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search_paging.do?cateno=${cateVO.cateno}&pword='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
    <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
       <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
       <input type="hidden" name="productno" id="productno" value="productno">
    </FORM>
  
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 60%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="productVO" items="${list }" varStatus="status">
        <c:set var="productno" value="${productVO.productno }" />
        <c:set var="cateno" value="${productVO.cateno }" />
        <c:set var="ptitle" value="${productVO.ptitle }" />
        <c:set var="pcontent" value="${productVO.pcontent }" />
        <c:set var="precom" value="${productVO.precom }" />
        
        <c:set var="pfile1" value="${productVO.pfile1 }" />
        <c:set var="pthumb1" value="${productVO.pthumb1 }" />
        
        <c:set var="price" value="${productVO.price }" />
        <c:set var="dc" value="${productVO.dc }" />
        <c:set var="saleprice" value="${productVO.saleprice }" />
        <c:set var="point" value="${productVO.point }" />
        
        <tr> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${pthumb1.endsWith('jpg') || pthumb1.endsWith('png') || pthumb1.endsWith('gif')}">
                <%-- /static/product/storage/ --%>
                <a href="./read.do?productno=${productno}&now_page=${param.now_page }"><IMG src="/product/storage/${pthumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/product/images/none1.png" style="width: 120px; height: 80px;">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?productno=${productno}&now_page=${param.now_page }&pword=${param.pword}"><strong>${ptitle}</strong> ${pcontent}</a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <del><fmt:formatNumber value="${price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${dc} %</span>
            <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" /></strong><br><%-- 
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /></span>
            <span><A id="recom_${status.count }" href="javascript:recom_ajax(${productno }, ${status.count })" class="recom_link">♥(${recom })</A></span> --%>

            <%-- <span id="span_animation_${status.count }"></span> --%>
            <br><%-- 
            <button type='button' id='btn_cart' class="btn btn-info" style='margin-bottom: 2px;'
                        onclick="cart_ajax(${productno })">장바 구니</button><br>
            <button type='button' id='btn_ordering' class="btn btn-info" 
                        onclick="cart_ajax(${productno })">바로 구매</button>   --%>
                                    
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <A href="./update_text.do?productno=${productno}&now_page=${param.now_page }"><img src='/product/images/update.png'></A>
            <A href="./delete.do?productno=${productno}&now_page=${param.now_page }&cateno=${cateno}"><img src='/product/images/delete.png'></A>
            <A href="./update_file.do?productno=${productno}&now_page=${now_page }">파일 수정</A>  
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>

 
<jsp:include page="../menu/bottom2.jsp" />
</body>
 
</html>