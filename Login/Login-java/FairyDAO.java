package com.ezen.spring.board.teampro.login;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.spring.board.teampro.admin.AdminVO;
import com.ezen.spring.board.teampro.carrotmarket.CarrotVO;
import com.ezen.spring.board.teampro.login.MemberVO;

@Repository("fairydao")
public class FairyDAO 
{

    @Autowired
    @Qualifier("fairyMem")
    private MemberVO memvo;
    
    @Autowired
    @Qualifier("fairyMapper")
    private FairyMapper fairyMapper;
	
	public boolean addJoin(MemberVO mem) 
	{
	    return fairyMapper.addfairyMem(mem)>0;
	}

	public boolean joinIdCheck(MemberVO mem) 
	{
		
		return fairyMapper.joinIdCheck(mem)>0;
	}

	public boolean joinEmailCheck(MemberVO mem) 
	{
		
		return fairyMapper.joinEmailCheck(mem)>0;
	}

	 public boolean login(MemberVO mem) 
	   {
		 MemberVO member = fairyMapper.loginCheck(mem);
		    return  member != null;
	   }

	public MemberVO getJoinedMem(String userid) 
	{
		
		return fairyMapper.getJoinedMem(userid);
	}

	public List<AdminVO> getBought(String userid) 
	{
		
		return fairyMapper.getboughtbook(userid);
	}
		
	public boolean adminLogin(MemberVO mem)
	   {
	      return fairyMapper.adminLoginCheck(mem)>0;
	   }


	public boolean updatedMem(MemberVO mem)
	   {
	      
	      return fairyMapper.updatedMem(mem)>0;
	   }
	
	public List<MemberVO> getmemlist()
	   {
	      
	      return fairyMapper.getMem();
	   }
	public boolean userExists(MemberVO mem)
	{
		return fairyMapper.userExists(mem)>0;
	}
	public boolean Escemp(int fnum) {
		
		return fairyMapper.empdel(fnum)>0;
	}

	public boolean deleteMember(int fnum)
   {
      return fairyMapper.deleteMember(fnum)>0;
   }
	
	public List<MemberVO> restMember(){
		
		return fairyMapper.restMem();
	}
	
	public boolean restesc(int fnum) {
		return fairyMapper.restEsc(fnum)>0;
				
	}
	
	public boolean carrotTransfer(int carrotpoint, String userid) {
		return fairyMapper.pointdown(carrotpoint, userid)>0;
	}
	
	public List<CarrotVO> boughtcarrot(String userid){
		
		return fairyMapper.getboughtcarrot(userid);
	}
	
	public List<CarrotVO> carrot(String userid){
		
		return fairyMapper.getcarrot(userid);
	}
	
    public boolean changestate(String userid,int cnum) {
	   return fairyMapper.state(userid,cnum)>0;
   }
    @Transactional
    public boolean Trade(int carrotpoint,String userid,int cnum,String uid) {
 	   boolean Laststate = fairyMapper.Laststate(uid,cnum)>0;
 	   boolean pointup = fairyMapper.pointup(carrotpoint, uid)>0;
 	   boolean state = fairyMapper.boughtupdata(userid, cnum)>0;
    	return Laststate&&pointup&&state;
    }
    
}
