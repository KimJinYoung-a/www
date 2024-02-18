<%
    Dim cEvent
    Dim evtCommentCopy , evtStartDate , evtEndDate , WinnerAnnouncementDate , giftImage
    Dim userID : userID = GetEncLoginUserID()
    
    '// event info
    SET cEvent = new ClsEvtCont
        cEvent.FECode = oMedia.FOneItem.Fcommenteventid
        cEvent.fnGetEvent
        
        evtCommentCopy          = cEvent.Fcomm_text
        evtStartDate            = cEvent.Fcomm_start
        evtEndDate              = cEvent.Fcomm_end
        WinnerAnnouncementDate  = cEvent.FEPDate
        giftImage               = cEvent.Ffreebie_img
    SET cEvent = nothing
%>
<%'!-- 댓글 이벤트 --%>
<%'!-- for dev msg : 사진 있을 경우 클래스 photo --%>
<div class="reply-evt <%=chkiif(giftImage <> "","photo","")%>">
    <% IF evtStartDate <> "" and evtEndDate <> "" THEN %>
    <h4>댓글 이벤트</h4>
    <p class="topic"><%=db2html(evtCommentCopy)%></p>
        <% IF cdate(date()) > cdate(left(evtEndDate,10)) THEN %>
        <div class="fin-evt">
            <p>이벤트가 종료되었습니다</p>
        </div>
        <% END IF %>
        <ul>
            <li>이벤트 기간 <span class="date"><%=formatdate(evtStartDate,"0000.00.00")%> - <%=formatdate(evtEndDate,"00.00")%></span></li>
            <% if instr(WinnerAnnouncementDate,"1900") < 1 then %><li>당첨자 발표 <span class="date"><%=formatdate(WinnerAnnouncementDate,"0000.00.00")%></span></li><% end if %>
        </ul>
        <%'!-- for dev msg : 사은품 사진 있을 경우 --%>
        <% if giftImage <> "" then %>
        <div class="thumbnail"><img src="<%=giftImage%>" alt=""></div>
        <% end if %>
    <% END IF %>
    <%'!-- 댓글 입력 --%>
    <div class="write">
        <form name="frm" id="frm" onSubmit="return false;">
        <input type="hidden" name="eventid" value="<%=oMedia.FOneItem.Fcommenteventid%>">
        <input type="hidden" name="cidx" />
		<input type="hidden" name="mode" value="add">
            <textarea id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" cols="30" rows="3" placeholder="댓글을 입력해주세요" onkeyup="chkword(this,600);"></textarea>
            <button class="btn-submit" onclick="fnComment();">등록</button>
        </form>
    </div>
    <%'!--// 댓글 입력 --%>
</div>

<%'!-- 댓글 리스트 --%>
<div id="replyList" class="reply-list"></div>
<script>
$(function() {
    jsGoComPage(1);
})

// list
function jsGoComPage(iP) {
    var str = $.ajax({
		type: "POST",
		url: "ajaxCommentList.asp",
		data: "eventid=<%=oMedia.FOneItem.Fcommenteventid%>&iCC="+ iP,
		dataType: "text",
		async: false
	}).responseText;
	if(str!="") {
		$("#replyList").empty().html(str);
	}
}

// comment action
function fnCommentAction(cidx,mode) {
    if (mode == 'del') {
        var _data = "eventid=<%=oMedia.FOneItem.Fcommenteventid%>&mode="+ mode +"&Cidx="+ cidx
    } else {
        var _data = $("#frm").serialize()
    }

    var str = $.ajax({
		type: "POST",
		url: "ajaxCommentProc.asp",
		data: _data,
		dataType: "text",
		async: false
    }).responseText;
    
    if(!str){alert("시스템 오류입니다."); return false;}

    var reStr = str.split("||");
    var reMessage = reStr[1].replace(">?n", "\n");

    if(reStr[0]=="OK"){
        alert(reMessage);
        jsGoComPage(1);
        var frm = document.frm;
            frm.mode.value = 'add';
            frm.cidx.value = '';
            frm.txtcomm.value = '';
    }else{
        alert(reMessage);
        return false;
    }	
}

// delete
function fnDelComment(cidx)	{
    fnCommentAction(cidx,'del');
}

// update
function fnUdtComment(cidx,event) {
    var frm = document.frm;
        frm.txtcomm.value = $(event.currentTarget.parentElement).parent().find('p').text();
        frm.mode.value = 'edit';
        frm.cidx.value = cidx;
}

// add
function fnComment() {
    jsCheckLimit();
    fnCommentAction(0,'Action');
}

// logincheck
function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
}

// lencheck
function chkword(obj, maxByte) {
 	var strValue = obj.value;
	var strLen = strValue.length;
	var totalByte = 0;
	var len = 0;
	var oneChar = "";
	var str2 = "";

	for (var i = 0; i < strLen; i++) {
		oneChar = strValue.charAt(i);
		if (escape(oneChar).length > 4) {
			totalByte += 2;
		} else {
			totalByte++;
		}

		// 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
		if (totalByte <= maxByte) {
			len = i + 1;
		}
	}

	// 넘어가는 글자는 자른다.
	if (totalByte > maxByte) {
		alert("띄어쓰기 포함 "+ maxByte/2 + "자를 초과 입력 할 수 없습니다.");
		str2 = strValue.substr(0, len);
		obj.value = str2;
		chkword(obj, 600);
	}
}
</script>