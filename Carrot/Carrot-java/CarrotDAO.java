package com.ezen.spring.board.teampro.carrotmarket;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.spring.board.teampro.board2.Boardvo;
import com.ezen.spring.board.teampro.book.Book;
import com.ezen.spring.board.teampro.book.Bookattach;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Component("carrotdao")
public class CarrotDAO {
	
	@Autowired
	@Qualifier("carrotmapper")
	CarrotMapper carrotmapper;
	
	public boolean addcarrotAll(CarrotVO cv) {
		
		boolean bSaved = carrotmapper.addcarrot(cv)>0;
		
		int cnum = cv.getCnum();
		List<CarrotAttach> list = cv.getClist();
		if (list != null && !list.isEmpty()) {
		    for (int i = 0; i < list.size(); i++) {
		         list.get(i).setCnum(cnum);
		        }
		    	boolean att = carrotmapper.addcarrotfile(cv.getClist())> 0;
			        if (!bSaved) {
			            return false;
			        }
		    }
		    return bSaved;
		
	}
	
	public PageInfo<Map> getallcarrot(int pageNum) {
		PageHelper.startPage(pageNum,10);
		PageInfo<Map> pageInfo = new PageInfo<> (carrotmapper.getcarrot());
		
		return pageInfo;
	}
	
	public PageInfo<Map> search(String category,String keyword, int pageNum)
	{
		PageHelper.startPage(pageNum,10);
		CarrotVO cv = new CarrotVO();
		if(category.equals("title")) {cv.setTitle(keyword);}
		PageInfo<Map> pageInfo = new PageInfo<>(carrotmapper.search(cv));
		return pageInfo;
		
	}
	public List<Map>  getcarrotandattach(int cnum) {
		return carrotmapper.getcarrottoattach(cnum);
	}

	public boolean hitup(CarrotVO cv)
	{
		return carrotmapper.gethit(cv)>0;
	}
	
	public boolean updateCarrot(CarrotVO cv,int cnum)
	{
		boolean bSaved = carrotmapper.updatecarrot(cv)>0;
		
	
		List<CarrotAttach> list = cv.getClist();
		if (list != null && !list.isEmpty()) {
			 for (int i = 0; i < list.size(); i++) {
		         list.get(i).setCnum(cnum);
		        }
		    	boolean att = carrotmapper.addcarrotfile(cv.getClist())> 0;
			        if (!bSaved) {
			            return false;
			        }
		    }
		    return bSaved;
		
	}

	public boolean deleteatt(int num) {
		return carrotmapper.delattach(num)>0;
	}
	
	public boolean comadd(Carrotcomment cc) {
		return carrotmapper.comtadd(cc)>0;
	}
	
	public List<Map> comment(int carnum)
	   {
	      List<Map> page = carrotmapper.getcomment(carnum);
	      return page;
	   }
	
	public boolean comtoadd(Carrotcomment1 cc) {
		return carrotmapper.comtocomadd(cc)>0;
	}
	
	public List<Map> commenttocom(){
	      List<Map> page = carrotmapper.getcommenttocom();
	      return page;
	   }
	
	public boolean interests(Interest in) {
		return carrotmapper.interest(in)>0;
	}
	
	public List<Map> get_interest_list(String userid){
	      List<Map> page = carrotmapper.getinterest(userid);
	      return page;
	   }
	
	public CarrotVO session_carrot(int cnum)
	   {
	     return carrotmapper.get_to_buy(cnum);
	   }
	

	public boolean bought_pointdown(String userid,String title,int price, String saleuserid,int cnum,String payment) {

		boolean bought = carrotmapper.boughtcarrot(userid,title,price,saleuserid,cnum,payment)>0;
		return bought;
	}
	
	public boolean stateTrans(String saleuserid) {
		return carrotmapper.state(saleuserid)>0;
	}
	
}
