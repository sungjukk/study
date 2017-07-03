package kr.co.mlec.dao;

import kr.co.mlec.vo.MemberVO;

public interface Dao {
	public void test() throws Exception;
	
	public MemberVO login(MemberVO mv) throws Exception;
	
	public MemberVO checkId(String id) throws Exception;
	
	public int newMember(MemberVO mv) throws Exception;
	
	public void modUser(MemberVO mv) throws Exception;
}
