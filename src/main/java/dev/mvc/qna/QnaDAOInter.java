package dev.mvc.qna;

import java.util.List;

import dev.mvc.you.YouVO;

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
     * 멤버 join
     * @return
     */
    public List<Member_QnaVO> member_join();  
    
    /**
     * 삭제 처리 
     * @param qnano
     * @return 삭제된 레코드 갯수
     */
    public int delete(int qnano);
    /**
     * 비밀번호 입력
     * @param qnano
     * @return
     */
    public int password(int qnano);

}
