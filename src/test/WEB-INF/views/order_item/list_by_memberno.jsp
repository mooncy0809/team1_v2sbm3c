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
  $(function(){
 
  });
</script>
</head> 
 
<body>
<jsp:include page="../menu/top2.jsp" flush='false' />
<div class="content">
    <section id="cart_items">
    <div class="container">
            <div class="breadcrumbs">
                <ol class="breadcrumb">
                  <li><a>Order</a></li>
                  <li class="active"><a href="../order_pay/list_by_memberno.do?memberno=${memberno}">${sessionScope.id }님 주문 결제내역</a></li>
                  <li class="active"><a href="javascript:location.reload();">${sessionScope.id }님 주문 상세내역</a></li>
                </ol>
            </div>
  <div class="table-responsive cart_info" >  
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
          <c:when test="${stateno == 4}">배달중</c:when>
          <c:when test="${stateno == 5}">오늘 도착</c:when>
          <c:when test="${stateno == 6}">배달 완료</c:when>
        </c:choose>
      </TD>
      <TD align="center" class="description">${rdate.substring(1,16) }</TD>
      <TD align="center" class="description"><A href="../review/create.do?order_itemno=${order_itemno}">리뷰 작성</A></TD>   
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