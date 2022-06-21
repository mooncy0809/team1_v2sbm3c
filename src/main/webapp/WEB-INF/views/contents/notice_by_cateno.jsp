<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>공지사항</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
function btn(sample){  
    alert(sample); 
    document.location.href="/member/login.do";
 }  
  
</script>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />

<DIV class='content_body' style="width:58%;">
<span style="width:70%; font-size: 1.5em; font-weight: bold;">공지사항</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">


  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./notice_by_cateno.do'>
      <input type='hidden' name='categrpno' value='${categrpVO.categrpno }'>
      <input type='hidden' name='now_page' value='1'> <%-- 최초 검색시 시작 페이지 지정 --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./notice_by_cateno.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 60%;'/>
      <col style='width: 20%;'/>
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">제목</TH>
      <TH class="th_bs">작성자</TH>
      <TH class="th_bs" style='vertical-align: middle; text-align: center;'>작성일</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="contentsVO" items="${list}">
      <c:set var="title" value="${contentsVO.title }" />
      <c:set var="mname" value="${contentsVO.mname }" />
      <c:set var="rdate" value="${contentsVO.rdate }" />   
      <TR> 
        <TD class="td_bs">

        <a href ="./read.do?contentsno=${contentsVO.contentsno}">${title}</a>     

        </TD>  
        <TD class="td_bs">${mname}</TD>     
        <TD class="td_bs" style='vertical-align: middle; text-align: center;'>${rdate}</TD>   
        
      </TR>   
      
    </c:forEach> 
    </tbody>
   
  </TABLE>
  
    <div style="text-align:right;">  
  <c:choose>
  <c:when test="${sessionScope.grade < 10}">
      <button type="button" class="btn btn-primary"
                            onclick="location.href='./notice_create.do?cateno=${cateVO.cateno }'">글쓰기</button>
                            
  </c:when>
  <%-- <c:otherwise>
  
  <button type="button" class="btn btn-primary"
                            onclick="location.href='./create.do?cateno=${cateVO.cateno }'">글쓰기</button>
  </c:otherwise> --%>
  </c:choose>
  </div>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>