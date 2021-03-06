package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;


public interface QnaDAOInter {
    /**
     * 등록
     * @param qnaVO
     * @return 등록된 갯수
     */
    public int create(QnaVO qnaVO); 
    /**
     *  전체 목록
     * @return
     */
    public List<QnaVO> list_all();  
    /**
     * 조회
     * @return
     */
    public QnaVO read(int qnano);
    /**
     * 수정 처리
     * @param qnaVO
     * @return
     */
    public int update(QnaVO qnaVO);
 
    
    /**
     * 삭제 처리 
     * @param qnano
     * @return 삭제된 레코드 갯수
     */
    public int delete(int qnano);
    /**
     * 비밀번호 입력
     * @param qnaVO
     * @return 처리된 레코드 갯수
     */
    public int input_pwd(QnaVO qnaVO);
    /**
     * 패스워드 체크
     * 
     * @param map
     * @return 1 or 0
     */
    public int passwd_check(HashMap<String, Object> map);
    
    public List<QnaVO> list_search_paging(HashMap<String, Object> map);

    public int search_count(HashMap<String, Object> hashMap);
    
    public String pagingBox(int categrpno, int search_count, int now_page, String word);
    
    public int update_replycnt(QnaVO qnaVO);
}
