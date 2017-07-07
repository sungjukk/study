<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<table class="roomList">
	<colgroup>
		<col width="10%" />
		<col width="70%" />
		<col width="20%" />
	</colgroup>
	<tr>
		<td colspan="3"></td>
	</tr>
	<c:forEach var="room" items="${roomList}" varStatus="qwe">
		<form id="chatFrm${room.cno}" method="post"></form>
			<tr class="roomInfo uTable${room.cno}" onclick="chatRoom(${room.cno})" style="border-bottom: 1px solid #f7f7f7">
				<td style="padding: 1em 1.5em 1em 1em; width: 10%;"><img id="thumbnail${room.receive_usrno}" src="/image?file=${room.filePath}/${room.sysName}" onerror="javascript:errorUserImg(${room.receive_usrno})" /></td>
				<td class="usrNickName" style="vertical-align: baseline; padding-top: 1em">
					<div>${room.nickName}</div>
					<div style="font-size: 12px; margin-top: 9px; font-weight: normal;">${room.content }</div>
				</td>
				<td style="vertical-align: baseline;">
<%-- 					<fmt:parseDate var="sendDate" value="${room.send_date}" pattern="yyyy-MM-dd HH:mm:ss" /> --%>
 					<fmt:formatDate var="regDate" value="${room.send_date}" pattern="a hh:mm" />
					<div style="font-size: 12px">${regDate}</div>
					<c:if test="${room.readCnt > 0}">
						<div style="margin-top: 9px"><span class="badge" style="background-color: #d9534f; font-size: 15px">${room.readCnt}</span></div>					
					</c:if>
				</td>
				<input type="hidden" id="usrNo" value="${room.receive_usrno}" />
			</tr>
	</c:forEach>
</table>