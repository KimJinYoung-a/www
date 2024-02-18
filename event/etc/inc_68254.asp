<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 박스테이프 공모전
' History : 2015-12-22 유태욱 생성
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
dim oItem
dim currenttime
	currenttime =  now()
	'currenttime = #10/07/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  65991
Else
	eCode   =  68254
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
	iCPageSize = 8		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 8		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
@font-face {font-family:'SDGdGulim'; 
src: url('http://www.10x10.co.kr/webfont/SDGdGulim.eot'); 
src: url('http://www.10x10.co.kr/webfont/SDGdGulim.eot?#iefix') format('embedded-opentype'), url('http://www.10x10.co.kr/webfont/SDGdGulim.woff') format('woff'), url('http://www.10x10.co.kr/webfont/SDGdGulim.ttf') format('truetype'); font-style:normal; font-weight:normal;}
img {vertical-align:top;}
.evt68254 {overflow:hidden; position:relative; padding-top:1350px; background-color:#fff;}
.evt68254 > span {display:block; position:absolute; top:0;}
.evt68254 > span.bgLt {right:50%; width:50%; height:1350px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68254/bg_lt.jpg) 100% 0 repeat-x; z-index:10;}
.evt68254 > span.bgRt {left:50%; width:50%; height:1350px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68254/bg_rt.jpg) 0 0 repeat-x; z-index:10;}
.evt68254 > span.deco {right:50%; width:440px; height:263px; margin-right:345px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_deco.png) 100% 0 no-repeat; z-index:20;}
.evt68254 .article {position:absolute; left:50%; top:0; width:1140px; height:1350px; margin-left:-570px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68254/bg.jpg) 50% 0 no-repeat; z-index:20;}
.evt68254 .evtDesp {float:left; padding:197px 0 0 33px;}
.evt68254 .evtDesp ul li {padding-top:55px; text-align:left;}
.evt68254 .evtJoin {float:right; padding-top:197px; width:555px; text-align:left;}
.evt68254 .evtJoin dfn {position:absolute; right:30px; top:50px;}
.evt68254 .evtAct dd {position:relative; padding:52px 0 0 0;}
.evt68254 .evtAct dd .tapeInput {display:block;}
.evt68254 .evtAct dd input[type=text] {margin:25px 5px 15px 0; padding:5px 0; background-color:transparent; border-bottom:2px solid #fff; color:#fff; font-size:20px; letter-spacing:-0.03em; font-family:'SDGdGulim', 'gulim', sans-serif;}
.evt68254 .evtAct dd input[type=text]::-webkit-input-placeholder {color:#fff; font-size:19px; font-family:'SDGdGulim', 'gulim', sans-serif;}
.evt68254 .evtAct dd input[type=text]:-moz-placeholder {color:#fff; font-size:19px; font-family:'SDGdGulim', 'gulim', sans-serif;}
.evt68254 .evtAct dd input[type=text]::-moz-placeholder {color:#fff; font-size:19px; font-family:'SDGdGulim', 'gulim', sans-serif;}
.evt68254 .evtAct dd input[type=text]:-ms-input-placeholder {color:#fff; font-size:19px; font-family:'SDGdGulim', 'gulim', sans-serif;}
.evt68254 .evtAct dd input[type=image] {margin-top:17px;}
.evt68254 .tapeAtclWrap {overflow:hidden; padding:45px 30px; width:1080px; margin:0 auto;}
.evt68254 .tapeAtclList {overflow:hidden; padding:10px 0;}
.evt68254 .tapeAtclList li {position:relative; float:left; width:240px; height:200px; padding:20px 15px;}
.evt68254 .tapeAtclList li .atclBox {position:relative; display:table; width:240px; height:200px; background-color:#ba1e24; color:#fff; text-align:center; vertical-align:middle;}
.evt68254 .tapeAtclList li .atclBox span {position:absolute; left:15px; top:15px; min-width:80px; height:22px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_cmt_num.png) no-repeat 0 50%; text-align:center; font-size:12px; line-height:23px; font-weight:bold; color:#ba1e24;}
.evt68254 .tapeAtclList li .atclBox p {position:absolute; right:15px; bottom:15px; text-decoration:underline; font-weight:bold;}
.evt68254 .tapeAtclList li .atclTxt {display:table-cell; text-align:center; width:154px; font-size:24px; line-height:1.4; vertical-align:middle; font-family:'SDGdGulim', sans-serif;}
.evt68254 .tapeAtclList li .btnDel {position:absolute; right:15px; top:4px;}
.evt68254 .boxSliderView {position:absolute; left:50%; top:915px; min-width:555px; margin-left:15px;}
.evt68254 .boxSliderView .slider-horizontal {margin-top:30px;}
.evt68254 .boxSliderView .www_FlowSlider_com-branding {display:none !important;}
.evt68254 .boxItem {width:228px; height:266px;}
</style>
<script>
<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},100);
//		window.$('html,body').animate({scrollTop:$(".commentlist").offset().top-100}, 10);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-12-23" and left(currenttime,10)<"2016-01-11" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("한 ID당 최대 5번까지 참여할 수 있습니다.");
				return false;
			<% else %>
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 36 || frm.txtcomm1.value == '띄어쓰기 포함 최대 18자 이내로 적어주세요'){
					alert("띄어쓰기 포함\n최대 한글 18자 이내로 적어주세요.");
					frm.txtcomm1.focus();
					return false;
				}
				frm.txtcomm.value = frm.txtcomm1.value
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

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}

	if (frmcom.txtcomm1.value == '띄어쓰기 포함 최대 18자 이내로 적어주세요'){
		frmcom.txtcomm1.value = '';
	}
}

</script>
	<div class="contF contW">
		<div class="evt68254">
			<div class="article">
				<div class="evtDesp">
					<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_tit.png" alt="널-리 박스테이프를 이롭게 하다" /></h2>
					<ul>
						<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_desp01.png" alt="01.일정" /></li>
						<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_desp02.png" alt="02.시상" /></li>
						<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_desp03.png" alt="03.규정" /></li>
						<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_desp04.png" alt="04.주제" /></li>
					</ul>
				</div>
				<div class="evtJoin">
					<dfn><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_tag.png" alt="텐바이텐X산돌" /></dfn>
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
					<dl class="evtAct">
						<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_sub01.png" alt="우리는 모두 박스테이프 크리에이터!" /></dt>
						<dd>
							<fieldset class="tapeInput">
								<input type="text" name="txtcomm1" id="txtcomm1" style="width:425px" class="tapeTxt" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();"  value="<%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>띄어쓰기 포함 최대 18자 이내로 적어주세요<%END IF%>"/>
								<input type="image" onclick="jsSubmitComment(document.frmcom); return false;" src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_sub01_btn.png" alt="응모" />
							</fieldset>
						</dd>
						<dd><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_txt.png" alt="욕설 및 비속어는 자동으로 삭제됩니다. / 한 ID당 최대 5번까지 참여할 수 있습니다." /></dd>
					</dl>
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
					<p style="margin-top:145px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_sub02.png" alt="텐바이텐의 좋은 친구 SandOll" usemap="#sdMap" /></p>
					<map name="sdMap" id="sdMap">
						<area shape="rect" coords="0,173,206,195" href="http://www.sandoll.co.kr/?viba_portfolio=gyeokdonggothic" target="_blank" alt="[산돌 격동굴림] 더 자세히 보기" />
						<area shape="rect" coords="252,173,452,195" href="http://www.sandoll.co.kr/sandollcloud/" target="_blank" alt="[산돌 구름] 만나러 가기" />
					</map>
					<div class="boxSliderView">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_sub03.png" alt="지금 텐바이텐 박스 테이프는?" /></p>
						<div id="boxSlider" class="slider-horizontal">
							<div class="boxItem"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_img1.png" alt="그래 내가 네 택배다" /></div>
							<div class="boxItem"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_img2.png" alt="친히 뜯어 살피소서" /></div>
							<div class="boxItem"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_img3.png" alt="일리있는 택배 느낌있는 텐바이텐" /></div>
							<div class="boxItem"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_img4.png" alt="뜯으면 비로소 보이는것" /></div>
							<div class="boxItem"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_img5.png" alt="열박스 뜯어 안 기쁜 택배 없다" /></div>
						</div>
					</div>
				</div>
			</div>

			<% IF isArray(arrCList) THEN %>
				<div class="tapeAtclWrap" id="commentlist">
					<ul class="tapeAtclList">
					<% For intCLoop = 0 To UBound(arrCList,2) %>
						<li>
							<div class="atclBox">
								<span>NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
								<div class="atclTxt"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></div>
								<p><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
							</div>
							<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
								<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btnDel"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68254/boxtape_cmt_del.gif" alt="삭제" /></a>
							<% end if %>
						</li>
					<% next %>
					</ul>
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			<% End if %>
			<span class="deco"></span><span class="bgLt"></span><span class="bgRt"></span>
		</div>

	</div>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function(){
	$('.tapeAtclList li:odd .atclBox').css('background-color', '#b48763');
	$('.tapeAtclList li:odd .atclBox span').css('color', '#9a6e4b');

	var evtSlideW = $('.evt68254').width()/2;
	$('.boxSliderView').css('min-width', evtSlideW+'px');
	$("#boxSlider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		position:0.0,
		startPosition:0.0
	});

	$(window).resize(function () {
		var evtSlideW = $('.evt68254').width()/2;
		$('.boxSliderView').css('min-width', evtSlideW+'px');
		FlowSlider("#boxSlider");
	});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->