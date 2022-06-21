<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko">
<head> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>장바구니 | 하루삼끼</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">  
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<style>
.chg{
    border: 3px solid #E2E8DE;
    background-color: #E2E8DE;
    color: gray; 
    position: relative; 
    border-radius: 5px;
}
.chg:hover{
    background-color: #E2E8DE;
    color:white;
}
.chg:focus{
    border: 3px solid #E2E8DE;
    outline:none;
}
</style>
<script type="text/javascript">
  function delete_func(cartno) {  // GET -> POST 전송, 상품 삭제
    var frm = $('#frm_post');
    frm.attr('action', './delete.do');
    $('#cartno',  frm).val(cartno);
    
    frm.submit();
  }   

  function update_cnt(cartno) {  // 수량 변경
    var frm = $('#frm_post');
    frm.attr('action', './update_cnt.do');
    $('#cartno',  frm).val(cartno);
    
    var new_cnt = $('#' + cartno + '_cnt').val();  // $('#1_cnt').val()로 변환됨.
    $('#cnt',  frm).val(new_cnt);

    // alert('cnt: ' + $('#cnt',  frm).val());
    // alert('cartno: ' + $('#cartno',  frm).val());
    // return;
    
    frm.submit();
    
  }
</script>

<style type="text/css">

    
</style>
 
</head> 
 
<body>
<jsp:include page="../menu/top2.jsp" />
<%-- GET -> POST: 상품 삭제, 수량 변경용 폼 --%>
<form name='frm_post' id='frm_post' action='' method='post'>
  <input type='hidden' name='cartno' id='cartno'>
  <input type='hidden' name='cnt' id='cnt'>
</form>
    <section id="cart_items">
    <div class="container">
            <div class="breadcrumbs">
                <ol class="breadcrumb">
                  <li><a href="/product/list_by_cateno_grid.do?categrpno=6&cateno=7">Home</a></li>
                  <li class="active"><a href="javascript:location.reload();">Shopping Cart</a></li>
                </ol>
            </div>

    <div class="table-responsive cart_info">
    
  <table class="table table-condensed">
     <colgroup>
      <col style="width: 15%;"></col>
      <col style="width: 35%;"></col>
      <col style="width: 15%;"></col>
      <col style="width: 15%;"></col>
      <col style="width: 14%;"></col>
      <col style="width: 6%;"></col>
    </colgroup>
                    <thead>
                        <tr class="cart_menu">
                            <td class="image">Item</td>
                            <td class="description"></td>
                            <td class="price">Price</td>
                            <td class="quantity">Quantity</td>
                            <td class="total">Total</td>
                            <td> </td>
                        </tr>
                    </thead>
    <%-- table 내용 --%>
    <tbody>
      <c:choose>
        <c:when test="${list.size() > 0 }"> <%-- 상품이 있는지 확인 --%>
          <c:forEach var="cartVO" items="${list }">  <%-- 상품 목록 출력 --%>
            <c:set var="cartno" value="${cartVO.cartno }" />
            <c:set var="productno" value="${cartVO.productno }" />
            <c:set var="ptitle" value="${cartVO.ptitle }" />
            <c:set var="pthumb1" value="${cartVO.pthumb1 }" />
            <c:set var="price" value="${cartVO.price }" />
            <c:set var="dc" value="${cartVO.dc }" />
            <c:set var="saleprice" value="${cartVO.saleprice }" />
            <c:set var="point" value="${cartVO.point }" />
            <c:set var="memberno" value="${cartVO.memberno }" />
            <c:set var="cnt" value="${cartVO.cnt }" />
            <c:set var="tot" value="${cartVO.tot }" />
            <c:set var="rdate" value="${cartVO.rdate }" />
            
            <tr> 
              <td class="cart_product">
                <c:choose>
                  <c:when test="${pthumb1.endsWith('jpg') || pthumb1.endsWith('png') || pthumb1.endsWith('gif')}">
                    <%-- /static/product/storage/ --%>
                    <a href="/product/read.do?productno=${productno}"><IMG src="/product/storage/${pthumb1 }" style="width: 100px; height: 100px;"></a> 
                  </c:when>
                  <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                    ${productVO.pfile1}
                  </c:otherwise>
                </c:choose>
              </td>  
              <td class="cart_description">
                <h4><a href="/product/read.do?productno=${productno}">${ptitle}</a></h4>
              </td> 
              <td class="cart_price">
                <del><fmt:formatNumber value="${price}" pattern="#,###" /></del><br>
                <span style="color: #FF0000; font-size: 1.2em;">${dc} %</span>
                <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" /></strong><br>
                <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /></span>
              </td>
              <td  class="cart_quantity">
              <div class="cart_quantity_button">
                <input class="cart_quantity_input" type='number' id='${cartno }_cnt' min='1' max='100' step='1' value="${cnt }" 
                  style='width: 52px;'>&nbsp;
                <button class="chg" onclick="update_cnt(${cartno})" type="button">변경</button>
                </div>
              </td>
              <td class="cart_total">
                <p class="cart_total_price"><fmt:formatNumber value="${tot}" pattern="#,###" /></p>
              </td>
              <td class="cart_delete" style="margin:auto; padding-right:50px; text-align:left;">
                <a class="cart_quantity_delete" href="javascript: delete_func(${cartno })"><i class="fa fa-times"></i></a>
              </td>
            </tr>
          </c:forEach>
        
        </c:when>
        <c:otherwise>
          <tr>
            <td colspan="6" style="text-align: center; font-size: 1.3em; padding:30px;">장바구니 상품을 담아보세요.<br>
            <a href=" /product/list_by_cateno_grid.do?categrpno=6&cateno=7"><button class="chg" type="button">상품 구경하러 가기</button></a></td>     
          </tr>
        </c:otherwise>
      </c:choose>
      
      
    </tbody>
  </table>
  </div>
  </div>
  </section> <!--/#cart_items-->
  
  <section id="do_action">
  <div class="container">
  <table class="table table-striped" style='margin-top: 50px; margin-bottom: 50px; width: 100%;'>
    <tbody>
      <tr>
        <td style='margin:100px auto; width: 50%;'>
          <div class='cart_label' style="font-size: 17px;">상품 금액 : <fmt:formatNumber value="${tot_sum }" pattern="#,###" /> 원</div>
          
          <div class='cart_label' style="font-size: 17px;">포인트 : <fmt:formatNumber value="${point_tot }" pattern="#,###" /> 원 </div>
          
          <div class='cart_label' style="font-size: 17px; font-weight:bold;">배송비 : <fmt:formatNumber value="${baesong_tot }" pattern="#,###" /> 원</div>
        </td>
        <td style='width: 50%;'>
          <div class='cart_label' style='font-size: 2.0em;'>전체 주문 금액</div>
          <div class='cart_price'  style='font-size: 2.0em; color: #FF0000;'><fmt:formatNumber value="${total_ordering }" pattern="#,###" /> 원</div>
          
          <form name='frm' id='frm' style='margin-top: 50px;' action="/order_pay/create.do" method='get'>
            <button type='submit' class='chg' style='font-size: 1.5em;'>주문하기</button>
          </form>
        <td>
      </tr>
    </tbody>
  </table>   
</dIv>
</section>

 
<jsp:include page="../menu/bottom2.jsp" />
</body>
 
</html>

