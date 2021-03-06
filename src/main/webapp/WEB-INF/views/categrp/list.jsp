<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="dev.mvc.categrp.CategrpVO" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>삼대몇 | 카테고리 관리</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css">

 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 

<DIV class='content_body' style="width:70%;">
<span style="width:70%; font-size: 1.5em; font-weight: bold;">카테고리 그룹</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">


  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <label>그룹 이름</label>
      <input type='text' name='name' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>순서</label>
      <input type='number' name='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>
    
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">순서</TH>
      <TH class="th_bs">이름</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">출력</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <%
    // Scriptlet
    // List<CategrpVO> list = (List<CategrpVO>)(request.getAttribute("list"));
    // for (CategrpVO categrpVO: list) {
    //    out.println(categrpVO.getName() + "<br>");
    // }
    %>
    <c:forEach var="categrpVO" items="${list}">
      <c:set var="categrpno" value="${categrpVO.categrpno }" />
      <c:set var="name" value="${categrpVO.name }" />
      <c:set var="visible" value="${categrpVO.visible }" />
      
      <TR>
        
          <c:choose>
            <c:when test="${visible == 'Y'}">
                <TD class="td_bs">${categrpVO.seqno }</TD>
                <TD class="td_bs_left"> 
                    <A href = '../cate/list_by_categrpno.do?categrpno=${categrpno}'>${name }</A>
                </TD>
                <TD class="td_bs">${categrpVO.rdate.substring(0, 10) }</TD>
                <TD class="td_bs">
              <A href="./update_visible.do?categrpno=${categrpno }&visible=${visible }"><IMG src="/categrp/images/open.png" ></A>
            </c:when>
            <c:otherwise>
                <td>N인데 왜 출력해 왜왜왜</td>
            </c:otherwise>
          </c:choose>
        </TD>   
        
        <TD class="td_bs">
          <A href="../cate/create.do?categrpno=${categrpno }" title="${categrpVO.name } 등록"><i class="fa-solid fa-plus"></i></A>
          <A href="./read_update.do?categrpno=${categrpno }" title="수정"><i class="fa-regular fa-pen-to-square"></i></A>
          <A href="./read_delete.do?categrpno=${categrpno }" title="삭제"><i class="fa-regular fa-trash-can"></i></A>
          <A href="./update_seqno_up.do?categrpno=${categrpno }" title="우선순위 상향"><i class="fa-solid fa-angle-up"></i></A>
          <A href="./update_seqno_down.do?categrpno=${categrpno }" title="우선순위 하향"><i class="fa-solid fa-angle-down"></i></A>              
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>