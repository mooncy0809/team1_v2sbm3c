<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>비밀번호 찾기</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    
<script type="text/javascript">
  $(function(){ 
    $('#btn_login').on('click', function() {  // click 이벤트와 함께 처리 함수를 동시 등록
      location.href="./login2.do";
    });
  });
</script>
 
</head> 
<body>
<jsp:include page="../menu/top2.jsp" flush='false' />
 
 
<DIV class='title_line' style='text-align:center'>알림</DIV>
  <DIV class='message'style='text-align:center'>
    <fieldset class='fieldset_basic'>
      <ul>
      
        
        <li class='li_none'>임시비밀번호가 발급되었습니다.</li>
        <li class='li_none'>메일함을 확인해주세요.</li>
        <li class='li_none'>
        
        
          <button type="button" id="btn_login" class="btn btn-primary btn-md">확인</button>
        </li>
        
      </ul>
    </fieldset>    
  </DIV>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>