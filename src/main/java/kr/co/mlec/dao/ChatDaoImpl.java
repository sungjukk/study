package kr.co.mlec.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.MemberVO;

@Repository
public class ChatDaoImpl implements ChatDao {
	private static final Logger logger = LoggerFactory.getLogger(ChatDaoImpl.class);
	
	@Inject
	private SqlSessionTemplate sqlSessionTemplate;
	
	private String nameSpace = "kr.co.mlec.chatMapper.";

	@Override
	public List<MemberVO> getUserList(int myUserNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList(nameSpace + "getUserList", myUserNo);
	}

	@Override
	public int getUserListCount(int myUserNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(nameSpace + "getUserListCount", myUserNo);
	}

	@Override
	public int chatRoomCount(String roomNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(nameSpace + "roomCnt", roomNo);
	}

	@Override
	public int createChatRoom(ChatRoomVO chatVO) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.insert(nameSpace + "insertRoom", chatVO);
		return chatVO.getCno();
	}

	@Override
	public ChatRoomVO getChatRoom(String roomNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(nameSpace+"getChatRoom", roomNo);
	}

	@Override
	public int chatRoomDetailCount(int cno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(nameSpace+"chatRoomDetailCount", cno);
	}

	@Override
	public void insertSendMsg(ChatRoomDetailVO cdVO) throws Exception {
		sqlSessionTemplate.insert(nameSpace + "insertSendMsg", cdVO);
	}

	@Override
	public void insertreceiveUser(ChatRoomDetailVO cdVO) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSessionTemplate.insert(nameSpace + "insertReceiveUser", cdVO);
	}

	@Override
	public ChatRoomDetailVO getSendMsgOne(ChatRoomDetailVO cdVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(nameSpace + "getSendMsgOne", cdVO);
	}

	@Override
	public void readMsg(Map<String,Integer> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.update(nameSpace + "readMsg", map);
	}

	@Override
	public List<ChatRoomDetailVO> getChatMsgList(int cno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList(nameSpace + "getChatMsgList", cno);
	}

	@Override
	public List<ChatRoomDetailVO> getChatRoomList(int usrNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList(nameSpace + "getRoomList", usrNo);
	}

	@Override
	public ChatRoomDetailVO receiveMsg(Map<String, Integer> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(nameSpace + "receiveMsg", param);
	}

	@Override
	public int insertFile(FileVO fv) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.insert(nameSpace + "insertFile", fv);
		return fv.getFile_no();
	}

	@Override
	public List<ChatRoomDetailVO> getReadCnt(int cno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList(nameSpace + "getReadCnt", cno);
	}

	@Override
	public int notReadCnt(int usr_no) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne(nameSpace + "notReadCnt", usr_no);
	}

	@Override
	public List<MemberVO> getUserInfo(String[] userInfo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String[]> param = new HashMap<String, String[]>();
		param.put("userInfo", userInfo);
		return sqlSessionTemplate.selectList(nameSpace + "getUserInfo", param);
	}
}
