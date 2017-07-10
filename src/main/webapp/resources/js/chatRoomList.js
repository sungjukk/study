/**
 * 
 */
var usrno;
function errorUserImg(no) {
		$("#thumbnail" + no).attr("src","/resources/images/img_photo_2.gif");
}

function initRoomList(usrNo) {
	usrno = usrNo;
	$.ajax({
		url : "/chat/roomList",
		type : "POST",
		data : {usrNo : usrNo}
	}).done(function(result) {
		$(".roomProfile").html(result);
	})
}

function chatRoom(cno) {
	var frm = $("#chatFrm" + cno);
	var html = "";
	html += "<input type='hidden' name='cno' value='" + cno + "'>";
	html += "<input type='hidden' name='uno' value='" + usrno + "'>";
	frm.attr("action","/chat/room");
	frm.html(html);
	frm.submit();
}