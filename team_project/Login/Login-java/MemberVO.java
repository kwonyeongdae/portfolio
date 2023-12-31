package com.ezen.spring.board.teampro.login;
  
import java.util.*;

import org.springframework.stereotype.Component;

    
@Component("fairyMem")

public class MemberVO 
{
	
	   private int fnum;
	   private int number;
	   private String userid;
	   private String pass;
	   private String name;
	   private String phone;
	   private String email;
	   private String postal_code;
	   private String contact_address;
	   private String detailed_address;
	   private String birth;
	   private int age; 
	   private String gender; 
	   private boolean agrStipulation1;
	   private boolean agrStipulation2;
	   private boolean agrStipulation3;
	   private int carrotpoint;
	   private int mileage;

    
	public MemberVO(){}


	public MemberVO(int fnum, int number, String userid, String pass, String name, String phone, String email,
			String postal_code, String contact_address, String detailed_address, String birth, int age, String gender,
			boolean agrStipulation1, boolean agrStipulation2, boolean agrStipulation3, int carrotpoint, int mileage) {
		super();
		this.fnum = fnum;
		this.number = number;
		this.userid = userid;
		this.pass = pass;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.postal_code = postal_code;
		this.contact_address = contact_address;
		this.detailed_address = detailed_address;
		this.birth = birth;
		this.age = age;
		this.gender = gender;
		this.agrStipulation1 = agrStipulation1;
		this.agrStipulation2 = agrStipulation2;
		this.agrStipulation3 = agrStipulation3;
		this.carrotpoint = carrotpoint;
		this.mileage = mileage;
	}


	public int getFnum() {
		return fnum;
	}
	public void setFnum(int fnum) {
		this.fnum = fnum;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPostal_code() {
		return postal_code;
	}
	public void setPostal_code(String postal_code) {
		this.postal_code = postal_code;
	}
	public String getContact_address() {
		return contact_address;
	}
	public void setContact_address(String contact_address) {
		this.contact_address = contact_address;
	}
	public String getDetailed_address() {
		return detailed_address;
	}
	public void setDetailed_address(String detailed_address) {
		this.detailed_address = detailed_address;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public boolean isAgrStipulation1() {
		return agrStipulation1;
	}
	public void setAgrStipulation1(boolean agrStipulation1) {
		this.agrStipulation1 = agrStipulation1;
	}
	public boolean isAgrStipulation2() {
		return agrStipulation2;
	}
	public void setAgrStipulation2(boolean agrStipulation2) {
		this.agrStipulation2 = agrStipulation2;
	}
	public boolean isAgrStipulation3() {
		return agrStipulation3;
	}
	public void setAgrStipulation3(boolean agrStipulation3) {
		this.agrStipulation3 = agrStipulation3;
	}
	public int getCarrotpoint() {
		return carrotpoint;
	}
	public void setCarrotpoint(int carrotpoint) {
		this.carrotpoint = carrotpoint;
	}
	public int getMileage() {
		return mileage;
	}
	public void setMileage(int mileage) {
		this.mileage = mileage;
	}  
}
