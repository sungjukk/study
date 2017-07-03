package kr.co.mlec.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.MemberVO;


public interface LoginService {
	public void test() throws Exception;
	
	public boolean Login(HttpServletRequest request, MemberVO mv) throws Exception;
	
	public boolean checkId(String id) throws Exception;
	
	public boolean newMember(MemberVO mv) throws Exception;
	
	public FileVO profileUpload(MultipartHttpServletRequest mRequest) throws Exception;
	
	public void modUser(MemberVO mv) throws Exception;
}
