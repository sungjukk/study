/**
 * 
 */
var rCho = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
var rJung = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"];
var rJong = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
var userList = new Array();
function errorUserImg(no) {
		$("#thumbnail" + no).attr("src","/resources/images/img_photo_2.gif");
}

function initChatMain() {
	$.ajax({
		url : "/chat/userInfo",
		type : "POST",
		data : {userNo : $("#userNo").val()}
	}).done(function(result) {
		//console.log(result);
		var usrNo = result.split('id="usrNo"');
		var usrNick = result.split('<td class="usrNickName">');
		for (var i = 1; i < usrNo.length; i++) {
			var usrInfo = new Object();
			var val = usrNo[i].split('value="');
			var nickVal = usrNick[i].split('</td>');
			val = val[1].split('"');
			usrInfo.usrNo = val[0];
			usrInfo.usrNickName = nickVal[0];
			usrInfo.splitName = nickNameSpilt(nickVal[0]);
			userList.push(usrInfo);
		}
		//console.log(userList);
		$(".userInfoList").append(result);
	})
}

function searchUser() {
	if ($("#searchKey").val() != "") {
		$(".myProfile").hide();
		var resultList = searchUserList($("#searchKey").val());
		
		for (var i = 0; i <userList.length; i++) {
			$(".uTable" + userList[i].usrNo).hide();
		}
		
		for (var i = 0; i < resultList.length; i++) {
			$(".uTable" + resultList[i].usrNo).show();
		}
		$(".userCnt").html("(" + resultList.length + ")");
	} else {
		$(".myProfile").show();
		for (var i = 0; i <userList.length; i++) {
			$(".uTable" + userList[i].usrNo).show();
		}
		$(".userCnt").html("(" + userList.length + ")");
	}
	
}

function nickNameSpilt(nick) {
	var cho, jung, jong, result = "";
	for (var i = 0; i < nick.length; i++) {
		var c = nick.charCodeAt(i);
		var nTmp = c - 0xAC00;
		if (isHangul(c)) {
			jong = nTmp % 28; //종성
			jung = ((nTmp - jong)/28) % 21; //중성
			cho = (((nTmp - jong)/28) - jung)/21; //초성 			
			//result += rCho[cho] + rJung[jung] + rJong[jong];
			result += rCho[cho];
		} else {
			result += nick.substring(i,i+1);
		}
		//console.log(rCho[cho]);
		//console.log(rJung[jung]);
		//console.log(rJong[jong]);		
	}
	return result;
}

function searchUserList(keyword) {
	var cho, jung, jong, result = "";
	var resultObj = new Array();
	for (var i = 0; i < keyword.length; i++) {
		var c = keyword.charCodeAt(i);
		var hangul = isHangul(c);
		var obj = new Array();
		if (i == 0) {
			obj = userList;
		} else {
			obj = resultObj;
		}
		
		for (var j = 0; j < obj.length; j++) {
			var key = keyword.substring(i,i+1);
			if (hangul) {
				var nTmp = c - 0xAC00;
				if (nTmp >= 0) {
					if (key == obj[j].usrNickName.substring(i,i+1) && i == 0) {
						var val = new Object();
						val.splitName = userList[j].splitName;
						val.usrNo = userList[j].usrNo;
						val.usrNickName = userList[j].usrNickName;
						resultObj.push(val);
					}
					
					if (key != obj[j].usrNickName.substring(i,i+1) && i != 0) {
						resultObj.splice(j,1);
						obj = resultObj;
						j--;
					}
				} else {
					if (i == 0) {
						if (key == userList[j].splitName.substring(i,i+1)) {
							/*						console.log(obj[j].splitName.substring(i,i+1));
						console.log(key);*/
							var val = new Object();
							val.splitName = userList[j].splitName;
							val.usrNo = userList[j].usrNo;
							val.usrNickName = userList[j].usrNickName;
							resultObj.push(val);
							result += userList[j].usrNickName + ",";
						}						
					} else {
						if (key != resultObj[j].splitName.substring(i,i+1)) {
							resultObj.splice(j,1);
							obj = resultObj;
							j--;
						}						
					}
					
				}
			} else {
				if (key == obj[j].splitName.substring(i,i+1) && i == 0) {
					var val = new Object();
					val.splitName = userList[j].splitName;
					val.usrNo = userList[j].usrNo;
					val.usrNickName = userList[j].usrNickName;
					resultObj.push(val);
				}
				
				if (key != obj[j].splitName.substring(i,i+1) && i != 0) {
					resultObj.splice(j,1);
					obj = resultObj;
					j--;
				}
			}
		}		
	}
	
	return resultObj;
}

function isHangul(c) {
	if( 0x1100<=c && c<=0x11FF ) return true;
	if( 0x3130<=c && c<=0x318F ) return true;
	if( 0xAC00<=c && c<=0xD7A3 ) return true;
	
	return false;
}

function chatRoom(usrno) {
	var frm = $("#chatFrm" + usrno);
	frm.attr("action","/chat/room");
	frm.append("<input type='hidden' name='roomNo' value='" + $("#userNo").val() + "'>");
	frm.append("<input type='hidden' name='roomNo' value='" + usrno  + "'>");
	frm.append("<input type='hidden' name='chatUserNo' value='" + usrno  + "'>");
	frm.submit();
}

function groupChatOn() {
	$.ajax({
		url : "/chat/userInfo",
		type : "POST",
		data : {userNo : $("#userNo").val(), isGroup : 'Y'}
	}).done(function(result) {
		$(".userInfoList").html(result);
	});
}

function groupRoomAdd() {
	var form = $("#groupChatFrm");
	form.attr("action","/chat/room");
	form.append("<input type='hidden' name='roomNo' value='" + $("#userNo").val() + "'>");
	
	$("input[type=checkbox]").each(function () {
		if ($(this).is(":checked")) {
			console.log($(this).val());
			form.append("<input type='hidden' name='roomNo' value='" + $(this).val() + "'>");
			form.append("<input type='hidden' name='chatUserNo' value='" + $(this).val() + "'>");
		}
	});
	
	form.submit();
}