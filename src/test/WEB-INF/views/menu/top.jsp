<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<meta name="description" content="">
<meta name="author" content="">
<title>Home | 삼대몇?</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/font-awesome.min.css" rel="stylesheet">
<link href="/css/prettyPhoto.css" rel="stylesheet">
<link href="/css/price-range.css" rel="stylesheet">
<link href="/css/animate.css" rel="stylesheet">
<link href="/css/main.css" rel="stylesheet">
<link href="/css/responsive.css" rel="stylesheet">
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
<link rel="shortcut icon" href="/images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
    href="/images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
    href="/images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
    href="/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
    href="/images/ico/apple-touch-icon-57-precomposed.png">

<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery.scrollUp.min.js"></script>
<script src="../js/price-range.js"></script>
<script src="../js/jquery.prettyPhoto.js"></script>
<script src="../js/main.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Anton&family=Do+Hyeon&family=Gaegu:wght@300&family=Kdam+Thmor+Pro&family=Kirang+Haerang&family=Nanum+Gothic&display=swap" rel="stylesheet">
<style type="text/css">
#menubar:hover{
    background-color: #FFDCD3;
    color:white;
}
#menubar:hover >.sub-menu {
    display:none;
}
.nav>li>a:hover, .nav>li>a:focus {
    text-decoration: none;
}
#menubar:active{
    background-color: #FFDCD3;
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
    position: relative;
    list-style-type: none;
    padding-left: 0px;
    display: none;
}
.dropdown2:hover >.drop{
    display: block; 
}

</style>

</head>
<!--/head-->

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
                                <li><a  id="menubar" href="../index2.do">하루삼끼</a></li>
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
                                    <c:when
                                        test="${sessionScope.id == null}">
                                        <li><a
                                            href="/member/login.do"><i
                                                class="fa fa-sign-in"></i>
                                                로그인</a></li>
                                    </c:when>

                                    <c:otherwise>
                                        <li id="menubar"><a id="menubar"
                                            href="/member/logout.do"><i
                                                class="fa fa-sign-out"></i>${sessionScope.id }
                                                로그아웃</a></li>
                                    </c:otherwise>

                                </c:choose>

                                <c:choose>
                                    <c:when
                                        test="${sessionScope.id == null}">
                                        <li id="menubar"><a id="menubar"
                                            href="/member/create.do"><i
                                                class="fa fa-plus"></i>회원
                                                가입</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li id="menubar"><a id="menubar"
                                            href="/member/read.do?memberno=${sessionScope.memberno}"><i
                                                class="fa fa-user"></i>${sessionScope.id }
                                                내 정보</a></li>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${sessionScope.grade < 10}">
                                        <%-- 로그인 한 경우 --%>
                                        <div class="social-icons pull-right">
                                        <ul class="nav navbar-nav collapse navbar-collapse">

                        <li><a class="dropdown" id="menubar"><i class="fa fa-user"></i>관리자<i class="fa fa-angle-down"></i></a>
                                                            <ul role="menu" class="sub-menu" style="font-size:small;">
                                                                <li><a  id="menubar" class="dropdown2" href="#"  ><i class="fa fa-gears"></i>삼대몇 관리자<i class="fa fa-angle-down"></i></a>
                                                                      <ul class="sub-menu" ><li class="drop"><a href="/categrp/list.do">카테고리 관리</a></li>
                                                                      <li class="drop"><a href="../you/list_by_categrpno_search_paging.do?categrpno=4">홈트레이닝 관리</a></li>
                                                                      </ul></li>
                                                                <li><a href="/categrp/list2.do"><i class="fa fa-gears"></i>하루삼끼 관리자<i class="fa fa-angle-down"></i></a>
                                                                      <ul class="drop"><li><a href="/categrp/list.do">카테고리 관리</a></li>
                                                                      
                                                                </ul></li>
                                                                 
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
        <!--/header_top-->

        <div class="header-middle">
            <!--header-middle-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-4">
                        <div class="logo pull-left">
                            <!--                             <a href="index.html"><img src="images/home/logo.png" alt="" /></a>
 -->
                            <a class="imgbtn"><img src="/images/home/cate.png"
                                onclick="openNav(this)"/></a>    
  
                            <!--    <li class="menu">            
                                
                                <ul class="hide">                
                                <li>공지사항</li>                
                                <li>다이어트 꿀팁</li>                
                                <li>커뮤니티</li>                
                                <li>홈트레이닝</li>                
                                <li>칼로리사전</li>           
                                </ul>        
                                </li>           -->
                        </div>



                    </div>
                    <div class="col-sm-5">
                        <a href="../index.do"><img
                            src="/images/home/logo.png" alt="" /></a>

                    </div>
                    <!--  <div class="col-sm-8">
                        <div class="mainmenu pull-right">
                            <ul class="nav navbar-nav collapse navbar-collapse">
                           <li><a href="#"><i class="fa fa-star"></i> 위시리스트</a></li>
                                <li><a href="checkout.html"><i class="fa fa-crosshairs"></i> 결제 </a></li>
                                <li><a href="cart.html"><i class="fa fa-shopping-cart"></i> 장바구니</a></li> -->
                    <%-- <c:forEach var="categrpVO" items="${list}">
                                <c:set var="categrpno" value="${categrpVO.categrpno }" />
                                <c:set var="name" value="${categrpVO.name }" />
                                <li><A href="../cate/list_by_categrpno.do?categrpno=${categrpno }">${name }</A></li>
                                </c:forEach> --%>
                    <!-- <li><a href="index.html"class="active">공지사항</a></li>
                                <li class="dropdown"><a href="#">다이어트 꿀팁<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="shop.html">전체</a></li>
                                        <li><a href="product-details.html">칼럼</a></li> 
                                        <li><a href="checkout.html">운동</a></li> 
                                        <li><a href="cart.html">식단</a></li> 
                                        <li><a href="login.html">성공후기</a></li> 
                                    </ul>                                   
                                </li> 
                                <li class="dropdown"><a href="#">커뮤니티<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="blog.html">전체</a></li>
                                        <li><a href="blog-single.html">팁&노하우</a></li>
                                        <li><a href="shop.html">고민&질문</a></li>
                                        <li><a href="product-details.html">자유게시판</a></li> 
                                    </ul>
                                </li>
                                <li><a href="404.html">홈트레이닝</a></li> 
                                <li><a href="404.html">칼로리사전</a></li>

                                
                            </ul>
                        </div>
                    </div>-->


                </div>
                <div id="mySidenav" class="sidenav category-bg"
                    style="padding-left: 40px; width: 500px; display: none; background-color: #FFF2EE; position:absolute; top:130px; left:65px; box-shadow: 12px 10px 11px 7px gray;">
                    <li class="menu" style="list-style:none;" >
                        <ul >                       
                            <a><li>NOTICE</li></a>
                            <a><li>DIET TIP</li></a>       
                            <a onclick="com(this)" ><li>COMMUNITY</li></a>            
                                        <div class="sub_com" id="sub_com" style="display: none; ">           
                                        <a href="../contents/list_all_join.do"><li>전체</li></a>
                                        <a href="../contents/list_by_cateno_search_paging.do?cateno=4&now_page=1"><li>자유게시판</li></a>
                                        <a href="../contents/list_by_cateno_search_paging.do?cateno=5&now_page=1"><li>팁&노하우</li></a>
                                        <a href="../contents/list_by_cateno_search_paging.do?cateno=6&now_page=1"><li>고민&질문</li></a>
                                        <a href="../contents/list_by_cateno_search_paging.do?cateno=7&now_page=1"><li>일기</li></a>  
                                       <a href="/qna/list_search_paging.do?categrpno=4&memberno=${sessionScope.memberno}"> <li>관리자에게</li></a> 
                                        </div>
                            <a href="../you/list_by_categrpno_grid_search_paging.do?categrpno=4&now_page=1"><li>HOME TRAINING</li></a>
                            <a href="../dict/list_by_categrpno_search_paging.do?categrpno=5"><li>CALORIE DICTIONARY</li></a>
                        </ul>        
                    </li>
                </div>
            </div>
        </div>
        <!--/header-middle-->

        <div class="header-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-sm-9">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle"
                                data-toggle="collapse"
                                data-target=".navbar-collapse">
                                <span class="sr-only">Toggle
                                    navigation</span> <span class="icon-bar"></span>
                                <span class="icon-bar"></span> <span
                                    class="icon-bar"></span>
                            </button>
                        </div>
                        <div class="mainmenu pull-left">
                            <ul
                                class="nav navbar-nav collapse navbar-collapse">
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
    <!--   <DIV class='content'> -->

</body>

<script>
function openNav() {
    if ($('#mySidenav').css('display') == 'block'){
        $("#mySidenav").slideUp(500);

        
       
        } 
    
    else{
        $("#mySidenav").slideDown(500);

            

            }

  } 

/* $('body').click(function(){
    $("#mySidenav").slideUp(500);
   
}); */
/* 
$(document).click(function(e){ //문서 body를 클릭했을때         
    if(e.target.className =="openNav"){return false} //내가 클릭한 요소(target)를 기준으로 상위요소에 .share-pop이 없으면 (갯수가 0이라면)       
    $("openNav").slideUp(500)

    });
 */


function com() {
    if ($('#sub_com').css('display') == 'block'){
        $("#sub_com").slideUp(500);
        
       
        } 
    
    else{
        $("#sub_com").slideDown(500);

            

            }

  } 




 /*  $(document).ready(function(){              
      $(".logo pull-left>img").click(function(){
          var submenu = $(this).next("mySidenav");
        if(submenu.is("none")){
            submenu.display();
            }
        else{
            submenu.slideDown();
            }
    });
  }); */

/* $(document).ready(function(){              
    $(".menu>img").click(function(){
         var submenu = $(this).next("ul"); 
         if( submenu.is(":visible") ){
              submenu.slideUp();            
              }
         else{
             submenu.slideDown();            
             }
         });
         }); */
</script>
