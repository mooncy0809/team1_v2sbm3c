package dev.mvc.review;

import java.util.List;

import dev.mvc.reply.ReplyMemberVO;

public interface ReviewProcInter {
    
    public int create(ReviewVO reviewVO);
    
    public ReviewVO read(int reviewno);
    
    public List<ReviewVO> list_by_productno(int productno);
    
    public List<ReviewMemberVO> list_by_productsno_join(int productsno);
    
    /**
     * 조회수 처리 
     * @param reviewno
     * @return cnt
     */
    public int cnt(int reviewno);
    
    public int delete(int replyno);
    
    /**
     * 특정글 관련 전체 댓글 목록
     * @param productsno
     * @return
     */
    public List<ReviewMemberVO> list_by_productsno_join_add(int productno);

}
