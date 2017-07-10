/**
 * 
 */
//var chat = io.connect("http://52.197.169.128:10001");	
var chat = io.connect("http://122.99.198.182:10001");	
var uNo;
$(document).ready(function() {
	uNo = $("input[name=isLogin]").val();
	var usrInfo = new Object();
	if (uNo == "") {
	} else {
		getNotReadCnt(uNo);
		usrInfo.state = chatType;
		usrInfo.userNo = uNo;
		if (chatType == 1) {
		} else if (chatType == 2) {
			
		} else if (chatType == 3) {
			usrInfo.cno = cno;
		}
		chat.emit('test',usrInfo);	
	}
	
	
});

chat.on('reciveMsg',function(result) {
	var receiveUser = result.receive_usrno.split(",");
	var isUser = false;
	
	for (var i = 0; i < receiveUser.length; i++) {
		if (receiveUser[i] == uNo) {
			isUser = true;
		}
	}
	
	if (isUser == true) {
		chatMsgProcess(result);
	}
});

function chatMsgProcess(result) {
	getNotReadCnt(uNo);
	if (chatType == 1) {
		// 아무 곳이나 있는 경우
	} else if (chatType == 2) {
		// 방목록에서 대기 중인 경우
		initRoomList(uNo);
	} else if (chatType == 3) {
		// 메세지를 보낸 유저랑 같은 방에 있는 경우
		if (cno == result.cno) {
			console.log("asdsad");
			result.usr_no = uNo;
			$.ajax({
				url : "/chat/receiveMsg",
				type : "POST",
				data : result
			}).done(function (text) {
				$.ajax({
					url : "/chat/getReadCnt",
					type : "POST",
					data : result
				}).done(function (json) {
					if ($(".chatMessageList").height() * 0.5 <= $(".chatList").scrollTop()) {
						$(".chatMessageList").append(text).find('img').on('load',function () {
							$(".chatList").scrollTop($(".chatMessageList").height());			
						});
						$(".chatList").scrollTop($(".chatMessageList").height());
					} else {
						$(".chatMessageList").append(text).find('img').on('load',function () {
							$(".chatList").scrollTop($(".chatMessageList").height());			
						});
						$(".chatList").scrollTop($(".chatMessageList").height());	
//						$(".scrollUp").html(text);
						/*$(".chatMessageList").append(text);
						*/
					}
					
					// 전부 다 읽은 경우
					if (json.length == 0) {
						$(".readCnt").each(function () {
							$(".readCnt").hide();
						});
					} else if(json.length > 0) {
						// 전부 다 읽은 경우가 아니라 하나하나 값을 변동시켜줘야 함
						for (var i = 0; i < json.length; i++) {
							var rc = json[i];
							if (rc.isRead == 0) {
								$(".read" + rc.cno + rc.chat_seq).hide();	
							} else {
								$(".read" + rc.cno + rc.chat_seq).html(rc.isRead);					
							}
						}
					}
					
					// 읽었다고 알려줘야함
					var readCnt = new Object();
					readCnt.readCnt = json;
					readCnt.cno = result.cno;
					chat.emit('readMsg',readCnt);
				});				
			});
		} else {
			// 방에는 있지만 메세지를 보낸 유저랑 다른 방에 있는 경우
			getNotReadCnt(usr_no);
		}
	}
}

chat.on('readCnt',function(data) {
	if (cno == data.cno) {
		readCnt(data);
	}
});

function readCnt(data) {
	if (chatType == 1) {
	} else if (chatType == 2) {
	} else if (chatType == 3) {
		if (data.readCnt.length == 0) {
			$(".readCnt").each(function () {
				$(".readCnt").hide();
			});
		} else if(data.readCnt.length > 0) {
			for (var i = 0; i < data.readCnt.length; i++) {
				var rc = data.readCnt[i];
				if (rc.isRead == 0) {
					$(".read" + rc.cno + rc.chat_seq).hide();	
				} else {
					$(".read" + rc.cno + rc.chat_seq).html(rc.isRead);					
				}
			}
		}		
	}
}

function getNotReadCnt(uNo) {
	$.ajax({
		url : "/chat/notReadCnt",
		type : "POST",
		data : {usr_no : uNo},
		dataType : "json"
	}).done(function (result) {
		$(".rCnt").html(result);
	});
}