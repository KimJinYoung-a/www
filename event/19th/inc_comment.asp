<%

dim i, vClassFlag, vClassName

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
Dim liTypeNumber, characterNumber
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
iCPageSize = 6

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	
	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>

<script type="text/javascript">
$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#commentList").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( currentDate >= evtStartDate and currentDate <= evtEndDate ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
            if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 200){
                alert("코멘트를 남겨주세요.\n한글 100자 까지 작성 가능합니다.");
                frm.txtcomm.focus();
                return false;
            }
            frm.action = "/event/19th/comment_process.asp";
            frm.submit();
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}
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
</script>
<!-- 코멘트 작성 -->
<div class="comment-container">
    <form name="frmcom" id="frmCom" method="post" onSubmit="return false;" style="margin:0px;">
    <input type="hidden" name="eventid" value="<%=eCode%>">
    <input type="hidden" name="com_egC" value="<%=com_egCode%>">
    <input type="hidden" name="bidx" value="<%=bidx%>">
    <input type="hidden" name="iCC" value="<%=iCCurrpage%>">
    <input type="hidden" name="iCTot" value="">
    <input type="hidden" name="mode" value="add">
    <input type="hidden" name="isMC" value="<%=isMyComm%>">
    <input type="hidden" name="pagereload" value="ON">	
    <div class="txt-info">
        <img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_event_info.png" alt="comment event 19살이 된 텐바이텐의 생일을 축하해주세요. 정성껏 축하 메시지를 남겨주신 10분을 추첨하여 기프트카드 10,000원 권을 드립니다. 기간 : 10월 5일 ~ 10월 29일 당첨자 발표 : 11월 3일">
    </div>
    <div class="message-area">
        <div class="txt"><textarea name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" placeholder="축하 메시지를 남겨주세요:) (100자 이내로 입력)" maxlength="100"></textarea></div>
        <div class="btn"><button type="button" onclick="jsSubmitComment(document.frmcom); return false;">등록</button></div>
    </div>
    </form>
    <form name="frmdelcom" method="post" action = "/event/19th/comment_process.asp" style="margin:0px;">
        <input type="hidden" name="eventid" value="<%=eCode%>">
        <input type="hidden" name="com_egC" value="<%=com_egCode%>">
        <input type="hidden" name="bidx" value="<%=bidx%>">
        <input type="hidden" name="Cidx" value="">
        <input type="hidden" name="mode" value="del">
        <input type="hidden" name="pagereload" value="ON">
    </form>			    
    <div class="message-view">
		<% IF isArray(arrCList) THEN %>    
        <ul class="comment-list" id="commentList">
            <% 
                For intCLoop = 0 To UBound(arrCList,2) 

                    If intCLoop mod 2 = 0 Then
                        liTypeNumber = 2
                    Else
                        liTypeNumber = 1
                    End if

                    Randomize()
                    characterNumber = Int((Rnd * 20) + 1)

                    If len(characterNumber)=1 Then
                        characterNumber = "0"&characterNumber
                    End If
            %>		   
                    <% If liTypeNumber = 2 Then %>         
                        <li class="type-blue">
                            <div class="img-character">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_character_<%=characterNumber%>.png" alt="character <%=characterNumber%>">
                            </div>
                            <div class="contents-area">
                                <p class="id"><%=printUserId(arrCList(2,intCLoop),3,"*")%></p>
                                <div class="message-container">
                                        <p class="num">NO. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></p>
                                        <p class="message"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
                                        <p class="date"><%= FormatDate(arrCList(4,intCLoop),"0000-00-00 00:00") %></p>
						                <% If ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") Then %>
								            <button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btn-close">삭제</button>
						                <% End If %>	
                                </div>
                            </div>
                        </li>
                    <% End If %>
                    <% If liTypeNumber = 1 Then %>
                        <li class="type-yellow">
                            <div class="contents-area">
                                <p class="id"><%=printUserId(arrCList(2,intCLoop),3,"*")%></p>
                                <div class="message-container">
                                        <p class="num">NO. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></p>
                                        <p class="message"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
                                        <p class="date"><%= FormatDate(arrCList(4,intCLoop),"0000-00-00 00:00") %></p>
						                <% If ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") Then %>
								            <button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btn-close">삭제</button>
						                <% End If %>					                                        
                                </div>
                            </div>
                            <div class="img-character">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/index/w/img_character_<%=characterNumber%>.png" alt="character <%=characterNumber%>">
                            </div>
                        </li>
                    <% End If %>
                <% next %>                
        </ul>
        <div class="pageWrapV15">
            <%=fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage")%>
        </div>
        <% end if %>        
    </div>
</div>