package kr.co.mlec.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.mlec.vo.MemberVO;

public class LoginFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		
		
		String getUrl = request.getRequestURI();
		String[] url = getUrl.split("\\.");
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		if (member != null || url.length != 1 || url[0].startsWith("/main") || url[0].equals("/") || url[0].equals("/image") || url[0].startsWith("/member") || url[0].startsWith("/overwatch")) {
			chain.doFilter(req, res);
		} else {
			response.sendRedirect("/main");
			return;
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
