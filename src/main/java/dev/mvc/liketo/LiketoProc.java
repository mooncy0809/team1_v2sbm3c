package dev.mvc.liketo;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.liketo.LiketoProc")
public class LiketoProc implements LiketoProcInter {
    
    @Autowired
    private LiketoDAOInter liketoDAO;

    @Override
    public int countbyLike(HashMap<String, Object> hashmap){
      int count = liketoDAO.countbyLike(hashmap);
      return count;
    }
    
    @Override
    public int create(HashMap<String, Object> hashmap){
      int count = liketoDAO.create(hashmap);
      return count;
    }
    
    @Override
    public int like_check(HashMap<String, Object> hashmap) {
      int count = liketoDAO.like_check(hashmap);
      return count;
    }

    @Override
    public int like_check_cancel(HashMap<String, Object> hashmap) {
      int count = liketoDAO.like_check_cancel(hashmap);
      return count;
    }
    
    @Override
    public LiketoVO read(HashMap<String, Object> hashmap) {
      LiketoVO liketoVO = liketoDAO.read(hashmap);
      return liketoVO;
    }

//    @Override
//    public int deletebyBoardno(int contentsno) {
//        int count = liketoDAO.deletebyBoardno(contentsno);
//        return count;
//    }
//
//    @Override
//    public int deletebyMno(int memberno) {
//        int count = liketoDAO.deletebyMno(memberno);
//        return count;
//    }
    
    

}
