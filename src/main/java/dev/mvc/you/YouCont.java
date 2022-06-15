package dev.mvc.you;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.you.YouVO;
import dev.mvc.categrp.CategrpVO;
import dev.mvc.contents.ContentsVO;
import dev.mvc.cate.CateVO;
import dev.mvc.categrp.CategrpProcInter;


@Controller
public class YouCont {
    @Autowired
    @Qualifier("dev.mvc.categrp.CategrpProc")
    private CategrpProcInter categrpProc;
    @Autowired
    @Qualifier("dev.mvc.you.YouProc")  // @Component("dev.mvc.you.YouProc")
    private YouProcInter youProc;

    public YouCont() {
        System.out.println("-> YouCont created.");
    }
    
    /**
     * 등록폼 http://localhost:9091/you/create.do?categrpno=2
     * 
     * @return
     */
    @RequestMapping(value = "/you/create.do", method = RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/you/create"); // /webapp/WEB-INF/views/you/create.jsp

      return mav;
    }
    
    /**
     * 등록처리
     * YouVO youVO 객체안의 필드들이 <form> 태그에 존재하면 자동으로 setter 호출됨. 
     * http://localhost:9091/you/create.do?categrpno=2
     * Exception: FK 전달이 안됨.
     * Field error in object 'urlVO' on field 'urlgrpno': rejected value [];
     * codes [typeMismatch.urlVO.urlgrpno,typeMismatch.urlgrpno,typeMismatch.int,typeMismatch]; 
     * arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [urlVO.urlgrpno,urlgrpno];
     * arguments []; default message [urlgrpno]]; 
     * default message [Failed to convert property value of type 'java.lang.String' to required type 'int' for property 'urlgrpno';
     * nested exception is java.lang.NumberFormatException: For input string: ""]]
     * @return
     */
    @RequestMapping(value = "/you/create.do", method = RequestMethod.POST)
    public ModelAndView create(YouVO youVO) {
      ModelAndView mav = new ModelAndView();

      // System.out.println("-> categrpno: " + youVO.getCategrpno());
      
      int count = this.youProc.create(youVO);
      // System.out.println("등록 성공");
      
      mav.addObject("count", count);
      mav.addObject("code", "create_success");
      mav.addObject("cnt", youVO.getCnt());
      mav.addObject("categrpno", youVO.getCategrpno());
      mav.addObject("ytitle", youVO.getYtitle());
      mav.addObject("ytext", youVO.getYtext());
      mav.addObject("url", youVO.getUrl());
      mav.setViewName("/you/msg"); // /WEB-INF/views/you/msg.jsp
     
      return mav;
    }
   
  
    /**
     * 조회 + 수정폼 http://localhost:9091/you/read_update.do
     * 
     * @return
     */
    @RequestMapping(value = "/you/read_update.do", method = RequestMethod.GET)
    public ModelAndView read_update(int youno) {
      // int youno = Integer.parseInt(request.getParameter("youno"));

      ModelAndView mav = new ModelAndView();
      mav.setViewName("/you/read_update"); // read_update.jsp

      // 카테고리 정보
      YouVO youVO = this.youProc.read(youno);
      mav.addObject("youVO", youVO);
      // request.setAttribute("youVO", youVO);
      
      int categrpno = youVO.getCategrpno();
      
      // 카테고리 그룹 정보
      CategrpVO categrpVO = this.categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);

      return mav; // forward
    }
    
    /**
     * 수정 처리
     * 
     * @param youVO
     * @return
     */
    @RequestMapping(value = "/you/update.do", method = RequestMethod.POST)
    public ModelAndView update(YouVO youVO) {
      ModelAndView mav = new ModelAndView();

      int cnt = this.youProc.update(youVO);
      
      if (cnt == 1) {
          mav.addObject("categrpno", youVO.getCategrpno());
          mav.setViewName("redirect:/you/list_by_categrpno.do");
      } else {
          mav.addObject("code", "update_fail"); // request에 저장
          mav.addObject("cnt", cnt); // request에 저장
          mav.addObject("youno", youVO.getYouno());
          mav.addObject("categrpno", youVO.getCategrpno());
          mav.addObject("ytitle", youVO.getYtitle());
          mav.addObject("ytext", youVO.getYtext());
          mav.addObject("url", "/you/msg");  // /you/msg -> /you/msg.jsp로 최종 실행됨.
          
          mav.setViewName("/you/msg"); // /WEB-INF/views/you/msg.jsp
             
      }
      
      return mav;
    }
    
    /**
     * 조회 + 삭제폼 http://localhost:9091/you/read_delete.do
     * 
     * @return
     */

    @RequestMapping(value = "/you/read_delete.do", method = RequestMethod.GET)
    public ModelAndView read_delete(int youno) {
      // int youno = Integer.parseInt(request.getParameter("youno"));
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/you/read_delete");

      YouVO youVO = this.youProc.read(youno);
      mav.addObject("youVO", youVO);
      int categrpno = youVO.getCategrpno();
      
      CategrpVO categrpVO = this.categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);

      return mav; // forward
    }
    
    /**
     * 삭제 처리
     * 
     * @param youVO
     * @return
     */
    @RequestMapping(value = "/you/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(int youno) {
      ModelAndView mav = new ModelAndView();
      // 삭제될 레코드 정보를 삭제하기전에 읽음
      YouVO youVO = this.youProc.read(youno); 
      
      int count = this.youProc.delete(youno);
      
      if (count == 1) {
          mav.addObject("categrpno", youVO.getCategrpno());
          mav.setViewName("redirect:/you/list_by_categrpno_search_paging.do");
      } else {
          mav.addObject("code", "update_fail"); // request에 저장
          mav.addObject("cnt", youVO.getCnt()); // request에 저장
          mav.addObject("count",count);
          mav.addObject("youno", youVO.getYouno());
          mav.addObject("categrpno", youVO.getCategrpno());
          mav.addObject("ytitle", youVO.getYtitle());
          mav.addObject("ytext", youVO.getYtext());
          mav.addObject("url", "/you/msg"); 
          
      }
      
      return mav;
    }
    /**
     * Grid 형태의 화면 구성
     * 
     * @return
     */
    @RequestMapping(value = "/you/list_by_categrpno_grid.do", method = RequestMethod.GET)
    public ModelAndView list_by_categrpno_grid(int categrpno) {
      ModelAndView mav = new ModelAndView();
      
      CategrpVO categrpVO = this.categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);
      
      
      /*
       * List<YouVO> list = this.youProc.list_by_categrpno_search_paging(categrpno);
       * mav.addObject("list", list);
       */

      mav.setViewName("/you/list_by_categrpno_grid");

      return mav; // forward
    }

    /**
     * 조회
     * 
     * @return
     */
    @RequestMapping(value = "/you/read.do", method = RequestMethod.GET)
    public ModelAndView read(int youno) {
        ModelAndView mav = new ModelAndView();
        
        youProc.cnt(youno);
        
        YouVO youVO = this.youProc.read(youno); 
        mav.addObject("youVO", youVO); // request.setAttribute("youVO", youVO);
        
        CategrpVO categrpVO = this.categrpProc.read(youVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);
       
        mav.setViewName("/you/read"); // /WEB-INF/views/you/read.jsp

        return mav;
    }
    
    /**
     * 목록 + 검색 + 페이징 지원
     * http://localhost:9090/you/list_by_categrpno_grid_search_paging.do?categrpno=1&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/you/list_by_categrpno_grid_search_paging.do", method = RequestMethod.GET)
    public ModelAndView list_by_categrpno_grid_search_paging(
            @RequestParam(value = "categrpno", defaultValue = "4") int categrpno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("categrpno", categrpno); // #{categrpno}
      map.put("word", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<YouVO> list = youProc.list_by_categrpno_grid_search_paging(map);
      mav.addObject("list", list);

      // 검색된 레코드 갯수
      int search_count = youProc.search_count(map);
      mav.addObject("search_count", search_count);

      CategrpVO categrpVO = categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);

      /*
       * CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
       * mav.addObject("categrpVO", categrpVO);
       */

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = youProc.pagingBox(categrpno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      
      mav.setViewName("/you/list_by_categrpno_grid_search_paging");

      return mav;
    }
    
    
    /**
     * 목록 + 검색 + 페이징 지원
     * http://localhost:9090/you/list_by_categrpno_grid_search_paging.do?categrpno=1&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/you/index_contents2.do", method = RequestMethod.GET)
    public ModelAndView index_contents2(
            @RequestParam(value = "categrpno", defaultValue = "4") int categrpno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("categrpno", categrpno); // #{categrpno}
      map.put("word", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<YouVO> list = youProc.index_contents2(map);
      mav.addObject("list", list);

      // 검색된 레코드 갯수
      int search_count = youProc.search_count(map);
      mav.addObject("search_count", search_count);

      CategrpVO categrpVO = categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);

      String paging = youProc.pagingBox(categrpno, search_count, now_page, word);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      
      mav.setViewName("/you/index_contents2");

      return mav;
    }
    
    
    
    
    
    /** http://localhost:9090/you/list_by_categrpno_search_paging.do?categrpno=1&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/you/list_by_categrpno_search_paging.do", method = RequestMethod.GET)
    public ModelAndView list_by_categrpno_search_paging(
            @RequestParam(value = "categrpno", defaultValue = "4") int categrpno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("categrpno", categrpno); // #{categrpno}
      map.put("word", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      List<YouVO> list = youProc.list_by_categrpno_search_paging(map);
      mav.addObject("list", list);

      // 검색된 레코드 갯수
      int search_count = youProc.search_count(map);
      mav.addObject("search_count", search_count);

      CategrpVO categrpVO = categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);

      /*
       * CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
       * mav.addObject("categrpVO", categrpVO);
       */

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = youProc.pagingBox_t(categrpno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      
      mav.setViewName("/you/list_by_categrpno_search_paging");

      return mav;
    }
    
    
    

    
    
}