<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 2017 박스테이프 공모전
' History : 2017-02-10 유태욱 생성
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
'	currenttime = #02/13/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66276
Else
	eCode   =  76169
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid="baboytw" or userid="ksy92630" or userid="bjh2546" THEN
	currenttime = #02/13/2017 09:00:00#
end if

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
.evt76169 {background:#fff;}
.topic {position:relative;}
.topic h2 {position:absolute; left:315px; top:175px;}
.topic h2 span {position:absolute;}
.topic h2 span.t1 {left:-22px; top:0;}
.topic h2 span.t2 {left:0; top:77px;}
.topic h2 span.t3 {left:22px; top:188px;}
.contestInfo {position:relative;}
.contestInfo .slide {position:absolute; right:61px; bottom:100px; width:448px; height:441px;}
.contestInfo .slide .slidesjs-navigation {position:absolute; top:181px; z-index:20; width:32px; height:62px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76169/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.contestInfo .slide .slidesjs-previous {left:0;}
.contestInfo .slide .slidesjs-next {right:0; background-position:100% 0;}
.contestInfo .slidesjs-pagination {position:absolute; left:50%; bottom:27px; z-index:20; width:52px; margin-left:-26px;}
.contestInfo .slidesjs-pagination li {float:left; width:11px; margin:0 7px;}
.contestInfo .slidesjs-pagination li a {display:inline-block; width:11px; height:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76169/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.contestInfo .slidesjs-pagination li a.active {background-position:100% 0;}
.writeCopy {height:350px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76169/bg_paper.png) no-repeat 0 0;}
.writeCopy h3 {padding:86px 0 30px;}
.writeCopy .writeCont {position:relative; width:912px; height:94px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76169/bg_bar.png) no-repeat 0 0;}
.writeCopy .writeCont p {position:absolute; left:45px; top:22px;}
.writeCopy .writeCont p input {width:590px; height:50px; border:0; font-size:14px; color:#000;}
.writeCopy .writeCont .btnApply {position:absolute; right:34px; top:18px;}
.copyList ul {width:1050px; margin:0 auto; padding:70px 0 23px;}
.copyList ul:after {content:' '; display:block; clear:both;}
.copyList li {position:relative; float:left; width:162px; height:131px; margin:0 20px 35px; padding:20px 30px 0; text-align:left; color:#fff; background:#cf2526 url(http://webimage.10x10.co.kr/eventIMG/2017/76169/bg_tape.png) no-repeat 100% 0;}
.copyList li.even {background-color:#ef8665;}
.copyList li .btnDelete {position:absolute; left:0; top:-16px;}
.copyList li .num {display:inline-block; height:22px; padding:0 12px; line-height:22px; color:#cf2526; background:#fff; border-radius:8px; font-weight:bold;}
.copyList li.even .num {color:#ef8665;}
.copyList li .copy {padding-top:14px;}
.copyList li .writer {position:absolute; right:30px; bottom:20px; line-height:12px; border-bottom:1px solid #fff; font-weight:bold;}
.copyList .pageMove {display:none;}
</style>
<script style="text/javascript">
$(function(){
	$('.contestInfo .slide').slidesjs({
		width:448,
		height:441,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3500, effect:'fade', auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.contestInfo .slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$(".copyList li:nth-child(even)").addClass("even");

	titleAnimation()
	$(".topic h2 span.t1").css("cssText", "opacity:0; margin:30px 0 0 -60px;");
	$(".topic h2 span.t2").css("cssText", "opacity:0; margin:-30px 0 0 60px;");
	$(".topic h2 span.t3").css("cssText", "opacity:0; margin:30px 0 0 -60px;");
	function titleAnimation() {
		$(".topic h2 span").delay(100).animate({"margin-top":"0", "margin-left":"0", "opacity":"1"},900);
	}
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
		<% If not( left(currenttime,10)>="2017-02-13" and left(currenttime,10)<"2017-02-25" ) Then %>
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
	<!-- 박스테이프 카피공모전 -->
	<div class="evt76169">
		<div class="topic">
			<h2>
				<span class="t1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/tit_copy_01.png" alt="다시 돌아온" /></span>
				<span class="t2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/tit_copy_02.png" alt="박스테이프" /></span>
				<span class="t3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/tit_copy_03.png" alt="카피공모전" /></span>
			</h2>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/img_box.png" alt="" /></div>
		</div>
		<div class="contestInfo">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/txt_info.png" alt="" usemap="#sandollMap" /></p>
			<map name="sandollMap" id="sandollMap">
				<area shape="rect" coords="665,311,860,345" href="http://www.sandollcloud.com/portfolio_page/gyeokdong-gothic" target="_blank" alt="[산돌 격동고딕] 더 자세히 보기" />
				<area shape="rect" coords="875,311,1041,345" href="http://www.sandollcloud.com/" target="_blank" alt="[산돌 구름] 만나러 가기" />
			</map>
			<div class="slide">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/img_slide_01.png" alt="" />
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/img_slide_02.png" alt="" />
			</div>
		</div>
		<!-- 이벤트 응모 -->
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
		<div class="writeCopy">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/tit_copywriter.png" alt="오늘부터 나도 카피라이터!" /></h3>
			<div class="writeCont">
				<p><input type="text" name="txtcomm1" id="txtcomm1" style="width:425px" class="tapeTxt" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();"  placeholder="<%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>띄어쓰기 포함 최대 18자 이내로 적어주세요<%END IF%>" value=""/></p>
				<button onclick="jsSubmitComment(document.frmcom); return false;" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/btn_apply.png" alt="응모하기" /></button>
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
		<!--// 이벤트 응모 -->

		<!-- 응모 리스트 -->
		<% IF isArray(arrCList) THEN %>
		<div class="copyList" id="commentlist">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
					<li>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
							<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btnDelete"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/btn_delete.png" alt="삭제" /></a>
						<% end if %>
						<p class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></p>
						<p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
						<p class="copy"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
					</li>
				<% next %>
			</ul>
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
		<% end if %>
		<!--// 응모 리스트 -->
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->