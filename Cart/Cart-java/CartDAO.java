package com.ezen.spring.board.teampro.cart;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.spring.board.teampro.admin.AdminVO;
import com.ezen.spring.board.teampro.carrotmarket.CarrotVO;

@Component("cartdao")
public class CartDAO {
	@Autowired
	@Qualifier("catmapper")
	public CartMapper CartMapper; 
	
	
	public boolean getcartadd(String bname,int quantity,String userid) {
		return CartMapper.getcart(bname,quantity,userid)>0;
	}
	
	public boolean getcartup(String bname,int quantity,String userid) {
		return CartMapper.updatequantity(bname,quantity,userid)>0;
	}
	
	
	public List<BookVO> getlist(String userid){
		return CartMapper.getlist(userid);
	}

	public boolean getdelete(String bname) {
		return CartMapper.getdelete(bname)>0;
	}
	
	public BookVO getbeylist(String bname,String userid){
		return CartMapper.getbeylist(bname,userid);
	}
	
	@Transactional
	public boolean getbought(String bname,String userid,int quantity,String payment,int age){
	      boolean bsave = CartMapper.boughtbook(bname,userid, quantity,payment,age)>0;
	      boolean mileage = CartMapper.updateMileage(bname, userid, quantity)>0;
	      boolean delbook = CartMapper.getdelete(bname)>0;
	      
	      return bsave&&mileage&&delbook;
	   }

	
	public boolean getdeleteAll() {
		return CartMapper.getdeleteAll()>0;
	}
	
	public boolean getqupdate(int quantity, String bname) {
		return CartMapper.quantityUpdate(quantity, bname)>0;
	}
	
	public List<BookVO> buylist(String uid)
	{
		List<BookVO> vo = CartMapper.buylist(uid);
		return vo;
	}
	
	 public BookVO mileage(String userid)
	   {
	      BookVO vo = CartMapper.mileage(userid);
	      return vo;
	   }
	 
	 public boolean pointdown(int mileage,int carrotpoint,String userid) 
	 {
	 
		boolean point = CartMapper.mileagedown(mileage, userid)>0;
	 
		boolean carrot =  CartMapper.carrotpointdown(carrotpoint,userid)>0;

		return point&&carrot;
	 }
	 
	 public boolean change(int num) {
		 return CartMapper.changebook(num)>0;
	 }
	 
	 public BookVO boughtget(int num) {
		 BookVO vo = CartMapper.getchange(num);
		 return vo;
	 }
	 
	 public boolean okbuy(int num) {
		  return CartMapper.OkBuy(num)>0;
	 }
	 
	 public List<AdminVO> pay(String userid) {
		 
		 return CartMapper.boughtlist(userid);
	 }
	 
 public List<CarrotVO> paycarrot(String userid) {
		 
		 return CartMapper.boughtcarrot(userid);
	 }


}

