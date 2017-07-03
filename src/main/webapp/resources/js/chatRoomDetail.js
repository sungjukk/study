/**
 * 
 */
var cno;
var myNo;
var sendUsr;
var reciveUsr = "";
var readUser = 0;

function errorUserImg(no) {
	$(".chatThumbnail" + no).attr("src","/resources/images/img_photo_2.gif");
}
function initChat(uno,rNo,usrList) {
	//var chat = io.connect("http://localhost:10001");
	cno = rNo;
	var usrNo = new Array();
	myNo = uno;
	var userList = usrList.split(",");
	readUser = userList.length - 1;
	for (var i = 0; i < userList.length; i++) {
		if (myNo != userList[i]) {
			usrNo.push(userList[i]);
		}
	}
	
	for (var i = 0; i < usrNo.length; i++) {
		if (i == usrNo.length - 1) {
			reciveUsr += usrNo[i];
		} else {
			reciveUsr += usrNo[i] + ",";
		}
	}
	
	$.ajax({
		url : "/chat/msgList",
		type : "POST",
		data : {cno : cno, usrNo : myNo}
	}).done(function (result) {
		console.log(result);
		$(".chatMessageList").append(result);
	});
}

function sendMsg() {
	var data = {
		cno : cno,
		content : $(".chatMsg").val(),
		send_usrno : myNo,
		recive_usrno : reciveUsr
	}
	
	$.ajax({
		url : "/chat/sendMsg",
		data : data,
		type : "POST"
	}).done(function (result) {
		console.log(result);
		$(".chatMessageList").append(result);
	});
	
	$(".chatMsg").val("");
}