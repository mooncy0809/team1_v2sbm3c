<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>관리자에게</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
function btn(sample){  
    alert(sample); 
    document.location.href="/member/login.do";
 }  
</script>
</head>
<body>
 <jsp:include page="../menu/top.jsp" />
<DIV class='content_body'>
<span style="width:70%; font-size: 1.5em; font-weight: bold;">관리자에게</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <br>
    
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 40%;'/>
      <col style='width: 30%;'/>
      <col style='width: 40%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">제목</TH>
      <TH class="th_bs">작성자</TH>
      <TH class="th_bs">작성일</TH>

    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="Member_QnaVO" items="${list}">
      <c:set var="title" value="${Member_QnaVO.title }" />
      <c:set var="m_id" value="${Member_QnaVO.m_id }" />
      <c:set var="rdate" value="${Member_QnaVO.rdate }" />   
      <TR> 
        <TD class="td_bs">
        <c:choose>
        <c:when test="${sessionScope.grade < 10}">
                <a href ="./read.do?qnano=${Member_QnaVO.qnano}">${title}</a>     
        </c:when>
        <c:otherwise>
         <a href ="./input_pwd.do?qnano=${Member_QnaVO.qnano}">${title}</a>
        </c:otherwise>
        
        
        </c:choose>
        </TD>  
        <TD class="td_bs">${m_id}</TD>     
        <TD class="td_bs">${rdate}</TD>   
        
      </TR>   
      
    </c:forEach> 
  </tbody>

  </TABLE>
  
  <div style="text-align:right;">  
  <c:choose>
  <c:when test="${sessionScope.id == null}">
      <button type="button" class="btn btn-primary"
                            onclick="javascript:btn('로그인 후 이용해주세요.' )">글쓰기</button>
                            
  </c:when>
  <c:otherwise>
  <button type="button" class="btn btn-primary"
                            onclick="location.href='./create.do?categrpno=4&memberno=${sessionScope.memberno}'">글쓰기</button>
  </c:otherwise>
  </c:choose>
  </div>

</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
</html>