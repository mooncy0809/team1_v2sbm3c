package dev.mvc.qna;

public class QnaVO {
    /** 질문답변 번호 */
    private int qnano;
    /** 카테고리 그룹 번호*/
    private int categrpno;
    /** 회원 번호*/
    private int memberno;
    /** 질문답변 제목*/
    private String title;
    /** 질문답변 내용*/
    private String content;
    /** 댓글 번호 */
    private int qna_replyno;
    /** 댓글수 */
    private int replycnt = 0;
    /** 질문답변 비밀번호*/
    private int pwd;
    /** 작성일 */
    private String rdate;
    /** 아이디 */
    private String id;
    
    public QnaVO() {
        
    }
    
    public QnaVO(int qnano, int categrpno, int memberno, String title, String content,int qna_replyno, int replycnt, int pwd, String rdate, String id) {
        super();
        this.qnano = qnano;
        this.categrpno = categrpno;
        this.memberno = memberno;
        this.title = title;
        this.content = content;
        this.qna_replyno = qna_replyno;
        this.replycnt = replycnt;
        this.pwd = pwd;
        this.rdate = rdate;
        this.id = id;
    }

    
    
    public int getQna_replyno() {
        return qna_replyno;
    }

    public void setQna_replyno(int qna_replyno) {
        this.qna_replyno = qna_replyno;
    }

    public int getReplycnt() {
        return replycnt;
    }

    public void setReplycnt(int replycnt) {
        this.replycnt = replycnt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getQnano() {
        return qnano;
    }

    public void setQnano(int qnano) {
        this.qnano = qnano;
    }

    public int getCategrpno() {
        return categrpno;
    }

    public void setCategrpno(int categrpno) {
        this.categrpno = categrpno;
    }

    public int getMemberno() {
        return memberno;
    }

    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getPwd() {
        return pwd;
    }

    public void setPwd(int pwd) {
        this.pwd = pwd;
    }
    
    public String getRdate() {
        return rdate;
    }
    
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    
    

}
