package dev.mvc.order_pay;

import java.util.HashMap;
import java.util.List;

public interface Order_payProcInter {
  /**
   * 
   * @param order_payVO
   * @return
   */
  public int create(Order_payVO order_payVO);
  
  /**
   * 회원별 주문 결제 목록 검색 레코드 갯수
   * 
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
      
  /**
   * 검색 + 페이징 목록
   * 
   * @param map
   * @return
   */
  public List<Order_payVO> list_by_memberno_search_paging(HashMap<String, Object> map);
  
  public String pagingBox(int memberno, int search_count, int now_page, String word);
  
  /**
   * 검색 + 페이징 목록 - 관리자용 전체목록
   * 
   * @param map
   * @return
   */
  public List<Order_payVO> list_by_memberno_search_paging_all(HashMap<String, Object> map);
  public String pagingBox2(int memberno, int search_count, int now_page, String word);
  public int search_count2(HashMap<String, Object> hashMap);

}