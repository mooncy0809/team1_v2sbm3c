package dev.mvc.reply;

import java.util.List;
import java.util.Map;

public interface ReplyProcInter {
  public int create(ReplyVO replyVO);
  
  public List<ReplyVO> list();
  
  public List<ReplyVO> list_by_contentsno(int contentsno);
  
  public List<ReplyMemberVO> list_by_contentsno_join(int contentsno);
  
  public int checkPasswd(Map<String, Object> map);

  public int delete(int replyno);
  
  /**
   * 특정글 관련 전체 댓글 목록
   * @param contentsno
   * @return
   */
  public List<ReplyMemberVO> list_by_contentsno_join_add(int contentsno);
  
}