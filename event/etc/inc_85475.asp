<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 기분전화 텐바이텐
' 미키와 미니의 양말셋트
' History : 2017-12-12 정태훈 생성
'###########################################################
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
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/10/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67510
Else
	eCode   =  85475
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid = "baboytw" or userid = "chaem35" or userid = "answjd248" or userid = "corpse2" or userid = "jinyeonmi" or userid = "ajung611" or userid = "phsman1"or userid = "babukim89"or userid = "amarytak"or userid = "areum531" then
	currenttime = #04/02/2018 00:00:00#
end if

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
if blnFull then
	iCPageSize = 6		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 6		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
<style>
.renewal-tenten {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2018/85475/bg_top.png) 0 0 repeat-x;}
.renewal-tenten .inner {position:relative; width:1140px; margin:0 auto;}
.renewal-tenten .topic .inner {padding:142px 0 35px;}
.renewal-tenten .topic p {position:absolute; left:0; top:50px;}
.renewal-tenten .topic a {position:absolute; right:0; top:50px;}
.renewal-tenten .section1 .preview {position:relative; width:731px; height:456px; padding:59px 204px 114px 205px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2018/85475/bg_notebook.png) 0 0 no-repeat;}
.renewal-tenten .section1 .preview:after {content:''; display:inline-block; position:absolute; left:200px; top:54px; width:742px; height:467px; background:url(http://fiximage.10x10.co.kr/web2018/main/bg_transparent.png) 0 0 repeat;}
.renewal-tenten .section1 .preview #slider1 {overflow:hidden; width:732px; height:457px;}
.renewal-tenten .section1 .num {margin-top:-10px; padding-bottom:152px;}
.renewal-tenten .section2 {background:#fbfbfb;}
.renewal-tenten .section2 .inner {padding-top:72px;}
.renewal-tenten .section2 .preview {width:874px; height:696px; margin-left:-25px; padding:17px 0 0 25px; text-align:left;  background:url(http://webimage.10x10.co.kr/eventIMG/2018/85475/bg_box_1.png) 0 0 no-repeat;}
.renewal-tenten .section2 .num {position:absolute; right:0; top:291px;}
.renewal-tenten .section2 .side {position:absolute; left:-171px; top:-76px;}
.renewal-tenten .section3 .inner {height:1113px; text-align:left;}
.renewal-tenten .section3 .num {padding:146px 0 0 60px;}
.renewal-tenten .section3 .preview {position:absolute; z-index:30;}
.renewal-tenten .section3 .preview1 {left:383px; top:145px; width:791px; height:367px; padding:17px 0 0 25px; text-align:left;  background:url(http://webimage.10x10.co.kr/eventIMG/2018/85475/bg_box_2.png) 0 0 no-repeat;}
.renewal-tenten .section3 .preview2 {left:-25px; top:515px; width:967px; height:420px; padding:17px 59px 67px 25px; text-align:left;  background:url(http://webimage.10x10.co.kr/eventIMG/2018/85475/bg_box_3.png) 0 0 no-repeat;}
.renewal-tenten .section3 .preview2:after {content:''; display:inline-block; position:absolute; left:20px; top:12px; width:977px; height:430px; background:url(http://fiximage.10x10.co.kr/web2018/main/bg_transparent.png) 0 0 repeat;}
.renewal-tenten .section3 .preview2 #slider2 {position:relative; overflow:hidden; width:967px; height:420px;}
.renewal-tenten .section3 .preview2 .tit {position:absolute; left:212px; top:42px; z-index:20;}
.renewal-tenten .section3 .preview2 #slider2 li {float:left;}
.renewal-tenten .section3 .side {position:absolute; right:-136px; top:327px; z-index:20;}
.renewal-tenten .section4 {height:284px; text-align:left; background:#fc4546;}
.renewal-tenten .section4 p {padding:104px 0 0 137px;}
.renewal-tenten .section4 .preview {position:absolute; right:87px; top:-38px;}
.renewal-tenten .comment {padding:106px 0 94px; text-align:center; background:#e7e7e7;}
.renewal-tenten .comment .inner {width:1060px;}
.renewal-tenten .cmt-write {position:relative; height:120px; margin-top:60px; padding:20px 25px; text-align:left; background:#fff;}
.renewal-tenten .cmt-write textarea {width:750px; height:120px; padding:0; font-size:16px; vertical-align:top; font-family: 'Noto Sans KR'; border:0;}
.renewal-tenten .cmt-write .btn-cmt {position:absolute; right:48px; top:32px;}
.renewal-tenten .cmt-list ul {overflow:hidden; margin:0 -41px; padding-bottom:40px;}
.renewal-tenten .cmt-list li {position:relative; float:left; width:266px; height:226px; margin:44px 0 0 41px; padding:30px; text-align:left; background:#fff;}
.renewal-tenten .cmt-list li .btn-del {display:inline-block; position:absolute; right:0; top:0; height:24px; padding:0 10px; line-height:24px; background:#666; color:#fff; text-decoration:none;}
.renewal-tenten .cmt-list li span {display:inline-block; position:relative; padding-bottom:40px; color:#ff4a4b; font:bold 13px/14px gulim; letter-spacing:0.08em;}
.renewal-tenten .cmt-list li span:after {content:''; display:inline-block; position:absolute; left:0; top:30px; width:4px; height:4px; background:#fc4546; border-radius:50%;}
.renewal-tenten .cmt-list li p {color:#666; font:16px/1.6 'Noto Sans KR';}
.renewal-tenten .cmt-list li p.txt {overflow:auto; height:150px;}
.renewal-tenten .cmt-list li p.writer {position:absolute; right:20px; bottom:24px; font-size:13px; color:#333;}
.renewal-tenten .paging {height:34px;}
.renewal-tenten .paging a {height:34px; line-height:34px; border:0; margin:0 4px; background-color:transparent;}
.renewal-tenten .paging a span {width:34px; height:34px; vertical-align:middle; font-size:16px; color:#333; min-width:34px; padding:0;}
.renewal-tenten .paging a.arrow {background-color:transparent;}
.renewal-tenten .paging a.arrow span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/85475/btn_pagination.png);width:34px;}
.renewal-tenten .paging a.current {background-color:transparent; border:0; color:#fff; border-radius:50%;}
.renewal-tenten .paging a.current span {color:#fff; background-color:#333;}
.renewal-tenten .paging a.current:hover {background-color:#333;}
.renewal-tenten .paging a.prev span {background-position:0 0;}
.renewal-tenten .paging a.next span {background-position:100% 0;}
.renewal-tenten .paging a:hover {background-color:transparent;}
.renewal-tenten .pageMove,.renewal-tenten .paging a.first,.renewal-tenten .paging a.end {display:none;}
</style>
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script>
$(function(){
	$("#slider1").kxbdMarquee({
		direction:"up",
		isEqual:false,
		scrollDelay:20
	});
	$("#slider2").kxbdMarquee({
		loop:20,
		isEqual:false,
		scrollDelay:15
	});

	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	//document.getElementById('commentlist').scrollIntoView();
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) >= "2018-04-02" and left(currenttime,10) < "2018-04-05" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>
				alert("본 이벤트는 ID당 1회만 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 300){
					alert("코멘트를 남겨주세요.\n한글 150자 까지 작성 가능합니다.");
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
			top.location.href="/login/loginpage.asp?vType=G";
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
		}
		return false;
	}
}
</script>
						<!-- 기분전환 텐바이텐 -->
						<div class="evt85475 renewal-tenten">
							<div class="topic">
								<div class="inner">
									<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/tit_tenten.png" alt="기분전환 텐바이텐" /></h2>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/txt_renewal.png" alt="10x10 PC Renewal" /></p>
									<a href="#commentlist"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/btn_go.png" alt="코멘트 쓰러가기" /></a>
								</div>
							</div>
							<div class="section section1">
								<div class="inner">
									<div class="preview">
										<div id="slider1">
											<ul>
												<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_main_1.jpg?v=1.1" alt="" /></li>
												<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_main_2.jpg?v=1.1" alt="" /></li>
												<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_main_3.jpg?v=1.1" alt="" /></li>
												<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_main_4.jpg?v=1.1" alt="" /></li>
												<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_main_5.jpg?v=1.1" alt="" /></li>
											</ul>
										</div>
									</div>
									<p class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/txt_newface.png" alt="01 텐바이텐의 새 얼굴 - 큼직해진 이미지와 텍스트, 깔끔해진 구성으로 한결 더 시원시원해진 텐바이텐을 소개합니다." /></p>
								</div>
							</div>
							<div class="section section2">
								<div class="inner">
									<p class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/txt_custom.png" alt="02 나에게 꼭 맞는  텐바이텐 - 장바구니와 위시에 담아둔 상품의  세일 소식, 놓치고 싶지 않으셨죠? 지금 바로 확인하고 스마트한 쇼핑하세요!" /></p>
									<div class="preview"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_custom.jpg" alt="" /></div>
									<p class="side"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/txt_smart.png" alt="SMART SHOPPING" /></p>
								</div>
							</div>
							<div class="section section3">
								<div class="inner">
									<p class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/txt_upgrade.png" alt="03 업그레이드된 큐레이션 - 감성과 트렌드를 모두 잡은 텐바이텐만의 감성 큐레이션을 만나보세요." /></p>
									<div class="preview preview1"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_event.jpg" alt="" /></div>
									<div class="preview preview2">
										<div id="slider2">
											<ul>
												<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_look_1.jpg" alt="" /></li>
												<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_look_2.jpg" alt="" /></li>
											</ul>
										</div>
									</div>
									<p class="side"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/txt_curation.png" alt="CURATION SERVICE" /></p>
								</div>
							</div>
							<div class="section section4">
								<div class="inner">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/txt_comingsoon.png" alt="더 새로워질 텐바이텐 메인도 기대해주세요!" /></p>
									<div class="preview"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/img_soon.png" alt="" /></div>
								</div>
							</div>
							<!-- comment -->
							<div class="section comment" id="commentlist">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/txt_comment.png" alt="COMMENT EVENT 새로워진 텐바이텐을 축하해주세요!" /></h3>
									<!-- 코멘트 작성 -->
									<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
									<input type="hidden" name="eventid" value="<%=eCode%>">
									<input type="hidden" name="com_egC" value="<%=com_egCode%>">
									<input type="hidden" name="bidx" value="<%=bidx%>">
									<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
									<input type="hidden" name="iCTot" value="">
									<input type="hidden" name="mode" value="add">
									<input type="hidden" name="spoint" value="0">
									<input type="hidden" name="isMC" value="<%=isMyComm%>">
									<input type="hidden" name="pagereload" value="ON">
									<input type="hidden" name="txtcomm">
									<input type="hidden" name="gubunval">
									<div class="cmt-write">
										<textarea cols="50" rows="6" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();"<%IF NOT(IsUserLoginOK) THEN%> readonly<%END IF%> placeholder="축하메시지를 150자 이내로 적어주세요!" maxlength="150"></textarea>
										<button class="btn-cmt" onclick="jsSubmitComment(document.frmcom); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/85475/btn_comment.png" alt="코멘트 쓰기" /></button>
									</div>
									</form>
									<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
										<input type="hidden" name="eventid" value="<%=eCode%>">
										<input type="hidden" name="com_egC" value="<%=com_egCode%>">
										<input type="hidden" name="bidx" value="<%=bidx%>">
										<input type="hidden" name="Cidx" value="">
										<input type="hidden" name="mode" value="del">
										<input type="hidden" name="pagereload" value="ON">
									</form>
									<!-- 코멘트 목록(6개씩 노출) -->
									<div class="cmt-list">
										<% IF isArray(arrCList) THEN %>
										<ul>
											<% For intCLoop = 0 To UBound(arrCList,2) %>
											<li>
												<span>NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
												<p class="txt">
													<%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%>
												</p>
												<p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
												<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
												<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btn-del">X</a>
												<% end if %>
											</li>
											<% next %>
										</ul>
										<% end if %>
										<div class="pageWrapV15 tMar20">
											<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
										</div>
									</div>
								</div>
							</div>
							<!--// comment -->
						</div>
						<!--// 기분전환 텐바이텐 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->