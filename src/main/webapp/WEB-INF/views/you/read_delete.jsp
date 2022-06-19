<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>book world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>
  <A href="../categrp/list.do" class='title_link'>유튜브 그룹</A> > 
  <A href="./list_by_categrpno_search_paging.do?categrpno=${param.categrpno }" class='title_link'>${categrpVO.name}</A> > 
  ${youVO.ytitle } 수정 
</DIV>

<DIV class='content_body'>

  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <div class="msg_warning">유튜브를 삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
      <input type='hidden' name='youno' id='youno' value="${youVO.youno }">
      
      <label>그룹 번호</label>: ${youVO.categrpno }  
      <label>유튜브</label>: ${youVO.ytitle}  
       
      <button type="submit" id='submit'>삭제</button>
      <button type="button" onclick="location.href='./list_by_categrpno_search_paging.do?categrpno=${youVO.categrpno}'">취소</button>
    </FORM>
  </DIV>

  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
      <col style='width: 25%;'/>
      <col style='width: 20%;'/>     
      <col style='width: 15%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">유튜브<br> 그룹 번호</TH>
      <TH class="th_bs">유튜브<br> 번호</TH>
      <TH class="th_bs">유튜브 이름</TH>
      <TH class="th_bs">URL</TH>
      <TH class="th_bs">등록일</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="youVO" items="${list}">
      <c:set var="categrpno" value="${youVO.categrpno }" />
      <c:set var="youno" value="${youVO.youno }" />
      <c:set var="ytitle" value="${youVO.ytitle }" />
      <c:set var="ytext" value="${youVO.ytext }" />
      <c:set var="rdate" value="${youVO.rdate.substring(0, 10) }" />
      <c:set var="url" value="${youVO.url }" />
      
      <TR>
        <TD class="td_bs">${categrpno }</TD> 
        <TD class="td_bs">${youno }</TD>
        <TD class="td_bs_left">${ytitle }</TD>
        <TD class="td_bs_left">${ytext }</TD>
         <TD class="td_bs_left"><a href="#">${url }</a></TD>
        <TD class="td_bs">${rdate }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?youno=${youno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?youno=${youno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>