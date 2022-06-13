package dev.mvc.qna;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.qna.QnaVO;
import dev.mvc.you.YouVO;
import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
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
    public ModelAndView create(QnaVO qnaVO, HttpSession session, int memberno) {
        ModelAndView mav = new ModelAndView();
        
        int cnt = this.qnaProc.create(qnaVO);
        session.setAttribute("memberno", memberno);
        
        
        mav.addObject("code", "create_success");
        mav.addObject("cnt", cnt);
        mav.addObject("qnano", qnaVO.getQnano());
        mav.addObject("categrpno", qnaVO.getCategrpno());
        mav.addObject("title", qnaVO.getTitle());
        mav.addObject("content", qnaVO.getContent());
        mav.addObject("pwd", qnaVO.getPwd());
        mav.addObject("rdate", qnaVO.getRdate());
        
        mav.setViewName("redirect:/qna/member_join.do");
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
          mav.setViewName("redirect:/qna/member_join.do");
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
    
    @RequestMapping(value="/qna/member_join.do", method=RequestMethod.GET )
    public ModelAndView member_join() {
      ModelAndView mav = new ModelAndView();
      
      List<Member_QnaVO> list = this.qnaProc.member_join();
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/qna/member_join");
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
          mav.setViewName("redirect:/qna/member_join.do");
      } else {
          mav.addObject("code", "update_fail"); // request에 저장
          mav.addObject("cnt", cnt);
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
     * 비밀번호 입력 폼
     * @return
     */
    @RequestMapping(value = "/qna/input_pwd.do", 
                               method = RequestMethod.GET)
   public ModelAndView input_pwd() {
      ModelAndView mav = new ModelAndView();
   
     mav.setViewName("/qna/input_pwd");
     return mav;
    }

    /**
     * 비밀번호 입력 처리
     * @return
     */
    @RequestMapping(value = "/qna/password.do", 
                               method = RequestMethod.POST)
    public ModelAndView password(int qnano) {
      ModelAndView mav = new ModelAndView();
      QnaVO qnaVO = this.qnaProc.read(qnano);

      int cnt = this.qnaProc.password(qnano);
      
      if (cnt == 1) {
          mav.addObject("categrpno", qnaVO.getCategrpno());  
          mav.setViewName("redirect:/qna/read.do");
          
      }else {
          mav.addObject("code", "update_fail"); // request에 저장
          mav.addObject("cnt", cnt);
          mav.addObject("qnano", qnaVO.getQnano());
          mav.addObject("categrpno", qnaVO.getCategrpno());
          mav.addObject("title", qnaVO.getTitle());
          mav.addObject("content", qnaVO.getContent());
          mav.addObject("pwd", qnaVO.getPwd());
          mav.addObject("rdate", qnaVO.getRdate());
          mav.setViewName("redirect:/qna/read.do");
          
      }
//        QnaVO qnaVO = memberProc.readById(id); // 로그인한 회원의 정보 조회
//        session.setAttribute("memberno", memberVO.getMemberno());
//        session.setAttribute("id", id);
//        session.setAttribute("mname", memberVO.getMname());
//        session.setAttribute("grade", memberVO.getGrade());
//        
//        mav.setViewName("redirect:/index.do"); // 시작 페이지로 이동  
//      } else {
//        mav.addObject("url", "/member/login_fail_msg"); // login_fail_msg.jsp, redirect parameter 적용
//       
//        mav.setViewName("redirect:/member/msg.do"); // 새로고침 방지
//      }
//          
      return mav;
    }

    
    
    }