<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!-- <div style="width: 100%; height: 7%; background-color: white; margin-top: 2%">
	<div class="col-xs-2">
		<a href="javascript:history.back();" style="color: #424242">
			<span class="glyphicon glyphicon-arrow-left" aria-hidden="true" style="font-size: 400%; line-height: 2"></span>			
		</a>
	</div>
</div> -->
<div style="width: 100%; height: 80%; margin-top: 2%">
 	<div style="width: 100%; height: 50%;">
 		<div class="col-xs-2"></div>
 		<div class="col-xs-8" style="text-align: center;">
	 		<img src="/resources/images/login.png" style="width: 246px; height: 246px;" /> 		
 		</div>
 		<div class="col-xs-2"></div>
 	</div>
<!-- 	<div class="radius">
		<span class="glyphicon glyphicon-lock" aria-hidden="true" style="font-size: 2000%; color: white;"></span>
	</div> -->
	<form id="loginFrm" style="width: 100%; height: 20%">
	<div style="width: 100%; height: 100%;">
		<div style="width: 100%;height: 45%;">
			<div class="asd" style="width: 10%; height: 50%"></div>
			<div class="asdf" style="width: 80%">
				<input type="text" name="id" class="form-control" placeholder="아이디" style="height: 40px; font-size: 15px">
			</div>
		</div>
		<div style="height: 45%; margin-top: 2%">
			<div class="asd" style="width: 10%; height: 50%"></div>
			<div class="asdf" style="width: 80%">
				<input type="password" name="pw" class="form-control" placeholder="패스워드" style="height: 40px; font-size: 15px">
			</div>
		</div>
	</div>
	</form>
	<div style="width: 100%; height: 15%; margin-top: 4%">
		<div class="col-xs-6" style="height: 100%;">
			<a href="/member/new" class="btn btn-default" style="width: 80%; height: 50%; margin-left: 18%; padding: 0"><span style="font-size: 20px; line-height: 2">Sign in</span></a>
		</div>
		<div class="col-xs-6" style="height: 100%;">
			<a href="javascript:login()" class="btn btn-default" style="width: 80%; height: 50%; margin-left: 2%; padding: 0"><span style="font-size: 20px; line-height: 2">Login</span></a>
		</div>
	</div>
</div>