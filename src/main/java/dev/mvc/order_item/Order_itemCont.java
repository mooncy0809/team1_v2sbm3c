package dev.mvc.order_item;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Order_itemCont {
  @Autowired 
  @Qualifier("dev.mvc.order_item.Order_itemProc")
  private Order_itemProcInter order_itemProc;
  
  public Order_itemCont() {
    System.out.println("-> Order_itemCont created.");
  }
  
  /**
   * 주문 결재/회원별 목록
   * http://localhost:9091/order_item/list_by_memberno.do 
   * @return
   */
  @RequestMapping(value="/order_item/list_by_memberno.do", method=RequestMethod.GET )
  public ModelAndView list_by_memberno(HttpSession session,
                                                        int order_payno) {
    ModelAndView mav = new ModelAndView();
    
    int baesong_tot = 0;   // 배송비 합계
    int tot_sum = 0;        // 할인 금액 총 합계(금액)
    int total_order = 0;     // 전체 주문 금액
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("order_payno", order_payno);
      map.put("memberno", memberno);
      
      List<Order_itemVO> list = this.order_itemProc.list_by_memberno(map);
      
      for (Order_itemVO order_itemVO: list) {
        tot_sum += order_itemVO.getTot();
      }
      
      if (tot_sum < 30000) { // 상품 주문 금액이 30,000 원 이하이면 배송비 3,000 원 부여
        baesong_tot = 3000;
      }
      
      total_order = tot_sum + baesong_tot; // 전체 주문 금액
      
      mav.addObject("baesong_tot", baesong_tot); // 배송비
      mav.addObject("total_order", total_order);     // 할인 금액 총 합계(금액)
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/order_item/list_by_memberno"); // /views/order_item/list_by_memberno.jsp
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/order_item/list_by_memberno.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    
    return mav;
  }
  
  
  /**
   * 주문 결제/회원별 목록
   * http://localhost:9091/order_item/list_by_memberno.do 
   * @return
   */
  @RequestMapping(value="/order_item/list_by_memberno_admin.do", method=RequestMethod.GET )
  public ModelAndView list_by_memberno_admin(HttpSession session,
                                                        int order_payno) {
    ModelAndView mav = new ModelAndView();
    
    int baesong_tot = 0;   // 배송비 합계
    int tot_sum = 0;        // 할인 금액 총 합계(금액)
    int total_order = 0;     // 전체 주문 금액
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("order_payno", order_payno);
      map.put("memberno", memberno);
      
      List<Order_itemVO> list = this.order_itemProc.list_by_memberno(map);
      
      for (Order_itemVO order_itemVO: list) {
        tot_sum += order_itemVO.getTot();
      }
      
      if (tot_sum < 30000) { // 상품 주문 금액이 30,000 원 이하이면 배송비 3,000 원 부여
        baesong_tot = 3000;
      }
      
      total_order = tot_sum + baesong_tot; // 전체 주문 금액
      
      mav.addObject("baesong_tot", baesong_tot); // 배송비
      mav.addObject("total_order", total_order);     // 할인 금액 총 합계(금액)
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/order_item/list_by_memberno_admin"); // /views/order_item/list_by_memberno.jsp
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/order_item/list_by_memberno_admin.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }
    
    return mav;
  }
  
  /**
   * 조회 + 수정폼 + Ajax, , VO에서 각각의 필드를 JSON으로 변환하는경우
   * http://localhost:9091/order_item/read_ajax.do?order_itemno=1
   * {"order_payno":1,"rdate":"2022-04-29 11:21:23","cnt":0,"name":"분식","order_itemno":1}
   * @param order_itemno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/order_item/read_ajax.do", 
                              method=RequestMethod.GET )
  @ResponseBody
  public String read_ajax(int order_itemno) {
      try {
          Thread.sleep(1000);
      } catch (InterruptedException e) {
          e.printStackTrace();
      }

      Order_itemVO order_itemVO = this.order_itemProc.read(order_itemno);

      JSONObject json = new JSONObject();
      json.put("order_itemno", order_itemVO.getOrder_itemno());
      json.put("order_payno", order_itemVO.getOrder_payno());
      json.put("memberno", order_itemVO.getMemberno());
      json.put("productno", order_itemVO.getProductno());
      json.put("cnt", order_itemVO.getCnt());
      json.put("tot", order_itemVO.getTot());
      json.put("stateno", order_itemVO.getStateno());
      json.put("rdate", order_itemVO.getRdate());

      return json.toString();
  }
  
  /**
   * 수정 처리
   * 
   * @param order_itemVO
   * @return
   */
  @RequestMapping(value = "/order_item/update.do", method = RequestMethod.POST)
  public ModelAndView update(Order_itemVO order_itemVO) {
      ModelAndView mav = new ModelAndView();

      int cnt = this.order_itemProc.update(order_itemVO);

      if (cnt == 1) {
          mav.addObject("order_payno", order_itemVO.getOrder_payno());
          mav.setViewName("redirect:/order_item/list_by_memberno_admin.do");
      } else {
          mav.addObject("code", "update_fail"); // request에 저장
          mav.addObject("cnt", cnt); // request에 저장
          mav.addObject("order_itemno", order_itemVO.getOrder_itemno());
          mav.addObject("order_payno", order_itemVO.getOrder_payno());
          mav.addObject("memberno", order_itemVO.getMemberno());
          mav.addObject("productno", order_itemVO.getProductno());
          mav.addObject("cnt", order_itemVO.getCnt());
          mav.addObject("tot", order_itemVO.getTot());
          mav.addObject("stateno", order_itemVO.getStateno());
          mav.addObject("rdate", order_itemVO.getRdate());
          mav.setViewName("/order_item/list_by_memberno_admin");

      }

      return mav;
  }
  
  /**
   * 삭제 처리
   * 
   * @param order_itemVO
   * @return
   */
  @RequestMapping(value = "/order_item/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int order_itemno) {
      ModelAndView mav = new ModelAndView();
      // 삭제될 레코드 정보를 삭제하기전에 읽음
      Order_itemVO order_itemVO = this.order_itemProc.read(order_itemno);

      int cnt = this.order_itemProc.delete(order_itemno);

      if (cnt == 1) {
          mav.addObject("order_payno", order_itemVO.getOrder_payno());
          mav.setViewName("redirect:/order_item/list_by_memberno_admin.do");
      } else {
          mav.addObject("code", "delete_fail"); // request에 저장
          mav.addObject("cnt", cnt); // request에 저장
          mav.addObject("order_itemno", order_itemVO.getOrder_itemno());
          mav.addObject("order_payno", order_itemVO.getOrder_payno());
          mav.addObject("memberno", order_itemVO.getMemberno());
          mav.addObject("productno", order_itemVO.getProductno());
          mav.addObject("cnt", order_itemVO.getCnt());
          mav.addObject("tot", order_itemVO.getTot());
          mav.addObject("stateno", order_itemVO.getStateno());
          mav.addObject("rdate", order_itemVO.getRdate());

          mav.setViewName("/order_item/list_by_memberno_admin");

      }

      return mav;
  }
  
  /**
   * 삭제 처리
   * 
   * @param order_itemVO
   * @return
   */
  @RequestMapping(value = "/order_item/delete2.do", method = RequestMethod.POST)
  public ModelAndView delete2(int order_itemno) {
      ModelAndView mav = new ModelAndView();
      // 삭제될 레코드 정보를 삭제하기전에 읽음
      Order_itemVO order_itemVO = this.order_itemProc.read(order_itemno);

      int cnt = this.order_itemProc.delete(order_itemno);

      if (cnt == 1) {
          mav.addObject("order_payno", order_itemVO.getOrder_payno());
          mav.setViewName("redirect:/order_item/list_by_memberno.do");
      } else {
          mav.addObject("code", "delete_fail"); // request에 저장
          mav.addObject("cnt", cnt); // request에 저장
          mav.addObject("order_itemno", order_itemVO.getOrder_itemno());
          mav.addObject("order_payno", order_itemVO.getOrder_payno());
          mav.addObject("memberno", order_itemVO.getMemberno());
          mav.addObject("productno", order_itemVO.getProductno());
          mav.addObject("cnt", order_itemVO.getCnt());
          mav.addObject("tot", order_itemVO.getTot());
          mav.addObject("stateno", order_itemVO.getStateno());
          mav.addObject("rdate", order_itemVO.getRdate());

          mav.setViewName("/order_item/list_by_memberno");

      }

      return mav;
  }
}