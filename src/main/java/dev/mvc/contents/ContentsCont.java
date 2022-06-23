package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cate.CateProcInter;
import dev.mvc.cate.CateVO;
import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.reply.ReplyMemberVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;
import dev.mvc.you.YouVO;

@Controller
public class ContentsCont {
    @Autowired
    @Qualifier("dev.mvc.categrp.CategrpProc")
    private CategrpProcInter categrpProc;

    @Autowired
    @Qualifier("dev.mvc.cate.CateProc")
    private CateProcInter cateProc;
    
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter memberProc;

    @Autowired
    @Qualifier("dev.mvc.contents.ContentsProc")
    private ContentsProcInter contentsProc;

    public ContentsCont() {
        System.out.println("-> ContentsCont created.");
    }

    /**
     * 새로고침 방지
     * 
     * @return
     */
    @RequestMapping(value = "/contents/msg.do", method = RequestMethod.GET)
    public ModelAndView msg(String url) {
        ModelAndView mav = new ModelAndView();

        mav.setViewName(url); // forward

        return mav; // forward
    }

    /**
     * 등록폼 http://localhost:9091/contents/create.do
     * http://localhost:9091/contents/create.do?cateno=1 FK 값 명시
     * 
     * @return
     */
    @RequestMapping(value = "/contents/create.do", method = RequestMethod.GET)
    public ModelAndView create(int cateno) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/contents/create"); // /webapp/WEB-INF/views/contents/create.jsp

        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

//      CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
//      mav.addObject("categrpVO", categrpVO);
//      
        return mav;
    }

    /**
     * 등록 처리 http://localhost:9091/contents/create.do
     * 
     * @return
     */
    @RequestMapping(value = "/contents/create.do", method = RequestMethod.POST)
    public ModelAndView create(HttpServletRequest request, 
                               HttpServletResponse response, 
                               HttpSession session,
                               int memberno, String mname, ContentsVO contentsVO) {
        ModelAndView mav = new ModelAndView();

        // ------------------------------------------------------------------------------
        // 파일 전송 코드 시작
        // ------------------------------------------------------------------------------
        String file1 = ""; // 원본 파일명 image
        String file1saved = ""; // 저장된 파일명, image
        String thumb1 = ""; // preview image

        // 기준 경로 확인
        String user_dir = System.getProperty("user.dir"); // 시스템 제공
        // System.out.println("-> User dir: " + user_dir);
        // --> User dir: C:\kd\ws_java\resort_v1sbm3c

        // 파일 접근임으로 절대 경로 지정, static 폴더 지정
        // 완성된 경로
        // C:/kd1/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage
        String upDir = user_dir + "/src/main/resources/static/contents/storage/"; // 절대 경로
        // System.out.println("-> upDir: " + upDir);

        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF'
        // value='' placeholder="파일 선택">
        MultipartFile mf = contentsVO.getFile1MF();

        file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
        // System.out.println("-> file1: " + file1);

        long size1 = mf.getSize(); // 파일 크기

        if (size1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
            file1saved = Upload.saveFileSpring(mf, upDir);

            if (Tool.isImage(file1saved)) { // 이미지인지 검사
                // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
                thumb1 = Tool.preview(upDir, file1saved, 200, 150); // 저장 폴더, 저장된 파일명, width, height
            }

        }

        contentsVO.setFile1(file1);
        contentsVO.setFile1saved(file1saved);
        contentsVO.setThumb1(thumb1);
        contentsVO.setSize1(size1);
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 종료
        // ------------------------------------------------------------------------------

        // Call By Reference: 메모리 공유, Hashcode 전달
        int cnt = this.contentsProc.create(contentsVO);

        // ------------------------------------------------------------------------------
        // PK의 return
        // ------------------------------------------------------------------------------
        System.out.println("--> contentsno: " + contentsVO.getContentsno());
        mav.addObject("contentsno", contentsVO.getContentsno()); // redirect parameter 적용
        // ------------------------------------------------------------------------------

        // MemberVO memberVO = memberProc.readById(id); // 로그인한 회원의 정보 조회
        session.setAttribute("memberno", memberno);
        session.setAttribute("mname", mname);
        
        mav.addObject("mname", mname);
        
//        System.out.println("memberno " + memberVO.getMemberno());
        
        if (cnt == 1) {
            mav.addObject("code", "create_success");
            // cateProc.increaseCnt(contentsVO.getCateno()); // 글수 증가
        } else {
            mav.addObject("code", "create_fail");
        }
        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

        // System.out.println("--> cateno: " + contentsVO.getCateno());
        // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
        mav.addObject("cateno", contentsVO.getCateno()); // redirect parameter 적용
//        mav.addObject("memberno", contentsVO.getMemberno());
        // mav.addObject("url", "/contents/msg"); // msg.jsp, redirect parameter 적용

        mav.setViewName("redirect:/contents/read.do"); // GET 방식 호출, 전달되는 데이터도 URL에 결합됨.

        return mav; // forward
    }
    
    /**
     * 등록폼 http://localhost:9091/contents/create.do
     * http://localhost:9091/contents/create.do?cateno=1 FK 값 명시
     * 
     * @return
     */
    @RequestMapping(value = "/contents/notice_create.do", method = RequestMethod.GET)
    public ModelAndView notice_create(int cateno) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/contents/notice_create"); // /webapp/WEB-INF/views/contents/create.jsp

        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        return mav;
    }
    
    /**
     * 등록 처리 http://localhost:9091/contents/notice_create.do?cateno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/notice_create.do", method = RequestMethod.POST)
    public ModelAndView notice_create(HttpServletRequest request, 
                               HttpServletResponse response, 
                               HttpSession session,
                               int memberno, String mname, ContentsVO contentsVO) {
        ModelAndView mav = new ModelAndView();

        // ------------------------------------------------------------------------------
        // 파일 전송 코드 시작
        // ------------------------------------------------------------------------------
        String file1 = ""; // 원본 파일명 image
        String file1saved = ""; // 저장된 파일명, image
        String thumb1 = ""; // preview image

        // 기준 경로 확인
        String user_dir = System.getProperty("user.dir"); // 시스템 제공
        // System.out.println("-> User dir: " + user_dir);
        // --> User dir: C:\kd\ws_java\resort_v1sbm3c

        // 파일 접근임으로 절대 경로 지정, static 폴더 지정
        // 완성된 경로
        // C:/kd1/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage
        String upDir = user_dir + "/src/main/resources/static/contents/storage/"; // 절대 경로
        // System.out.println("-> upDir: " + upDir);

        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF'
        // value='' placeholder="파일 선택">
        MultipartFile mf = contentsVO.getFile1MF();

        file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
        // System.out.println("-> file1: " + file1);

        long size1 = mf.getSize(); // 파일 크기

        if (size1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
            file1saved = Upload.saveFileSpring(mf, upDir);

            if (Tool.isImage(file1saved)) { // 이미지인지 검사
                // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
                thumb1 = Tool.preview(upDir, file1saved, 200, 150); // 저장 폴더, 저장된 파일명, width, height
            }

        }

        contentsVO.setFile1(file1);
        contentsVO.setFile1saved(file1saved);
        contentsVO.setThumb1(thumb1);
        contentsVO.setSize1(size1);
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 종료
        // ------------------------------------------------------------------------------

        // Call By Reference: 메모리 공유, Hashcode 전달
        this.contentsProc.create(contentsVO);

        // ------------------------------------------------------------------------------
        // PK의 return
        // ------------------------------------------------------------------------------
        System.out.println("--> contentsno: " + contentsVO.getContentsno());
        mav.addObject("contentsno", contentsVO.getContentsno()); // redirect parameter 적용
        // ------------------------------------------------------------------------------

        // MemberVO memberVO = memberProc.readById(id); // 로그인한 회원의 정보 조회
        session.setAttribute("memberno", memberno);
        session.setAttribute("mname", mname);
        
        mav.addObject("mname", mname);

        // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
        mav.addObject("cateno", contentsVO.getCateno()); // redirect parameter 적용

        mav.setViewName("redirect:/contents/notice_by_cateno.do"); // GET 방식 호출, 전달되는 데이터도 URL에 결합됨.
        
        return mav; // forward
    }
    
    /**
     * 공지사항 목록 + 검색 + 페이징 지원
     * http://localhost:9090/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/notice_by_cateno.do", method = RequestMethod.GET)
    public ModelAndView notice_by_cateno(
            @RequestParam(value = "cateno", defaultValue = "1") int cateno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("word", word.toUpperCase()); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<ContentsVO> list = contentsProc.notice_by_cateno_search_paging(map);
      mav.addObject("list", list);
      

      // 검색된 레코드 갯수
      int search_count = contentsProc.search_count(map);
      mav.addObject("search_count", search_count);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = contentsProc.notice_pagingBox(cateno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      mav.addObject("word", word);
      

      // /contents/list_by_cateno_table_img1_search_paging.jsp
      mav.setViewName("/contents/notice_by_cateno");

      return mav;
    }
    
    /**
     * 등록폼 http://localhost:9091/contents/tip_create.do
     * http://localhost:9091/contents/tip_create.do?cateno=2 FK 값 명시
     * 
     * @return
     */
    @RequestMapping(value = "/contents/tip_create.do", method = RequestMethod.GET)
    public ModelAndView tip_create(int cateno) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/contents/tip_create"); // /webapp/WEB-INF/views/contents/create.jsp

        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        return mav;
    }
    
    /**
     * 등록 처리 http://localhost:9091/contents/notice_create.do?cateno=2
     * 
     * @return
     */
    @RequestMapping(value = "/contents/tip_create.do", method = RequestMethod.POST)
    public ModelAndView tip_create(HttpServletRequest request, 
                               HttpServletResponse response, 
                               HttpSession session,
                               int memberno, String mname, ContentsVO contentsVO) {
        ModelAndView mav = new ModelAndView();

        // ------------------------------------------------------------------------------
        // 파일 전송 코드 시작
        // ------------------------------------------------------------------------------
        String file1 = ""; // 원본 파일명 image
        String file1saved = ""; // 저장된 파일명, image
        String thumb1 = ""; // preview image

        // 기준 경로 확인
        String user_dir = System.getProperty("user.dir"); // 시스템 제공
        // System.out.println("-> User dir: " + user_dir);
        // --> User dir: C:\kd\ws_java\resort_v1sbm3c

        // 파일 접근임으로 절대 경로 지정, static 폴더 지정
        // 완성된 경로
        // C:/kd1/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage
        String upDir = user_dir + "/src/main/resources/static/contents/storage/"; // 절대 경로
        // System.out.println("-> upDir: " + upDir);

        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF'
        // value='' placeholder="파일 선택">
        MultipartFile mf = contentsVO.getFile1MF();

        file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
        // System.out.println("-> file1: " + file1);

        long size1 = mf.getSize(); // 파일 크기

        if (size1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
            file1saved = Upload.saveFileSpring(mf, upDir);

            if (Tool.isImage(file1saved)) { // 이미지인지 검사
                // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
                thumb1 = Tool.preview(upDir, file1saved, 200, 150); // 저장 폴더, 저장된 파일명, width, height
            }

        }

        contentsVO.setFile1(file1);
        contentsVO.setFile1saved(file1saved);
        contentsVO.setThumb1(thumb1);
        contentsVO.setSize1(size1);
        // ------------------------------------------------------------------------------
        // 파일 전송 코드 종료
        // ------------------------------------------------------------------------------

        // Call By Reference: 메모리 공유, Hashcode 전달
        this.contentsProc.create(contentsVO);

        // ------------------------------------------------------------------------------
        // PK의 return
        // ------------------------------------------------------------------------------
        System.out.println("--> contentsno: " + contentsVO.getContentsno());
        mav.addObject("contentsno", contentsVO.getContentsno()); // redirect parameter 적용
        // ------------------------------------------------------------------------------

        // MemberVO memberVO = memberProc.readById(id); // 로그인한 회원의 정보 조회
        session.setAttribute("memberno", memberno);
        session.setAttribute("mname", mname);
        
        mav.addObject("mname", mname);

        // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
        mav.addObject("cateno", contentsVO.getCateno()); // redirect parameter 적용

        mav.setViewName("redirect:/contents/tip_by_cateno.do"); // GET 방식 호출, 전달되는 데이터도 URL에 결합됨.
        
        return mav; // forward
    }
    
    /**
     * 공지사항 목록 + 검색 + 페이징 지원
     * http://localhost:9090/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/tip_by_cateno.do", method = RequestMethod.GET)
    public ModelAndView tip_by_cateno(
            @RequestParam(value = "cateno", defaultValue = "2") int cateno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("word", word.toUpperCase()); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<ContentsVO> list = contentsProc.tip_by_cateno_search_paging(map);
      mav.addObject("list", list);
      

      // 검색된 레코드 갯수
      int search_count = contentsProc.search_count(map);
      mav.addObject("search_count", search_count);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = contentsProc.tip_pagingBox(cateno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      mav.addObject("word", word);

      // /contents/list_by_cateno_table_img1_search_paging.jsp
      mav.setViewName("/contents/tip_by_cateno");

      return mav;
    }

    /**
     * 상품 정보 수정 폼 사전 준비된 레코드: 관리자 1번, cateno 1번, categrpno 1번을 사용하는 경우 테스트 URL
     * http://localhost:9091/contents/create.do?cateno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/product_update.do", method = RequestMethod.GET)
    public ModelAndView product_update(int cateno, int contentsno) {
        ModelAndView mav = new ModelAndView();

        CateVO cateVO = this.cateProc.read(cateno);
        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        ContentsVO contentsVO = this.contentsProc.read(contentsno);

        mav.addObject("cateVO", cateVO);
        mav.addObject("categrpVO", categrpVO);
        mav.addObject("contentsVO", contentsVO);

        mav.setViewName("/contents/product_update"); // /views/contents/product_update.jsp
        // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
        // mav.addObject("content", content);

        return mav; // forward
    }

    /**
     * 상품 정보 수정 처리 http://localhost:9091/contents/product_update.do
     * 
     * @return
     */
    @RequestMapping(value = "/contents/product_update.do", method = RequestMethod.POST)
    public ModelAndView product_update(ContentsVO contentsVO) {
        ModelAndView mav = new ModelAndView();

        // Call By Reference: 메모리 공유, Hashcode 전달
        int cnt = this.contentsProc.product_update(contentsVO);

        mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
        mav.addObject("cateno", contentsVO.getCateno()); // redirect parameter 적용

        // 연속 입력 지원용 변수, Call By Reference에 기반하여 contentsno를 전달 받음
        mav.addObject("contentsno", contentsVO.getContentsno());

        mav.addObject("url", "/contents/msg"); // msg.jsp

        if (cnt == 1) {
            mav.addObject("code", "product_success");
        } else {
            mav.addObject("code", "product_fail");
        }

        mav.setViewName("redirect:/contents/msg.do");

        return mav; // forward
    }

    /**
     * 카테고리별 목록 http://localhost:9091/contents/list_by_cateno.do?cateno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/list_by_cateno.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno(int cateno) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/contents/list_by_cateno");

        // 테이블 이미지 기반, /webapp/contents/list_by_cateno.jsp
        mav.setViewName("/contents/list_by_cateno");

        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        List<ContentsVO> list = this.contentsProc.list_by_cateno(cateno);
        mav.addObject("list", list);

        return mav; // forward
    }
    

    // http://localhost:9091/contents/read.do?contentsno=3
    /**
     * 조회
     * 
     * @return
     */
//    @RequestMapping(value = "/contents/read.do", method = RequestMethod.GET)
//    public ModelAndView read(int contentsno,
//                             @RequestParam(value = "now_page", defaultValue = "1") int now_page,
//                             HttpSession session, String id) {
//        ModelAndView mav = new ModelAndView();
//
//        contentsProc.cnt(contentsno);
//        
//        ContentsVO contentsVO = this.contentsProc.read(contentsno);
//        mav.addObject("contentsVO", contentsVO); // request.setAttribute("contentsVO", contentsVO);
//
//        CateVO cateVO = this.cateProc.read(contentsVO.getCateno());
//        mav.addObject("cateVO", cateVO);
//        
//        session.setAttribute("id", id);
//
//        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
//        mav.addObject("categrpVO", categrpVO);
//        mav.addObject("now_page", now_page);
//
//        mav.setViewName("/contents/read"); // /WEB-INF/views/contents/read.jsp
//
//        return mav;
//    }
    
    
 // http://localhost:9091/contents/read.do
    /**
     * 조회
     * @return
     */
    @RequestMapping(value="/contents/read.do", method=RequestMethod.GET )
    public ModelAndView read_ajax(HttpServletRequest request, int contentsno, HttpSession session) {
      // public ModelAndView read(int contentsno, int now_page) {
      // System.out.println("-> now_page: " + now_page);
      
      ModelAndView mav = new ModelAndView();
      
      int memberno = 0;
      
      if(session.getAttribute("memberno") == null) {
          memberno = 99999999;
      } else {
          memberno = (int)session.getAttribute("memberno");
      }
          
      HashMap <String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("contentsno", contentsno);
      hashMap.put("memberno", memberno); 
      
      contentsProc.cnt(contentsno);    
      
      Liketo_ContentsVO liketo_contentsVO = this.contentsProc.read_like_join(hashMap);
      mav.addObject("liketo_contentsVO", liketo_contentsVO); // request.setAttribute("list", list);

      ContentsVO contentsVO = this.contentsProc.read(contentsno);
      mav.addObject("contentsVO", contentsVO); // request.setAttribute("contentsVO", contentsVO);

      CateVO cateVO = this.cateProc.read(contentsVO.getCateno());
      mav.addObject("cateVO", cateVO); 

      CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);
      
      this.contentsProc.update_replycnt(contentsVO);
      
     
      // 단순 read
      // mav.setViewName("/contents/read"); // /WEB-INF/views/contents/read.jsp
      
      // 쇼핑 기능 추가
      // mav.setViewName("/contents/read_cookie"); // /WEB-INF/views/contents/read_cookie.jsp
      
      // 댓글 기능 추가 
      // mav.setViewName("/contents/read_cookie_reply"); // /WEB-INF/views/contents/read_cookie_reply.jsp
      
      // 댓글 + 더보기 버튼 기능 추가 
      mav.setViewName("/contents/read_cookie_reply_add"); // /WEB-INF/views/contents/read_cookie_reply_add.jsp
      
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
     * Concert + ConcertCate join, 연결 목록
     * http://localhost:9091/concertcate/list_all_join.do 
     * @return
     */
    @RequestMapping(value = "/contents/list_all_join.do", method=RequestMethod.GET)
    public ModelAndView list_all_join(
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page            
            ) {
        ModelAndView mav = new ModelAndView();
        
        HashMap<String, Object> map = new HashMap<String, Object>();        
        map.put("word", word.toUpperCase()); // #{word}
        map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용
        
        // 검색된 레코드 갯수
        int search_count = contentsProc.search_count2(map);
        mav.addObject("search_count", search_count);
        
        List<ContentsVO>list = this.contentsProc.list_all_join(map);
        mav.addObject("list", list); // request.setAttribute("list", list);
                      
        
        
        /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
        String paging = contentsProc.pagingBox2(search_count, now_page, word);
        System.out.println("-> paging: " + paging);
        mav.addObject("paging", paging);
    
        mav.addObject("now_page", now_page);
        mav.addObject("word", word);
        
        mav.setViewName("/contents/list_all_join"); // /WEB-INF/views/concertcate/list_all_join.jsp
        return mav;
    }
    

    /**
     * 목록 + 검색 + 페이징 지원
     * http://localhost:9090/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/list_by_cateno_search_paging.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno_search_paging(
            @RequestParam(value = "cateno", defaultValue = "1") int cateno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("word", word.toUpperCase()); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<ContentsVO> list = contentsProc.list_by_cateno_search_paging(map);
      mav.addObject("list", list);
      

      // 검색된 레코드 갯수
      int search_count = contentsProc.search_count(map);
      mav.addObject("search_count", search_count);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = contentsProc.pagingBox(cateno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      mav.addObject("word", word);

      // /contents/list_by_cateno_table_img1_search_paging.jsp
      mav.setViewName("/contents/list_by_cateno_search_paging");

      return mav;
    }
    
//    /**
//     * 목록 + 검색 + 페이징 지원
//     * http://localhost:9090/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
//     * 
//     * @param cateno
//     * @param word
//     * @param now_page
//     * @return
//     */
//    @RequestMapping(value = "/contents/index_contents.do", method = RequestMethod.GET)
//    public ModelAndView index_contents(
//            @RequestParam(value = "cateno", defaultValue = "1") int cateno,                                                                           
//            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
//            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
//            HttpSession session) {
//      System.out.println("--> now_page: " + now_page);
//
//      ModelAndView mav = new ModelAndView();
//
//      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
//      HashMap<String, Object> map = new HashMap<String, Object>();
//      map.put("cateno", cateno); // #{cateno}
//      map.put("word", word); // #{word}
//      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용
//
//      // 검색 목록
//      List<ContentsVO> list = contentsProc.list_by_cateno_search_paging(map);
//      mav.addObject("list", list);
//
//      // 검색된 레코드 갯수
//      int search_count = contentsProc.search_count(map);
//      mav.addObject("search_count", search_count);
//
//      CateVO cateVO = cateProc.read(cateno);
//      mav.addObject("cateVO", cateVO);
//
//      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
//      mav.addObject("categrpVO", categrpVO);
//
//      /*
//       * SPAN태그를 이용한 박스 모델의 지원
//       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
//       * 18 19 20 [다음]
//       * @param cateno 카테고리번호
//       * @param search_count 검색(전체) 레코드수
//       * @param now_page 현재 페이지
//       * @param word 검색어
//       * @return 페이징용으로 생성된 HTML tag 문자열
//       */
//      String paging = contentsProc.pagingBox(cateno, search_count, now_page, word);
////      System.out.println("-> paging: " + paging);
//      mav.addObject("paging", paging);
//
//      mav.addObject("now_page", now_page);
//      
//
//      // /contents/list_by_cateno_table_img1_search_paging.jsp
//      mav.setViewName("/contents/index_contents");
//
//      return mav;
//    }

    /*    /**
             * 목록 + 검색 + 페이징 + Cookie 지원
             * http://localhost:9091/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
             * 
             * @param cateno
             * @param word
             * @param now_page
             * @return
             *//*
                * @RequestMapping(value = "/contents/list_by_cateno_search_paging.do", method =
                * RequestMethod.GET) public ModelAndView list_by_cateno_search_paging_cookie(
                * 
                * @RequestParam(value = "cateno", defaultValue = "1") int cateno,
                * 
                * @RequestParam(value = "word", defaultValue = "") String word,
                * 
                * @RequestParam(value = "now_page", defaultValue = "1") int now_page,
                * HttpServletRequest request) {
                * System.out.println("-> list_by_cateno_search_paging now_page: " + now_page);
                * 
                * ModelAndView mav = new ModelAndView();
                * 
                * // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용 HashMap<String, Object> map = new
                * HashMap<String, Object>(); map.put("cateno", cateno); // #{cateno}
                * map.put("word", word); // #{word} map.put("now_page", now_page); // 페이지에 출력할
                * 레코드의 범위를 산출하기위해 사용
                * 
                * // 검색 목록 List<ContentsVO> list =
                * contentsProc.list_by_cateno_search_paging(map); mav.addObject("list", list);
                * 
                * // 검색된 레코드 갯수 int search_count = contentsProc.search_count(map);
                * mav.addObject("search_count", search_count);
                * 
                * CateVO cateVO = cateProc.read(cateno); mav.addObject("cateVO", cateVO);
                * 
                * CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
                * mav.addObject("categrpVO", categrpVO);
                * 
                * 
                * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
                * 18 19 20 [다음]
                * 
                * @param cateno 카테고리번호
                * 
                * @param search_count 검색(전체) 레코드수
                * 
                * @param now_page 현재 페이지
                * 
                * @param word 검색어
                * 
                * @return 페이징 생성 문자열
                * 
                * String paging = contentsProc.pagingBox(cateno, search_count, now_page, word);
                * 
                * mav.addObject("paging", paging);
                * 
                * mav.addObject("now_page", now_page);
                * 
                * // /views/contents/list_by_cateno_search_paging_cookie.jsp //
                * mav.setViewName("/contents/list_by_cateno_search_paging_cookie");
                * mav.setViewName("/contents/list_by_cateno_search_paging_cookie_cart");
                * 
                * //
                * -----------------------------------------------------------------------------
                * -- // 쇼핑 카트 장바구니에 상품 등록전 로그인 폼 출력 관련 쿠기 //
                * -----------------------------------------------------------------------------
                * -- Cookie[] cookies = request.getCookies(); Cookie cookie = null;
                * 
                * String ck_id = ""; // id 저장 String ck_id_save = ""; // id 저장 여부를 체크 String
                * ck_passwd = ""; // passwd 저장 String ck_passwd_save = ""; // passwd 저장 여부를 체크
                * 
                * if (cookies != null) { // Cookie 변수가 있다면 for (int i=0; i < cookies.length;
                * i++){ cookie = cookies[i]; // 쿠키 객체 추출
                * 
                * if (cookie.getName().equals("ck_id")){ ck_id = cookie.getValue(); // Cookie에
                * 저장된 id }else if(cookie.getName().equals("ck_id_save")){ ck_id_save =
                * cookie.getValue(); // Cookie에 id를 저장 할 것인지의 여부, Y, N }else if
                * (cookie.getName().equals("ck_passwd")){ ck_passwd = cookie.getValue(); //
                * Cookie에 저장된 password }else if(cookie.getName().equals("ck_passwd_save")){
                * ck_passwd_save = cookie.getValue(); // Cookie에 password를 저장 할 것인지의 여부, Y, N }
                * } }
                * 
                * System.out.println("-> ck_id: " + ck_id);
                * 
                * mav.addObject("ck_id", ck_id); mav.addObject("ck_id_save", ck_id_save);
                * mav.addObject("ck_passwd", ck_passwd); mav.addObject("ck_passwd_save",
                * ck_passwd_save); //
                * -----------------------------------------------------------------------------
                * --
                * 
                * return mav; }
                */

    /**
     * Grid 형태의 화면 구성 http://localhost:9091/contents/list_by_cateno_grid.do
     * 
     * @return
     */
    @RequestMapping(value = "/contents/list_by_cateno_grid.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno_grid(int cateno) {
        ModelAndView mav = new ModelAndView();

        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);

        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());
        mav.addObject("categrpVO", categrpVO);

        List<ContentsVO> list = this.contentsProc.list_by_cateno(cateno);
        mav.addObject("list", list);

        // mav.addObject("now_page", now_page);

        // 테이블 이미지 기반, /webapp/contents/list_by_cateno_grid.jsp
        mav.setViewName("/contents/list_by_cateno_grid");

        return mav; // forward
    }

    /**
     * 수정 폼 http://localhost:9091/contents/update_text.do?contentsno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/update_text.do", method = RequestMethod.GET)
    public ModelAndView update_text(int contentsno) {
        ModelAndView mav = new ModelAndView();

        ContentsVO contentsVO = this.contentsProc.update_read(contentsno);
        CateVO cateVO = this.cateProc.read(contentsVO.getCateno());
        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());

        mav.addObject("contentsVO", contentsVO);
        mav.addObject("cateVO", cateVO);
        mav.addObject("categrpVO", categrpVO);

        mav.setViewName("/contents/update_text"); // /WEB-INF/views/contents/update_text.jsp
        // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
        // mav.addObject("content", content);

        return mav; // forward
    }

    /**
     * 수정 처리 http://localhost:9091/contents/update_text.do?contentsno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/update_text.do", method = RequestMethod.POST)
    public ModelAndView update_text(ContentsVO contentsVO,
            @RequestParam(value = "word_search", defaultValue = "") String word_search,
            @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
        ModelAndView mav = new ModelAndView();

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("contentsno", contentsVO.getContentsno());
        map.put("passwd", contentsVO.getPasswd());

        int cnt = 0;
        int passwd_cnt = this.contentsProc.passwd_check(map);
        if (passwd_cnt == 1) {
            cnt = this.contentsProc.update_text(contentsVO); // 수정 처리

//             System.out.println("->word_search: " + word_search);

            mav.addObject("word", word_search); // ??
            mav.addObject("now_page", now_page);
            mav.addObject("contentsno", contentsVO.getContentsno());
            mav.setViewName("redirect:/contents/read.do");
        } else {
            mav.addObject("cnt", cnt);
            mav.addObject("code", "passwd_fail");
            mav.addObject("url", "/contents/msg"); // msg.jsp, redirect parameter 적용
            mav.setViewName("redirect:/contents/msg.do");
        }

        return mav; // forward
    }

    /**
     * 파일 수정 폼 http://localhost:9091/contents/update_file.do?contentsno=1
     * 
     * @return
     */
    @RequestMapping(value = "/contents/update_file.do", method = RequestMethod.GET)
    public ModelAndView update_file(int contentsno) {
        ModelAndView mav = new ModelAndView();

        ContentsVO contentsVO = this.contentsProc.read(contentsno);
        CateVO cateVO = this.cateProc.read(contentsVO.getCateno());
        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());

        mav.addObject("contentsVO", contentsVO);
        mav.addObject("cateVO", cateVO);
        mav.addObject("categrpVO", categrpVO);
//        mav.addObject("now_page", now_page);

        mav.setViewName("/contents/update_file"); // /WEB-INF/views/contents/update_file.jsp

        return mav; // forward
    }

    /**
     * 파일 수정 처리 http://localhost:9091/contents/update_file.do
     * 
     * @return
     */
    @RequestMapping(value = "/contents/update_file.do", method = RequestMethod.POST)
    public ModelAndView update_file(HttpServletRequest request, ContentsVO contentsVO) {
        ModelAndView mav = new ModelAndView();

        // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
        ContentsVO contentsVO_old = contentsProc.read(contentsVO.getContentsno());

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("contentsno", contentsVO.getContentsno());
        map.put("passwd", contentsVO.getPasswd());

        int cnt = 0;
        int passwd_cnt = this.contentsProc.passwd_check(map);
        if (passwd_cnt == 1) { // 패스워드 일치 -> 등록된 파일 삭제 -> 신규 파일 등록
            // -------------------------------------------------------------------
            // 파일 삭제 코드 시작
            // -------------------------------------------------------------------
//             System.out.println("contentsno: " + vo.getContentsno());
//             System.out.println("file1: " + vo.getFile1());

            String file1saved = contentsVO_old.getFile1saved(); // 실제 저장된 파일명
            String thumb1 = contentsVO_old.getThumb1(); // 실제 저장된 preview 이미지 파일명
            long size1 = 0;
            boolean sw = false;

            // 완성된 경로
            // c:/kd/ws_frame/resort_v1sbm3c/src/main/resources/static/contents/storage/
            String upDir = System.getProperty("user.dir") + "/src/main/resources/static/contents/storage/"; // 절대 경로

            sw = Tool.deleteFile(upDir, file1saved); // Folder에서 1건의 파일 삭제
            sw = Tool.deleteFile(upDir, thumb1); // Folder에서 1건의 파일 삭제
            // System.out.println("sw: " + sw);
            // -------------------------------------------------------------------
            // 파일 삭제 종료 시작
            // -------------------------------------------------------------------

            // -------------------------------------------------------------------
            // 파일 전송 코드 시작
            // -------------------------------------------------------------------
            String file1 = ""; // 원본 파일명 image

            // 완성된 경로
            // F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/contents/storage/
            // String upDir = System.getProperty("user.dir") +
            // "/src/main/resources/static/contents/storage/"; // 절대 경로

            // 전송 파일이 없어도 fnamesMF 객체가 생성됨.
            // <input type='file' class="form-control" name='file1MF' id='file1MF'
            // value='' placeholder="파일 선택">
            MultipartFile mf = contentsVO.getFile1MF();

            file1 = mf.getOriginalFilename(); // 원본 파일명
            size1 = mf.getSize(); // 파일 크기

            if (size1 > 0) { // 파일 크기 체크
                // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
                file1saved = Upload.saveFileSpring(mf, upDir);

                if (Tool.isImage(file1saved)) { // 이미지인지 검사
                    // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
                    thumb1 = Tool.preview(upDir, file1saved, 250, 200);
                }

            } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
                file1 = "";
                file1saved = "";
                thumb1 = "";
                size1 = 0;
            }

            contentsVO.setFile1(file1);
            contentsVO.setFile1saved(file1saved);
            contentsVO.setThumb1(thumb1);
            contentsVO.setSize1(size1);
            // -------------------------------------------------------------------
            // 파일 전송 코드 종료
            // -------------------------------------------------------------------

            // Call By Reference: 메모리 공유, Hashcode 전달
            cnt = this.contentsProc.update_file(contentsVO);
            System.out.println("-> cnt: " + cnt);

            mav.addObject("contentsno", contentsVO.getContentsno());
            mav.setViewName("redirect:/contents/read.do");

        } else { // 패스워드 오류
            mav.addObject("cnt", cnt);
            mav.addObject("code", "passwd_fail");
            mav.addObject("url", "/contents/msg"); // msg.jsp, redirect parameter 적용
            mav.setViewName("redirect:/contents/msg.do");
        }

        /*
         * mav.addObject("word", word); mav.addObject("now_page", now_page);
         */
        mav.addObject("cateno", contentsVO_old.getCateno());
        System.out.println("-> cateno: " + contentsVO_old.getCateno());

        return mav; // forward
    }

    /**
     * 삭제 폼
     * 
     * @param contentsno
     * @return
     */
    @RequestMapping(value = "/contents/delete.do", method = RequestMethod.GET)
    public ModelAndView delete(int contentsno) {
        ModelAndView mav = new ModelAndView();

        // 삭제할 정보를 조회하여 확인
        ContentsVO contentsVO = this.contentsProc.read(contentsno);
        CateVO cateVO = this.cateProc.read(contentsVO.getCateno());
        CategrpVO categrpVO = this.categrpProc.read(cateVO.getCategrpno());

        mav.addObject("contentsVO", contentsVO);
        mav.addObject("cateVO", cateVO);
        mav.addObject("categrpVO", categrpVO);

        mav.setViewName("/contents/delete"); // contents/delete.jsp

        return mav;
    }

    /**
     * 삭제 처리 http://localhost:9091/contents/delete.do
     * 
     * @return
     */
    @RequestMapping(value = "/contents/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(HttpServletRequest request, ContentsVO contentsVO, int now_page,
            @RequestParam(value = "word", defaultValue = "") String word) {
        ModelAndView mav = new ModelAndView();
        int contentsno = contentsVO.getContentsno();

        HashMap<String, Object> passwd_map = new HashMap<String, Object>();
        passwd_map.put("contentsno", contentsVO.getContentsno());
        passwd_map.put("passwd", contentsVO.getPasswd());

        int cnt = 0;
        int passwd_cnt = this.contentsProc.passwd_check(passwd_map);
        if (passwd_cnt == 1) { // 패스워드 일치 -> 등록된 파일 삭제 -> 신규 파일 등록
            // -------------------------------------------------------------------
            // 파일 삭제 코드 시작
            // -------------------------------------------------------------------
            // 삭제할 파일 정보를 읽어옴.
            ContentsVO vo = contentsProc.read(contentsno);
//             System.out.println("contentsno: " + vo.getContentsno());
//             System.out.println("file1: " + vo.getFile1());

            String file1saved = vo.getFile1saved();
            String thumb1 = vo.getThumb1();
            long size1 = 0;
            boolean sw = false;

            // 완성된 경로
            // C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/contents/storage/
            String upDir = System.getProperty("user.dir") + "/src/main/resources/static/contents/storage/"; // 절대 경로

            sw = Tool.deleteFile(upDir, file1saved); // Folder에서 1건의 파일 삭제
            sw = Tool.deleteFile(upDir, thumb1); // Folder에서 1건의 파일 삭제
            // System.out.println("sw: " + sw);
            // -------------------------------------------------------------------
            // 파일 삭제 종료 시작
            // -------------------------------------------------------------------

            cnt = this.contentsProc.delete(contentsno); // DBMS 삭제

            // -------------------------------------------------------------------------------------
            System.out.println("-> cateno: " + vo.getCateno());
            System.out.println("-> word: " + word);

            // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
            HashMap<String, Object> page_map = new HashMap<String, Object>();
            page_map.put("cateno", vo.getCateno());
            page_map.put("word", word);
            // 10번째 레코드를 삭제후
            // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
            // 페이지수를 4 -> 3으로 감소 시켜야함.
            if (contentsProc.search_count(page_map) % Contents.RECORD_PER_PAGE == 0) {
                now_page = now_page - 1;
                if (now_page < 1) {
                    now_page = 1; // 시작 페이지
                }
            }
            // -------------------------------------------------------------------------------------

            mav.addObject("now_page", now_page);
            mav.setViewName("redirect:/contents/list_by_cateno_search_paging.do"); // redirect: param.now_page

        } else { // 패스워드 오류
            mav.addObject("cnt", cnt);
            mav.addObject("code", "passwd_fail");
            mav.addObject("url", "/contents/msg"); // msg.jsp, redirect parameter 적용
            mav.setViewName("redirect:/contents/msg.do");
        }
        mav.addObject("word", word);
        mav.addObject("cateno", contentsVO.getCateno());
        System.out.println("-> cateno: " + contentsVO.getCateno());

        return mav; // forward
    }
    
    /**
     * 목록 + 검색 + 페이징 지원
     * http://localhost:9090/you/list_by_categrpno_grid_search_paging.do?categrpno=1&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/list_by_grid.do", method = RequestMethod.GET)
    public ModelAndView list_by_grid(
            @RequestParam(value = "cateno", defaultValue = "5") int cateno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{categrpno}
      map.put("word", word.toUpperCase()); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<ContentsVO> list = contentsProc.list_by_grid(map);
      mav.addObject("list", list);

      // 검색된 레코드 갯수
      int search_count = contentsProc.grid_search_count(map);
      mav.addObject("search_count", search_count);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);
      /*
       * CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
       * mav.addObject("categrpVO", categrpVO);
       */

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = contentsProc.grid_pagingBox(cateno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      
      mav.setViewName("/contents/list_by_grid");

      return mav;
    }
    
    
    /**
     * 공지사항 목록 + 검색 + 페이징 지원
     * http://localhost:9090/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/index_contents4.do", method = RequestMethod.GET)
    public ModelAndView index_contents4(
            @RequestParam(value = "cateno", defaultValue = "1") int cateno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("word", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<ContentsVO> list = contentsProc.index_contents4(map);
      mav.addObject("list", list);
      

      // 검색된 레코드 갯수
      int search_count = contentsProc.search_count(map);
      mav.addObject("search_count", search_count);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = contentsProc.notice_pagingBox(cateno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      

      // /contents/list_by_cateno_table_img1_search_paging.jsp
      mav.setViewName("/contents/index_contents4");

      return mav;
    }
    
    
    /**
     * 공지사항 목록 + 검색 + 페이징 지원
     * http://localhost:9090/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/index_contents5.do", method = RequestMethod.GET)
    public ModelAndView index_contents5(
            @RequestParam(value = "cateno", defaultValue = "2") int cateno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("word", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<ContentsVO> list = contentsProc.index_contents5(map);
      mav.addObject("list", list);
      

      // 검색된 레코드 갯수
      int search_count = contentsProc.search_count(map);
      mav.addObject("search_count", search_count);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = contentsProc.tip_pagingBox(cateno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      

      // /contents/list_by_cateno_table_img1_search_paging.jsp
      mav.setViewName("/contents/index_contents5");

      return mav;
    }

    
    /**
     * 공지사항 목록 + 검색 + 페이징 지원
     * http://localhost:9090/contents/list_by_cateno_search_paging.do?cateno=1&word=스위스&now_page=1
     * 
     * @param cateno
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/contents/index_contents7.do", method = RequestMethod.GET)
    public ModelAndView index_contents7(
            @RequestParam(value = "cateno", defaultValue = "2") int cateno,                                                                           
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page,
            HttpSession session) {
      System.out.println("--> now_page: " + now_page);

      ModelAndView mav = new ModelAndView();

      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("word", word); // #{word}
      map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

      // 검색 목록
      List<ContentsVO> list = contentsProc.index_contents7(map);
      mav.addObject("list", list);
      

      // 검색된 레코드 갯수
      int search_count = contentsProc.search_count(map);
      mav.addObject("search_count", search_count);

      CateVO cateVO = cateProc.read(cateno);
      mav.addObject("cateVO", cateVO);

      CategrpVO categrpVO = categrpProc.read(cateVO.getCategrpno());
      mav.addObject("categrpVO", categrpVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
      String paging = contentsProc.tip_pagingBox(cateno, search_count, now_page, word);
//      System.out.println("-> paging: " + paging);
      mav.addObject("paging", paging);

      mav.addObject("now_page", now_page);
      

      // /contents/list_by_cateno_table_img1_search_paging.jsp
      mav.setViewName("/contents/index_contents7");

      return mav;
    }
    
    /**
     * Concert + ConcertCate join, 연결 목록
     * http://localhost:9091/concertcate/list_all_join.do 
     * @return
     */
    @RequestMapping(value = "/contents/index_contents.do", method=RequestMethod.GET)
    public ModelAndView index_contents(
            @RequestParam(value = "word", defaultValue = "") String word,                                                                           
            @RequestParam(value = "now_page", defaultValue = "1") int now_page     
            ) {
        ModelAndView mav = new ModelAndView();
        
        HashMap<String, Object> map = new HashMap<String, Object>();        
        map.put("word", word); // #{word}
        map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용
        
        // 검색된 레코드 갯수
        int search_count = contentsProc.search_count2(map);
        mav.addObject("search_count2", search_count);
        
        List<ContentsVO>list = this.contentsProc.index_contents(map);
        mav.addObject("list", list); // request.setAttribute("list", list);
     
        /*
       * SPAN태그를 이용한 박스 모델의 지원
       * 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param cateno 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML tag 문자열
       */
        String paging = contentsProc.pagingBox2(search_count, now_page, word);
        System.out.println("-> paging: " + paging);
        mav.addObject("paging", paging);
    
        mav.addObject("now_page", now_page);
        
        mav.setViewName("/contents/index_contents"); // /WEB-INF/views/concertcate/list_all_join.jsp
        return mav;
    }
    
//    @ResponseBody
//    @RequestMapping(value = "/contents/update_recom_ajax.do", 
//                                method = RequestMethod.POST)
//    public String update_recome_ajax(int contentsno, HttpSession session) {
//        
//      int memberno = (int)session.getAttribute("memberno");                
//      
//      HashMap<String, Object> map = new HashMap<String, Object>();     
//      map.put("contentsno", contentsno);
//      map.put("memberno", memberno);
//      
//      ContentsVO contentsVO = contentsProc.read(contentsno);      
//      
//      int recom = contentsVO.getRecom();
//      
//      if(recom == 0) {
//          contentsProc.recom_check(map);
//      } else {
//          contentsProc.recom_check_cancel(map);          
//      }
//         
//      JSONObject obj = new JSONObject();
//
//      obj.put("contetnsno", contentsno);
//
//      
//      return obj.toString();
//    }
    

}