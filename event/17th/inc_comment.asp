<%
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  89172
Else
	eCode   =  88938 
End If

dim currenttime
	currenttime =  date()

dim userid, commentcount, i, vClassFlag, vClassName
	userid = GetEncLoginUserID()
	commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
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
iCPageSize = 9

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
	var randomNumber = Math.floor(Math.random() * 3);	
	var obj = $("#frmCom input[name='spoint']");
	obj[randomNumber].checked = true;	
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#tenCmtList").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) >= "2018-09-20" and left(currenttime,10) <= "2018-10-31" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 and userid <> "cjw0515" then %>
				alert("코멘트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (!$("#frmCom input[name='spoint']:checked").val()){
					alert("코멘트 아이콘을 선택해주세요.");
					return false;
				}

				if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 800){
					alert("코멘트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return false;
				}
				frm.action = "/event/17th/comment_process.asp";
				frm.submit();
			<% end if %>
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
$(function(){
	$(".select-icon label").click(function(){
		$(".select-icon label").removeClass("current");
		$(this).addClass("current");
	});
});
</script>
<!-- 코멘트 작성 -->

<div class="cmt-wrap">
	<div class="cmt-write">
		<div class="inner">
			<form name="frmcom" id="frmCom" method="post" onSubmit="return false;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="com_egC" value="<%=com_egCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="isMC" value="<%=isMyComm%>">
			<input type="hidden" name="pagereload" value="ON">				
			<div class="info">
				<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/tit_cmt_evt.png" alt="" /></h3>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/89309/txt_cmt_evt.png" alt="" /></p>
			</div>
			<div class="select-icon">
				<div><input type="radio" name="spoint" value="1" id="select1" /><label for="select1">축하해요 선택</label></div>
				<div><input type="radio" name="spoint" value="2" id="select2" /><label for="select2">멋있어요 선택</label></div>
				<div><input type="radio" name="spoint" value="3" id="select3" /><label for="select3">고마워요 선택</label></div>
			</div>
			<div class="write-cont">
				<textarea cols="50" rows="5" name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%=chkiif(userid<>"","","placeholder=""로그인한 후 코멘트를 남길 수 있습니다""")%> ></textarea>
				<button type="button" onclick="jsSubmitComment(document.frmcom); return false;" class="btn-submit"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/btn_submit.png" alt="" /></button>
			</div>
			<p class="caution"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/txt_caution_v2.png" alt="" /></p>
			</form>
			<form name="frmdelcom" method="post" action = "/event/17th/comment_process.asp" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="com_egC" value="<%=com_egCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				<input type="hidden" name="pagereload" value="ON">
			</form>			
		</div>
	</div>
	<!-- 코멘트리스트 -->
	<div class="cmt-list" id="tenCmtList">
		<div class="inner">
		<% IF isArray(arrCList) THEN %>	
			<ul>	
				<% 
				For intCLoop = 0 To UBound(arrCList,2) 
					Select Case intCLoop + 1 
						case 1
							vClassName=" et1"
						case 6
							vClassName=" et2"
						case 8
							vClassName=" et3"
					end select
					vClassFlag = (intCLoop + 1 = 1 or intCLoop + 1 = 6 or intCLoop + 1 = 8)
				%>		
						<li class="cmt<%=arrCList(3,intCLoop)%> <%=chkiif(vClassFlag, vClassName,"")%>"> 
							<div class="info">
								<p class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></p>
								<p class="writer">
									<% If arrCList(8,intCLoop) <> "W" Then %><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_phone.png" alt="모바일에서 작성" /><% end if %>
									<%=printUserId(arrCList(2,intCLoop),2,"*")%>
								</p>
							</div>
							<div class="scrollbarwrap">
								<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
								<div class="viewport">
									<div class="overview">
										<p><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
									</div>
								</div>
							</div>
							<p class="date"><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></p>
							<div class="btn-group">
						<% If ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") Then %>									
								<button onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="delete">삭제</button>									
						<% End If %>					
							</div>
							<span class="dc-group">
								<span class="ico"></span>
								<% if vClassFlag then%>
								<span class="dc1"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_dc_1.png" alt=""></span>
								<span class="dc2"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_dc_2.png" alt=""></span>
								<% end if %>
							</span>
						</li>
				<% next %>											
			</ul>	
			<div class="pageWrapV15">
				<%=fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage")%>
			</div>					
		<% end if %>								
		</div>
	</div>
</div>
</div>
