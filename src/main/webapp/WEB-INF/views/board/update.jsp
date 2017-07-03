<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
<%@include file="../include/header.jsp" %>
<title>Insert title here</title>
</head>
<script type="text/javascript">
	$(document).ready(function () {
		$("#content").summernote({
			height : 300,
			callbacks: {onImageUpload : function(files, editor, welEditable) {
				sendFile(files[0], editor, welEditable);
			}
		}
		});
	})
	
	function sendFile(file, editor, welEditable) {
		data = new FormData();
		data.append("uploadFile",file);
		$.ajax({
			url : "/board/new/img",
			data : data,
			type : "POST",
			contentType : false,
	        processData : false,
		}).done(function (data) {
			imgUrl = "/image?file=" + data.filePath +"/" + data.sysName;
			$('#content').summernote("insertImage", imgUrl);
		})
	}
	
	function updateContent() {
		if ($("input[name=title]").val() == "") {
			alert("제목을 입력하세요.");
			$("input[name=title]").focus();
			return false;
		}
		if ($("input[name=writer]").val() == "") {
			alert("작성자 입력하세요.");
			$("input[name=writer]").focus();
			return false;
		}
		if ($("#content").summernote('code') == "<p><br></p>") {
			alert("내용 입력하세요.");
			$("#content").focus();
			return false;
		} 
		
 		$("input[name=content]").val($("#content").summernote('code'));
		$("form[name=updateFrm]").submit();
	}
</script>
<body>
	<div class="header">
	</div>
	<div class="container">
		<form name="updateFrm" action="/board/${board.board_no}" method="POST">
		<input type="hidden" name="_method" value="PUT">
		<input type="hidden" name="board_no" value="${board.board_no}">
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				제목 
				<input name="title" class="form-control" type="text" value="${board.title}"/>
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				작성자 
				<input name="writer" class="form-control" type="text" value="${board.writer}" readonly="readonly" />
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				파일 <input type="file" name="file">
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				내용 
<%-- 				<textarea name="content" class="form-control" rows="5" cols="5">${board.content}</textarea> --%>
				<div id="content">${board.content}</div>
				<input type="hidden" name="content" value="" />
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<c:if test="${fn:length(board.fList) > 0}">
									<small>첨부파일 : 
									<c:forEach var="file" items="${board.fList}" varStatus="fList">
										<a href="/download/${file.file_no}">${file.oriName}</a>
										<a href="#1" style="float: right;">[삭제]</a><br>
									</c:forEach>				
									</small>
								</c:if>
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4 btn-align">
				<a href="javascript:updateContent()" class="btn btn-info">수정</a>
				<a href="/board/${board.board_no}" class="btn btn-danger">취소</a>
			</div>
			<div class="col-md-4"></div>
		</div>
		</form>
	</div>
	<div class="footer">
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
<%-- 		<div>
			제목 : <input name="title" type="text" value="${board.title}">
		</div>	
		<div>
			작성자 : <input name="writer" type="text" value="${board.writer}">
		</div>	
		<div>
			내용 : <textarea name="content" rows="5" cols="5">${board.content}</textarea>
		</div>
		<input type="submit" value="수정">	
	</form> --%>
</body>
</html>