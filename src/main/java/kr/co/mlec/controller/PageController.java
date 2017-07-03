package kr.co.mlec.controller;

import kr.co.mlec.vo.PageVO;

public class PageController {
	private int page_no;
	
	public int getPage_no() {
		return page_no;
	}

	public void setPage_no(int page_no) {
		this.page_no = page_no;
	}

	public PageVO initPage(int pageNo, int pageSize, float listSize) {
		PageVO pv = new PageVO();
		pv.setPageNoCnt((int)Math.ceil(listSize/pageSize));
		if (pv.getPageNoCnt() == 0) {
			pv.setPageNoCnt(1);
		}
		
		pv.setPageSize(pageSize);
		pv.setPageCnt(pageNo);
		if (pageNo == 0 || pageNo == 1) {
			pv.setfCnt(1);
			pv.setlCnt(pv.getPageSize());			
		} else {
			pv.setlCnt(pageNo * pv.getPageSize());
			pv.setfCnt(pv.getlCnt() - (pv.getPageSize()) + 1);
		}
		return pv;
	}
}
