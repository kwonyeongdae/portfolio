package com.ezen.spring.board.teampro.board2;

import java.util.List;

import org.springframework.stereotype.Component;

@Component("FileVO")
public class FileVO {

    int num;
    int pnum;
    String fname;
    float fsize;
    String contentType;
    

    public FileVO() {}
    public FileVO(int num, int pnum, String fname, float fsize, String contentType) {
        super();
        this.num = num;
        this.pnum = pnum;
        this.fname = fname;
        this.fsize = fsize;
        this.contentType = contentType;
    }

    public int getNum() {
        return num;
    }
    public void setNum(int num) {
        this.num = num;
    }
    public int getPnum() {
        return pnum;
    }
    public void setPnum(int pnum) {
        this.pnum = pnum;
    }
    public String getFname() {
        return fname;
    }
    public void setFname(String fname) {
        this.fname = fname;
    }
    public float getFsize() {
        return fsize;
    }
    public void setFsize(float fsize) {
        this.fsize = fsize;
    }
    public String getContentType() {
        return contentType;
    }
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
}
