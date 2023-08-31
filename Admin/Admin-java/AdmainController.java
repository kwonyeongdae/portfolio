package com.ezen.spring.board.teampro.admin;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import com.ezen.spring.board.teampro.book.Book;
import com.ezen.spring.board.teampro.book.BookDAO;
import com.ezen.spring.board.teampro.book.Bookattach;
import com.ezen.spring.board.teampro.cart.BookVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.spring.board.teampro.login.FairyDAO;
import com.ezen.spring.board.teampro.login.MemberVO;
import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
@SessionAttributes("userid")
public class AdmainController {
	
	@Autowired
	@Qualifier("admindao")
	AdminDAO admindao;
	
	@Autowired
	@Qualifier("bookdao")
	private BookDAO dao;
	
	@Autowired
	@Qualifier("adminvo")
	AdminVO vo;

	@Autowired
    @Qualifier("fairydao")
	private FairyDAO fairydao;
	
//=================================어드민 페이지 get방식 차단용 메소드==================================	
	public Model mod(Model model,@SessionAttribute(name = "userid", required = false)String userid) {
		return model.addAttribute("user",admindao.joinmem(userid));
	}
//=================================어드민 페이지 get방식 차단용 메소드==================================	

	//=================================관리자 페이지 이동==================================	
	@GetMapping("/")
	public String get(Model model,@SessionAttribute(name = "userid", required = false)String userid) {
		mod(model,userid);
		return "admin/admin";
	}
	//=================================관리자 페이지 이동==================================
	
	//=================================관리자 회원가입 기존회원과입과 동일하지만 자동으로 숫자9입력됨==================================
	@GetMapping("/add")
	public String setadd(Model model,@SessionAttribute(name = "userid", required = false)String userid) {
		mod(model,userid);
		return "admin/Adminjoin";
	}

	@PostMapping("/add")//어드민 계정으로 로그인 하면 어드민전용 창에서 직원아이디 생성해주는 로직
	@ResponseBody
	public Map<String,Boolean> adminjoin(MemberVO vo){
		Map<String,Boolean> map = new HashMap<>();
		map.put("added", admindao.addadmin(vo));
		return map;
	}
	//=================================관리자 회원가입 기존회원과입과 동일하지만 자동으로 숫자9입력됨==================================
	
	//=================================총 판매내역 보여주는 리스트==================================
	@GetMapping("/list")
	public String getlist(Model model,@SessionAttribute(name = "userid", required = false)String userid) {
		mod(model,userid);
		List<AdminVO> alist = new ArrayList<>();
		alist = admindao.getBylist();
		model.addAttribute("alist",alist);
		return "admin/Adminlist";
	}
	
	@GetMapping("/list/data")
	public String getday(@RequestParam("category") String category,
            @RequestParam("key") String key,Model model) {
		
		List<AdminVO> daylist = new ArrayList<>();
		if (category.equals("day")) {
	        // 일별 데이터 조회를 위한 SQL 쿼리 실행
			daylist = admindao.getByDay(key);
	    } else if (category.equals("month")) {
	        // 월별 데이터 조회를 위한 SQL 쿼리 실행
	    	 String year = key.substring(0, 4);
	    	 String month = key.substring(5, 7);
	    	daylist = admindao.getByMonth(year,month);
	    } else if (category.equals("year")) {
	        // 연도별 데이터 조회를 위한 SQL 쿼리 실행
	    	daylist = admindao.getByYear(key);
	    }else if (category.equals("uid")) {
	        // 연도별 데이터 조회를 위한 SQL 쿼리 실행
	    	daylist = admindao.getById(key);
	    }
		model.addAttribute("daylist",daylist);
		return "admin/Adminlist";
	}
	//=================================총 판매내역 보여주는 리스트==================================
	
	
	@GetMapping("/adbooklist/{pn}")
	public String adbooklist(@PathVariable int pn, 
			 @RequestParam(value="category", required=false) String category, 
			 @RequestParam(value="keyword", required=false) String keyword,
			 Model model,@SessionAttribute(name = "userid", required = false)String userid)
	{
		mod(model,userid);
		PageInfo<Map> pageInfo = null;
		List<Bookattach> blist = new ArrayList<>();
		blist = admindao.getattach();
		model.addAttribute("att", blist);
		if(category != null)
		{
			pageInfo = admindao.search(category, keyword,1);
			model.addAttribute("category",category);
			model.addAttribute("keyword",keyword);
		}else {
			pageInfo = admindao.getallbook(pn);
		}
		model.addAttribute("pageInfo",pageInfo);		
		return "admin/adbooklist";
	}
	
	@PostMapping("/search")
	public String search(@RequestParam("category") String category,
			 @RequestParam("keyword") String keyword,
			 Model model)
	{
		PageInfo<Map> pageInfo = admindao.search(category, keyword,1);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("category",category);
		model.addAttribute("keyword",keyword);
		
		return "admin/adbooklist";
		
	}
	//=======================================책 수정하는 로직=============================
	@GetMapping("/updateform/{bnum}")
	public String detail(Model model , @PathVariable int bnum)
	{
		model.addAttribute("book" , dao.getbook(bnum));
		return "admin/editform";
	}
	
	
	@PostMapping("/delete/{bnum}")
	@ResponseBody
	public Map<String,Boolean> getdeletebook(@PathVariable int bnum,@RequestParam String cvrimg, @RequestParam String contentimg){
		Map<String,Boolean> map = new HashMap<>();
		boolean del = false;
		Path thepath = Paths.get("/img" +"/" + cvrimg);
        del = dao.deletebook(bnum,contentimg);
        if(del==true) {
        try {
	        if (Files.exists(thepath)) {
	            Files.delete(thepath);
	        }
	        }catch (Exception e) {
				// TODO: handle exception
			}
        }
		map.put("deleted", del);
		return map;
	}
	
	
	@PostMapping("/update")
	   @ResponseBody
	   public Map<String,Boolean> update(
	                             @RequestParam("conimg") MultipartFile contentimg,
	                             Book bo,HttpServletRequest request)
	   {
	      Map<String,Boolean> map = new HashMap<>();
	      ServletContext context = request.getServletContext();
	       String savePath = context.getRealPath("/img");
	       List<Bookattach> filelist = new ArrayList<>();
	       try {
	          if(contentimg != null && !contentimg.isEmpty()) {
	               String contentName = contentimg.getOriginalFilename();
	                 contentimg.transferTo(new File(savePath + "/" + contentName));
	                 String conType = contentimg.getContentType();
	                 String conName = contentimg.getName();
	                 Resource con = contentimg.getResource();
	                 long conSize = contentimg.getSize();
	                 boolean cont = contentimg.isEmpty();
	                 
	                 Bookattach ba = new Bookattach();
	                 
	                 ba.setContentimg(contentName);
	                 ba.setConsize(conSize/1024);
	                 ba.setContype(conType);
	                 filelist.add(ba);
	                 
	                 bo.setFlist(filelist);
	                
	                 boolean success = dao.updateBook(bo);
	              map.put("update", success);
	            }else {
	               boolean success = dao.updateBook(bo);
	             map.put("update", success);
	            }
	       } catch (Exception e) {
	         e.printStackTrace();
	       }   
	         return map;
	   }
		

	
}
