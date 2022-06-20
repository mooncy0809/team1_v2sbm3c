package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter{
    @Autowired
    private MemberDAOInter memberDAO;
   
    @Override
    public int checkID(String id) {
        int cnt = this.memberDAO.checkID(id);
        return cnt;
    }
    
    @Override
    public int create(MemberVO memberVO) {
      int cnt = this.memberDAO.create(memberVO);
      return cnt;
    }
    
    @Override
    public List<MemberVO> list() {
      List<MemberVO> list = this.memberDAO.list();
      return list;
    }
    
    @Override
    public MemberVO read(int memberno) {
      MemberVO memberVO = this.memberDAO.read(memberno);
      return memberVO;
    }

    @Override
    public MemberVO readById(String id) {
      MemberVO memberVO = this.memberDAO.readById(id);
      return memberVO;
    }
    
    @Override
    public int update(MemberVO memberVO) {
      int cnt = this.memberDAO.update(memberVO);
      return cnt;
    }
    
    @Override
    public int delete(int memberno) {
      int cnt = this.memberDAO.delete(memberno);
      return cnt;
    }
    
    @Override
    public int passwd_check(HashMap<Object, Object> map) {
      int cnt = this.memberDAO.passwd_check(map);
      return cnt;
    }

    @Override
    public int passwd_update(HashMap<Object, Object> map) {
      int cnt = this.memberDAO.passwd_update(map);
      return cnt;
    }
    
    @Override
    public int login(Map<String, Object> map) {
      int cnt = this.memberDAO.login(map);
      return cnt;
    }

    @Override
    public boolean isMember(HttpSession session){
      boolean sw = false; // 로그인하지 않은 것으로 초기화
      int grade = 99;
      
      // System.out.println("-> grade: " + session.getAttribute("grade"));
      if (session != null) {
        String id = (String)session.getAttribute("id");
        if (session.getAttribute("grade") != null) {
          grade = (int)session.getAttribute("grade");
        }
        
        if (id != null && grade <= 20){ // 관리자 + 회원
          sw = true;  // 로그인 한 경우
        }
      }
      
      return sw;
    }

    @Override
    public boolean isAdmin(HttpSession session) {
      boolean sw = false; // 로그인하지 않은 것으로 초기화
      int grade = 99;
      
      // System.out.println("-> grade: " + session.getAttribute("grade"));
      if (session != null) {
        String id = (String)session.getAttribute("id");
        if (session.getAttribute("grade") != null) {
          grade = (int)session.getAttribute("grade");
        }
        
        if (id != null && grade <= 10){ // 관리자
          sw = true;  // 로그인 한 경우
        }
      }
      
      return sw;
    }

    @Override
    public int find_id(Map<String, Object> map) {
        int cnt = this.memberDAO.find_id(map);        
        return cnt;
    }

    @Override
    public MemberVO read_id(Map<String, Object> map) {
        MemberVO memberVO = this.memberDAO.read_id(map);
        return memberVO;
    }

    @Override
    public int find_passwd_check(Map<Object, Object> map) {
        int cnt = this.memberDAO.find_passwd_check(map);
        return cnt;
    }

    @Override
    public int find_passwd(Map<Object, Object> map) {
        int cnt = this.memberDAO.find_passwd(map);
        return cnt;
    }


    
    
    
    
    
}