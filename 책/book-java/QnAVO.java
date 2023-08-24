package com.ezen.spring.board.teampro.book;

public class QnAVO {
	private int qnum;
	private String userid;
	private String qcontent;
	private String qnadate;
	
	public QnAVO() {}
	public QnAVO(int qnum, String userid, String qcontent, String qnadate) {
		super();
		this.qnum = qnum;
		this.userid = userid;
		this.qcontent = qcontent;
		this.qnadate = qnadate;
	}
	public int getQnum() {
		return qnum;
	}
	public void setQnum(int qnum) {
		this.qnum = qnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getQcontent() {
		return qcontent;
	}
	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}
	public String getQnadate() {
		return qnadate;
	}
	public void setQnadate(String qnadate) {
		this.qnadate = qnadate;
	}
	
}
