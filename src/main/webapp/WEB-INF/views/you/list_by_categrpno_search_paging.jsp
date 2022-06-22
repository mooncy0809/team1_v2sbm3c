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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
 
  
</script>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
 


<DIV class='content_body' style="width:70%;">
<span style="width:70%; font-size: 1.2em; font-weight: bold;">
  <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <%-- <A href="../cate/list_by_categrpno.do?categrpno=${categrpVO.categrpno }" class='title_link'>${categrpVO.name }</A> > --%>
  <A href="./list_by_categrpno_search_paging.do?categrpno=4" class='title_link'>${categrpVO.name }</A>
</span>
  <ASIDE class="aside_right">
    <c:if test="${sessionScope.id != null }"> 
        <A href="./create.do?categrpno=${categrpVO.categrpno }">등록</A>    
    <span class='menu_divide' >│</span>
    </c:if>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
  </ASIDE> 

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
  
  <DIV class='menu_line'></DIV>
  
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 5%;'/>
      <col style='width: 20%;'/>
      <col style='width: 15%;'/>
      <col style='width: 35%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs"></TH>
      <TH class="th_bs">제목</TH>
      <TH class="th_bs">내용</TH>
      <TH class="th_bs">주소</TH>
      <TH class="th_bs">조회수</TH>
      <TH class="th_bs">날짜</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="youVO" items="${list}">
      <c:set var="youno" value="${youVO.youno }" />
      <TR>
        <TD class="td_bs">${youVO.youno }</TD>  
        <TD class="td_bs_left"><a href ="./read.do?youno=${youVO.youno}">${youVO.ytitle }</a></TD>
        <TD class="td_bs">${youVO.ytext }</TD>
        <TD class="td_bs">${youVO.url }</TD>
        <TD class="td_bs">${youVO.cnt }</TD>
        <TD class="td_bs">${youVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?youno=${youno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?youno=${youno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>