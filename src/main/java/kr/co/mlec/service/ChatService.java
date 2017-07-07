package kr.co.mlec.service;

import java.util.List;

import org.springframework.aop.ThrowsAdvice;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.MemberVO;

public interface ChatService {
	public List<MemberVO> getUserList(int myUserNo) throws Exception;
	
	public int getUserListCount(int myUserNo) throws Exception;
	
	public ChatRoomVO chatRoom(ChatRoomVO cvo) throws Exception;
	
	public ChatRoomDetailVO sendMsg(ChatRoomDetailVO cdVO) throws Exception;
	
	public List<ChatRoomDetailVO> getChatMsgList(int cno, int usrNo) throws Exception;
	
	public List<ChatRoomDetailVO> getChatRoomList(int usrNo) throws Exception;
	
	public ChatRoomDetailVO receiveMsg(int cno, int maxSeq, int usr_no) throws Exception;
	
	public ChatRoomDetailVO chatFileUpload(MultipartHttpServletRequest mRequest) throws Exception;
	
	public List<ChatRoomDetailVO> getReadCnt(int cno) throws Exception;
	
	public int notReadCnt(int usr_no) throws Exception;
	
	public List<MemberVO> getUserInfo(String[] userInfo) throws Exception;
	
	public ChatRoomVO getChatRoom(String cno) throws Exception;
}
