<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="qnano" value="${qnaVO.qnano }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>관리자에게</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 <link href="/css/bootstrap.min.css" rel="stylesheet"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
$(function(){
});
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
<DIV class='content_body' style="width: 70%;">
<span style="width:70%; font-size: 1.5em; font-weight: bold;">관리자에게</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">

<FORM name='frm' method='GET' action='./passwd_check.do' class="form-horizontal">
<input type="hidden" name="qnano" value="${qnano }">
   <div class="form-group">
       <label class="control-label col-md-4">비밀번호를 입력하세요.</label>
       <div class="col-md-8">
       <input name='pwd' type='password'/></input>

       <button type="submit" onclick="./read.do?qnano=${QnaVO.qnano}" class="btn btn-primary">등록</button>

   </div>       
   </div> 
   </FORM>



</DIV>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
</html>