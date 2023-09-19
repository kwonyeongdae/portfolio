package com.ezen.spring.board.teampro.carrotmarket;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import com.ezen.spring.board.teampro.board2.Boardvo;
import com.ezen.spring.board.teampro.book.Book;
import com.ezen.spring.board.teampro.book.Bookattach;

@Component("carrotmapper")
@Mapper
public interface CarrotMapper {

	public int addcarrot(CarrotVO cv);
	
	public int addcarrotfile(List<CarrotAttach> list);
	
	public List<Map> getcarrot();
	
	public List<Map> search(CarrotVO cv);
	
	public List<Map>  getcarrottoattach(int cnum);
	
	public int updatecarrot(CarrotVO cv);
	
	public int gethit(CarrotVO cv);
	
	public int delattach(int num);
	
	public int comtadd(Carrotcomment cc);

	 public List<Map> getcomment(int carnum);

	 public int comtocomadd(int dcarnum,String duserid,String dcomment );
	 
	 public List<Map> getcommenttocom();
	 
	 public int interest(Interest in);
	 
	 public List<Map> getinterest(String userid);
	 
	 public CarrotVO get_to_buy(int cnum);
	 
	 public int pointup(int carrotpoint, String uid);
	 
	 public int boughtcarrot(String buyuserid,String title,int price, String saleuserid,int cnum,String payment);
	 
	 public int state(String saleuserid);
	 
	 public List<Map> get_to_my(String userid);
	 
	 public int delcarrot(int cnum);
	 
	 public int delcarrot_att(int cnum);
}
