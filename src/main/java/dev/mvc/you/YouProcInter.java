package dev.mvc.you;

import java.util.HashMap;
import java.util.List;

import dev.mvc.contents.ContentsVO;
import dev.mvc.dict.DictVO;


public interface YouProcInter {
  /**
   * 등록
   * @param youVO
   * @return 등록된 갯수
   */
  public int create(YouVO youVO);

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
  
  /**
   * 검색 + 페이징 목록
   * select id="list_by_categrpno_search_paging" 
           resultType="dev.mvc.you.YouVO" parameterType="HashMap"
   * @param map
   * @return
   */
  public List<YouVO> list_by_categrpno_grid_search_paging(HashMap<String, Object> map);
  
  public int search_count(HashMap<String, Object> hashMap);
  
  public String pagingBox(int categrpno, int search_count, int now_page, String word);
  
  public List<YouVO> list_by_categrpno_search_paging(HashMap<String, Object> map);

/** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param list_file 목록 파일명 
   * @param categrpno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param now_page     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   * 관리자 화면 기준 페이징 기법
   */
String pagingBox_t(int categrpno, int search_count, int now_page, String word);

/**
 * 검색 + 페이징 목록
 * 
 * @param map
 * @return
 */
public List<YouVO> index_contents2(HashMap<String, Object> map);
 
}
