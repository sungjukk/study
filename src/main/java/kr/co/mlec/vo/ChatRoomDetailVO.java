package kr.co.mlec.vo;

import java.util.Date;

public class ChatRoomDetailVO {
	private int cno;
	private int chat_seq;
	private int send_usrno;
	private String recive_usrno;
	private String content;
	private int isRead;
	private String send_date;
	private int reciveNo;
	private String filePath;
	private String sysName;
	private String nickName;
	
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public int getChat_seq() {
		return chat_seq;
	}
	public void setChat_seq(int chat_seq) {
		this.chat_seq = chat_seq;
	}
	public int getSend_usrno() {
		return send_usrno;
	}
	public void setSend_usrno(int send_usrno) {
		this.send_usrno = send_usrno;
	}
	public String getRecive_usrno() {
		return recive_usrno;
	}
	public void setRecive_usrno(String recive_usrno) {
		this.recive_usrno = recive_usrno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getIsRead() {
		return isRead;
	}
	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	public int getReciveNo() {
		return reciveNo;
	}
	public void setReciveNo(int reciveNo) {
		this.reciveNo = reciveNo;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getSysName() {
		return sysName;
	}
	public void setSysName(String sysName) {
		this.sysName = sysName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	@Override
	public String toString() {
		return "ChatRoomDetailVO [cno=" + cno + ", chat_seq=" + chat_seq + ", send_usrno=" + send_usrno
				+ ", recive_usrno=" + recive_usrno + ", content=" + content + ", isRead=" + isRead + ", send_date="
				+ send_date + "]";
	}
	
	
}
