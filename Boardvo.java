package com.ezen.spring.board.teampro.board2;

import java.util.*;

import org.springframework.stereotype.Component;

@Component("board")
public class Boardvo {
	private int bnum;
    private String bname;
    private String title;
    private String content;
    private java.util.Date date = new Date();
    private int hitnum;
    private List<FileVO> flist;
    private List<Comment> clist;
    private String pass;
    private String name;
    
    public Boardvo() {}
	public Boardvo(int bnum, String bname, String title, String content, Date date, int hitnum, List<FileVO> flist,List<Comment> clist,String pass,String name) {
		super();
		this.bnum = bnum;
		this.bname = bname;
		this.title = title;
		this.content = content;
		this.date = date;
		this.hitnum = hitnum;
		this.flist = flist;
		this.clist = clist;
		this.pass = pass;
		this.name = name;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public List<Comment> getClist() {
		return clist;
	}
	public void setClist(List<Comment> clist) {
		this.clist = clist;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
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
	public java.util.Date getDate() {
		return date;
	}
	public void setDate(java.util.Date date) {
		this.date = date;
	}
	public int getHitnum() {
		return hitnum;
	}
	public void setHitnum(int hitnum) {
		this.hitnum = hitnum;
	}
	public List<FileVO> getFlist() {
		return flist;
	}
	public void setFlist(List<FileVO> flist) {
		this.flist = flist;
	}
    
}
