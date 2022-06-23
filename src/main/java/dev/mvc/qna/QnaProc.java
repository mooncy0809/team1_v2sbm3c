package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.contents.Contents;
import dev.mvc.contents.ContentsVO;
import dev.mvc.tool.Tool;
import dev.mvc.you.Ytext;



@Component("dev.mvc.qna.QnaProc")
public class QnaProc implements QnaProcInter{
    
    @Autowired
    private QnaDAOInter qnaDAO;

    public QnaProc() {
    }

    @Override
    public int create(QnaVO qnaVO) {
        int cnt = this.qnaDAO.create(qnaVO);
        return cnt;
    }

    @Override
    public List<QnaVO> list_all() {
        List<QnaVO> list = this.qnaDAO.list_all();
        return list;
    }

    @Override
    public QnaVO read(int qnano) {
        QnaVO qnaVO = this.qnaDAO.read(qnano);
        return qnaVO;
    }

    @Override
    public int update(QnaVO qnaVO) {
        int cnt = this.qnaDAO.update(qnaVO);
        return cnt;
    }

    @Override
    public int delete(int qnano) {
        int cnt = this.qnaDAO.delete(qnano);
        return cnt;
    }

    @Override
    public int input_pwd(QnaVO qnaVO) {
        int cnt = this.qnaDAO.input_pwd(qnaVO);
        return cnt;
    }
    
    @Override
    public int passwd_check(HashMap<String, Object> map) {
        int cnt = this.qnaDAO.passwd_check(map);
        return cnt;
    }
    
    @Override
    public int search_count(HashMap<String, Object> hashMap) {
      int count = qnaDAO.search_count(hashMap);
      return count;
    }
    
//    @Override
//    public int search_count2(HashMap<String, Object> hashMap) {
//      int count = qnaDAO.search_count2(hashMap);
//      return count;
//    }

    @Override
    public List<QnaVO> list_search_paging(HashMap<String, Object> map) {

        int begin_of_page = ((Integer)map.get("now_page") - 1) * Qtext.RECORD_PER_PAGE;
        int start_num = begin_of_page + 1;
        int end_num = begin_of_page + Qtext.RECORD_PER_PAGE;   

        map.put("start_num", start_num);
        map.put("end_num", end_num);
       
        List<QnaVO> list = this.qnaDAO.list_search_paging(map);
        
        for (QnaVO qnaVO : list) { // 내용이 160자 이상이면 160자만 선택
          String content= qnaVO.getContent();
          if (content.length() > 160) {
            content = content.substring(0, 160) + "...";
            qnaVO.setContent(content);
          }
          String title = Tool.convertChar(qnaVO.getTitle());  // 특수 문자 변환
          qnaVO.setTitle(title);
          
          content = Tool.convertChar(content);
          qnaVO.setContent(content);
        }
        
        return list;
    }
    
    /** 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param list_file 목록 파일명 
     * @param categrpno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param now_page     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     *  회원 목록 페이징 기법 ( 회원 화면 기준)
     */ 
    @Override
    public String pagingBox(int categrpno, int search_count, int now_page, String word){ 
      int total_page = (int)(Math.ceil((double)search_count/Qtext.RECORD_PER_PAGE)); // 전체 페이지 수 
      int total_grp = (int)(Math.ceil((double)total_page/Qtext.PAGE_PER_BLOCK)); // 전체 그룹  수
      int now_grp = (int)(Math.ceil((double)now_page/Qtext.PAGE_PER_BLOCK));  // 현재 그룹 번호
      
      // 1 group: 1, 2, 3 ... 9, 10
      // 2 group: 11, 12 ... 19, 20
      // 3 group: 21, 22 ... 29, 30
      int start_page = ((now_grp - 1) * Qtext.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작  페이지  
      int end_page = (now_grp * Qtext.PAGE_PER_BLOCK);               // 특정 그룹의 마지막 페이지   
       
      StringBuffer str = new StringBuffer(); 
       
      str.append("<style type='text/css'>"); 
      str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
      str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
      str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
      str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
      str.append("  .span_box_1{"); 
      str.append("    text-align: center;");    
      str.append("    font-size: 1em;"); 
      str.append("    border: 1px;"); 
      str.append("    border-style: solid;"); 
      str.append("    border-color: #cccccc;"); 
      str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("  }"); 
      str.append("  .span_box_2{"); 
      str.append("    text-align: center;");    
      str.append("    background-color:  #FF8B6E;"); 
      str.append("    color: #FFFFFF;"); 
      str.append("    font-size: 1em;"); 
      str.append("    border: 1px;"); 
      str.append("    border-style: solid;"); 
      str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("  }"); 
      str.append("</style>"); 
      str.append("<DIV id='paging'>"); 
//      str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
   
      // 이전 10개 페이지로 이동
      // now_grp: 1 (1 ~ 10 page)
      // now_grp: 2 (11 ~ 20 page)
      // now_grp: 3 (21 ~ 30 page) 
      // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
      // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
      int _now_page = (now_grp - 1) * Qtext.PAGE_PER_BLOCK;  
      if (now_grp >= 2){ // 현재 그룹번호가 2이상이면 페이지수가 11페이 이상임으로 이전 그룹으로 갈수 있는 링크 생성 
        str.append("<span class='span_box_1'><A href='"+Qtext.LIST_FILE+"?&word="+word+"&now_page="+_now_page+"&categrpno="+categrpno+"'>이전</A></span>"); 
      } 
   
      // 중앙의 페이지 목록
      for(int i=start_page; i<=end_page; i++){ 
        if (i > total_page){ // 마지막 페이지를 넘어갔다면 페이 출력 종료
          break; 
        } 
    
        if (now_page == i){ // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
          str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
        }else{
          // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
          str.append("<span class='span_box_1'><A href='"+Qtext.LIST_FILE+"?word="+word+"&now_page="+i+"&categrpno="+categrpno+"'>"+i+"</A></span>");   
        } 
      } 
   
      // 10개 다음 페이지로 이동
      // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
      // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
      // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
      // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
      _now_page = (now_grp * Contents.PAGE_PER_BLOCK)+1; //  최대 페이지수 + 1 
      if (now_grp < total_grp){ 
        str.append("<span class='span_box_1'><A href='"+Qtext.LIST_FILE+"?&word="+word+"&now_page="+_now_page+"&categrpno="+categrpno+"'>다음</A></span>"); 
      } 
      str.append("</DIV>"); 
       
      return str.toString(); 
    }
    

}
