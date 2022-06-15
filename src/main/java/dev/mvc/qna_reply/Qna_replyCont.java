package dev.mvc.qna_reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProc;

@Controller
public class Qna_replyCont {
    @Autowired
    @Qualifier("dev.mvc.qna_reply.Qna_replyProc")
    private Qna_replyProcInter qna_replyProc;
    
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProc memberProc;
    
    public Qna_replyCont() {
        System.out.println("-> Qna_replyCont created.");
    }
    
    @ResponseBody
    @RequestMapping(value = "/qna_reply/create.do",
                              method = RequestMethod.POST,
                              produces = "text/plain;charset=UTF-8")
    public String create(Qna_replyVO qna_replyVO) {
      int cnt = qna_replyProc.create(qna_replyVO);
      
      JSONObject obj = new JSONObject();
      obj.put("cnt",cnt);
   
      return obj.toString(); // {"cnt":1}

    }
    
    @RequestMapping(value="/qna_reply/list.do", method=RequestMethod.GET)
    public ModelAndView list(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      if (memberProc.isAdmin(session)) {
        List<Qna_replyVO> list = qna_replyProc.list();
        
        mav.addObject("list", list);
        mav.setViewName("/qna_reply/list"); // /webapp/reply/list.jsp

      } else {
        mav.addObject("return_url", "/qna_reply/list_join.do"); // 로그인 후 이동할 주소 ★
        
        mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
      }
      
      return mav;
    }
    
    @ResponseBody
    @RequestMapping(value = "/qna_reply/list_by_qnano.do",
                              method = RequestMethod.GET,
                              produces = "text/plain;charset=UTF-8")
    public String list_by_qnano(int qnano) {
      List<Qna_replyVO> list = qna_replyProc.list_by_qnano(qnano);
      
      JSONObject obj = new JSONObject();
      obj.put("list", list);
   
      return obj.toString(); 

    }
    
    @ResponseBody
    @RequestMapping(value = "/qna_reply/list_by_qnano_join.do",
                                method = RequestMethod.GET,
                                produces = "text/plain;charset=UTF-8")
    public String list_by_qnano_join(int qnano) {
      // String msg="JSON 출력";
      // return msg;
      
      List<Qna_replyMemberVO> list = qna_replyProc.list_by_qnano_join(qnano);
      
      JSONObject obj = new JSONObject();
      obj.put("list", list);
   
      return obj.toString();     
    }
    
    @ResponseBody
    @RequestMapping(value = "/qna_reply/delete.do", 
                                method = RequestMethod.POST,
                                produces = "text/plain;charset=UTF-8")
    public String delete(int qna_replyno, String passwd) {
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("qna_replyno", qna_replyno);
      map.put("passwd", passwd);
      
      int passwd_cnt = qna_replyProc.checkPasswd(map); // 패스워드 일치 여부, 1: 일치, 0: 불일치
      int delete_cnt = 0;                                    // 삭제된 댓글
      if (passwd_cnt == 1) { // 패스워드가 일치할 경우
        delete_cnt = qna_replyProc.delete(qna_replyno); // 댓글 삭제
      }
      
      JSONObject obj = new JSONObject();
      obj.put("passwd_cnt", passwd_cnt); // 패스워드 일치 여부, 1: 일치, 0: 불일치
      obj.put("delete_cnt", delete_cnt); // 삭제된 댓글
      
      return obj.toString();
    }


}
