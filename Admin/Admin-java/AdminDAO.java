package com.ezen.spring.board.teampro.admin;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.ezen.spring.board.teampro.book.Book;
import com.ezen.spring.board.teampro.book.Bookattach;
import com.ezen.spring.board.teampro.login.MemberVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Component("admindao")
public class AdminDAO {
	@Autowired
	@Qualifier("adminmapper")
	AdminMapper adminmapper;

	
	public List<AdminVO> getBylist(){
		return adminmapper.getlist();
	}
	
	public List<AdminVO> getByDay(String key){
		return adminmapper.getByDay(key);
	}
	public List<AdminVO> getByMonth(String year,String month){
		return adminmapper.getByMonth(year, month);
	}
	public List<AdminVO> getByYear(String key){
		return adminmapper.getByYear(key);
	}
	
	public List<AdminVO> getById(String key){
		return adminmapper.getByid(key);
	}
	
	public boolean addadmin(MemberVO vo){
		return adminmapper.adminadd(vo)>0;
	}
	
	public PageInfo<Map> getallbook(int pageNum)
	{	PageHelper.startPage(pageNum,10);
		PageInfo<Map> pageInfo = new PageInfo<> (adminmapper.getallbook());
		return pageInfo;
	}
	public PageInfo<Map> search(String category,String keyword, int pageNum)
	{
		PageHelper.startPage(pageNum,10);
		Book vo = new Book();
		if(category.equals("bname")) {vo.setBname(keyword);}
		else if(category.equals("author")) {vo.setAuthor(keyword);}
		PageInfo<Map> pageInfo = new PageInfo<>(adminmapper.search(vo));
		return pageInfo;
	}
	
	 public List<Bookattach> getattach() {
		 List<Bookattach> ba = adminmapper.getattbook();
		 return ba;
	 }
	 
	 public MemberVO joinmem(String userid) {
		 return adminmapper.getJoinedMem(userid);
	 }
}
