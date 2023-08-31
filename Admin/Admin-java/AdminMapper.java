package com.ezen.spring.board.teampro.admin;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import com.ezen.spring.board.teampro.book.Book;
import com.ezen.spring.board.teampro.book.Bookattach;
import com.ezen.spring.board.teampro.login.MemberVO;

@Component("adminmapper")
@Mapper
public interface AdminMapper {

	public List<AdminVO> getlist();
	public List<AdminVO> getByDay(String key);
	public List<AdminVO> getByMonth(String year,String month);
	public List<AdminVO> getByYear(String key);
	public List<AdminVO> getByid(String key);
	public int adminadd(MemberVO vo);
	public List<Map<String,String>> getallbook();
	public List<Bookattach> getattbook();
	public List<Map> search(Book vo);
	
	public MemberVO getJoinedMem(String userid);

}
