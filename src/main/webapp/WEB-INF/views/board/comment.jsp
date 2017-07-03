<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>Insert title here</title>
</head>
<body>
	<input type="hidden" id="count" value="${commentCount}">
	<c:forEach var="comment" items="${commentList}" varStatus="qwe">
	<tr style="background-color: #f9f9f9">
						<c:choose>
							<c:when test="${comment.del_yn == 'N'}">
								<td style="text-align: left;">
									<c:set var="marginLeft" value="${comment.first_seq * 3 - 3}"></c:set>
									<div style="margin-bottom: 1%; margin-left: ${marginLeft}%">
		<%-- 								<c:if test="${comment.first_seq > 1}">
											<c:forEach begin="1" end="${comment.first_seq}">&nbsp;&nbsp;</c:forEach>
										</c:if> --%>
										<img src="/image?file=${comment.filePath}/${comment.sysName}" onError="javascript:errorImg(this)" style="width: 30px; height: 20px;" />
										<small>${comment.nickName}</small>
									</div>
		 							<div id="commentContent${comment.comment_no}" style="margin-left: ${marginLeft}%">
		<%--  								<c:if test="${comment.first_seq > 1}">
											<c:forEach begin="1" end="${comment.first_seq}">&nbsp;&nbsp;</c:forEach>
										</c:if> --%>
		 								${comment.content}
		 							</div>
		 							<div id="updateComment${comment.comment_no}" style="display: none;">
		 								<textarea id="updateCommentContent${comment.comment_no}" rows="3" class="form-control"></textarea>
		 							</div>
									<div>
		<%-- 								<c:if test="${comment.first_seq > 1}">
											<c:forEach begin="1" end="${comment.first_seq}">&nbsp;&nbsp;</c:forEach>
										</c:if> --%>
										<a id="isShowComment${comment.comment_no}" href="javascript:showCommentInsert(${comment.comment_no})" class="btn btn-link" style="padding: 0; font-size: 50%; margin-left: ${marginLeft}%">▼댓글달기</a>
									</div>
								</td>
							</c:when>
							<c:otherwise>
								<td style="text-align: left;">삭제된 글 입니다.</td>
							</c:otherwise>
						</c:choose>
						<td colspan="2" style="text-align: right;">
							<c:if test="${comment.del_yn == 'N'}">
								<div style="margin-bottom: 3%"><small>${comment.showDate}</small></div>
								<c:if test="${sessionScope.member.usr_no eq comment.usr_no}">
								<div id="commentContentBtn${comment.comment_no}">
									<a href="javascript:updateCommentForm(${comment.comment_no},'true')" class="btn btn-default btn-xs">수정</a>
									<a href="javascript:delComment(${comment.comment_no},${comment.first_seq})" class="btn btn-default btn-xs">삭제</a>
								</div>
								<div id="updateCommentBtn${comment.comment_no}" style="display: none;">
									<a href="javascript:updateComment(${comment.comment_no})" class="btn btn-default btn-xs">수정</a>
									<a href="javascript:updateCommentForm(${comment.comment_no},'false')" class="btn btn-default btn-xs">취소</a>
								</div>
								</c:if>							
							</c:if>
						</td>
					</tr>
					<tr id="commentInsert${comment.comment_no}" style="background-color: #f9f9f9; display: none;">
						<td colspan="2">
							<textarea id="insertCommentContent${comment.comment_no}" rows="3" class="form-control"></textarea>
						</td>
						<td style="padding-left: 0">
							<button class="btn btn-default" style="margin-top: 30%" onclick="insertCommentOfComment(${comment.comment_no},${comment.first_seq},${sessionScope.member.usr_no},${comment.sec_seq})">등록</button>
						</td>
					</tr>
	</c:forEach>
</body>
</html>