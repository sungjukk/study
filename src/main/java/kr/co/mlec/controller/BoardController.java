package kr.co.mlec.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.mlec.service.BoardService;
import kr.co.mlec.util.FileUpload;
import kr.co.mlec.vo.BoardVO;
import kr.co.mlec.vo.CommentVO;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.PageVO;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	private int pageSize = 10;
	
	private PageVO pv = new PageVO();
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView boardMain(HttpServletRequest request, HttpServletResponse response, String type, String pageNo) throws Exception {
		HttpSession session = request.getSession();
		System.out.println(type);
		System.out.println(pageNo);
		
		
		String page = (String)session.getAttribute("pageNo");
		int pageno = 1;
		if (page != null) {
			pageno = Integer.parseInt(page);
		}
		
		if (type != null) {
			pageno = Integer.parseInt(pageNo);
		}
		PageController pc = new PageController();
		ModelAndView mav = new ModelAndView();
		pv = pc.initPage(pageno, pageSize, (float)boardService.boardCount(request));
		mav.addObject("pv", pv);
		mav.addObject("boardList", boardService.boardList(request, pv));
		mav.setViewName("board/board");
		return mav;
	}
	
	@RequestMapping(value="/savePageNo", method = RequestMethod.POST)
	@ResponseBody
	public String savePageNo(HttpServletRequest request, String pageNo) throws Exception {
		HttpSession session = request.getSession();
		session.setAttribute("pageNo", pageNo);
		return "success";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String writeForm() {
		return "board/write";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String insertBoard(MultipartHttpServletRequest mRequest) throws Exception {
		return "redirect:/board/" + boardService.insertBoard(mRequest);
	}
	
	@RequestMapping(value = "/{no}", method = RequestMethod.GET)
	public ModelAndView detailBoard(@PathVariable("no") int no) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", boardService.detailBoard(no));
		mav.addObject("pageNo", pv.getPageCnt());
		mav.setViewName("board/detail");
		return mav;
	}
	
	@RequestMapping(value = "/{no}/mod", method = RequestMethod.GET)
	public ModelAndView updateForm(@PathVariable("no") int no) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("board", boardService.detailBoard(no));
		mav.setViewName("board/update");
		return mav;
	}
	
	@RequestMapping(value = "/{no}", method = RequestMethod.PUT)
	public String updateBoard(@PathVariable("no") int no, BoardVO bv) throws Exception {
		boardService.updateBoard(bv);
		return "redirect:/board/" + no;
	}
	
	@RequestMapping(value = "/{no}", method = RequestMethod.DELETE)
	public String deleteBoard(@PathVariable("no") int no) throws Exception {
		boardService.deleteBoard(no);
		return "redirect:/board";
	}
	
	@RequestMapping(value="/comment", method = RequestMethod.POST)
	public ModelAndView insertComment(CommentVO cv) throws Exception {
		ModelAndView mav = new ModelAndView("board/comment");
		boardService.insertComment(cv);
		Map<String,Object> map = getCommentList(cv.getBoard_no());
		mav.addObject("commentCount", map.get("count"));
		mav.addObject("commentList", map.get("list"));
		return mav;
	}
	
	@RequestMapping(value="/comment/{board_no}/{comment_no}/{first_seq}", method = RequestMethod.DELETE)
	public ModelAndView delComment(CommentVO cv) throws Exception {
		ModelAndView mav = new ModelAndView("board/comment");
		boardService.delComment(cv);
		Map<String,Object> map = getCommentList(cv.getBoard_no());
		mav.addObject("commentCount", map.get("count"));
		mav.addObject("commentList", map.get("list"));
		return mav;
	}
	
	@RequestMapping(value="/comment/{no}", method = RequestMethod.GET)
	public ModelAndView commentList(@PathVariable("no") int no) throws Exception {
		ModelAndView mav = new ModelAndView("board/comment");
		mav.addObject("commentCount", boardService.commentCount(no));
		mav.addObject("commentList", boardService.commentList(no));
		return mav; 
	}
	
	@RequestMapping(value="/comment/{no}", method = RequestMethod.PUT)
	public ModelAndView updateComment(@PathVariable("no") int no, CommentVO cv) throws Exception {
		ModelAndView mav = new ModelAndView("board/comment");
		boardService.updateComment(no, cv);
		Map<String,Object> map = getCommentList(no);
		mav.addObject("commentCount", map.get("count"));
		mav.addObject("commentList", map.get("list"));
		return mav; 
	}
	
	@RequestMapping(value="/comment/{no}", method = RequestMethod.POST)
	public ModelAndView insertCommentOfComment(@PathVariable("no") int no, CommentVO cv) throws Exception {
		ModelAndView mav = new ModelAndView("board/comment");
		boardService.insertCommentOfComment(no, cv);
		Map<String,Object> map = getCommentList(no);
		mav.addObject("commentCount", map.get("count"));
		mav.addObject("commentList", map.get("list"));
		return mav; 
	}
	
	public Map<String, Object> getCommentList(int no) throws Exception {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("count", boardService.commentCount(no));
		map.put("list", boardService.commentList(no));
		return map;
	}
	
	@RequestMapping(value = "/new/img", method = RequestMethod.POST)
	@ResponseBody
	public FileVO writeImg(MultipartHttpServletRequest mRequest) throws Exception {
		MultipartFile file = mRequest.getFile("uploadFile");
		return new FileUpload().fileUpload(file, 0, 2);
	}
}
