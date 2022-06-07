<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 

<DIV class='content_body' style="width:70%;">

  <DIV class='title_line'><A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > ${categrpVO.name }</DIV>
   
  <ASIDE class="aside_right">
<!--   /you/create.do?categrpno=2 -->
    <A href="./create.do?categrpno=4">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
<!--     <span class='menu_divide' >│</span>
    <A href="./list_by_categrpno_grid.do?categrpno=4">갤러리형</A> -->
  </ASIDE> 

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
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
 