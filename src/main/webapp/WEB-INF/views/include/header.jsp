<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="/resources/js/jquery-3.2.0.min.js"></script>
<link href="/resources/css/board.css" rel="stylesheet" type="text/css">
<link href="/resources/css/study.css" rel="stylesheet" type="text/css">

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.3/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.3/summernote.js"></script>
<!-- socket.io -->
<script type="text/javascript" src="https://cdn.socket.io/socket.io-1.4.5.js"></script>
<script src="/resources/js/chat.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	function errorImg() {
		$("#thumnail").attr("src","/resources/images/img_photo_2.gif");
	}
	function showMenuBar() {
		$(".headerDiv").css("z-index","2000");
		$(".menuClear").css("display","block");
		$(".move").css("opacity","0.3");
		$(".menuBar").css("box-shadow","7px 0px 20px rgba(0, 0, 0, 0.52)");
// 	    $(".headerDiv").css("height","734px");
 	    $(".phoneMainHeader").css("height","100%");
	    $(".headerDiv").css("height","100%");
	    $(".menuBar").css("overflow-y","scroll");
/* 		box-shadow: 3px 0px 14px rgba(0, 0, 0, 0.52);
	    -moz-box-shadow: 3px 0px 14px rgba(0, 0, 0, 0.52);
	    -webkit-box-shadow: 3px 0px 14px rgba(0, 0, 0, 0.52); */
/* 		$(".headerMenu").animate({left:'70%'}, function () {
		});
 */		$(".menuBar").animate({left:'0%'}, function () {
		});
 		$(".menuClear").animate({left:'70%'}, function () {
		});
 		$(".move").animate({left:'70%'}, function () {
		});
  		$(".phoneBodyContent").animate({left :'70%'});
  		$(".phoneLogin").animate({left :'70%'});
	}
	
	function selectMain() {
		location.href = "/main";
	}
	
	function loginFrm() {
/* 		$(".loginFrmDisplay").show();
		menuBarClear(); */
		location.href = "/member";
	}
	
	function overwatch() {
		$.ajax({
			url : "/overwatch/test",
			type: "POST"
		}).done(function (data) {
		})
	}
	
	function searchRecord() {
		location.href = "/overwatch";
	}
	
	function freeBoard() {
		location.href = "/board";
	}
	
	function testOverwatch() {
		$("#testPost").submit();
	}
	
	function menuBarClear() {
		$(".menuBar").css('left','-70%');
		$(".menuBar").css("box-shadow","none");
 		$(".menuClear").hide();
		$(".move").css("opacity","1");
		$(".headerDiv").css("z-index","0");
	 	$(".menuClear").css('left','0%');
	 	$(".move").css('left','0%');
	 	$(".phoneBodyContent").css('left','0%');
	 	$(".phoneLogin").css('left','0%');
	 	$(".phoneMainHeader").css("height","4em");
	}
	$(document).ready(function(){
		
		$(".menuClear").click(function(){
/* 			$(".headerMenu").animate({left:'0%'},function () {
				$(".menuClear").hide();
				$(".move").css("opacity","1");	
			});
			 */
			$(".menuBar").animate({left:'-70%'}, function () {
				$(".menuBar").css("box-shadow","none");
			});
 	 		$(".menuClear").animate({left:'0%'}, function () {
	 			$(".menuClear").hide();
				$(".move").css("opacity","1");
				$(".headerDiv").css("z-index","0");

	 	 		$(".headerDiv").css("height","70px");
	 	 		$(".phoneMainHeader").css("height","4em");
			});
 	 		$(".move").animate({left:'0%'}, function () {
 			});
 	 		$(".phoneBodyContent").animate({left :'0%'});
 	 		
 	 		$(".phoneLogin").animate({left :'0%'});
		});
		
	});


</script>
</head>
	<div class="headerDiv">
		<div class="loadingBackground">
				<div class="loader"></div>			
		</div>
		<div class="menuBar phone">
			<div>
				<input type="hidden" name="isLogin" value="${sessionScope.member.usr_no}">
			<c:choose>
				<c:when test="${sessionScope.member == null}">
					<div class="loginMenu">
						<div class="subMenuTitle" style="height: 4em"></div>
						<img src="/resources/images/img_photo_2.gif" class="img-rounded" style="vertical-align: text-bottom; height: 40%">
					</div>
					<div class="sideMenu" style="height: auto;">
						<div style="line-height: 3.5; margin : 3% 0 8% 0">
						<div class="menuBarTitle">
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4">Login</span>						
						</div>
						<div onclick="loginFrm()" class="menuBarTitle">
							<span class="glyphicon glyphicon-user sideIconText" aria-hidden="true"></span>
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4; padding-left: 8%">Login</span>						
						</div>
						<a href="/member/new" class="menuBarTitle">
<!-- 							<img alt="" src="https://blzgdapipro-a.akamaihd.net/game/unlocks/0x02500000000002F7.png" style="width: 30px; height: 30px"> -->
							<span class="glyphicon glyphicon-off sideIconText" aria-hidden="true"></span>
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4; padding-left: 8%">Sign In</span>	
						</a>
<!-- 						<div onclick="testOverwatch()" class="menuBarTitle">
							<img alt="" src="https://blzgdapipro-a.akamaihd.net/game/unlocks/0x02500000000002F7.png" style="width: 30px; height: 30px">
							<span class="glyphicon glyphicon-off sideIconText" aria-hidden="true"></span>
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4; padding-left: 8%">overwatchTest</span>	
							<form id="testPost" action="/overwatch" method="post">
								<input type="hidden" name="overwatchId" value="이성주-3468">
							</form>
						</div> -->
						</div>
					</div>					
				</c:when>
				<c:otherwise>
					<div class="loginMenu">
						<div class="subMenuTitle" style="height: 4em"></div>
						<!-- <img src="/resources/images/img_photo_2.gif" class="img-rounded" style="vertical-align: text-bottom; height: 60%"> -->
						<img id="thumnail" src="/image?file=${sessionScope.member.filePath}/${sessionScope.member.sysName}" onError="javascript:errorImg()" style="vertical-align: text-bottom; max-width: 212px; max-height: 143px"/>
						<div>
						<a href="/member/mod" class="sideALink" style="padding-left: 0%">
							<span class="sideIconText sideTextLogin" style="font-size: 15px">${sessionScope.member.nickName}</span>
						</a>
						</div>
					</div>
					<div class="sideMenu" style="height: auto">
						<div style="line-height: 3; margin : 3% 0 6% 0">
						<div class="menuBarTitle">
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4">회원 정보</span>						
						</div>
						<div>
						<a href="/member/mod"  class="menuBarTitle">
							<span class="glyphicon glyphicon-user sideIconText" aria-hidden="true"></span>
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4; padding-left: 8%">정보 수정</span>						
						</a>
						</div>
						<a href="/member/logout" class="menuBarTitle">
							<span class="glyphicon glyphicon-off sideIconText" aria-hidden="true"></span>
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4; padding-left: 8%">로그아웃</span>	
						</a>
						</div>
					</div>
					<div class="sideMenu" style="height: auto; border-bottom: none">
						<div style="line-height: 3; margin : 3% 0 6% 0">
						<div class="menuBarTitle">
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4">Communicate</span>						
						</div>
						<div onclick="freeBoard()" class="menuBarTitle">
							<span class="glyphicon glyphicon-user sideIconText" aria-hidden="true"></span>
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4; padding-left: 8%">자유게시판</span>						
						</div>
						<div onclick="searchRecord()" class="menuBarTitle">
<!-- 							<img alt="" src="https://blzgdapipro-a.akamaihd.net/game/unlocks/0x02500000000002F7.png" style="width: 30px; height: 30px"> -->
							<img alt="" src="/resources/images/overwatch_icon_large.png" style="width: 1.5em; margin-bottom: 5%">
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4; padding-left: 8%">overwatch</span>	
						</div>
						<a href="/chat" class="menuBarTitle">
							<span class="glyphicon glyphicon-off sideIconText" aria-hidden="true"></span>
							<span class="sideIconText sideTextLogin" style="font-weight: bold; color: #e4e4e4; padding-left: 8%">채팅 <span class="badge rCnt" style="background-color: #d9534f; font-size: 15px">1</span></span>	
						</a>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		<div class="menuClear phone"></div>
		<header class="navbar navbar-static-top bs-docs-nav" >
			<div class="container">
			<div class="move" style="padding: 0; z-index: 200">
				<div class="phoneHeader">		
				<div class="col-xs-2" style="height: 100%; padding: 0">
					<button type="button" class="btn-xlarge" onclick="showMenuBar()" style="background-color: rgba(68, 114, 148, 1);">
		   				<span class="glyphicon glyphicon-align-justify" style="color: white;"></span>
					</button>
				</div>
				<div class="col-xs-8" style="height: 100%; text-align: center;">
					<img src="/resources/images/catbus.png" style="height: 100%; width: 40%; margin-bottom: 4%"/>
		<!-- 			<span style="font-size: 400%; color: white">제목 없음</span> -->
				</div>
				<div class="col-xs-2" style="height: 100%">
					<button type="button" class="btn-xlarge" onclick="selectMain()" style="background-color: rgba(68, 114, 148, 1); float: right;">
		   				<span class="glyphicon glyphicon-home" style="color: white;"></span>
					</button>
				</div>
				</div>
			</div>
		</header>
		</div>
	</div>
<%-- 	<div class="loginFrmDisplay">
		<%@include file="/WEB-INF/views/login/login.jsp" %>	
	</div> --%>
		<div class="container desktop" style="margin-top: 3%; margin-bottom: 3%">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<ul class="nav nav-tabs">
		  				<li name="headerBtn" role="presentation" class="active" value="main"><a href="/main">Home</a></li>
		 				<li name="headerBtn" role="presentation" value="board"><a href="/board">Board</a></li>
		  				<li name="headerBtn" role="presentation" value="chatting"><a href="#">Messages</a></li>
		  				<li name="headerBtn" role="presentation" value="chatting"><a href="/overwatch">overwatch</a></li>
					</ul>
				</div>
				<div class="col-md-1"></div>		
			</div>
		</div> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="/resources/js/html.js"></script>