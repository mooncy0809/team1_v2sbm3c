package dev.mvc.qna;

public class Member_QnaVO {
    
    private int m_memberno;
    private String m_id;
    
    private int qnano;
    private String title;
    private String contetn;
    private int pwd;
    private String rdate;
    
    public Member_QnaVO() {
        
    }

    public int getM_memberno() {
        return m_memberno;
    }

    public void setM_memberno(int m_memberno) {
        this.m_memberno = m_memberno;
    }

    public String getM_id() {
        return m_id;
    }

    public void setM_id(String m_id) {
        this.m_id = m_id;
    }

    public int getQnano() {
        return qnano;
    }

    public void setQnano(int qnano) {
        this.qnano = qnano;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContetn() {
        return contetn;
    }

    public void setContetn(String contetn) {
        this.contetn = contetn;
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
