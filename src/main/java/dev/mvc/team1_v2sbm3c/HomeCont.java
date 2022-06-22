package dev.mvc.team1_v2sbm3c;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cate.CateProcInter;
import dev.mvc.cate.CateVO;
import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
import dev.mvc.product.Cate_ProductVO;
import dev.mvc.product.ProductProcInter;

@Controller
public class HomeCont {
    
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc") // @Component("dev.mvc.categrp.CategrpProc);
  private CategrpProcInter categrpProc; 
  
  @Autowired
  @Qualifier("dev.mvc.cate.CateProc") 
  private CateProcInter cateProc; 
  
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc; 
  
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }

  // http://localhost:9091
  @RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
  public ModelAndView home() {
      
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/index");  // /WEB-INF/views/index.jsp
    
    List<CateVO> list = this.cateProc.list_all();
    mav.addObject("list", list); // request.setAttribute("list", list);   
    
    return mav;
  }
  
//http://localhost:9091
  @RequestMapping(value = "index2.do", method = RequestMethod.GET)
  public ModelAndView list_by_cateno_grid_join2(@RequestParam(value = "cateno", defaultValue = "1") int cateno,
          @RequestParam(value = "pword", defaultValue = "") String word,
          @RequestParam(value = "now_page", defaultValue = "1") int now_page,
          HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("pword", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<Cate_ProductVO> list = productProc.list_by_cateno_grid_join2(map);
      mav.addObject("list", list);
      List<Cate_ProductVO> list2 = productProc.list_by_cateno_grid_join();
      mav.addObject("list2", list2);

      // 검색된 레코드 갯수
      int search_count = productProc.search_count2(map);
      mav.addObject("search_count", search_count);
      
      int search_count_main = productProc.search_count_main(map);
      mav.addObject("search_count_main", search_count_main);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징 생성 문자열
       */
      String paging3 = productProc.pagingBox3(cateno, search_count, now_page, word);
     
      mav.addObject("paging3", paging3);
      
      

      mav.addObject("now_page", now_page);

    // 테이블 이미지 기반, /webapp/product/list_by_cateno_grid.jsp
    mav.setViewName("/index2");

    return mav; // forward
 }
}