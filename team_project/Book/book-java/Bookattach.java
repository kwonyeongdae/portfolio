package com.ezen.spring.board.teampro.book;

public class Bookattach {

	private int num;
	private int bnum;
	private String contentimg;
	private float consize;
	private String contype;
	
	public Bookattach() {}
	public Bookattach(int num,int bnum, String contentimg, float consize, String contype) {
		super();
		this.num = num;
		this.bnum = bnum;
		this.contentimg = contentimg;
		this.consize = consize;
		this.contype = contype;
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
	public String getContentimg() {
		return contentimg;
	}
	public void setContentimg(String contentimg) {
		this.contentimg = contentimg;
	}
	public float getConsize() {
		return consize;
	}
	public void setConsize(float consize) {
		this.consize = consize;
	}
	public String getContype() {
		return contype;
	}
	public void setContype(String contype) {
		this.contype = contype;
	}
	
	
}
