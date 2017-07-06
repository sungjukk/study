/**
 * 
 */

function errorUserImg(no) {
		$("#thumbnail" + no).attr("src","/resources/images/img_photo_2.gif");
}

function initRoomList(usrNo) {
	$.ajax({
		url : "/chat/roomList",
		type : "POST",
		data : {usrNo : usrNo}
	}).done(function(result) {
		console.log(result);
		$(".roomProfile").html(result);
	})
}

function chatRoom(usrno) {
	var frm = $("#chatFrm" + usrno);
	frm.attr("action","/chat/room");
	frm.append("<input type='hidden' name='roomNo' value='" + $("#userNo").val() + "'>");
	frm.append("<input type='hidden' name='roomNo' value='" + usrno  + "'>");
	frm.submit();
}