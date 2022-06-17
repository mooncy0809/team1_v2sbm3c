package dev.mvc.review;

public interface ReviewDAOInter {
    
    public int create(ReviewVO reviewVO);

    public ReviewVO read(int reviewno);
    
}
