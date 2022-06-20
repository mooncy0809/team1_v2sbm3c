package dev.mvc.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.order_item.Order_itemProcInter;
import dev.mvc.qna.QnaVO;
import dev.mvc.reply.ReplyMemberVO;
import dev.mvc.reply.ReplyVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

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
    public ModelAndView create(int order_itemno, int productno) {
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
                               String mname,
                               ReviewVO reviewVO) {
        ModelAndView mav = new ModelAndView();
        
     // ------------------------------------------------------------------------------
        // 파일 전송 코드 시작
        // ------------------------------------------------------------------------------
        String file1 = ""; // 원본 파일명 image
        String file1saved = ""; // 저장된 파일명, image
        String thumb1 = ""; // preview image

        // 기준 경로 확인
        String user_dir = System.getProperty("user.dir"); // 시스템 제공
        // System.out.println("-> User dir: " + user_dir);
        // --> User dir: C:\kd\ws_java\resort_v1sbm3c

        // 파일 접근임으로 절대 경로 지정, static 폴더 지정
        // 완성된 경로
        // C:/kd1/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage
        String upDir = user_dir + "/src/main/resources/static/review/storage/"; // 절대 경로
        // System.out.println("-> upDir: " + upDir);

        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF'
        // value='' placeholder="파일 선택">
        MultipartFile mf = reviewVO.getFile1MF();

        file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
        // System.out.println("-> file1: " + file1);

        long size1 = mf.getSize(); // 파일 크기

        if (size1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
            file1saved = Upload.saveFileSpring(mf, upDir);

            if (Tool.isImage(file1saved)) { // 이미지인지 검사
                // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
                thumb1 = Tool.preview(upDir, file1saved, 200, 150); // 저장 폴더, 저장된 파일명, width, height
            }

        }

        reviewVO.setFile1(file1);
        reviewVO.setFile1saved(file1saved);
        reviewVO.setThumb1(thumb1);
        reviewVO.setSize1(size1);
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 종료
        // ------------------------------------------------------------------------------

        
        this.reviewProc.create(reviewVO);
        mav.addObject("reviewno", reviewVO.getReviewno());
        session.setAttribute("memberno", memberno);
        session.setAttribute("mname", mname);
  
        mav.addObject("order_itemno", reviewVO.getOrder_itemno());
        mav.addObject("rtitle", reviewVO.getRtitle());
        mav.addObject("rcontent", reviewVO.getRcontent());
        mav.addObject("score", reviewVO.getScore());
        mav.addObject("rdate", reviewVO.getRdate());
        mav.addObject("productno", reviewVO.getProductno());
        
        mav.setViewName("redirect:/review/read.do");
        return mav;
    }
    
    /** 
    * @param productno
    * @return
    */
   @ResponseBody
   @RequestMapping(value = "/review/list_by_productsno.do",
                             method = RequestMethod.GET,
                             produces = "text/plain;charset=UTF-8")
   public String list_by_productno(int productno) {
     List<ReviewVO> list = reviewProc.list_by_productno(productno);
     
     JSONObject obj = new JSONObject();
     obj.put("list", list);
  
     return obj.toString(); 

   }
   
   // http://localhost:9091/review/read.do?reviewno=3
   /**
    * 조회
    * 
    * @return
    */
   @RequestMapping(value = "/review/read.do", method = RequestMethod.GET)
   public ModelAndView read(int reviewno) {
       ModelAndView mav = new ModelAndView();
       
       reviewProc.cnt(reviewno);  
       
       ReviewVO reviewVO = this.reviewProc.read(reviewno);
       mav.addObject("reviewVO", reviewVO);

       mav.setViewName("/review/read");

       return mav;
   }
   
   /** http://localhost:9091/review/list_by_productsno_join.do?productno=1
       * @param contentsno
       * @return
       */
      @ResponseBody
      @RequestMapping(value = "/review/list_by_productsno_join.do",
                                  method = RequestMethod.GET,
                                  produces = "text/plain;charset=UTF-8")
      public String list_by_productsno_join(int productno) {
        // String msg="JSON 출력";
        // return msg;
        
        List<ReviewMemberVO> list = reviewProc.list_by_productsno_join(productno);
        
        JSONObject obj = new JSONObject();
        obj.put("list", list);
     
        return obj.toString();     
      }
   
   /**
    * 삭제 
    * http://localhost:9090/review/delete.do?reviewno=1
    * {"delete_cnt":0,"passwd_cnt":0}
    * {"delete_cnt":1,"passwd_cnt":1}
    * @param reviewno
    * @param passwd
    * @return
    */
   @ResponseBody
   @RequestMapping(value = "/review/delete.do", 
                               method = RequestMethod.POST,
                               produces = "text/plain;charset=UTF-8")
   public String delete(int reviewno) {
     
     reviewProc.delete(reviewno); // 댓글 삭제
     
     JSONObject obj = new JSONObject();

     
     return obj.toString();
   }
    
}
