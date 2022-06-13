package dev.mvc.dict;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class DictCont {
    
    @Autowired
    @Qualifier("dev.mvc.categrp.CategrpProc")
    private CategrpProcInter categrpProc;
    
    @Autowired
    @Qualifier("dev.mvc.dict.DictProc")
    private DictProcInter dictProc;
    
    public DictCont() {
        System.out.println("-> DictCont created.");
    }    
    
    /**
     * 조회
     * 
     * @return
     */
    @RequestMapping(value = "/dict/read.do", method = RequestMethod.GET)
    public ModelAndView read(int dictno,
                             @RequestParam(value = "now_page", defaultValue = "1") int now_page,
                             HttpSession session, String id) {
        ModelAndView mav = new ModelAndView();

        dictProc.cnt(dictno);
        
        DictVO dictVO = this.dictProc.read(dictno);
        mav.addObject("dictVO", dictVO); // request.setAttribute("dictVO", dictVO);

        CategrpVO categrpVO = this.categrpProc.read(dictVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);
        
        session.setAttribute("id", id);

        mav.addObject("now_page", now_page);

        mav.setViewName("/dict/read"); // /WEB-INF/views/dict/read.jsp

        return mav;
    }
    
    /** http://localhost:9090/dict/list_by_categrpno_search_paging.do?categrpno=1&now_page=1
     * 
     * @param categrpno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/dict/list_by_categrpno_search_paging.do", method = RequestMethod.GET)
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

      List<DictVO> list = dictProc.list_by_categrpno_search_paging(map);
      mav.addObject("list", list);

      // 검색된 레코드 갯수
      int search_count = dictProc.search_count(map);
      mav.addObject("search_count", search_count);

      CategrpVO categrpVO = categrpProc.read(categrpno);
      mav.addObject("categrpVO", categrpVO);


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
      String paging = dictProc.pagingBox(categrpno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      
      mav.setViewName("/dict/list_by_categrpno_search_paging");

      return mav;
    }

}
