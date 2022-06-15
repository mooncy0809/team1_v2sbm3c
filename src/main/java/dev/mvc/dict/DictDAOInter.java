package dev.mvc.dict;

import java.util.HashMap;
import java.util.List;

import dev.mvc.contents.ContentsVO;

public interface DictDAOInter {

    /**
     * 조회 select id="read" resultType="dev.mvc.dict.DictVO"
     * parameterType="int"
     * 
     * @param dictno
     * @return
     */
    public DictVO read(int dictno);
    
    /**
     * 조회수 처리 
     * @param dictno
     * @return cnt
     */
    public int cnt(int dictno);
    
    /**
     * 카테고리별 검색 레코드 갯수
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
    public List<DictVO> list_by_categrpno_search_paging(HashMap<String, Object> map);
    
    public String pagingBox(int categrpno, int search_count, int now_page, String word);
    
    /**
     * 검색 + 페이징 목록
     * 
     * @param map
     * @return
     */
    public List<DictVO> index_contents3(HashMap<String, Object> map);
}
