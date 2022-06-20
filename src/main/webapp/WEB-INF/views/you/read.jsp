<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="youno" value="${youVO.youno }" />
<c:set var="categrpno" value="${youVO.categrpno }" />
<c:set var="ytitle" value="${youVO.ytitle }" />        
<c:set var="ytext" value="${youVO.ytext }" /> 
<c:set var="url" value="${youVO.url }" /> 
<c:set var="cnt" value="${youVO.cnt }" /> 
<c:set var="rdate" value="${youVO.rdate }" /> 

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>삼대몇</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 


<DIV class='content_body' style="width:70%;">
  
  <fieldset class="fieldset_basic">
    <DIV class='title_line'>
    <A href="./list_by_categrpno_grid_search_paging.do?categrpno=${categrpVO.categrpno}&word=" class='title_link'>홈트레이닝</A> >
       <c:choose>
                                    <c:when
                                        test="${sessionScope.grade < 10}">
                                        <%-- 로그인 한 경우 --%>
                                       <a href="../../you/list_by_categrpno_search_paging.do?categrpno=4&word=">
                                                홈트레이닝(관리자 전용 링크)</a>   >              
                                    </c:when>
        </c:choose> 
    ${youVO.ytitle }
    </DIV>
   <DIV class='menu_line'style="width:1000px; font-size: 1.5em; font-weight: bold;">
       ${ytitle }<br>
   </DIV>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <DIV>${rdate }&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;조회수: ${cnt }</DIV>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <DIV align="center">${url }</DIV>
   <br>
   <span style="width:50%; font-size: 1.5em; font-weight: bold;">영상 소개</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <DIV>${ytext }</DIV> 
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

