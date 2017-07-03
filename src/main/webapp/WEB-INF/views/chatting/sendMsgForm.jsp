<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach var="sendMsg" items="${sendList}" varStatus="qwe">
	<c:choose>
		<c:when test="${sendMsg.send_usrno == sessionScope.member.usr_no}">
			<div class="chatMessage" style="width: 100%">
				<div class="chatContent">${sendMsg.content}</div>
				<div class="messageDate">${sendMsg.send_date}</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="userChatMessage" style="width: 100%">
				<img id="userThumbnail" class="chatThumbnail${sendMsg.send_usrno}" src="/image?file=${sendMsg.filePath}/${sendMsg.sysName}" style="border-radius: 50%; width: 60px; height: 60px; margin-left: 2%" onerror="javascript:errorUserImg(${sendMsg.send_usrno})"  />
				<div class="chatUsr">
					<div style="font-size: 12px; font-weight: bold; margin-left: 10px; margin-top: 7px">${sendMsg.nickName}</div>
					<div class="userChatContent" style="padding: 0.5em 1em 0.5em 0.5em; margin-left: 11px; margin-top: 0">${sendMsg.content}</div>
				</div>
					<div class="userMessageDate" style="margin-top: 5.5%; margin-left: 5px">${sendMsg.send_date}</div>
			</div>
		</c:otherwise>
	</c:choose>
</c:forEach>