<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
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
'####################################################
' Description : 2018 박스테이프 공모전 - 코멘트 이벤트
' History : 2018-06-25 최종원 생성
'####################################################
%>
<%
dim currenttime
dim commentcount, i
Dim eCode , userid , pagereload , vDIdx
Dim className

className = "rdBox"

	currenttime =  now()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  68523
	Else
		eCode   =  87452
	End If

	userid = GetEncLoginUserID()

If userid <> "" then
	commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
Else
	commentcount = 0
End If

vDIdx = request("didx")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
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
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
/* 웹폰트는 테섭에서 적용되지 않음, 실섭에서 확인*/
@font-face {font-family:'10X10';
src:url('http://www.10x10.co.kr/webfont/10X10.woff') format('woff'), url('http://www.10x10.co.kr/webfont/10X10.woff2') format('woff2'); font-style:normal; font-weight:normal;}

.topic {position:relative; height:536px; background:#bc8450 url(http://webimage.10x10.co.kr/eventIMG/2018/87452/bg_top.jpg) no-repeat 50% 0;}
.topic h2 {position:relative; top:112px;}
.topic span {position:absolute; top:30px; left:50%; margin-left:-570px;}
.contestInfo {position:relative; height:865px; padding-top:100px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/87452/bg_cont.jpg) repeat-x 50% 0;}
.contestInfo .slide {position:absolute; left:50%; bottom:100px; width:469px; height:460px; margin-left:80px;}
.contestInfo .slidesjs-pagination {position:absolute; left:50%; bottom:25px; z-index:20; width:100%; height:11px; margin-left:-50%; text-align:center;}
.contestInfo .slidesjs-pagination li {display:inline-block; width:10px; height:9px; margin:0 4px; border:solid 1px #b70000;}
.contestInfo .slidesjs-pagination li a {display:inline-block; width:100%; height:100%; text-indent:-999em;}
.contestInfo .slidesjs-pagination li a.active {background-color:#b70000;}
.cmt-evt {position:relative; height:1199px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84429/bg_cmt.jpg) repeat 50% 0;}
.writeCopy h3 {padding:103px 0 35px;}
.writeCopy .writeCont {position:relative; width:1031px; height:158px; margin:0 auto 24px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84429/bg_bar.png) no-repeat 0 0;}
.writeCopy .writeCont p {position:absolute; left:64px; top:63px;}
.writeCopy .writeCont p input {width:590px; height:34px; border:0; font-size:28px; color:#460000; font-weight:bold;}
.writeCopy .writeCont p input::placeholder{color:#460000; font-size:15px; vertical-align:middle;}
.writeCopy .writeCont .btnApply {position:absolute; right:30px; top:28px;}
.copyList ul {width:1140px; margin:70px auto 0;}
.copyList ul:after {content:' '; display:block; clear:both;}
.copyList li {position:relative; float:left; width:470px; margin-bottom:30px; padding:27px 40px 32px; line-height:1; text-align:left; color:#fff;}
.copyList li.last-col{margin-right:0;}
.copyList li.even { margin-right:40px;}
.copyList li.rdbox {background-color:#f44e38;}
.copyList li.ywBox {background-color:#ec914f;}
.copyList li .btnDelete {position:absolute; right:0; top:0;}
.copyList li .num {display:inline-block; height:22px; color:#ffe87f; font-size:12px;}
.copyList li .copy {margin-top:5px; font-size:23px; line-height:1; font-family:'10X10';}
.copyList li .writer {position:absolute; right:37px; top:28px; color:#ffe2cd;}
.copyList .pageMove {display:none;}
.copyList .paging {padding-top:40px; height:34px;}
.copyList .paging a{height:34px; background-color:transparent; border:0;}
.copyList .paging a span {height:100%; padding:0 14px 0 12px; color:#f33f27; font:bold 14px/34px dotum, '돋움', sans-serif; text-align:center;}
.copyList .paging a.current span{background-color:#f33f27; color:#fff; border-radius:4px;}
.copyList .paging a.arrow span {width:30px; height:100%; padding:0; margin:0 28px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84429/paging_arrow.png);}
.copyList .paging a.prev span {background-position:0 3px;}
.copyList .paging a.next span {background-position:100% 3px;}
.copyList .paging a.first,
.copyList .paging a.end {display:none;}
.noti {position:relative; padding:90px 0; background-color:#eec8ac; text-align:left;}
.noti h3 {position:absolute; top:50%; left:50%; margin-left:-434px; margin-top:-11px;}
.noti ul {width:815px; margin:0 auto; padding-left:325px;}
.noti ul li {padding-top:12px; line-height:1; font-size:12px; color:#3b1a02;}
.noti ul li:first-child {padding-top:0;}
</style>
<script type="text/javascript">
$(function(){
	$('.contestInfo .slide').slidesjs({
		width:417,
		height:460,
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
	$(".copyList li:nth-child(2n-1)").addClass("even");
	$(".copyList li:nth-child(1)").addClass("even");
});

$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".copyList").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2018-06-27" and date() <= "2018-07-03" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if(!frm.txtcomm.value){
					alert("택배 받는 순간을 즐겁게 해줄 카피를 적어주세요!");
					document.frmcom.txtcomm.value="";
					frm.txtcomm.focus();
					return false;
				}

				if (GetByteLength(frm.txtcomm.value) > 36){
					alert("제한길이를 초과하였습니다. 18자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return false;
				}

				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	}
}
</script>

<div class="evt87452">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/tit_box_tape.png" alt="텐바이텐 박스테이프 카피 공모전" /></h2>
		<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/txt_date.png" alt="2018.06.27 ㅡ 07.03" /></span>
	</div>
	<div class="contestInfo">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/txt_conts.png" alt="택배 받는 순간을 시~원하게! 해줄 수 있는 카피를 응모해주세요" usemap="#fontMap" /></p>
		<map name="fontMap" id="fontMap">
			<area alt="텐바이텐 폰트 TTF 윈도우용 다운로드"href="javascript:fileDownload(1795);" onfocus="this.blur();"shape="rect" coords="622,154,870,204" />
			<area alt="텐바이텐 폰트 OTF 맥용 다운로드"href="javascript:fileDownload(1796);" onfocus="this.blur();"shape="rect" coords="874,156,1075,203" />
		</map>
		<div class="slide">
			<img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/img_slide_1.jpg" alt="" />
			<img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/img_slide_2.jpg" alt="" />
			<img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/img_slide_3.jpg" alt="" />
		</div>
	</div>

	<div class="cmt-evt">
		<!-- 이벤트 응모 -->
		<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="com_egC" value="<%=com_egCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
		<input type="hidden" name="iCTot" value="">
		<input type="hidden" name="mode" value="add">
		<input type="hidden" name="spoint">
		<input type="hidden" name="isMC" value="<%=isMyComm%>">
		<input type="hidden" name="pagereload" value="ON">
		<input type="hidden" name="gubunval">
		<div class="writeCopy">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/tit_copywriter.png" alt="택배 받는 순간을 시~원하게 해줄 카피를 적어주세요!" /></h3>
			<div class="writeCont">
				<p><input type="text" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" placeholder="띄어쓰기 포함 최대 18자 입니다." maxlength="18" /></p>
				<button class="btnApply" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/btn_apply.png" alt="응모하기" /></button>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/txt_caution.png" alt="욕설 및 비속어는 삭제되며 한 ID 당 5번까지 참여 가능합니다 카피 미리보기는 크롬 브라우저에서만 적용됩니다" /></p>
		</div>
		</form>	
		<!--// 이벤트 응모 -->

		<!-- 응모 리스트 -->
		<% If isArray(arrCList) Then %>
		<div class="copyList">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>				
				<%
				if intCLoop MOD 8 = 0 or intCLoop MOD 8 = 3 or intCLoop MOD 8 = 4 or intCLoop MOD 8 = 7 then 				
					className="rdbox" 
				else
					className="ywBox"		
				end if 
				%>
				<li class="<%=className%>"> <!-- for dev msg : 처음과 마지막 li만 rdbox 클래스 이고 두번째부터는 두개씩 ywBox / rdBox 차례로 클래스 붙여주세요-->
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btnDelete"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/btn_delete.png" alt="삭제" /></a>
					<% End If %>
					<p class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></p>
					<p class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%></p>
					<p class="copy"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>					
				</li>
				<% Next %>
			</ul>
			<!-- pagination -->
			<div class="pageWrapV15">				
				<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>				
			</div>
		</div>
		<% End If %>
		<!--// 응모 리스트 -->
		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/87452/tit_noti.png" alt="이벤트유의사항" /></h3>
			<ul>
				<li>- 박스테이프 카피 등록은 한 ID 당 5번 참여 가능합니다.</li>
				<li>- 욕설 및 비속어는 자동으로 삭제됩니다.</li>
				<li>- 모든 응모작의 저작권을 포함한 일체 권리는 ㈜텐바이텐에 귀속됩니다.</li>
				<li>- 박스테이프 제작 시 일부분 수정될 가능성이 있습니다.</li>
				<li>- 최종 발표는 07월 06일 금요일 텐바이텐 공지사항에 기재되며, 새로운 박스테이프는 7월 말부터 만나볼 수 있습니다.</li>
				<li>- 당첨자에게는 세무신고에 필요한 개인정보를 요청할 수 있으며, 제세공과금은 텐바이텐 부담입니다.</li>
				<li>- 비슷한 응모작이 있을 경우, 최초 응모작이 인정됩니다.</li>
			</ul>
		</div>
	</div>
</div>	
<!--// 박스테이프 카피공모전 -->
<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="com_egC" value="<%=com_egCode%>">
<input type="hidden" name="bidx" value="<%=bidx%>">
<input type="hidden" name="Cidx" value="">
<input type="hidden" name="mode" value="del">
<input type="hidden" name="pagereload" value="ON">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->