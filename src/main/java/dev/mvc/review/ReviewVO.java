package dev.mvc.review;

public class ReviewVO {
    /** 댓글 번호 */
    private int reviewno;
    /** 주문 상세 번호 */
    private int order_itemno;
    /** 회원 번호 */
    private int memberno;
    /** 제목 */
    private String rtitle;
    /** 내용 */
    private String rcontent;
    /** 별점 */
    private int score;
    /** 등록일 */
    private String rdate;
    
    public int getReviewno() {
        return reviewno;
    }
    public void setReviewno(int reviewno) {
        this.reviewno = reviewno;
    }
    public int getOrder_itemno() {
        return order_itemno;
    }
    public void setOrder_itemno(int order_itemno) {
        this.order_itemno = order_itemno;
    }
    public String getRtitle() {
        return rtitle;
    }
    public void setRtitle(String rtitle) {
        this.rtitle = rtitle;
    }
    public String getRcontent() {
        return rcontent;
    }
    public void setRcontent(String rcontent) {
        this.rcontent = rcontent;
    }
    public int getScore() {
        return score;
    }
    public void setScore(int score) {
        this.score = score;
    }
    public String getRdate() {
        return rdate;
    }
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    public int getMemberno() {
        return memberno;
    }
    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }
    
    
    
}
