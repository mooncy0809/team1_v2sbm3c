<%@ page contentType="text/html; charset=UTF-8" %>
 
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    
<script type="text/javascript">
var msg = "${msg}";

if (msg != "") {
    alert(msg);
}
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

 <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-2">비밀번호 찾기</h1>
                                        <p class="mb-4">이름과 아이디를 입력해주세요!</p>
                                    </div>
                                    <form class="user" action="./find_passwd.do" method="post">
                                       <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                id="mname" name="mname"
                                                placeholder="이름">
                                        </div>
                                        <div class="form-group">
                                            <input type="email" class="form-control form-control-user"
                                                id="id" name="id"
                                                placeholder="아이디">
                                        </div>
                                         
                                        <button type="submit" class="btn btn-primary btn-user btn-block">
                                            찾기
                                        </button>
                                    </form>
                                    <hr>
                                     <a href="/member/login.do" class="btn btn-google btn-user btn-block">
                                           로그인
                                        </a>
                                        <hr>
                                       <div class="text-center">
                                        <a class="btn btn-google btn-user btn-block" href="../index.do">메인페이지</a>
                                    </div>
</div>
<jsp:include page="../menu/bottom.jsp" flush='false' />
 
</body>
</html>