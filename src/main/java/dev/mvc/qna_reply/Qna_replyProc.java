package dev.mvc.qna_reply;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.qna_reply.Qna_replyProc")
public class Qna_replyProc implements Qna_replyProcInter {
    @Autowired
    private Qna_replyDAOInter qna_replyDAO; 
    
    @Override
    public int create(Qna_replyVO qna_replyVO) {
      int count = qna_replyDAO.create(qna_replyVO);
      return count;
    }

    @Override
    public List<Qna_replyVO> list() {
        List<Qna_replyVO> list = qna_replyDAO.list();
        return list;
    }

    @Override
    public List<Qna_replyVO> list_by_qnano(int qnano) {
        List<Qna_replyVO> list = qna_replyDAO.list_by_qnano(qnano);
        String content = "";
        
        for (Qna_replyVO qna_replyVO:list) {
            content = qna_replyVO.getContent();
            content = Tool.convertChar(content);
            qna_replyVO.setContent(content);
        }
        return list;
    }

    @Override
    public List<Qna_replyMemberVO> list_by_qnano_join(int qnano) {
        List<Qna_replyMemberVO> list = qna_replyDAO.list_by_qnano_join(qnano);
        String content = "";
        
        for (Qna_replyMemberVO qna_replyMemberVO:list) {
            content = qna_replyMemberVO.getContent();
            content = Tool.convertChar(content);
            qna_replyMemberVO.setContent(content);
        }
        return list;
    }

    @Override
    public int checkPasswd(Map<String, Object> map) {
        int count = qna_replyDAO.checkPasswd(map);
        return count;
    }

    @Override
    public int delete(int qna_replyno) {
        int count = qna_replyDAO.delete(qna_replyno);
        return count;
    }
}
