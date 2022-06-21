<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Community</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

 <link href="/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
function btn(sample){  
    alert(sample); 
    document.location.href="/member/login.do";
 }  


function changeSize() {
    document.getElementsByClassName("size")[0].style.width = "200px";
    document.getElementsByClassName("size")[0].style.height = "150px";
  }
</script>
 
<style type="text/css">
.size{
    width: 120px; 
    height: 80px;
}
</style>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />

<DIV class='content_body' style="width:58%;">
    <span style="width:70%; font-size: 1.5em; font-weight: bold;">
        <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }">${cateVO.name }</A>
    </span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_grid.do?cateno=${param.cateno }" onclick="changeSize()"">갤러리형</A>

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <input type='hidden' name='now_page' value='1'> <%-- 최초 검색시 시작 페이지 지정 --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit' class="btn btn-primary">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class="btn btn-primary"
                     onclick="location.href='./list_by_cateno_search_paging.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 30%;"></col>
      <col style="width: 10%;"></col>
      <col style="width: 10%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
    <thead>
      <tr>
        <th style='text-align: center;'></th>
        <th style='text-align: center;'>제목</th>
        <th style='text-align: center;'>내용</th>
        <th style='text-align: center;'>조회수</th>
        <th style='text-align: center;'>작성자</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead>
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="contentsVO" items="${list }">
        <c:set var="contentsno" value="${contentsVO.contentsno }" />
        <c:set var="cateno" value="${contentsVO.cateno }" />
        <c:set var="title" value="${contentsVO.title }" />
        <c:set var="content" value="${contentsVO.content }" />
        <c:set var="file1" value="${contentsVO.file1 }" />
        <c:set var="thumb1" value="${contentsVO.thumb1 }" />
        <c:set var="memberno" value="${contentsVO.memberno }" />
        <c:set var="cnt" value="${contentsVO.cnt }" />
        <c:set var="mname" value="${contentsVO.mname }" />
        <c:set var="replycnt" value="${contentsVO.replycnt }" />
        
        
        <tr> 
          <td style='vertical-align: middle; text-align: center; '>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/contents/storage/ --%>
                <a href="./read.do?contentsno=${contentsno}&now_page=${param.now_page }"><IMG class='size' src="/contents/storage/${thumb1 }" ></a> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG class='size' src="/contents/images/none1.png" ">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle; text-align: center;'>
            <a href="./read.do?contentsno=${contentsno}&now_page=${param.now_page }&word=${param.word }">
            <strong>${title} [${replycnt }]</strong> </a> </td>
          <td style='vertical-align: middle; text-align: center;'>${content} </td> 
          
          <!-- 조회수 -->
          <td style='vertical-align: middle; text-align: center;'>${cnt } </td>
          
          <!-- 작성자 -->
          <td style='vertical-align: middle; text-align: center;'>${mname } </td>
          
          
          
          <td style='vertical-align: middle; text-align: center;'>
            <A href="./update_text.do?contentsno=${contentsno}&now_page=${param.now_page }"><img src="/contents/images/update.png"></A>
            <A href="./delete.do?contentsno=${contentsno}&now_page=${param.now_page }&cateno=${cateno}"><img src="/contents/images/delete.png"></A>
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  
  <div style="text-align:right;">  
  <c:choose>
  <c:when test="${sessionScope.id == null}">
      <button type="button" class="btn btn-primary"
                            onclick="javascript:btn('로그인 후 이용해주세요.' )">글쓰기</button>
                            
  </c:when>
  <c:otherwise>
  <button type="button" class="btn btn-primary"
                            onclick="location.href='./create.do?cateno=${cateVO.cateno }'">글쓰기</button>
  </c:otherwise>
  </c:choose>
  </div>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>