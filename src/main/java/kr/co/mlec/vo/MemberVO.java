package kr.co.mlec.vo;

public class MemberVO {
	private int usr_no;
	private String id;
	private String pw;
	private String filePath;
	private String oriName;
	private String sysName;
	private String nickName;
	
	public int getUsr_no() {
		return usr_no;
	}
	public void setUsr_no(int usr_no) {
		this.usr_no = usr_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
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
	
}
