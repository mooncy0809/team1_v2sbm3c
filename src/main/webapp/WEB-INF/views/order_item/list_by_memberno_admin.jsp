<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>하루삼끼</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
 
<script type="text/javascript">
$(function() { 
    $('#btn_update_cancel').on('click', cancel);
    $('#btn_delete_cancel').on('click', cancel);
    
});

// 수정
function read_update_ajax(order_itemno) { // 수정
    $('#panel_update').css('display', '');  // 태그 출력 

    var params = "";
    params = 'order_itemno=' + order_itemno; // 공백이 값으로 있으면 안됨.

    $.ajax(
      {
        url: '/order_item/read_ajax.do',
        type: 'get',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
          let order_payno = rdata.order_payno;
          let order_itemno = rdata.order_itemno;
          let stateno = rdata.stateno;

          let frm_update = $('#frm_update'); //document.frm_update
          $('#order_payno', frm_update).val(order_payno);
          $('#order_itemno', frm_update).val(order_itemno);
          $('#stateno', frm_update).val(stateno);     
     
          $('#span_animation').hide();
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

    $('#span_animation').css('text-align', 'center');
    $('#span_animation').html("<img src='/contents/images/ani02.gif' style='width: 20%;'>");
    $('#span_animation').show(); // 숨겨진 태그의 출력
}

function cancel() { // 초기 상태로 변경
    $('#panel_update').css('display', 'none');  // 태그 출력 
    $('#panel_delete').css('display', 'none');  // 태그 출력 
    $('#btn_submit').css('dis')
}  



//삭제 폼(자식 레코드가 없는 경우의 삭제)
function read_delete_ajax(order_itemno) {
  $('#btn_submit').show();  // 삭제 버튼 출력
    
  $('#panel_update').css("display","none"); // 태그를 숨김  
  $('#panel_delete').css("display",""); // show, 숨겨진 태그 출력 
  // return;
  
  let params = "";
  // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  params = 'order_itemno=' + order_itemno; // 공백이 값으로 있으면 안됨.
  
  $.ajax(
    {
      url: '/order_item/read_ajax.do',
      type: 'get',  // get, post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
        let order_itemno = rdata.order_itemno;
        let productno = rdata.productno;

        let frm_delete = $('#frm_delete');
        $('#order_itemno', frm_delete).val(order_itemno);
        
        $('#frm_delete_order_itemno').html(order_itemno);  // <label>그룹 이름</label><span id='frm_delete_name'></span>  
        $('#frm_delete_productno').html(productno);
        console.log('-> frm_delete_productno: ' + $('#frm_delete_productno').html(productno));

        $('#btn_submit').show();  // 삭제 버튼 출력


        $('#span_animation_delete').hide();
      },
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    }
  );  //  $.ajax END


  $('#span_animation_delete').css('text-align', 'center');
  $('#span_animation_delete').html("<img src='/contents/images/ani02.gif' style='width: 20%;'>");
  $('#span_animation_delete').show(); // 숨겨진 태그의 출력
} 
  
</script>
</head> 
 
<body>
<jsp:include page="../menu/top2.jsp" flush='false' />
<div class="content">
    <section id="cart_items">
    <div class="container">
            <div class="breadcrumbs">
                <ol class="breadcrumb">
                  <li><a>Manage</a></li>
                  <li class="active"><a href="../order_pay/list_by_memberno_search_paging_all.do?memberno=${memberno}&word=">주문내역 관리</a></li>
                  <li class="active"><a href="javascript:location.reload();">주문상태 관리</a></li>
                </ol>
            </div>
  <div class="table-responsive cart_info" > 
   
    <!-- 수정폼 -->
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display: none;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      
      <label>주문 번호</label>
      <input type='number' id='order_payno' name='order_payno' value='' required="required" style='width:30px' readonly/>
      <label>주문 상세번호</label>
      <input type='number' id='order_itemno' name='order_itemno' value='' required="required" style='width: 30px' readonly/>
      <label>배송상태</label>
      <select  id='stateno' name='stateno' style="width:20%;">
        <option value=1>결제 완료</option>
        <option value=2>상품 준비중</option>
        <option value=3>배송 시작</option>
        <option value=4>배송중</option>
        <option value=5>오늘 도착</option>
        <option value=6>배달 완료</option>
      </select>
  
      <button type="submit" id='submit' class='btn btn-secondary btn-sm'>저장</button>
      <button type="button" onclick="cancel();" class='btn btn-secondary btn-sm'>취소</button><br>
      
      <span id='span_animation'></span>
    </FORM>
  </DIV>
  
    <%-- 삭제폼 --%>
  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; 
          width: 100%; text-align: center; display: none;'>
    <div class="msg_warning">주문정보를 삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
      <input type='hidden' name='order_itemno' id='order_itemno' value=''>
        
      <label>주문 상세번호</label>: <span id='frm_delete_order_itemno'></span>  
      <label>상품 번호</label>: <span id='frm_delete_productno'></span>
      
      &nbsp;<button type="submit" id='btn_submit' class='btn btn-secondary btn-sm'>삭제</button>
      &nbsp;<button type="button" id='btn_delete_cancel' class='btn btn-secondary btn-sm'>취소</button>
      <br>
      <span id='span_animation_delete'></span>
      
    </FORM>
  </DIV>
  <table class="table table-condensed"style="margin-bottom:0px;">
    <colgroup>
      <col style='width: 7%;'/>
      <col style='width: 7%;'/>
      <col style='width: 26%;'/>
      <col style='width: 5%;'/>
      <col style='width: 5%;'/>
      <col style='width: 5%;'/>
      <col style='width: 10%;'/>
      <col style='width: 15%;'/>
      <col style='width: 10%;'/>
     
    </colgroup>
    <TR class="cart_menu">
      <TD class='th_bs'>주문번호</TD>
      <TD class='th_bs'>상품번호</TD>
      <TD class='th_bs'>상품명</TD>
      <TD align="center" class='th_bs'>가격</TD>
      <TD align="center" class='th_bs'>수량</TD>
      <TD align="center" class='th_bs'>금액</TD>
      <TD align="center" class='th_bs'>배송상태</TD>
      <TD align="center" class='th_bs'>주문일</TD>
      <TD align="center" class='th_bs'> </TD>
    </TR>
   
    <c:forEach var="order_itemVO" items="${list }">
      <c:set var="order_payno" value ="${order_itemVO.order_payno}" />
      <c:set var="order_itemno" value ="${order_itemVO.order_itemno}" />
      <c:set var="memberno" value ="${order_itemVO.memberno}" />
      <c:set var="productno" value ="${order_itemVO.productno}" />
      <c:set var="ptitle" value ="${order_itemVO.ptitle}" />
      <c:set var="saleprice" value ="${order_itemVO.saleprice}" />
      <c:set var="cnt" value ="${order_itemVO.cnt}" />
      <c:set var="tot" value ="${order_itemVO.tot}" />
      <c:set var="stateno" value ="${order_itemVO.stateno}" />
      <c:set var="rdate" value ="${order_itemVO.rdate}" />
         
    <TR>
      <TD class="description">${order_payno}</TD>
      <TD class="description"><A href="/product/read.do?productno=${productno}">${productno}</A></TD>
      <TD class="description">${ptitle}</TD>
      <TD align="center" class="description"><fmt:formatNumber value="${saleprice }" pattern="#,###" /></TD>
      <TD align="center" class="description">${cnt }</TD>
      <TD align="center" class="description"><fmt:formatNumber value="${tot }" pattern="#,###" /></TD>
      <TD align="center" class="description">
        <c:choose>
          <c:when test="${stateno == 1}">결제 완료</c:when>
          <c:when test="${stateno == 2}">상품 준비중</c:when>
          <c:when test="${stateno == 3}">배송 시작</c:when>
          <c:when test="${stateno == 4}">배송중</c:when>
          <c:when test="${stateno == 5}">오늘 도착</c:when>
          <c:when test="${stateno == 6}">배달 완료</c:when>
        </c:choose>
      </TD>
      <TD align="center" class="description">${rdate.substring(1,16) }</TD>
      
    <TD align="center" class="description">
        <input type="hidden" name="order_itemno" value="${order_itemno }">
        <input type="hidden" name="productno" value="${productno }">
        <A href="javascript: read_update_ajax(${order_itemno })" title="수정"><i class="fas fa-edit"></i></A>
        <A href="javascript: read_delete_ajax(${order_itemno })"title="삭제"><i class="fas fa-eraser"></i></A>
    </TD>
    </TR>
    </c:forEach>
  </TABLE>
  </div>
  
  <table class="table table-condensed">
    <TR>
      <TD colspan="10"  style="text-align: right; font-size: 1.3em; font-weight:bold;">
        배송비: <fmt:formatNumber value="${baesong_tot }" pattern="#,###" />&nbsp;&nbsp;&nbsp;&nbsp; 
        총 주문 금액: <fmt:formatNumber value="${total_order }" pattern="#,###" />
      </TD>
    </TR>  
  </table>

  </div>
  </section>
 </div>
<jsp:include page="../menu/bottom.jsp" flush='false' />
 </body>
</html>