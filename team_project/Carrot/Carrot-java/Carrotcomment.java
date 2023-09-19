package com.ezen.spring.board.teampro.carrotmarket;

public class Carrotcomment {

	private int num;
	private int carnum;
	private String userid;
	private String comment;
	private String cardata;
	
	public Carrotcomment() {}
	public Carrotcomment(int num,int carnum, String userid, String comment, String cardata) {
		super();
		this.num = num;
		this.carnum = carnum;
		this.userid = userid;
		this.comment = comment;
		this.cardata = cardata;
	}
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getCarnum() {
		return carnum;
	}
	public void setCarnum(int carnum) {
		this.carnum = carnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCardata() {
		return cardata;
	}
	public void setCardata(String cardata) {
		this.cardata = cardata;
	}
	
	
}
