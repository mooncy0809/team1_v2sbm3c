package dev.mvc.you;

import java.util.List;

public interface YouProcInter {
  /**
   * 등록
   * @param youVO
   * @return 등록된 갯수
   */
  public int create(YouVO youVO);
  /**
   *  전체 목록
   * @return
   */
  public List<YouVO> list_all();  
  /**
   *  categrpno별 목록
   * @return
   */
  public List<YouVO> list_by_categrpno(int categrpno);   
  /**
   * Categrp + You join, 연결 목록
   * @return
   */

  public YouVO read(int youno);
  
  /**
   * 수정 처리
   * @param youVO
   * @return 수정된 레코드 갯수
   */
  public int update(YouVO youVO);
  /**
   * 삭제 처리 
   * @param pcateno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int youno);
  
  /**
   * 조회수 처리 
   * @param youno
   * @return cnt
   */
  public int cnt(int youno);
  
 
}
