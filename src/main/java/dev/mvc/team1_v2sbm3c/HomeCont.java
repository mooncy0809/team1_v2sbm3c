package dev.mvc.team1_v2sbm3c;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;

@Controller
public class HomeCont {
    
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc") // @Component("dev.mvc.categrp.CategrpProc);
  private CategrpProcInter categrpProc; 
  
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }

  // http://localhost:9091
  @RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
  public ModelAndView home(CategrpVO categrpVO) {
      
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/index");  // /WEB-INF/views/index.jsp
    
    List<CategrpVO> list = this.categrpProc.list_categrpno_asc();
    mav.addObject("list", list);   
    
    return mav;
  }
}