package dev.mvc.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.review.ReviewProcInter;

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
        return reviewVO;
    }

    @Override
    public List<ReviewVO> list_by_productno(int productno) {
        List<ReviewVO> list = reviewDAO.list_by_productno(productno);
        return list;
    } 
    
    
}
