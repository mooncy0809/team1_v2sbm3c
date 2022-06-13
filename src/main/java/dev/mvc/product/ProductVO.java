package dev.mvc.product;

import org.springframework.web.multipart.MultipartFile;

/*
        productno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        cateno                                NUMBER(10)         NOT NULL ,
        ptitle                                 VARCHAR2(300)         NOT NULL,
        pcontent                               CLOB                  NOT NULL,
        precom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        pcnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        preplycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        ppasswd                                VARCHAR2(15)         NOT NULL,
        pword                                  VARCHAR2(300)         NULL ,
        rdate                                 DATE               NOT NULL,
        pfile1                                   VARCHAR(100)          NULL, -- 원본 파일명 이미지
        pfile1saved                            VARCHAR(100)          NULL, --저장된 파일명 이미지
        pthumb1                              VARCHAR(100)          NULL, --preview image
        psize1                                 NUMBER(10)      DEFAULT 0 NULL,  --파일사이즈
        price                                 NUMBER(10)      DEFAULT 0 NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,  
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 NUMBER(10)      DEFAULT 0 NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL, 
 */
public class ProductVO {
    /** 컨텐츠 번호 */
    private int productno;
    /** 카테고리 번호 */
    private int cateno;
    /** 제목 */
    private String ptitle = "";
    /** 내용 */
    private String pcontent = "";
    /** 추천수 */
    private int precom;
    /** 조회수 */
    private int pcnt = 0;
    /** 댓글수 */
    private int preplycnt = 0;
    /** 패스워드 */
    private String ppasswd = "";
    /** 검색어 */
    private String pword = "";
    /** 등록 날짜 */
    private String rdate = "";

    /** 메인 이미지 */
    private String pfile1 = "";
    /** 실제 저장된 메인 이미지 */
    private String pfile1saved = "";
    /** 메인 이미지 preview */
    private String pthumb1 = "";
    /** 메인 이미지 크기 */
    private long psize1;

    /** 정가 */
    private int price;
    /** 할인률 */
    private int dc;
    /** 판매가 */
    private int saleprice;
    /** 포인트 */
    private int point;
    /** 재고 수량 */
    private int salecnt;
    
    /**
     이미지 파일
     <input type='file' class="form-control" name='file1MF' id='file1MF' 
                value='' placeholder="파일 선택">
     */
    private MultipartFile pfile1MF;
    
    /** 메인 이미지 크기 단위, 파일 크기 */
    private String psize1_label = "";

    public ProductVO() { // 기본 생성자
        
    }

    public int getProductno() {
        return productno;
    }

    public void setProductno(int productno) {
        this.productno = productno;
    }

    public int getCateno() {
        return cateno;
    }

    public void setCateno(int cateno) {
        this.cateno = cateno;
    }

    public String getPtitle() {
        return ptitle;
    }

    public void setPtitle(String ptitle) {
        this.ptitle = ptitle;
    }

    public String getPcontent() {
        return pcontent;
    }

    public void setPcontent(String pcontent) {
        this.pcontent = pcontent;
    }

    public int getPrecom() {
        return precom;
    }

    public void setPrecom(int precom) {
        this.precom = precom;
    }

    public int getPcnt() {
        return pcnt;
    }

    public void setPcnt(int pcnt) {
        this.pcnt = pcnt;
    }

    public int getPreplycnt() {
        return preplycnt;
    }

    public void setPreplycnt(int preplycnt) {
        this.preplycnt = preplycnt;
    }

    public String getPpasswd() {
        return ppasswd;
    }

    public void setPpasswd(String ppasswd) {
        this.ppasswd = ppasswd;
    }

    public String getPword() {
        return pword;
    }

    public void setPword(String pword) {
        this.pword = pword;
    }

    public String getRdate() {
        return rdate;
    }

    public void setRdate(String rdate) {
        this.rdate = rdate;
    }

    public String getPfile1() {
        return pfile1;
    }

    public void setPfile1(String pfile1) {
        this.pfile1 = pfile1;
    }

    public String getPfile1saved() {
        return pfile1saved;
    }

    public void setPfile1saved(String pfile1saved) {
        this.pfile1saved = pfile1saved;
    }

    public String getPthumb1() {
        return pthumb1;
    }

    public void setPthumb1(String pthumb1) {
        this.pthumb1 = pthumb1;
    }

    public long getPsize1() {
        return psize1;
    }

    public void setPsize1(long psize1) {
        this.psize1 = psize1;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getDc() {
        return dc;
    }

    public void setDc(int dc) {
        this.dc = dc;
    }

    public int getSaleprice() {
        return saleprice;
    }

    public void setSaleprice(int saleprice) {
        this.saleprice = saleprice;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public int getSalecnt() {
        return salecnt;
    }

    public void setSalecnt(int salecnt) {
        this.salecnt = salecnt;
    }

    public MultipartFile getPfile1MF() {
        return pfile1MF;
    }

    public void setPfile1MF(MultipartFile pfile1mf) {
        pfile1MF = pfile1mf;
    }

    public String getPsize1_label() {
        return psize1_label;
    }

    public void setPsize1_label(String psize1_label) {
        this.psize1_label = psize1_label;
    }

    
    
    
}




