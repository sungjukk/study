<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
</head>
<script src="/resources/js/chatMain.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		initChatMain();
	});
</script>
<body>
	<div class="phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
			<div class="phoneBodyContent">
				<nav class="navbar navbar-default chatnav">
				  <div class="container-fluid">
				    <div class="navbar-header" style="background-color: white;">
				      <a class="navbar-brand" href="/chat">
				        <span class="glyphicon glyphicon-user"></span>
				      </a>
				      <a class="navbar-brand" href="/chat/roomList">
				        <span class="glyphicon glyphicon-comment"></span>
				      </a>
				    </div>
				  </div>
				</nav>
				<div class="userSearch">
					<div class="input-group">
						<span class="input-group-addon searchIcon" id="basic-addon1"><span class="glyphicon glyphicon-search"></span></span>
						<input type="text" class="form-control input-lg" placeholder="Username" aria-describedby="basic-addon1" style="border: none; box-shadow: none" onkeyup="searchUser()" id="searchKey">
					</div>
				</div>
				<div class="myProfile">
					<input type="hidden" id="userNo" value="${sessionScope.member.usr_no}">
					<table class="userList">
						<colgroup>
							<col width="10%" />
							<col width="90%" />
						</colgroup>
						<tr>
							<td colspan="2">내 프로필</td>
						</tr>
						<tr class="userInfo">
							<td><img id="thumbnail${sessionScope.member.usr_no}" src="/image?file=${sessionScope.member.filePath}/${sessionScope.member.sysName}" onerror="javascript:errorUserImg(${sessionScope.member.usr_no})" /></td>
							<td>${sessionScope.member.nickName}</td>
						</tr>
					</table>
				</div>
				<div class="userInfoList"></div>
			</div>
		</div>
	</div>
</body>
</html>