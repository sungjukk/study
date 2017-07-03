package kr.co.mlec.util;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.mlec.vo.FileVO;

@Repository
public class DownloadDAO {
	
	@Inject
	private SqlSessionTemplate sqlSessionTemplate;
	
	public FileVO getFile(int no) {
		return sqlSessionTemplate.selectOne("kr.co.mlec.fileMapper.getFile", no);
	}
}
