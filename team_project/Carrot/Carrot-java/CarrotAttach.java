package com.ezen.spring.board.teampro.carrotmarket;

public class CarrotAttach {

	private int num;
	private int cnum;
	private String contimg1;
	private float contsize1; 
	private String conttype1; 
	
	public CarrotAttach() {}

	public CarrotAttach(int num, int cnum, String contimg1, float contsize1, String conttype1) {
		super();
		this.num = num;
		this.cnum = cnum;
		this.contimg1 = contimg1;
		this.contsize1 = contsize1;
		this.conttype1 = conttype1;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
	}

	public String getContimg1() {
		return contimg1;
	}

	public void setContimg1(String contimg1) {
		this.contimg1 = contimg1;
	}

	public float getContsize1() {
		return contsize1;
	}

	public void setContsize1(float contsize1) {
		this.contsize1 = contsize1;
	}

	public String getConttype1() {
		return conttype1;
	}

	public void setConttype1(String conttype1) {
		this.conttype1 = conttype1;
	}
	
	
}
