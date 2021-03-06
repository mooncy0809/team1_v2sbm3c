<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Community</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->

 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
</script>

<style type="text/css">
 ::-webkit-scrollbar {
  width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
  box-shadow: inset 0 0 5px white;
  border-radius: 10px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: #E96D53;
  border-radius: 10px;
}
 </style>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
 
<!-- <DIV class='title_line'>
  <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 전체 게시물
</DIV> -->

<DIV class='content_body' style="width:58%;">
 <span style="width:70%; font-size: 1.5em; font-weight: bold;">전체 게시물</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <br>

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_all_join.do'>
      
      <input type='hidden' name='now_page' value='1'> <%-- 최초 검색시 시작 페이지 지정 --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit' class="btn btn-primary">검색</button>
      <c:if test="${param.word.length() > 0 }">

        <button type='button' 
                     onclick="location.href='./list_all_join.do?word='">검색 취소</button> 

      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <table class="table" style='width: 100%;'>
    <colgroup>
      <%-- <col style="width: 10%;"></col> --%>
      <col style="width: 10%;"></col>
      <col style="width: 35%;"></col>
      <col style="width: 25%;"></col>
      <col style="width: 7%;"></col>
      <col style="width: 10%;"></col>
      <col style="width: 13%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
    <thead>
      <tr>
        <!-- <th style='text-align: center;'></th> -->
        <th style='text-align: center;'>카테고리</th>
        <th style='text-align: center;'>제목</th>
        <th style='text-align: center;'>내용</th>
        <th style='text-align: center;'>조회수</th>
        <th style='text-align: center;'>작성자</th>
        <th style='text-align: center;'>작성일</th>
      </tr>
    
    </thead>
    
    <%-- table 내용 --%>
    
    <tbody>

      <c:forEach var="contentsVO" items="${list }">
        <c:set var="contentsno" value="${contentsVO.contentsno }" />
        <c:set var="cateno" value="${contentsVO.cateno }" />
        <c:set var="name" value="${contentsVO.name }" />
        <c:set var="title" value="${contentsVO.title }" />
        <c:set var="content" value="${contentsVO.content }" />
        <c:set var="file1" value="${contentsVO.file1 }" />
        <c:set var="thumb1" value="${contentsVO.thumb1 }" />
        <c:set var="memberno" value="${contentsVO.memberno }" />
        <c:set var="cnt" value="${contentsVO.cnt }" />
        <c:set var="mname" value="${contentsVO.mname }" />
        <c:set var="rdate" value="${contentsVO.rdate }" />
        <c:set var="replycnt" value="${contentsVO.replycnt }" />      
          
          <tr <c:if test="${cateno eq 1}"> style='background-color:#FFDCD3; font-weight:bold;' </c:if>>           
          
          <td style='vertical-align: middle; text-align: center;'>${name} </td> 
          
          <td style='vertical-align: middle; text-align: center; '>
            <a href="./read.do?contentsno=${contentsno}&now_page=${param.now_page }&word=${param.word }">
          <strong>${title} [${replycnt}]</strong> </a> </td>
          
          <td style='vertical-align: middle; text-align: center;'>${content} </td> 
          
          <!-- 조회수 -->
          <td style='vertical-align: middle; text-align: center;'>${cnt } </td>
          
          <!-- 작성자 -->
          <td style='vertical-align: middle; text-align: center;'>${mname } </td>
          
          <!-- 작성일 -->
          <td style='vertical-align: middle; text-align: center;'>${rdate } </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>

 
</html>