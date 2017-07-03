package kr.co.mlec.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;
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
	public void insertReciveUser(ChatRoomDetailVO cdVO) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSessionTemplate.insert(nameSpace + "insertReciveUser", cdVO);
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
}
