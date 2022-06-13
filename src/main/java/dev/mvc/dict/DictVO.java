package dev.mvc.dict;
/*
 *      DICTNO                                  NUMBER(38)       NULL ,
        FNAME                               VARCHAR2(40)         NULL ,
        BCLASS                              VARCHAR2(40)         NULL ,
        SCLASS                              VARCHAR2(40)         NULL ,
        FSIZE                               NUMBER(38)       NULL ,
        KCAL                                NUMBER(38)       NULL ,
        CARBO                               NUMBER(38)       NULL ,
        PROTEIN                             NUMBER(38)       NULL ,
        FAT                                 NUMBER(38)       NULL ,
        SUGAR                               NUMBER(38)       NULL ,
        SODIUM                              NUMBER(38)       NULL ,
        CNT                                 NUMBER(5)        NULL ,
        CATEGRPNO                           NUMBER(10)       NOT NULL
 */
public class DictVO {
    /** 식별번호 */
    private int dictno;
    /** 음식이름 */
    private String fname="";
    /** 대분류 */
    private String bclass="";
    /** 상세분류 */
    private String sclass="";
    /** 1회 제공량 */
    private int fsize;
    /** 에너지(kcal) */
    private int kcal;
    /** 탄수화물(g) */
    private int carbo;
    /** 단백질(g) */
    private int protein;
    /** 지방(g) */
    private int fat;
    /** 당류(g) */
    private int sugar;
    /** 나트륨(g) */
    private int sodium;
    /** 조회수 */
    private int cnt;
    /** 카테고리 그룹 번호 */
    private int categrpno;
    public int getDictno() {
        return dictno;
    }
    public void setDictno(int dictno) {
        this.dictno = dictno;
    }
    public String getFname() {
        return fname;
    }
    public void setFname(String fname) {
        this.fname = fname;
    }
    public String getBclass() {
        return bclass;
    }
    public void setBclass(String bclass) {
        this.bclass = bclass;
    }
    public String getSclass() {
        return sclass;
    }
    public void setSclass(String sclass) {
        this.sclass = sclass;
    }
    public int getFsize() {
        return fsize;
    }
    public void setFsize(int fsize) {
        this.fsize = fsize;
    }
    public int getKcal() {
        return kcal;
    }
    public void setKcal(int kcal) {
        this.kcal = kcal;
    }
    public int getCarbo() {
        return carbo;
    }
    public void setCarbo(int carbo) {
        this.carbo = carbo;
    }
    public int getProtein() {
        return protein;
    }
    public void setProtein(int protein) {
        this.protein = protein;
    }
    public int getFat() {
        return fat;
    }
    public void setFat(int fat) {
        this.fat = fat;
    }
    public int getSugar() {
        return sugar;
    }
    public void setSugar(int sugar) {
        this.sugar = sugar;
    }
    public int getSodium() {
        return sodium;
    }
    public void setSodium(int sodium) {
        this.sodium = sodium;
    }
    public int getCnt() {
        return cnt;
    }
    public void setCnt(int cnt) {
        this.cnt = cnt;
    }
    public int getCategrpno() {
        return categrpno;
    }
    public void setCategrpno(int categrpno) {
        this.categrpno = categrpno;
    }
    public DictVO() {
        
    }
}
