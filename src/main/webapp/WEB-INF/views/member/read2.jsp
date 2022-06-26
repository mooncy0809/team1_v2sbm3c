<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>하루삼끼 | 장바구니</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">  
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>  
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 <style>
 #right:before{
     padding: 0 5px;
    color: #ccc;
    content: "a";
    };
 </style>
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
  $(function(){
 
  });
</script>
</head> 
 
<body>
<jsp:include page="../menu/top2.jsp" flush='false' />
    <div class="container">
<!--             <div class="breadcrumbs">
                <ol class="breadcrumb">
                  <li><a>마이페이지</a></li>
                  <li class="active"><a style="content:none;"href="javascript:location.reload();">회원 정보 조회 및 수정</a></li>
                </ol> -->
            </div>
            <br><br><br>
    </div> 
    <div class="container" >
    <ASIDE class="aside_right">
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span>&nbsp;
      <span class='menu_divide'><i class="fas fa-user-edit"></i></span>
      <A href="javascript:location.reload();">내 정보 변경 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span>&nbsp;
      <span class='menu_divide' ><i class="fas fa-key"></i></span> 
      <A href='./passwd_update2.do?memberno=${memberVO.memberno }'>비밀번호 변경 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span>  &nbsp;
      <span class='menu_divide'><i class="fas fa-id-badge"></i></span>
      <A href='#'>내 활동 정보 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span> &nbsp;
      <span class='menu_divide'><i class="fas fa-coins"></i></span>
      <A href='#'>적립금 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span>&nbsp; 
      <span class='menu_divide'><i class="fas fa-wallet"></i></span>
      <A href='#'>쿠폰 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span> &nbsp;
      <span class='menu_divide'><i class="fas fa-question"></i></span>
      <A href='#'>1:1문의 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span>&nbsp;
      <span class='menu_divide'><i class="fas fa-history"></i></span> 
      <A href='#'>최근본상품 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span> &nbsp;
      <span class='menu_divide'><i class="fas fa-truck"></i></span>
      <A href='#'>배송지 관리 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span>&nbsp;
      <span class='menu_divide'><i class="fas fa-shopping-bag"></i></span>
      <A href='../order_pay/list_by_memberno_search_paging.do?memberno=${memberVO.memberno }&now_page=1'>주문내역 </A>&nbsp;
      <span class='menu_divide'><i class="fas fa-grip-lines-vertical"></i></span>&nbsp;
    </ASIDE> 
    </div>
    
   
    <!-- Modal -->
    <div class="modal fade" id="modal_panel" role="dialog">
      <div class="modal-dialog">
      
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h4 class="modal-title" id='modal_title'></h4> <!-- 제목 -->
          </div>
          <div class="modal-body">
            <p id='modal_content'></p> <!-- 내용 -->
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
        
      </div>
    </div> <!-- Modal END -->
    <FORM name='frm' id='frm' method='POST' action='./update2.do' 
                onsubmit="return send();" class="form-horizontal">
      <input type='hidden' name='memberno' id='memberno' value='${memberVO.memberno }'>          
      <input type='hidden' name='id' id='id' value='${memberVO.id }'>          
    <section id="do_action">
        <div class="container">
         <div class="col-sm-6" style="max-width: 100%;width:100%; border: 1px solid #E6E4DF; background:#F0F0E9;">
                    <div class="chose_area" style="margin:0 auto;padding:30px 25px 30px 25px;border:0;">
   <ul class="user_option">
   <li style="margin:10px auto;">
         <label style="font-weight:bold;margin-left:0;">아이디<span style="color:red; font-size: 1.0em;"> (변경 불가)</span></label>&nbsp;
         <label>${memberVO.id } </label>
   </li>  
   <li style="margin:10px auto;">
         <label for="mname" style='font-weight:bold; font-size: 0.9em; margin-left:0;'>성명</label>    
          <input type='text' class="form-control" name='mname' id='mname' 
                     value='${memberVO.mname }' required="required" autofocus="autofocus" 
                     style='width: 30%;' placeholder="성명">
   </li>
   <li style="margin:10px auto;">
         <label for="mname" style='font-weight:bold; font-size: 0.9em; margin-left:0;'>전화번호</label>    
          <input type='text' class="form-control" name='tel' id='tel' 
                     value='${memberVO.tel }' required="required" style='width: 30%;' placeholder="전화번호">
   </li>
   <li style="margin:10px auto;">
         <label for="mname" style='font-weight:bold; font-size: 0.9em; margin-left:0;'>우편번호</label>    
          <input type='text' class="form-control" name='zipcode' id='zipcode' 
                     value='${memberVO.zipcode }' required="required" style='width: 30%;' placeholder="우편번호">
          <input type="button" id="btn_DaumPostcode" value="우편번호 찾기" style="margin-top:3px;" class="btn-sm btn-warning" >
   </li>
   <li style="margin:10px auto;">
         <label for="mname" style='font-weight:bold; font-size: 0.9em; margin-left:0;'>주소</label>    
          <input type='text' class="form-control" name='address1' id='address1' 
                     value='${memberVO.address1 }' required="required" style='width: 80%;' placeholder="주소">
   </li>
   <li style="margin:10px auto;">
         <label for="mname" style='font-weight:bold; font-size: 0.9em; margin-left:0;'>상세 주소</label>    
          <input type='text' class="form-control" name='address2' id='address2' 
                     value='${memberVO.address2 }' required="required" style='width: 80%;' placeholder="상세 주소">
   </li>
   </ul>
   
 <ul class="user_option">
  <li>
<!-- ------------------------------ DAUM 우편번호 API 시작 ------------------------------ -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');
    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }
    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#rzipcode').val(data.zonecode); //5자리 새우편번호 사용 ★
                $('#raddress1').val(fullAddr);  // 주소 ★
                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';
                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#raddress2').focus(); //  ★
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);
        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ------------------------------ DAUM 우편번호 API 종료 ------------------------------ -->

      </li>
    </ul>
    </div> 
    </div>
 <ul class="user_option" style="text-align:right;">
  <li>
        
        <button type="submit" class="btn-sm btn-warning" style="margin-top:10px;">저장</button>
        <button type="button" onclick="history.go(-1);" class="btn-sm btn-warning" style="margin-top:10px;">취소</button>
  </li>
  </ul>
    </div>
    </section>
    </FORM>
 
<jsp:include page="../menu/bottom2.jsp" flush='false' />
</body>
 
</html>