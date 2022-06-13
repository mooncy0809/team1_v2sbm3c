<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="qnano" value="${qnaVO.qnano }" />
<c:set var="categrpno" value="${qnaVO.categrpno }" />
<c:set var="memberno" value="${qnaVO.memberno }" />
<c:set var="title" value="${qnaVO.title }" />        
<c:set var="content" value="${qnaVO.content }" /> 
<c:set var="pwd" value="${qnaVO.pwd }" />
<c:set var="rdate" value="${qnaVO.rdate }" /> 

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>관리자에게</title>
 
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
  <span style="width:50%; font-size: 1.5em; font-weight: bold;">관리자에게</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <DIV>제목: ${title}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${rdate }</DIV>
   <DIV style="text-align: right;">
        <button type="button" onclick="location.href='./read_update.do?qnano=${qnaVO.qnano}'"  class="btn">수정</button>
        <button type="submit"  onclick="location.href='./read_delete.do?qnano=${qnaVO.qnano}'" class="btn">삭제</button>
        </DIV>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <br>
   <DIV>${content }</DIV> 
  </fieldset>
  
  

</DIV>

<!-- ------------------------------ 댓글 영역 시작 ------------------------------ -->
<DIV style='width: 80%; margin: 0px auto;'>
    <HR>
    <FORM name='frm_reply' id='frm_reply'> <%-- 댓글 등록 폼 --%>
        <input type='hidden' name='contentsno' id='contentsno' value='${contentsno}'>
        <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
        
        <textarea name='content' id='content' style='width: 100%; height: 60px;' placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea>
        <input type='password' name='passwd' id='passwd' placeholder="비밀번호">
        <button type='button' id='btn_create'>등록</button>
    </FORM>
    <HR>
    <DIV id='reply_list' data-replypage='1'>  <%-- 댓글 목록 --%>
    
    </DIV>
    <DIV id='reply_list_btn' style='border: solid 1px #EEEEEE; margin: 0px auto; width: 100%; background-color: #EEFFFF;'>
        <button id='btn_add' style='width: 100%;'>더보기 ▽</button>
    </DIV>  
  
</DIV>

<!-- ------------------------------ 댓글 영역 종료 ------------------------------  -->
  
   
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

