<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>Community</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gaegu:wght@300&family=Kdam+Thmor+Pro&family=Kirang+Haerang&family=Nanum+Gothic&display=swap" rel="stylesheet">

<style type="text/css">
 table.type04 {
  border-collapse: separate;
  border-spacing: 1px;
  text-align: center;
  margin:auto;
  padding-top: 20px;
  line-height: 0.5;
  font-size: 13px;
  
}
table.type04 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}
a{
    color: black;
    text-decoration: none;
    font-family: 'Kdam Thmor Pro', sans-serif;
   font-family: 'Gaegu', cursive;
   font-size: 12px;
    
    
}
a:hover{
    color: white;
}
.style1{
    padding : 10px 10px 10px 10px;
    text-align: center;
}

h1{
    font-family: 'Kirang Haerang', cursive;
}

.eng{
    font-family: 'Kirang Haerang', cursive;
    font-size:20px;
}



 
 </style>
</head> 
  
<body >
 
<div class="style1">
  <table class="type04" style='width: 70%;'>
    <%-- table 컬럼 --%>
    
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
        
        
        <tr>  
          <td style='vertical-align: middle; text-align: left;'>
            <a href="./read.do?contentsno=${contentsno}&now_page=${param.now_page }&word=${param.word }" target="_top">
            <strong> ${title}</strong> </a> </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  <a href="../contents/notice_by_cateno.do" target="_top"><h1 style="font-size: 40px">자유게시판<div class="eng">COMMUNITY</div></h1></a>
  </div>
 
</body>
 
</html>