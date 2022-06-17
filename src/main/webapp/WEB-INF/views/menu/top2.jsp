<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Home | 삼대몇? </title>
    <link href="/css/bootstrap.min2.css" rel="stylesheet">
    <link href="/css/font-awesome.min2.css" rel="stylesheet">
    <link href="/css/prettyPhoto2.css" rel="stylesheet">
    <link href="/css/price-range2.css" rel="stylesheet">
    <link href="/css/animate2.css" rel="stylesheet">
    <link href="/css/main2.css" rel="stylesheet">
    <link href="/css/responsive2.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="/images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/images/ico/apple-touch-icon-57-precomposed.png">
    
    
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.scrollUp.min.js"></script>
    <script src="../js/price-range.js"></script>
    <script src="../js/jquery.prettyPhoto.js"></script>
    <script src="../js/main.js"></script>
    
</head><!--/head-->

<body>
    <header id="header"><!--header-->
        <div class="header_top"><!--header_top-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="contactinfo">
                            <ul class="nav nav-pills">
                                <li><a href="../index.do">삼대몇?</a></li>
                                <li><a href="../index2.do">하루삼끼</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="social-icons pull-right">
<!--                             <ul class="nav navbar-nav2">
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                <li><a href="#"><i class="fa fa-dribbble"></i></a></li>
                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                            </ul> -->
                            <ul class="nav navbar-nav2">
                                    <c:choose>
                                    <c:when test="${sessionScope.id == null}">
                                        <li><a href="/member/login.do"><i class="fa fa-sign-in"></i> 로그인</a></li>
                                    </c:when>                                   
                                    
                                    <c:otherwise>
                                        <li><a href="/member/logout.do"><i class="fa fa-sign-out"></i>${sessionScope.id } 로그아웃</a></li>
                                    </c:otherwise>                                                                                                          
                                    
                                </c:choose>                               
                                
                                <c:choose>
                                    <c:when test="${sessionScope.id == null}">
                                        <li><a href="/member/create.do"><i class="fa fa-plus"></i>회원 가입</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="/member/read2.do?memberno=${sessionScope.memberno}"><i class="fa fa-user"></i>${sessionScope.id } 내 정보</a></li>
                                    </c:otherwise>
                                </c:choose>
                                
                                <c:choose>
                                    <c:when
                                        test="${sessionScope.grade < 10}">
                                        <%-- 로그인 한 경우 --%>
                                                <div class="nav navbar-nav2">
                                                    <ul class="nav navbar-nav collapse navbar-collapse">
                                                        <li class="dropdown"><a href="#"><i class="fa fa-user"></i>관리자<i class="fa fa-angle-down"></i></a>
                                                            <ul role="menu" class="sub-menu">
                                                                <li><a href="/categrp/list.do"><i class="fa fa-gears"></i>삼대몇 관리자</a></li>
                                                                <li><a href="/categrp/list2.do"><i class="fa fa-gears"></i>하루삼끼 관리자</a></li>
                                                                <li><a href="../../you/list_by_categrpno.do?categrpno=4"><i class="fa fa-gears"></i>홈트레이닝</a></li> 
                                                            </ul>
                                                        </li>
                                                     </ul>
                                                </div>         
                                    </c:when>
                                </c:choose>
                                
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--/header_top-->
        
        <div class="header-middle"><!--header-middle-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-4">
                        <div class="logo pull-left">
<!--                             <a href="index.html"><img src="images/home/logo.png" alt="" /></a>
 -->                            <a href="../index2.do"><img src="/images/home/logo2.png" alt="" /></a>
                        </div>
                        <div class="btn-group pull-right">
                            <div class="btn-group">
                               
                            </div>
                            
                            <div class="btn-group">
                               
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <div class="mainmenu pull-right">
                            <ul class="nav navbar-nav collapse navbar-collapse">
<!--                            <li><a href="#"><i class="fa fa-star"></i> 위시리스트</a></li>
                                <li><a href="checkout.html"><i class="fa fa-crosshairs"></i> 결제 </a></li> -->  
                                <li><a href="../../product/list_by_cateno_grid.do?cateno=1"class="active">추천시스템</a></li>                           
                                <li class="dropdown"><a href="#">전체 카테고리<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="../product/list_by_cateno_grid.do?categrpno=6&cateno=7">닭가슴살</a></li>
                                        <li><a href="product-details.html">간편요리</a></li> 
                                        <li><a href="checkout.html">샐러드</a></li> 
                                        <li><a href="cart.html">건강미용</a></li> 
                                        <li><a href="login.html">간식</a></li> 
                                    </ul>                                   
                                </li> 
                                
                                <li><a href="../../product/list_by_cateno_grid.do?cateno=1">베스트</a></li>
                                <li><a href="../../product/list_by_cateno_grid.do?cateno=19">특가</a></li>
                                <li><a href="../../product/list_by_cateno_grid.do?cateno=3">신상품</a></li>  
                                <li><a href="/cart/list_by_memberno.do"><i class="fa fa-shopping-cart"></i> 장바구니</a></li>                                               
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--/header-middle-->
    
        <div class="header-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-sm-9">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>
                        <div class="mainmenu pull-left">
                            <ul class="nav navbar-nav collapse navbar-collapse">
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-3">
<!--                         <div class="search_box pull-right">
                            <input type="text" placeholder="Search"/>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
    </header>
  
  <%-- 내용 --%> 
  <DIV class='content'>