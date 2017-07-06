package kr.co.mlec.vo;

import java.util.Date;

public class ChatRoomDetailVO {
	private int cno;
	private int chat_seq;
	private int send_usrno;
	private String recive_usrno;
	private String content;
	private int isRead;
	private Date send_date;
	private int reciveNo;
	private String filePath;
	private String sysName;
	private String nickName;
	private int readCnt;
	private int file_no;
	private String sendFilePath;
	private String sendOriName;
	private String sendSysName;
	
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
	public Date getSend_date() {
		return send_date;
	}
	public void setSend_date(Date send_date) {
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
	public int getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	
	public String getSendFilePath() {
		return sendFilePath;
	}
	public void setSendFilePath(String sendFilePath) {
		this.sendFilePath = sendFilePath;
	}
	public String getSendOriName() {
		return sendOriName;
	}
	public void setSendOriName(String sendOriName) {
		this.sendOriName = sendOriName;
	}
	public String getSendSysName() {
		return sendSysName;
	}
	public void setSendSysName(String sendSysName) {
		this.sendSysName = sendSysName;
	}
	
}
