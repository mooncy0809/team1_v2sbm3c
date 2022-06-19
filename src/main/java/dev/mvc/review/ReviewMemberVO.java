package dev.mvc.review;

import org.springframework.web.multipart.MultipartFile;

public class ReviewMemberVO {
    
    /** 아이디 */
    private String id = "";
    
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
    /** 조회수 */
    private int cnt;    
    /** 메인 이미지 */
    private String file1 = "";
    /** 실제 저장된 메인 이미지 */
    private String file1saved = "";
    /** 메인 이미지 preview */
    private String thumb1 = "";
    /** 메인 이미지 크기 */
    private long size1;
    /** 작성자 */
    private String mname;

    /**
     이미지 파일
     <input type='file' class="form-control" name='file1MF' id='file1MF' 
                    value='' placeholder="파일 선택">
     */
    private MultipartFile file1MF;
    
    /** 상품 번호 */
    private int productno;
    
    /**
     * 메인 이미지 크기 단위, 파일 크기 출력
     */
    private String size1_label;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

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

    public int getMemberno() {
        return memberno;
    }

    public void setMemberno(int memberno) {
        this.memberno = memberno;
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

    public int getCnt() {
        return cnt;
    }

    public void setCnt(int cnt) {
        this.cnt = cnt;
    }

    public String getFile1() {
        return file1;
    }

    public void setFile1(String file1) {
        this.file1 = file1;
    }

    public String getFile1saved() {
        return file1saved;
    }

    public void setFile1saved(String file1saved) {
        this.file1saved = file1saved;
    }

    public String getThumb1() {
        return thumb1;
    }

    public void setThumb1(String thumb1) {
        this.thumb1 = thumb1;
    }

    public long getSize1() {
        return size1;
    }

    public void setSize1(long size1) {
        this.size1 = size1;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public MultipartFile getFile1MF() {
        return file1MF;
    }

    public void setFile1MF(MultipartFile file1mf) {
        file1MF = file1mf;
    }

    public int getProductno() {
        return productno;
    }

    public void setProductno(int productno) {
        this.productno = productno;
    }

    public String getSize1_label() {
        return size1_label;
    }

    public void setSize1_label(String size1_label) {
        this.size1_label = size1_label;
    }

    
    
    
}
