package com.ezen.spring.board.teampro.carrotmarket;

import java.util.List;

public class CarrotVO {

	private int cnum;
	private String userid;
	private String saleuserid;
	private String cvrimg; 
	private float imgsize;
	private String imgtype;
	private int price;
	private String title;
	private String content; 
	private java.util.Date cdata;
	private int hitnum;
	private int number;
	private List<CarrotAttach> clist;
	private String state;
	private String payment;
	
	public CarrotVO() {}
	public CarrotVO(int cnum, String userid, String saleuserid, String cvrimg, float imgsize, String imgtype, int price, String title,
			String content, java.util.Date cdata, int hitnum, int number, List<CarrotAttach> clist,String state,String payment) {
		super();
		this.saleuserid = saleuserid;
		this.cnum = cnum;
		this.userid = userid;
		this.cvrimg = cvrimg;
		this.imgsize = imgsize;
		this.imgtype = imgtype;
		this.price = price;
		this.title = title;
		this.content = content;
		this.cdata = cdata;
		this.hitnum = hitnum;
		this.number = number;
		this.clist = clist;
		this.state = state;
		this.payment = payment;
	}
	
	
	
	@Override
	public String toString() {
		return "CarrotVO [cnum=" + cnum + ", userid=" + userid + ", cvrimg=" + cvrimg + ", imgsize=" + imgsize
				+ ", imgtype=" + imgtype + ", price=" + price + ", title=" + title + ", content=" + content + ", cdata="
				+ cdata + ", hitnum=" + hitnum + ", number=" + number + ", clist=" + clist + ", state=" + state + "]";
	}
	
	
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
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
	
	public String getSaleuserid() {
		return saleuserid;
	}
	public void setSaleuserid(String saleuserid) {
		this.saleuserid = saleuserid;
	}
	public String getCvrimg() {
		return cvrimg;
	}
	public void setCvrimg(String cvrimg) {
		this.cvrimg = cvrimg;
	}
	public float getImgsize() {
		return imgsize;
	}
	public void setImgsize(float imgsize) {
		this.imgsize = imgsize;
	}
	public String getImgtype() {
		return imgtype;
	}
	public void setImgtype(String imgtype) {
		this.imgtype = imgtype;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.util.Date getCdata() {
		return cdata;
	}
	public void setCdata(java.util.Date cdata) {
		this.cdata = cdata;
	}
	public int getHitnum() {
		return hitnum;
	}
	public void setHitnum(int hitnum) {
		this.hitnum = hitnum;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public List<CarrotAttach> getClist() {
		return clist;
	}
	public void setClist(List<CarrotAttach> clist) {
		this.clist = clist;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	
}
