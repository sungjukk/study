/**
 * 
 */
var usrno;
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
	var html = "";
	html += "<input type='hidden' name='roomNo' value='" + $("#userNo").val() + "'>";
	html += "<input type='hidden' name='roomNo' value='" + usrno + "'>";
	html += "<input type='hidden' name='chatUserNo' value='" + usrno  + "'>";
	frm.attr("action","/chat/room");
	frm.html(html);
	frm.submit();
}