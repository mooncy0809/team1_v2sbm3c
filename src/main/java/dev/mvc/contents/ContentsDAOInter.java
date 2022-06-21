package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

public interface ContentsDAOInter {
    /**
     * 등록
     * 
     * @param contentsVO 등록할 내용
     * @return 등록된 레코드 갯수
     */
    public int create(ContentsVO contentsVO);

    /**
     * 조회 select id="read" resultType="dev.mvc.contents.ContentsVO"
     * parameterType="int"
     * 
     * @param contentsno
     * @return
     */
    public ContentsVO read(int contentsno);

    /**
     * 상품 정보 수정 처리
     * 
     * @param contentsVO
     * @return
     */
    public int product_update(ContentsVO contentVO);

    /**
     * 특정 카테고리의 등록된 글목록
     * 
     * @param cateno
     * @return
     */
    public List<ContentsVO> list_by_cateno(int cateno);

    /**
     * 카테고리별 검색 목록
     * 
     * @param hashMap
     * @return
     */
    public List<ContentsVO> list_by_cateno_search(HashMap<String, Object> hashMap);

    /**
     * 카테고리별 검색 레코드 갯수
     * 
     * @param hashMap
     * @return
     */
    public int search_count(HashMap<String, Object> hashMap);
    
    /**
     * 전체 게시물 카테고리별 검색 레코드 갯수
     * 
     * @param hashMap
     * @return
     */
    public int search_count2(HashMap<String, Object> hashMap);

    /**
     * 검색 + 페이징 목록
     * 
     * @param map
     * @return
     */
    public List<ContentsVO> list_by_cateno_search_paging(HashMap<String, Object> map);

    /**
     * 패스워드 체크
     * 
     * @param map
     * @return 1 or 0
     */
    public int passwd_check(HashMap<String, Object> map);

    /**
     * 텍스트 정보 수정
     * 
     * @param contentsVO
     * @return 처리된 레코드 갯수
     */
    public int update_text(ContentsVO contentsVO);
    
    /**
     * 파일 정보 수정
     * @param contentsVO
     * @return 처리된 레코드 갯수
     */
    public int update_file(ContentsVO contentsVO);
    
    /**
     * 삭제
     * @param contentsno
     * @return
     */
    public int delete(int contentsno);
    
    /**
     * 특정 그룹에 속한 레코드 갯수 산출
     * @param cateno
     * @return
     */
    public int count_by_cateno(int cateno);
    
    /**
     * 조회수 처리 
     * @param contentsno
     * @return cnt
     */
    public int cnt(int contentsno);
    
    /**
     * Cate + Contents join, 연결 목록
     * @return
     */
//    public List<Cate_ContentsVO> list_all_join(); 
    
    /**
     * 검색 + 페이징 목록
     * 
     * @param map
     * @return
     */
    public List<ContentsVO> list_all_join(HashMap<String, Object> map);
    
    /**
     * 댓글 수 업데이트
     * @param contentsVO
     * @return
     */
    
    public int update_replycnt(ContentsVO contentsVO);
    
    /**
     * 검색 + 페이징 목록
     * 
     * @param map
     * @return
     */
    public List<ContentsVO> notice_by_cateno_search_paging(HashMap<String, Object> map);
    
    public List<ContentsVO> tip_by_cateno_search_paging(HashMap<String, Object> map);
    
    public List<ContentsVO> index_contents4(HashMap<String, Object> map);
    
    public List<ContentsVO> index_contents5(HashMap<String, Object> map);
    
    public List<ContentsVO> index_contents7(HashMap<String, Object> map);
    public List<ContentsVO> index_contents(HashMap<String, Object> map);
    
}