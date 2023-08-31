package com.ezen.spring.board.teampro.cart;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import com.ezen.spring.board.teampro.admin.AdminVO;
import com.ezen.spring.board.teampro.carrotmarket.CarrotVO;

@Component("catmapper")
@Mapper
public interface CartMapper {
	

	
	public int getcart(String bname,int quantity,String userid);
	
	public int updatequantity(String bname,int quantity,String userid);
	
	public List<BookVO> getlist(String userid);
	
	public int getdelete(String bname);

	public BookVO getbeylist(String bname,String userid);
	
	public int boughtbook(String bname,String userid,int quantity,String payment);
	
	public int getdeleteAll();
	
	public int quantityUpdate(int quantity, String bname);
	
	public List<BookVO> buylist(String uid);
	
	public int updateMileage(String bname,String userid,int quantity);
	   
	public BookVO mileage(String userid);
	
	public int carrotpointdown(int carrotpoint,String userid);
	
	public int mileagedown(int mileage,String userid);

	public int changebook(int num);
	
	public BookVO getchange(int num);
	
	public int OkBuy(int num);
	
	public List<AdminVO> boughtlist(String userid);
	
	public List<CarrotVO> boughtcarrot(String userid);
}
