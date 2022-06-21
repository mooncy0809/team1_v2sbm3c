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
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
 
<%-- <DIV class='title_line'style="width:70%;"><A href="./list_by_categrpno_grid_search_paging.do?categrpno=${categrpVO.categrpno}&word=" class='title_link'>유튜브 그룹</A> > ${categrpVO.name }</DIV>
 --%>
<DIV class='content_body' style="width:58%;">
<span style="width:70%; font-size: 1.5em; font-weight: bold;">홈트레이닝</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">


  <DIV style="text-align: right; clear: both; ">  
    <form name='frm' id='frm' method='get' action='./list_by_categrpno_grid_search_paging.do'>
      <input type='hidden' name='categrpno' value='${categrpVO.categrpno }'>
      <input type='hidden' name='now_page' value='1'> <%-- 최초 검색시 시작 페이지 지정 --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_categrpno_grid_search_paging.do?categrpno=${categrpVO.categrpno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <fieldset>
  <DIV class='content_body' style="width:1100px;">
  <ASIDE class="aside_right">&nbsp;
    <A style="color:black;" href="javascript:location.reload();"><i class="fa-solid fa-arrow-rotate-right"></i>&nbsp;새로고침</A>
  </ASIDE> 
  <DIV class='menu_line'></DIV>
  
  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>  
    <c:forEach var="youVO" items="${list }" varStatus="status">
      <c:set var="youno" value="${youVO.youno }" />
      <c:set var="ytitle" value="${youVO.ytitle }" />
      <c:set var="url" value="${youVO.url }" />
      <c:set var="cnt" value="${youVO.cnt }" />
      
     <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if> 
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <a href ="./read.do?youno=${youVO.youno}">
      <DIV style='width: 24%; 
              float: left; 
              margin: 0.5%; padding: 0.5%; background-color: #FFDCD3; text-align: center;'>
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style=' color: black; display: table-cell; vertical-align: middle; text-align: center; font-weight: bold;'> <!-- 수직 가운데 정렬 -->
                   ${url } <br>
                   ${ytitle} <br>
                   <DIV style="text-align:right;">
                   <i class="fa-solid fa-eye" >&nbsp;${cnt}</i> <br></DIV>   
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