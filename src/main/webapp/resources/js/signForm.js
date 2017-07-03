var checked = false;
var state = "SIGNIN";
var filePath = "";
var sysName = "";
var oriName = "";
var imgUpdate = false;
	$("document").ready(function () {
		$("#userProfile").change(uploadThumnail);
		
		if ($("#isLogin").val() == "") {
			state = "SIGNIN";
		} else {
			state = "MODIFY";
		}
		
		if (state == "SIGNIN") {
			$("#signBtn").show();
			$("#modBtn").hide();
		}
		
		if (state == "MODIFY") {
			$("input[name=userId]").attr("readonly","readonly");
			$("a[name=checkBtn]").hide();
			$("#signBtn").hide();
			$("#modBtn").show();
		}
	})

	function checkId() {
		if ($("input[name=userId]").val() == "") {
			alert("아이디를 입력하세요.");
			$("input[name=userId]").focus();
			return false;
		} else {
			$.ajax({
				type : "POST",
				 url : "/member/checkId",
				 data : {id : $("input[name=userId]").val()},
				 dataType : "json"
			})
			.done(function (data) {
				if (data == true) {
					alert("사용 가능한 아이디 입니다.");
					$("input[name=userId]").attr("readonly","readonly");
					$("a[name=checkBtn]").attr("disabled","disabled");
					checked = true;
					return false;
				} else {
					alert("중복된 아이디 입니다.");
					$("input[name=userId]").focus();
					return false;
				}
			})
		}
	}
	
	function signIn() {
		if (checked == false) {
			alert("중복 확인해주세요.");
			return false;
		}
		
		if ($("input[name=userId]").val() == "") {
			alert("아이디를 입력하세요.");
			$("input[name=userId]").focus();
			return false;
		}
		
		if ($("input[name=userName]").val() == "") {
			alert("닉네임을 입력하세요.");
			$("input[name=userName]").focus();
			return false;
		}
		
		if ($("input[name=userPw]").val() == "") {
			alert("패스워드를 입력하세요.");
			$("input[name=userPw]").focus();
			return false;
		}
		$.ajax({
			url : "/member/new",
			dataType : "json",
			data : {
				id : $("input[name=userId]").val(),
				pw : $("input[name=userPw]").val(),
				nickName : $("input[name=userName]").val(),
				filePath : filePath, 
				sysName : sysName, 
				oriName : oriName
			},
			type : "POST"
		}).done(function (data) {
			if (data == true) {
				alert("회원가입에 성공했습니다.");
				location.href = "http://" + location.host;				
			} else {
				alert("에러가 발생했습니다.");
			}
		})
	}
	
	function uploadThumnail() {
		
		var file = $("#userProfile")[0].files;
		
		var fd = new FormData();
		
		fd.append("profileImg",file[0]);
		fd.append("beforeThum",filePath + "/" + sysName);
		$.ajax({
			url : "/member/thumnail",
			data : fd,
			type : "POST",
			dataType : "json",
			processData : false,
			contentType : false
		})
		.done(function (result) {
			$("#thumnail").attr("src","/image?file=" + result.filePath + "/" + result.sysName);
			filePath = result.filePath;
			sysName = result.sysName;
			oriName = result.oriName;
			imgUpdate = true;
		})
	}

function errorImg() {
	$("#thumnail").attr("src","/resources/images/img_photo_2.gif");
}

function userMod(usr_no) {
	var img = $("#thumnail").attr("src");
	if (img != "/resources/images/img_photo_2.gif" && imgUpdate == false) {
		var imgArr = img.split("image?file=");
		var pathArr = imgArr[1].split("/");
		for (i = 1; i < pathArr.length - 1; i++) {
			filePath += "/" + pathArr[i];
		}
		sysName ="/" + pathArr[pathArr.length - 1];
		oriName = $("#oriName").val();
	}
	
	if ($("input[name=userPw]").val() == "") {
		alert("패스워드를 입력하세요.");
		$("input[name=userPw]").focus();
		return false;
	}
	
	var data = {
			usr_no : usr_no, 
			pw : $("input[name=userPw]").val(), 
			nickName : $("input[name=userName]").val(),
			filePath : filePath, 
			sysName : sysName, 
			oriName : oriName,
			'_method' : 'PUT'};	
	$.ajax({
		url : "/member/" + usr_no + "/mod",
		type : "POST",
		data : data
	}).done(function (result) {
		alert("회원정보 수정이 완료되었습니다.");
		location.href = "/board";
	});
}