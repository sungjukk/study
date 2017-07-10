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
				<td style="padding: 1em 1.5em 1em 1em; width: 10%;">
					<c:choose>
						<c:when test="${room.usrCnt > 1}">
							<c:choose>
								<c:when test="${room.usrCnt == 2}">
									<img id="thumbnail${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[0]}" onerror="javascript:errorUserImg(${room.cno}${room.receive_usrno})" style="border-radius: 60px 0 0 60px; width: 30px" />						
									<img id="thumbnailSec${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[1]}" onerror="javascript:errorUserImg('Sec${room.cno}${room.receive_usrno}')" style="border-radius: 0px 30px 30px 0px; width: 30px; float: right;" />			
								</c:when>
								<c:when test="${room.usrCnt == 3}">
									<div style="width: 60px; height: 60px; position: relative;">
										<img id="thumbnail${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[0]}" onerror="javascript:errorUserImg(${room.cno}${room.receive_usrno})" style="border-radius: 60px 0 0 60px; width: 30px; height: 100%" />						
										<img id="thumbnailSec${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[1]}" onerror="javascript:errorUserImg('Sec${room.cno}${room.receive_usrno}')" style="border-radius: 0px 60px 0px 0px; width : 30px; height : 30px; float: right;" />			
										<img id="thumbnailTh${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[2]}" onerror="javascript:errorUserImg('Th${room.cno}${room.receive_usrno}')" style="border-radius: 0px 0px 60px 0px; width: 30px; height: 30px; position: absolute; bottom: 0; left: 50%"  />												
									</div>
								</c:when>
								<c:when test="${room.usrCnt >= 4}">
									<div style="width: 60px; height: 60px; position: relative;">
										<img id="thumbnail${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[0]}" onerror="javascript:errorUserImg(${room.cno}${room.receive_usrno})" style="border-radius: 60px 0 0 0; width: 30px; height: 30px" />						
										<img id="thumbnailSec${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[1]}" onerror="javascript:errorUserImg('Sec${room.cno}${room.receive_usrno}')" style="border-radius: 0px 60px 0px 0px; width : 30px; height : 30px; float: right;" />			
										<img id="thumbnailTh${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[2]}" onerror="javascript:errorUserImg('Th${room.cno}${room.receive_usrno}')" style="border-radius: 0px 0px 0px 60px; width: 30px; height: 30px; position: absolute; bottom: 0; left: 0"  />																					
										<img id="thumbnailFour${room.cno}${room.receive_usrno}" src="/image?file=${room.groupThumbNail[2]}" onerror="javascript:errorUserImg('Four${room.cno}${room.receive_usrno}')" style="border-radius: 0px 0px 60px 0px; width: 30px; height: 30px; position: absolute; bottom: 0; left: 50%"  />																					
									</div>
								</c:when>
							</c:choose>			
						</c:when>
						<c:otherwise>
							<img id="thumbnail${room.receive_usrno}" src="/image?file=${room.filePath}/${room.sysName}" onerror="javascript:errorUserImg(${room.receive_usrno})" />
						</c:otherwise>
					</c:choose>
				</td>
				<td class="usrNickName" style="vertical-align: baseline; padding-top: 1em">
					<div>${room.nickName}</div>
					<div style="font-size: 12px; margin-top: 9px; font-weight: normal;overflow:hidden;white-space:nowrap; text-overflow: ellipsis; word-wrap : break-word; -webkit-line-clamp: 1; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical;">${room.content }</div>
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