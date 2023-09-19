package com.ezen.spring.board.teampro.cart;

import java.util.Objects;

import org.springframework.stereotype.Component;

@Component("VO")
public class BookVO {
	int num;
	int bnum;
	String bname;
	String name;
	String publisher;
	String author;
	int price;
	String pdate;
	String cvrimg;
	int quantity;
	int sum;
	String cate;
	private String userid;
	private int totalQuantity;
	private int totalPrice;
	long fsize;
	String contenttype;
	int mileage;
	private String payment;
	int age;
	
	public BookVO(){ 
		quantity = 0;
		}
	

	
	public BookVO(int num, int bnum, String bname, String name, String publisher, String author, int price,
			String pdate, String cvrimg, int quantity, int sum, String cate, String userid, int totalQuantity,
			int totalPrice, long fsize, String contenttype, int mileage, String payment,int age) {
		super();
		this.num = num;
		this.bnum = bnum;
		this.bname = bname;
		this.name = name;
		this.publisher = publisher;
		this.author = author;
		this.price = price;
		this.pdate = pdate;
		this.cvrimg = cvrimg;
		this.quantity = quantity;
		this.sum = sum;
		this.cate = cate;
		this.userid = userid;
		this.totalQuantity = totalQuantity;
		this.totalPrice = totalPrice;
		this.fsize = fsize;
		this.contenttype = contenttype;
		this.mileage = mileage;
		this.payment = payment;
		this.age = age;
	}

	@Override
	public int hashCode() {
		return Objects.hash(bname, userid);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookVO other = (BookVO) obj;
		return Objects.equals(bname, other.bname) && Objects.equals(userid, other.userid);
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "BookVO [bnum=" + bnum + ", bname=" + bname + ", publisher=" + publisher + ", author=" + author
				+ ", price=" + price + ", pdate=" + pdate + ", cvrimg=" + cvrimg + ", quantity=" + quantity + ", sum="
				+ sum + ", userid=" + userid + "]";
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
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
	
	
	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public long getFsize() {
		return fsize;
	}

	public void setFsize(long fsize) {
		this.fsize = fsize;
	}

	public String getContenttype() {
		return contenttype;
	}

	public void setContenttype(String contenttype) {
		this.contenttype = contenttype;
	}

	public String getCvrimg() {
		return cvrimg;
	}

	public void setCvrimg(String cvrimg) {
		this.cvrimg = cvrimg;
	}
	public int getTotalQuantity() {
        return totalQuantity;
    }
    
    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    // totalPrice에 대한 getter와 setter
    public int getTotalPrice() {
        return totalPrice;
    }
    
    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
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

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
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

	public int getMileage() {
		return mileage;
	}

	public void setMileage(int mileage) {
		this.mileage = mileage;
	}

	
}
