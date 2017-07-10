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
	<div class="showChatImg" style="width: 100%; height: 100%;top: 0px; left: 0px;z-index: 10; position: absolute; display: none; overflow-y: auto">
		<button type="button" onclick="javascript:$('.showChatImg').hide()" class="close" aria-label="Close" style="font-size: 40px; color: white; position: fixed; left: 92%; top: 1%; z-index: 15; opacity: .8"><span aria-hidden="true">&times;</span></button>
		<div class="chatImgDiv" style="width: 100%; top: 25%; z-index: 11; height: 50%; position: relative;">
			<img src="" style="width: 100%" class="viewChatImg"> 
		</div>
		<div style="width: 100%; height: 100%;top: 0px; left: 0px; background-color : black; position: absolute; opacity: 0.6"></div>
	</div>
	<div class="phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
			<div class="phoneBodyContent">
				<div class="chatState" style="width: 100%; height: 9%; background-color: rgba(152,182,204,1); position: fixed;" onclick="javascript:$('.chatList').scrollTop($('.chatList').scrollTop() - 500)">
					<c:choose>
						<c:when test="${userInfo.usrCnt == 1}">
							<img class="chatThumbnailOne" src="/image?file=${userInfo.filePath[0]}" style="width: 40px; height: 40px; border-radius: 50%; margin: 2% 0 0 3%; float: left;" onerror="javascript:errorUserImg('One')" >							
						</c:when>
						<c:when test="${userInfo.usrCnt == 2}">
							<img class="chatThumbnailOne" src="/image?file=${userInfo.filePath[0]}" style="width: 20px; height: 40px; border-radius: 20px 0 0 20px; margin: 2% 0 0 3%; float: left;" onerror="javascript:errorUserImg('One')" >							
							<img class="chatThumbnailTwo" src="/image?file=${userInfo.filePath[1]}" style="width: 20px; height: 40px; border-radius: 0 20px 20px 0; margin: 2% 0 0 0; float: left;" onerror="javascript:errorUserImg('Two')" >													
						</c:when>
						<c:when test="${userInfo.usrCnt == 3}">
							<div style="width: 40px; height: 40px; margin: 2% 0 0 3%; position: relative; float: left;">
								<img class="chatThumbnailOne" src="/image?file=${userInfo.filePath[0]}" style="width: 20px; height: 40px; border-radius: 20px 0 0 20px; float: left;" onerror="javascript:errorUserImg('One')" >							
								<img class="chatThumbnailTwo" src="/image?file=${userInfo.filePath[1]}" style="width: 20px; height: 20px; border-radius: 0 20px 0 0; float: left;" onerror="javascript:errorUserImg('Two')" >
								<img class="chatThumbnailThr" src="/image?file=${userInfo.filePath[2]}" style="width: 20px; height: 20px; border-radius: 0 0 20px 0; float: left;" onerror="javascript:errorUserImg('Thr')" >
							</div>
						</c:when>
						<c:when test="${userInfo.usrCnt >= 4}">
							<div style="width: 40px; height: 40px; margin: 2% 0 0 3%; position: relative; float: left;">
								<img class="chatThumbnailOne" src="/image?file=${userInfo.filePath[0]}" style="width: 20px; height: 20px; border-radius: 20px 0 0 0; float: left;" onerror="javascript:errorUserImg('One')" >							
								<img class="chatThumbnailTwo" src="/image?file=${userInfo.filePath[1]}" style="width: 20px; height: 20px; border-radius: 0 20px 0 0; float: left;" onerror="javascript:errorUserImg('Two')" >
								<img class="chatThumbnailThr" src="/image?file=${userInfo.filePath[2]}" style="width: 20px; height: 20px; border-radius: 0 0 0 20px; float: left;" onerror="javascript:errorUserImg('Thr')" >
								<img class="chatThumbnailFour" src="/image?file=${userInfo.filePath[3]}" style="width: 20px; height: 20px; border-radius: 0 0 20px 0; float: left;" onerror="javascript:errorUserImg('Four')" >
							</div>							
						</c:when>
					</c:choose>
					<div style="padding-top: 5%; margin-left: 15%; font-size: 13px; font-weight: bold;">${userInfo.nickName}</div>		
				</div>
				<div style="width: 100%; height: 8%"></div>
				<div class="chatList" style="overflow-y: auto;height: 77%; overflow-x: hidden; position: fixed; width: 100%; background: rgba(160,192,215,1)">
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