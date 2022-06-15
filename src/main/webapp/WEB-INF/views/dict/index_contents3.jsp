<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>Calorie Dictionary</title>
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


 
 </style>
</head> 
  
<body>
<div class="style1">
  <table class="type04" style='width: 70%;'>
    <tbody>
    <c:forEach var="dictVO" items="${list}">
      <c:set var="dictno" value="${dictVO.dictno }" />
      
      <TR>
        <td style='vertical-align: middle; text-align: left;'>
        <a href ="./read.do?dictno=${dictVO.dictno}"  target="_top">
        <strong>${dictVO.fname }</strong>
        <strong>${dictVO.kcal }kcal</strong>
        </a></td>
    </TR>   
    </c:forEach> 
    
    </tbody>
  </TABLE>
  <a href="../dict/list_by_categrpno_search_paging.do?categrpno=5" target="_top"><h1 style="font-size: 40px">칼로리사전</h1></a>
  
  </DIV>

</body>
 
</html>