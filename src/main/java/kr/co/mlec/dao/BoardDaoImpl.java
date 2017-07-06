package kr.co.mlec.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.mlec.vo.BoardVO;
import kr.co.mlec.vo.CommentVO;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.PageVO;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Inject
	private SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "kr.co.mlec.boardMapper.";
	
	@Override
	public List<BoardVO> boardList(Map<String,Object> params) throws Exception {
		return sqlSessionTemplate.selectList(namespace + "boardList",params);
	}

	@Override
	public int insertBoard(BoardVO bv) throws Exception {
		int result = sqlSessionTemplate.insert(namespace + "insertBoard", bv);
		return bv.getBoard_no();
	}

	@Override
	public BoardVO detailBoard(int no) throws Exception {
		sqlSessionTemplate.update(namespace + "upCnt", no);
		return sqlSessionTemplate.selectOne(namespace + "detailBoard", no);
	}

	@Override
	public void updateBoard(BoardVO bv) throws Exception {
		sqlSessionTemplate.update(namespace + "updateBoard", bv);
	}

	@Override
	public void deleteBoard(int no) throws Exception {
		sqlSessionTemplate.delete(namespace + "deleteBoard", no);
	}

	@Override
	public int boardCount(Map<String,Object> params) throws Exception {
		return sqlSessionTemplate.selectOne(namespace + "boardCount", params);
	}

	@Override
	public int insertFile(FileVO fv) throws Exception {
		System.out.println(fv.toString());
		return sqlSessionTemplate.insert(namespace + "insertFile", fv);
	}

	@Override
	public List<FileVO> getBoardFile(BoardVO bv) throws Exception {
		return sqlSessionTemplate.selectList(namespace + "getBoardFile", bv);
	}

	@Override
	public List<CommentVO> commentList(int no) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList(namespace + "commentList", no);
	}

	@Override
	public void insertComment(CommentVO cv) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.insert(namespace + "insertComment", cv);
	}

	@Override
	public void delComment(CommentVO cv) throws Exception {
		// TODO Auto-generated method stub
		cv.setCno(0);
		cv.setParents_no(cv.getComment_no());
		//sqlSessionTemplate.update(namespace + "updateCommentSeq", cv);
		//CommentVO isChild = sqlSessionTemplate.selectOne(namespace+"isChildComment", comment_no);
		sqlSessionTemplate.update(namespace + "delCommentY", cv.getComment_no());			
//		sqlSessionTemplate.delete(namespace + "delComment", comment_no);
	}

	@Override
	public void updateComment(CommentVO cv) throws Exception {
		sqlSessionTemplate.update(namespace + "updateComment", cv);		
	}

	@Override
	public void insertCommentOfComment(CommentVO cv) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.update(namespace + "updateCommentSeq", cv);
		sqlSessionTemplate.insert(namespace + "insertCommentOfComment", cv);
	}

	@Override
	public int commentCount(int no) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(namespace + "commentCount", no);
	}

	@Override
	public int isChildComment(CommentVO cv) throws Exception {
		return sqlSessionTemplate.selectOne(namespace + "isChild", cv);
	}

	@Override
	public CommentVO isBrother(int no) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(namespace + "isBrother", no);
	}

	@Override
	public CommentVO parentsComment(int no) throws Exception {
		return sqlSessionTemplate.selectOne(namespace + "selectOneComment", no);
	}

	@Override
	public void completeDelComment(CommentVO cv) throws Exception {
		// TODO Auto-generated method stub
		cv.setCno(0);
		cv.setParents_no(cv.getComment_no());
		sqlSessionTemplate.update(namespace + "updateCommentSeq", cv);
		sqlSessionTemplate.delete(namespace + "delComment", cv.getComment_no());
	}
}
