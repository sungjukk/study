package kr.co.mlec.vo;

public class PageVO {
	/** 유저가 선택한 페이지 번호 */
	private int pageCnt;
	
	/** 게시글 검색 */
	private int fCnt;
	
	/** 게시글 검색  */
	private int lCnt;
	
	/** 출력될 게시글 개수 */
	private int pageSize;
	
	/** 페이지 번호 개수  */
	private int pageNoCnt;
	
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public int getfCnt() {
		return fCnt;
	}
	public void setfCnt(int fCnt) {
		this.fCnt = fCnt;
	}
	public int getlCnt() {
		return lCnt;
	}
	public void setlCnt(int lCnt) {
		this.lCnt = lCnt;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageNoCnt() {
		return pageNoCnt;
	}
	public void setPageNoCnt(int pageNoCnt) {
		this.pageNoCnt = pageNoCnt;
	}
	
	
	
}
