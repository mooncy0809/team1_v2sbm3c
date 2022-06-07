<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Person world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css"></head>
<script type="text/javascript">
</script>
</head> 
<body>
<jsp:include page="../menu/top.jsp" />

<DIV class='title_line'style="width:70%;"><A href="../categrp/list.do" class='title_link'>유튜브 그룹</A> > ${categrpVO.name }</DIV>
  <fieldset>
  <DIV class='content_body' style="width:70%;">
  <ASIDE class="aside_right">&nbsp;
    <A style="color:black;" href="javascript:location.reload();"><i class="fa-solid fa-arrow-rotate-right"></i>&nbsp;새로고침</A>
  </ASIDE> 
  <DIV class='menu_line'></DIV>
  
  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>  
    <c:forEach var="youVO" items="${list }" varStatus="status">
      <c:set var="youno" value="${youVO.youno }" />
      <c:set var="ytitle" value="${youVO.ytitle }" />
      <c:set var="url" value="${youVO.url }" />
      <c:set var="cnt" value="${youVO.cnt }" />
      
     <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if> 
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <a href ="./read.do?youno=${youVO.youno}">
      <DIV style='width: 24%; 
              float: left; 
              margin: 0.5%; padding: 0.5%; background-color: #EEEFFF; text-align: center;'>
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style=' color: black; display: table-cell; vertical-align: middle; text-align: center; font-weight: bold;'> <!-- 수직 가운데 정렬 -->
                   ${url } <br>
                   ${ytitle} <br>
                   <DIV style="text-align:right;">
                   <i class="fa-solid fa-eye" >&nbsp;${cnt}</i> <br></DIV>   
                  </DIV>      
      </DIV>  
</DIV></a>
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
  </div>
</DIV>
 </fieldset>
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>