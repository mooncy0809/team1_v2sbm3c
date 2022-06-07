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
<%--   <ASIDE class="aside_right">
    <A href="./create.do?cateno=${cateVO.cateno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }&now_page=${param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_grid.do?cateno=${cateVO.cateno }">갤러리형</A>
    <span class='menu_divide' >│</span>
    <A href="./update_text.do?contentsno=${contentsno}&now_page=${param.now_page}&word=${param.word }">수정</A>
    <span class='menu_divide' >│</span>
    <A href="./update_file.do?contentsno=${contentsno}&now_page=${param.now_page}&word=${param.word }">파일 수정</A>  
    <span class='menu_divide' >│</span>
    <A href="./delete.do?contentsno=${contentsno}&now_page=${param.now_page}&cateno=${cateno}&word=${param.word }">삭제</A>  
  </ASIDE>  --%>
  
<%--   <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> 검색하는 경우
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> 검색하지 않는 경우
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search_paging.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV> --%>
  
  <fieldset class="fieldset_basic">
    <DIV class='title_line'>
    <A href="./list_by_categrpno_grid.do?categrpno=4" class='title_link' >홈트레이닝</A> > 
    ${youVO.ytitle }
    </DIV>
   <DIV class='menu_line'style="width:50%; font-size: 1.5em; font-weight: bold;">
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

