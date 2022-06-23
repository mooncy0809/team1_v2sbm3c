<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="fsize" value="${dictVO.fsize }" />
<c:set var="categrpno" value="${dictVO.categrpno }" />
<c:set var="fname" value="${dictVO.fname }" />        
<c:set var="bclass" value="${dictVO.bclass }" /> 
<c:set var="sclass" value="${dictVO.sclass }" /> 
<c:set var="kcal" value="${dictVO.kcal }" /> 
<c:set var="carbo" value="${dictVO.carbo }" /> 
<c:set var="protein" value="${dictVO.protein }" /> 
<c:set var="fat" value="${dictVO.fat }" /> 
<c:set var="sugar" value="${dictVO.sugar }" /> 
<c:set var="sodium" value="${dictVO.sodium }" /> 
<c:set var="cnt" value="${dictVO.cnt }" /> 
<c:set var="sum" value="${dictVO.carbo+dictVO.protein+dictVO.fat+dictVO.sugar+(dictVO.sodium/1000) }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Calorie Dictionary</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
  $(function(){
 
  });
</script>
 <style>
 table.caltable {
  width:100%;
  border-collapse: separate;
  border-spacing: 0;
  text-align: left;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-left: 1px solid #ccc;
}
table.caltable th {
  width:30%;
  padding: 8px;
  font-weight: bold;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #fff;
  border-left: 1px solid #fff;
  background: rgb(255, 220, 211);
}
table.caltable td {
  width:70%;
  padding: 8px;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}

.boxchart {
 border: 1px solid #ccc;
 padding: 25px 0; 
}

.clfix {
 position: relative;
 width: 684px;
 height: 40px;
 margin: 0 auto;
}

.blue2 {
    padding-left:20px;
    line-height: 16px;
    margin-left: 15px;
    background: url('/images/dictionary/ico_blue.gif') no-repeat; 
    }
.green2 {
    padding-left:20px;
    line-height: 16px;
    margin-left: 15px;
    background: url("/images/dictionary/ico_green.gif") no-repeat; 
    }
.orange2 {
    padding-left:20px;
    line-height: 16px;
    margin-left: 15px;
    background: url("/images/dictionary/ico_org.gif") no-repeat;  
    }
.yellow2 {
    padding-left:20px;
    line-height: 16px;
    margin-left: 15px;
    background: url("/images/dictionary/ico_yellow.gif") no-repeat; 
    }
.purple2 {
    padding-left:20px;
    line-height: 16px;
    margin-left: 15px;
    background: url("/images/dictionary/ico_purple.gif")  no-repeat; 
    }

.blue {
    float:left;
    height:35px;
    background: url('/images/dictionary/bg_calorie_blue.gif') repeat-x left 1px; 
    }
.green {
    float:left;
    height:35px;
    background: url("/images/dictionary/bg_calorie_green.gif")  repeat-x left 1px; 
    }
.orange {
    float:left;
    height:35px;
    background: url("/images/dictionary/bg_calorie_orange.gif")  repeat-x left 1px; 
    }
.yellow {
    float:left;
    height:35px;
    background: url("/images/dictionary/bg_calorie_yellow.gif")  repeat-x left 1px; 
    }
.purple {
    float:left;
    height:35px;
    background: url("/images/dictionary/bg_calorie_purple.gif")  repeat-x left 1px; 
    }

 </style>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 


<DIV class='content_body' style="width:58%;">
<fieldset class="fieldset_basic">
    <DIV class='title_line'>
    <span style="width:70%; font-size: 1.2em; font-weight: bold;">
    <a href="../../dict/list_by_categrpno_search_paging.do?categrpno=5&word=">칼로리 사전</a>
    </span>
    <c:choose>
    <c:when test="${sessionScope.grade < 10}"> <%-- 로그인 한 경우 --%>
    <span style="width:70%; font-size: 1.2em; font-weight: bold;">
    <a href="../../dict/list_by_categrpno_search_paging.do?categrpno=5&word=">칼로리 사전</a> 
    </span>
    </c:when>
    </c:choose>
   </DIV>
    <DIV style="text-align: right; clear: both;">
    <form name='frm' id='frm' method='get' action='./list_by_categrpno_search_paging.do'>
      <input type='hidden' name='categrpno' value='${categrpVO.categrpno }'>
      <input type='hidden' name='now_page' value='1'> <%-- 최초 검색시 시작 페이지 지정 --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit' class="btn btn-primary">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class="btn btn-primary"
                     onclick="location.href='./list_by_categrpno_search_paging.do?categrpno=${categrpVO.categrpno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
   <br>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <span style="width:50%; font-size: 1.5em; "><strong style="color:#FF8B6E;">${fname }</strong> 검색 결과</span>
   <DIV style="padding-top: 8px;'">
     <TABLE class='caltable' style="border-top: 1px solid #444444;">
      <TR><TH>음식 대분류</TH><TD class="td_bs">${bclass } </TD></TR>
      <TR><TH>음식 상세분류</TH><TD class="td_bs">${sclass } </TD></TR>
      <TR><TH>음식명</TH><TD class="td_bs">${fname } </TD></TR>
      <TR><TH>1회 제공량(g)</TH><TD class="td_bs">${fsize } g</TD></TR>
      <TR><TH>칼로리(kcal)</TH><TD class="td_bs">${kcal } kcal</TD></TR>
  </TABLE>
   </DIV> 
   <p style="padding-top: 8px;'"><strong style="color:#FF8B6E;">[주의] </strong>음식 칼로리는 사용되는 재료와 1인 분량 기준의 차이에 의해 다소 차이가 있을 수 있습니다.</p>
   
   <br>
   <span style="width:50%; font-size: 1.5em; font-weight:bold;">영양소 구성</span>
   <DIV class="boxchart">
        <DIV class="clfix">
            <span class="blue" style="width:${100/sum*carbo}%;"></span>
            <span class="green" style="width:${100/sum*protein}%;"></span>
            <span class="orange" style="width:${100/sum*fat}%;"></span>
            <span class="yellow" style="width:${100/sum*sugar}%;"></span>
            <span class="purple" style="width:${100/sum*(sodium/1000)}%;"></span>
        </DIV>
        <p align="center" style="margin-top: 15px;">
            <strong class="blue2">탄수화물</strong>
            <span>${carbo } g</span>
            <strong class="green2">단백질</strong>
            <span>${protein } g</span>
            <strong class="orange2">지방</strong>
            <span>${fat } g</span>
            <strong class="yellow2">당류</strong>
            <span>${sugar } g</span>
            <strong class="purple2">나트륨</strong>
            <span>${sodium } mg</span>
        </p>
   </DIV>

</fieldset>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

