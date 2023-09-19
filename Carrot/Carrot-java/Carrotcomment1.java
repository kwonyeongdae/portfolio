package com.ezen.spring.board.teampro.carrotmarket;

public class Carrotcomment1 {

	private int num;
	private int dcarnum;
	private String duserid;
	private String dcomment;
	private String dcardata;
	
	public Carrotcomment1() {}
	public Carrotcomment1(int num,int dcarnum, String duserid, String dcomment, String dcardata) {
		super();
		this.num = num;
		this.dcarnum = dcarnum;
		this.duserid = duserid;
		this.dcomment = dcomment;
		this.dcardata = dcardata;
	}
	
	
	@Override
	public String toString() {
		return "Carrotcomment1 [num=" + num + ", dcarnum=" + dcarnum + ", duserid=" + duserid + ", dcomment=" + dcomment
				+ ", dcardata=" + dcardata + "]";
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getDcarnum() {
		return dcarnum;
	}
	public void setDcarnum(int dcarnum) {
		this.dcarnum = dcarnum;
	}
	public String getDuserid() {
		return duserid;
	}
	public void setDuserid(String duserid) {
		this.duserid = duserid;
	}
	public String getDcomment() {
		return dcomment;
	}
	public void setDcomment(String dcomment) {
		this.dcomment = dcomment;
	}
	public String getDcardata() {
		return dcardata;
	}
	public void setDcardata(String dcardata) {
		this.dcardata = dcardata;
	}

	
}
