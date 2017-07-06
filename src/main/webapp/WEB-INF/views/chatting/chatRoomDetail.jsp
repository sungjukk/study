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
	var chatType = 3;
	$(document).ready(function () {
		initChat(${sessionScope.member.usr_no},${chatInfo.cno},'${chatInfo.user_list}');
		
		$("#chatFile").change(chatFileUpload);
	});
</script>
<body>
	<div style="width: 100%; height: 100%;top: 0px; left: 0px;z-index: 10; position: absolute;">
		<button type="button" class="close" aria-label="Close" style="font-size: 40px; color: white; position: absolute; left: 92%; top: 1%; z-index: 11; opacity: .8"><span aria-hidden="true">&times;</span></button>
		<div style="width: 100%; position: absolute; top: 25%; z-index: 11; height: 50%;">
			<img src="/image?file=/2017/07/06/2017070697df53f7-6711-47e7-9f78-e67662172bd6.jpg">
		</div>
		<div style="width: 100%; height: 100%;top: 0px; left: 0px; background-color : black; position: absolute; opacity: 0.6"></div>
	</div>
	<div class="phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
			<div class="phoneBodyContent">
				<div class="chatList" style="overflow-y: auto;height: 85%; overflow-x: hidden; position: fixed; width: 100%; background: rgba(160,192,215,1)">
					<div class="chatMessageList" style="overflow-y: hidden">		
					</div>
<!-- 					<input type="text" id="focusChat" />			 -->
				</div>
				<div class="scrollUp" style="position: absolute; bottom: 50px; width: 100%"></div>
				<div class="chatBar">
					<nav class="navbar navbar-default navbar-fixed-bottom">
					  <div class="container" style="padding: 0">
					    <div class="input-group input-group-lg">
					   	  <span class="input-group-btn">
						  	<button type="file" class="btn btn-default" onclick="chatUpload()">+</button>
						  	<input type="file" id="chatFile" style="display: none">
						  </span>
					      <input type="text" class="form-control chatMsg" placeholder="Message">
					      <span class="input-group-btn">
					        <button class="btn btn-default" type="button" onclick="sendMsg()">Àü¼Û</button>
					      </span>
					  </div>
					</nav>
				</div>
			</div>
		</div>
	</div>
</body>
</html>