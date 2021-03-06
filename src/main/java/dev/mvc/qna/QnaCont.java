package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.qna.QnaVO;
import dev.mvc.you.YouVO;
import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
import dev.mvc.contents.Contents;
import dev.mvc.contents.ContentsVO;
import dev.mvc.member.MemberVO;

@Controller
public class QnaCont {
    @Autowired
    @Qualifier("dev.mvc.categrp.CategrpProc")
    private CategrpProcInter categrpProc;
    
    @Autowired
    @Qualifier("dev.mvc.qna.QnaProc")  
    private QnaProcInter qnaProc;
    
    public QnaCont() {
        System.out.println("-> QnaCont created.");
    }
    /**
     * 새로고침 방지
     * 
     * @return
     */
    @RequestMapping(value = "/qna/msg.do", method = RequestMethod.GET)
    public ModelAndView msg() {
        ModelAndView mav = new ModelAndView();
        return mav; // forward
    }

    /**
     * 등록폼 
     * 
     * @return
     */
    @RequestMapping(value= "/qna/create.do", method = RequestMethod.GET)
    public ModelAndView create(int categrpno, int memberno) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/qna/create");

        return mav;
    }
    
    /**
     * 등록처리
     * 
     * @return
     */
    @RequestMapping(value= "/qna/create.do", method = RequestMethod.POST)
    public ModelAndView create(HttpServletRequest request, 
            HttpServletResponse response, 
            HttpSession session,
            int memberno,
            String id,
            QnaVO qnaVO) {
        ModelAndView mav = new ModelAndView();
        
        int cnt = this.qnaProc.create(qnaVO);
        mav.addObject("qnano", qnaVO.getQnano());
        session.setAttribute("memberno", memberno);
        session.setAttribute("id", id);
        
        
        mav.addObject("code", "create_success");
        mav.addObject("cnt", cnt);
        mav.addObject("qnano", qnaVO.getQnano());
        mav.addObject("categrpno", qnaVO.getCategrpno());
        mav.addObject("title", qnaVO.getTitle());
        mav.addObject("content", qnaVO.getContent());
        mav.addObject("pwd", qnaVO.getPwd());
        mav.addObject("rdate", qnaVO.getRdate());
        mav.addObject("id", qnaVO.getId());
        
        mav.setViewName("redirect:/qna/list_search_paging.do");
        return mav;
    }
    
    @RequestMapping(value= "/qna/list.do", method = RequestMethod.GET)
    public ModelAndView list_all() {
        ModelAndView mav = new ModelAndView();
        
        List<QnaVO> list = this.qnaProc.list_all();
        mav.addObject("list", list);
        
        mav.setViewName("/qna/list");
        return mav;
    }
    
    @RequestMapping(value = "/qna/read.do", method = RequestMethod.GET)
    public ModelAndView read(int qnano) {
        ModelAndView mav = new ModelAndView();
        
        QnaVO qnaVO = this.qnaProc.read(qnano); 
        mav.addObject("qnaVO", qnaVO); // request.setAttribute("youVO", youVO);
        this.qnaProc.update_replycnt(qnaVO);
        
        CategrpVO categrpVO = this.categrpProc.read(qnaVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);
       
        mav.setViewName("/qna/read"); // /WEB-INF/views/you/read.jsp
        
        

        return mav;
    }
    
    @RequestMapping(value= "/qna/read_update.do", method = RequestMethod.GET)
    public ModelAndView read_update(int qnano) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/qna/read_update");
        
        QnaVO qnaVO = this.qnaProc.read(qnano);
        mav.addObject("qnaVO", qnaVO);
        
        int categrpno = qnaVO.getCategrpno();
        
        // 카테고리 그룹 정보
        CategrpVO categrpVO = this.categrpProc.read(categrpno);
        mav.addObject("categrpVO", categrpVO);
        
        List<QnaVO> list = this.qnaProc.list_all();
        mav.addObject("list", list);
        
        return mav;
    }
    
    /**
     * 수정 처리
     * 
     * @param qnaVO
     * @return
     */
    @RequestMapping(value = "/qna/update.do", method = RequestMethod.POST)
    public ModelAndView update(QnaVO qnaVO) {
      ModelAndView mav = new ModelAndView();

      int cnt = this.qnaProc.update(qnaVO);
      
      if (cnt == 1) {
          mav.addObject("categrpno", qnaVO.getCategrpno());
          mav.setViewName("redirect:/qna/list_search_paging.do");
      } else {
          mav.addObject("code", "update_fail"); // request에 저장
          mav.addObject("cnt", cnt); // request에 저장
          mav.addObject("qnano", qnaVO.getQnano());
          mav.addObject("categrpno", qnaVO.getCategrpno());
          mav.addObject("title", qnaVO.getTitle());
          mav.addObject("content", qnaVO.getContent());
          mav.addObject("pwd", qnaVO.getPwd());
          mav.addObject("rdate", qnaVO.getRdate());
             
      }
      
      return mav;
    }
    
   
    
    /**
     * 조회 + 삭제폼 http://localhost:9091/qna/read_delete.do
     * 
     * @return
     */

    @RequestMapping(value = "/qna/read_delete.do", method = RequestMethod.GET)
    public ModelAndView read_delete(int qnano) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/qna/read_delete");

      QnaVO qnaVO = this.qnaProc.read(qnano);
      mav.addObject("qnaVO", qnaVO);
      int categrpno = qnaVO.getCategrpno();
      
      CategrpVO categrpVO = this.categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);

      List<QnaVO> list = this.qnaProc.list_all();
      mav.addObject("list", list);
      
      

      return mav; // forward
    }
    
    /**
     * 삭제 처리
     * 
     * @param qnaVO
     * @return
     */
    @RequestMapping(value = "/qna/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(int qnano) {
      ModelAndView mav = new ModelAndView();
      // 삭제될 레코드 정보를 삭제하기전에 읽음
      QnaVO qnaVO = this.qnaProc.read(qnano); 
      
      int cnt = this.qnaProc.delete(qnano);
      
      if (cnt == 1) {
          mav.addObject("categrpno", qnaVO.getCategrpno());
          mav.setViewName("redirect:/qna/list_search_paging.do");
      } else {
          mav.addObject("code", "update_fail"); // request에 저장
          mav.addObject("cnt", cnt);
          mav.addObject("qnano", qnaVO.getQnano());
          mav.addObject("categrpno", qnaVO.getCategrpno());
          mav.addObject("title", qnaVO.getTitle());
          mav.addObject("content", qnaVO.getContent());
          mav.addObject("pwd", qnaVO.getPwd());
          mav.addObject("rdate", qnaVO.getRdate());
          mav.addObject("id", qnaVO.getId());
          
      }
      
      return mav;
    }
    
    /**
     * 비밀번호 입력 폼
     * @return
     */
    @RequestMapping(value = "/qna/input_pwd.do", 
                               method = RequestMethod.GET)
   public ModelAndView input_pwd(HttpServletRequest request, QnaVO qnaVO) {
      ModelAndView mav = new ModelAndView();
      HashMap<String, Object> map = new HashMap<String, Object>();
      
      map.put("qnano", qnaVO.getQnano());
      map.put("pwd", qnaVO.getPwd());
      
      mav.setViewName("/qna/input_pwd");
     return mav;
    }

    /**
     * 비밀번호 입력 처리
     * @return
     */
    @RequestMapping(value = "/qna/passwd_check.do", 
                               method = RequestMethod.GET)
    public ModelAndView password(HttpServletRequest request, QnaVO qnaVO) {
      ModelAndView mav = new ModelAndView();
     qnaProc.read(qnaVO.getQnano());

      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("qnano", qnaVO.getQnano());
      map.put("pwd", qnaVO.getPwd());

      int cnt = 0;
      int passwd_cnt = this.qnaProc.passwd_check(map);
      if (passwd_cnt == 1) {
   
          mav.addObject("qnano", qnaVO.getQnano());  
          mav.setViewName("redirect:/qna/read.do");
          
      }else { // 패스워드 오류
          mav.addObject("cnt", cnt);
          mav.addObject("code", "passwd_fail");
          mav.addObject("url", "/qna/msg"); // msg.jsp, redirect parameter 적용
          mav.setViewName("redirect:/qna/msg.do");
      }
    
      return mav;
    }
    
    /**
     * 목록 검색 페이징
     * @param categrpno
     * @param word
     * @param now_page
     * @param session
     * @return
     */
    @RequestMapping(value = "/qna/list_search_paging.do", method = RequestMethod.GET)
    public ModelAndView list_search_paging(
            @RequestParam(value = "categrpno", defaultValue = "6") int categrpno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
        
      ModelAndView mav = new ModelAndView();

      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("categrpno", categrpno); // #{categrpno}
      map.put("word", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      List<QnaVO> list = qnaProc.list_search_paging(map);
      mav.addObject("list", list);

      int search_count = qnaProc.search_count(map);
      
      mav.addObject("search_count", search_count);
      
      CategrpVO categrpVO = categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);
      
      String paging = qnaProc.pagingBox(categrpno, search_count, now_page, word);
//    System.out.println("-> paging: " + paging);
    mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      
      mav.setViewName("/qna/list_search_paging");

      return mav;
    }
    
  

    
    
    }