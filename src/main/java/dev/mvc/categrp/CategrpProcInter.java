package dev.mvc.categrp;

import java.util.List;

public interface CategrpProcInter {
    /**
     * 등록
     * select id ="create" resultType="dev.mvc.categrp.CategrpVO"
     * @param categrpVO
     * @return 등록된 레코드 갯수
     */
  public int create(CategrpVO categrpVO);
 
  /**
   * 등록 순서별 목록
   * select id ="list_categrpno_asc" resultType="dev.mvc.categrp.CategrpVO"
   * @return
   */
  public List<CategrpVO> list_categrpno_asc();
  
  /**
   * 조회, 수정폼
   * select id="read" resultType="dev.mvc.categrp.CategrpVO" parameterType="int"
   * @param categrpno 카테고리 그룹 번호, PK
   * @return
   */
  public CategrpVO read(int categrpno);
  
  /**
   * 수정 처리
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(CategrpVO categrpVO);
  
  /**
   * 삭제 처리
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int delete(int categrpno);
  
  /**
   * 삭제 처리
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int delete2(int categrpno);
  
  /**
   * 출력 순서별 목록
   * @return
   */
  public List<CategrpVO> list_seqno_asc();
  
  /**
   * 출력 순서 상향 2 -> 1
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_up(int categrpno);
 
  /**
   * 출력 순서 하향 1 -> 2
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_down(int categrpno); 

  
  /**
   * visible 수정
   * @param categrpVO
   * @return
   */
  public int update_visible(CategrpVO categrpVO);
  
}