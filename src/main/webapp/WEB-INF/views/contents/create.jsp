<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>게시글 등록</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet"> 

    
<script type="text/javascript">
  $(function(){
 
  });

  function check_submit()
  {

   if(frm.cateno.value == ""){
	 alert("카테고리를 선택해주세요.");
	 frm.cateno.focus();
     return false;
   }
  }
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='content_body'  style="width:70%;"> 

    <span style="width:70%; font-size: 1.5em; font-weight: bold;"> ${cateVO.name } > 글 등록</span>
    
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
  <ASIDE class="aside_right">
    <A href="./create.do?cateno=${cateVO.cateno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }">기본 목록형</A>    
    <!-- <span class='menu_divide' >│</span> -->
    <%-- <A href="./list_by_cateno_grid.do?cateno=${cateVO.cateno }">갤러리형</A> --%>
  </ASIDE> 
  
<%--     <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='post' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>

      <c:choose>
        <c:when test="${param.word != '' }"> 검색하는 경우
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> 검색하지 않는 경우
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV> --%>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='post' action='./create.do' class="form-horizontal"
             enctype="multipart/form-data" onsubmit="return check_submit();">
    <input type="hidden" name="categrpno" value="${cateVO.categrpno }"> 
    <%-- <input type="hidden" name="cateno" value="${param.cateno }"> --%>
    <%-- <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }"> --%>
    <input type="hidden" name="memberno" id="memberno" value="${sessionScope.memberno}">
    <input type="hidden" name="mname" id="mname" value="${sessionScope.mname}">
    <%-- <input type="hidden" name="adminno" value="1"> 관리자 개발후 변경 필요 --%>
    
    <%-- <c:if test="${cateVO.cateno == 4}"> --%>
    
    
    <br>
    
    <div class="form-group">
       <label class="control-label col-md-2">
        제목       
       </label>
       <div class="col-md-8">
         <input type='text' name='title' placeholder='제목' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 100%;'>
       </div>
       <div class="col-md-2">
       <select name="cateno" style="width:160px; background-color:#FFDCD3;">
            <option value="" selected>=== 게시판 선택 ===</option>
            <option value=4 <c:if test="${cateVO.cateno eq 4}">selected="selected"</c:if>>자유게시판</option>
            <option value=5 <c:if test="${cateVO.cateno eq 5}">selected="selected"</c:if>>팁/노하우</option>
            <option value=6 <c:if test="${cateVO.cateno eq 6}">selected="selected"</c:if>>고민</option>
            <option value=7 <c:if test="${cateVO.cateno eq 7}">selected="selected"</c:if>>일기</option>
       </select>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">내용</label>
       <div class="col-md-10">
         <textarea name='content' required="required" class="form-control" placeholder='내용' rows="12" style='width: 100%;'></textarea>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">검색어</label>
       <div class="col-md-10">
         <input type='text' name='word' value='' placeholder='검색어' required="required" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>   
    <div class="form-group">
       <label class="control-label col-md-2">이미지</label>
       <div class="col-md-10">
         <input type='file' class="form-control" name='file1MF' id='file1MF' 
                    value='' placeholder="파일 선택">
       </div>
    </div>   
    <div class="form-group">
       <label class="control-label col-md-2">패스워드</label>
       <div class="col-md-10">
         <input type='password' name='passwd' value='' placeholder='패스워드'required="required" 
                    class="form-control" style='width: 50%;'>
       </div>
    </div>   
    <div class="content_body_bottom" style="text-align:right;">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="history.go(-1);" class="btn btn-primary">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>