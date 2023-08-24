package com.ezen.spring.board.teampro.book;

public class Qnacomment {

	private int num;
	private int qnum;
	private String name;
	private String qcomment;
	private String qnadate;
	
	public Qnacomment() {}
	public Qnacomment(int num, int qnum, String name, String qcomment, String qnadate) {
		super();
		this.num = num;
		this.qnum = qnum;
		this.name = name;
		this.qcomment = qcomment;
		this.qnadate = qnadate;
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getQnum() {
		return qnum;
	}
	public void setQnum(int qnum) {
		this.qnum = qnum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getQcomment() {
		return qcomment;
	}
	public void setQcomment(String qcomment) {
		this.qcomment = qcomment;
	}
	public String getQnadate() {
		return qnadate;
	}
	public void setQnadate(String qnadate) {
		this.qnadate = qnadate;
	}
	
	
}
