package dev.mvc.you;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import dev.mvc.tool.Tool;


@Component("dev.mvc.you.YouProc")
public class YouProc implements YouProcInter {

  @Autowired
  private YouDAOInter youDAO;
 
  public YouProc() {
    System.out.println("-> YouProc created");
  }
  
  @Override
  public int create(YouVO youVO) {
    int count = this.youDAO.create(youVO);
    return count;
  }
  @Override
  public List<YouVO> list_all() {
      List<YouVO> list = this.youDAO.list_all();
      
      for (YouVO youVO : list) {
          String url = youVO.getUrl();
          url = Tool.youtube(url, 95, 170); 
          youVO.setUrl(url);
      }
      
      return list;
  }
  
  @Override
  public List<YouVO> list_by_categrpno(int categrpno) {
    List<YouVO> list = this.youDAO.list_by_categrpno(categrpno);
    for (YouVO youVO : list) {
        String ytext = youVO.getYtext();

        if (ytext.length() > 150) { // 150 초과이면 150자만 선택
            ytext = ytext.substring(0, 150) + "...";
            youVO.setYtext(ytext); // 줄어든 문자열 저장
        }

        String ytitle = youVO.getYtitle();

        ytitle = Tool.convertChar(ytitle); // 특수 문자 처리
        ytext = Tool.convertChar(ytext);

        youVO.setYtitle(ytitle);
        youVO.setYtext(ytext);
        String url = youVO.getUrl();
        url = Tool.youtube(url, 100, 170); 
        youVO.setUrl(url);
    }
    return list;
  }


  @Override
  public YouVO read(int youno) {
    YouVO youVO = this.youDAO.read(youno);
    
    return youVO;
  }

  @Override
  public int update(YouVO youVO) {
    int count = this.youDAO.update(youVO);
    return count;
  }
  @Override
  public int delete(int youno) {
    int count = this.youDAO.delete(youno);
    return count;
  }
  @Override
  public int cnt(int youno) {
      int cnt = this.youDAO.cnt(youno);
      return cnt;
  }
  
  
}
