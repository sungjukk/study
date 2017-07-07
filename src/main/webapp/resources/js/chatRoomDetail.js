/**
 * 
 */
var cno;
var myNo;
var sendUsr;
var reciveUsr = "";
var readUser = 0;
var maxSeq = 0;

function errorUserImg(no) {
	$(".chatThumbnail" + no).attr("src","/resources/images/img_photo_2.gif");
}
function initChat(uno,rNo,usrList) {
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
		//console.log(result);
		$(".chatMessageList").append(result);
		$(".chatList").scrollTop($(".chatMessageList").height());
		$("#sendImg").on('load',function () {
			$(".chatList").scrollTop($(".chatMessageList").height());
		});
/*		$("#focusChat").focus();
		$("#focusChat").hide();*/
		maxSeq = $("#maxSeq").val();
		//console.log(maxSeq);
/*		console.log($(".chatList").scrollTop());
		console.log($(".chatMessageList").height());*/
		//console.log($(".chatList").scrollTop());
	});
	
	$.ajax({
		url : "/chat/getReadCnt",
		type : "POST",
		data : {cno : cno}
	}).done(function (json) {
		var readCnt = new Object();
		readCnt.readCnt = json;
		readCnt.cno = cno;
		chat.emit('readMsg',readCnt);
	})
}

function sendMsg() {
	var data = {
		cno : cno,
		content : $(".chatMsg").val(),
		send_usrno : myNo,
		receive_usrno : reciveUsr
	}
	
	$.ajax({
		url : "/chat/sendMsg",
		data : data,
		type : "POST"
	}).done(function (result) {
		var seq = result.split('value="')[1].split('"')[0];
		data.state = chatType;
		maxSeq = seq;
		data.maxSeq = maxSeq;
		chat.emit('sendMsg',data);
		$(".chatMessageList").append(result);
		$(".chatList").scrollTop($(".chatMessageList").height());	
	});
	
	$(".chatMsg").val("");
}

function chatUpload() {
	$("#chatFile").trigger('click');
}

function chatFileUpload() {
	var data = {
			cno : cno,
			send_usrno : myNo,
			recive_usrno : reciveUsr
	}
	
	var file = $("#chatFile")[0].files;
	var fd = new FormData();
	
	fd.append("chatFile",file[0]);
	fd.append("cno",data.cno);
	fd.append("send_usrno",data.send_usrno);
	fd.append("receive_usrno",data.recive_usrno);
	
	$.ajax({
		url : "/chat/file",
		data : fd,
		type : "POST",
		processData : false,
		contentType : false
	}).done(function(result) {
		var seq = result.split('value="')[1].split('"')[0];
		data.state = chatType;
		maxSeq = seq;
		data.maxSeq = maxSeq;
		chat.emit('sendMsg',data);
		$(".chatMessageList").append(result).find('img').on('load',function () {
			$(".chatList").scrollTop($(".chatMessageList").height());			
		});
	});
}


function showChatImg(imgPath) {
	$(".showChatImg").show();
	$(".viewChatImg").attr('src','/image?file='+imgPath);
	$(".viewChatImg").on('load', function () {
		console.log($(".viewChatImg").height());
		console.log($(".chatImgDiv").height());
		var margin = ($(".chatImgDiv").height() - $(".viewChatImg").height())/2;
		if (margin < -184) margin = -184;
		$(".viewChatImg").css("margin-top",margin + "px");
	});
}


function chatVideoPlay(seq) {
	var video = document.getElementById("chatVideo" + seq);
	if(video.paused) {
		video.play();		
	} else {
		video.pause();
	}
}