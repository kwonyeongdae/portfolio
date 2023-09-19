package com.ezen.spring.board.teampro.cart;

import java.util.*;

import com.ezen.spring.board.teampro.carrotmarket.CarrotVO;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Conditional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.spring.board.teampro.admin.AdminVO;
import com.ezen.spring.board.teampro.login.FairyDAO;
import com.ezen.spring.board.teampro.login.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.server.PathParam;

@Controller
@RequestMapping("/fairy")
@SessionAttributes("userid")
public class CartController {
	@Autowired
	@Qualifier("cartdao")
	CartDAO dao;
	
	@Autowired
	  @Qualifier("fairydao")
	  private FairyDAO fairydao;
	
	@Autowired
	@Qualifier("VO")
	BookVO vo;
	@GetMapping("/cart/index")
	public ModelAndView index()
	{
		 ModelAndView modelAndView = new ModelAndView("cart/index");
		return modelAndView;
	}

//==============================================여기서부터 카트추가=================================================================================	
//==============================================여기서부터 카트추가=================================================================================		
	@PostMapping("/cart/add/{bnum}")
	@ResponseBody
	public Map<String, Boolean> getcartadddd(@PathVariable int bnum, @RequestParam int quantity, @RequestParam String bname, @SessionAttribute(name = "userid", required = false) String userid) {
	    Map<String, Boolean> map = new HashMap<>();
	    List<BookVO> blist = new ArrayList<>();
	    blist = dao.getlist(userid);
	    
	    boolean added = false;
	    boolean quanti = false;
	    
	    for (int i=0;i<blist.size();i++) {
	        if (blist.get(i).getBname().equals(bname)&&blist.get(i).getUserid().equals(userid)) {
	            quanti = dao.getcartup(bname, quantity, userid);
	            break;
	        }
	    }
	    if(!quanti) {
	     added = dao.getcartadd(bname, quantity, userid);
	    }
	    map.put("added", added);
	    map.put("quanti", quanti);
	    return map;
	}
	
	@GetMapping("/cart/list")
	public ModelAndView getlist(Model model,@SessionAttribute(name = "userid", required = false)String userid)
	{
		model.addAttribute("user",fairydao.getJoinedMem(userid));
		List<BookVO> blist = new ArrayList<>();
		blist = dao.getlist(userid);
		 ModelAndView modelAndView = new ModelAndView("cart/showCartjsp");
		 model.addAttribute("book", blist);
		return modelAndView;
	}
	
	//장바구니 내에서 수량만 추가하는 기능----------------------------------------------------
	@PostMapping("/cart/qupdate")
	@ResponseBody
	public Map<String,List<Boolean>> Qupdate(@RequestParam(value="bname[]") List<String> bbname, @RequestParam(value="quantity[]") List<Integer> bquantity)
	{
		List<Boolean> updateList = new ArrayList<>();
		Map<String,List<Boolean>> map = new HashMap<>();
		List<Integer> quantlist = new ArrayList<>();
		quantlist = bquantity;

		List<String> blist = new ArrayList<>();
		blist = bbname;

		 for(int i=0;i<quantlist.size();i++) {
			  int quantity= quantlist.get(i);
			  String bname= blist.get(i);
			  boolean update = dao.getqupdate(quantity, bname);
			  updateList.add(update);
			  map.put("update",  updateList);
			}
			
		return map;
	}
	
//==============================================장바구니에서 삭제로직=================================================================================		
//==============================================장바구니에서 삭제로직=================================================================================
	
	@PostMapping("/cart/delete")
	@ResponseBody
	public Map<String,Boolean> getdelete(@RequestParam(value="bname[]") List<String> bname,@SessionAttribute(name = "userid", required = false)String userid)
	{
	  Map<String,Boolean> map = new HashMap<>();
	  List<String> intlist = new ArrayList<>();
	  intlist = bname;
	  for(int i=0;i<intlist.size();i++) {
		  String bbname=intlist.get(i);
		if (userid != null) {
			String id = userid; 
			map.put("deleted", dao.getdelete(bbname));
		}else {
	        map.put("deleted", false);
	    	}
		}
	  return map;
	}
	
//==============================================결제창=================================================================================	
//==============================================결제창=================================================================================	
	
	@GetMapping("/cart/buy")
	public ModelAndView beycart(@SessionAttribute(name = "userid", required = false) String userid,Model model) {
		model.addAttribute("user",fairydao.getJoinedMem(userid));
		ModelAndView modelAndView = new ModelAndView("cart/buycart");
		return modelAndView;
	}
	
	@PostMapping("/cart/buy")
	@ResponseBody
	public String beycart(@RequestParam(value = "bname[]") List<String> bname, HttpServletRequest request,
	                      @SessionAttribute(name = "userid", required = false) String userid) throws Exception {
	    HttpSession session = request.getSession();
	    List<BookVO> selectedBooks = (List<BookVO>) session.getAttribute("selectedBooks");
	    if (selectedBooks == null) {
	        selectedBooks = new ArrayList<>();
	    }
	    for (String selectedbname : bname) {
	        // 기존 객체를 찾아서 제거
	        for (Iterator<BookVO> iterator = selectedBooks.iterator(); iterator.hasNext();) {
	            BookVO book = iterator.next();
	            if (book.getBname().equals(selectedbname)) {
	                iterator.remove();
	                break;
	            }
	        }
	        // 세션에 새로운 객체 추가
	        selectedBooks.add(dao.getbeylist(selectedbname, userid));
	    }
	    session.setAttribute("selectedBooks", selectedBooks);
	    return "cart/buycart";
	}



	
//==============================================결제후 bougthbook테이블로 넘어감=================================================================================	
//==============================================결제후 bougthbook테이블로 넘어감=================================================================================
	
	@PostMapping("/cart/bought")
	@ResponseBody
	public Map<String, Object> bought(@RequestParam(value = "bname[]") List<String> bname,
	                                  @RequestParam(value = "userid") String uid,
	                                  @RequestParam(value = "payment") String payment,
	                                  @RequestParam(value = "quantity[]") List<Integer> quantity,
	                                  @RequestParam(value = "age") int age,
	                                  @SessionAttribute(name = "userid", required = false) String userid,
	                                  HttpSession session) {

	    Map<String, Object> paramMap = new HashMap<>();
	    
	    if (userid != null) {
	        for (int i = 0; i < bname.size(); i++) {
	            boolean bought = dao.getbought(bname.get(i), userid, quantity.get(i),payment,age);
	            paramMap.put("bought", bought);
	            if (!bought) {
	                paramMap.put("bought", false);
	            }
	        }
	    }

	    // 세션에 저장된 모든 속성 제거 (단, userid 속성은 제외)
	    Enumeration<String> attributeNames = session.getAttributeNames();
	    while (attributeNames.hasMoreElements()) {
	        String attributeName = attributeNames.nextElement();
	        if (!attributeName.equals("userid")) {
	            session.removeAttribute(attributeName);
	        }
	    }

	    return paramMap;
	}
	
//==============================================결제후 cart테이블삭제=================================================================================	
//==============================================결제후 cart테이블삭제=================================================================================	
@GetMapping("/cart/payment/{userid}")
public String payment(Model model, @PathVariable String userid) {
	List<AdminVO> paylist = new ArrayList<>();
	paylist = dao.pay(userid);
	List<CarrotVO> carrotlist = new ArrayList<>();
	carrotlist = dao.paycarrot(userid);
	model.addAttribute("user",fairydao.getJoinedMem(userid));
	model.addAttribute("payment",paylist);
	model.addAttribute("paycarrot",carrotlist);
	return "cart/showpayment";
}
//==============================================결제후 cart테이블삭제=================================================================================	
//==============================================결제후 cart테이블삭제=================================================================================	
	@PostMapping("/cart/remove")
	@ResponseBody
	public Map<String,Boolean> remove(@SessionAttribute(name = "userid", required = false) String userid){
		
		Map<String,Boolean> map = new HashMap<>();
		boolean remove = dao.getdeleteAll();
		map.put("remove",remove );
		return map;
		
	}
	
	@PostMapping("/buy/del")
	@ResponseBody
	public Map<String, Object> buydelete(@RequestParam String bname, HttpSession session) {
	    Map<String, Object> map = new HashMap<>();
	    boolean removed = false; // 제거 여부를 나타내는 플래그

	    // 세션에 저장된 객체를 가져온 뒤 bname 값과 비교하여 일치하는 경우 제거
	    List<BookVO> objects = (List<BookVO>) session.getAttribute("selectedBooks");
	    if (objects != null) {
	        for (Iterator<BookVO> iterator = objects.iterator(); iterator.hasNext();) {
	        	BookVO object = iterator.next();
	            if (object.getBname().equals(bname)) {
	                iterator.remove();
	                removed = true;
	                break; // 원하는 객체를 찾았으면 더 이상 순회할 필요 없으므로 종료
	            }
	        }
	    }

	    map.put("remove", removed); // 제거 여부를 응답으로 전달
	    return map;
	}
//==============================================슬라이드쇼 보기=================================================================================	
//==============================================슬라이드쇼 보기=================================================================================	
	
	@GetMapping("/cart/buylist/{uid}")
	   public String buylist(@PathVariable String uid, Model model)
	   {
	      List<BookVO> vo = dao.buylist(uid);
	      BookVO bo = dao.mileage(uid);
	      model.addAttribute("buy",vo);
	      model.addAttribute("mileage",bo);
	      
	      return "cart/buybook";
	      
	   }

	
	@GetMapping("/cart/slideshow")
	public String slide()
	{
		return "book/slideshow";
	}
//==============================================포인트=================================================================================	
//==============================================포인트=================================================================================	

	@PostMapping("/cart/pointdown")
	@ResponseBody
	public Map<String, Boolean> point(@SessionAttribute(name = "userid", required = false) String userid,
									  @RequestParam int carrotpoint,@RequestParam int mileage){
		Map<String, Boolean> map = new HashMap<>();
		map.put("point", dao.pointdown(mileage, carrotpoint, userid));
		return map;
	}

//==============================================교환/반품/물품수령=================================================================================	
//==============================================교환/반품/물품수령=================================================================================	
	@GetMapping("/cart/change/{num}")
	public String change(@PathVariable int num,Model model,@SessionAttribute(name = "userid", required = false) String userid)
	{	model.addAttribute("member",fairydao.getJoinedMem(userid));
		model.addAttribute("book",dao.boughtget(num));
		return "cart/changegoods";
	}
	
	@PostMapping("/cart/changebook")
	@ResponseBody
	public Map<String, Boolean> change_book(@RequestParam int num){
		Map<String, Boolean> map = new HashMap<>();
		map.put("point", dao.change(num));
		return map;
	}
	
	@PostMapping("/cart/ok")
	@ResponseBody
	public Map<String, Boolean> Ok_buy(@RequestParam int num){
		Map<String, Boolean> map = new HashMap<>();
		map.put("ok", dao.okbuy(num));
		return map;
	}

}
