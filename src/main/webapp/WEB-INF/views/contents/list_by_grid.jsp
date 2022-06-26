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
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css"></head>

<script type="text/javascript">
 
  
</script>

<style>

.size {
    width: 200px;
    height: 150px;
}

/* 공통적으로 모든 태그 모든 아이들을 박스 사이징을 borderbox로 한다.
 우리가 패딩을 줬을 때 동일한 높이와 너비가 되도록 만든다. */
* {
  box-sizing: border-box;
}
  
.grid__list {
  display: flex;
  justify-content: flex-start;
  flex-wrap: wrap;
  padding-left: 0px;
  margin-right: -1rem;
  margin-left: -1rem;
  margin-top: 0px;
  margin-bottom: 0px;
  transition: all 200ms ease-in;
}

.grid__list-item {
  position: relative;
  max-width: 220px;
  padding-right: 1rem;
  padding-left: 1rem;
  flex: 0 0 100%;
  padding-bottom: 2rem;
}

.grid__card {
  background-color:#FFF2EE;
  border: solid 3px #ffdcd3;
  text-decoration: none;
  height: 100%;
  display: flex;
  flex-direction: column;
  color: #0c1721;
  box-shadow: 1px 10px 15px 1px grey;
  transition: all 160ms ease-in-out;
}

.grid__card:hover {
  transform: translateY(-15px);
  box-shadow: 12px 10px 11px 7px gray;
  filter: brightness(102%);
}

.grid__description {
  padding: 2rem 1rem 1rem;
  flex-grow: 1;
  position: relative;
  text-align: center;
  margin-bottom: auto;
}

.grid__detail {
  display: flex;
  flex-wrap: wrap;
  line-height: 1;
}


.grid__title {
  font-size: 1.6rem !important;
  text-align: center;
  margin-top: 0px;
  margin-bottom: 16px;
  
}

.grid__content {

  text-align: center;
  margin: 0 0 0.5rem;
  font-size: 1.2rem !important;
  font-weight: bold;
  opacity: 0.6;
}

.grid__img {
  position: relative;
  width: 100%;
  height: 150px;
  overflow: hidden;
}

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

</style>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
 
<%-- <DIV class='title_line'style="width:70%;"><A href="./list_by_categrpno_grid_search_paging.do?categrpno=${categrpVO.categrpno}&word=" class='title_link'>유튜브 그룹</A> > ${categrpVO.name }</DIV>
 --%>
<DIV class='content_body' style="width:58%;">
    <span style="width:70%; font-size: 1.5em; font-weight: bold;">
        <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }">${cateVO.name }</A>        
    </span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">

<ASIDE class="aside_right">&nbsp;
    <A style="color:black;" href="javascript:location.reload();"><i class="fa-solid fa-arrow-rotate-right"></i>&nbsp;새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }">기본 목록형</A>
  </ASIDE> 

  <DIV style="text-align: right; clear: both; ">  
    <form name='frm' id='frm' method='get' action='./list_by_grid.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <input type='hidden' name='now_page' value='1'> <%-- 최초 검색시 시작 페이지 지정 --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit' class="btn btn-primary">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class="btn btn-primary"
                     onclick="location.href='./list_by_grid.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <fieldset>
  <DIV class='content_body' style="width:880px;">
  
  <DIV class='menu_line'></DIV>
  
  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>  
        <ul class='grid__list'>
      <c:forEach var="contentsVO" items="${list }" varStatus="status">
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
        <c:set var="recom" value="${contentsVO.recom }" />
      
     <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if> 
      <!-- 하나의 이미지, 24 * 4 = 96% -->


      <li class='grid__list-item'>
          <DIV class='grid__card'>
                  <DIV class="grid__description">  
                    <p class='grid__title'>${title} </p> <!-- 수직 가운데 정렬 -->
	                <p class='grid__content'> ${content } </p>
                    <DIV style="text-align:right;"> <i class="fa-solid fa-eye" >&nbsp;${cnt}</i> &nbsp;<i class="fa-solid fa-heart">&nbsp;${recom }</i><br></DIV>   
                   </DIV>
                   
                   <DIV class='grid__detail'> </DIV>       

            <c:choose>
				<c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
				<%-- /static/contents/storage/ --%>
				    <div class='grid__img'><a href="./read.do?contentsno=${contentsno}&now_page=${param.now_page }"><IMG class='size' src="/contents/storage/${thumb1 }"></a></div> 
				</c:when>
				<c:otherwise> <!-- 기본 이미지 출력 -->
				    <a href="./read.do?contentsno=${contentsno}&now_page=${param.now_page }"><IMG class='size' src="/contents/images/none1.png"></a>
				</c:otherwise>
			</c:choose>
                  
                   
      </DIV>  
      
    </li>
    
    </c:forEach>
    </ul>
  </div>
  
</DIV>

 </fieldset>
  
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