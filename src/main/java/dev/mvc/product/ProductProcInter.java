package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

public interface ProductProcInter {
    /**
     * 등록
     * @param productVO 등록할 내용
     * @return 등록된 레코드 갯수
     */
    public int create(ProductVO productVO);
    
    /**
     * 조회
     * select id="read" resultType="dev.mvc.product.ProductVO" parameterType="int"
     * @param productno
     * @return
     */
    public ProductVO read(int productno);
    
    /**
     * 상품 정보 변경
     * @param productVO
     * @return
     */
    public int product_update(ProductVO productVO);
    
    /**
     * 특정 카테고리의 등록된 글목록
     * @param cateno
     * @return
     */
    public List<ProductVO> list_by_cateno(HashMap<String, Object> map);
    
    /**
     * 카테고리별 검색 목록
     * @param hashMap
     * @return
     */
    public List<ProductVO> list_by_cateno_search(HashMap<String, Object> hashMap);

    /**
     * 카테고리별 검색 레코드 갯수
     * @param hashMap
     * @return
     */
    public int search_count(HashMap<String, Object> hashMap);
    
    /**
     * 카테고리별 검색 레코드 갯수
     * @param hashMap
     * @return
     */
    public int search_count_main(HashMap<String, Object> hashMap);
    
    /**
     * 카테고리별 검색 레코드 갯수
     * @param hashMap
     * @return
     */
    public int search_count2(HashMap<String, Object> hashMap);
    
    /**
     * 검색 + 페이징 목록
     * select id="list_by_cateno_search_paging" 
             resultType="dev.mvc.product.ProductVO" parameterType="HashMap"
     * @param map
     * @return
     */
    public List<ProductVO> list_by_cateno_search_paging(HashMap<String, Object> map);
    
    /** 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param list_file 목록 파일명 
     * @param cateno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param now_page     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    public String pagingBox(int cateno, int search_count, int now_page, String word);
    
    /** 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param list_file 목록 파일명 
     * @param cateno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param now_page     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    public String pagingBox2(int cateno, int search_count, int now_page, String word);
    
    /**
     * 패스워드 검사
     * @param map
     * @return 1 or 0
     */
    public int passwd_check(HashMap map);
    
    /**
     * 텍스트 정보 수정
     * @param productVO
     * @return 처리된 레코드 갯수
     */
    public int update_text(ProductVO productVO);
    
    /**
     * 파일 정보 수정
     * @param productVO
     * @return 처리된 레코드 갯수
     */
    public int update_file(ProductVO productVO);
    
    /**
     * 삭제
     * @param productno
     * @return 삭제된 레코드 개수
     */
    public int delete(int productno);

    /**
     * 카테고리 번호에 의한 카운트 
     * @param cateno 카테고리 번호
     * @return 갯수
     */
    public int count_by_cateno(int cateno);
    
    /**
     * Cate + Product join, 연결 목록
     * @return
     */
    public List<Cate_ProductVO> list_by_cateno_grid_join();  
    
    /**
     * Cate + Product join, 연결 목록
     * @return
     */
    public List<Cate_ProductVO> list_by_cateno_grid_join2(HashMap<String, Object> map);

    /** 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param list_file 목록 파일명 
     * @param cateno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param now_page     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */
    String pagingBox3(int cateno, int search_count, int now_page, String pword);
    String pagingBox4(int cateno, int search_count, int now_page, String pword);
    String pagingBox5(int cateno, int search_count, int now_page, String pword);
    
    /**
     * Cate + Product join, 연결 목록
     * @return
     */
    public List<Cate_ProductVO> list_by_cateno_grid_join_up(HashMap<String, Object> map);
    
    /**
     * Cate + Product join, 연결 목록
     * @return
     */
    public List<Cate_ProductVO> list_by_cateno_grid_join_down(HashMap<String, Object> map);
    
    /**
     * Cate + Product join, 연결 목록
     * @return
     */
    public List<Cate_ProductVO> list_by_cateno_grid_join_dc(HashMap<String, Object> map);
    
}




