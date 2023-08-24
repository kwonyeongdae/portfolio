package com.ezen.spring.board.teampro.board2;

import java.io.File;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;


@Repository("boarddao")
public class BoardDao {
	@Autowired
	@Qualifier("boardmapper")
	private BoardMapper bm;
	

	public boolean add(Boardvo vo)
	{
		boolean bSaved = bm.add(vo)>0;
		
		int pnum = vo.getBnum();
		List<FileVO> list = vo.getFlist();
		if (list != null && !list.isEmpty()) {
		    for (int i = 0; i < list.size(); i++) {
		         list.get(i).setPnum(pnum);
		        }
		    	boolean att = bm.addfile(vo.getFlist()) > 0;
			        if (!bSaved) {
			            return false;
			        }
		    }
		    return bSaved;
	}
	
	public PageInfo<Map> getlist(int pagenum,int pagesize)
	{
		PageHelper.startPage(pagenum,pagesize);
		PageInfo<Map> PageInfo = new PageInfo<>(bm.getList());
		return PageInfo;
	}
	
	public PageInfo<Boardvo> getsearch(String category,String key,int pagenum,int pagesize) 
	{
		PageHelper.startPage(pagenum,pagesize);
		Map<String,String> map = new HashMap<>();
		map.put("category", category);
	    map.put("key", key);
		PageInfo<Boardvo> pageinfo = new PageInfo<>(bm.getsearch(map));
		return pageinfo;
	}
	
	public List<Map<String,Object>> getboard(int bnum)
	{
		return bm.getBoard(bnum);
	}
	
	
	public boolean update(Boardvo vo) {
		boolean board = bm.getupdate(vo) > 0;
		
		int pnum = vo.getBnum();
	    List<FileVO> list = vo.getFlist();
	    if (list != null && !list.isEmpty()) {
	        for (int i = 0; i < list.size(); i++) {
	            list.get(i).setPnum(pnum);
	        }
	       boolean att = bm.addfile(vo.getFlist()) > 0;
	      }
	     
	    return board;
	}


	
	
	public boolean hitup(Boardvo vo)
	{
		return bm.gethit(vo)>0;
	}
	
	@Transactional
	public boolean delete(int bnum,Boardvo vo)
	{
		
		boolean bSaved = bm.attdalete(bnum)>0;
		
		boolean aSaved = bm.dalete(bnum)>0;
		return bSaved&&aSaved;
		
	}
	
	
	
	public List<FileVO> add(List<FileVO> vo) {
        bm.addfile(vo);
        return vo;
    }
	
	@Transactional
	public boolean attdelete(int num,String fname,HttpServletRequest request )
	{
		boolean delatt = bm.attdalete(num)>0;
		ServletContext context = request.getServletContext();
	    String savePath = context.getRealPath("files");
	    File delFile = new File(savePath,fname);
	    boolean fdel = delFile.delete();
	    
		return delatt&&fdel;
	}
	
	public String getdownload(int num)
	{
		return bm.getdownload(num);
	}
	
	public boolean addcomm(Comment vo)
	{
		boolean add = bm.addcomment(vo)>0;
		return add;
	}
	
	public List<Comment> getcomlist(int bnum)
	{
		 List<Comment> clist = bm.comlist(bnum);
		return clist;
	}
	
}