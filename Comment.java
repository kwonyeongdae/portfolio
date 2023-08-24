package com.ezen.spring.board.teampro.board2;

import org.springframework.stereotype.Component;

@Component
public class Comment {
	
	private int bnum;
	private String name;
	private String comcontent;
	private String data;
	
	public Comment(int bnum, String name, String comcontent, String data) {
		super();
		this.bnum = bnum;
		this.name = name;
		this.comcontent = comcontent;
		this.data = data;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getComcontent() {
		return comcontent;
	}
	public void setComcontent(String comcontent) {
		this.comcontent = comcontent;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	
	
}

