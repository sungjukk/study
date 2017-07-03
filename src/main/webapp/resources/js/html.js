/**
 * 
 */
var html = new Object();


html.createByList = function (elementId,json) {
	var regexp = /\{[^\}]+\}/gi;
	var dataList = $("[name="+elementId+"][data-type=LIST]"); 
	var dataForm = $("[name="+elementId+"][data-type=FORM]").html();
	var listElementEmpty = $("[name="+elementId+"][data-type=EMPTY]");
	dataList.html("");
	if(dataForm == null || dataForm == "" || dataForm.length < 1 ){
		return false;
	}
	
	var list = new Array();
	
	if(json != null){
		list = json;		
	}
	
	// 기본 목록일 경우
	if(json != null && json.length > 0  ){
		list = json;
	}
	
	var lists = [];
	lists = $("[name="+elementId+"] textarea");
	var listsCnt = lists.length;
	if(listsCnt == 0){lists = $("#container textarea");}
	
	var cnt= list.length;
	var htmlBuffer = new Array();
	var dataFormBuffer = "";
	for(var i=0;i<cnt;i++){
		var map = list[i];
		dataFormBuffer = dataForm;

		for(var key in map){
			var condReg = new RegExp("(<[A-Za-z]+ [^>]*)data-cond=[\"']?\\{"+key+"(==|!=)([^'\"> ]+)\\}[\"']?([^<>]*>[^<>]*(?:<[^<>]+>)*[^<>]*</[A-Za-z ]+>)");
			var condResult = '';
			
			while(condResult != null){				
				condResult = condReg.exec(dataFormBuffer);
	
				if(condResult != null && condResult.length == 5){					
					var condMark = condResult[2];
					var condValue = condResult[3] == 'null' || condResult[3] =='NULL' ? null : condResult[3];					
					if( (condMark == '==' && condValue != map[key]) || (condMark == '!=' && condValue == map[key]) ){
						dataFormBuffer = dataFormBuffer.replace(condResult[0],'');
					} else {
						dataFormBuffer = dataFormBuffer.replace(condResult[0], condResult[1] + condResult[4]);						
					}
				}
			}
			
			dataFormBuffer = dataFormBuffer.replace(/((?:name|id|class|value)\s*=\s*)"?'?({[^>]+})"?'?\s*(([A-Za-z]+\s*=\s*)|>)/gi,'$1"$2"$3');
			var replaceStr = eval("/{"+key+"}/gi");
			
			if (map[key] == null) {
				tmpStr = "";
			} else {
				tmpStr = map[key];
			}
			
			if(listsCnt > 0){				
				for(var j=0; j<listsCnt; j++){
					if(lists[j].name != 'CONTS'){
						if(key == lists[j].name){						
							tmpStr = tmpStr.split("<br/>").join("\n");
						}
					}
				}
			}
			dataFormBuffer = dataFormBuffer.replace(replaceStr, tmpStr); 
		}
		var isKeep = true;
		// {NAME}의 문자열을 모두 공백으로 변경 한다.
		if(isKeep != true){
			dataFormBuffer = dataFormBuffer.replace(/((?:name|id|class|value)\s*=\s*)"?'?({[^>]+})"?'?\s*(([A-Za-z]+\s*=\s*)|>)/gi,'$1""$3');
			dataFormBuffer = dataFormBuffer.replace(regexp, "");
			dataFormBuffer = dataFormBuffer.replace(/([a-zA-Z]+\s*=\s*)["']?([a-zA-Z]+\s*=\s*)["']?/gi,'$1""$2');
		}
		htmlBuffer.push(dataFormBuffer);
	}
	
	if(htmlBuffer.length > 0){
		dataList.append(htmlBuffer.join(""));
		dataList.css("display","");
		listElementEmpty.hide();
	}else{
		dataList.hide();
		// EMPTY가 없을 경우 FORM정보를 가지고 EMPTY를 구현 한다.
		if(listElementEmpty.length > 0){
			listElementEmpty.css("display","");
			 
		}else{
			var reg = /\{[^\}]+\}/gi;
			dataList.html(dataForm.replace(reg,"&nbsp;"));
		}
	}
	
	//ie7 테이블 문제로 인해 빈 td는 스페이스로 채워줌 
	$("td:empty").html("&nbsp;");

	return true;
}