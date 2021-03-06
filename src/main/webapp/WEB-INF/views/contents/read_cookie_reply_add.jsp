<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contentsno" value="${contentsVO.contentsno }" />
<c:set var="cateno" value="${contentsVO.cateno }" />
<c:set var="title" value="${contentsVO.title }" />        
<c:set var="memberno" value="${contentsVO.memberno }"/>
<c:set var="file1" value="${contentsVO.file1 }" />
<c:set var="file1saved" value="${contentsVO.file1saved }" />
<c:set var="thumb1" value="${contentsVO.thumb1 }" />
<c:set var="content" value="${contentsVO.content }" />
<c:set var="recom" value="${contentsVO.recom }" />
<c:set var="word" value="${contentsVO.word }" />
<c:set var="size1_label" value="${contentsVO.size1_label }" />
 
<c:set var="replycnt" value="${contentsVO.replycnt }" />

<c:set var="like_check" value="${liketo_contentsVO.like_check }" />

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Community</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  let reply_list; // 댓글 목록
  
  $(function(){
      $('#btn_recom').on("click", function() { update_recom_ajax(${contentsno}); });
    $('#btn_login').on('click', login_ajax);
    $('#btn_loadDefault').on('click', loadDefault);

    // ---------------------------------------- 댓글 관련 시작 ----------------------------------------
    var frm_reply = $('#frm_reply');
    $('#content', frm_reply).on('click', check_login);  // 댓글 작성시 로그인 여부 확인
    $('#btn_create', frm_reply).on('click', reply_create);  // 댓글 작성시 로그인 여부 확인
    $('#modal_x').on('click', reload); // 댓글 수 업데이트 하려면 read페이지 새로고침
    $('#modal_close').on('click', reload); // 댓글 수 업데이트 하려면 read페이지 새로고침

    list_by_contentsno_join(); // 댓글 목록

    $('#btn_add').on('click', list_by_contentsno_join_add);  // [더보기] 버튼
    // ---------------------------------------- 댓글 관련 종료 ----------------------------------------
    
  });

  function update_recom_ajax(contentsno) {

    // console.log('-> contentsno:' + contentsno);
    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'contentsno=' + contentsno; // 공백이 값으로 있으면 안됨.
    $.ajax(
      {
        url: '/contents/update_recom_ajax.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          // console.log('-> rdata: '+ rdata);
          var str = '';
          if (rdata.recom == 1) {
            // console.log('-> btn_recom: ' + $('#btn_recom').val());  // X
            // console.log('-> btn_recom: ' + $('#btn_recom').html());
            $('#btn_recom').html('♥('+rdata.recom+')');
            $('#span_animation').hide();
          } else {
            $('#span_animation').html("지금은 추천을 할 수 없습니다.");
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

    // $('#span_animation').css('text-align', 'center');
    $('#span_animation').html("<img src='/contents/images/ani04.gif' style='width: 8%;'>");
    $('#span_animation').show(); // 숨겨진 태그의 출력
  }

  function like_func(){

      var frm_read = $('#frm_read');
      var contentsno = $('#contentsno', frm_read).val();
      var memberno = $('#memberno', frm_read).val();
      
      $.ajax({
        url: "../liketo/like.do",
        type: "GET",
        cache: false,
        dataType: "json",
        data: 'contentsno=' +contentsno+ '&memberno=' +memberno,
        success: function(data) {

          var like_img = '';

          /*  var msg = '';
          msg += data.msg;
          alert(msg); */
          
          if(data.like_check == 0){
            like_img = "/contents/images/heart_e.png";
          } else {
            like_img = "/contents/images/heart.png";
          }

          /* $('#span_animation').hide(); */
                
          $('#like_img', frm_read).attr('src', like_img);
          $('#like_cnt').html(data.like_cnt);
          $('#like_check').html(data.like_check);
        },
        error: function(request, status, error){
          alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
      });
    }

  function loadDefault() {
    $('#id').val('user1');
    $('#passwd').val('1234');
  } 
  
  <%-- 로그인 --%>
  function login_ajax() {
    var params = "";
    params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // params += '&${ _csrf.parameterName }=${ _csrf.token }';
    // console.log(params);
    // return;
    
    $.ajax(
      {
        url: '/member/login_ajax.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          console.log('-> login cnt: ' + rdata.cnt);  // 1: 로그인 성공
          
          if (rdata.cnt == 1) {
            // 쇼핑카트에 insert 처리 Ajax 호출
            $('#div_login').hide();
            // alert('로그인 성공');
            $('#login_yn').val('YES'); // 로그인 성공 기록
            cart_ajax_post(); // 쇼핑카트에 insert 처리 Ajax 호출     
            
          } else {
            alert('로그인에 실패했습니다.<br>잠시후 다시 시도해주세요.');
            
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  }

  <%-- 쇼핑 카트에 상품 추가 --%>
  function cart_ajax(contentsno) {
    var f = $('#frm_login');
    $('#contentsno', f).val(contentsno);  // 쇼핑카트 등록시 사용할 상품 번호를 저장.
    
    console.log('-> contentsno: ' + $('#contentsno', f).val()); 
    
    // console.log('-> id:' + '${sessionScope.id}');
    if ('${sessionScope.id}' != '' || $('#login_yn').val() == 'YES') {  // 로그인이 되어 있다면
      cart_ajax_post();
    } else { // 로그인 안된 경우
      $('#div_login').show();
    }

  }

  <%-- 쇼핑카트 상품 등록 --%>
  function cart_ajax_post() {
    var f = $('#frm_login');
    var contentsno = $('#contentsno', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
    
    var params = "";
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params += 'contentsno=' + contentsno;
    params += '&${ _csrf.parameterName }=${ _csrf.token }';
    console.log('-> cart_ajax_post: ' + params);
    // return;
    
    $.ajax(
      {
        url: '/cart/create.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          console.log('-> cart_ajax_post cnt: ' + rdata.cnt);  // 1: 쇼핑카트 등록 성공
          
          if (rdata.cnt == 1) {
            var sw = confirm('선택한 상품이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?');
            if (sw == true) {
              // 쇼핑카트로 이동
              location.href='/cart/list_by_memberno.do';
            }           
          } else {
            alert('선택한 상품을 장바구니에 담지못했습니다.<br>잠시후 다시 시도해주세요.');
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  }

  // 댓글 작성시 로그인 여부 확인
  function check_login() {
    var frm_reply = $('#frm_reply');
    if ($('#memberno', frm_reply).val().length == 0 ) {
      $('#modal_title').html('댓글 등록'); // 제목 
      $('#modal_content').html("로그인해야 등록 할 수 있습니다."); // 내용
      $('#modal_panel').modal();            // 다이얼로그 출력
      return false;  // 실행 종료
    }
  }

  // 댓글 등록
  function reply_create() {
    var frm_reply = $('#frm_reply');
    
    if (check_login() !=false) { // 로그인 한 경우만 처리
      var params = frm_reply.serialize(); // 직렬화: 키=값&키=값&...
      // alert(params);
      // return;

      // 자바스크립트: 영숫자, 한글, 공백, 특수문자: 글자수 1로 인식
      // 오라클: 한글 1자가 3바이트임으로 300자로 제한
      // alert('내용 길이: ' + $('#content', frm_reply).val().length);
      // return;
      
      if ($('#content', frm_reply).val().length > 300) {
        $('#modal_title').html('댓글 등록'); // 제목 
        $('#modal_content').html("댓글 내용은 300자이상 입력 할 수 없습니다."); // 내용
        $('#modal_panel').modal();           // 다이얼로그 출력
        return;  // 실행 종료
      }

      $.ajax({
        url: "../reply/create.do", // action 대상 주소
        type: "post",          // get, post
        cache: false,          // 브러우저의 캐시영역 사용안함.
        async: true,           // true: 비동기
        dataType: "json",   // 응답 형식: json, xml, html...
        data: params,        // 서버로 전달하는 데이터
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          var msg = ""; // 메시지 출력
          var tag = ""; // 글목록 생성 태그
          
          if (rdata.cnt > 0) {
            $('#modal_content').attr('class', 'alert alert-success'); // CSS 변경
            msg = "댓글을 등록했습니다.";
            $('#content', frm_reply).val('');
            $('#passwd', frm_reply).val('');

            // list_by_contentsno_join(); // 댓글 목록을 새로 읽어옴
            
            $('#reply_list').html(''); // 댓글 목록 패널 초기화, val(''): 안됨
            $("#reply_list").attr("data-replypage", 1);  // 댓글이 새로 등록됨으로 1로 초기화
            
            // list_by_contentsno_join_add(); // 페이징 댓글, 페이징 문제 있음.
            // alert('댓글 목록 읽기 시작');
            // global_rdata = new Array(); // 댓글을 새로 등록했음으로 배열 초기화
            // global_rdata_cnt = 0; // 목록 출력 글수
            
            list_by_contentsno_join(); // 페이징 댓글
          } else {
            $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
            msg = "댓글 등록에 실패했습니다.";
          }
          
          $('#modal_title').html('댓글 등록'); // 제목 
          $('#modal_content').html(msg);     // 내용
          $('#modal_panel').modal();           // 다이얼로그 출력
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      });
    }
  }

  // contentsno 별 소속된 댓글 목록, 2건만 출력
  function list_by_contentsno_join() {
    var params = 'contentsno=' + ${contentsVO.contentsno };

    $.ajax({
      url: "../reply/list_by_contentsno_join.do", // action 대상 주소
      type: "get",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = '';
        
        $('#reply_list').html(''); // 패널 초기화, val(''): 안됨

        // -------------------- 전역 변수에 댓글 목록 추가 --------------------
        reply_list = rdata.list;
        // -------------------- 전역 변수에 댓글 목록 추가 --------------------
        // alert('rdata.list.length: ' + rdata.list.length);
        
        var last_index=1; 
        if (rdata.list.length >= 2 ) { // 글이 2건 이상이라면 2건만 출력
          last_index = 2
        }

        for (i=0; i < last_index; i++) {
          // alert('i: ' + i); 
          
          var row = rdata.list[i];
          
          msg += "<DIV id='"+row.replyno+"' style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
          msg += "<span style='font-weight: bold;'>" + row.id + "</span>";
          msg += "  " + row.rdate;
          
          if ('${sessionScope.memberno}' == row.memberno) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
            msg += " <A href='javascript:reply_delete("+row.replyno+")'><IMG src='/contents/images/delete.png'></A>";
          }
          msg += "  " + "<br>";
          msg += row.content;
          msg += "</DIV>";
        }
        // alert(msg);
        $('#reply_list').append(msg);
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });
    
  }
  
  // 댓글 삭제 레이어 출력
  function reply_delete(replyno) {
    // alert('replyno: ' + replyno);
    var frm_reply_delete = $('#frm_reply_delete');
    $('#replyno', frm_reply_delete).val(replyno); // 삭제할 댓글 번호 저장
    $('#modal_panel_delete').modal();             // 삭제폼 다이얼로그 출력
  }

  // 댓글 삭제 처리
  function reply_delete_proc(replyno) {
    // alert('replyno: ' + replyno);
    var params = $('#frm_reply_delete').serialize();
    $.ajax({
      url: "../reply/delete.do", // action 대상 주소
      type: "post",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";
        
        if (rdata.passwd_cnt ==1) { // 패스워드 일치
          if (rdata.delete_cnt == 1) { // 삭제 성공

            $('#btn_frm_reply_delete_close').trigger("click"); // 삭제폼 닫기, click 발생 
            
            $('#' + replyno).remove(); // 태그 삭제
              
            return; // 함수 실행 종료
          } else {  // 삭제 실패
            msg = "패스 워드는 일치하나 댓글 삭제에 실패했습니다. <br>";
            msg += " 다시한번 시도해주세요."
          }
        } else { // 패스워드 일치하지 않음.
          // alert('패스워드 불일치');
          // return;
          
          msg = "패스워드가 일치하지 않습니다.";
          $('#modal_panel_delete_msg').html(msg);

          $('#passwd', '#frm_reply_delete').focus();  // frm_reply_delete 폼의 passwd 태그로 focus 설정
          
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });
  }

  // // [더보기] 버튼 처리
  function list_by_contentsno_join_add() {
    // alert('list_by_contentsno_join_add called');
    
    let cnt_per_page = 2; // 2건씩 추가
    let replyPage=parseInt($("#reply_list").attr("data-replyPage"))+cnt_per_page; // 2
    $("#reply_list").attr("data-replyPage", replyPage); // 2
    
    var last_index=replyPage + 2; // 4
    // alert('replyPage: ' + replyPage);
    
    var msg = '';
    for (i=replyPage; i < last_index; i++) {
      var row = reply_list[i];
      
      msg = "<DIV id='"+row.replyno+"' style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
      msg += "<span style='font-weight: bold;'>" + row.id + "</span>";
      msg += "  " + row.rdate;
      
      if ('${sessionScope.memberno}' == row.memberno) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
        msg += " <A href='javascript:reply_delete("+row.replyno+")'><IMG src='/contents/images/delete.png'></A>";
      }
      msg += "  " + "<br>";
      msg += row.content;
      msg += "</DIV>";

      // alert('msg: ' + msg);
      $('#reply_list').append(msg);
    }    
  }


  function reload() {
      location.reload();
  }

  function btn(sample){  
      alert(sample); 
      document.location.href="/member/login.do";
   }  
  
  // -------------------- 댓글 관련 종료 --------------------
  
</script>

<style type="text/css">

.lb-wrap {
  width: 100%;
  margin: 10px auto;
/*   border: 1px solid #000000; */
  position: relative;
}
.lb-wrap img {
  width: 100%;
  vertical-align: middle;
}
.lb-text {
/*   padding: 10px 20px; */
/*   border-radius: 10px; */
/*   background-color: #FFEEBC; */
  text-align: center;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

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

<!-- Modal 알림창 시작 -->
<div class="modal fade" id="modal_panel" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
      </div>
      <div class="modal-body">
        <p id='modal_content'></p>  <!-- 내용 -->
      </div>
      <div class="modal-footer">
        <button type="button" id="modal_close" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div> <!-- Modal 알림창 종료 -->

<!-- -------------------- 댓글 삭제폼 시작 -------------------- -->
<div class="modal fade" id="modal_panel_delete" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" id="modal_x" class="close" data-dismiss="modal">×</button>
        <h4 class="modal-title">댓글 삭제</h4><!-- 제목 -->
      </div>
      <div class="modal-body">
        <form name='frm_reply_delete' id='frm_reply_delete'>
          <input type='hidden' name='replyno' id='replyno' value=''>
          
          <label>패스워드</label>
          <input type='password' name='passwd' id='passwd' class='form-control'>
          <DIV id='modal_panel_delete_msg' style='color: #AA0000; font-size: 1.1em;'></DIV>
        </form>
      </div>
      <div class="modal-footer">
        <button type='button' class='btn btn-danger' 
                     onclick="reply_delete_proc(frm_reply_delete.replyno.value); frm_reply_delete.passwd.value='';">삭제</button>

        <button type="button" class="btn btn-default" data-dismiss="modal" 
                     id='btn_frm_reply_delete_close'>Close</button>
      </div>
    </div>
  </div>
</div>
<!-- -------------------- 댓글 삭제폼 종료 -------------------- -->
   
<DIV class='content_body' style="width:70%;">

    <span style="width:70%; font-size: 1.5em; font-weight: bold;">
        <A href="#" onclick="history.go(-1);">${cateVO.name }</A>
    </span>    
    
    <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">

    <DIV>제목: ${title}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${contentsVO.rdate }</DIV>

  <DIV style="text-align: right;">
<%--     <A href="./create.do?cateno=${cateVO.cateno }">등록</A>
    <span class='menu_divide' >│</span> --%>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./update_text.do?contentsno=${contentsno}&now_page=${now_page}&word=${param.word }">수정</A>
    <span class='menu_divide' >│</span>
    <A href="./update_file.do?contentsno=${contentsno}&now_page=${now_page}&word=${param.word }">파일 수정</A>  
    <span class='menu_divide' >│</span>
    <A href="./delete.do?contentsno=${contentsno}&now_page=${now_page}&cateno=${cateno}&word=${param.word }">삭제</A>  
    
    <br>
    <div style='float : right; text-align:center;'>
    <div style='width:70px; height:70px; float : right;'>
    
    <form name='frm_read' id='frm_read' method="get" action="../liketo/like.do">
      
    <input type='hidden' name='contentsno' id='contentsno' value='${param.contentsno}'>
    <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
    
    <div class="lb-wrap">
    <div class="lb-text"> <h5 style='color:white'><span id='like_cnt'>${recom }</span></h5> </div>
    <div class="lb-image">
       <c:choose>
          <%-- <c:when test="${memberno ne null }" > --%>
          <c:when test="${sessionScope.id ne null}">       
          
              <c:if test="${like_check != 1}">
	              <a href='javascript: like_func();'>
	                <img style='width:100%;' src='/contents/images/heart_e.png' id='like_img'>
	              </a>
              </c:if>
              <c:if test="${like_check == 1}">
	              <a href='javascript: like_func();'>
	                <img style='width:100%;' src='/contents/images/heart.png' id='like_img'>
	              </a>
              </c:if>
          </c:when>

          <c:otherwise>
              <a href='javascript: btn("로그인 후 이용해주세요.");'>
                <img style='width:100%;' src='/contents/images/heart_e.png'>
              </a>
          </c:otherwise>
        </c:choose>
        </div>
    </div>
    
    </form>    
    
    </div>
    
    <h5>Like</h5>  
    
    </div>
    
    
    <br><br><br>
    
    </DIV>
    <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">

  
  <br>
  
  <DIV class='menu_line'></DIV>
  
  <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
  <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
  <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
    <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
    <input type="hidden" name="contentsno" id="contentsno" value="contentsno">
    <input type="hidden" name="login_yn" id="login_yn" value="NO">
          
    <div class="form-group">
      <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
      <div class="col-md-8">
        <input type='text' class="form-control" name='id' id='id' 
                   value='${ck_id }' required="required" 
                   style='width: 30%;' placeholder="아이디" autofocus="autofocus">
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
                  value='${ck_passwd }' required="required" style='width: 30%;' placeholder="패스워드">
        <Label>
          <input type='checkbox' name='passwd_save' value='Y' 
                    ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
        </Label>
      </div>
    </div>   
 
    <div class="form-group">
      <div class="col-md-offset-4 col-md-8">
        <button type="button" id='btn_login' class="btn btn-primary btn-md">로그인</button>
        <button type='button' onclick="location.href='./create.do'" class="btn btn-primary btn-md">회원가입</button>
        <button type='button' id='btn_loadDefault' class="btn btn-primary btn-md">테스트 계정</button>
        <button type='button' id='btn_cancel' class="btn btn-primary btn-md"
                    onclick="$('#div_login').hide();">취소</button>
      </div>
    </div>   
    
  </FORM>
  </DIV>
  <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <c:set var="file1saved" value="${file1saved.toLowerCase() }" />
        <DIV style="width: 50%; float: left; margin-right: 10px; margin-left:210px">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/contents/storage/ --%>
                <IMG src="/contents/storage/${file1saved }" style="width: 100%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/contents/images/none1.png" style="width: 100%;"> 
              </c:otherwise>
            </c:choose>
        </DIV>
       </li>
      </ul>
            
      <br>
                
  </fieldset>
     
    <br> <br> 
       
    <DIV style='word-wrap: break-word;'>${content }</DIV>

    <br><br>
    
    <div style='text-align:left; margin-top:100px;'>
    <ul style='padding-left:0px;'>
      <li class="li_none">
        <DIV style='text-decoration: none;'>
          검색어(키워드): ${word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/contents/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1_label})  
          </c:if>
        </DIV>
      </li> 
      
      </ul>
      </div>

</DIV>

<!-- ------------------------------ 댓글 영역 시작 ------------------------------ -->
<DIV style='width: 70%; margin: 0px auto;'>
    <HR>
    
    <FORM name='frm_reply' id='frm_reply'> <%-- 댓글 등록 폼 --%>
        <input type='hidden' name='contentsno' id='contentsno' value='${contentsno}'>
        <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
        
         <div style="width:70%; font-size: 1.2em; font-weight: bold;">댓글수 ${replycnt }</div>
        
        <textarea name='content' id='content' style='width: 100%; height: 60px;' placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea>
        <input type='password' name='passwd' id='passwd' placeholder="비밀번호">
        <button type='button' id='btn_create'>등록</button>
    </FORM>
    <HR>
    <DIV id='reply_list' data-replyPage='0'>  <%-- 댓글 목록 --%>
    
    </DIV>
    <DIV id='reply_list_btn' style='border: solid 1px #EEEEEE; margin: 0px auto; width: 100%; background-color: #EEFFFF;'>
        <button id='btn_add' style='width: 100%;'>더보기 ▽</button>
    </DIV>  
  
</DIV>

<!-- ------------------------------ 댓글 영역 종료 ------------------------------  -->
  
   
    
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>