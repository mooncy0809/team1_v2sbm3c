<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0,
                                 maximum-scale=5.0, width=device-width" /> 
<title>관리자에게</title>

<link href="/css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

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
<jsp:include page="../menu/top.jsp" flush='false' />


 <DIV class='content_body' style="width:58%;">
 <span style="width:70%; font-size: 1.5em; font-weight: bold;">글쓰기</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <br>
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal"  enctype="multipart/form-data">
  
  <input type="hidden" name="categrpno" value="${param.categrpno }"> 
  <input type="hidden" name="memberno" id="memberno" value="${sessionScope.memberno }"> 
    <input type="hidden" name="id" id="id" value="${sessionScope.id }"> 
    <div class="form-group">
       <label class="control-label col-md-4">질문 제목</label>
       <div class="col-md-8">
         <input type='text' name='title' value='' required="required" placeholder="제목"
                    autofocus="autofocus" class="form-control" style='width: 70%;'>
       </div>
    </div>
    
    <div class="form-group">
       <label class="control-label col-md-4">질문 내용</label>
       <div class="col-md-8">
         <textarea name='content' required="required" class="form-control" placeholder="내용" rows="12" style='width: 70%;'></textarea>
      </div>        

     </div>
     
     <div class="form-group">
       <label class="control-label col-md-4">비밀번호</label>
       <div class="col-md-8">
       <input name='pwd'  type='password' required="required">
        <div class="content_body_bottom" style="padding-right: 20%;">
       <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list_search_paging.do'" class="btn btn-primary">목록</button>
      </div>
   </div>       
   </div> 

  
  </FORM>
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>