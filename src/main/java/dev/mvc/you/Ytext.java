package dev.mvc.you;

import java.io.File;

public class Ytext {
    /** 페이지당 출력할 레코드 갯수 */
    public static int RECORD_PER_PAGE = 8;

    /** 블럭당 페이지 수, 하나의 블럭은 1개 이상의 페이지로 구성됨 */
    public static int PAGE_PER_BLOCK = 10;

    /** 목록 파일명 */
    public static String LIST_FILE = "list_by_categrpno_grid_search_paging.do";

    
    public static int RECORD_PER_PAGE2 = 3;
    public static String LIST_FILE2 = "index_contents2.do";
    
    public static int RECORD_PER_PAGE3 = 3;
    public static String LIST_FILE3 = "index_contents2.do";

    /*
     * // Windows, VMWare, AWS cloud 절대 경로 설정 public static synchronized String
     * getUploadDir() { String path = ""; if (File.separator.equals("\\")) { // path
     * = "C:/kd/deploy/resort_v1sbm3c/contents/storage/"; path =
     * "C:\\kd\\ws_java\\team1_v2sbm3c\\src\\main\\resources\\static\\contents\\storage\\";
     * // System.out.println("Windows 10: " + path);
     * 
     * } else { // System.out.println("Linux"); path =
     * "/home/ubuntu/deploy/resort_v1sbm3c/contents/storage/"; }
     * 
     * return path; }
     */
    
}