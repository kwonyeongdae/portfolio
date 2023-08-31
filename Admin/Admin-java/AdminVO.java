package com.ezen.spring.board.teampro.admin;

import org.springframework.stereotype.Component;

@Component("adminvo")
public class AdminVO {

	private int num;
	private int bnum;
	private String year;
	private String month;
	private String day;
	private int total;
	private String bname;
	private String buyday;
	private String statu;
	private int price;
	private int quantity;
	private int totalquantity;
	private String userid;
	private String payment;
	public AdminVO() {}
	
	public AdminVO(int num, int bnum, String year, String month, String day, int total, String bname, String buyday,String statu,
			int price, int quantity, int totalquantity, String userid, String payment) {
		super();
		this.num = num;
		this.bnum = bnum;
		this.year = year;
		this.month = month;
		this.day = day;
		this.total = total;
		this.bname = bname;
		this.buyday = buyday;
		this.statu = statu;
		this.price = price;
		this.quantity = quantity;
		this.totalquantity = totalquantity;
		this.userid = userid;
		this.payment = payment;
	}




	public String getStatu() {
		return statu;
	}
	public void setStatu(String statu) {
		this.statu = statu;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public int getTotalquantity() {
		return totalquantity;
	}
	public void setTotalquantity(int totalquantity) {
		this.totalquantity = totalquantity;
	}
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getBuyday() {
		return buyday;
	}
	public void setBuyday(String buyday) {
		this.buyday = buyday;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	
	
}
