package kr.co.mlec.util;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.mlec.vo.FileVO;

@Service
public class DownloadService {
	
	@Inject
	private DownloadDAO dao;
	
	public FileVO getFile(int no) throws Exception {
		return dao.getFile(no);
	}
}
