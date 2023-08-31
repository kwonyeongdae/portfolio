package com.ezen.spring.board.teampro.carrotmarket;

public class Interest {

	private int num;
	private int cnum;
	private String userid;
	private String mainimg;
	private String title;
	private String state;
	private int price;
	
	public Interest() {}
	public Interest(int num,int cnum, String userid, String mainimg, String title, String state,int price) {
		super();
		this.num= num;
		this.cnum = cnum;
		this.userid = userid;
		this.mainimg = mainimg;
		this.title = title;
		this.state = state;
		this.price = price;

	}
	
	
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getMainimg() {
		return mainimg;
	}
	public void setMainimg(String mainimg) {
		this.mainimg = mainimg;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	

}
