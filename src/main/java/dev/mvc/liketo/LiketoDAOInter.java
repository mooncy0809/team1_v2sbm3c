package dev.mvc.liketo;

import java.util.HashMap;

public interface LiketoDAOInter {
    
    public int countbyLike(HashMap<String, Object> hashmap);
    
    /* 좋아요 번호 등록 */
    public int create(HashMap<String, Object> hashmap);
    
    /**
     * 좋아요 체크 여부 (0 -> 1)
     * @param hashMap
     * @return
     */
    public int like_check(HashMap<String, Object> hashmap);
    
    /**
     * 좋아요 체크 여부 (1 -> 0)
     * @param hashMap
     * @return
     */
    public int like_check_cancel(HashMap<String, Object> hashmap);
    
    /* 조회 */
    public LiketoVO read(HashMap<String, Object> hashmap);
   
//    /* 게시판의 좋아요 삭제 */
//    public int deletebyBoardno(int contentsno);
//    
//    /* 회원의 좋아요 삭제 */
//    public int deletebyMno(int memberno); 

}

