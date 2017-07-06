package kr.co.mlec.dao;

import java.util.List;
import java.util.Map;

import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.MemberVO;

public interface ChatDao {
	public List<MemberVO> getUserList(int myUserNo) throws Exception;
	
	public int getUserListCount(int myUserNo) throws Exception;
	
	public int chatRoomCount(String roomNo) throws Exception;
	
	public int createChatRoom(ChatRoomVO chatVO) throws Exception;
	
	public ChatRoomVO getChatRoom(String roomNo) throws Exception;
	
	public int chatRoomDetailCount(int cno) throws Exception;
	
	public void insertSendMsg(ChatRoomDetailVO cdVO) throws Exception;
	
	public void insertReciveUser(ChatRoomDetailVO cdVO) throws Exception;
	
	public ChatRoomDetailVO getSendMsgOne(ChatRoomDetailVO cdVO) throws Exception;
	
	public void readMsg(Map<String,Integer> map) throws Exception;
	
	public List<ChatRoomDetailVO> getChatMsgList(int cno) throws Exception;
	
	public List<ChatRoomDetailVO> getChatRoomList(int usrNo) throws Exception;
	
	public ChatRoomDetailVO reciveMsg(Map<String,Integer> param) throws Exception;
	
	public int insertFile(FileVO fv) throws Exception;
	
	public List<ChatRoomDetailVO> getReadCnt(int cno) throws Exception;
	
	public int notReadCnt(int usr_no) throws Exception;
}
