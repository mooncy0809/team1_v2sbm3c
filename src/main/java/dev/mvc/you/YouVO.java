package dev.mvc.you;

public class YouVO {
    /** 유튜브 번호 */
    private int youno;
    /**  유튜브 제목 */
    private String ytitle;
    /** 유튜브 한줄소개 */
    private String ytext;
    /** 유튜브 주소 */    
    private String url;
    /** 등록 날짜 */
    private String rdate;
    /** 카테고리 그룹 번호 */
    private int categrpno;
    /** 조회수 */
    private int cnt;
    
    public YouVO() {
        
    }
    public YouVO(int youno, String ytitle, String ytext, String url, String rdate, int categrpno, int cnt) {
        super();
        this.youno = youno;
        this.ytitle = ytitle;
        this.ytext = ytext;
        this.url = url;
        this.rdate = rdate;
        this.categrpno = categrpno;
        this.cnt = cnt;
    }

    public int getCnt() {
        return cnt;
    }
    public void setCnt(int cnt) {
        this.cnt = cnt;
    }
    /**
     * @return the youno
     */
    public int getYouno() {
        return youno;
    }
    /**
     * @param youno the youno to set
     */
    public void setYouno(int youno) {
        this.youno = youno;
    }
    /**
     * @return the ytitle
     */
    public String getYtitle() {
        return ytitle;
    }
    /**
     * @param ytitle the ytitle to set
     */
    public void setYtitle(String ytitle) {
        this.ytitle = ytitle;
    }
    /**
     * @return the you
     */
    public String getUrl() {
        return url;
    }
    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }
    /**
     * @return the rdate
     */
    public String getRdate() {
        return rdate;
    }
    /**
     * @param rdate the rdate to set
     */
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    /**
     * @return the categrpno
     */
    public int getCategrpno() {
        return categrpno;
    }
    /**
     * @param categrpno the categrpno to set
     */
    public void setCategrpno(int categrpno) {
        this.categrpno = categrpno;
    }    
    public String getYtext() {
        return ytext;
    }
    public void setYtext(String ytext) {
        this.ytext = ytext;
    }

}