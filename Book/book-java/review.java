package com.ezen.spring.board.teampro.book;

import java.util.*;

import org.springframework.stereotype.Component;


@Component("review")
public class review {
	private int bnum;
	private String bname;
	private String userid;
	private String reviewcontents;
	private int score;
	private java.util.Date rdate = new Date();
	private int count;
	public review(){}
	public review(int bnum, String bname, String userid, String reviewcontents, int score, Date rdate,int count) {
		super();
		this.bnum = bnum;
		this.bname = bname;
		this.userid = userid;
		this.reviewcontents = reviewcontents;
		this.score = score;
		this.rdate = rdate;
		this.count = count;
	}
	
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
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
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getReviewcontents() {
		return reviewcontents;
	}
	public void setReviewcontents(String reviewcontents) {
		this.reviewcontents = reviewcontents;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public java.util.Date getRdate() {
		return rdate;
	}
	public void setRdate(java.util.Date rdate) {
		this.rdate = rdate;
	}
	
	
}
