package kr.co.mlec.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.mlec.dao.ChatDao;
import kr.co.mlec.util.ChatFileUpload;
import kr.co.mlec.util.FileUpload;
import kr.co.mlec.util.SecurityCryptograph;
import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;
import kr.co.mlec.vo.FileVO;
import kr.co.mlec.vo.MemberVO;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Inject
	private ChatDao dao;
	
	private final String imgExt[] = {".jpg",".png",".jpeg",".gif"}; 
	private final String videoExt = ".mp4";

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
		String receiveUser[] = cdVO.getReceive_usrno().split(",");
		for (String receive : receiveUser) {
			cdVO.setReceiveNo(Integer.parseInt(receive));
			dao.insertreceiveUser(cdVO);
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

	@Override
	public List<ChatRoomDetailVO> getChatRoomList(int usrNo) throws Exception {
		// TODO Auto-generated method stub
		List<ChatRoomDetailVO> roomList = dao.getChatRoomList(usrNo);
		
		for (ChatRoomDetailVO cd : roomList) {
			// 1보다 크면 그룹채팅방
			if (cd.getUsrCnt() > 1) {
				Map<String,Object> param = new HashMap<String, Object>();
				param.put("cno", cd.getCno());
				param.put("usr_no", usrNo);
				Map<String,Object> resultMap = dao.getGroupUserInfo(param);
				String thumbNail = (String)resultMap.get("FILEPATH");
				String[] thumbNailList = thumbNail.split(",");
				cd.setNickName((String)resultMap.get("NICKNAME"));
				cd.setGroupThumbNail(thumbNailList);
				System.out.println(cd.toString());
			}
		}
		
		return roomList;
	}

	@Override
	public ChatRoomDetailVO receiveMsg(int cno, int maxSeq, int usr_no) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Integer> param = new HashMap<String, Integer>();
		param.put("cno", cno);
		param.put("chatSeq", maxSeq);
		param.put("usr_no", usr_no);
		//유저가 방에 있으므로 읽음 처리
		dao.readMsg(param);
		
		return dao.receiveMsg(param);
	}

	@Override
	public ChatRoomDetailVO chatFileUpload(MultipartHttpServletRequest mRequest) throws Exception {
		// TODO Auto-generated method stub
		MultipartFile file = mRequest.getFile("chatFile");
		ChatRoomDetailVO cdVO = new ChatRoomDetailVO();
		
		cdVO.setCno(Integer.parseInt(mRequest.getParameter("cno")));
		cdVO.setSend_usrno(Integer.parseInt(mRequest.getParameter("send_usrno")));
		cdVO.setChat_seq(dao.chatRoomDetailCount(cdVO.getCno()) + 1);

		FileVO fv = new FileUpload().fileUpload(file,0,1);
		System.out.println(fv.getExt());
		cdVO.setFile_no(dao.insertFile(fv));
		System.out.println(cdVO.getFile_no());
		boolean isImg = false;
		boolean isVideo = false;
		for (String ext : imgExt) {
			if (fv.getExt().toLowerCase().equals(ext.toLowerCase())) {
				isImg = true;
				break;
			}
			
			if (fv.getExt().toLowerCase().equals(videoExt.toLowerCase())) {
				isVideo = true;
				break;
			}
		}
		if (isImg == true) {
			cdVO.setContent("img");
		} else {
			cdVO.setContent("file");
		} 
		if (isVideo == true) {
			cdVO.setContent("video"); 
		}
		
		//메세지 저장
		dao.insertSendMsg(cdVO);
		
		//받는 사람 추가
		String receiveUser[] = mRequest.getParameter("receive_usrno").split(",");
		for (String receive : receiveUser) {
			cdVO.setReceiveNo(Integer.parseInt(receive));
			dao.insertreceiveUser(cdVO);
		}
		
		return dao.getSendMsgOne(cdVO);
	}

	@Override
	public List<ChatRoomDetailVO> getReadCnt(int cno) throws Exception {
		// TODO Auto-generated method stub
		return dao.getReadCnt(cno);
	}

	@Override
	public int notReadCnt(int usr_no) throws Exception {
		// TODO Auto-generated method stub
		return dao.notReadCnt(usr_no);
	}

	@Override
	public Map<String, Object> getUserInfo(String[] userInfo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> resultMap = dao.getUserInfo(userInfo);
		String thumbNail = (String)resultMap.get("FILEPATH");
		String[] thumbNailList = thumbNail.split(",");
		map.put("nickName", (String)resultMap.get("NICKNAME"));
		map.put("filePath", thumbNailList);
		map.put("usrCnt", String.valueOf(resultMap.get("USRCNT")));
		return map;
	}

	@Override
	public ChatRoomVO getChatRoom(String cno) throws Exception {
		// TODO Auto-generated method stub
		return dao.getChatRoomByCno(cno);
	}
}
