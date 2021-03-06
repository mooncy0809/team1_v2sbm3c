<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%!  int cnt=0;   %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>하루삼끼 사용자</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>  
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css"></head>

<script type="text/javascript">

  $(function() {
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

  function openNav() {    
      $("#imgstart").css('display', 'none');   
      $("#mySidenav2").slideDown(500);     
    } 
  function closeNav() {
      $("#mySidenav2").slideUp(1);
      $('#imgstart').show();
      location.reload();
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
 
 <style>
 a{
    font-family: 'Kdam Thmor Pro', sans-serif;
 font-family: 'Sunflower', sans-serif;
 }
 
 .cartimg{
    background: url('../images/home/cart.png') no-repeat;
}
 </style>
</head> 
 
<body>

<jsp:include page="../menu/top2.jsp" />
       
       <input type='hidden' name='now_page' value='1'>
  <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
       <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
       <input type="hidden" name="productno" id="productno" value="${productno }">
  </FORM>
    <section id="advertisement">
        <div class="container">
            <img src="images/shop/advertisement.jpg" alt="" />
        </div>
    </section>
    
    <section>
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
                                    <h4 class="panel-title"><a href="#">특가</a></h4>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a href="#">신상품</a></h4>
                                </div>
                            </div>
                        </div><!--/category-productsr-->
                        
                        <div>
                             <iframe class="cartimg" src="../cart/list_by_memberno2.do" align="left"  scrolling="no" style="border:0px; width:220px; height:280px;" ></iframe>
                        
                        </div>

                        
                    </div>
                </div>
                
  <div class="col-sm-9 padding-right"> <%-- 갤러리 Layout 시작 --%>
  <div class="features_items">
  <div>
        <div id="imgstart" style="text-align:center;margin:10px auto">
            <a class="imgbtn"onclick="openNav(this)" >
            <img width="270px" height="150px;"src="/recommend/recom.png" alt="추천시스템 시작"></a>
        </div>                             
  <div id="mySidenav2" style="position:relative; width:100%; display: none;">  
        <a class="imgbtn"  style="display:scroll; position:absolute; right:30px; z-index:1;" onclick="closeNav(this)" >
        <i class="fa-solid fa-square-minus"style="font-size:25px;"></i>
        </a><iframe class="backimg" src="http://localhost:9091/tensorflow/recommend/form1.do" scrolling="no" style="border:0px; width:100%; height:380px; " ></iframe>
  </div> 
  </div>

  <DIV style="text-align: right; clear: both;padding-right:25px;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_grid_join2.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <input type='text' name='pword' id='pword' value='${param.pword }' style='width: 20%;'>
      <button type='submit'><i class="fas fa-search"></i></button>
      <c:if test="${param.pword.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_grid.do?cateno=${cateVO.cateno}&pword='"><i class="fas fa-times" style="background-color: #E2E8DE;
    border-color: #E2E8DE;"></i></button>  
      </c:if>    
    </form>
<DIV class='title_line' style="text-align: right; margin-right:0;padding-top:10px;font-size:16px;">
  <A href="./list_by_cateno_grid_join_up.do" class='title_link'>높은 가격순</A> | 
  <A href="./list_by_cateno_grid_join_down.do" class='title_link'>낮은 가격순</A> 
</DIV>
  </DIV>
  
   <h2 class="title text-center">상품 목록</h2>
    <c:forEach var="cate_productVO" items="${list }" varStatus="status">
      <c:set var="productno" value="${cate_productVO.productno }" />
      <c:set var="ptitle" value="${cate_productVO.ptitle }" />
      <c:set var="pcontent" value="${cate_productVO.pcontent }" />
      <c:set var="pfile1" value="${cate_productVO.pfile1 }" />
      <c:set var="psize1" value="${cate_productVO.psize1 }" />
      <c:set var="pthumb1" value="${cate_productVO.pthumb1 }" />
      <c:set var="price" value="${cate_productVO.price }" />
      <c:set var="dc" value="${cate_productVO.dc }" />
      <c:set var="saleprice" value="${cate_productVO.saleprice }" />
      <c:set var="point" value="${cate_productVO.point }" />
        
      <c:if test="${status.index % 6 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if>
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV class="col-sm-4">
      <div class="product-image-wrapper">
      <div class="single-products">
      <div class="productinfo text-center">
        <c:choose>
          <c:when test="${psize1 > 0}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${pthumb1.endsWith('jpg') || pthumb1.endsWith('png') || pthumb1.endsWith('gif')}"> <!-- 이미지 인경우 -->
                <a href="./read.do?productno=${productno}">               
                  <IMG src="./storage/${pthumb1 }" style='width: 100%; height:230px ;'>
                </a>
                <del><fmt:formatNumber value="${price}" pattern="#,###" /></del>
                <span style="color: #FF0000; font-size: 1.0em;">${dc} %</span>
                <h2><fmt:formatNumber value="${saleprice}" pattern="#,###" /> 원</h2>
                <p>${ptitle}</p>
                <a onclick="cart_ajax(${productno })" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                    <a href="./read.do?productno=${productno}">${pfile1}</a><br>
                  </DIV>
                </DIV>
                ${title} (${cnt})              
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise> <%-- 파일이 없는 경우 기본 이미지 출력 --%>
            <a href="./read.do?productno=${productno}">
              <img src='/product/images/none1.png' style='width: 100%; height: 150px;'>
            </a><br>
            이미지를 등록해주세요.
          </c:otherwise>
        </c:choose>   
      </div> <%--사진 정렬 --%>
      <div class="product-overlay" style="background: rgba(76,121,72,.8);">
      <div class="overlay-content">
                <a class="read" href="./read.do?productno=${productno}"><i class="fas fa-door-open  fa-3x"></i></a>
                <h2><fmt:formatNumber value="${saleprice}" pattern="#,###" /> 원</h2>
                <p>${ptitle}</p>
                <a onclick="cart_ajax(${productno })" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
      </div>  
      </div>
      </div><%--add cart 구역 전 --%>
      <!-- <div class="choose">
        <ul style="margin:5px auto;padding-left:5px;">
        <li><a href=""><i class="fa fa-plus-square"></i>위시리스트</a></li>
        </ul>
      </div> -->
      </div>      
      </DIV>
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
  </div>
   <DIV class='bottom_menu' style="text-align: center; padding-bottom: 45px;">${paging3}</DIV>
  </div>
  </div>
  </div>
</section>

  



 
<jsp:include page="../menu/bottom2.jsp" />
</body>
 
</html>

