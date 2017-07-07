<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
</head>
<body>
	<div class="phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container">
		<div class="phoneBody">
		<div class="phoneBodyContent">
			<div style="width: 100%; height: 40%; position: absolute; left: 0%"></div>
			<div style="width: 100%; height: 60%; position: absolute; top: 9em">
				<div style="width: 5%; height: 100%; position: absolute;"></div>
				<div style="width: 90%; position: absolute; left: 5%">
					<form style="width: 100%; height: 100%" action="/overwatch" method="post" id="overFrm">
						<div class="input-group">
							<input type="text" class="form-control" style="width: 100%; height: 45px; font-size: 20px;" name="overwatchId" placeHolder = "닉네임#배틀태그">	
							<span class="input-group-btn">
								<button type="button" class="btn btn-warning" style="height: 45px; font-size: 18px" onclick="viewOverwatch()">검색</button>
							</span>					
						</div>
					</form>
				</div>
				<div style="width: 90%; position: absolute; top: 4em; left: 5%;">
					<button class="btn btn-info" style="width: 100%; height: 100%; font-size: 100%;" onclick="searchId()" >배틀태그 가져오기</button>
				</div>
			</div>
		</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function () {
		$("li[name=headerBtn]").each(function (index) {
			if ($(this).find('a').html() == "overwatch") {
				$(this).attr('class','active');
			} else {
				$(this).attr('class','');
			}
		})
	})
	
	function searchId() {
		var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)

		window.open("/overwatch/search");
	}
	
	function getBattleTag(battleTag) {
		$("input[name=overwatchId]").val(battleTag);
	}
	
	function viewOverwatch() {
		$(".loadingBackground").show();
		$(".phoneMainHeader").css("height","100%");
		$(".headerDiv").css("height","100%");
		$("#overFrm").submit();
		/* $.ajax({
			url : "/overwatch",
			data : {id : $("input[name=overwatchId]").val()},
			type: "POST"
		}).done(function (data) {
		}) */
	}
</script>
</html>