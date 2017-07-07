<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="border-top: 1px solid #d6d6d6; background-color: white;" class="chatProfileTxt">전체 <span class="userCnt">(${userCount})</span></div>
<div style="height: 78%; overflow-y: auto">
	<div class="userProfile">
		<table class="userList">
			<colgroup>
				<col width="3%" />
				<col width="10%" />
				<col width="87%" />
			</colgroup>
<%-- 			<tr>
				<td colspan="3" style="border-top: 1px solid #d6d6d6" class="chatProfileTxt" >전체 <span class="userCnt">(${userCount})</span></td>
			</tr> --%>
			<div>
			<c:forEach var="user" items="${userList}" varStatus="qwe">
				<form id="chatFrm${user.usr_no}" method="post">
					<tr class="userInfo uTable${user.usr_no}">
						<td><input type="checkbox" style="margin-left: 1em" value="${user.usr_no}"></td>
						<td class="chatProfileTd" style="padding: 1em 1.5em 1em 1em"><img id="thumbnail${user.usr_no}" class="chatMyImg" src="/image?file=${user.filePath}/${user.sysName}" onerror="javascript:errorUserImg(${user.usr_no})" style="width: 60px; height: 60px" /></td>
						<td class="usrNickName">${user.nickName}</td>
						<input type="hidden" id="usrNo" value="${user.usr_no}" />
					</tr>
				</form>
			</c:forEach>
			</div>
		</table>
	</div>
</div>
<div class="groupChatBtn">
	<button type="button" class="btn btn-primary groupBtnStyle" onclick="groupRoomAdd()">등록</button>
	<form id="groupChatFrm" method="post"></form>
</div>