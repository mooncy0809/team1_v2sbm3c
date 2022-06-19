<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0,
                                 maximum-scale=5.0, width=device-width" /> 
<title>리뷰쓰기</title>

<link href="/css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function(){
  });
</script>

</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

 <DIV class='content_body'>
 <span style="width:70%; font-size: 1.5em; font-weight: bold;">리뷰 쓰기</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <br>
  <FORM name='frm' method='post' action='./create.do' class="form-horizontal"  enctype="multipart/form-data">
  
  <input type="hidden" name="order_itemno" value="${param.order_itemno }">
  <input type="hidden" name="memberno" id="memberno" value="${sessionScope.memberno }">
    <div class="form-group">
       <label class="control-label col-md-4">리뷰 제목</label>
       <div class="col-md-8">
         <input type='text' name='rtitle' value='' required="required" placeholder="제목"
                    autofocus="autofocus" class="form-control" style='width: 70%;'>
       </div>
    </div>
    
    <div class="form-group">
       <label class="control-label col-md-4">리뷰 내용</label>
       <div class="col-md-8">
         <textarea name='rcontent' required="required" class="form-control" rows="12" style='width: 70%;'></textarea>
      </div>        

     </div>
    
    <div>
        <span>별점을 선택해주세요</span>
        <input type="radio" name="score" value="5" id="rate1"><label
            for="rate1">★</label>
        <input type="radio" name="score" value="4" id="rate2"><label
            for="rate2">★</label>
        <input type="radio" name="score" value="3" id="rate3"><label
            for="rate3">★</label>
        <input type="radio" name="score" value="2" id="rate4"><label
            for="rate4">★</label>
        <input type="radio" name="score" value="1" id="rate5"><label
            for="rate5">★</label>
    </div>
     
    <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./member_join.do'" class="btn btn-primary">목록</button>
    </div>      
  
  </FORM>
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>