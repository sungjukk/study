<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
</head>
<!-- socket.io -->
<script type="text/javascript" src="https://cdn.socket.io/socket.io-1.4.5.js"></script>
<script src="/resources/js/chatRoomDetail.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		initChat(${sessionScope.member.usr_no},${chatInfo.cno},'${chatInfo.user_list}');
	});
</script>
<body>
	<div class="phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
			<div class="phoneBodyContent" style="background-color: #D1D7F0">
				<div class="chatMessageList">
<!-- 					<div class="chatMessage" style="width: 100%">
						<div class="chatContent">안녕하세요</div>
						<div class="messageDate">11:11</div>
					</div>	 -->			
<!-- 					<div class="userChatMessage" style="width: 100%">
						<img id="userThumbnail" src="/resources/images/img_photo_2.gif" style="border-radius: 50%; width: 60px; height: 60px; margin-left: 2%" />
						<div class="chatUsr">
							<div style="font-size: 12px; font-weight: bold; margin-left: 10px; margin-top: 7px">이름</div>
							<div class="userChatContent" style="padding: 0.5em 1em 0.5em 0.5em; margin-left: 11px; margin-top: 0">안녕하세요</div>
						</div>
						<div class="userMessageDate" style="margin-top: 5.5%; margin-left: 5px">11:11</div>
					</div>	 -->			
				</div>
				<div class="chatBar">
					<nav class="navbar navbar-default navbar-fixed-bottom">
					  <div class="container" style="padding: 0">
					    <div class="input-group input-group-lg">
					      <input type="text" class="form-control chatMsg" placeholder="Message">
					      <span class="input-group-btn">
					        <button class="btn btn-default" type="button" onclick="sendMsg()">전송</button>
					      </span>
					  </div>
					</nav>
				</div>
			</div>
		</div>
	</div>
</body>
</html>