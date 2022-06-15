package dev.mvc.qna_reply;

import java.util.List;
import java.util.Map;

public interface Qna_replyDAOInter {
    public int create(Qna_replyVO qna_replyVO);
    
    public List<Qna_replyVO> list();
    
    public List<Qna_replyVO> list_by_qnano(int qnano);
    
    public List<Qna_replyMemberVO> list_by_qnano_join(int qnano);
    
    public int checkPasswd(Map<String, Object> map);

    public int delete(int qna_replyno);

}
