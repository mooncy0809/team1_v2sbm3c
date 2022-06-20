package dev.mvc.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.contents.ContentsVO;
import dev.mvc.reply.ReplyMemberVO;
import dev.mvc.review.ReviewProcInter;
import dev.mvc.tool.Tool;

@Component("dev.mvc.review.ReviewProc")
public class ReviewProc implements ReviewProcInter {
    @Autowired
    private ReviewDAOInter reviewDAO;

    @Override
    public int create(ReviewVO reviewVO) {
        int cnt = this.reviewDAO.create(reviewVO);
        return cnt;
    }

    @Override
    public ReviewVO read(int reviewno) {
        ReviewVO reviewVO = this.reviewDAO.read(reviewno);
        
        String rtitle = reviewVO.getRtitle();
        String rcontent = reviewVO.getRcontent();
        
        rtitle = Tool.convertChar(rtitle); // 특수 문자 처리
        rcontent = Tool.convertChar(rcontent);
        
        reviewVO.setRtitle(rtitle);
        reviewVO.setRcontent(rcontent);
        
        long size1 = reviewVO.getSize1();
        reviewVO.setSize1_label(Tool.unit(size1));
        
        return reviewVO;
    }

    @Override
    public List<ReviewVO> list_by_productno(int productno) {
        List<ReviewVO> list = reviewDAO.list_by_productno(productno);
        
        for (ReviewVO reviewVO : list) {
            String content = reviewVO.getRcontent();

            if (content.length() > 50) { // 150 초과이면 150자만 선택
                content = content.substring(0, 50) + "...";
                reviewVO.setRcontent(content); // 줄어든 문자열 저장
            }

            String title = reviewVO.getRtitle();

            title = Tool.convertChar(title); // 특수 문자 처리
            content = Tool.convertChar(content);

            reviewVO.setRtitle(title);
            reviewVO.setRcontent(content);
        }
        
        return list;
    }
    
    @Override
    public List<ReviewMemberVO> list_by_productsno_join(int productno) {
      List<ReviewMemberVO> list = reviewDAO.list_by_productsno_join(productno);
      
      for (ReviewMemberVO reviewMemberVO : list) {
          String content = reviewMemberVO.getRcontent();

          if (content.length() > 50) { // 150 초과이면 150자만 선택
              content = content.substring(0, 50) + "...";
              reviewMemberVO.setRcontent(content); // 줄어든 문자열 저장
          }

          String title = reviewMemberVO.getRtitle();

          title = Tool.convertChar(title); // 특수 문자 처리
          content = Tool.convertChar(content);

          reviewMemberVO.setRtitle(title);
          reviewMemberVO.setRcontent(content);
      }
      
      return list;
    }
    
    @Override
    public int cnt(int reviewno) {
        int cnt = this.reviewDAO.cnt(reviewno);
        return cnt;
    }
    
    @Override
    public int delete(int reviewno) {
      int cnt = reviewDAO.delete(reviewno);
      return cnt;
    }
    
    @Override
    public List<ReviewMemberVO> list_by_productsno_join_add(int productno) {
      List<ReviewMemberVO> list = reviewDAO.list_by_productsno_join_add(productno);
      String content = "";
      
      // 특수 문자 변경
      for (ReviewMemberVO reviewMemberVO:list) {
        content = reviewMemberVO.getRcontent();
        content = Tool.convertChar(content);
        reviewMemberVO.setRcontent(content);
      }
      return list;
    }
    
    
}
