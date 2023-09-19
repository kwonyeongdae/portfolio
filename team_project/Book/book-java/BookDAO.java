package com.ezen.spring.board.teampro.book;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.ezen.spring.board.teampro.board2.FileVO;
import com.ezen.spring.board.teampro.cart.BookVO;
import com.ezen.spring.board.teampro.login.MemberVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Component("bookdao")
public class BookDAO {

	
	@Autowired
	@Qualifier("bookmapper")
	private BookMapper bookmap;
	
	
	public boolean addbooks(Book bo) {
		boolean bSaved = bookmap.addbook(bo)>0;
		
		int bnum = bo.getBnum();
		List<Bookattach> list = bo.getFlist();
		if (list != null && !list.isEmpty()) {
		    for (int i = 0; i < list.size(); i++) {
		         list.get(i).setBnum(bnum);
		        }
		    	boolean att = bookmap.addfile(bo.getFlist()) > 0;
			        if (!bSaved) {
			            return false;
			        }
		    }
		    return bSaved;
	}
	
	public PageInfo<Map> getallbook(int pagenum,int pagesize) {
		PageHelper.startPage(pagenum,12);
		PageInfo<Map> pageInfo = new PageInfo<> (bookmap.getallbook());
		
		return pageInfo;
	}
	
	public PageInfo<Map> search(String category,String keyword, int pageNum)
	{
		PageHelper.startPage(pageNum,12);
		Book vo = new Book();
		if(category.equals("bname")) {vo.setBname(keyword);}
		else if(category.equals("publisher")) {vo.setPublisher(keyword);}
		else if(category.equals("author")) {vo.setAuthor(keyword);}
		
		PageInfo<Map> pageInfo = new PageInfo<>(bookmap.search(vo));
		
		
		return pageInfo;
		
	}
	public List<Book> catesearch(String cate)
	{
		List<Book> vo = bookmap.CateSearch(cate);
		return vo;
	}

	public List<Map> getbook(int bnum) {
		return bookmap.getbook(bnum);
	}
	
	public boolean deletebook(int bnum,String contentimg) {
		boolean bookatt = false;
		if(!contentimg.isEmpty()) {
			bookatt = bookmap.getattdelete(bnum)>0;
		   }
		boolean book = bookmap.getdelete(bnum)>0;
		return book;
	}
	
	public boolean deleteatt(int bnum,String contentimg) {
		boolean bookatt = bookmap.getattdelete(bnum)>0;
		return bookatt;
	}
	
	public boolean updateBook(Book b)
	{
		boolean bSaved = bookmap.updateBook(b)>0;
		
		int bnum = b.getBnum();
		List<Bookattach> list = b.getFlist();
		if (list != null && !list.isEmpty()) {
		    list.get(0).setBnum(bnum);
		    boolean att =  bookmap.addfile(b.getFlist()) > 0;
			        if (!bSaved) {
			            return false;
			        }
		    }
		    return bSaved;	   
	}
	
	public MemberVO getmember(String userid) {
	      return bookmap.getMem(userid);
	   }
	
	public boolean addqna(QnAVO vo) {
		
		return bookmap.qnaadd(vo)>0;
	}
	
	public List<Map> getqna1(int pnum){
		List<Map> qlist = bookmap.getqnalist(pnum);
		return qlist;
	}
	
	 public List<Book> best()
	   {
	      List<Book> vo  = bookmap.best();
	      return vo;
	   }
	 
	 public boolean addreview(review re)
	   {
	      boolean revi = bookmap.addreview(re)>0;
	      return revi;
	   }
	   public List<Map> reviewlist(int bnum)
	   {
	      List<Map> page = bookmap.reviewlist(bnum);
	      return page;
	   }
	   
	   public PageInfo<Map> allreview(int bnum, int pagenum)
	   {
	      PageHelper.startPage(pagenum,10);
	      PageInfo<Map> list = new PageInfo<>(bookmap.reviewlist(bnum));
	      return list;
	   }
	   
	   public boolean delreview(int count) 
	      {
	         boolean delreview = bookmap.delreview(count)>0;
	         return delreview;
	      }

	   
	   public Double score(int bnum)
	   {
	      Double list = bookmap.score(bnum);
	      return list;
	   }

	   public boolean Qnacomment(Qnacomment Qna) {
		   
		   return bookmap.qnacomment(Qna)>0;
	   }
	
	   public List<Map> qnacomment()
	   {
	      List<Map> page = bookmap.getallqnacomment();
	      return page;
	   }

}
