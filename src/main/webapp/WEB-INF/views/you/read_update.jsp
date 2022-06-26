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
 
<DIV class='title_line'style="width:70%;">
  <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="./list_by_categrpno_search_paging.do?categrpno=${youVO.categrpno }" class='title_link'>${categrpVO.name }</A> > 
  ${youVO.ytitle } 수정 
</DIV>

<DIV class='content_body'style="width:70%;">
  <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
    <input type="hidden" name="youno" value="${param.youno }">

      <input type='hidden' name='categrpno' value='${youVO.categrpno }' 
                 required="required" min="1" max="100" step="1" autofocus="autofocus">

    <div class="form-group">
        
       <label class="control-label col-md-3">유튜브 제목</label>
       <div class="col-md-9">
         <input type='text' name='ytitle' value='${youVO.ytitle }' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 70%;'>
       </div>
     </div>
    <div class="form-group">
       <label class="control-label col-md-3">URL</label>
       <div class="col-md-9">
         <input type='text' name='url' value='${youVO.url }'' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 70%;'>  
                   <%-- (유튜브 그룹번호: ${param.ytgrpno })    --%> 
       </div>
     </div>
     
    <div class="form-group">
       <label class="control-label col-md-3">유튜브 내용</label>
       <div class="col-md-9">
         <textarea name='ytext' required="required" class="form-control" rows="12" style='width: 70%;'>${youVO.ytext }</textarea>
      <div class="content_body_bottom" style="text-align:right; width:70%;">
      <button type="submit" class="btn btn-primary">수정</button>
      <button type="button" onclick="location.href='./list_by_categrpno_search_paging.do?categrpno=4'" class="btn btn-primary">목록</button>
      </div>
      </div>        

     </div>

  
  </FORM>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>