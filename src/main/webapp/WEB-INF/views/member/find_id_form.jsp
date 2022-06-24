<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>아이디 찾기</title>

</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

    <div class="w3-content w3-container w3-margin-top">
        <div class="w3-container w3-card-4">
            <form action="./find_id.do" method="post">
                <div class="w3-center w3-large w3-margin-top">
                    <h3>아이디 찾기</h3>
                </div>
                <div>
                    <p>
                        <label>이름</label>
                        <input class="w3-input" type="text" id="mname" name="mname" required>
                    </p>
                    
                    <p>
                        <label>휴대폰 번호</label>
                        <input class="w3-input" type="text" id="tel" name="tel" required>
                    </p>
                    <p class="w3-center">
                        <button type="submit" id=findBtn   class="btn btn-info">찾기</button>
                        <button type="button" onclick="history.go(-1);" class="btn btn-info">취소</button>
                    </p>
                </div>
            </form>
        </div>
    </div>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>