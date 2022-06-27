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
 <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gaegu:wght@300&family=Kdam+Thmor+Pro&family=Kirang+Haerang&family=Nanum+Gothic&display=swap" rel="stylesheet">
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<style>


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
a{
    color: black;
    text-decoration: none;
    font-weight: bold;
    font-family: 'Kdam Thmor Pro', sans-serif;
   font-family: 'Gaegu', cursive;
   font-size: 20px;
    
    
}

#cart::-webkit-scrollbar {
    width: 8px;  /* 스크롤바의 너비 */
}

#cart::-webkit-scrollbar-thumb {
    height: 30%; /* 스크롤바의 길이 */
    background: #8DA386; /* 스크롤바의 색상 */
    
    border-radius: 10px;
}

#cart::-webkit-scrollbar-track {
    background: rgba(33, 122, 244, .1);  /*스크롤바 뒷 배경 색상*/
}
    
</style>
 
</head> 
 
<body style="background-color:transparent; width:200px; height:150px;">

<%-- GET -> POST: 상품 삭제, 수량 변경용 폼 --%>

    <section id="cart_items">
    <div class="container" style="  width: 230px;   padding-top: 100px;">

 <div id="cart" class="table-responsive cart_info" style="  height: 150px; overflow-x: hidden; border:none;
    overflow-y: scroll;">
 
  <table class="table table-condensed">
  
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
              <td class="cart_description" style="    width: 160px;">
                <h4><a href="/product/read.do?productno=${productno}" target="_top">${ptitle}</a></h4>
              </td> 

              <td class="cart_total">
                <p class="cart_total_price" style="font-family: 'Gaegu', cursive;"><fmt:formatNumber value="${tot}" pattern="#,###" /></p>
              </td>

            </tr>
          </c:forEach>
        
        </c:when>
      </c:choose>
      
      
    </tbody>
  </table>
  </div>
  </div>
  </section> <!--/#cart_items-->
  
  
 
</body>
 
</html>

