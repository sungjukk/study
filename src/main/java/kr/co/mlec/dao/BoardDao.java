package kr.co.mlec.dao;

import java.util.List;
import java.util.Map;

import kr.co.mlec.vo.BoardVO;
import kr.co.mlec.vo.CommentVO;
import kr.co.mlec.vo.FileVO;

public interface BoardDao {
	
	public int boardCount(Map<String,Object> params) throws Exception;
	
	public List<BoardVO> boardList(Map<String,Object> params) throws Exception;
	
	public int insertBoard(BoardVO bv) throws Exception;
	
	public BoardVO detailBoard(int no) throws Exception;
	
	public void updateBoard(BoardVO bv) throws Exception;
	
	public void deleteBoard(int no) throws Exception;
	
	public int insertFile(FileVO fv) throws Exception;
	
	public List<FileVO> getBoardFile(BoardVO bv) throws Exception; 
	
	public List<CommentVO> commentList(int no) throws Exception;
	
	public int commentCount(int no) throws Exception;
	
	public void insertComment(CommentVO cv) throws Exception;
	
	public void delComment(CommentVO cv) throws Exception;
	
	public void updateComment(CommentVO cv) throws Exception;
	
	public void insertCommentOfComment(CommentVO cv) throws Exception;
	
	public int isChildComment(CommentVO cv) throws Exception;
	
	public CommentVO isBrother(int no) throws Exception;
	
	public CommentVO parentsComment(int no) throws Exception;
	
	public void completeDelComment(CommentVO cv) throws Exception;
}
