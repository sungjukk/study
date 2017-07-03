package kr.co.mlec.vo;

import java.util.Date;

public class CommentVO {
	private int cno;
	private int comment_no;
	private int board_no;
	private int usr_no;
	private String content;
	private Date reg_date;
	private String id;
	private String filePath;
	private String sysName;
	private String showDate;
	private int first_seq;
	private int sec_seq;
	private int parents_no;
	private String del_yn;
	private int cGroup;
	private String nickName;
	
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public int getComment_no() {
		return comment_no;
	}
	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getUsr_no() {
		return usr_no;
	}
	public void setUsr_no(int usr_no) {
		this.usr_no = usr_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getShowDate() {
		return showDate;
	}
	public void setShowDate(String showDate) {
		this.showDate = showDate;
	}
	public int getFirst_seq() {
		return first_seq;
	}
	public void setFirst_seq(int first_seq) {
		this.first_seq = first_seq;
	}
	public int getSec_seq() {
		return sec_seq;
	}
	public void setSec_seq(int sec_seq) {
		this.sec_seq = sec_seq;
	}
	public int getParents_no() {
		return parents_no;
	}
	public void setParents_no(int parents_no) {
		this.parents_no = parents_no;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public int getcGroup() {
		return cGroup;
	}
	public void setcGroup(int cGroup) {
		this.cGroup = cGroup;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
}
