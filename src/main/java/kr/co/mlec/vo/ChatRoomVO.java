package kr.co.mlec.vo;

import java.util.Date;

public class ChatRoomVO {
	private int cno;
	private String enter_usrno;
	private String user_list;
	private Date createDate;
	
	
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getEnter_usrno() {
		return enter_usrno;
	}
	public void setEnter_usrno(String enter_usrno) {
		this.enter_usrno = enter_usrno;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getUser_list() {
		return user_list;
	}
	public void setUser_list(String user_list) {
		this.user_list = user_list;
	}
	
	
}
