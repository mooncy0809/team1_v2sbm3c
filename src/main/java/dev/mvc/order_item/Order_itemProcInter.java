package dev.mvc.order_item;

import java.util.HashMap;
import java.util.List;

public interface Order_itemProcInter{
  /**
   * 등록
   * @param order_itemVO
   * @return
   */
  public int create(Order_itemVO order_itemVO);
  
  /**
   * 회원별 주문 결재 목록
   * @param order_payno
   * @return
   */
  public List<Order_itemVO> list_by_memberno(HashMap<String, Object> map);
  
  /**
   * 조회, 수정
   * @param order_itemno 카테고리 번호, PK
   * @return 
   */
  public Order_itemVO read(int order_itemno);
  
  /**
   * 수정 처리
   * @param order_itemVO
   * @return 수정된 레코드 갯수
   */
  public int update(Order_itemVO order_itemVO);
  
  /**
   * 삭제 처리 
   * @param order_itemno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int order_itemno);
}