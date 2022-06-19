package dev.mvc.review;

import java.util.List;

public interface ReviewDAOInter {
    
    public int create(ReviewVO reviewVO);

    public ReviewVO read(int reviewno);
    
    public List<ReviewVO> list_by_productno(int productno);
    
}
