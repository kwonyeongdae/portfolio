package com.ezen.spring.board.teampro.book;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import com.ezen.spring.board.teampro.cart.BookVO;
import com.ezen.spring.board.teampro.login.MemberVO;

@Component("bookmapper")
@Mapper
public interface BookMapper {
	
	public int addbook(Book bo);
	
	public List<Map<String,String>> getallbook(); 
	
	public List<Map> search(Book vo);
	
	public List<Book> CateSearch(String cate);

	public List<Map> getbook(int bnum);
	
	public int getdelete(int bnum);
	
	public int getattdelete(int bnum);

	public int updateBook(Book VO);
	
	public int updateattach(Bookattach ba);
	
	public MemberVO getMem(String userid);
	
	public int qnaadd(QnAVO vo);
	
	public List<Map> getqnalist(int pnum);
	
	public List<Book> best();
	
	public int addfile(List<Bookattach> list);
	
	public Bookattach getatt(int bnum);
	
	public int addreview(review re);
	   
    public List<Map> reviewlist(int bnum);
   
    public int delreview(int count);
    
    public Double score(int bnum);
   
    public int qnacomment(Qnacomment Qna);

    public List<Map> getallqnacomment();
	   
}
