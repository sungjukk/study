package kr.co.mlec.service;

import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;
import kr.co.mlec.vo.MemberVO;

public interface ChatService {
	public List<MemberVO> getUserList(int myUserNo) throws Exception;
	
	public int getUserListCount(int myUserNo) throws Exception;
	
	public ChatRoomVO chatRoom(ChatRoomVO cvo) throws Exception;
	
	public ChatRoomDetailVO sendMsg(ChatRoomDetailVO cdVO) throws Exception;
	
	public List<ChatRoomDetailVO> getChatMsgList(int cno, int usrNo) throws Exception;
}
