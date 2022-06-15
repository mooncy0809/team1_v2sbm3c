<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko">
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>하루 삼끼</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
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
 
<DIV class='title_line'>
  쇼핑카트입니다
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="/product/list_by_cateno_grid.do">쇼핑 계속하기</A>
    <span class='menu_divide' >│</span>    
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 
</DIV>
  <DIV class='menu_line'></DIV>
    <div class="container">
            <div class="row">
                <div class="col-sm-3">
                    <div class="left-sidebar">
                        <h2>Category</h2>
                        <div class="panel-group category-products" id="accordian"><!--category-productsr-->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordian" href="#sportswear">
                                            <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                            전체 카테고리
                                        </a>
                                    </h4>
                                </div>
                                <div id="sportswear" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <ul>
                                            <li><a href="">닭가슴살</a></li>
                                            <li><a href="">간편요리</a></li>
                                            <li><a href="">샐러드 </a></li>
                                            <li><a href="">건강미용</a></li>
                                            <li><a href="">간식 </a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a href="#">베스트</a></h4>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a href="#">특가</a></h4>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a href="#">신상품</a></h4>
                                </div>
                            </div>
                        </div><!--/category-productsr-->
                    
                        <div class="brands_products"><!--brands_products-->
                            <h2>Brands</h2>
                            <div class="brands-name">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href=""> <span class="pull-right"></span>맛있닭</a></li>
                                    <li><a href=""> <span class="pull-right"></span>굽네</a></li>
                                    <li><a href=""> <span class="pull-right"></span>참프레</a></li>
                                    <li><a href=""> <span class="pull-right"></span>러브잇</a></li>
                                </ul>
                            </div>
                        </div><!--/brands_products-->
                        
                        <div class="price-range"><!--price-range-->
                            <h2>Price Range</h2>
                            <div class="well">
                                 <input type="text" class="span2" value="" data-slider-min="0" data-slider-max="600" data-slider-step="5" data-slider-value="[250,450]" id="sl2" ><br />
                                 <b>0</b> <b class="pull-right">10000</b>
                            </div>
                        </div><!--/price-range-->
                        
                    </div>
                </div>
    
  <table class="table table-striped" style='width: 70%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col> <%-- 수량 --%>
      <col style="width: 10%;"></col> <%-- 합계 --%>
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
              <td style='vertical-align: middle; text-align: center;'>
                <c:choose>
                  <c:when test="${pthumb1.endsWith('jpg') || pthumb1.endsWith('png') || pthumb1.endsWith('gif')}">
                    <%-- /static/product/storage/ --%>
                    <a href="/product/read.do?productno=${productno}"><IMG src="/product/storage/${pthumb1 }" style="width: 120px; height: 80px;"></a> 
                  </c:when>
                  <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                    ${productVO.pfile1}
                  </c:otherwise>
                </c:choose>
              </td>  
              <td style='vertical-align: middle;'>
                <a href="/product/read.do?productno=${productno}"><strong>${ptitle}</strong></a> 
              </td> 
              <td style='vertical-align: middle; text-align: center;'>
                <del><fmt:formatNumber value="${price}" pattern="#,###" /></del><br>
                <span style="color: #FF0000; font-size: 1.2em;">${dc} %</span>
                <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" /></strong><br>
                <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /></span>
              </td>
              <td style='vertical-align: middle; text-align: center;'>
                <input type='number' id='${cartno }_cnt' min='1' max='100' step='1' value="${cnt }" 
                  style='width: 52px;'><br>
                <button type='button' onclick="update_cnt(${cartno})" class='btn' style='margin-top: 5px;'>변경</button>
              </td>
              <td style='vertical-align: middle; text-align: center;'>
                <fmt:formatNumber value="${tot}" pattern="#,###" />
              </td>
              <td style='vertical-align: middle; text-align: center;'>
                <A href="javascript: delete_func(${cartno })"><IMG src="/cart/images/delete3.png"></A>
              </td>
            </tr>
          </c:forEach>
        
        </c:when>
        <c:otherwise>
          <tr>
            <td colspan="6" style="text-align: center; font-size: 1.3em;">쇼핑 카트에 상품이 없습니다.</td>
          </tr>
        </c:otherwise>
      </c:choose>
      
      
    </tbody>
  </table>
  
  <table class="table table-striped" style='margin-top: 50px; margin-bottom: 50px; width: 100%;'>
    <tbody>
      <tr>
        <td style='width: 50%;'>
          <div class='cart_label'>상품 금액</div>
          <div class='cart_price'><fmt:formatNumber value="${tot_sum }" pattern="#,###" /> 원</div>
          
          <div class='cart_label'>포인트</div>
          <div class='cart_price'><fmt:formatNumber value="${point_tot }" pattern="#,###" /> 원 </div>
          
          <div class='cart_label'>배송비</div>
          <div class='cart_price'><fmt:formatNumber value="${baesong_tot }" pattern="#,###" /> 원</div>
        </td>
        <td style='width: 50%;'>
          <div class='cart_label' style='font-size: 2.0em;'>전체 주문 금액</div>
          <div class='cart_price'  style='font-size: 2.0em; color: #FF0000;'><fmt:formatNumber value="${total_ordering }" pattern="#,###" /> 원</div>
          
          <form name='frm' id='frm' style='margin-top: 50px;' action="/order_pay/create.do" method='get'>
            <button type='submit' id='btn_order' class='btn btn-info' style='font-size: 1.5em;'>주문하기</button>
          </form>
        <td>
      </tr>
    </tbody>
  </table>   
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

