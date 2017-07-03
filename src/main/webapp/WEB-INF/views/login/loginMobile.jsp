<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
<script src="/resources/js/login.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="phone phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container phone">
		<div class="phoneBody">
			<div class="phoneBodyContent">
				<%@include file="MobileLoginForm.jsp" %>
			</div>
		</div>
	</div>
</body>
</html>