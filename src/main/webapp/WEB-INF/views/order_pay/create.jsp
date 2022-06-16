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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>  
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">

<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.chg{
    border: 3px solid #FE980F;
    background-color: #FE980F;
    color: white; 
    position: relative; 
    border-radius: 7px;
}
.chg:hover{
    background-color: #fdb45e;
}
.chg:focus{
    border: 3px solid #FE980F;
    outline:none;
}
</style>
<script type="text/javascript">
  $(function() { // 자동 실행
    $('#btn_DaumPostcode').on('click', DaumPostcode); // 다음 우편 번호
    $('#btn_my_address').on('click', my_address); 
    $('#btn_order_pay').on('click', send);
  });

  // 나의 주소 가져오기, jQuery ajax 요청
  function my_address() {
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = '';
    var msg = '';

    $.ajax({
      url: '/member/read_ajax.do', // spring execute
      type: 'get',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";

        $('#rname').val(rdata.rname);
        $('#rtel').val(rdata.rtel);
        $('#rzipcode').val(rdata.rzipcode);
        $('#raddress1').val(rdata.raddress1);
        $('#raddress2').val(rdata.raddress2);
        
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });

  }

  function check_null(str) {
    var sw = false;
    if (str == "" || str.trim().length == 0 || str == null || str == undefined || typeof str == "object") {
      sw = true;  // 값이 없는 경우  
    }
    return sw;
  }
  
  function send() {
    if (check_null($('#rname').val()))  {
      alert('수취인 성명을 입력해주세요.');
      $('#rname').focus();
      return;
    } 

    if (check_null($('#rtel').val()))  {
      alert('수취인 전화번호를 입력해주세요.');
      $('#rtel').focus();
      return;
    } 

    if (check_null($('#rzipcode').val()))  {
      alert('우편번호를 입력해주세요.');
      $('#rzipcode').focus();
      return;
    }    

    if (check_null($('#raddress1').val()))  {
      alert('주소를 입력해주세요.');
      $('#raddress1').focus();
      return;
    }     
     
    if (check_null($('#raddress2').val()))  {
      alert('상세 주소를 입력해주세요. 내용이 없으면 수취인 성명을 입력주세요.');
      $('#raddress2').focus();
      return;
    }     

    frm.submit();
  }
</script>
</head> 


<body>
<div class="content">
<jsp:include page="../menu/top2.jsp" flush='false' />
    <section id="cart_items">
    <div class="container">
            <div class="breadcrumbs">
                <ol class="breadcrumb">
                  <li><a href="/product/list_by_cateno_grid.do?categrpno=6&cateno=7">Home</a></li>
                  <li class="active"><a href="javascript:location.reload();">Order</a></li>
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
      <c:forEach var="cartVO" items="${list }">
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
                <a href="/product/read.do?productno=${productno}"><IMG src="/product/storage/${pthumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                ${productVO.file1}
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
            <strong>${cnt }</strong>
          </td>
              <td class="cart_total">
                <p class="cart_total_price"><fmt:formatNumber value="${tot}" pattern="#,###" /></p>
          </td>
          <td class="cart_delete" style="margin:auto; padding-right:50px; text-align:left;">
            <A class="cart_quantity_delete" href="../cart/list_by_memberno.do"><i class="fa fa-shopping-cart"></i></a>
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  </div>
  </div>
  </section>
  
  <form name='frm' id='frm' style='margin-top: 50px;' action="/order_pay/create.do" method='post'>
    <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">  
    <input type="hidden" name="amount" value=" ${total_order }">   <%-- 전체 주문 금액 --%>
    
    <section id="do_action">
        <div class="container">
                <div class="col-sm-6" style="width:100%; border: 1px solid #E6E4DF;">
                    <div class="chose_area" style="margin:0 auto;padding:30px 25px 30px 25px;border:0;">
   <ul class="user_option">
   <li style="margin:10px auto;">
         <label style="font-weight:bold;margin-left:0;">배송 정보<span style="color:red;font-size: 1.0em;">(*: 필수 입력)</span></label>&nbsp;
         <button type="button" id="btn_my_address" class="btn-sm btn-warning" style="margin-bottom: 2px;">나의 주소 가져오기</button>&nbsp; 
         <button type="reset" id="btn_reset" class="btn-sm btn-warning" style="margin-bottom: 2px;">주소 지우기</button>
  </li>  
  <li style="margin:10px auto;">
        <label for="mname" style='font-weight:bold; font-size: 0.9em; margin-left:0;'>수취인 성명*</label>    
        <input type='text' class="form-control" name='rname' id='rname' 
                   value='' required="required" style='width: 30%;' placeholder="수취인 성명" >
  </li>
  
   <li style="margin:10px auto;">
       <label for="tel" style='font-weight:bold; font-size: 0.9em;margin-left:0;'>수취인 전화번호*</label>    
       <input type='text' class="form-control" name='rtel' id='rtel' 
                   value='' required="required" style='width: 30%;' placeholder="수취인 전화번호"> 예) 010-0000-0000
  </li>
  
   <li style="margin:10px auto;">
      <label for="zipcode" style='font-weight:bold; font-size: 0.9em;margin-left:0;'>우편번호</label>    
        <input type='text' class="form-control" name='rzipcode' id='rzipcode' 
                   style='width: 30%;vertical-align: left; margin-right:0;' placeholder="우편번호">
        <input type="button" id="btn_DaumPostcode" value="우편번호 찾기" style="margin-top:3px;" class="btn-sm btn-warning" >
  </li>
  
   <li style="margin:10px auto;">
      <label for="address1" style='font-weight:bold; font-size: 0.9em;margin-left:0;'>주소</label>    
        <input type='text' class="form-control" name='raddress1' id='raddress1' 
                   value='' style='width: 80%;' placeholder="주소">
  </li>
  <li style="margin:10px auto;">
      <label for="address2" style='font-weight:bold; font-size: 0.9em;margin-left:0;'>상세 주소</label> 
      <input type='text' class="form-control" name='raddress2' id='raddress2' 
                   value='' style='width: 80%;' placeholder="상세 주소">
  </li>
  </ul>
  <ul class="user_option">
  <li>
<!-- ------------------------------ DAUM 우편번호 API 시작 ------------------------------ -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#rzipcode').val(data.zonecode); //5자리 새우편번호 사용 ★
                $('#raddress1').val(fullAddr);  // 주소 ★

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#raddress2').focus(); //  ★
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ------------------------------ DAUM 우편번호 API 종료 ------------------------------ -->

      </li>
    </ul>
  
   <ul class="user_option" style="margin-top:30px;">
   <li style="margin:10px auto;">
    <label style="font-weight:bold;margin-left:0;">결제 수단</label>

  <div class='menu_line'></div>
  <div style="text-align: left;">
    <label style="margin-left:0px; margin-right:10px; cursor: pointer;"><input type="radio" name="paytype" id="paytype" value="1" checked="checked"> 신용 카드</label>  
    <label style="margin-left:0px; margin-right:10px; cursor: pointer;"><input type="radio" name="paytype" id="paytype" value="2"> 모바일</label>  
    <label style="margin-left:0px; margin-right:10px; cursor: pointer;"><input type="radio" name="paytype" id="paytype" value="3"> 포인트</label>  
    <label style="margin-left:0px; margin-right:10px; cursor: pointer;"><input type="radio" name="paytype" id="paytype" value="4"> 계좌 이체</label>  
    <label style="margin-left:0px; margin-right:10px; cursor: pointer;"><input type="radio" name="paytype" id="paytype" value="5"> 직접 입금</label>  
  </div>
  </li>
  </ul>
  </div>
  </div>
  </div>
  </section>
  <section id="do_action">
  <div class="container">
  <table class="table table-striped" style='width: 100%;'>
    <tbody>
      <tr>
        <td style='margin:100px auto; width: 50%;'>
          <div class='cart_label' style="font-size: 17px;">상품 금액 : <fmt:formatNumber value="${tot_sum }" pattern="#,###" /> 원</div>
          
          <div class='cart_label' style="font-size: 17px;">포인트 : <fmt:formatNumber value="${point_tot }" pattern="#,###" /> 원 </div>
          
          <div class='cart_label' style="font-size: 17px; font-weight:bold;">배송비 : <fmt:formatNumber value="${baesong_tot }" pattern="#,###" /> 원</div>
        </td>
        <td style='width: 50%;'>
          <div class='cart_label' style='font-size: 2.0em;'>전체 주문 금액</div>
          <div class='cart_price'  style='font-size: 2.0em; color: #FF0000;'><fmt:formatNumber value="${total_order }" pattern="#,###" /> 원</div>
          
            <button class='chg' type='button' id='btn_order_pay' class='btn btn-info' style='font-size: 1.5em;'>결제하기</button>
        <td>
      </tr>
    </tbody>
  </table>   
  </div>
  </section>    
  </FORM>

</div>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>
