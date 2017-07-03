package kr.co.mlec.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.mlec.dao.ChatDao;
import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;
import kr.co.mlec.vo.MemberVO;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Inject
	private ChatDao dao;

	@Override
	public List<MemberVO> getUserList(int myUserNo) throws Exception {
		return dao.getUserList(myUserNo);
	}

	@Override
	public int getUserListCount(int myUserNo) throws Exception {
		return dao.getUserListCount(myUserNo);
	}

	@Override
	public ChatRoomVO chatRoom(ChatRoomVO cvo) throws Exception {
		int count = dao.chatRoomCount(cvo.getEnter_usrno());
		ChatRoomVO chatVO = new ChatRoomVO();
		
		if (count == 1) {
			cvo = dao.getChatRoom(cvo.getEnter_usrno());
		} else if (count == 0) {
			//채팅 방이 없는 경우 등록
			cvo.setCno(dao.createChatRoom(cvo));
			System.out.println(cvo.getCno());
		}
		return cvo;
	}

	@Override
	public ChatRoomDetailVO sendMsg(ChatRoomDetailVO cdVO) throws Exception {
		// TODO Auto-generated method stub
		
		// 정렬 순서 가져옴
		cdVO.setChat_seq(dao.chatRoomDetailCount(cdVO.getCno()) + 1);
		// 보낸 메세지 추가
		dao.insertSendMsg(cdVO);
		
		// 받는 사람 추가
		String reciveUser[] = cdVO.getRecive_usrno().split(",");
		for (String recive : reciveUser) {
			cdVO.setReciveNo(Integer.parseInt(recive));
			dao.insertReciveUser(cdVO);
		}
		
		// 보낸 정보 가져오기
		return dao.getSendMsgOne(cdVO);
	}

	@Override
	public List<ChatRoomDetailVO> getChatMsgList(int cno, int usrNo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("cno", cno);
		map.put("usr_no", usrNo);
		// 입장 시 채팅방 글 읽음 처리
		dao.readMsg(map);
		
		// 채팅방 글 전체를 가져온다.
		return dao.getChatMsgList(cno);
	}
}
