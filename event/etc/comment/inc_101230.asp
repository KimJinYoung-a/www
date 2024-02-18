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
' Description : 박스테이프 공모전 - 코멘트 이벤트
' History : 2020-03-10 이종화
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
		eCode   =  100916
	Else
		eCode   =  101230
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
@font-face {font-family:'10x10'; src:url('//fiximage.10x10.co.kr/webfont/10x10.woff') format('woff'), url('//fiximage.10x10.co.kr/webfont/10x10.woff2') format('woff2'); font-style:normal; font-weight:normal;}
.box-tape .topic {position:relative; height:536px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/101230/bg_top.jpg); background-position:50% 0;}
.box-tape .topic h2 {padding-top:125px;}
.box-tape .topic .date {position:absolute; top:32px; left:50%; z-index:10; margin-left:-454px;}
.box-tape .contest {position:relative; padding:110px 0; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/101230/bg_cont.jpg); background-position:50% 0;} 
.box-tape .contest .btn-font {position:absolute; top:265px; left:50%; width:208px; height:40px; margin-left:60px; color:transparent;}
.box-tape .contest .down-otf {margin-left:320px;}
.box-tape .contest .slide1 {position:absolute; top:425px; left:50%; width:459px; height:395px; margin-left:60px;}
.box-tape .contest .slide1 .slick-dots {position:absolute; bottom:29px; left:0; width:100%;}
.box-tape .contest .slide1 .slick-dots li {width:5px; height:5px; background-color:transparent; border:solid 2px #bf1b17; border-radius:50%; margin:0 5px;}
.box-tape .contest .slide1 .slick-dots .slick-active {background-color:#bf1b17;}
.box-tape .cmt-section {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/101230/bg_cmt.jpg); background-position:50% 0;}
.box-tape .cmt-section h3 {padding:95px 0 35px;}
.box-tape .cmt-section .input-wrap {position:relative; width:1031px; height:158px; margin:0 auto 23px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/101230/bg_input.png); background-position:0 50%;}
.box-tape .cmt-section .input-wrap input {position:absolute; top:28px; left:30px; width:970px; height:102px; padding-left:35px; padding-right:272px; font-size:20px; box-sizing:border-box;}
.box-tape .cmt-section .input-wrap input::placeholder{color:#b6b6b6;}
.box-tape .cmt-section .input-wrap .btn-submit {position:absolute; top:28px; right:30px;}
.box-tape .cmt-section .cmt-list {margin:40px 0 70px;}
.box-tape .cmt-section .cmt-list ul {display:flex; width:1140px; margin:0 auto; justify-content:space-between; flex-wrap:wrap;}
.box-tape .cmt-section .cmt-list li {position:relative; width:550px; height:109px; margin-top:30px; padding:28px 30px; background-color:#d66500; box-sizing:border-box;}
.box-tape .cmt-section .cmt-list li:nth-child(4n-1),.box-tape .cmt-section .cmt-list li:nth-child(4n-2) {background-color:#e19262;}
.box-tape .cmt-section .cmt-list li .info {display:flex; justify-content:space-between; font-size:13px; color:#ffe87f; line-height:1;}
.box-tape .cmt-section .cmt-list li .info .writer {color:#ffe2cd;}
.box-tape .cmt-section .cmt-list li .copy {margin-top:13px; color:#fff; font-size:23px; line-height:31px; font-family:'10X10'; text-align:left;}
.box-tape .cmt-section .cmt-list li .btn-delete {position:absolute; top:0; right:0; width:37px; height:16px; background-image:url(//webimage.10x10.co.kr/eventIMG/2017/76169/btn_delete.png)}
.box-tape .cmt-section .pageMove {display:none;}
.box-tape .cmt-section .paging {height:34px; padding-bottom:84px;}
.box-tape .cmt-section .paging a{height:34px; background-color:transparent; border:0;}
.box-tape .cmt-section .paging a span {height:100%; padding:0 14px 0 12px; color:#f33f27; font:bold 14px/34px dotum, '돋움', sans-serif; text-align:center;}
.box-tape .cmt-section .paging a.current span{background-color:#f33f27; color:#fff; border-radius:50%;}
.box-tape .cmt-section .paging a.arrow span {width:30px; height:100%; padding:0; margin:0 28px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84429/paging_arrow.png);}
.box-tape .cmt-section .paging a.prev span {background-position:0 3px;}
.box-tape .cmt-section .paging a.next span {background-position:100% 3px;}
.box-tape .cmt-section .paging a.first,
.box-tape .cmt-section .paging a.end {display:none;}
.box-tape .noti {background-color:#eec8ac;}
</style>
<script type="text/javascript">
$(function(){
	$('.slide1').slick({
		autoplay: true,
		infinite:true,
		dots: true,
		speed: 1200,
		fade: true
	});

	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".cmt-section").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2020-03-13" and date() <= "2020-03-29" then %>
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

<div class="evt101230 box-tape">
	<div class="topic">
		<h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/tit_boxtape.png" alt="텐바이텐 박스테이프 카피 공모전"></h2>
		<p class="date"><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/txt_date.png" alt="20.03.16 ㅡ 20.03.29z"></p>
	</div>
	<div class="contest">
		<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/txt_conts.png?v=1.01" alt="택배 받는 순간을 재미있게!” 해줄 수 있는 카피를 응모해주세요."></div>
		<a href="javascript:fileDownload(1795);" class="btn-font down-ttf" onfocus="this.blur();">TTF 윈도우용 다운로드</a>
		<a href="javascript:fileDownload(1796);" class="btn-font down-otf" onfocus="this.blur();">OTF 맥용 다운로드</a>
		<div class="slide1">
			<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/img_slide1.jpg" alt=""></div>
			<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/img_slide2.jpg" alt=""></div>
			<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/img_slide3.jpg" alt=""></div>
			<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/img_slide4.jpg" alt=""></div>
		</div>
	</div>
	<div class="cmt-section">
		<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/tit_cmt.png" alt="택배 받는 순간을 재미있게 해줄 카피를 응모해주세요!"></h3>
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
		<div class="input-wrap">
			<input type="text" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" placeholder="띄어쓰기 포함 최대 18자 이내로 적어주세요" maxlength="18">
			<button class="btn-submit" onclick="jsSubmitComment(document.frmcom);return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/btn_submit.png" alt="응모하기"></button>
		</div>
		</form>	
		<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/txt_noti1.png" alt="욕설 및 비속어는 삭제되며 한 ID 당 5번까지 참여 가능합니다,카피 미리보기는 브라우저 환경에 따라 보이지 않을 수 있습니다."></p>

		<% If isArray(arrCList) Then %>
		<div class="cmt-list">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>				
				<li>
					<div class="info">
						<span class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
						<span class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%></span>
					</div>
					<div class="copy"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></div>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<button class="btn-delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');"></button>
					<% End If %>
				</li>
				<% Next %>
			</ul>
		</div>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
		<% End If %>
	</div>
	<div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2020/101230/txt_noti2.png" alt="이벤트 유의사항"></div>
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