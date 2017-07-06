package kr.co.mlec.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.mlec.service.ChatService;
import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;
import kr.co.mlec.vo.FileVO;

@Controller
@RequestMapping(value = "/chat")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String chatMain() throws Exception {
		return "chatting/chatMain";
	}
	
	@RequestMapping(value = "/userInfo", method = RequestMethod.POST)
	public ModelAndView getUserInfo(String userNo) throws Exception {
		ModelAndView mav = new ModelAndView("chatting/userTable");
		mav.addObject("userList", chatService.getUserList(Integer.parseInt(userNo)));
		mav.addObject("userCount", chatService.getUserListCount(Integer.parseInt(userNo)));
		return mav;
	}
	
	@RequestMapping(value = "/roomList", method = RequestMethod.GET)
	public ModelAndView chatRoomList() throws Exception {
		ModelAndView mav = new ModelAndView("chatting/chatRoomList");
		return mav;
	}
	
	@RequestMapping(value="/room", method = RequestMethod.POST)
	public ModelAndView chatRoom(String[] roomNo, String[] chatUserNo) throws Exception {
		int[] sortUno = new int[roomNo.length];
		int[] usrNo = new int[chatUserNo.length];
		String temp;
		for (int i = 0; i < roomNo.length; i++) {
			for (int j = i + 1; j < roomNo.length; j++) {
				int bno = Integer.parseInt(roomNo[i]);
				int ano = Integer.parseInt(roomNo[j]);
				if (bno > ano) {
					temp = roomNo[i];
					roomNo[i] = roomNo[j];
					roomNo[j] = temp;
				}
			}
		}
		ChatRoomVO cvo = new ChatRoomVO();
		String room = "";
		String roomInfo = "";
		int i = 0;
		for (String n : roomNo) {
			if (i == roomNo.length - 1) {
				roomInfo += n;
			} else {
				roomInfo += n + ",";				
			}
			room += n;	
			i++;
		}
		cvo.setEnter_usrno(room);
		cvo.setUser_list(roomInfo);
		
		String inUser = "";
		int cnt = 0;
		for (String usr : chatUserNo) {
			if (cnt == chatUserNo.length - 1) {
				inUser = usr;
			} else {
				inUser = usr + ",";
			}
			cnt++;
		}
		ModelAndView mav = new ModelAndView("chatting/chatRoomDetail");
		mav.addObject("chatInfo", chatService.chatRoom(cvo));
		mav.addObject("userInfo", chatService.getUserInfo(inUser));
		return mav;
	}
	
	@RequestMapping(value="/sendMsg", method = RequestMethod.POST)
	public ModelAndView sendMsg(ChatRoomDetailVO cdVO) throws Exception {
		ModelAndView mav = new ModelAndView("chatting/sendMsgForm");
		System.out.println(cdVO.toString());
		List<ChatRoomDetailVO> list = new ArrayList<ChatRoomDetailVO>();
		list.add(chatService.sendMsg(cdVO));
		mav.addObject("sendList",list);
		return mav;
	}
	
	@RequestMapping(value="/msgList", method = RequestMethod.POST)
	public ModelAndView getChatMsgList(int cno, int usrNo) throws Exception {
		ModelAndView mav = new ModelAndView("chatting/sendMsgForm");
		mav.addObject("sendList", chatService.getChatMsgList(cno, usrNo));
		return mav;
	}
	
	@RequestMapping(value="/roomList", method = RequestMethod.POST)
	public ModelAndView getChatRoomList(int usrNo) throws Exception {
		ModelAndView mav = new ModelAndView("chatting/roomList");
		mav.addObject("roomList", chatService.getChatRoomList(usrNo));
		return mav;
	}
	
	@RequestMapping(value="/reciveMsg", method = RequestMethod.POST)
	public ModelAndView reciveMsg(int cno, int maxSeq, int usr_no) throws Exception {
		System.out.println(cno);
		System.out.println(maxSeq);
		System.out.println(usr_no);
		ModelAndView mav = new ModelAndView("chatting/sendMsgForm");
		List<ChatRoomDetailVO> list = new ArrayList<ChatRoomDetailVO>();
		list.add(chatService.reciveMsg(cno, maxSeq, usr_no));
		mav.addObject("sendList", list);
		return mav;
	}
	
	@RequestMapping(value = "/file", method = RequestMethod.POST)
	public ModelAndView chatFileUpload(MultipartHttpServletRequest mRequest) throws Exception {
		ModelAndView mav = new ModelAndView("chatting/sendMsgForm");
		List<ChatRoomDetailVO> list = new ArrayList<ChatRoomDetailVO>();
		list.add(chatService.chatFileUpload(mRequest));
		mav.addObject("sendList", list);
		return mav;
	}
	
	@RequestMapping(value = "/getReadCnt", method = RequestMethod.POST)
	@ResponseBody	
	public List<ChatRoomDetailVO> getReadCnt(int cno) throws Exception {
		
		return chatService.getReadCnt(cno);
	}
	
	@RequestMapping(value ="/notReadCnt", method = RequestMethod.POST)
	@ResponseBody
	public int notReadCnt(int usr_no) throws Exception {
		return chatService.notReadCnt(usr_no);
	}
	
	@RequestMapping(value = "/player", method = RequestMethod.GET)
	public String videoPlayer() throws Exception {
		return "chatting/videoPlayer";
	}
}
