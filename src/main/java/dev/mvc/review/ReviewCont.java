package dev.mvc.review;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.order_item.Order_itemProcInter;
import dev.mvc.qna.QnaVO;

@Controller
public class ReviewCont {
    
    @Autowired
    @Qualifier("dev.mvc.review.ReviewProc") // 이름 지정
    private ReviewProcInter reviewProc;
    
    @Autowired 
    @Qualifier("dev.mvc.order_item.Order_itemProc")
    private Order_itemProcInter order_itemProc;

    public ReviewCont(){
        System.out.println("-> ReviewCont created.");
      }
      
    /**
     * 새로고침 방지
     * 
     * @return
     */
    @RequestMapping(value = "/review/msg.do", method = RequestMethod.GET)
    public ModelAndView msg() {
        ModelAndView mav = new ModelAndView();
        return mav; // forward
    }

    /**
     * 등록폼 
     * 
     * @return
     */
    @RequestMapping(value= "/review/create.do", method = RequestMethod.GET)
    public ModelAndView create(int order_itemno) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/review/create");

        return mav;
    }
    
    /**
     * 등록처리
     * 
     * @return
     */
    @RequestMapping(value= "/review/create.do", method = RequestMethod.POST)
    public ModelAndView create(HttpServletRequest request, 
                               HttpServletResponse response, 
                               HttpSession session,
                               int memberno,
                               int order_itemno,
                               ReviewVO reviewVO) {
        ModelAndView mav = new ModelAndView();
        
        this.reviewProc.create(reviewVO);
        mav.addObject("reviewno", reviewVO.getReviewno());
        session.setAttribute("memberno", memberno);
  
        mav.addObject("order_itemno", reviewVO.getOrder_itemno());
        mav.addObject("rtitle", reviewVO.getRtitle());
        mav.addObject("rcontent", reviewVO.getRcontent());
        mav.addObject("score", reviewVO.getScore());
        mav.addObject("rdate", reviewVO.getRdate());
        
        mav.setViewName("redirect:/index.do");
        return mav;
    }
    
}
