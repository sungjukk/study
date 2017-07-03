<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../include/head.jsp" %>
</head>
<script src="/resources/js/signForm.js"></script>
<script type="text/javascript">
	function defaultImg() {
		$("#profileImg").attr("src","/resources/images/img_photo_2.gif");
	}
</script>
<body>
	<div class="phone phoneMainHeader">
		<%@include file="../include/header.jsp" %>
	</div>
	<div class="container phone">
		<div class="phoneBody">
			<div class="phoneBodyContent">
				<input type="hidden" id="isLogin" value="${sessionScope.member}">
				<div class="boardTableDiv">
					<div class="row phoneRow">
						<div class="col-md-3 col-3per"></div>
						<div class="col-md-6 col-94per">
							<form class="form-horizontal" id="signFrm" enctype="multipart/form-data">
								<div class="form-group pForm-group">
									<label for="inputEmail3" class="col-sm-2 control-label" id="hiddenTxt">Email</label>
									<div class="col-sm-6 col-80per" style="padding-right: 0">
										<input type="email" class="form-control pForm-control" name="userId" placeholder="Email" value="${sessionScope.member.id}">
									</div>
									<div class="col-sm-4 col-20per" style="padding: 0">
										<a href="javascript:checkId()" class="btn btn-default check-Btn" name="checkBtn">check</a>
									</div>
								</div>
								<div class="form-group pForm-group">
									<label for="inputPassword3" class="col-sm-2 control-label" id="hiddenTxt">NickName</label>
									<div class="col-sm-8 col-100per">
										<input type="text" class="form-control pForm-control" name="userName" value="${sessionScope.member.nickName}" placeholder="NickName">
									</div>
								</div>
								<div class="form-group pForm-group">
									<label for="inputPassword3" class="col-sm-2 control-label" id="hiddenTxt">Password</label>
									<div class="col-sm-8 col-100per">
										<input type="password" class="form-control pForm-control" name="userPw" placeholder="Password">
									</div>
								</div>
								<div class="form-group pForm-group">
									<label for="inputPassword3" class="col-sm-2 control-label" id="hiddenTxt">Profile</label>
									<div>
										<div class="row">
											<div class="col-15per"></div>
										  	<div class="col-xs-6 col-md-3 col-70per">
										    	<div class="thumbnail">
										      		<img src="/image?file=${sessionScope.member.filePath}/${sessionScope.member.sysName}" alt="thumnail" id="profileImg" onError="javascript:defaultImg()"/>
										      		<input type="hidden" id="oriName" value="${sessionScope.member.oriName}">
										    	</div>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group pForm-group fileDiv">
									<label for="inputFile" class="col-sm-2 control-label"></label>
									<div class="col-sm-8 col-100per">
											<input type="file" id="userProfile" class="fileBtn" />			
									</div>
								</div>
								<div class="form-group pForm-group">
									<div id="signBtn" class="col-sm-offset-2 col-sm-10 margin0">
										<a href="javascript:signIn()" class="btn btn-primary signBtnCss">Sign in</a>
										<button type="reset" class="btn btn-warning signBtnCss">Reset</button>
										<a href="javascript:history.back();" class="btn btn-danger signBtnCss">Cancel</a>
									</div>
									<div id="modBtn" class="col-sm-offset-2 col-sm-10 margin0">
										<a href="javascript:userMod(${sessionScope.member.usr_no})" class="btn btn-primary signBtnCss">Mod</a>
										<a href="javascript:history.back();" class="btn btn-danger signBtnCss">Cancel</a>
									</div>
								</div>
							</form>
						</div>
						<div class="col-md-3 col-3per"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>