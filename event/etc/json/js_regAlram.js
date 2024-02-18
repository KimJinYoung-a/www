function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    return results[2];
}
function regAlram() {
	var url = window.location.href;	
	var evtCode = getParameterByName("eventid", url);
	if(evtCode == ""){
		return false;
	}	
	var str = $.ajax({
		type: "post",
		url:"/event/etc/doeventsubscript/doEventAlramSubscript.asp",
		data: {
			eCode: evtCode
		},
		dataType: "text",
		async: false
	}).responseText;	
	
	if(!str){alert("시스템 오류입니다."); return false;}

	var reStr = str.split("|");

	if(reStr[0]=="OK"){		
		if(reStr[1] == "alram"){	//알람신청
			alert("PUSH 알림이 신청되었습니다.\n텐바이텐 앱에서 'PUSH 수신 동의'를 해주세요");
		}else{
			alert('오류가 발생했습니다.');
			return false;
		}
	}else{
		var errorMsg = reStr[1].replace(">?n", "\n");
		alert(errorMsg);
//			document.location.reload();
		return false;
	}		
}
