package kr.co.mlec.service;

import java.io.File;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.mlec.dao.Dao;
import kr.co.mlec.util.FileUpload;
import kr.co.mlec.util.SecurityCryptograph;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.MemberVO;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Inject
	private Dao dao;
	
	private String baseFilePath = "c://study"; 
	
	SecurityCryptograph sc = new SecurityCryptograph();
	
	@Override
	public void test() throws Exception {
		dao.test();
	}
	
	@Override
	public boolean Login(HttpServletRequest request, MemberVO mv) throws Exception {
		mv.setPw(sc.encodingMD5(mv.getPw()));
		MemberVO getMember = dao.login(mv);
		if (getMember != null) {
			HttpSession session = request.getSession();
			session.setAttribute("member", getMember);
			return true;
		}
		return false;
	}

	@Override
	public boolean checkId(String id) throws Exception {
		MemberVO mv = dao.checkId(id);
		if (mv == null) {
			return true;
		}
		return false;
	}

	@Override
	public boolean newMember(MemberVO mv) throws Exception {
		// �н����� ��ȣȭ
		mv.setPw(sc.encodingMD5(mv.getPw()));
		if (dao.newMember(mv) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public FileVO profileUpload(MultipartHttpServletRequest mRequest) throws Exception {
		String beforeThum = mRequest.getParameter("beforeThum");
		new File(baseFilePath + beforeThum).delete();
		MultipartFile file = mRequest.getFile("profileImg");
		return new FileUpload().fileUpload(file, 0, 2);
	}

	@Override
	public void modUser(MemberVO mv) throws Exception {
		mv.setPw(sc.encodingMD5(mv.getPw()));
		dao.modUser(mv);
	}
}
