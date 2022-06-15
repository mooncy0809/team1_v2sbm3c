package dev.mvc.qna_reply;

public class Qna_replyVO {
    /** 댓글 번호 */
    private int qna_replyno;
    /** 관련 글 번호 */
    private int qnano;
    /** 회원 번호 */
    private int memberno;
    /** 내용 */
    private String content;
    /** 패스워드 */
    private String passwd;
    /** 등록일 */
    private String rdate;
    
    
    public int getQna_replyno() {
        return qna_replyno;
    }
    public void setQna_replyno(int qna_replyno) {
        this.qna_replyno = qna_replyno;
    }
    public int getQnano() {
        return qnano;
    }
    public void setQnano(int qnano) {
        this.qnano = qnano;
    }
    public int getMemberno() {
        return memberno;
    }
    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getPasswd() {
        return passwd;
    }
    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }
    public String getRdate() {
        return rdate;
    }
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    
    

}
