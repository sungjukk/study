<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
</head>
<script src="/resources/js/chatRoomList.js"></script>
<script type="text/javascript">
	var chatType = 2;
	$(document).ready(function () {
		initRoomList(${sessionScope.member.usr_no});
	});
</script>
<body>
	<div class="phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
			<div class="phoneBodyContent">
				<div style="position: fixed; width: 100%">
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
				</div>
				<div class="fixedDiv" style="width: 100%; height: 50px"></div>
				<input type="hidden" id="userNo" value="${sessionScope.member.usr_no}">
				<div class="roomProfile"></div>
			</div>
		</div>
	</div>
</body>
</html>