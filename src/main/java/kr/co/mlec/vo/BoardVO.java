package kr.co.mlec.vo;

import java.util.Date;
import java.util.List;

public class BoardVO {
	private int bnum;
	private int board_no;
	private int board_type;
	private String title;
	private String content;
	private String writer;
	private int usr_no;
	private Date reg_date;
	private int cnt;
	private int c_count;
	private List<FileVO> fList;
	
	
	
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getBoard_type() {
		return board_type;
	}
	public void setBoard_type(int board_type) {
		this.board_type = board_type;
	}
	public List<FileVO> getfList() {
		return fList;
	}
	public void setfList(List<FileVO> fList) {
		this.fList = fList;
	}
	public int getC_count() {
		return c_count;
	}
	public void setC_count(int c_count) {
		this.c_count = c_count;
	}
	public int getUsr_no() {
		return usr_no;
	}
	public void setUsr_no(int usr_no) {
		this.usr_no = usr_no;
	}
	
}
