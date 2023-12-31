package com.ezen.spring.board.teampro.login;

import java.io.IOException;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ezen.spring.board.teampro.admin.AdminVO;
import com.ezen.spring.board.teampro.carrotmarket.CarrotVO;
import com.ezen.spring.board.teampro.login.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/fairy")
@SessionAttributes("userid")
public class FairyBoardController 
{
  @Autowired
  @Qualifier("fairyMem")
  private MemberVO memvo;
 
  
  @Autowired
  @Qualifier("fairydao")
  private FairyDAO fairydao;
  
  @GetMapping("/")
  public String index(Model model,@SessionAttribute(name = "userid", required = false)String userid)
  {
	  model.addAttribute("user",fairydao.getJoinedMem(userid));
	  return "fairy/index";
  }
  
  @GetMapping("/joinForm")
  public String joinForm(Model model,@SessionAttribute(name = "userid", required = false)String userid)
  {
	  model.addAttribute("user",fairydao.getJoinedMem(userid));
	  return "fairy/joinForm";
  }
  
  @PostMapping("/join")
  @ResponseBody 
  public Map<String, Boolean> addJoin(MemberVO mem)
  {
	  Map<String, Boolean> map = new HashMap();
	  map.put("addedJoin", fairydao.addJoin(mem));
	  return map;
	  
  }
  
  @GetMapping("/join")
  @ResponseBody 
  public Map<String, Boolean> joinCheck(MemberVO mem)
  {
	  Map<String, Boolean> map = new HashMap();
	  map.put("isDuplicateId", fairydao.joinIdCheck(mem));
	  map.put("isDuplicateEmail", fairydao.joinEmailCheck(mem));
	  return map;
  }
  
  
  @GetMapping("/login")
  public String login()
  {		
	  return "fairy/loginForm";
  }
  
  @PostMapping("/login")
  @ResponseBody
   public Map<String, Boolean> login(@RequestParam("userid") String userid, @RequestParam("pass") String pass, HttpSession session, MemberVO mem, Model model)
    {
	  
	  mem = new MemberVO();
     mem.setUserid(userid);
     mem.setPass(pass);
      boolean login = fairydao.login(mem);
   
      if(login){
        model.addAttribute("userid", mem.getUserid());
        session.setAttribute("userid", mem.getUserid());
        session.setAttribute("isAdmin", mem.getNumber());
      }
      boolean signupRequired = !fairydao.userExists(mem); 
      Map<String, Boolean> map = new HashMap<>();
      map.put("login", login);
      map.put("signupRequired", signupRequired);
      return map;
    }

  
  
  @GetMapping("/editMem/{userid}")
  public String editMember(@PathVariable String userid, Model model)
  {
	  MemberVO mem = fairydao.getJoinedMem(userid);
	  model.addAttribute("member", mem);
	  return "fairy/editMember";
  }
  
   
  @GetMapping("/logout")
  @ResponseBody
  public Map<String, Boolean> logout(SessionStatus status,HttpSession session)
  { 
	  Map<String, Boolean> map = new HashMap<>();
	  status.setComplete();
	  session.invalidate();
	  map.put("logout", true);
	  return map;
  }
  @GetMapping("/mypage/{userid}")
  public String Mypage(@PathVariable String userid,Model model) {
	  
	  MemberVO vo = fairydao.getJoinedMem(userid);
	  List<AdminVO> bougth = fairydao.getBought(userid);
	  List<CarrotVO> bougthcarrot = fairydao.boughtcarrot(userid);
	  List<CarrotVO> carrot = fairydao.carrot(userid);
	  model.addAttribute("carrot",carrot);
	  model.addAttribute("bougthcarrot",bougthcarrot);
	  model.addAttribute("member",vo);
	  model.addAttribute("book",bougth);
	  return "fairy/mypage";
  }
  
  @PostMapping("state")
  @ResponseBody
  public Map<String,Boolean> State(@SessionAttribute(name = "userid", required = false)String userid,int cnum){
	  Map<String,Boolean> map = new HashMap<>();
	  map.put("Deli",fairydao.changestate(userid,cnum));
	  return map;
  }
  
  @PostMapping("trade")
  @ResponseBody
  public Map<String,Boolean> Tradecarrot(@SessionAttribute(name = "userid", required = false)String userid,
		  								@RequestParam int cnum,@RequestParam  int carrotpoint,@RequestParam String uid){
	  Map<String,Boolean> map = new HashMap<>();
	  map.put("tra",fairydao.Trade(carrotpoint,userid,cnum,uid));
	  return map;
  }
  @PostMapping("/restesc")
  @ResponseBody
  public Map<String,Boolean> restEsc(@RequestParam int fnum){
	  Map<String,Boolean> map = new HashMap<>();
	  boolean rest = fairydao.restesc(fnum);
	  map.put("restout", rest);
	  return map;
  }
  
  @GetMapping("/adminLogin")
  public String Adminlogin()
  {
     return "admin/adminLogin";
  }
 


  @PostMapping("/adminLogin")
  @ResponseBody
  public Map<String, Boolean> adminlogin(MemberVO mem, HttpSession session)
  {
      boolean adminLogin = fairydao.adminLogin(mem);
      if (adminLogin) {
         session.setAttribute("userid", mem.getUserid());
          session.setAttribute("isAdmin", true); // 관리자 권한인 경우 세션에 isAdmin 속성을 true로 저장
         }
      Map<String, Boolean> map = new HashMap<>();
      map.put("adminLogin", adminLogin);
      return map;
  }


  @GetMapping("/admin")
  public String admin()
  {
     return "admin/admin";
  }

  @PostMapping("/updateMem/{userid}")
  @ResponseBody
  public Map<String, Boolean> updateMember(@PathVariable String userid, MemberVO mem)
  {
     
     Map<String, Boolean> map = new HashMap();
     mem.setUserid(userid);
     map.put("updated", fairydao.updatedMem(mem));
     map.put("isDuplicateEmail", fairydao.joinEmailCheck(mem));
     return map;
  }



//관리자 로그아웃
  @GetMapping("/adminLogout")
  @ResponseBody
  public Map<String, Boolean> adminLogout(HttpSession session)
  {
      Map<String, Boolean> map = new HashMap<>();
      session.removeAttribute("userid");
      session.removeAttribute("isAdmin");
      map.put("logout", true);
      return map;
  }
//=====================================회원 목록============================
  @GetMapping("/memlist")
  public String getlist(Model model)
  {
      List<MemberVO> mlist = fairydao.getmemlist();
      model.addAttribute("mlist",mlist);
      return "thymeleaf/memlist";
  }
//=====================================회원 목록============================  
  
//=====================================직원 목록============================  
  @GetMapping("/emplist")
  public String emplist(Model model)
  {
      List<MemberVO> mlist = fairydao.getmemlist();
      model.addAttribute("emplist",mlist);
      return "thymeleaf/emplist";
  }
//=====================================직원 목록============================
  
//=====================================휴먼계정============================  
  @GetMapping("restmem")
  public String restmember(Model model) {
	  List<MemberVO> rlist = fairydao.restMember();
      model.addAttribute("restlist",rlist);
	  return "thymeleaf/restmem";
  }
//=====================================휴먼계정============================  
  
//=====================================직원계정삭제============================  
  @PostMapping("delemp")
  @ResponseBody
  public Map<String,Boolean> delemp(@RequestParam int fnum){
	 Map<String,Boolean> map = new HashMap<>();
	 boolean del = fairydao.Escemp(fnum);
	 map.put("del", del);
	 return map;
	  
  }
//=====================================직원계정삭제============================

//=====================================회원 탈퇴============================
  @PostMapping("/deleteMem")
  @ResponseBody
   public Map<String, Boolean> deleteMember(@RequestParam("fnum") int fnum, SessionStatus status)
  {
    boolean deleted = fairydao.deleteMember(fnum);
     Map<String, Boolean> map = new HashMap<>();
     status.setComplete();
     map.put("deleted", deleted);
     return map;
  }   
//=====================================회원 탈퇴============================
  
  
//=======================carrotpoint 계좌로 환전하는 로직=====================
  @PostMapping("/pointout")
  @ResponseBody
   public Map<String, Boolean> Transfer(@SessionAttribute(name = "userid", required = false)String userid, int carrotpoint)
  {
    boolean point = fairydao.carrotTransfer(carrotpoint,userid);
     Map<String, Boolean> map = new HashMap<>();
     map.put("point", point);
     return map;
  }   
  
  @GetMapping("/find/ID")
  public String findforID() 
  {
     return "thymeleaf/find/findforID";

  }
  
  @PostMapping("/find/ID/byPhone")
  @ResponseBody
  public Map<String, Object> findIDByNameAndPhone(@RequestParam("name") String name, @RequestParam("phone") String phone)
  {
    MemberVO mem = new MemberVO(); 
    mem.setName(name);
    mem.setPhone(phone);
    
    String userID= fairydao.findIDByNameAndPhone(mem);
    
    Map<String, Object> map = new HashMap<>();
    
    if (userID != null && !userID.isEmpty()) 
    {
         map.put("found", true);
         map.put("userID", userID);
     }else{
         map.put("found", false);
         map.put("userID", "");
     }
       
       return map;  
   }

@PostMapping("/find/ID/byEmail")
  @ResponseBody
  public Map<String, Object> findIDByNameAndEmail(@RequestParam("name") String name, @RequestParam("email") String email)
  {
    MemberVO mem = new MemberVO();
    mem.setName(name);
    mem.setEmail(email);
    
     String userID= fairydao.findIDByNameAndEmail(mem);
    
    Map<String, Object> map = new HashMap<>();
    
    if (userID != null && !userID.isEmpty()) 
    {
         map.put("found", true);
         map.put("userID", userID);
     }else{
         map.put("found", false);
         map.put("userID", "");
     }
       
       return map;  
   }
  
  @GetMapping("/findID/result/{userID}")
  public String findforIDResult(@PathVariable("userID") String userid, Model model) 
  {
     String maskedUserId = maskUserId(userid);
     model.addAttribute("userid", userid);
     model.addAttribute("userid", maskedUserId);
     return "thymeleaf/find/resultFindID";

  }
  
  // 아이디 마스킹 처리
  public String maskUserId(String userid) 
  {
       int length = userid.length();
       if (length <= 4) {
           return "**";
       } else {
           int start = (length / 2) - 1;
           return userid.substring(0, start) + "**" + userid.substring(start + 2, length);
       }
   }

  @GetMapping("/find/pass")
  public String findforPass() 
  {
     return "thymeleaf/find/findforPass";

  }

  //기본 패스워드 찾기
  @PostMapping("/find/pass/byPhone")
  @ResponseBody
  public Map<String, Object> findPassByNameAndPhone(@RequestParam("name") String name, @RequestParam("phone") String phone)
  {
    MemberVO mem = new MemberVO(); 
    mem.setName(name);
    mem.setPhone(phone);
    
    String pass= fairydao.findPassByNameAndPhone(mem);
    
    Map<String, Object> map = new HashMap<>();
    
    if (pass != null && !pass.isEmpty()) 
    {
         map.put("found", true);
         map.put("pass", pass);
     }else{
         map.put("found", false);
         map.put("pass", "");
     }
       
       return map;  
   }

@PostMapping("/find/pass/byEmail")
  @ResponseBody
  public Map<String, Object> findPassByNameAndEmail(@RequestParam("name") String name, @RequestParam("email") String email)
  {
    MemberVO mem = new MemberVO();
    mem.setName(name);
    mem.setEmail(email);
    
     String pass= fairydao.findPassByNameAndEmail(mem);
    
    Map<String, Object> map = new HashMap<>();
    
    if (pass != null && !pass.isEmpty()) 
    {
         map.put("found", true);
         map.put("pass", pass);
     }else{
         map.put("found", false);
         map.put("pass", "");
     }
       
       return map;  
   }
  
  @GetMapping("/findPass/result/{pass}")
  public String findforPassResult(@PathVariable("pass") String pass, Model model) 
  {
     String maskedPass = maskUserPass(pass);
     model.addAttribute("pass", pass);
     model.addAttribute("pass", maskedPass);
     return "thymeleaf/find/resultFindPass";

  }
  
  public String maskUserPass(String pass) 
  {
       int length = pass.length();
       if (length <= 4) {
           return "***";
       } else {
           int start = (length / 2) - 1;
           int end = start + 3; 
           if (end > length) {
               end = length;
               start = end - 3;
          
               if (start < 0)
                   start = 0;
           }
           return pass.substring(0, start) + "***" + pass.substring(end);
       }
   }

  @GetMapping("/fairybooks")
  public String recommendBook(HttpSession session, Model model, @SessionAttribute(name = "userid", required = false) String userid) 
  {
      try {
          BookRecommender_GET bookRecommender = new BookRecommender_GET();
          String recommendations = bookRecommender.getRecommendations(userid);
          session.setAttribute("recommendations", recommendations);
      } catch (IOException e) {
          e.printStackTrace();
      }

      model.addAttribute("recommendations", session.getAttribute("recommendations"));
      
      return "fairy/rec_book";
  }

}

 

