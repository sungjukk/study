<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="userProfile">
	<table class="userList">
		<colgroup>
			<col width="10%" />
			<col width="90%" />
		</colgroup>
		<tr>
			<td colspan="2" style="border-top: 1px solid #d6d6d6">ÀüÃ¼ <span class="userCnt">(${userCount})</span></td>
		</tr>
		<c:forEach var="user" items="${userList}" varStatus="qwe">
			<form id="chatFrm${user.usr_no}" method="post">
				<tr class="userInfo uTable${user.usr_no}" onclick="chatRoom(${user.usr_no})">
					<td style="padding: 1em 1.5em 1em 1em"><img id="thumbnail${user.usr_no}" src="/image?file=${user.filePath}/${user.sysName}" onerror="javascript:errorUserImg(${user.usr_no})" /></td>
					<td class="usrNickName">${user.nickName}</td>
					<input type="hidden" id="usrNo" value="${user.usr_no}" />
				</tr>
			</form>
		</c:forEach>
	</table>
</div>