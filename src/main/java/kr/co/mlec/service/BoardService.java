package kr.co.mlec.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.mlec.vo.BoardVO;
import kr.co.mlec.vo.CommentVO;
import kr.co.mlec.vo.PageVO;

public interface BoardService {
	
	public int boardCount(HttpServletRequest request) throws Exception;
	
	public List<BoardVO> boardList(HttpServletRequest request, PageVO pv) throws Exception;
	
	public int insertBoard(MultipartHttpServletRequest mRequest) throws Exception;
	
	public BoardVO detailBoard(int no) throws Exception;
	
	public void updateBoard(BoardVO bv) throws Exception;
	
	public void deleteBoard(int no) throws Exception;
	
	public List<CommentVO> commentList(int no) throws Exception;
	
	public int commentCount(int no) throws Exception;
	
	public void insertComment(CommentVO cv) throws Exception;
	
	public void delComment(CommentVO cv) throws Exception;
	
	public void updateComment(int board_no, CommentVO cv) throws Exception;
	
	public void insertCommentOfComment(int board_no, CommentVO cv) throws Exception;
}
