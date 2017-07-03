<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/resources/js/jquery-3.2.0.min.js"></script>
<%@include file="../include/header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<div class="header">
	</div>
	<div class="container">
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
						<td style="height: 400px;" colspan="2"><pre style="border: none; background-color: transparent;"><p class="text-left"><c:out value="${board.content}" /></p></pre></td>
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
							<div style="margin-bottom: 1%">댓글 ${board.c_count}개</div>
							<textarea id="commentContent" class="form-control" rows="3"></textarea>
							<br>
						</td>
						<td scope="col" style="vertical-align: middle; margin-left: 10%; padding-left: 0">
							<a href="javascript:insertComment(${board.board_no},${sessionScope.member.usr_no})" class="btn btn-default" style="line-height: 300%;">등록</a>
						</td>
					</tr>
					<tbody name="commentList" data-type="LIST"></tbody>
					<tbody name="commentList" data-type="EMPTY" style="display:none;"><tr><td colspan="6" class="table04_td"><s:text name='message.G014' /></td></tr></tbody>
					<tbody name="commentList" data-type="FORM" style="display:none;">
					<tr style="background-color: #f9f9f9">
						<td style="text-align: left;">
							<div style="margin-bottom: 1%">
								<img src="/image?file={filePath}/{sysName}" onError="javascript:errorImg(this)" style="width: 30px; height: 20px;" />
								<small>{id}</small>
							</div>
 							<div id="commentContent{comment_no}">{content}</div>
 							<div id="updateComment{comment_no}" style="display: none;"><input type="text" class="form-control"></div>
							<div><a id="isShowComment{comment_no}" href="javascript:showCommentInsert({comment_no})" class="btn btn-link" style="padding: 0; font-size: 50%">▼댓글달기</a></div>
						</td>
						<td colspan="2" style="text-align: right;">
							<div style="margin-bottom: 3%"><small>{reg_date}</small></div>
							<c:set var="asd" value="{usr_no}" />
							<c:if test="${!fn:contains(asd,'usr_no')}">
	 							<fmt:parseNumber var="writeNo" value="${asd}"/>							
								${writeNo}
							</c:if>
 							<fmt:parseNumber var="usrNo" value="${sessionScope.member.usr_no}" />
 							<c:if test="${usrNo eq writeNo}">ㅁㄴㅇㅁㄴㅇ</c:if>
							<div id="commentContentBtn{comment_no}">
								<a href="javascript:updateComment({comment_no},'true')" class="btn btn-default btn-xs">수정</a>
								<a href="javascript:delComment({comment_no})" class="btn btn-default btn-xs">삭제</a>
							</div>
							<div id="updateCommentBtn{comment_no}" style="display: none;">
								<a href="#1" class="btn btn-default btn-xs">수정</a>
								<a href="javascript:updateComment({comment_no},'false')" class="btn btn-default btn-xs">취소</a>
							</div>
						</td>
					</tr>
					<tr id="commentInsert{comment_no}" style="background-color: #f9f9f9; display: none;">
						<td colspan="2">
							<input type="text" class="form-control">
						</td>
						<td style="padding-left: 0">
							<button class="btn btn-default">등록</button>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8"></div>
			<div class="col-md-3">
				<form id="delBoard" action="/board/${board.board_no}" method="POST">
					<input type="hidden" name="pageNo" value="${pageNo}">
					<a href="javascript:selectList()" class="btn btn-primary">목록</a>				
					<a href="/board/${board.board_no}/mod" class="btn btn-info">수정</a>
					<input type="hidden" name="_method" value="DELETE">
					<a href="javascript:deleteBoard()" class="btn btn-danger">삭제</a>
				</form>
			</div>
		</div>
	</div>
	<div class="footer">
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>