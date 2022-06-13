package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.contents.ContentsVO;



@Component("dev.mvc.qna.QnaProc")
public class QnaProc implements QnaProcInter{
    
    @Autowired
    private QnaDAOInter qnaDAO;

    public QnaProc() {
    }

    @Override
    public int create(QnaVO qnaVO) {
        int cnt = this.qnaDAO.create(qnaVO);
        return cnt;
    }

    @Override
    public List<QnaVO> list_all() {
        List<QnaVO> list = this.qnaDAO.list_all();
        return list;
    }

    @Override
    public QnaVO read(int qnano) {
        QnaVO qnaVO = this.qnaDAO.read(qnano);
        return qnaVO;
    }

    @Override
    public int update(QnaVO qnaVO) {
        int cnt = this.qnaDAO.update(qnaVO);
        return cnt;
    }

    @Override
    public List<Member_QnaVO> member_join() {
        List<Member_QnaVO> list = this.qnaDAO.member_join();
        return list;
    }

    @Override
    public int delete(int qnano) {
        int cnt = this.qnaDAO.delete(qnano);
        return cnt;
    }

    @Override
    public int input_pwd(QnaVO qnaVO) {
        int cnt = this.qnaDAO.input_pwd(qnaVO);
        return cnt;
    }
    
    @Override
    public int passwd_check(HashMap<String, Object> map) {
        int cnt = this.qnaDAO.passwd_check(map);
        return cnt;
    }

}
