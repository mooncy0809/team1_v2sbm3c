package dev.mvc.order_pay;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cart.CartProcInter;
import dev.mvc.cart.CartVO;
import dev.mvc.categrp.CategrpVO;
import dev.mvc.order_item.Order_itemProcInter;
import dev.mvc.order_item.Order_itemVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;
 
@Controller
public class Order_payCont {
  
  @Autowired 
  @Qualifier("dev.mvc.cart.CartProc")
  private CartProcInter cartProc;
  
  @Autowired 
  @Qualifier("dev.mvc.order_pay.Order_payProc")
  private Order_payProcInter order_payProc;
  
  @Autowired 
  @Qualifier("dev.mvc.order_item.Order_itemProc")
  private Order_itemProcInter order_itemProc;

  @Autowired 
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;
  public Order_payCont() {
    System.out.println("-> Order_payCont created.");
  }
  
  // http://localhost:9091/order_pay/create.do
  /**
  * 등록 폼
  * @return
  */
  @RequestMapping(value="/order_pay/create.do", method=RequestMethod.GET )
  public ModelAndView create(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    int tot = 0;               // 할인 금액 합계 = 할인 금액 * 수량
    int tot_sum = 0;        // 할인 금액 총 합계 = 할인 금액 총 합계 + 할인 금액 합계
    int point_tot = 0;       // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
    int baesong_tot = 0;   // 배송비 합계
    int total_order = 0;     // 전체 주문 금액
    
    int memberno = (int)session.getAttribute("memberno");
    
    // 쇼핑카트에 등록된 상품 목록을 가져옴
    List<CartVO> list = this.cartProc.list_by_memberno(memberno);
    
    for (CartVO cartVO : list) {
      tot = cartVO.getSaleprice() * cartVO.getCnt();  // 할인 금액 합계 = 할인 금액 * 수량
      cartVO.setTot(tot);
      
      // 할인 금액 총 합계 = 할인 금액 총 합계 + 할인 금액 합계
      tot_sum = tot_sum + cartVO.getTot();
      // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
      point_tot = point_tot + (cartVO.getPoint() * cartVO.getCnt());
      
    }
    
    if (tot_sum < 30000) { // 상품 주문 금액이 30,000 원 이하이면 배송비 3,000 원 부여
      baesong_tot = 3000;
    }
    
    total_order = tot_sum + baesong_tot; // 전체 주문 금액
        
    mav.addObject("list", list); // request.setAttribute("list", list);
    
    
    mav.addObject("tot_sum", tot_sum);
    mav.addObject("point_tot", point_tot);
    mav.addObject("baesong_tot", baesong_tot);
    mav.addObject("total_order", total_order);
    
    mav.setViewName("/order_pay/create"); // webapp/WEB-INF/views/order_pay/create.jsp
      
    return mav; // forward
  }

  
  // http://localhost:9091/order_pay/create.do
  /**
   * 주문 결제 등록 처리
   * @param order_payVO
   * @return
   */
  @RequestMapping(value="/order_pay/create.do", method=RequestMethod.POST )
  public ModelAndView create(HttpSession session,
                                        Order_payVO order_payVO) { // order_payVO 자동 생성, Form -> VO
    ModelAndView mav = new ModelAndView();
    
    int memberno = (int)session.getAttribute("memberno");
    order_payVO.setMemberno(memberno); // 회원 번호 저장
    
    int cnt = this.order_payProc.create(order_payVO);

    /*
    // 주문 결제하고 바로 번호 수집
    <!-- 주문 결제 등록 전 order_payno를 Order_payVO에 저장  -->
    <insert id="create" parameterType="dev.mvc.order_pay.Order_payVO">
      <selectKey keyProperty="order_payno" resultType="int" order="BEFORE">
        SELECT order_pay_seq.nextval FROM dual
      </selectKey>
      
      INSERT INTO order_pay(order_payno, memberno, rname, rtel, rzipcode,
                                       raddress1, raddress2, paytype, amount, rdate)
      VALUES (#{order_payno}, #{memberno}, #{rname}, #{rtel}, #{rzipcode},
                                       #{raddress1}, #{raddress2}, #{paytype}, #{amount}, sysdate)
    </insert>
    */
    
    
    // Order_item: 주문 상세 테이블 관련 시작
    
    int order_payno = order_payVO.getOrder_payno(); // 결제 번호 수집
    
    Order_itemVO order_itemVO = new Order_itemVO();
    if (cnt == 1) { // 정상적으로 주문 결제 정보가 등록된 경우
      // 회원의 쇼핑카트 정보를 읽어서 주문 상세 테이블로 insert
      // 1. cart 읽음, SELECT
      List<CartVO> list = this.cartProc.list_by_memberno(memberno);
      for (CartVO cartVO : list) {
        int productno = cartVO.getProductno();
        int cartno = cartVO.getCartno();
        
        // 2. order_item INSERT
       order_itemVO.setMemberno(memberno);
       order_itemVO.setOrder_payno(order_payno);
       order_itemVO.setProductno(productno);
       order_itemVO.setCnt(cartVO.getCnt());
       
       ProductVO productVO = this.productProc.read(productno); // 할인 금액 읽기용 VO
       int tot = productVO.getSaleprice() * cartVO.getCnt();  // 할인 금액 합계 = 할인 금액 * 수량
       
       order_itemVO.setTot(tot); // 상품 1건당 총 결제 금액
       
       // 주문 상태(stateno):  1: 결제 완료, 2: 상품 준비중, 3: 배송 시작, 4: 배달중, 5: 오늘 도착, 6: 배달 완료  
       order_itemVO.setStateno(1); // 신규 주문 등록임으로 1 
       
       this.order_itemProc.create(order_itemVO); // 주문 상세 등록

       // 3. 주문된 상품 cart에서 DELETE
       int delete_cnt = this.cartProc.delete(cartno);
       System.out.println("-> delete_cnt: " + delete_cnt + " 건 주문후 cart에서 삭제됨.");

      }
      
    } else {
      // 결제 실패했다는 에러 페이지등 제작 필요, 여기서는 생략
    }
    
 // Order_item: 주문 상세 테이블 관련 종료    
    
    mav.addObject("memberno", memberno);
    
    mav.setViewName("redirect:/order_pay/list_by_memberno_search_paging.do");  // 참일 경우만 발생한다고 결정, 에러 페이지 이동 생략 

    return mav; // forward
  }

  /**
   * 회원별 전체 목록, 로그인이 안되어 있으면 로그인 후 목록 출력
   * http://localhost:9091/order_pay/list_by_memberno_search_paging.do 
   * @return
   */
  @RequestMapping(value="/order_pay/list_by_memberno_search_paging.do", method=RequestMethod.GET )
  public ModelAndView list_by_memberno_search_paging(
          @RequestParam(value = "memberno") int memberno,                                                                           
          @RequestParam(value = "word", defaultValue = "") String word,                                                                           
          @RequestParam(value = "now_page", defaultValue = "1") int now_page,
          HttpSession session) {
    ModelAndView mav = new ModelAndView();
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno); // #{memberno}
    map.put("word", word); // #{word}
    map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용
  
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      memberno = (int)session.getAttribute("memberno");
      
      List<Order_payVO> list = order_payProc.list_by_memberno_search_paging(map);
      mav.addObject("list", list);  
      
      // 검색된 레코드 갯수
      int search_count = order_payProc.search_count(map);
      mav.addObject("search_count", search_count);
      
      String paging = order_payProc.pagingBox(memberno, search_count, now_page, word);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      
      mav.setViewName("/order_pay/list_by_memberno_search_paging"); // /views/order_pay/list_by_memberno_search_paging.jsp   
      
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/order_pay/list_by_memberno_search_paging.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }

    return mav;
  }
  /**
   * 회원별 전체 목록, 로그인이 안되어 있으면 로그인 후 목록 출력
   * 관리자용
   * http://localhost:9091/order_pay/list_by_memberno_search_paging.do 
   * @return
   */
  @RequestMapping(value="/order_pay/list_by_memberno_search_paging_all.do", method=RequestMethod.GET )
  public ModelAndView list_by_memberno_search_paging_all(
          @RequestParam(value = "memberno") int memberno,                                                                           
          @RequestParam(value = "word", defaultValue = "") String word,                                                                           
          @RequestParam(value = "now_page", defaultValue = "1") int now_page,
          HttpSession session) {
    ModelAndView mav = new ModelAndView();
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno); // #{memberno}
    map.put("word", word); // #{word}
    map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용
  
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      memberno = (int)session.getAttribute("memberno");
      
      List<Order_payVO> list = order_payProc.list_by_memberno_search_paging_all(map);
      mav.addObject("list", list);  
      
      // 검색된 레코드 갯수
      int search_count2 = order_payProc.search_count2(map);
      mav.addObject("search_count2", search_count2);
      
      String paging = order_payProc.pagingBox2(memberno, search_count2, now_page, word);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      
      mav.setViewName("/order_pay/list_by_memberno_search_paging_all"); // /views/order_pay/list_by_memberno_search_paging.jsp   
      
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/order_pay/list_by_memberno_search_paging_all.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }

    return mav;
  }

}