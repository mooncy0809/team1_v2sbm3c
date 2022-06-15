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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function(){
      //$('#btn_login').on('click', login_ajax);
     // $('#btn_loadDefault').on('click', loadDefault);
  });


  
  <%-- 쇼핑 카트에 상품 추가 --%>
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

  <%-- 쇼핑카트 상품 등록 --%>
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
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top2.jsp" flush='false' />
 
<DIV class='title_line'>
  <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../cate/list_by_categrpno.do?categrpno=${categrpVO.categrpno }" class='title_link'>${categrpVO.name }</A> >
  <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }" class='title_link'>${cateVO.name }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
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
      <button type='submit'>검색</button>
      <c:if test="${param.pword.length() > 0 }">
        <button type='button' 
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
                <IMG src="/product/storage/${pfile1saved }" style="width: 100%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/product/images/none1.png" style="width: 100%;"> 
              </c:otherwise>
            </c:choose>
        </DIV>
        <DIV style="width: 47%; height: 260px; float: left; margin-right: 10px; margin-bottom: 30px;">
          <span style="font-size: 1.5em; font-weight: bold;">${ptitle }</span><br>
          <span style="color: #FF0000; font-size: 2.0em;">${dc} %</span>
          <span style="font-size: 1.5em; font-weight: bold;"><fmt:formatNumber value="${saleprice}" pattern="#,###" /> 원</span>
          <del><fmt:formatNumber value="${price}" pattern="#,###" /> 원</del><br>
          <span style="font-size: 1.2em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /> 원</span><br>
          <span style="font-size: 1.0em;">(보유수량: <fmt:formatNumber value="${salecnt}" pattern="#,###" /> 개)</span><br>
          <span style="font-size: 1.0em;">수량</span><br>
          <form>
          <input type='number' name='ordercnt' value='1' required="required" 
                     min="1" max="99999" step="1" class="form-control" style='width: 30%;'><br>
          <button type='button' onclick="cart_ajax(${productno })" class="btn btn-info">장바 구니</button>           
          <button type='button' onclick="" class="btn btn-info">바로 구매</button>
          <button type='button' onclick="" class="btn btn-info">관심 상품</button>
          </form>
        </DIV> 

        <DIV>${pcontent }</DIV>
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
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

