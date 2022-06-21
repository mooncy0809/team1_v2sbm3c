package dev.mvc.you;

import java.util.HashMap;
import java.util.List;

import dev.mvc.contents.ContentsVO;
import dev.mvc.dict.DictVO;

public interface YouDAOInter {
  /**
   * 등록
   * @param youVO
   * @return 등록된 갯수
   */
  public int create(YouVO youVO);
 
  /**
   * Urlgrp + Url join, 연결 목록
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
   * @param youno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int youno);

  /**
   * 조회수 처리 
   * @param youno
   * @return cnt
   */
  public int cnt(int youno);
 
  public List<YouVO> list_by_categrpno_grid_search_paging(HashMap<String, Object> map);
  
  public int search_count(HashMap<String, Object> hashMap);
  
  public String pagingBox(int categrpno, int search_count, int now_page, String word);
  
  public List<YouVO> list_by_categrpno_search_paging(HashMap<String, Object> map);
  
  String pagingBox_t(int categrpno, int search_count, int now_page, String word);

  
  /**
   * 검색 + 페이징 목록
   * 
   * @param map
   * @return
   */
  public List<YouVO> index_contents2(HashMap<String, Object> map);
  
  public List<YouVO> index_contents6(HashMap<String, Object> map);
}



