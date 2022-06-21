package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cate.CateProcInter;
import dev.mvc.cate.CateVO;
import dev.mvc.cate.Categrp_CateVO;
import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ProductCont {
    // CategrpProcInter를 [구현한 CategrpProc 클래스]의 객체를 자동으로 만들어 할당
    @Autowired
    @Qualifier("dev.mvc.categrp.CategrpProc") // @Component("dev.mvc.categrp.CategrpProc")
    private CategrpProcInter categrpProc;

    @Autowired
    @Qualifier("dev.mvc.cate.CateProc") // @Component("dev.mvc.cate.CateProc")
    private CateProcInter cateProc;

    @Autowired
    @Qualifier("dev.mvc.product.ProductProc")
    private ProductProcInter productProc;

    public ProductCont() {
        System.out.println("-> ProductCont created.");
    }

    /**
     * 새로고침 방지
     * 
     * @return
     */
    @RequestMapping(value = "/product/msg.do", method = RequestMethod.GET)
    public ModelAndView msg(String url) {
        ModelAndView mav = new ModelAndView();

        mav.setViewName(url); // forward, msg.jsp

        return mav; // forward
    }

    /**
     * 등록폼 http://localhost:9091/product/create.do
     * http://localhost:9091/product/create.do?cateno=1 FK 값 명시
     * http://localhost:9091/product/create.do?cateno=4 FK 값 명시
     * 
     * @return
     */
    @RequestMapping(value = "/product/create.do", method = RequestMethod.GET)
    public ModelAndView create(int cateno) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/product/create"); // /webapp/WEB-INF/views/product/create.jsp

        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        return mav;
    }

    /**
     * 등록 처리 http://localhost:9091/product/create.do
     * 
     * @return
     */
    @RequestMapping(value = "/product/create.do", method = RequestMethod.POST)
    public ModelAndView create(HttpServletRequest request, ProductVO productVO) {
        ModelAndView mav = new ModelAndView();

        // ------------------------------------------------------------------------------
        // 파일 전송 코드 시작
        // ------------------------------------------------------------------------------
        String pfile1 = ""; // 원본 파일명 image
        String pfile1saved = ""; // 저장된 파일명, image
        String pthumb1 = ""; // preview image

        // 기준 경로 확인
        String user_dir = System.getProperty("user.dir"); // 시스템 제공
        // System.out.println("-> User dir: " + user_dir);
        // --> User dir: C:\kd1\ws_java\resort_v1sbm3c

        // 파일 접근임으로 절대 경로 지정, static 폴더 지정
        // 완성된 경로
        // C:/kd1/ws_java/resort_v1sbm3c/src/main/resources/static/product/storage
        String upDir = user_dir + "/src/main/resources/static/product/storage/"; // 절대 경로
        // System.out.println("-> upDir: " + upDir);

        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF'
        // value='' placeholder="파일 선택">
        MultipartFile mf = productVO.getPfile1MF();

        pfile1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
        // System.out.println("-> file1: " + file1);

        long psize1 = mf.getSize(); // 파일 크기

        if (psize1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
            pfile1saved = Upload.saveFileSpring(mf, upDir);

            if (Tool.isImage(pfile1saved)) { // 이미지인지 검사
                // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
                pthumb1 = Tool.preview(upDir, pfile1saved, 200, 150); // 저장 폴더, 저장된 파일명, width, height
            }

        }

        productVO.setPfile1(pfile1); // 원본 파일명
        productVO.setPfile1saved(pfile1saved); // 실제 저장된 파일명
        productVO.setPthumb1(pthumb1); // 축소 이미지
        productVO.setPsize1(psize1); // 파일 크기
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 종료
        // ------------------------------------------------------------------------------

        int cnt = this.productProc.create(productVO); // Call By Reference: 메모리 공유, Hashcode 전달

        // ------------------------------------------------------------------------------
        // 글번호 PK의 return
        // ------------------------------------------------------------------------------
        // System.out.println("--> productno: " + productVO.getProductno());
        mav.addObject("productno", productVO.getProductno()); // redirect parameter 적용
        // ------------------------------------------------------------------------------

        if (cnt == 1) {
            mav.addObject("code", "create_success");
            // cateProc.increaseCnt(productVO.getCateno()); // 글수 증가
        } else {
            mav.addObject("code", "create_fail");
        }
        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

        // System.out.println("--> cateno: " + productVO.getCateno());
        // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
        mav.addObject("cateno", productVO.getCateno()); // redirect parameter 적용
        mav.addObject("url", "/product/msg"); // msg.jsp, redirect parameter 적용

        mav.setViewName("redirect:/product/msg.do"); // GET 방식 호출, 전달되는데이터도 URL에 결합됨.

        return mav; // forward
    }

    /**
     * 상품 정보 수정 폼 사전 준비된 레코드: 관리자 1번, cateno 1번, categrpno 1번을 사용하는 경우 테스트 URL
     * http://localhost:9091/product/create.do?cateno=1
     * 
     * @param cateno     카테고리번호
     * @param productno 현재 insert한 글번호
     * @return
     */
    @RequestMapping(value = "/product/product_update.do", method = RequestMethod.GET)
    public ModelAndView product_update(int cateno, int productno) {
        ModelAndView mav = new ModelAndView();

        CateVO cateVO = this.cateProc.read(cateno);
        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        ProductVO productVO = this.productProc.read(productno);

        mav.addObject("cateVO", cateVO);
        mav.addObject("categrpVO", categrpVO);
        mav.addObject("productVO", productVO);

        mav.setViewName("/product/product_update"); // /views/product/product_update.jsp
        // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
        // mav.addObject("content", content);

        return mav; // forward
    }

    /**
     * 상품 정보 수정 처리 http://localhost:9091/product/product_update.do
     * 
     * @return
     */
    @RequestMapping(value = "/product/product_update.do", method = RequestMethod.POST)
    public ModelAndView product_update(ProductVO productVO) {
        ModelAndView mav = new ModelAndView();

        // Call By Reference: 메모리 공유, Hashcode 전달
        int cnt = this.productProc.product_update(productVO);

        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
        mav.addObject("cateno", productVO.getCateno()); // redirect parameter 적용

        // 연속 입력 지원용 변수, Call By Reference에 기반하여 productno를 전달 받음
        mav.addObject("productno", productVO.getProductno());

        mav.addObject("url", "/product/msg"); // msg.jsp

        if (cnt == 1) {
            mav.addObject("code", "product_success");
        } else {
            mav.addObject("code", "product_fail");
        }

        mav.setViewName("redirect:/product/msg.do");

        return mav; // forward
    }

    /**
     * 카테고리별 컨텐츠 목록 http://localhost:9091/product/list_by_cateno.do?cateno=1
     * 
     * @return
     */
   /* @RequestMapping(value = "/product/list_by_cateno.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno(int cateno) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/product/list_by_cateno");

        // 테이블 이미지 기반, /webapp/product/list_by_cateno.jsp
        mav.setViewName("/product/list_by_cateno");

        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        List<ProductVO> list = this.productProc.list_by_cateno(cateno);
        mav.addObject("list", list);

        return mav; // forward
    }
*/
    // http://localhost:9091/product/read.do?productno=1
    /**
     * 조회
     * 
     * @return
     */
    @RequestMapping(value = "/product/read.do", method = RequestMethod.GET)
    public ModelAndView read(int productno) {
        ModelAndView mav = new ModelAndView();

        ProductVO productVO = this.productProc.read(productno);
        mav.addObject("productVO", productVO); // request.setAttribute("productVO", productVO);

        CateVO cateVO = this.cateProc.read(productVO.getCateno());
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        mav.setViewName("/product/read"); // /WEB-INF/views/product/read.jsp

        return mav;
    }

    /**
     * 목록 + 검색 지원
     * http://localhost:9091/product/list_by_cateno_search.do?cateno=1&word=스위스
     * 
     * @param cateno
     * @param word
     * @return
     */
    @RequestMapping(value = "/product/list_by_cateno_search.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno_search(@RequestParam(value = "cateno", defaultValue = "1") int cateno,
            @RequestParam(value = "pword", defaultValue = "") String word) {

        ModelAndView mav = new ModelAndView();

        // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
        HashMap<String, Object> map = new HashMap<String, Object>(); // 키, 값
        map.put("cateno", cateno); // #{cateno}
        map.put("pword", word.toUpperCase()); // #{word}

        // 검색 목록
        List<ProductVO> list = productProc.list_by_cateno_search(map);
        mav.addObject("list", list);

        // 검색된 레코드 갯수
        int search_count = productProc.search_count(map);
        mav.addObject("search_count", search_count);

        CateVO cateVO = cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        mav.setViewName("/product/list_by_cateno_search"); // /product/list_by_cateno_search.jsp

        return mav;
    }

    /**
     * 목록 + 검색 + 페이징 + Cookie 지원
     * http://localhost:9091/product/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/product/list_by_cateno_search_paging.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno_search_paging_cookie(
        @RequestParam(value = "cateno", defaultValue = "1") int cateno,
        @RequestParam(value = "pword", defaultValue = "") String word,
        @RequestParam(value = "now_page", defaultValue = "1") int now_page,
        HttpServletRequest request) {
      // System.out.println("-> list_by_cateno_search_paging now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("pword", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<ProductVO> list = productProc.list_by_cateno_search_paging(map);
      mav.addObject("list", list);

      // 검색된 레코드 갯수
      int search_count = productProc.search_count(map);
      mav.addObject("search_count", search_count);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징 생성 문자열
       */
      String paging = productProc.pagingBox(cateno, search_count, now_page, word);
     
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);

      // /views/product/list_by_cateno_search_paging_cookie.jsp
      // mav.setViewName("/product/list_by_cateno_search_paging_cookie");
      mav.setViewName("/product/list_by_cateno_search_paging_cookie_cart");
      // -------------------------------------------------------------------------------
      // 쇼핑 카트 장바구니에 상품 등록전 로그인 폼 출력 관련 쿠기  
      // -------------------------------------------------------------------------------
      Cookie[] cookies = request.getCookies();
      Cookie cookie = null;

      String ck_id = ""; // id 저장
      String ck_id_save = ""; // id 저장 여부를 체크
      String ck_passwd = ""; // passwd 저장
      String ck_passwd_save = ""; // passwd 저장 여부를 체크

      if (cookies != null) {  // Cookie 변수가 있다면
        for (int i=0; i < cookies.length; i++){
          cookie = cookies[i]; // 쿠키 객체 추출
          
          if (cookie.getName().equals("ck_id")){
            ck_id = cookie.getValue();                                 // Cookie에 저장된 id
          }else if(cookie.getName().equals("ck_id_save")){
            ck_id_save = cookie.getValue();                          // Cookie에 id를 저장 할 것인지의 여부, Y, N
          }else if (cookie.getName().equals("ck_passwd")){
            ck_passwd = cookie.getValue();                          // Cookie에 저장된 password
          }else if(cookie.getName().equals("ck_passwd_save")){
            ck_passwd_save = cookie.getValue();                  // Cookie에 password를 저장 할 것인지의 여부, Y, N
          }
        }
      }
      
      System.out.println("-> ck_id: " + ck_id);
      
      mav.addObject("ck_id", ck_id); 
      mav.addObject("ck_id_save", ck_id_save);
      mav.addObject("ck_passwd", ck_passwd);
      mav.addObject("ck_passwd_save", ck_passwd_save);
      // -------------------------------------------------------------------------------
      
      return mav;
    }
     
    
  
    
    
    /**
     * Grid 형태의 화면 구성 http://localhost:9091/product/list_by_cateno_grid.do
     * 
     * @return
     */
    @RequestMapping(value = "/product/list_by_cateno_grid.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno_grid(@RequestParam(value = "cateno", defaultValue = "1") int cateno,
            @RequestParam(value = "pword", defaultValue = "") String word,
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("cateno", cateno); // #{cateno}
        map.put("pword", word); // #{word}
        map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

        // 검색 목록
        List<ProductVO> list = productProc.list_by_cateno(map);
        mav.addObject("list", list);

        // 검색된 레코드 갯수
        int search_count = productProc.search_count(map);
        mav.addObject("search_count", search_count);

        CateVO cateVO = cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        /*
         * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
         * 18 19 20 [다음]
         * @param cateno 카테고리번호
         * @param search_count 검색(전체) 레코드수
         * @param now_page 현재 페이지
         * @param word 검색어
         * @return 페이징 생성 문자열
         */
        String paging2 = productProc.pagingBox2(cateno, search_count, now_page, word);
       
        mav.addObject("paging2", paging2);

        mav.addObject("now_page", now_page);

      // 테이블 이미지 기반, /webapp/product/list_by_cateno_grid.jsp
      mav.setViewName("/product/list_by_cateno_grid");

      return mav; // forward
    }
    
    /**
     * 수정 폼
     * http://localhost:9091/product/update_text.do?productno=1
     * 
     * @return
     */
    @RequestMapping(value = "/product/update_text.do", method = RequestMethod.GET)
    public ModelAndView update_text(int productno) {
      ModelAndView mav = new ModelAndView();
      
      ProductVO productVO = this.productProc.read(productno);
      CateVO cateVO = this.cateProc.read(productVO.getCateno());
      CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
      
      mav.addObject("productVO", productVO);
      mav.addObject("cateVO", cateVO);
      mav.addObject("categrpVO", categrpVO);
      
      mav.setViewName("/product/update_text"); // /WEB-INF/views/product/update_text.jsp
      // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
      // mav.addObject("content", content);

      return mav; // forward
    }

    /**
     * 수정 처리
     * http://localhost:9091/product/update_text.do?productno=1
     * 
     * @return
     */
    @RequestMapping(value = "/product/update_text.do", method = RequestMethod.POST)
    public ModelAndView update_text(ProductVO productVO,
                                                    @RequestParam(value = "word_search", defaultValue = "") String word_search,
                                                    @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
      ModelAndView mav = new ModelAndView();
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("productno", productVO.getProductno());
      map.put("ppasswd", productVO.getPpasswd());
      
      int pcnt = 0;
      int passwd_cnt = this.productProc.passwd_check(map);
      if (passwd_cnt == 1) {
          pcnt = this.productProc.update_text(productVO); // 수정 처리
          //System.out.println("-> word_search: " + word_search);
          
          mav.addObject("word", word_search);
          mav.addObject("now_page", now_page);
          mav.addObject("productno", productVO.getProductno());
          mav.setViewName("redirect:/product/read.do");  //  param 접근 가능: now_page , productno         
      } else {
          mav.addObject("pcnt", pcnt);
          mav.addObject("code", "passwd_fail");
          mav.addObject("url", "/product/msg"); // msg.jsp, redirect parameter 적용
          mav.setViewName("redirect:/product/msg.do"); //  param 접근 가능: cnt , code, url
      }

      return mav; // forward
    }
    
    /**
     * 파일 수정 폼
     * http://localhost:9091/product/update_file.do?productno=1
     * 
     * @return
     */
    @RequestMapping(value = "/product/update_file.do", method = RequestMethod.GET)
    public ModelAndView update_file(int productno) {
      ModelAndView mav = new ModelAndView();
      
      ProductVO productVO = this.productProc.read(productno);
      CateVO cateVO = this.cateProc.read(productVO.getCateno());
      CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
      
      mav.addObject("productVO", productVO);
      mav.addObject("cateVO", cateVO);
      mav.addObject("categrpVO", categrpVO);
      
      mav.setViewName("/product/update_file"); // /WEB-INF/views/product/update_file.jsp

      return mav; // forward
    }

    /**
     * 파일 수정 처리 http://localhost:9091/product/update_file.do
     * 
     * @return
     */
    @RequestMapping(value = "/product/update_file.do", method = RequestMethod.POST)
    public ModelAndView update_file(HttpServletRequest request, ProductVO productVO, 
                                                      int now_page, String word) {
      ModelAndView mav = new ModelAndView();
      
      // System.out.println("-> now_page: " + now_page);
      
      // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
      ProductVO productVO_old = productProc.read(productVO.getProductno());
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("productno", productVO.getProductno());
      map.put("ppasswd", productVO.getPpasswd());
      
      int cnt = 0;
      int passwd_cnt = this.productProc.passwd_check(map);
      if (passwd_cnt == 1) { // 패스워드 일치 -> 등록된 파일 삭제 -> 신규 파일 등록
          // -------------------------------------------------------------------
          // 파일 삭제 코드 시작
          // -------------------------------------------------------------------
//          System.out.println("productno: " + vo.getproductno());
//          System.out.println("file1: " + vo.getFile1());
          
          String pfile1saved = productVO_old.getPfile1saved(); // 실제 저장된 파일명
          String pthumb1 = productVO_old.getPthumb1();       // 실제 저장된 preview 이미지 파일명
          long psize1 = 0;
          boolean sw = false;
          
          // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/product/storage/
          String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/product/storage/"; // 절대 경로

          sw = Tool.deleteFile(upDir, pfile1saved);  // Folder에서 1건의 파일 삭제
          sw = Tool.deleteFile(upDir, pthumb1);     // Folder에서 1건의 파일 삭제
          // System.out.println("sw: " + sw);
          // -------------------------------------------------------------------
          // 파일 삭제 종료 시작
          // -------------------------------------------------------------------
          
          // -------------------------------------------------------------------
          // 파일 전송 코드 시작
          // -------------------------------------------------------------------
          String pfile1 = "";          // 원본 파일명 image

          // 완성된 경로 F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/product/storage/
          // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/product/storage/"; // 절대 경로
          
          // 전송 파일이 없어도 fnamesMF 객체가 생성됨.
          // <input type='file' class="form-control" name='file1MF' id='file1MF' 
          //           value='' placeholder="파일 선택">
          MultipartFile mf = productVO.getPfile1MF();
          
          pfile1 = mf.getOriginalFilename(); // 원본 파일명
          psize1 = mf.getSize();  // 파일 크기
          
          if (psize1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
            pfile1saved = Upload.saveFileSpring(mf, upDir); 
            
            if (Tool.isImage(pfile1saved)) { // 이미지인지 검사
              // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
              pthumb1 = Tool.preview(upDir, pfile1saved, 250, 200); 
            }
            
          } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
              pfile1="";
              pfile1saved="";
              pthumb1="";
              psize1=0;
          }
          
          productVO.setPfile1(pfile1);
          productVO.setPfile1saved(pfile1saved);
          productVO.setPthumb1(pthumb1);
          productVO.setPsize1(psize1);
          // -------------------------------------------------------------------
          // 파일 전송 코드 종료
          // -------------------------------------------------------------------
          
          // Call By Reference: 메모리 공유, Hashcode 전달
          cnt = this.productProc.update_file(productVO);
          // System.out.println("-> cnt: " + cnt);
          
          System.out.println("-> word: " + word);
          mav.addObject("pword", word);
          // request.setAttribute("now_page", now_page);
          mav.addObject("now_page", now_page);
          mav.addObject("productno", productVO.getProductno());
          mav.setViewName("redirect:/product/read.do"); // request -> param으로 접근 전환
          
      } else { // 패스워드 오류
          mav.addObject("cnt", cnt);
          mav.addObject("code", "passwd_fail");
          mav.addObject("url", "/product/msg"); // msg.jsp, redirect parameter 적용
          mav.setViewName("redirect:/product/msg.do");
      }

      mav.addObject("cateno", productVO_old.getCateno());
      System.out.println("-> cateno: " + productVO_old.getCateno());
      
      return mav; // forward
    }   

    /**
     * 삭제 폼
     * @param productno
     * @return
     */
    @RequestMapping(value="/product/delete.do", method=RequestMethod.GET )
    public ModelAndView delete(int productno) { 
      ModelAndView mav = new  ModelAndView();
      
      // 삭제할 정보를 조회하여 확인
      ProductVO productVO = this.productProc.read(productno);
      CateVO cateVO = this.cateProc.read(productVO.getCateno());
      CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
      
      mav.addObject("productVO", productVO);
      mav.addObject("cateVO", cateVO);
      mav.addObject("categrpVO", categrpVO);
      
      mav.setViewName("/product/delete");  // product/delete.jsp
      
      return mav; 
    }

    /**
     * 삭제 처리 http://localhost:9091/product/delete.do
     * 
     * @return
     */
    @RequestMapping(value = "/product/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(HttpServletRequest request, ProductVO productVO, 
                                            int now_page,
                                            @RequestParam(value="pword", defaultValue="") String word) {
      ModelAndView mav = new ModelAndView();
      int productno = productVO.getProductno();
      
      HashMap<String, Object> passwd_map = new HashMap<String, Object>();
      passwd_map.put("productno", productVO.getProductno());
      passwd_map.put("ppasswd", productVO.getPpasswd());
      
      int cnt = 0;
      int passwd_cnt = this.productProc.passwd_check(passwd_map);
      if (passwd_cnt == 1) { // 패스워드 일치 -> 등록된 파일 삭제 -> 신규 파일 등록
          // -------------------------------------------------------------------
          // 파일 삭제 코드 시작
          // -------------------------------------------------------------------
          // 삭제할 파일 정보를 읽어옴.
          ProductVO vo = productProc.read(productno);
//          System.out.println("productno: " + vo.getProductno());
//          System.out.println("file1: " + vo.getFile1());
          
          String pfile1saved = vo.getPfile1saved();
          String pthumb1 = vo.getPthumb1();
          long psize1 = 0;
          boolean sw = false;
          
          // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/product/storage/
          String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/product/storage/"; // 절대 경로

          sw = Tool.deleteFile(upDir, pfile1saved);  // Folder에서 1건의 파일 삭제
          sw = Tool.deleteFile(upDir, pthumb1);     // Folder에서 1건의 파일 삭제
          // System.out.println("sw: " + sw);
          // -------------------------------------------------------------------
          // 파일 삭제 종료 시작
          // -------------------------------------------------------------------
          
          cnt = this.productProc.delete(productno); // DBMS 삭제

          // -------------------------------------------------------------------------------------
          // System.out.println("-> cateno: " + vo.getCateno());
          // System.out.println("-> word: " + word);
          
          // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
          HashMap<String, Object> page_map = new HashMap<String, Object>();
          page_map.put("cateno", vo.getCateno());
          page_map.put("pword", word);
          // 10번째 레코드를 삭제후
          // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
          // 페이지수를 4 -> 3으로 감소 시켜야함.
          if (productProc.search_count(page_map) % Product.RECORD_PER_PAGE == 0) {
            now_page = now_page - 1;
            if (now_page < 1) {
              now_page = 1; // 시작 페이지
            }
          }
          // -------------------------------------------------------------------------------------
 
          mav.addObject("now_page", now_page);
          mav.setViewName("redirect:/product/list_by_cateno_search_paging.do"); // redirect: param.now_page

      } else { // 패스워드 오류
          mav.addObject("cnt", cnt);
          mav.addObject("code", "passwd_fail");
          mav.addObject("url", "/product/msg"); // msg.jsp, redirect parameter 적용
          mav.setViewName("redirect:/product/msg.do");
      }
      mav.addObject("cateno", productVO.getCateno());
      //System.out.println("-> cateno: " + productVO.getCateno());
      
      return mav; // forward
    }   
    
    /**
     * Cate + Product join, 연결 목록
     * http://localhost:9091/product/list_by_cateno_grid_join.do 
     * @return
     */
    @RequestMapping(value="/product/list_by_cateno_grid_join.do", method=RequestMethod.GET )
    public ModelAndView list_by_cateno_grid_join() {
      ModelAndView mav = new ModelAndView();
      
      List<Cate_ProductVO> list = this.productProc.list_by_cateno_grid_join();
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/product/list_by_cateno_grid_join"); // /WEB-INF/views/cate/list_all_join.jsp
      return mav;
    }  
    
    /**
     * Grid 형태의 화면 구성 http://localhost:9091/product/list_by_cateno_grid.do
     * 
     * @return
     */
    @RequestMapping(value = "/product/list_by_cateno_grid_join2.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno_grid_join2(@RequestParam(value = "cateno", defaultValue = "1") int cateno,
            @RequestParam(value = "pword", defaultValue = "") String word,
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("cateno", cateno); // #{cateno}
        map.put("pword", word); // #{word}
        map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

        // 검색 목록
        List<Cate_ProductVO> list = productProc.list_by_cateno_grid_join2(map);
        mav.addObject("list", list);

        // 검색된 레코드 갯수
        int search_count = productProc.search_count2(map);
        mav.addObject("search_count", search_count);

        CateVO cateVO = cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        /*
         * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
         * 18 19 20 [다음]
         * @param cateno 카테고리번호
         * @param search_count 검색(전체) 레코드수
         * @param now_page 현재 페이지
         * @param word 검색어
         * @return 페이징 생성 문자열
         */
        String paging3 = productProc.pagingBox3(cateno, search_count, now_page, word);
       
        mav.addObject("paging3", paging3);

        mav.addObject("now_page", now_page);

      // 테이블 이미지 기반, /webapp/product/list_by_cateno_grid.jsp
      mav.setViewName("/product/list_by_cateno_grid_join2");

      return mav; // forward
    }

}