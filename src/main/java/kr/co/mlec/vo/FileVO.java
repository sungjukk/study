package kr.co.mlec.vo;

public class FileVO {
	private int file_no;
	private int board_no;
	private int board_type;
	private String filePath;
	private String oriName;
	private String sysName;
	
	
	
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getBoard_type() {
		return board_type;
	}
	public void setBoard_type(int board_type) {
		this.board_type = board_type;
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
	@Override
	public String toString() {
		return "FileVO [file_no=" + file_no + ", board_no=" + board_no + ", board_type=" + board_type + ", filePath="
				+ filePath + ", oriName=" + oriName + ", sysName=" + sysName + "]";
	}
	
	
}
