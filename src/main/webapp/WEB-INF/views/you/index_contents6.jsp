<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>HomeTraining</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gaegu:wght@300&family=Kdam+Thmor+Pro&family=Kirang+Haerang&family=Nanum+Gothic&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css">
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

::-webkit-scrollbar {
  width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
  box-shadow: inset 0 0 5px #FFDCD3;
  border-radius: 10px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: #FF8B6E;
  border-radius: 10px;
}
</style>
 
</head> 
  
<body>
<div class="style1">
  <table class="type04" style='width: 60%;'>
  <tbody> <%-- 갤러리 Layout 시작 --%>  
    <c:forEach var="youVO" items="${list }" >
      <c:set var="youno" value="${youVO.youno }" />
      <c:set var="ytitle" value="${youVO.ytitle }" />
      <c:set var="url" value="${youVO.url }" />
      <c:set var="cnt" value="${youVO.cnt }" />

      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <tr>
       <td  style='vertical-align: middle; text-align: center;'>
            <a href ="./read.do?youno=${youVO.youno}"  target="_top">
                 <strong>${url }</strong><br><br>
                 <strong>${ytitle }</strong></a> <br><br>
                 <DIV style="text-align:right;">
                  <i class="fa-solid fa-eye" >&nbsp;${cnt}</i> <br>  
                 </DIV> 
                 
                  </td>
                  
        </tr>

      </c:forEach>  

    <!-- 갤러리 Layout 종료 -->
    </tbody>
  </table>
</div>



</body>
 
</html>