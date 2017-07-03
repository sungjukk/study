<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
<title>Insert title here</title>
<script src="/resources/js/boardDetail.js"></script>
<script type="text/javascript">
	function deleteBoard() {
		$("#delBoard").submit();
	}
	function selectList() {
		$("#delBoard").attr("action","/board");
		$("input[name=_method]").val("PUT");
		$("#delBoard").submit();
	}
	function fileDownload(i) {
		$("#fileFrm"+i).submit();
	}
</script>
</head>
<body>
	<div class="phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
			<div class="phoneBodyContent">
		<input type="hidden" id="boardNo" value="${board.board_no}">
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-9">
				<table class="table table-striped">
					<tr>
						<th colspan="2">
						<c:out value="${board.title}"/>
<%-- 						<span style="float: right; line-height: 100%;"><small>조회수 : <c:out value="${board.cnt}" /></small></span> --%>
 						<p style="text-align: right !important; float: right; margin: 0; padding-top: 5px; font-weight: normal;"><small>조회수 : <c:out value="${board.cnt}" /></small></p>
						</th>
					</tr>
					<tr>
<%-- 						<td><div style="text-align: left;"><small>작성자 : <c:out value="${board.writer}" /></small></div></td> --%>
						<td>
							<div style="text-align: left;">
								<c:if test="${fn:length(board.fList) > 0}">
									<small>첨부파일 : 
									<c:forEach var="file" items="${board.fList}" varStatus="fList">
										<a href="/download/${file.file_no}">${file.oriName}</a>
									</c:forEach>				
									</small>
								</c:if>
							</div>
						</td>
						<td>
							<fmt:formatDate var="regDate" value="${board.reg_date}" pattern="yyyy/MM/dd hh:mm:ss" />
							<div style="text-align: right;">
								<small><c:out value="${regDate}" /></small>
							</div>
						</td>
					</tr>
					<tr>
						<td style="height: 400px;" colspan="2"><div class="text-left">${board.content}</div></td>
					</tr>
				</table>
			</div>
			<div class="col-md-1"></div>
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-9">
				<table class="table table-striped">
					<colgroup>
						<col width="80%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
					<tr>
						<td scope="col" style="text-align: left;" colspan="2">
							<div id="commentCount" style="margin-bottom: 1%">댓글 ${board.c_count}개</div>
							<textarea id="commentContent" class="form-control" rows="3"></textarea>
							<br>
						</td>
						<td scope="col" style="vertical-align: middle; margin-left: 10%; padding-left: 0">
							<a href="javascript:insertComment(${board.board_no},${sessionScope.member.usr_no})" class="btn btn-default" style="line-height: 300%;">등록</a>
						</td>
					</tr>
					<tbody id="commentList"></tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8"></div>
			<div class="col-md-3">
				<form id="delBoard" action="/board/${board.board_no}" method="POST" style="margin-bottom: 5em">
					<input type="hidden" name="pageNo" value="${pageNo}">
					<a href="/board" class="btn btn-primary">목록</a>
					<c:if test="${sessionScope.member.usr_no == board.usr_no}">
						<a href="/board/${board.board_no}/mod" class="btn btn-info">수정</a>
						<input type="hidden" name="_method" value="DELETE">
						<a href="javascript:deleteBoard()" class="btn btn-danger">삭제</a>					
					</c:if>				
				</form>
			</div>
		</div>
		</div>
		</div>
	</div>
	<div class="footer">
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>