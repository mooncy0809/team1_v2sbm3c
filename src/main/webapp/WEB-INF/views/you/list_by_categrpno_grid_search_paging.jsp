<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>HomeTraining</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css"></head>

<script type="text/javascript">
 
  
</script>

<style>
.circle {
    width:300px;
    height:300px;
    border-radius:50%;
    background:#transparent;
    font-size:25px;
    text-align:center;
    line-height:110px;
    color:#FF8B6E;
    font-family:'Open Sans';
    font-weight:bold;    
}

iframe {
    width:300px;
    height:300px;
    border-radius:50%;
    box-shadow: 40px 40px 40px 40px grey;   
}

</style>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'style="width:1100px;"><A href="./list_by_categrpno_grid_search_paging.do?categrpno=${categrpVO.categrpno}&word=" class='title_link'>유튜브 그룹</A> > ${categrpVO.name }</DIV>

<%-- <DIV class='title_line'style="width:70%;"><A href="./list_by_categrpno_grid_search_paging.do?categrpno=${categrpVO.categrpno}&word=" class='title_link'>유튜브 그룹</A> > ${categrpVO.name }</DIV>
 --%>
<DIV class='content_body' style="width:58%;">
<span style="width:70%; font-size: 1.5em; font-weight: bold;">
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">

</span>
  <DIV style="text-align: right; clear: both; ">  
    <form name='frm' id='frm' method='get' action='./list_by_categrpno_grid_search_paging.do'>
      <input type='hidden' name='categrpno' value='${categrpVO.categrpno }'>
      <input type='hidden' name='now_page' value='1'> <%-- 최초 검색시 시작 페이지 지정 --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit' class="btn btn-primary">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class="btn btn-primary"
                     onclick="location.href='./list_by_categrpno_grid_search_paging.do?categrpno=${categrpVO.categrpno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  

  
  <fieldset>
  <DIV class='content_body' style="width:1100px;">
  <ASIDE class="aside_right">&nbsp;
    <A style="color:black;" href="javascript:location.reload();"><i class="fa-solid fa-arrow-rotate-right"></i>&nbsp;새로고침</A>
  </ASIDE> 
  
  <div style='width: 1000px;'> <%-- 갤러리 Layout 시작 --%>  
    <c:forEach var="youVO" items="${list }" varStatus="status">
      <c:set var="youno" value="${youVO.youno }" />
      <c:set var="ytitle" value="${youVO.ytitle }" />
      <c:set var="url" value="${youVO.url }" />
      <c:set var="cnt" value="${youVO.cnt }" />
      
     <c:if test="${status.index % 3 == 0 && status.index != 0 }"> 
        <HR class='menu_line' >
      </c:if> 
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <a href ="./read.do?youno=${youVO.youno}">

      <DIV class='circle' style='float: left; margin:0.5%; padding:0.5%;'>
        <div class="product-image-wrapper " style='width:300px; height:300px;border-radius:50%; margin:0.5%; padding:0.5%;'>
          <div class="single-products" style='width:300px; height:300px; border-radius:50%; margin:0.5%; padding:0.5%; '> <!-- 수직 가운데 정렬 -->
          <div class="productinfo text-centerv" style='margin:0.5%; padding:0.5%;'>
               ${url }<br>
          </div>
          
          <div class="product-overlay" style="background: rgba(255,242,238,.9); border-radius:50%;  transition: all 300ms ease-in-out; margin:0.5%; padding:0.5%;">
          <div class="overlay-content" style="width:100%;border-radius:50%;">           
            
            <div style="width:100%; word-wrap: break-word;">
                ${ytitle} <br>     
                <i class="fa-solid fa-eye" >&nbsp; ${cnt} <br> </i>
            </div>
      </div>  
      </div>
          
         </DIV>
          </DIV>  
        </DIV></a>
        

    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
  </div>
</DIV>
 </fieldset>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>