package kr.co.mlec.controller;

import java.io.PrintWriter;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.mlec.service.LoginService;
import kr.co.mlec.util.FileUpload;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.MemberVO;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/member")
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
/*	@RequestMapping(method = RequestMethod.GET)
	public String member() throws Exception {
		return "login/login";
	}*/
	
	@RequestMapping(method = RequestMethod.GET)
	public String memberMobile() throws Exception {
		return "login/loginMobile";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String Login(HttpServletRequest request,HttpServletResponse response,MemberVO mv) throws Exception {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw =  response.getWriter();
		if (loginService.Login(request, mv)) {
			return "redirect:/main";
		} else {
			pw.println("<script>");
			pw.println("alert('아이디를 확인해주세요');");
			pw.println("location.href='/member'");
			pw.println("</script>");
			pw.close();			
		}
		return "login/login";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String signIn() throws Exception {
		return "login/signIn";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	@ResponseBody
	public boolean newMember(MemberVO mv) throws Exception {
		return loginService.newMember(mv);
	}
	
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	@ResponseBody
	public boolean checkId(String id) throws Exception {
		return loginService.checkId(id);
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/main";
	}
	
	@RequestMapping(value = "/thumnail", method = RequestMethod.POST)
	@ResponseBody
	public FileVO profileUpload(MultipartHttpServletRequest mRequest) throws Exception {
		return loginService.profileUpload(mRequest);
	}
	
	@RequestMapping(value = "/mod")
	public String modUser() throws Exception {
		return "login/signIn";
	}
	@RequestMapping(value = "/{no}/mod", method = RequestMethod.PUT)
	@ResponseBody
	public String modUser(MemberVO mv, HttpServletRequest request) throws Exception {
		loginService.modUser(mv);
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		session.setAttribute("member", mv);
		return "success";
	}
}
