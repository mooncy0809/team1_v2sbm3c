<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="qnano" value="${qnaVO.qnano }" />
<c:set var="categrpno" value="${qnaVO.categrpno }" />
<c:set var="memberno" value="${qnaVO.memberno }" />
<c:set var="title" value="${qnaVO.title }" />        
<c:set var="content" value="${qnaVO.content }" /> 
<c:set var="pwd" value="${qnaVO.pwd }" />
<c:set var="rdate" value="${qnaVO.rdate }" /> 


 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>관리자에게</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function(){


    // ---------------------------------------- 댓글 관련 시작 ----------------------------------------
    var frm_qna_reply = $('#frm_qna_reply');
    $('#content', frm_qna_reply).on('click', check_login);  // 댓글 작성시 로그인 여부 확인
    $('#btn_create', frm_qna_reply).on('click', qna_reply_create);  // 댓글 작성시 로그인 여부 확인

    list_by_qnano_join(); // 댓글 목록
    // ---------------------------------------- 댓글 관련 종료 ----------------------------------------
    
  });
  // 댓글 작성시 로그인 여부 확인
  function check_login() {
    var frm_qna_reply = $('#frm_qna_reply');
    if ($('#memberno', frm_qna_reply).val().length == 0 ) {
      $('#modal_title').html('댓글 등록'); // 제목 
      $('#modal_content').html("로그인해야 등록 할 수 있습니다."); // 내용
      $('#modal_panel').modal();            // 다이얼로그 출력
      return false;  // 실행 종료
    }
  }

  // 댓글 등록
  function qna_reply_create() {
    if('${sessionScope.id}' == 'crm'){
    var frm_qna_reply = $('#frm_qna_reply');
    }
    
    if (check_login() !=false) { // 로그인 한 경우만 처리
      var params = frm_qna_reply.serialize(); // 직렬화: 키=값&키=값&...
      // alert(params);
      // return;

      // 자바스크립트: 영숫자, 한글, 공백, 특수문자: 글자수 1로 인식
      // 오라클: 한글 1자가 3바이트임으로 300자로 제한
      // alert('내용 길이: ' + $('#content', frm_qna_reply).val().length);
      // return;
      
      if ($('#content', frm_qna_reply).val().length > 300) {
        $('#modal_title').html('댓글 등록'); // 제목 
        $('#modal_content').html("댓글 내용은 300자이상 입력 할 수 없습니다."); // 내용
        $('#modal_panel').modal();           // 다이얼로그 출력
        return;  // 실행 종료
      }

      $.ajax({
        url: "../qna_reply/create.do", // action 대상 주소
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
            $('#content', frm_qna_reply).val('');
            $('#passwd', frm_qna_reply).val('');

            // list_by_contentsno_join(); // 댓글 목록을 새로 읽어옴
            
            $('#qna_reply_list').html(''); // 댓글 목록 패널 초기화, val(''): 안됨
            $("#qna_reply_list").attr("data-qna_replypage", 1);  // 댓글이 새로 등록됨으로 1로 초기화
            
            // list_by_contentsno_join_add(); // 페이징 댓글, 페이징 문제 있음.
            // alert('댓글 목록 읽기 시작');
            // global_rdata = new Array(); // 댓글을 새로 등록했음으로 배열 초기화
            // global_rdata_cnt = 0; // 목록 출력 글수
            
            list_by_qnano_join(); // 페이징 댓글
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

  // qnano 별 소속된 댓글 목록
  function list_by_qnano_join() {
    var params = 'qnano=' + ${qnaVO.qnano };

    $.ajax({
      url: "../qna_reply/list_by_qnano_join.do", // action 대상 주소
      type: "get",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = '';
        
        $('#qna_reply_list').html(''); // 패널 초기화, val(''): 안됨
        
        for (i=0; i < rdata.list.length; i++) {
          var row = rdata.list[i];
          
          msg += "<DIV id='"+row.qna_replyno+"' style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
          msg += "<span style='font-weight: bold;'>" + row.id + "</span>";
          msg += "  " + row.rdate;
          
          if ('${sessionScope.memberno}' == row.memberno) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
            msg += " <A href='javascript:qna_reply_delete("+row.qna_replyno+")'><IMG src='/contents/images/delete.png'></A>";
          }
          msg += "  " + "<br>";
          msg += row.content;
          msg += "</DIV>";
        }
        // alert(msg);
        $('#qna_reply_list').append(msg);
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });
    
  }
  
  // 댓글 삭제 레이어 출력
  function qna_reply_delete(qna_replyno) {
    // alert('qna_replyno: ' + qna_replyno);
    var frm_qna_reply_delete = $('#frm_qna_reply_delete');
    $('#qna_replyno', frm_qna_reply_delete).val(qna_replyno); // 삭제할 댓글 번호 저장
    $('#modal_panel_delete').modal();             // 삭제폼 다이얼로그 출력
  }

  // 댓글 삭제 처리
  function qna_reply_delete_proc(qna_replyno) {
    // alert('qna_replyno: ' + qna_replyno);
    var params = $('#frm_qna_reply_delete').serialize();
    $.ajax({
      url: "../qna_reply/delete.do", // action 대상 주소
      type: "post",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";

            $('#btn_frm_qna_reply_delete_close').trigger("click"); // 삭제폼 닫기, click 발생 
            
            $('#' + qna_replyno).remove(); // 태그 삭제
              
            return; // 함수 실행 종료
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });
  }
  // -------------------- 댓글 관련 종료 --------------------
  
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
 


<DIV class='content_body' style="width:70%;">
<!-- Modal 알림창 시작 -->
<div class="modal fade" id="modal_panel" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" id="modal_x" class="close" data-dismiss="modal">×</button>
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

  <!-- -------------------- 리뷰 삭제폼 시작 -------------------- -->
<div class="modal fade" id="modal_panel_delete" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
<!--       <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h4 class="modal-title">리뷰 삭제</h4>제목
      </div> -->
      <div class="modal-body">
        <form name='frm_qna_reply_delete' id='frm_qna_reply_delete'>
          <input type='hidden' name='qna_replyno' id='qna_replyno' value=${qna_replyno }>
          
           <h4>댓글을 삭제하시겠습니까?</h4>
          
          <DIV id='modal_panel_delete_msg' style='color: #AA0000; font-size: 1.1em;'></DIV>
        </form>
      </div>
      <div class="modal-footer">
        <button type='button' class='btn btn-danger' 
                     onclick="qna_reply_delete_proc(frm_qna_reply_delete.qna_replyno.value); frm_qna_reply_delete.passwd.value='';">삭제</button>

        <button type="button" class="btn btn-default" data-dismiss="modal" 
                     id='btn_frm_qna_reply_delete_close'>Close</button>
      </div>
    </div>
  </div>
</div>
<!-- -------------------- 리뷰 삭제폼 종료 -------------------- -->


  <fieldset class="fieldset_basic">
  <span style="width:50%; font-size: 1.5em; font-weight: bold;">관리자에게</span>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <DIV>제목: ${title}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${rdate }</DIV>
   <DIV style="text-align: right;">
        <button type="button" onclick="location.href='./read_update.do?qnano=${qnaVO.qnano}'"  class="btn">수정</button>
        <button type="submit"  onclick="location.href='./read_delete.do?qnano=${qnaVO.qnano}'" class="btn">삭제</button>
        </DIV>
   <hr align="left" style="border-top: 1px solid #bbb; border-bottom: 1px solid #fff; width: 100%;">
   <br>
   <DIV>${content }</DIV> 
  </fieldset>
  
  

</DIV>

<!-- ------------------------------ 댓글 영역 시작 ------------------------------ -->
<DIV style='width: 70%; margin: 0px auto;'>
    <HR>
    <FORM name='frm_qna_reply' id='frm_qna_reply'> <%-- 댓글 등록 폼 --%>
        <input type='hidden' name='qnano' id='qnano' value='${qnano}'>
        <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
        
        <textarea name='content' id='content' style='width: 100%; height: 60px;' placeholder="관리자만 등록 할 수 있습니다."></textarea>
<!--         <input type='password' name='pwd' placeholder="비밀번호"> -->
        <button type='button' id='btn_create'>등록</button>
    </FORM>
    <HR>
    <DIV id='qna_reply_list' data-qna_replypage='1'>  <%-- 댓글 목록 --%>
    
    </DIV>
    <DIV id='qna_reply_list_btn' style='border: solid 1px #EEEEEE; margin: 0px auto; width: 100%; background-color: #EEFFFF;'>
        <button id='btn_add' style='width: 100%;'>더보기 ▽</button>
    </DIV>  
  
</DIV>

<!-- ------------------------------ 댓글 영역 종료 ------------------------------  -->
  
   
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

