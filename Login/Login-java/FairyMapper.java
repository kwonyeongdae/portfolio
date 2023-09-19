package com.ezen.spring.board.teampro.login;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import com.ezen.spring.board.teampro.admin.AdminVO;
import com.ezen.spring.board.teampro.carrotmarket.CarrotVO;
import com.ezen.spring.board.teampro.login.MemberVO;
  
@Component("fairyMapper")
@Mapper
public interface FairyMapper 
{
	public int addfairyMem(MemberVO mem);

	public int joinIdCheck(MemberVO mem);

	public int joinEmailCheck(MemberVO mem);

	public MemberVO loginCheck(MemberVO mem);

	public MemberVO getJoinedMem(String userid); 
	
	public List<AdminVO> getboughtbook(String userid);
	
	public int adminLoginCheck(MemberVO mem);

	public int updatedMem(MemberVO mem);

	public List<MemberVO> getMem();
	
	public int userExists(MemberVO mem);
	
	public int empdel(int fnum);
	
	public int deleteMember(int fnum);
	
	public List<MemberVO> restMem();
	
	public int restEsc(int fnum);
	
	public int pointdown(int carrotpoint, String uid);

	public List<CarrotVO> getboughtcarrot(String userid);
	
	public List<CarrotVO> getcarrot(String userid);
	
	public int state(String userid,int cnum);
	
	public int pointup(int carrotpoint,String uid);
	
	public int Laststate(String uid,int cnum);
	
	public int boughtupdata(String userid,int cnum);
	
	public int up_state(int cnum);
	
	public String findIDByNameAndPhone(MemberVO mem);

	public String findIDByNameAndEmail(MemberVO mem);

	public String findPassByNameAndPhone(MemberVO mem);

	public String findPassByNameAndEmail(MemberVO mem);

}
