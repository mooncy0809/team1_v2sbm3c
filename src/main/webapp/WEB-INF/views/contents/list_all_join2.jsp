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
 
<DIV class='title_line'><A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 전체 카테고리</DIV>

<DIV class='content_body'>
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
      <col style='width: 30%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">카테고리<br> 이름</TH>
      
      <TH class="th_bs">제목</TH>
      <TH class="th_bs">내용</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">조회수</TH>
      <TH class="th_bs">작성자</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="cate_ContentsVO" items="${list}">
      <c:set var="r_name" value="${cate_ContentsVO.r_name }" />
      <c:set var="contentsno" value="${cate_ContentsVO.contentsno }" />
      <c:set var="cateno" value="${cate_ContentsVO.cateno }" />
      <c:set var="title" value="${cate_ContentsVO.title }" />
      <c:set var="content" value="${cate_ContentsVO.content }" />
      <c:set var="rdate" value="${cate_ContentsVO.rdate.substring(0, 10) }" />
      <c:set var="cnt" value="${cate_ContentsVO.cnt }" />
      <c:set var="mname" value="${cate_ContentsVO.mname }" />
      
      <TR>
        <TD class="td_bs">${r_name }</TD>
        
        <TD class="td_bs_left">
        <A href = '../contents/read.do?contentsno=${contentsno}'>${title }</A>
        </TD>
        <TD class="td_bs">${content }</TD>
        <TD class="td_bs">${rdate }</TD>
        <TD class="td_bs">${cnt }</TD>
        <TD class="td_bs">${mname }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?cateno=${cateno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?cateno=${cateno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>