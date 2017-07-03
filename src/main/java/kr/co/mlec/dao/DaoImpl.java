package kr.co.mlec.dao;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.mlec.vo.MemberVO;

@Repository
public class DaoImpl implements Dao{
	private static final Logger logger = LoggerFactory.getLogger(DaoImpl.class);
	
	@Inject
	private SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "kr.co.mlec.loginMapper.";
	
	@Override
	public MemberVO login(MemberVO mv) throws Exception {
		return sqlSessionTemplate.selectOne(namespace + "getMember", mv);
	}
	
	@Override
	public void test() throws Exception {
		String a = sqlSessionTemplate.selectOne("kr.co.mlec.loginMapper.getUserId");
	}
	@Override
	public MemberVO checkId(String id) throws Exception {
		return sqlSessionTemplate.selectOne(namespace + "checkId", id);
	}
	@Override
	public int newMember(MemberVO mv) throws Exception {
		return sqlSessionTemplate.insert(namespace + "newMember", mv);
	}

	@Override
	public void modUser(MemberVO mv) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.update(namespace + "modUser", mv);
	}
}
