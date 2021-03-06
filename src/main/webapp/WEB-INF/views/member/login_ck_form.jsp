<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>삼대몇?</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() {
    // var contentsno = 0;
    // $('#btn_cart').on('click', function() { cart_ajax(contentsno)});
    $('#btn_login').on('click', send); 
    $('#btn_loadDefault').on('click', loadDefault);
  });
  
  function loadDefault() {
    $('#id').val('user1');
    $('#passwd').val('1234');
  }  

  function send() {
      frm_login.submit();
  }

  function enterkey() {
      if (window.event.keyCode == 13) {
          // 엔터키가 눌렸을 때
          send();
      }
  }
</script> 

</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<!-- <DIV class='title_line'>로그인</DIV> -->
<DIV class='title_line'><span style="text-align: center; width:50%; font-weight: bold;">로그인</span></DIV>
   <hr align="center" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 70%;">


<DIV class='content_body'>
  <DIV id='div_login' style='display: ; padding-left: 80px;'>
    <div style='width: 100%; margin: 0px 0px 0px 0px;'>
        <FORM name='frm_login' id='frm_login' method='post' action='./login.do' class="form-horizontal">
          <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
          <input type="hidden" name="contentsno" id="contentsno" value="contentsno">
          <input type="hidden" name="memberno" id="memberno" value="${sessionScope.memberno}">
          <%-- 로그인 후 자동으로 이동할 페이지 전달 ★ --%>
          <input type="hidden" name="return_url" value="${return_url}">
    
          <div class="form-group">
            <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
            <div class="col-md-8">
              <input type='text' class="form-control" name='id' id='id' 
                         value='${ck_id }' required="required" 
                         style='width: 40%;' placeholder="아이디" autofocus="autofocus">
              <Label>   
                <input type='checkbox' name='id_save' value='Y' 
                          ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
              </Label>                   
            </div>
       
          </div>   
       
          <div class="form-group">
            <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
            <div class="col-md-8">
              <input type='password' class="form-control" name='passwd' id='passwd' 
                        value='${ck_passwd }' required="required" style='width: 40%;' placeholder="패스워드" onkeyup="enterkey()">
              <Label>
                <input type='checkbox' name='passwd_save' value='Y' 
                          ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
              </Label>
            </div>
          </div>   
        </FORM>
    </div>
   
    <div style='text-align: center; margin: 10px auto;'>
      <button type="button" id='btn_login' class="btn btn-info">로그인</button>
      <button type='button' onclick="location.href='./create.do'" class="btn btn-info">회원가입</button>
      <button type='button' onclick="location.href='./find_id_form.do'" class="btn btn-info">아이디 찾기</button>
      <button type='button' onclick="location.href='./find_passwd.do'" class="btn btn-info">비밀번호 찾기</button>
      <button type='button' id='btn_loadDefault' class="btn btn-info">테스트 계정</button>
      <button type='button' id='btn_cancel' class="btn btn-info" onclick="location.href='../index.do'">취소</button>
      <!-- <button type='button' id='btn_cancel' class="btn btn-info" onclick="$('#div_login').hide();">취소</button> -->
    </div>
  
  </DIV>


</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>