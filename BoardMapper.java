package com.ezen.spring.board.teampro.board2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;


@Component("boardmapper")
@Mapper
public interface BoardMapper {
	
	public int add(Boardvo vo);
	
	public List<Map<String,String>> getList();
	
	public List<Map<String,Object>> getBoard(int bnum);
	 
	public List<Boardvo> getsearch(Map<String, String> map);
	
	public int getupdate(Boardvo vo);
	
	public int gethit(Boardvo vo);
	
	public int dalete(int bnum);
	
	public int attdalete(int num);
	
	public int addfile(List<FileVO> list);
	
	public String getdownload(int num);
	

	public int addcomment(Comment vo); 

	public List<Comment> comlist(int bnum);
}

