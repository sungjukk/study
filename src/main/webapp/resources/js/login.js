/**
 * 
 */
function login() {
	if ($("input[name=id]").val() == "") {
		alert("아이디를 입력하세요.");
		$("input[name=id]").focus();
		return false;
	}
	
	if ($("input[name=pw]").val() == "") {
		alert("패스워드를 입력하세요.");
		$("input[name=pw]").focus();
		return false;
	}
	
	$("#loginFrm").attr("action","/member");
	$("#loginFrm").attr("method","POST");
	
	$("#loginFrm").submit();
}
function errorImg() {
	$("#thumnail").attr("src","/resources/images/img_photo_2.gif");
}