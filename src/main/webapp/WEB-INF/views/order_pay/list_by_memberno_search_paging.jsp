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
</head> 
 
<body>
<jsp:include page="../menu/top2.jsp" flush='false' />
    <section id="cart_items">
    <div class="container">
            <div class="breadcrumbs">
                <ol class="breadcrumb">
                  <li><a>Order</a></li>
                  <li class="active"><a href="javascript:location.reload();">${sessionScope.id }님 주문 결제내역</a></li>
                </ol>
            </div>
            
  <DIV style="text-align: right; clear: both;margin-bottom:15px;">  
    <form name='frm' id='frm' method='get' action='./list_by_memberno_search_paging.do'>
      <input type='hidden' name='memberno' value='${memberno }'>
      <input type='text' placeholder="주문번호" name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit'><i class="fas fa-search"></i></button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_memberno_search_paging.do?memberno=${memberno}&word='"><i class="fas fa-times"></i></button>  
      </c:if>    
    </form>
  </DIV>
  <div class="table-responsive cart_info" style="margin-bottom:20px;">  
  <table class="table table-condensed" style="margin-bottom:0px;">
    <colgroup>
      <col style='width: 5%;'/>
      <col style='width: 10%;'/>
      <col style='width: 15%;'/>
      <col style='width: 35%;'/>
      <col style='width: 10%;'/>
      <col style='width: 7%;'/>
      <col style='width: 13%;'/>
      <col style='width: 5%;'/>
    </colgroup>
    <thead>
    <TR class="cart_menu">
      <TD class="description"> </TD>
      <TD align="center"  class="description">수취인 성명</TD>
      <TD align="center"  class="description">수취인 전화번호</TD>
      <TD class="description">수취인 주소</TD>
      <TD align="center" class="description">결제수단</TD>
      <TD align="center"  class="description">결제금액</TD>
      <TD align="center" class="description">주문일</TD>
      <TD align="center" class="description">조회</TD>
    </TR>
    </thead>
    <tbody>
    <c:forEach var="order_payVO" items="${list }">
      <c:set var="order_payno" value ="${order_payVO.order_payno}" />
      <c:set var="rname" value ="${order_payVO.rname}" />
      <c:set var="rtel" value ="${order_payVO.rtel}" />
      <c:set var="address" value ="(${order_payVO.rzipcode}) ${order_payVO.raddress1} ${order_payVO.raddress1}" />
      <c:set var="paytype" value ="${order_payVO.paytype}" />
      <c:set var="amount" value ="${order_payVO.amount}" />
      <c:set var="rdate" value ="${order_payVO.rdate}" />
         
       
    <TR>
      <TD align="center" class="cart_description"><strong>${order_payno}</strong></TD>
      <TD align="center" class="cart_description"><A href="/member/read2.do?memberno=${memberno}">${rname}</A></TD>
      <TD align="center" class="cart_description">${rtel}</TD>
      <TD class="cart_description">${address}</TD>
      <TD class="cart_description" style="text-align:center;">
        <c:choose>
          <c:when test="${paytype == 1}">신용 카드</c:when>
          <c:when test="${paytype == 2}">모바일</c:when>
          <c:when test="${paytype == 3}">포이트</c:when>
          <c:when test="${paytype == 4}">계좌 이체</c:when>
          <c:when test="${paytype == 5}">직접 입금</c:when>
        </c:choose>
      </TD>
      <TD align="center"  class="cart_description"><p><fmt:formatNumber value="${amount }" pattern="#,###" /></p></TD>
      <TD align="center" class="cart_description">${rdate.substring(1,16) }</TD>
      <TD align="center"  class="cart_description">
        <A href="/order_item/list_by_memberno.do?order_payno=${order_payno}"><i class="fas fa-search-plus"></i></A>
      </TD>
      
    </TR>
    </c:forEach>
    </tbody>
  </TABLE>
  </div>
    <DIV class='bottom_menu'  style="margin-bottom:20px;">${paging }</DIV> <%-- 페이지 리스트 --%>
  </div>
  </section>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>