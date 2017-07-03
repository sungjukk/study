<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="/resources/js/jquery-3.2.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		if ($("input[name=tagId]").val() == "") {
			$("#findId").submit();			
		} else {
			opener.getBattleTag($("input[name=tagId]").val());
			window.open('', '_self', '');
	        window.close();
		}
		
	})
</script>
<body>
	<form action="https://www.euneezz.o-r.kr:3000/auth/bnet" id="findId">
	</form>
	<input type="hidden" name="tagId" value="${battleTag}">
</body>
</html>