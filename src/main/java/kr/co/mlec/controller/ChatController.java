package kr.co.mlec.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.mlec.service.ChatService;
import kr.co.mlec.vo.ChatRoomDetailVO;
import kr.co.mlec.vo.ChatRoomVO;

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
	public ModelAndView chatRoom(String[] roomNo) throws Exception {
		int[] sortUno = new int[roomNo.length];
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
		ModelAndView mav = new ModelAndView("chatting/chatRoomDetail");
		mav.addObject("chatInfo", chatService.chatRoom(cvo));
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
		System.out.println(cno);
		System.out.println(usrNo);
		mav.addObject("sendList", chatService.getChatMsgList(cno, usrNo));
		return mav;
	}
}
