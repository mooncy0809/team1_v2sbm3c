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
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top2.jsp" />

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
                
  <div class="col-sm-9 padding-right"> <%-- 갤러리 Layout 시작 --%>
  <div class="features_items">
   <h2 class="title text-center">${cateVO.name } 상품 목록</h2>
    <c:forEach var="productVO" items="${list }" varStatus="status">
      <c:set var="productno" value="${productVO.productno }" />
      <c:set var="ptitle" value="${productVO.ptitle }" />
      <c:set var="pcontent" value="${productVO.pcontent }" />
      <c:set var="pfile1" value="${productVO.pfile1 }" />
      <c:set var="psize1" value="${productVO.psize1 }" />
      <c:set var="pthumb1" value="${productVO.pthumb1 }" />
      
      <c:set var="price" value="${productVO.price }" />
      <c:set var="dc" value="${productVO.dc }" />
      <c:set var="saleprice" value="${productVO.saleprice }" />
      <c:set var="point" value="${productVO.point }" />

      <%-- 하나의 행에 이미지를 4개씩 출력후 행 변경, index는 0부터 시작 --%>
      <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
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
                  <IMG src="./storage/${pthumb1 }" style='width: 230px; height:230px ;'>
                </a>
                <del><fmt:formatNumber value="${price}" pattern="#,###" /></del>
                <span style="color: #FF0000; font-size: 1.0em;">${dc} %</span>
                <h2><fmt:formatNumber value="${saleprice}" pattern="#,###" /> 원</h2>
                <p>${ptitle}</p>
                <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
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
      <div class="product-overlay" style="background: rgba(254,152,15,.8);">
      <div class="overlay-content">
                
                <h2><fmt:formatNumber value="${saleprice}" pattern="#,###" /> 원</h2>
                <p>${ptitle}</p>
                <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
      </div>
      </div>
      </div><%--add cart 구역 전 --%>
      <div class="choose">
        <ul style="margin:5px auto;padding-left:5px;">
        <li><a href=""><i class="fa fa-plus-square"></i>위시리스트</a></li>
        </ul>
      </div>
      </div>      
      </DIV>
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
  </div>
   <ul class="pagination">
    <li class="active"><a href="">1</a></li>
    <li><a href="">2</a></li>
    <li><a href="">3</a></li>
    <li><a href="">&raquo;</a></li>
   </ul>
  </div>
  </div>
  </div>
</section>

  



 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

