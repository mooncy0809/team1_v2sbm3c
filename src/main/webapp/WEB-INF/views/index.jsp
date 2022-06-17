<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0,
                                 maximum-scale=5.0, width=device-width" /> 

<jsp:include page="./menu/top.jsp" flush='false' />

<style type="text/css">
.backimg{
    background: url('./images/home/back1.png') no-repeat;
}
.backimg2{
    background: url('./images/home/back2.png') no-repeat;
}
.backimg3{
    background: url('./images/home/back3.png') no-repeat;
}
.backimg4{
    background: url('./images/home/back4.png') no-repeat;
}
.backimg5{
    background: url('./images/home/back5.png') no-repeat;
}
</style>
</head>
<body>
  <DIV style='width: 850px; margin: 30px auto; text-align: center;'><div style="text-align: center;">
   <iframe class="backimg" src="./contents/index_contents.do?cateno=4" align="left" scrolling="no" style="border:0px; width:280px; height:300px; " ></iframe>
       <iframe class="backimg2" src="./you/index_contents2.do?categrpno=4" align="left" scrolling="no" style="border:0px; width:280px; height:300px; " ></iframe>
           <iframe class="backimg3" src="./dict/index_contents3.do?categrpno=5" align="left" scrolling="no" style="border:0px; width:280px; height:300px; " ></iframe>
       <iframe class="backimg4" src="./contents/index_contents.do?cateno=4" align="left" scrolling="no" style="border:0px; width:280px; height:300px; " ></iframe>
       <iframe class="backimg5" src="./you/index_contents2.do?categrpno=4" align="left" scrolling="no" style="border:0px; width:280px; height:300px; " ></iframe>
        <a onclick="toggleImg()" href="./member/login.do" target="_top"><IMG id="logimg" src='/images/home/back6.png'>
        </a>
        
        
  </div>
  </DIV>
    <section id="slider"><!--slider-->

    </section>
 <jsp:include page="./menu/bottom.jsp" flush='false' />
</body>

<script>
function toggleImg() {
    window.open(
    document.getElementById("logimg").src = "/images/home/back7.png";
    

  } 
 </script>

</html>