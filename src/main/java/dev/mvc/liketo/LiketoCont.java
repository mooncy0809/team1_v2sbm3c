package dev.mvc.liketo;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dev.mvc.contents.ContentsProcInter;
import dev.mvc.contents.ContentsVO;

@Controller
public class LiketoCont {
    
    @Autowired
    @Qualifier("dev.mvc.liketo.LiketoProc")
    private LiketoProcInter liketoProc = null;
    
    @Autowired
    @Qualifier("dev.mvc.contents.ContentsProc")
    private ContentsProcInter contentsProc = null;
    
    public LiketoCont() {
      System.out.println("-> liketoCont() created");
    }
    
    
    @ResponseBody
    @RequestMapping(value="/liketo/like.do", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
    public String like(int contentsno, HttpSession session){

      int memberno = (int)session.getAttribute("memberno");
      JSONObject obj = new JSONObject();

      ArrayList<String> msgs = new ArrayList<String>();
      HashMap <String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("contentsno", contentsno);
      hashMap.put("memberno", memberno);
      
      if(liketoProc.countbyLike(hashMap)==0){
          liketoProc.create(hashMap);
        }
      
      LiketoVO liketoVO = liketoProc.read(hashMap);          
      
      ContentsVO contentsVO = contentsProc.read(contentsno);
      int like_cnt = contentsVO.getRecom();     //게시판의 좋아요 카운트
      int like_check = 0;
      like_check = liketoVO.getLike_check();    //좋아요 체크 값
            
      if(like_check == 0) {
        msgs.add("좋아요!");
        liketoProc.like_check(hashMap);
//        like_check++;
//        like_cnt++;
        contentsProc.like_cnt_up(contentsno);   //좋아요 갯수 증가
      } else {
        msgs.add("좋아요 취소");
        liketoProc.like_check_cancel(hashMap);
//        like_check--;
//        like_cnt--;
        contentsProc.like_cnt_down(contentsno);   //좋아요 갯수 감소
      }
      obj.put("contentsno", contentsno);
      obj.put("like_check", like_check);
      obj.put("like_cnt", like_cnt);
      obj.put("memberno", memberno);
      obj.put("msg", msgs);
      
      return obj.toString();
    }

}
