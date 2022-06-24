<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0,
                                 maximum-scale=5.0, width=device-width" /> 

<jsp:include page="./menu/top2.jsp" flush='false' />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Sunflower&display=swap" rel="stylesheet">
 

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/> 

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> 

<style type="text/css">
a{
    font-family: 'Kdam Thmor Pro', sans-serif;

 font-family: 'Sunflower', sans-serif;
 }
</style>

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

</head>
<body>
        <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
           <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
           <input type="hidden" name="productno" id="productno" value="productno">
        </FORM>
    <section id="slider"><!--slider-->
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div id="slider-carousel" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#slider-carousel" data-slide-to="0" class="active"></li>
                            <li data-target="#slider-carousel" data-slide-to="1"></li>
                            <li data-target="#slider-carousel" data-slide-to="2"></li>
                        </ol>
                           
                        <div class="carousel-inner">
                            <div class="item active">
                                <div class="col-sm-6">
                                    <h1><span>E</span>-SHOPPER</h1>
                                    <h2>Free E-Commerce Template</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                    <button type="button" class="btn btn-default get">보러 가기</button>
                                </div>
                                <div class="col-sm-6">
                                    <img src="images/home/indexmain1.png" class="girl img-responsive" alt="" />
                                    <img src="images/home/pricing.png"  class="pricing" alt="" />
                                </div>
                            </div>
                            <div class="item">
                                <div class="col-sm-6">
                                    <h1><span>E</span>-SHOPPER</h1>
                                    <h2>100% Responsive Design</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                    <button type="button" class="btn btn-default get">보러 가기</button>
                                   
                                </div>
                                <div class="col-sm-6">
                                    <img src="images/home/indexmain2.png" class="girl img-responsive" alt="" />
                                    <img src="images/home/pricing.png"  class="pricing" alt="" />
                                </div>
                            </div>
                            
                            <div class="item">
                                <div class="col-sm-6">
                                    <h1><span>E</span>-SHOPPER</h1>
                                    <h2>여기다가 상품 나와야하는건가</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                    <button type="button" class="btn btn-default get">보러 가기</button>
                                </div>
                                <div class="col-sm-6">
                                    <img src="product/storage/77ㅓ억_1.png" class="girl img-responsive" alt="" />
                                    <img src="images/home/pricing.png" class="pricing" alt="" />
                                </div>
                            </div>
                            
                        </div>
                        
                        <a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
                            <i class="fa fa-angle-left"></i>
                        </a>
                        <a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </div>
                    
                </div>
            </div>
        </div>
    </section><!--/slider-->
    
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
                                            <li><a href="#">Nike </a></li>
                                            <li><a href="#">Under Armour </a></li>
                                            <li><a href="#">Adidas </a></li>
                                            <li><a href="#">Puma</a></li>
                                            <li><a href="#">ASICS </a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
<!--                             <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordian" href="#mens">
                                            <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                            Mens
                                        </a>
                                    </h4>
                                </div>
                                <div id="mens" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <ul>
                                            <li><a href="#">Fendi</a></li>
                                            <li><a href="#">Guess</a></li>
                                            <li><a href="#">Valentino</a></li>
                                            <li><a href="#">Dior</a></li>
                                            <li><a href="#">Versace</a></li>
                                            <li><a href="#">Armani</a></li>
                                            <li><a href="#">Prada</a></li>
                                            <li><a href="#">Dolce and Gabbana</a></li>
                                            <li><a href="#">Chanel</a></li>
                                            <li><a href="#">Gucci</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div> -->
                            
                            <!-- <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordian" href="#womens">
                                            <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                            Womens
                                        </a>
                                    </h4>
                                </div>
                                <div id="womens" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <ul>
                                            <li><a href="#">Fendi</a></li>
                                            <li><a href="#">Guess</a></li>
                                            <li><a href="#">Valentino</a></li>
                                            <li><a href="#">Dior</a></li>
                                            <li><a href="#">Versace</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div> -->
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
<!--                             <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a href="#">Interiors</a></h4>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a href="#">Clothing</a></h4>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a href="#">Bags</a></h4>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a href="#">Shoes</a></h4>
                                </div>
                            </div> -->
                        </div><!--/category-products-->
                    
                        <div class="brands_products"><!--brands_products-->
                            <h2>Brands</h2>
                            <div class="brands-name">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="#"> <span class="pull-right">(50)</span>맛있닭</a></li>
                                    <li><a href="#"> <span class="pull-right">(56)</span>굽네</a></li>
                                    <li><a href="#"> <span class="pull-right">(27)</span>참프레</a></li>
                                    <li><a href="#"> <span class="pull-right">(32)</span>러브잇</a></li>
<!--                                     <li><a href="#"> <span class="pull-right">(5)</span>Oddmolly</a></li>
                                    <li><a href="#"> <span class="pull-right">(9)</span>Boudestijn</a></li>
                                    <li><a href="#"> <span class="pull-right">(4)</span>Rösch creative culture</a></li> -->
                                </ul>
                            </div>
                        </div><!--/brands_products-->
                        
                        <div class="price-range"><!--price-range-->
                            <h2>Price Range</h2>
                            <div class="well text-center">
                                 <input type="text" class="span2" value="" data-slider-min="0" data-slider-max="600" data-slider-step="5" data-slider-value="[250,450]" id="sl2" ><br />
                                 <b class="pull-left">$ 0</b> <b class="pull-right">$ 600</b>
                            </div>
                        </div><!--/price-range-->
                        
                        <div class="shipping text-center"><!--shipping-->
                            <a href="./index.do"><img src="images/home/indexmain4.png" alt=""  /></a>
                        </div><!--/shipping-->
                    
                    </div>
                </div>
                
                <!-- <div class="col-sm-9 padding-right">
                    <div class="features_items">features_items
                        <h2 class="title text-center">Features Items</h2>
                        <div class="col-sm-4">

                            <div class="product-image-wrapper">
                                <div class="single-products">
                                        <div class="productinfo text-center">
                                            <img src="images/home/product1.jpg" alt="" />
                                            <h2>$56</h2>
                                            <p>Easy Polo Black Edition</p>
                                            <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
                                        </div>
                                        <div class="product-overlay">
                                            <div class="overlay-content">
                                                <h2>$56</h2>
                                                <p>Easy Polo Black Edition</p>
                                                <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
                                            </div>
                                        </div>
                                </div>
                                <div class="choose">
                                    <ul class="nav nav-pills nav-justified">
                                        <li><a href="#"><i class="fa fa-plus-square"></i>Add to wishlist</a></li>
                                        <li><a href="#"><i class="fa fa-plus-square"></i>Add to compare</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div> -->
                        <div class="col-sm-9 padding-right"> <%-- 갤러리 Layout 시작 --%>
  <div class="features_items">
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
        
      
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV class="col-sm-4" >
      <div class="product-image-wrapper" >
      <div class="single-products"  >
      <div class="productinfo text-center" >
        <c:choose>
          <c:when test="${psize1 > 0}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${pthumb1.endsWith('jpg') || pthumb1.endsWith('png') || pthumb1.endsWith('gif')}"> <!-- 이미지 인경우 -->
                <a href="./product/read.do?productno=${productno}">               
                  <IMG src="./product/storage/${pthumb1 }" style='width: 230px; height:230px ;'>
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
            <a href="./product/read.do?productno=${productno}">
              <img src='/product/images/none1.png' style='width: 100%; height: 150px;'>
            </a><br>
            이미지를 등록해주세요.
          </c:otherwise>
        </c:choose>   
      </div> <%--사진 정렬 --%>
      <div class="product-overlay" style="background: rgba(76,121,72,.8);">
      <div class="overlay-content">
                <a class="read" href="./product/read.do?productno=${productno}"><i class="fas fa-door-open  fa-3x"></i></a>
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
  </div>    
</div> 
    <div style="width: 75%; padding-right: 0px; float: right;">
    <div class="recommended_items">
                        <h2 class="title text-center">recommended items</h2>
                        <div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="item active">
                                    <c:forEach var="cate_productVO" items="${list2 }" varStatus="status">
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
                                      <c:if test="${status.index % 3 == 0 && status.index != 0 }"> 
                                      </div>
                                      <div class="item">
                                      </c:if> 
                                    <div class="col-sm-4">
                                        <div class="product-image-wrapper">
                                            <div class="single-products">
                                                <div class="productinfo text-center" style="width: 240px; height:430px;">
                                                    <c:choose>
                                          <c:when test="${psize1 > 0}"> <!-- 파일이 존재하면 -->
                                            <c:choose> 
                                              <c:when test="${pthumb1.endsWith('jpg') || pthumb1.endsWith('png') || pthumb1.endsWith('gif')}"> <!-- 이미지 인경우 -->
                                                <a href="./product/read.do?productno=${productno}">               
                                                  <IMG src="./product/storage/${pthumb1 }" alt="" style='width: 100%; height:230px ;'>
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
                                            <a href="./product/read.do?productno=${productno}">
                                              <img src='/product/images/none1.png' style='width: 100%; height: 150px;'>
                                            </a><br>
                                            이미지를 등록해주세요.
                                          </c:otherwise>
                                        </c:choose>   
                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                             
                                            <c:if test="${status.index % search_count_main == 0 && status.index != 0 }"> 
                                        
                                             </div>
                                            <div class="item">
                                
                                             </c:if> 
                                        </c:forEach>
    
                  </div>      
             </div>
         <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
          <i class="fa fa-angle-left"></i>
          </a>
          <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
            <i class="fa fa-angle-right"></i>
          </a>  
                                      
   </div>
   </div>
 </DIV>
    </section>
 <jsp:include page="./menu/bottom2.jsp" flush='false' />
</body>
</html>