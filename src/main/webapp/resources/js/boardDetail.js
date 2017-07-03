/**
 * 
 */

$(function () {
	initBoardDetail();
});

function insertComment(board_no,usr_no) {
	var usr_no = usr_no;
	var board_no = board_no;
	var content = $("#commentContent").val().replace(/(?:\r\n|\r|\n)/g, '<br />');
	
	$.ajax({
		url : "/board/comment",
		type : "POST",
		data : {
			usr_no : usr_no,
			board_no : board_no,
			content : content
		},
		dataType : "text"
	}).done(makeCommentList);
}

function initBoardDetail() {
	var boardNo = $("#boardNo").val();
	
	$.ajax({
		url : "/board/comment/"+boardNo,
		type:"GET",
		dataType : "text"
	}).done(makeCommentList);
}

function showCommentInsert(commentNo) {
	if ($("#isShowComment" + commentNo).html() == "▼댓글달기") {
		$("#commentInsert" + commentNo).show();
		$("#isShowComment" + commentNo).html("▲댓글접기");
	} else {
		$("#commentInsert" + commentNo).hide();
		$("#isShowComment" + commentNo).html("▼댓글달기");
	}
}

function makeCommentList(result) {
	$("#commentContent").val("");
	var html = result.split("<body>")[1].split("</body>")[0];
	$("#commentList").html(html);
	$("#commentCount").html("댓글 " + $("#count").val() + "개");
}

function dateCalculation(calDate) {
	var nowDate = new Date();
	var longDate = nowDate.getTime();
	var subtraction = longDate - calDate;
	var cDay = subtraction / (24 * 60 * 60 * 1000);
	var cHour = subtraction / (60 * 60 * 1000);
	var cMinute = subtraction / (60 * 1000);
	var cSeconds = subtraction / (1000);
	
	if (cDay > 1) {
		return parseInt(cDay) + "일전";
	} else if (cHour > 1) {
		return parseInt(cHour) + "시간전";
	} else if (cMinute > 1) {
		return parseInt(cMinute) + "분전";
	} else if (cSeconds > 1) {
		return parseInt(cSeconds) + "초전";
	} else {
		return "0초전";
	}
}

function errorImg(e) {
	if ($(e).attr("src") != "/image?file={filePath}/{sysName}") {
		$(e).attr("src","/resources/images/img_photo_2.gif");		
	}
}

function delComment(commentNo,first_seq) {
	$.ajax({
		url : "/board/comment/" + $("#boardNo").val() + "/" + commentNo + "/" + first_seq,
		type : "DELETE"
	}).done(makeCommentList);
}

function updateCommentForm(commentNo,isShow) {
	if (isShow == "true") {
		$("#updateComment"+commentNo).show();
		$("#updateCommentBtn"+commentNo).show();
		$("#commentContent"+commentNo).hide();
		$("#commentContentBtn"+commentNo).hide();
	} else {
		$("#updateComment"+commentNo).hide();
		$("#updateCommentBtn"+commentNo).hide();
		$("#commentContent"+commentNo).show();
		$("#commentContentBtn"+commentNo).show();
	}
}

function updateComment(commentNo) {
	var content = $("#updateCommentContent"+commentNo).val().replace(/(?:\r\n|\r|\n)/g, '<br />');
	var data = {comment_no : commentNo, content : content, '_method' : 'PUT'}	
	$.ajax({
		url : "/board/comment/" + $("#boardNo").val(),
		type : "POST",
		data : data
	}).done(makeCommentList);	
}

function insertCommentOfComment(commentNo,seq,usr_no,commentSeq) {
	var first_seq = seq + 1;
	var sec_seq = commentSeq + 1;
	var content = $("#insertCommentContent" + commentNo).val().replace(/(?:\r\n|\r|\n)/g, '<br />');
	$.ajax({
		url : "/board/comment/" + $("#boardNo").val(),
		type : "POST",
		data : {
			usr_no : usr_no,
			parents_no : commentNo,
			first_seq : first_seq,
			sec_seq : sec_seq,
			content : content
		},
		dataType : "text"
	}).done(makeCommentList);
}