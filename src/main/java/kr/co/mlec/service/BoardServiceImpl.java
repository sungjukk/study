package kr.co.mlec.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.mlec.dao.BoardDao;
import kr.co.mlec.util.DateCalculation;
import kr.co.mlec.util.FileUpload;
import kr.co.mlec.vo.BoardVO;
import kr.co.mlec.vo.CommentVO;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.PageVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDao dao;
	
	@Autowired
	private ServletContext servletContext;
	
	@Override
	public List<BoardVO> boardList(HttpServletRequest request,PageVO pv) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("pageInfo", pv);
		if (request.getParameter("searchContent") != null) {
			if (!request.getParameter("searchContent").equals("")) {
				params.put("searchType", request.getParameter("searchType"));
				params.put("searchContent", request.getParameter("searchContent"));			
			}			
		}
		return dao.boardList(params);
	}
	
	@Override
	public int insertBoard(MultipartHttpServletRequest mRequest) throws Exception {
		BoardVO bv = new BoardVO();
		bv.setTitle(mRequest.getParameter("title"));
		bv.setContent(mRequest.getParameter("content"));
		bv.setUsr_no(Integer.parseInt(mRequest.getParameter("usr_no")));
		
		int board_no = dao.insertBoard(bv);
		
		MultipartFile file = mRequest.getFile("file");
		
		FileVO fv = new FileUpload().fileUpload(file, board_no, 1);
		
		dao.insertFile(fv);
		
/*		SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd");
		String datePath = sdf.format(new Date());
		String savePath = "c://study" + datePath;
		
		File f = new File(savePath);
		
		if (!f.exists()) f.mkdirs();
		
		Iterator<String> iter = mRequest.getFileNames();
		while (iter.hasNext()) {
			String formFileName = iter.next();
			MultipartFile mFile = mRequest.getFile(formFileName);
			
			String oriFileName = mFile.getOriginalFilename();
			
			if (oriFileName != null && !oriFileName.equals("")) {
				String ext = "";
				int index = oriFileName.lastIndexOf(".");
				if (index != -1) {
					ext = oriFileName.substring(index);
				}
				String saveFileName = new SimpleDateFormat("yyyyMMdd").format(new Date()) + UUID.randomUUID().toString() + ext;
				FileVO fv = new FileVO();
				fv.setBoard_no(board_no);
				fv.setBoard_type(1);
				fv.setFilePath(datePath);
				fv.setOriName(oriFileName);
				fv.setSysName(saveFileName);
				if (dao.insertFile(fv) == 1) {
					mFile.transferTo(new File(savePath + "/" + saveFileName));					
				}
			}
		}*/
		return board_no;
	}

	@Override
	public BoardVO detailBoard(int no) throws Exception {
		BoardVO bv = dao.detailBoard(no);
		bv.setfList(dao.getBoardFile(bv));
		return bv;
	}

	@Override
	public void updateBoard(BoardVO bv) throws Exception {
		dao.updateBoard(bv);
	}

	@Override
	public void deleteBoard(int no) throws Exception {
		dao.deleteBoard(no);
	}

	@Override
	public int boardCount(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> params = new HashMap<String, Object>();
		if (request.getParameter("searchContent") != null) {
			if (!request.getParameter("searchContent").equals("")) {
				params.put("searchType", request.getParameter("searchType"));
				params.put("searchContent", request.getParameter("searchContent"));			
			}			
		}
		return dao.boardCount(params);
	}

	@Override
	public List<CommentVO> commentList(int no) throws Exception {
		List<CommentVO> cl = dao.commentList(no);
		DateCalculation dc = new DateCalculation();
		for (CommentVO cv : cl) {
			cv.setShowDate(dc.DateCalculation(cv.getReg_date()));
		}
		return cl;
	}

	@Override
	public void insertComment(CommentVO cv) throws Exception {
		// TODO Auto-generated method stub
		dao.insertComment(cv);
	}

	@Override
	public void delComment(CommentVO cv) throws Exception {
		// TODO Auto-generated method stub
		
		int isChild = dao.isChildComment(cv);
		CommentVO delCv = dao.parentsComment(cv.getComment_no());
		if (isChild == 0) {
			if (delCv.getParents_no() == 0) {
				dao.completeDelComment(delCv);
			} else {	
				CommentVO bComment = dao.isBrother(cv.getComment_no());
				if (bComment != null) {
					dao.completeDelComment(cv);						
				} else {
					dao.completeDelComment(cv);	
					int parent_no = delCv.getParents_no();
					for (int i = cv.getFirst_seq(); i >= 1; i--) {
						CommentVO pComment = dao.parentsComment(parent_no);
						if (pComment.getDel_yn().equals("N")) {
							break;
						} else {
							CommentVO pbComment = dao.isBrother(pComment.getComment_no());
							if (pbComment != null) {
								dao.completeDelComment(pComment);
								break;
							} else {
								parent_no = pComment.getParents_no();
								dao.completeDelComment(pComment);
								if (parent_no == 0) {
									break;
								}
							}
						}
					}
				}
			}
		} else {
			dao.delComment(cv);			
		}
	}

	@Override
	public void updateComment(int board_no, CommentVO cv) throws Exception {
		// TODO Auto-generated method stub
		dao.updateComment(cv);			
	}

	@Override
	public void insertCommentOfComment(int board_no, CommentVO cv) throws Exception {
		cv.setBoard_no(board_no);
		cv.setCno(1);
		dao.insertCommentOfComment(cv);
	}

	@Override
	public int commentCount(int no) throws Exception {
		// TODO Auto-generated method stub
		return dao.commentCount(no);
	}

}
