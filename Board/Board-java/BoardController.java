package com.ezen.spring.board.teampro.board2;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.spring.board.teampro.login.FairyDAO;
import com.ezen.spring.board.teampro.login.MemberVO;
import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/board")
@SessionAttributes("userid")
public class BoardController {
	@Autowired
	@Qualifier("boarddao")
	BoardDao bd;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@Autowired
	  @Qualifier("fairydao")
	  private FairyDAO fairydao;
	
	@GetMapping("/")
	public ModelAndView index()
	{
		 ModelAndView modelAndView = new ModelAndView("board/boardIndex");
		return modelAndView;
	}
//================================문의사항 추가 로직==========================================	
	@GetMapping("/board/add")
	public ModelAndView getadd(Boardvo vo)
	{
		ModelAndView modelAndView = new ModelAndView("board/addForm");
        return modelAndView;
	}
	@PostMapping("/board/add")
	   @ResponseBody
	   public Map<String, Object> add(@SessionAttribute(name = "userid", required = false)String userid, Boardvo bo,@RequestParam("files") MultipartFile[] mfiles,
	            HttpServletRequest request) {
	      
	      Map<String, Object> map = new HashMap<>();
	      ServletContext context = request.getServletContext();
	       String savePath = context.getRealPath("WEB-INF/files");
	       List<FileVO> fileList = new ArrayList<>();
	          try {
	             for(int i=0;i<mfiles.length;i++) {
	                  if (mfiles[i].getSize() == 0) continue;

	                  String fileName = mfiles[i].getOriginalFilename();
	                  mfiles[i].transferTo(new File(savePath + "/" + fileName));
	                  String cType = mfiles[i].getContentType();
	                  String pName = mfiles[i].getName();
	                  Resource res = mfiles[i].getResource();
	                  long fSize = mfiles[i].getSize();
	                  boolean empty = mfiles[i].isEmpty();
	              
	                  FileVO vo = new FileVO();
	                  vo.setFname(fileName);
	                  vo.setFsize(fSize/1024);
	                  vo.setContentType(cType);
	                  
	                  fileList.add(vo);
	              }
	             bo.setFlist(fileList);
	              boolean added = bd.add(bo);
	             // System.out.println(added);
	              if (userid != null) {
	                 String id = userid;
	                 map.put("added", added);
	              }else {
	                 map.put("added", false);
	              }
	              return map;
	          } catch (Exception e) {
	              e.printStackTrace();
	          }
	          map.put("added", false);
	      return map;
	   }
	//================================문의사항 추가 로직==========================================	
	
	//================================문의사항 list 로직==========================================
	@GetMapping("/board/list/page/{pn}")
	public ModelAndView getlist(@SessionAttribute(name = "userid", required = false)String userid,@PathVariable int pn, Model model) {
		model.addAttribute("user",fairydao.getJoinedMem(userid));
	    int pagenum = pn;
	    int pagesize = 10;
	    ModelAndView modelAndView = new ModelAndView("board/list");
	    PageInfo<Map> pageinfo = bd.getlist(pagenum, pagesize);
	    model.addAttribute("pageinfo", pageinfo);
	    return modelAndView;
	}

	@GetMapping("/board/search/page/{pn}")
	public ModelAndView getsearch(@RequestParam("category")String category,
								  @RequestParam("key")String key,Model model,
								  @PathVariable int pn)
	{
		int pagenum = pn;
	    int pagesize = 10;
		ModelAndView modelAndView = new ModelAndView("board/searchform");
		PageInfo<Boardvo> pageinfo = bd.getsearch(category,key,pagenum, pagesize);
	    model.addAttribute("pageinfo", pageinfo);
	    return modelAndView;
	}
	//================================문의사항 list 로직==========================================
	
	
	@GetMapping("/board/detail/{bnum}")
	public ModelAndView deteil(@SessionAttribute(name = "userid", required = false)String userid,@PathVariable int bnum,Boardvo vo, Model model)
	{
		model.addAttribute("user",fairydao.getJoinedMem(userid));
		bd.hitup(vo);
		List<Map<String,Object>> blist = new ArrayList<>();
		ModelAndView modelAndView = new ModelAndView("board/detail");
		blist = bd.getboard(bnum);
		List<Comment> clist = bd.getcomlist(bnum);
		
		model.addAttribute("detail", blist);
		model.addAttribute("comlist", clist);
		return modelAndView;
	}
	
	@GetMapping("/download/{num}")
	   public ResponseEntity<Resource> download(HttpServletRequest request,
	                           @PathVariable int num,String fname)
	   {
	      String filename = bd.getdownload(num);
	      Resource resource = resourceLoader.getResource("WEB-INF/files/"+filename);
	        String contentType = null;
	        try {
	            contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	 
	        if(contentType == null) {
	            contentType = "application/octet-stream";
	        }
	 
	        /* 파일명이 한글로 되어 있을 때 다운로드가 안되는 경우... */
	        try {
	         filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }

	        return ResponseEntity.ok()
	                .contentType(MediaType.parseMediaType(contentType))
	                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
	                .body(resource);
	   }
	//================================문의사항 update 로직==========================================
	@GetMapping("/board/update/{bnum}")
	public ModelAndView updateform(@PathVariable int bnum,Boardvo vo, Model model)
	{
		ModelAndView modelAndView = new ModelAndView("board/updateform");
		model.addAttribute("alist", bd.getboard(bnum));
		return modelAndView;
	}
	
	@PostMapping("/board/updatedd")
	   @ResponseBody
	   public Map<String, Object> getupdate(@RequestParam(value ="files",required=false) MultipartFile[] mfiles,
	                               @SessionAttribute(name = "userid", required = false)String userid, 
	                               Boardvo bo,@RequestParam("bnum") int bnum)
	   {
	      
	      Map<String, Object> map = new HashMap<>();
	      ServletContext context = request.getServletContext();
	       String savePath = context.getRealPath("/files");
	      List<FileVO> fileList = new ArrayList<>();
	          try {
	                for(int i=0;i<mfiles.length;i++) {
	                   if (mfiles != null) { 
	                   
	                     String fileName = mfiles[i].getOriginalFilename();
	                     mfiles[i].transferTo(new File(savePath + "/" + fileName));
	                     String cType = mfiles[i].getContentType();
	                     String pName = mfiles[i].getName();
	                     Resource res = mfiles[i].getResource();
	                     long fSize = mfiles[i].getSize();
	                     boolean empty = mfiles[i].isEmpty();
	                 
	                     FileVO vo = new FileVO();
	                     
	                     vo.setPnum(bnum);
	                     vo.setFname(fileName);
	                     vo.setFsize(fSize/1024);
	                     vo.setContentType(cType);
	                     
	                     fileList.add(vo);
	                     }
	                }	
	                  bo.setFlist(fileList);
	                 boolean added = bd.update(bo);
	                 map.put("update", added); 
	          } catch (Exception e) {
	              e.printStackTrace();
	          }
	      return map;
	   }
	
	@PostMapping("/board/attremove")//첨부물만 삭제
	@ResponseBody
	public Map<String, Boolean> remove(@RequestParam("num")int num,
										@RequestParam("fname")String fname,HttpServletRequest request)
	{
		Map<String, Boolean> map = new HashMap<>();
		map.put("attremove", bd.attdelete(num,fname,request));

		return map;
	}
	
	@PostMapping("/board/remove/{bnum}")//문의사항 전체삭제
	@ResponseBody
	public Map<String, Boolean> remove(@PathVariable int bnum,@SessionAttribute(name = "userid", required = false)String userid,Boardvo vo)
	{
		Map<String, Boolean> map = new HashMap<>();
		map.put("remove", bd.delete(bnum,vo));
		//System.out.println("결과 = " + bd.delete(bnum, vo));
		
		return map;
	}
	
	
	//================================문의사항 update 로직==========================================
	@PostMapping("/comment/{bnum}")
	@ResponseBody
	public Map<String,Boolean> getadd(@PathVariable int bnum, Comment vo)
	{
		Map<String,Boolean> map = new HashMap<>();
		boolean save = bd.addcomm(vo);
		map.put("added", save);
		return map;
	}

}