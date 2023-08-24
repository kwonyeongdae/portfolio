package com.ezen.spring.board.teampro.book;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.spring.board.teampro.board2.FileVO;
import com.ezen.spring.board.teampro.cart.BookVO;
import com.ezen.spring.board.teampro.login.FairyDAO;
import com.ezen.spring.board.teampro.login.MemberVO;
import com.ezen.spring.board.teampro.carrotmarket.CarrotVO;
import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/book")
@SessionAttributes("userid")
public class BookController {

	@Autowired
	@Qualifier("bookdao")
	private BookDAO dao;
	
	@Autowired
	  @Qualifier("fairydao")
	  private FairyDAO fairydao;
	
	@GetMapping("/add")
	public String add()
	{
		return "book/addform";
	}
	
	@PostMapping("/add")
	   @ResponseBody
	       public Map<String, Object> addBook(@RequestParam("file") MultipartFile cvrimg,
	                                  		  @RequestParam("conimg") MultipartFile contentimg,
	                                  		  Book bo,HttpServletRequest request) 
	      {
	      Map<String, Object> map = new HashMap<>();
	      ServletContext context = request.getServletContext();
	      String savePath = context.getRealPath("/img");
	      List<Bookattach> filelist = new ArrayList<>();
	           try {
	                  String fileName = cvrimg.getOriginalFilename();
	                  cvrimg.transferTo(new File(savePath + "/" + fileName));
	                  String cType = cvrimg.getContentType();
	                  String pName = cvrimg.getName();
	                  Resource res = cvrimg.getResource();
	                  long fSize = cvrimg.getSize();
	                  bo.setCvrimg(fileName);
	                  bo.setFsize(fSize/1024);
	                  bo.setContenttype(cType);
	                  boolean empty = cvrimg.isEmpty();
	//---------------------------content-------------------------------------------------------------   
	//---------------------------content-------------------------------------------------------------   
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
		                 
		                  boolean added = dao.addbooks(bo);
		                  map.put("added", added);
	                 }else {
	                  boolean added = dao.addbooks(bo);
	                  map.put("added", added);
	                 }
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	               return map;
	       }
//=======================================여기부터 list===============================================
//=======================================여기부터 list================================================
	@GetMapping("/list/page/{pn}")
	   public String getlist(@PathVariable int pn,
	         @RequestParam(value="category", required=false) String category,
	         @RequestParam(value="keyword", required=false) String keyword, Model model,
	         @SessionAttribute(name = "userid", required = false)String userid
	         )
	   {
		List<CarrotVO> clist = new ArrayList<>();
  		clist = fairydao.carrot(userid);
  		model.addAttribute("users",clist);
		model.addAttribute("rest",fairydao.getJoinedMem(userid));
	      PageInfo<Map> pageInfo = null;
	      List<Book> list = new ArrayList<>();
	      if(category !=null)
	      {
	         pageInfo = dao.search(category, keyword, pn);
	         model.addAttribute("category" , category);
	         model.addAttribute("keyword", keyword);
	      }else {
	         pageInfo = dao.getallbook(pn);
	         
	      }
	      list = dao.best();
	      model.addAttribute("user",dao.getmember(userid));
	      model.addAttribute("best",list);
	      model.addAttribute("pageInfo",pageInfo);
	      
	      
	      return "book/list";
	      
	   }
	
	@PostMapping("/search")
	public String search( @RequestParam("category") String category,
						 @RequestParam("keyword") String keyword,
						 Model model)
	{
		PageInfo<Map> pageInfo = dao.search(category, keyword,1);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("category", category);
		model.addAttribute("keyword", keyword);
		
		return "book/list";
		
	}
	
	
	
	@GetMapping("/listcate/{cate}")
	public String catelist(@PathVariable String cate,
			Model model)
	{
		List<Book> vo = dao.catesearch(cate);
		model.addAttribute("cate",vo);
		return "book/catelist"; 
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
//=======================================여기까지 list===============================================
//=======================================여기까지 list================================================
	
//=======================================여기부터 detail===============================================
//=======================================여기부터 detail================================================	
	@GetMapping("/book/{bnum}")//detail부분
	public ModelAndView getbook(@PathVariable int bnum,Model model,@SessionAttribute(name = "userid", required = false)String userid)
	{
		model.addAttribute("rest",fairydao.getJoinedMem(userid));
		model.addAttribute("user",dao.getmember(userid));
		List<Map> blist = new ArrayList<>();
		blist = dao.getbook(bnum);
		List<Map> qnlist = new ArrayList<>();
		qnlist = dao.qnacomment(); //
		 ModelAndView modelAndView = new ModelAndView("book/detail");
		 List<Map> qlist = new ArrayList<>();
		 qlist = dao.getqna1(bnum);
		 List<Map> list = dao.reviewlist(bnum);
         // dao.reviewlist(bnum)가 null인 경우 빈 리스트로 초기화
         model.addAttribute("review", list != null ? list : Collections.emptyList());
         
         // 평점 가져오기, dao.score(bnum)가 null인 경우 기본값으로 0 설정
         Double  score = dao.score(bnum);
         model.addAttribute("score", score != null ? score : 0);
         model.addAttribute("qnacom", qnlist);
		 model.addAttribute("qnalist",qlist);
		 model.addAttribute("book", blist);
		return modelAndView;
	}
	
	 @PostMapping("/book/review")
	 @ResponseBody
	 public Map<String,Boolean> addreview(@RequestBody review re){
	      boolean added = false;
	      Map<String, Boolean> map = new HashMap<>();

	      added=dao.addreview(re);
	      map.put("added", added);
	      return map;
	   }
	  @GetMapping("/book/reviewlist/{bnum}/{pn}")
	   public String reviewlist(@PathVariable int bnum,Model model , @PathVariable int pn)
	   {
	      PageInfo<Map> list = dao.allreview(bnum,pn);
	      model.addAttribute("pageInfo" , list);
	      
	      return "book/review";
	      
	   }
	  
	  @PostMapping("addqna")
		@ResponseBody
		public Map<String,Boolean> addqna(QnAVO vo){
			Map<String,Boolean> map = new HashMap<>();
			boolean qna = dao.addqna(vo);
			map.put("qna", qna);
			return map;
		}
		
		@PostMapping("/attremove")
		@ResponseBody
		public Map<String, Boolean> remove(@RequestParam("bnum")int bnum,
											@RequestParam("contentimg")String contentimg)
		{
			Map<String, Boolean> map = new HashMap<>();
			map.put("attremove", dao.deleteatt(bnum,contentimg));

			return map;
		}
		
		@PostMapping("/qnacomment")
		@ResponseBody
		public Map<String, Boolean> qnacomment(Qnacomment Qna)
		{
			Map<String, Boolean> map = new HashMap<>();
			map.put("qnacomment", dao.Qnacomment(Qna));

			return map;
		}


}
