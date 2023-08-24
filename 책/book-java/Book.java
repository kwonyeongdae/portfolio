package com.ezen.spring.board.teampro.book;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ezen.spring.board.teampro.board2.FileVO;
import com.ezen.spring.board.teampro.cart.BookVO;

@Component("book")
public class Book {
	private int bnum;
	private String bname;
	private float fsize;
	private  String contenttype;
    private String publisher;
	private String author;
	private int price;
	private String pdate;
	private String content;
	private String cvrimg;
	private String cate;
	private List<Bookattach> flist;

	
	public Book() {};
	public Book(int bnum, String bname, float fsize, String contenttype, String publisher, String author, int price,
			String pdate, String content, String cvrimg,
			String cate,List<Bookattach> flist) {
		super();
		this.bnum = bnum;
		this.bname = bname;
		this.fsize = fsize;
		this.contenttype = contenttype;
		this.publisher = publisher;
		this.author = author;
		this.price = price;
		this.pdate = pdate;
		this.content = content;
		this.cvrimg = cvrimg;
		this.cate = cate;
		this.flist = flist;

	}

	public List<Bookattach> getFlist() {
		return flist;
	}
	public void setFlist(List<Bookattach> flist) {
		this.flist = flist;
	}
	public float getFsize() {
		return fsize;
	}
	public void setFsize(float fsize) {
		this.fsize = fsize;
	}
	public String getContenttype() {
		return contenttype;
	}
	public void setContenttype(String contenttype) {
		this.contenttype = contenttype;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	public int getBnum() {
		return bnum;
	}
	
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getCvrimg() {
		return cvrimg;
	}

	public void setCvrimg(String cvrimg) {
		this.cvrimg = cvrimg;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPdate() {
		return pdate;
	}

	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	
}