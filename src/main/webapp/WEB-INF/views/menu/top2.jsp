<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Home | 하루삼끼 </title>
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
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Sunflower&display=swap" rel="stylesheet">
    
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.scrollUp.min.js"></script>
    <script src="../js/price-range.js"></script>
    <script src="../js/jquery.prettyPhoto.js"></script>
    <script src="../js/main.js"></script>
    
<style type="text/css">
#menubar:hover{
    background-color: #E2E8DE;
    color:white;
}
#menubar:hover >.sub-menu {
    display:none;
}
.nav>li>a:hover, .nav>li>a:focus {
    text-decoration: none;
}
#menubar:active{
    background-color: #E2E8DE;
    color:white;
}
.menu li:hover{
    color: white;
}

.sub_com li:hover{
    color: white;
}


.imgbtn{
    cursor:pointer;
    position: relative;
}

.menu li{
    font-family: 'Alfa Slab One', cursive;
    font-size: 50px;
    cursor:pointer;
    color: black;

}
.sub_com li{
    font-family: 'Do Hyeon', sans-serif;
    font-size: 20px;
    cursor:pointer;
    color: black;
}

.drop{
    color:white;
    position: relative;
    list-style-type: none;
    padding-left: 44px;
    display: none;
    margin: 0 auto
}
ul.sub {
    cursor:pointer;
    position: absolute;
    top: 36px;
    left: 0;
    background:#E2E8DE;
    list-style: none;
    padding:10px 0px 10px 0px;
    margin: 0;
    width: 200px;
    -webkit-box-shadow: 0 3px 3px rgb(0 0 0 / 90%);
    box-shadow: 0 3px 3px rgb(0 0 0 / 90%);
    display: none;
    line-height: 20px;
    z-index:1;
    }
ul.sub > li > a:hover{
    cursor:pointer;
    color: white;
}
ul.drop > li > a:hover{
    cursor:pointer;
    color: white;
}

a{
    font-family: 'Kdam Thmor Pro', sans-serif;
    font-family: 'Sunflower', sans-serif;
 }
</style>
<script type="text/javascript">
window.onload = function() {

}
function recommend(){
  var url = '../../tensorflow/recommend/start.do';
  var win = window.open(url, 'AI 서비스', 'width=850px, height=400px');

  var x = (screen.width - 1000) / 2;
  var y = (screen.height - 800) / 2;

  win.moveTo(x, y); // 화면 중앙으로 이동
}
</script>
<script type="text/javascript">
function com2() {
    if ($('#sub_com2').css('display') == 'block'){
        $("#sub_com2").slideUp(500);   
        }     
    else{
        $("#sub_com2").slideDown(500);
            }
  } 

function com3() {
    if ($('#sub_com3').css('display') == 'block'){
        $("#sub_com3").slideUp(500);   
        }     
    else{
        $("#sub_com3").slideDown(500);
            }
  } 

function com4() {
    if ($('#sub_com4').css('display') == 'block'){
        $("#sub_com4").slideUp(500);   
        }     
    else{
        $("#sub_com4").slideDown(500);
            }
  } 
</script>
</head><!--/head-->

<body>
    <header id="header">
        <!--header-->
        <div class="header_top">
            <!--header_top-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="contactinfo">
                            <ul class="nav nav-pills">
                                <li><a id="menubar" href="../index.do">삼대몇?</a></li>
                                <li><a  id="menubar" href="../index2.do"  style=" color:balck; background-color:#F5F5EE;">하루삼끼</a></li>
                            </ul>
                        </div>
                    </div>
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
                                        <li><a id="menubar" href="/member/login.do"><i class="fa fa-sign-in"></i> 로그인</a></li>
                                    </c:when>                                   
                                    
                                    <c:otherwise>
                                        <li id="menubar"><a id="menubar" href="/member/logout.do"><i class="fa fa-sign-out"></i>${sessionScope.id } 로그아웃</a></li>
                                    </c:otherwise>                                                                                                          
                                    
                                </c:choose>                               
                                
                                <c:choose>
                                    <c:when test="${sessionScope.id == null}">
                                        <li id="menubar"><a id="menubar" href="/member/create.do"><i class="fa fa-plus"></i>회원 가입</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li id="menubar"><a id="menubar" href="/member/read2.do?memberno=${sessionScope.memberno}"><i class="fa fa-user"></i>${sessionScope.id } 내 정보</a></li>
                                    </c:otherwise>
                                </c:choose>
                                
                                <c:choose>
                                    <c:when
                                        test="${sessionScope.grade < 10}">
                                        <%-- 로그인 한 경우 --%>
                                                <div class="social-icons pull-right">
                                                    <ul class="nav navbar-nav collapse navbar-collapse" style="padding-top:0;">
                                                        <li><a onclick="com2(this)" style="cursor:pointer;" id="menubar"><i class="fa fa-user"></i>관리자<i class="fa fa-angle-down"></i></a>
                                                            <ul role="menu" class="sub" id="sub_com2" style="font-size:small;">
                                                                <li class="dropdown2"><a onclick="com3(this)" class="sub" style="color:gray;font-weight:bold;"><i class="fa fa-gears"></i>삼대몇 관리자<i class="fa fa-angle-down"></i></a>
                                                                      <ul role="menu"class="drop" id="sub_com3" >
                                                                      <li><a href="/categrp/list.do">카테고리 관리</a></li><br>
                                                                      <li> <a href="../you/list_by_categrpno_search_paging.do?categrpno=4">홈트레이닝 관리</a></li>
                                                                      </ul>
                                                                </li>
                                                                <li class="dropdown2"><a onclick="com4(this)" class="sub"style="color:gray;font-weight:bold;" ><i class="fa fa-gears"></i>하루삼끼 관리자<i class="fa fa-angle-down"></i></a>
                                                                      <ul role="menu" class="drop"  id="sub_com4">
                                                                      <li><a href="/categrp/list2.do">카테고리 관리</a></li><br>
                                                                      <li><a href="../../order_pay/list_by_memberno_search_paging_all.do?memberno=${memberno}&word=">주문 관리</a></li>
                                                                      </ul>
                                                                </li>
                                                                 
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
        
        <div class="header-middle"><!--header-middle-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-4">
                        <div class="logo pull-left">
<!--                             <a href="index.html"><img src="images/home/logo.png" alt="" /></a>
 -->                            <a href="../index2.do"><img src="/images/home/logo2.png" alt=""style="    padding-left: 20px;" /></a>
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
<!--                                 <li><a href="../../product/list_by_cateno_grid.do?cateno=1"class="active">추천시스템</a></li>                           
 -->
                                    <li><a href="javascript: recommend()"class="active">추천시스템</a></li>
                                    <li class="dropdown"><a href="#">전체 카테고리<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="../product/list_by_cateno_grid.do?categrpno=7&cateno=8">닭가슴살</a></li>
                                        <li><a href="../product/list_by_cateno_grid.do?categrpno=7&cateno=9">간편요리</a></li> 
                                        <li><a href="../product/list_by_cateno_grid.do?categrpno=7&cateno=10">샐러드</a></li> 
                                        <li><a href="../product/list_by_cateno_grid.do?categrpno=7&cateno=11">건강미용</a></li> 
                                        <li><a href="../product/list_by_cateno_grid.do?categrpno=7&cateno=12">간식</a></li> 
                                    </ul>                                   
                                </li> 
                                
                                <li><a href="../../product/list_by_cateno_grid.do?cateno=8">베스트</a></li>
                                <li><a href="../../product/list_by_cateno_grid.do?cateno=9">특가</a></li>
                                <li><a href="../../product/list_by_cateno_grid.do?cateno=10">신상품</a></li>
                                <li><a href="../../product/list_by_cateno_grid_join2.do">전체상품</a></li>  
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