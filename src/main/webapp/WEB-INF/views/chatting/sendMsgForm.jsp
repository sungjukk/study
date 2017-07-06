<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:forEach var="sendMsg" items="${sendList}" varStatus="qwe">
<%-- 	<fmt:parseDate var="sendDate" value="${sendList.send_date}" pattern="yyyy-MM-dd HH:mm:ss" /> --%>
 	<fmt:formatDate var="regDate" value="${sendMsg.send_date}" pattern="a hh:mm" />
	<c:choose>
		<c:when test="${sendMsg.send_usrno == sessionScope.member.usr_no}">
			<div class="chatMessage" style="width: 100%; margin-bottom: 1em; overflow-x: hidden">
				<div class="chatContent">
					<c:choose>
						<c:when test="${sendMsg.file_no == 0}"><c:out value="${sendMsg.content}" /></c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${sendMsg.content == 'img'}">
									<img src="/image?file=${sendMsg.sendFilePath}/${sendMsg.sendSysName}" style="width: 100%" id="sendImg" onclick="showChatImg('${sendMsg.sendFilePath}/${sendMsg.sendSysName}')" />
								</c:when>
								<c:when test="${sendMsg.content == 'video'}">
									<video id="chatVideo${sendMsg.chat_seq}" style="width: 100%" onclick="chatVideoPlay(${sendMsg.chat_seq})">
										<source src="/resources/images/test.mp4" type="video/mp4">
									</video>
									<a href="/chat/player">asfdaf</a>
								</c:when>
								<c:when test="${sendMsg.content == 'mov'}">
									<video id="chatVideo${sendMsg.chat_seq}" style="width: 100%" onclick="chatVideoPlay(${sendMsg.chat_seq})">
										<source src="/download/${sendMsg.file_no}" type="video/mp4">
									</video>
									<a href="/chat/player">asfdaf</a>
								</c:when>
								<c:otherwise>
									<div style="width: 100%; text-align: center;">
										<img src="/resources/images/documentIcon.png" style="width: 40px" id="sendImg">
										<p></p>
									</div>
									<div>
										<a href="/download/${sendMsg.file_no}">${sendMsg.sendOriName}</a>									
									</div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<c:if test="${sendMsg.isRead > 0}">
						<div class="readCnt read${sendMsg.cno}${sendMsg.chat_seq}" style="position: absolute; bottom: 12px; right: 100%; margin-right: 5px; font-size: 8px; color: rgba(255, 236, 66, 1)">${sendMsg.isRead}</div>					
					</c:if>
					<div style="position: absolute; bottom: 0; right: 100%; font-size: 11px; width: 55px; margin-right: 5px">${regDate}</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="userChatMessage" style="width: 100%; margin-bottom: 1em">
				<img id="userThumbnail" class="chatThumbnail${sendMsg.send_usrno}" src="/image?file=${sendMsg.filePath}/${sendMsg.sysName}" style="border-radius: 50%; width: 60px; height: 60px; margin-left: 2%" onerror="javascript:errorUserImg(${sendMsg.send_usrno})"  />
				<div class="chatUsr" style="max-width: 55%">
					<div style="font-size: 12px; font-weight: bold; margin-left: 10px; margin-top: 7px">${sendMsg.nickName}</div>
					<div class="userChatContent" style="padding: 0.5em 1em 0.5em 0.5em; margin-left: 11px; margin-top: 0;">
						<c:choose>
							<c:when test="${sendMsg.file_no == 0}"><c:out value="${sendMsg.content}" /></c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${sendMsg.content == 'img'}">
										<img src="/image?file=${sendMsg.sendFilePath}/${sendMsg.sendSysName}" style="width: 100%" id="sendImg" onclick="showChatImg('${sendMsg.sendFilePath}/${sendMsg.sendSysName}')" />
										<a href="/download/${sendMsg.file_no}" style="font-size: 12px">¿˙¿Â</a>
									</c:when>
									<c:otherwise>
										<div style="width: 100%; text-align: center;">
											<img src="/resources/images/documentIcon.png" style="width: 40px" id="sendImg">
											<p></p>
										</div>
										<div>
											<a href="/download/${sendMsg.file_no}">${sendMsg.sendOriName}</a>									
										</div>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						<c:if test="${sendMsg.isRead > 0}">
							<div class="readCnt read${sendMsg.cno}${sendMsg.chat_seq}" style="margin-left : 5px;position: absolute; bottom: 12px; left: 100%; font-size: 8px; color: rgba(255, 236, 66, 1)">${sendMsg.isRead}</div>
						</c:if>
						<div style="margin-top: 5.5%; margin-left: 5px; position: absolute; bottom: 0; left: 100%; font-size: 11px; width: 55px">${regDate}</div>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</c:forEach>
<input type="hidden" id="maxSeq" value="${sendList[fn:length(sendList) - 1].chat_seq}">