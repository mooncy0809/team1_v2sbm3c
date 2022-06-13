package dev.mvc.contents;

public class Cate_ContentsVO {
    
    /** 카테고리 이름 */
    private String r_name;
    
    
    /** 카테고리 번호 */
    private int contentsno;  
    /** 카테고리 번호 */
    private int cateno;  
    /** 제목 */
    private String title;
    /** 내용 */
    private String content;
    /** 등록일 */
    private String rdate;
    /** 조회 수 */
    private int cnt;
    
    /** 작성자 */
    private String mname;
    
    public Cate_ContentsVO() {
        
    }

    public String getR_name() {
        return r_name;
    }

    public void setR_name(String r_name) {
        this.r_name = r_name;
    }

    public int getCateno() {
        return cateno;
    }

    public void setCateno(int cateno) {
        this.cateno = cateno;
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

    public String getRdate() {
        return rdate;
    }

    public void setRdate(String rdate) {
        this.rdate = rdate;
    }

    public int getCnt() {
        return cnt;
    }

    public void setCnt(int cnt) {
        this.cnt = cnt;
    }

    public int getContentsno() {
        return contentsno;
    }

    public void setContentsno(int contentsno) {
        this.contentsno = contentsno;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }
    
    

}
