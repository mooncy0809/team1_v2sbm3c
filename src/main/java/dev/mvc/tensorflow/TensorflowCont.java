package dev.mvc.tensorflow;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TensorflowCont {
  public TensorflowCont() {
    System.out.println("-> TensorflowCont created.");
  }

  // http://localhost:9091/tensorflow/recommend/start.do
  @RequestMapping(value = {"/tensorflow/recommend/start.do"}, method = RequestMethod.GET)
  public ModelAndView start() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend/start");  // /WEB-INF/views/tensorflow/recommend/start.jsp
    
    return mav;
  }

  // http://localhost:9091/tensorflow/recommend/form1.do
  @RequestMapping(value = {"/tensorflow/recommend/form1.do"}, method = RequestMethod.GET)
  public ModelAndView form1() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend/form1");  // /WEB-INF/views/tensorflow/recommend/form1.jsp
    
    return mav;
  }

  // http://localhost:9091/tensorflow/recommend/form2.do
  @RequestMapping(value = {"/tensorflow/recommend/form2.do"}, method = RequestMethod.GET)
  public ModelAndView form2() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend/form2");  // /WEB-INF/views/tensorflow/recommend/form2.jsp
    
    return mav;
  }

  // http://localhost:9091/tensorflow/recommend/form3.do
  @RequestMapping(value = {"/tensorflow/recommend/form3.do"}, method = RequestMethod.GET)
  public ModelAndView form3() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend/form3");  // /WEB-INF/views/tensorflow/recommend/form3.jsp
    
    return mav;
  }

  // http://localhost:9091/tensorflow/recommend/form4.do
  @RequestMapping(value = {"/tensorflow/recommend/form4.do"}, method = RequestMethod.GET)
  public ModelAndView form4() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend/form4");  // /WEB-INF/views/tensorflow/recommend/form4.jsp
    
    return mav;
  }
  
  // http://localhost:9091/tensorflow/recommend/form5.do
  @RequestMapping(value = {"/tensorflow/recommend/form5.do"}, method = RequestMethod.GET)
  public ModelAndView form5() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend/form5");  // /WEB-INF/views/tensorflow/recommend/form5.jsp
    
    return mav;
  }
  
  // http://localhost:9091/tensorflow/recommend/end.do
  @RequestMapping(value = {"/tensorflow/recommend/end.do"}, method = RequestMethod.GET)
  public ModelAndView end() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend/end");  // /WEB-INF/views/tensorflow/recommend/end.jsp
    
    return mav;
  }

  @RequestMapping(value = {"/tensorflow/recommend/recommend_product.do"}, method = RequestMethod.GET)
  public ModelAndView recommend_product() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/tensorflow/recommend/recommend_product"); 
    
    return mav;
  }
  
}


