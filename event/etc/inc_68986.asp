<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : [컬쳐콘서트#10] 카피 한잔
' History : 2016-02-12 유태욱 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim currenttime
	currenttime =  now()
'																		currenttime = #02/15/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66026
Else
	eCode   =  68986
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, ecc
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(request("ecc"),10)

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
if blnFull then
	iCPageSize = 6
else
	iCPageSize = 6
end if

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
<style type="text/css">
img {vertical-align:top;}
.copy1CupWrap {background-color:#fff;}
.copy1CupWrap .copyClassHead {height:1149px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68986/bg_copy_head.jpg) 50% 0 repeat-x;}
.copy1CupWrap .copyCont {position:relative; width:1140px; margin:0 auto; padding-top:115px;}
.copy1CupWrap .copyCont p {margin-top:635px;}
.copyCont li {position:absolute;}
.copyCont li.copyObj1 {left:380px; top:474px;}
.copyCont li.copyObj2 {left:795px; top:608px;}
.copyCont li.copyObj3 {left:9px; top:252px;}
.copyCont li.copyObj4 {left:-86px; top:665px;}
.copyCont li.copyObj5 {right:-78px; top:730px;}
.copyCont li.copyObj6 {right:-98px; top:340px;}
.copy1CupWrap .copyGuest {position:relative; height:369px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68986/bg_copy_guest.jpg) 50% 0 repeat-x;}
.copy1CupWrap .copyGuest p {position:absolute; left:50%; top:0; width:1900px; height:369px; margin-left:-950px;}
.copy1CupWrap .cmtInputWrap {height:448px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68986/bg_copy_cmt.jpg) 50% 0 repeat-x;}
.copy1CupWrap .cmtInput {width:1140px; margin:0 auto; padding-top:46px;}
.copy1CupWrap .cmtInput h3 {padding-bottom:33px;}
.copy1CupWrap .inputArea {position:relative; width:955px; margin:30px auto; text-align:left;}
.copy1CupWrap .inputArea p {display:table; width:85%; padding:8px 0; vertical-align:middle;}
.copy1CupWrap .inputArea span {display:table-cell; vertical-align:middle;}
.copy1CupWrap .inputArea .copyBtn {position:absolute; right:0; top:10px;}
.copy1CupWrap .inputArea input[type=text] {padding:18px 25px; font-size:11px; line-height:1.2; color:#6d6d6d; font-family:dotum, dotumche, '돋움', tahoma, sans-serif; border:1px solid #703f38;}
.copy1CupWrap .inputArea textarea {padding:18px 25px; font-size:11px; line-height:1.2; color:#6d6d6d; font-family:dotum, dotumche, '돋움', tahoma, sans-serif; border:1px solid #703f38;}
.copy1CupWrap .cmtListWrap {width:1140px; margin:0 auto; padding-top:40px;}
.copy1CupWrap .cmtListWrap ul {overflow:hidden; width:960px; margin:0 auto;}
.copy1CupWrap .cmtListWrap ul li {float:left; position:relative; width:210px; height:236px; padding:20px 30px; margin:15px 25px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68986/box_copy_cmt.png) 50% 0 no-repeat;}
.copy1CupWrap .cmtListWrap ul li .num {display:block; font-size:11px; color:#d69c8c; font-weight:bold; text-align:left;}
.copy1CupWrap .cmtListWrap ul li strong.copy {display:block; padding:15px; font-size:16px; color:#b5634d; text-align:center;}
.copy1CupWrap .cmtListWrap ul li .writer {display:block; padding-top:25px; font-size:11px; color:#b5644e; font-weight:bold;}
.copy1CupWrap .cmtListWrap ul li .cmtDel {overflow:hidden; position:absolute; right:18px; top:18px; width:19px; height:19px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68986/btn_copy_cmt_del.png) 0 0 no-repeat; text-indent:-999em;}
/* tiny scrollbar */
.copy1CupWrap .scrollbarwrap {width:205px; margin:0 auto;}
.copy1CupWrap .scrollbarwrap .viewport {overflow:hidden; position:relative; width:190px; height:90px;}
.copy1CupWrap .scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%; color:#d28e7c; font-size:11px; line-height:1.7; text-align:left;}
.copy1CupWrap .scrollbarwrap .overview .copyView {padding:0 10px 0 15px;}
.copy1CupWrap .scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#f4dad3;}
.copy1CupWrap .scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#f4dad3;}
.copy1CupWrap .scrollbarwrap .thumb {overflow:hidden; position:absolute; top:0; left:0; width:3px; height:24px; background-color:#ba4a2b; cursor:pointer;}
.copy1CupWrap .scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.copy1CupWrap .scrollbarwrap .disable {display:none;}
.copy1CupWrap .pageMove {display:none;}
.copyLyr {display:none; position:fixed; top:50% !important; left:50% !important; width:514px; height:588px; margin:-294px 0 0 -257px;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(function(){
	$('.scrollbarwrap').tinyscrollbar();
});

<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},100);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-02-15" and left(currenttime,10)<"2016-02-22" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>
				alert("한 ID당 한번만 참여할 수 있습니다.");
				return false;
			<% else %>

				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 30 || frm.txtcomm1.value == '15자 이내로 적어주세요.'){
					alert("띄어쓰기 포함\n최대 한글 15자 이내로 적어주세요.");
					frm.txtcomm1.focus();
					return false;
				}

				if (frm.txtcomm2.value == '' || GetByteLength(frm.txtcomm2.value) > 300 || frm.txtcomm2.value == '150자 이내로 적어주세요.'){
					alert("띄어쓰기 포함\n최대 한글 150자 이내로 적어주세요.");
					frm.txtcomm2.focus();
					return false;
				}

				frm.txtcommURL.value = frm.txtcomm1.value
				frm.txtcomm.value = frm.txtcomm2.value
				frm.action = "/event/lib/comment_process.asp";
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

function jsCheckLimit(textgb) {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
	if (textgb =='text1'){
		if (frmcom.txtcomm1.value == '15자 이내로 적어주세요.'){
			frmcom.txtcomm1.value = '';
		}
	}else if(textgb =='text2'){
		if (frmcom.txtcomm2.value == '150자 이내로 적어주세요.'){
			frmcom.txtcomm2.value = '';
		}
	}else{
		alert('잠시 후 다시 시도해 주세요');
		return;
	}
}

</script>
	<div class="contF contW">
		<div class="copy1CupWrap">
			<div class="copyClassHead">
				<div class="copyCont">
					<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/tit_copy.png" alt="크리에이티브 콘서트 카피 한 잔에 여러분을 초대합니다." /></h2>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/txt_copy.png" alt="사물을 클릭해 도서 &lt;카피책&gt;을 미리 둘러보세요." /></p>
					<ul>
						<li class="copyObj1"><a href="#copyLyr1" onclick="viewPoupLayer('modal',$('#copyLyr1').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/img_copy1.png" alt="카피책" /></a></li>
						<li class="copyObj2"><a href="#copyLyr2" onclick="viewPoupLayer('modal',$('#copyLyr2').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/img_copy2.png" alt="가위" /></a></li>
						<li class="copyObj3"><a href="#copyLyr3" onclick="viewPoupLayer('modal',$('#copyLyr3').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/img_copy3.png" alt="계산기" /></a></li>
						<li class="copyObj4"><a href="#copyLyr4" onclick="viewPoupLayer('modal',$('#copyLyr4').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/img_copy4.png" alt="라디오" /></a></li>
						<li class="copyObj5"><a href="#copyLyr5" onclick="viewPoupLayer('modal',$('#copyLyr5').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/img_copy5.png" alt="연필과 지우개" /></a></li>
						<li class="copyObj6"><a href="#copyLyr6" onclick="viewPoupLayer('modal',$('#copyLyr6').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/img_copy6.png" alt="커피" /></a></li>
					</ul>
				</div>

				<div id="copyLyr1">
					<div class="copyLyr window"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/lyr_copy1.png" alt="도서 카피책" usemap="#lyr01" /></div>
					<map name="lyr01" id="lyr01">
						<area shape="rect" coords="424,65,475,116" href="" onclick="ClosePopLayer(); return false;" alt="레이어 닫기" />
						<area shape="rect" coords="103,424,394,461" href="/culturestation/culturestation_event.asp?evt_code=3271" alt="정철 &lt;카피책&gt; 증정 이벤트 바로가기" />
					</map>
				</div>
				<div id="copyLyr2">
					<div class="copyLyr window"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/lyr_copy2.png" alt="카피 작법1 - 싹둑 싹둑 자르십시오" usemap="#lyrClose" /></div>
				</div>
				<div id="copyLyr3">
					<div class="copyLyr window"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/lyr_copy3.png" alt="카피 작법2 - 더하고 빼고 곱하고 나누십시오" usemap="#lyrClose" /></div>
				</div>
				<div id="copyLyr4">
					<div class="copyLyr window"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/lyr_copy4.png" alt="카피 작법3 - 귀에 들리는 말을 채집하십시오" usemap="#lyrClose" /></div>
				</div>
				<div id="copyLyr5">
					<div class="copyLyr window"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/lyr_copy5.png" alt="카피 작법4 - 쓴다/지운다 두가지 일을 하십시오" usemap="#lyrClose" /></div>
				</div>
				<div id="copyLyr6">
					<div class="copyLyr window"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/lyr_copy6.png" alt="카피 작법5 - 정철이 들려 준 이야기" usemap="#lyrClose" /></div>
				</div>
				<map name="lyrClose" id="lyrClose">
					<area shape="rect" coords="424,65,475,116" href="" onclick="ClosePopLayer(); return false;" alt="레이어 닫기" />
				</map>

			</div>
			<div class="copyGuest">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/img_copy_guest.jpg" alt="함께 커피 마실 남자 정철 / 카피 한 잔에 초대된 남자 표시형" usemap="#copyMan" /></p>
				<map name="copyMan" id="copyMan">
					<area shape="rect" coords="736,289,981,343" href="/culturestation/culturestation_event.asp?evt_code=3271" alt="정철 &lt;카피책&gt; 증정 이벤트 바로가기" />
					<area shape="rect" coords="1230,271,1502,323" href="https://www.facebook.com/passionoil/?fref=ts" target="_blank" alt="열정에 기름붓기 페이지 보러가기" />
				</map>
			</div>

			<div class="copyCmtEvt">
				<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="com_egC" value="<%=com_egCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="iCTot" value="">
				<input type="hidden" name="mode" value="add">
				<input type="hidden" name="spoint" value="0">
				<input type="hidden" name="isMC" value="<%=isMyComm%>">
				<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
				<% Else %>
					<input type="hidden" name="hookcode" value="&ecc=1">
				<% End If %>
				<input type="hidden" name="txtcomm">
				<input type="hidden" name="txtcommURL">
				<div class="cmtInputWrap">
					<div class="cmtInput">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/subtit_copy_cmt.png" alt="Comment Event - 카피라이터 정철의 크리에이티브 콘서트 <카피 한 잔>에 여러분을 초대합니다." /></h3>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/txt_copy_cmt1.png" alt="나에게 가장 큰 울림을 줬던 카피를 기대평과 함께 댓글로 남겨주세요." /></p>
						<div class="inputArea">
							<fieldset>
								<p>
									<span style="width:175px;"><strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/txt_copy_cmt2.png" alt="나의 인생카피는?" /></strong></span>
									<span>
										<input type="text" name="txtcomm1" id="txtcomm1" style="width:540px" onClick="jsCheckLimit('text1');" onKeyUp="jsCheckLimit('text1');"  value="<%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>15자 이내로 적어주세요.<%END IF%>"/>
									</span>
								</p>
								<p>
									<span style="width:175px;"><strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/68986/txt_copy_cmt3.png" alt="<카피 한 잔> 기대평" /></strong></span>
									<span>
										<textarea rows="4" style="width:540px;" name="txtcomm2" id="txtcomm2" onClick="jsCheckLimit('text2');" onKeyUp="jsCheckLimit('text2');"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>150자 이내로 적어주세요.<%END IF%></textarea>
									</span>
								</p>
								<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2016/68986/btn_copy_cmt.png" onclick="jsSubmitComment(document.frmcom); return false;" alt="응모하기" class="copyBtn" />
							</fieldset>
						</div>
					</div>
				</div>
				</form>

				<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="com_egC" value="<%=com_egCode%>">
					<input type="hidden" name="bidx" value="<%=bidx%>">
					<input type="hidden" name="Cidx" value="">
					<input type="hidden" name="mode" value="del">
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
				</form>

				<% IF isArray(arrCList) THEN %>
					<div class="cmtListWrap" id="commentlist">
						<ul>
						<% For intCLoop = 0 To UBound(arrCList,2) %>
							<li>
								<span class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
								<strong class="copy"><%=ReplaceBracket(db2html(arrCList(7,intCLoop)))%></strong>
								<div class="scrollbarwrap">
									<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
									<div class="viewport">
										<div class="overview">
											<p class="copyView"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
										</div>
									</div>
								</div>
								<span class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></span>
								<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"")then %>
									<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="cmtDel">삭제</a>
								<% end if %>
							</li>
						<% next %>
						</ul>
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				<% End if %>
			</div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->