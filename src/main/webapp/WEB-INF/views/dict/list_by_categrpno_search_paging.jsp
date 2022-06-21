<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Calorie Dictionary</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->

 
<link href="/css/bootstrap.min.css" rel="stylesheet">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
 
  
</script>
<%int rownum=1; %>
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
<%--  
    <DIV class='title_line'>
    <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 
    <c:choose>
    <c:when test="${sessionScope.grade < 10}"> 로그인 한 경우
    <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 
    </c:when>
    </c:choose>${categrpVO.name }
   </DIV> --%>

<DIV class='content_body'  style="width:58%;">
<span style="width:70%; font-size: 1.5em; font-weight: bold;">칼로리 사전</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_categrpno_search_paging.do'>
      <input type='hidden' name='categrpno' value='${categrpVO.categrpno }'>
      <input type='hidden' name='now_page' value='1'> <%-- 최초 검색시 시작 페이지 지정 --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit' class="btn btn-primary">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class="btn btn-primary"
                     onclick="location.href='./list_by_categrpno_search_paging.do?categrpno=${categrpVO.categrpno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
   <br>
<!--    <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
  -->  <c:choose>
   <c:when test="${param.word.length() > 0 }">
   <span style="width:50%; font-size: 1.5em; font-weight:bold;">검색 결과</span>
   </c:when>
   <c:otherwise>
   <span style="width:50%; font-size: 1.5em; ">금주의 음식칼로리 <strong style="color:#FF8B6E;">검색 순위 TOP 30</strong></span>
   </c:otherwise>
   </c:choose>
  <DIV style="padding-top: 8px; ">
  <TABLE class='table table-striped' style="border-top: 1px solid #444444;">
    <colgroup>
    <c:choose>
    <c:when test="${param.word.length() > 0 }">
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
    </c:when>
    <c:otherwise>
      <col style='width: 5%;'/>
      <col style='width: 18%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
    </c:otherwise>
    </c:choose>
    </colgroup>
   
    <thead>  
    <TR> 
    <c:choose>
    <c:when test="${param.word.length() > 0 }">
      <TH class="th_bs">음식명</TH>
      <TH class="th_bs">1회 제공량(g)</TH>
      <TH class="th_bs">칼로리(kcal)</TH>
      <TH class="th_bs">탄수화물(g)</TH>
      <TH class="th_bs">단백질(g)</TH>
      <TH class="th_bs">지방(g)</TH>
      <TH class="th_bs">당류(g)</TH>
      <TH class="th_bs">나트륨(mg)</TH>
      <TH class="th_bs" style="text-align:center;">조회수</TH>
    </c:when>
    <c:otherwise>
      <TH class="th_bs" style="text-align:center;">순위</TH>
      <TH class="th_bs">음식명</TH>
      <TH class="th_bs">1회 제공량(g)</TH>
      <TH class="th_bs">칼로리(kcal)</TH>
      <TH class="th_bs">탄수화물(g)</TH>
      <TH class="th_bs">단백질(g)</TH>
      <TH class="th_bs">지방(g)</TH>
      <TH class="th_bs">당류(g)</TH>
      <TH class="th_bs">나트륨(mg)</TH>
      <TH class="th_bs" style="text-align:center;">조회수</TH>
    </c:otherwise>
    </c:choose>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="dictVO" items="${list}">
      <c:set var="dictno" value="${dictVO.dictno }" />
      
      <TR>
      <c:choose>
      <c:when test="${param.word.length() > 0 }">
        <TD class="td_bs_left"><a href ="./read.do?dictno=${dictVO.dictno}">${dictVO.fname }</a></TD>
        <TD class="td_bs">${dictVO.fsize }</TD>
        <TD class="td_bs">${dictVO.kcal } kcal</TD>
        <TD class="td_bs">${dictVO.carbo } g</TD>
        <TD class="td_bs">${dictVO.protein } g</TD>
        <TD class="td_bs">${dictVO.fat } g</TD>
        <TD class="td_bs">${dictVO.sugar } g</TD>
        <TD class="td_bs">${dictVO.sodium } mg</TD>
        <TD class="td_bs" style="text-align:center;">${dictVO.cnt }</TD>
     </c:when>
     <c:otherwise>
        <TD class="td_bs" style="text-align:center;"><%=rownum %><%rownum+=1;%></TD>  
        <TD class="td_bs_left"><a href ="./read.do?dictno=${dictVO.dictno}">${dictVO.fname }</a></TD>
        <TD class="td_bs">${dictVO.fsize }</TD>
        <TD class="td_bs">${dictVO.kcal } kcal</TD>
        <TD class="td_bs">${dictVO.carbo } g</TD>
        <TD class="td_bs">${dictVO.protein } g</TD>
        <TD class="td_bs">${dictVO.fat } g</TD>
        <TD class="td_bs">${dictVO.sugar } g</TD>
        <TD class="td_bs">${dictVO.sodium } mg</TD>
        <TD class="td_bs" style="text-align:center;">${dictVO.cnt }</TD>
     </c:otherwise>
     </c:choose>
    </TR>   
    </c:forEach> 
    </tbody>
  </TABLE>
  </DIV>
  <!-- 페이지 목록 출력 부분 시작 -->
  <c:if test="${param.word.length() > 0 }">
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  </c:if>
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>