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
' History : 2018-02-08 이종화 생성
'####################################################
%>
<%
dim currenttime
dim commentcount, i
Dim eCode , userid , pagereload , vDIdx

	currenttime =  now()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66277
	Else
		eCode   =  84429
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
/* 웹폰트는 테섭에서 적용되지 않음 실섭에서 확인*/
@font-face {font-family:'SDCinemaTheater';
src:url('http://www.10x10.co.kr/webfont/SDCinemaTheater.woff') format('woff'), url('http://www.10x10.co.kr/webfont/SDCinemaTheater.woff2') format('woff2'); font-style:normal; font-weight:normal;}

.evt76169 {background:#f4d5ba;}
.topic {position:relative; height:560px; background:#bc8450 url(http://webimage.10x10.co.kr/eventIMG/2018/84429/bg_top.jpg) no-repeat 50% 0;}
.topic h2 {position:relative; top:163px;}
.topic span {position:absolute; top:30px; left:50%; margin-left:-570px;}

.contestInfo {position:relative; height:890px; padding-top:100px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84429/bg_cont.jpg) repeat-x 50% 0;}
.contestInfo .slide {position:absolute; left:50%; bottom:100px; width:417px; height:460px; margin-left:80px;}
.contestInfo .slidesjs-pagination {position:absolute; left:50%; bottom:25px; z-index:20; width:52px; margin-left:-16px;}
.contestInfo .slidesjs-pagination li {float:left; width:10px; height:9px; margin:0 4px; border:solid 1px #b70000;}
.contestInfo .slidesjs-pagination li a {display:inline-block; width:100%; height:100%; text-indent:-999em;}
.contestInfo .slidesjs-pagination li a.active {background-color:#b70000;}

.cmt-evt {position:relative; height:1206px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84429/bg_cmt.jpg) repeat 50% 0;}
.writeCopy h3 {padding:103px 0 35px;}
.writeCopy .writeCont {position:relative; width:1031px; height:158px; margin:0 auto 24px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84429/bg_bar.png) no-repeat 0 0;}
.writeCopy .writeCont p {position:absolute; left:64px; top:63px;}
.writeCopy .writeCont p input {width:590px; height:34px; border:0; font-size:15px; color:#460000; font-weight:bold;}
.writeCopy .writeCont p input::placeholder{color:#460000;}
.writeCopy .writeCont .btnApply {position:absolute; right:30px; top:28px;}

.copyList ul {width:1140px; margin:70px auto 0;}
.copyList ul:after {content:' '; display:block; clear:both;}
.copyList li {position:relative; float:left; width:200px; height:210px; margin-right:35px; margin-bottom:35px; padding:27px 28px 25px; text-align:left; color:#fff; background-color:#f44e38;}
.copyList li.last-col{margin-right:0;}
.copyList li.even {background-color:#ec914f;}
.copyList li .btnDelete {position:absolute; right:0; top:0;}
.copyList li .num {display:inline-block; height:22px; color:#ffe87f; font-size:12px; font-weight:bold;}
.copyList li .copy {font-size:23px; padding-top:14px; font-family:'SDCinemaTheater'; word-break:break-all;}
.copyList li .writer {position:absolute; right:26px; bottom:25px; font-weight:bold;}
.copyList .pageMove {display:none;}
.copyList .paging {padding-top:5px; height:34px;}
.copyList .paging a{height:34px; background-color:transparent; border:0;}
.copyList .paging a span {height:100%; padding:0 14px 0 15px; line-height:34px; color:#f33f27; font-weight:bold;}
.copyList .paging a.current span{background-color:#f33f27; color:#fff; border-radius:4px;}
.copyList .paging a.arrow span {width:30px; height:100%; padding:0 4px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84429/paging_arrow.png);}
.copyList .paging a.prev span {background-position:0 3px;}
.copyList .paging a.next span {background-position:100% 3px;}
.copyList .paging a.first span,
.copyList .paging a.end span {display:none;}
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
	$(".copyList li:nth-child(even)").addClass("even");
	$(".copyList li:nth-child(4n)").addClass("last-col");
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
		<% if date() >="2018-02-08" and date() <= "2018-02-25" then %>
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
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
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
}

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
		chkword(obj, 4000);
	}
}
</script>

<div class="evt84429">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/tit_box_tape.png" alt="어디까지 써봤니? 박스테이프 카피" /></h2>
		<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/txt_date.png" alt="2018.02.12 ㅡ 02.25" /></span>
	</div>
	<div class="contestInfo">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/txt_conts.png" alt="일정 - 카피 응모 : 2018년 02월 12일 (월) – 02월 25일 (일) - 1차 발표 및 고객 투표 : 2018년 03월 05일 (월) – 03월 09일 (금) - 최종 발표 : 2018년 03월 14일 (수)( 실제 배송 박스에는 4월부터 부착됩니다.) - 택배 받는 순간을 즐겁게! 만들 수 있는 카피를 응모해주세요." usemap="#sandollMap" /></p>
		<map name="sandollMap" id="sandollMap">
			<area alt="산돌 시네마극장’ 설명 페이지로 이동"href="http://www.sandoll.co.kr/?viba_portfolio=cinema" target="_blank" shape="rect" coords="622,154,870,204" />
			<area alt="산돌 구름’ 설명 페이지 이동"href="http://www.sandoll.co.kr/sandollcloud/" target="_blank" shape="rect" coords="874,156,1075,203" />
		</map>
		<div class="slide">
			<img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/img_slide_1.jpg" alt="하늘 아래 같은 택배는 없다 [헐레벌떡][허겁지겁]=3 설렘(이)가 +1 상승했습니다 슬기로운 (소비)생활 쇼핑이 최강, 늘 새로워, 늘 짜릿해" />
			<img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/img_slide_2.jpg" alt="뭐해 자니 택배야 (feat.텐바이텐) 월급 받았는데 어떻게 안 사요ㅠㅠ 택배는 뜯어야 제맛 :9 뜯어서 잠금해제 > 택배 온 걸 엄마는 모르게 하라" />
		</div>
	</div>
	<div class="cmt-evt">
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
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/tit_copywriter.png" alt="오늘부터 나도 카피라이터!" /></h3>
			<div class="writeCont">
				<p><input type="text" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" placeholder="띄어쓰기 포함 18자 이내" onkeyup="chkword(this,36);"/></p>
				<button class="btnApply" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/btn_apply.png" alt="응모하기" /></button>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/84429/txt_caution.png" alt="욕설 및 비속어는 삭제되며 한 ID 당 5번까지 참여 가능합니다  ㅣ  카피 미리보기는 크롬 브라우저에서만 적용됩니다" /></p>
		</div>
		</form>

		<% If isArray(arrCList) Then %>
		<div class="copyList">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btnDelete"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76169/btn_delete.png" alt="삭제" /></a>
					<% End If %>
					<p class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
					<p class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%></p>
					<p class="copy"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
				</li>
				<% Next %>
			</ul>
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
			<div class="pageMove">
				<input type="text" style="width:24px;" /> /23페이지 <a href="" class="btn btnS2 btnGry2"><em class="whiteArr01 fn">이동</em></a>
			</div>
		</div>
		<% End If %>
	</div>
</div>
<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="com_egC" value="<%=com_egCode%>">
<input type="hidden" name="bidx" value="<%=bidx%>">
<input type="hidden" name="Cidx" value="">
<input type="hidden" name="mode" value="del">
<input type="hidden" name="pagereload" value="ON">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->