<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="reviewno" value="${reviewVO.reviewno }" />
<c:set var="order_itemno" value="${reviewVO.order_itemno }" />
<c:set var="productno" value="${reviewVO.productno }" />
<c:set var="rtitle" value="${reviewVO.rtitle }" />
<c:set var="rcontent" value="${reviewVO.rcontent }" />
<c:set var="file1" value="${reviewVO.file1 }" />
<c:set var="file1saved" value="${reviewVO.file1saved }" />
<c:set var="thumb1" value="${reviewVO.thumb1 }" />
<c:set var="score" value="${reviewVO.score }" />
<c:set var="mname" value="${reviewVO.mname }" />
<c:set var="size1_label" value="${reviewVO.size1_label }" />
<c:set var="rdate" value="${reviewVO.rdate }" />
<c:set var="cnt" value="${reviewVO.cnt }" />

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>리뷰</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css">

<style type="text/css">
.star {
  color:#f90;
  font-size: 2.3rem;
}

img { 
    display : block;
    margin : auto;
}
</style>

</head>

<body>
 
<jsp:include page="../menu/top2.jsp" flush='false' />
<DIV class='content_body' style="width:70%;">
  
  <fieldset class="fieldset_basic">
  
  <span style="width:50%; font-size: 1.5em; font-weight: bold;">리뷰</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <DIV>
     <c:if test="${score == 1 }"> <label for="5-stars" class="star">&#9733;</label></c:if>
  <c:if test="${score == 2 }">
        <label for="5-stars" class="star">&#9733;</label> <label for="5-stars" class="star">&#9733;</label>  
  </c:if>
  <c:if test="${score == 3 }">
        <label for="5-stars" class="star">&#9733;</label>  <label for="5-stars" class="star">&#9733;</label>  <label for="5-stars" class="star">&#9733;</label> 
  </c:if>  
  <c:if test="${score == 4 }">
        <label for="5-stars" class="star">&#9733;</label>  <label for="5-stars" class="star">&#9733;</label> <label for="5-stars" class="star">&#9733;</label> <label for="5-stars" class="star">&#9733;</label> 
  </c:if>  
  <c:if test="${score == 5 }">
        <label for="5-stars" class="star">&#9733;</label>  <label for="5-stars" class="star">&#9733;</label> <label for="5-stars" class="star">&#9733;</label> <label for="5-stars" class="star">&#9733;</label> <label for="5-stars" class="star">&#9733;</label> 
  </c:if>  
   <strong>${rtitle}</strong>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${rdate }&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-eye" > ${cnt } </i></DIV>
<%--    <DIV style="text-align: right;">
        <button type="button" onclick="location.href='./read_update.do?qnano=${qnaVO.qnano}'"  class="btn">수정</button>
        <button type="submit"  onclick="location.href='./read_delete.do?qnano=${qnaVO.qnano}'" class="btn">삭제</button>
        </DIV> --%>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   
   
    <DIV style="width: 60%; float: initial; margin-left:180px">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/contents/storage/ --%>
                <IMG src="/review/storage/${file1saved }" style="width: 100%;"> 
              </c:when>              
            </c:choose>
    </DIV>
   <br>
   <DIV>${rcontent }</DIV> 
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>