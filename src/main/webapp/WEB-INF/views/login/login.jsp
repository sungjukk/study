<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
<%-- <%@include file="/WEB-INF/views/include/header.jsp" %> --%>
<script src="/resources/js/login.js"></script>
<script type="text/javascript">
// 	var chat = io.connect("http://localhost:10001");
</script>
</head>
<body>
	<div class="container phoneLogin">
		<c:choose>
			<c:when test="${sessionScope.member == null}">
				<div class="row phoneLow">
				<%-- <% response.sendRedirect("/board"); %> --%>
					<div class="col-md-3 phoneNotDisplay"></div>
					<div class="showPhone"></div>
					<div class="col-md-9 loginFrmCss" style="margin-top: 4%">
						<div class="phoneImg"></div>
						<form class="form-inline" id="loginFrm">
						  <div class="form-group inputCss">
						  	<div class="sortDiv"></div>
						    <label class="loginText" for="exampleInputName2">ID</label>
						    <input type="text" class="form-control" id="loginFormInput" name="id" placeholder="ID">
						  	<div class="sortDiv"></div>
						  </div>
						  <div class="form-group inputCss formInterval">
						  	<div class="sortDiv"></div>
						    <label class="loginText" for="exampleInputEmail2">Password</label>
						    <input type="password" class="form-control" id="loginFormInput" name="pw" placeholder="Password">
						  	<div class="sortDiv"></div>
						  </div>
							<a href="/member/new" class="btn btn-default phoneBtn formInterval">Sign in</a>
							<a href="javascript:login()" class="btn btn-default formInterval2 phoneBtn formInterval">Login</a>
						</form>
					</div>
	<!-- 				<div class="col-md-3"></div> -->
			</div>
			</c:when>
			<c:otherwise>
				<div class="row">
					<div class="col-md-1"></div>
<%-- 					<div class="col-md-9" style="text-align: right; line-height: 800%">
						<span>${sessionScope.member.id}</span>
						<a href="/member/logout" class="btn btn-default">로그아웃</a>						
					</div> --%>
					<div class="col-md-9" style="text-align: right; margin-top: 4%">
						<div class="btn-group">
						  <a class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
						    <img id="thumnail" src="/image?file=${sessionScope.member.filePath}/${sessionScope.member.sysName}" onError="javascript:errorImg()" style="width: 30px; height: 20px"/>&nbsp;&nbsp;${sessionScope.member.nickName} <span class="caret"></span>
						  </a>
						  <ul class="dropdown-menu" role="menu">
						    <li><a href="/member/mod">회원정보수정</a></li>
						    <li><a href="#">내 글 확인</a></li>
						    <li><a href="#">댓글 목록</a></li>
						    <li class="divider"></li>
						    <li><a href="/member/logout">로그아웃</a></li>
						  </ul>
						</div>
					</div>
					<div class="col-md-1"></div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>