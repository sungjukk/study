<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
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
	
	function testSummer() {
	}
	function insertContent() {
		if ($("input[name=title]").val() == "") {
			alert("������ �Է��ϼ���.");
			$("input[name=title]").focus();
			return false;
		}
		if ($("input[name=writer]").val() == "") {
			alert("�ۼ��� �Է��ϼ���.");
			$("input[name=writer]").focus();
			return false;
		}
 		if ($("#content").summernote('code') == "<p><br></p>") {
			alert("���� �Է��ϼ���.");
			$("#content").focus();
			return false;
		} 
		
 		$("input[name=content]").val($("#content").summernote('code'));
		$("form[name=writeFrm]").submit();
	}
</script>
<body>
	<div class="phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
			<div class="phoneBodyContent">
				<form class="writeFrmPhone" name="writeFrm" action="/board" method="POST" enctype="multipart/form-data">
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
			<label class="col-sm-2 control-label writeFrmTxt">����</label>
				<input name="title" type="text" class="form-control pInput" >
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<label class="col-sm-2 control-label writeFrmTxt">�ۼ���</label>
				<input type="text" class="form-control pInput" value="${sessionScope.member.nickName}" readonly="readonly">
				<input type="hidden" name="usr_no" value="${sessionScope.member.usr_no}">
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<label class="col-sm-2 control-label writeFrmTxt">����</label>
				<input type="file" name="file">
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row writeFrm">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<label class="col-sm-2 control-label writeFrmTxt">����</label> 
<!-- 				<textarea name="content" rows="5" cols="5" class="form-control"></textarea> -->
				<div id="content"></div>
				<input type="hidden" name="content" value="" />
			</div>
			<div class="col-md-4"></div>
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4 btn-align">
				<a href="javascript:insertContent()" class="btn btn-primary">���</a>
				<a href="/board" class="btn btn-danger">���</a>				
			</div>
			<div class="col-md-4"></div>
		</div>
		</form>
			</div>
		</div>
	</div>
	<div class="footer">
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>