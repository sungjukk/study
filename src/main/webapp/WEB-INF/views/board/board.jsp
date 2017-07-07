<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ page import="kr.co.mlec.controller.PageController" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
</head>
<script type="text/javascript">
	$(document).ready(function () {
		$("li[name=headerBtn]").each(function (index) {
			if ($(this).find('a').html() == "Board") {
				$(this).attr('class','active');
			} else {
				$(this).attr('class','');
			}
		})
		/* $.ajax({
			url : "/board/test",
			dataType : "json"
		})
		.done(function (json) {
			html.createByList("PAGELIST",json);
		}) */
		
		function pageSelect() {
			var selectNo = $("input[name=pageNo]").val();
			var pageCnt = $("input[name=pageNoCnt]").val();
			 for (var i = 1; i <= pageCnt; i++) {
				if (i == selectNo) {
					$("#selectPage" + i).addClass("active");
					break;
				}
			}
		}
		
		var pageNo = 1;
		var pageSize = 10;
		var isLastPage = false;
		$(".phoneBody").scroll(function() {
			var currentScroll = $(".boardTableDiv").height() + $(".boardMore").height() + $(".searchBoard").height();

			if ($(".phoneBody").scrollTop() == Math.ceil(currentScroll - $(".phoneBody").height())) {
				if (isLastPage == false) {
					$(".lodingImg").css("visibility","visible");
					$.ajax({
						url :"/board",
						type : "GET",
						data : {"type":"phone","pageNo":++pageNo},
						dataType : "text"
					}).done(function (result) {
						var html = result.split('<div class="boardTableDiv">')[2].split('</colgroup>')[1].split('</table>')[0];
						var count = html.split('<tr>').length - 1;
						
						
						if (count <= pageSize) isLastPage = true;
						
						$(".boardTable > tbody").append(html);
						$(".lodingImg").css("visibility","hidden");
					})
				} else if (isLastPage == true) {
					alert("마지막 페이지입니다.");
				}
			}
		});
		
		
		pageSelect();
	});
	
	function goPage(i) {
		/* $("input[name=pageNo]").val(i);
		$("#pageFrm").submit(); */
		 $.ajax({
			url : "/board/savePageNo",
			type : "POST",
			data : {"pageNo" : i},
			dataType : "text"
		}).done(function () {
			location.href = "/board";
		}) 
	}
	
	function searchType(type) {
		var html = "";
		if (type == "title") {
			html += "제목&nbsp;&nbsp;";
			$("input[name=searchType]").val("title");
		} else {
			html += "작성자&nbsp;"
			$("input[name=searchType]").val("writer");
		}
		html += "<span class='caret'></span>";
		$("#search-btn").html(html);
	}
	
	function searchBoard() {
		<% session.setAttribute("pageNo", "1");%>
		$("#searchFrm").submit();		
	}
</script>
<body style="overflow-y: hidden">
	<div class="phone phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container phone pBoard">
		<div class="phoneBody">
			<div class="phoneBodyContent">
				<div class="searchBoard">
					<ul class="nav nav-pills" role="tablist">
					  <li role="presentation" class="active"><a href="#">Home</a></li>
					  <li role="presentation"><a href="#">Profile</a></li>
					  <li role="presentation"><a href="#">Messages</a></li>
					  <li role="presentation" style="float: right;"><a href="/board/new"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a></li>
					</ul>
				</div>
				<div style="width: 100%; height: 3em"></div>
				<div class="boardTableDiv">
					<table width="100%;" class="boardTable">
						<colgroup>
							<col width="85%" />
							<col width="15%" />
						</colgroup>
						<c:forEach var="board" items="${boardList}" varStatus="qwe">
							<tr>
								<td scope="col">
									<a class="phoneABtn" href="/board/${board.board_no}"><div class="titleTxt">${board.title}</div></a>
									<div class="writeTxt">${board.writer}</div>
									<div class="dateTxt">
										<fmt:formatDate var="regDate" value="${board.reg_date}" pattern="yyyy/MM/dd" />
										<c:out value="${regDate}"/>
									</div>
									<div class="viewCnt">
										<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
									</div>
									<div class="viewCnt" style="margin-left: 5px">
										${board.cnt}
									</div>
								</td>
								<td scope="col">
									${board.c_count}
									<div class="commentTxt" style="font-size: 70%; color: #848484">댓글</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="boardMore">
					<img style="width: 15%; visibility: hidden" class="lodingImg" src="https://thomas.vanhoutte.be/miniblog/wp-content/uploads/light_blue_material_design_loading.gif">
				</div>
			</div>
		</div>
	</div>
	<div class="container desktop">
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-9">
				<table class="table table-hover">
					<colgroup>
						<col width="6%" />
						<col width="6%" />
						<col width="30%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
					<tr>
						<th scope="col"><input type="checkbox" id="allCheck"></th>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">날짜</th>
						<th scope="col">조회수</th>
					</tr>
					<c:forEach var="board" items="${boardList}" varStatus="qwe">
						<tr>
							<td><input type="checkbox"></td>
							<td><c:out value="${board.bnum}" /></td>
							<td><a href="/board/${board.board_no}"><c:out value="${board.title}" /> <span class="label label-info">${board.c_count}</span></a></td>
							<td><c:out value="${board.writer}" /></td>
							<td><fmt:formatDate var="regDate" value="${board.reg_date}" pattern="yyyy/MM/dd" />
								<c:out value="${regDate}"/>
							</td>
							<td><c:out value="${board.cnt}"/></td>
						</tr>
					</c:forEach>
				</table>
		</div>
		<div class="col-md-1"></div>
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-1"></div>
			<div class="col-md-7">
				<form id="searchFrm" action="/board" method="get">
					<div class="input-group">
	     				<div class="input-group-btn">
	     					<input type="hidden" name="searchType" value="title">
	        				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" id="search-btn">제목 <span class="caret"></span></button>
	        				<ul class="dropdown-menu" role="menu">
	          					<li><a href="javascript:searchType('title')">제목</a></li>
	          					<li><a href="javascript:searchType('writer')">작성자</a></li>
	        				</ul>
	      				</div><!-- /btn-group -->
	      				<input type="text" class="form-control" aria-label="..." name="searchContent">
	      				<span class="input-group-btn">
	       					<button class="btn btn-default" type="button" onclick="searchBoard()">검색</button>
	      				</span>
					</div>				
				</form>
			</div>
		</div>
		<div class="row" style="margin-top: 1%">
			<div class="col-md-1"></div>
			<div class="col-md-9" style="text-align: center;">
			<form id="pageFrm" action="/board" method="POST">
			<input type="hidden" name="_method" value="PUT">
			<input type="hidden" name="pageNo" value="${pv.pageCnt}">
 			<input type="hidden" name="pageNoCnt" value="${pv.pageNoCnt}">
			<nav>
				  <ul class="pagination" style="margin: 0">
				    <li>
				      <a href="javascript:goPage(1)" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				     <c:forEach begin="1" end="${pv.pageNoCnt}" var="i">
				    	<li id="selectPage${i}" class="">
				    			<a href="javascript:goPage(${i})">${i}</a>
				    	</li>
				    </c:forEach>
				    <li>
				      <a href="javascript:goPage(${pv.pageNoCnt})" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				  </ul>
					<a href="/board/new" class="btn btn-primary btn-insert">등록</a>	
				  	<a href="/board" class="btn btn-danger btn-insert">삭제</a>
				</nav>
			</form>
			</div>
			<div class="col-md-1"></div>
		</div>
	</div>
	<div class="footer">
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>