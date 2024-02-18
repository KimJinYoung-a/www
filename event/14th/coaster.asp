<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#########################################################
' Description :  14th coaster 이벤트
' History : 2015.10.06 유태욱 생성
'#########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim currenttime, hookcode
	currenttime =  now()
	'currenttime = #04/22/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64907
Else
	eCode   =  66517
End If

dim userid, commentcount, i
	userid = getEncloginuserid()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm, ename, emimg, blnitempriceyn, ecc
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(Request("ecc"),10)	
	hookcode	= requestCheckVar(request("hookcode"),2)

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
end If

'// 이벤트 정보 가져옴

dim cEvent
	set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	
	set cEvent = Nothing

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
/* 다함께 코스터! */
.anniversary14th .topic {position:relative; width:1140px; height:273px; margin:0 auto; padding-top:97px;}
.anniversary14th .topic .hgroup {position:relative; width:564px; height:124px; margin:0 auto;}
.anniversary14th .topic .welove {height:20px;}
.anniversary14th .topic .welove span {position:absolute; height:20px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/tit_coaster.png) no-repeat -143px 0; text-indent:-999em;}
.anniversary14th .topic .welove .letter1 {top:0; left:143px; width:106px}
.anniversary14th .topic .welove .letter2 {top:0; left:273px; width:42px; background-position:-273px 0;}
.anniversary14th .topic .welove .letter3 {top:0; left:339px; width:11px; background-position:-339px 0;}
.anniversary14th .topic .welove .letter4 {top:0; left:358px; background:none; text-indent:0;}
.anniversary14th .topic .welove .letter5 {top:0; left:389px; width:15px; background-position:-389px 0;}
.anniversary14th .topic .welove .letter6 {top:0; left:412px; width:12px; background-position:-412px 0;}
.anniversary14th .topic .welove .letter7 {top:45px; left:0; width:68px; background-position:0 -45px;}
.anniversary14th .topic h3 {margin-top:26px;}

/* css3 animation */
.pulse {animation-name:pulse; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:infinite;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.8);}
	100% {transform:scale(1);}
}

.anniversary14th .topic .meet {margin-top:45px;}
.anniversary14th .topic .btncomment {position:absolute; top:25px; right:0;}

.brand {padding:15px 0; text-align:left;}
#slider {width:100%; height:211px;}
#slider .slide-img {float:left; width:211px; height:211px; margin:0 17px; text-align:center;}
#slider .slide-img a {overflow:hidden; display:block; position:relative; width:100%; height:100%;}
#slider .slide-img .over {position:absolute; top:0; left:0; height:0; transition:opacity 0.8s ease-out; opacity:0; filter:alpha(opacity=0); width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/bg_brand_over_v1.png) no-repeat 0 0; transition:0.7s ease; text-indent:-9999em; cursor:pointer;}
#slider .slide-img a:hover .over {opacity:1; filter: alpha(opacity=100); height:211px;}
#slider .circusboyband .over {background-position:0 0;}
#slider .thankyou .over {background-position:-212px 0;}
#slider .jam .over {background-position:-423px 0;}
#slider .dailylike .over {background-position:-635px 0;}
#slider .iconic .over {background-position:-846px 0;}
#slider .ban8 .over {background-position:100% 0;}
#slider .tium .over {background-position:0 100%;}
#slider .livework .over {background-position:-212px 100%;}
#slider .limpalimpa .over {background-position:-423px 100%;}
#slider .thence .over {background-position:-635px 100%;}
#slider .monopoly .over {background-position:-846px 100%;}
#slider .design7321 .over {background-position:100% 100%;}

#slider .www_FlowSlider_com-branding {display:none !important;}
.slide-img img {display:block;}

.slidewrap {width:1140px; margin:0 auto; padding-top:105px; padding-bottom:128px;}
.slidewrap .slide {position:relative;}
.slidewrap .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:41px; height:71px; margin-top:-35px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/btn_nav_v1.png) no-repeat 0 0; text-indent:-999em;}
.slidewrap .slidesjs-previous {left:15px;}
.slidewrap .slidesjs-next {right:15px; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:20px; left:50%; z-index:50; width:133px; margin-left:-66px;}
.slidesjs-pagination li {float:left; padding:0 3px;}
.slidesjs-pagination li a {display:block; width:13px; height:13px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/btn_pagination.png) no-repeat 0 0; text-indent:-999em; transition:all 0.7s;}
.slidesjs-pagination li a.active {background-position:0 100%;}

.commentForm {height:327px; padding-top:40px; background:#f6eee2 url(http://webimage.10x10.co.kr/eventIMG/2015/14th/bg_pattern_ivory.png) repeat 50% 0;}
.commentForm .field {position:relative; width:870px; margin:36px auto 0; text-align:left;}
.commentForm textarea {width:718px; height:56px; padding:15px; border:2px solid #d50c0c; border-right:0; color:#000; font-family:'Vedana', 'Dotum'; font-size:12px;}
.commentForm .btnsubmit {position:absolute; top:0; right:0;}

.commentlistWrap {padding-top:60px;}
.commentlist {overflow:hidden; width:1050px; margin:0 auto;}
.commentlist .col {float:left; position:relative; width:240px; height:225px; margin:0 15px 50px; padding:35px 40px 60px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/bg_comment.jpg) no-repeat 0 0; text-align:left;}
.commentlist .col01 {background-position:0 0;}
.commentlist .col02 {background-position:-320px 0;}
.commentlist .col03 {background-position:100% 0;}
.commentlist .col04 {background-position:0 -320px;}
.commentlist .col05 {background-position:-320px -320px;}
.commentlist .col06 {background-position:100% -320px;}
.commentlist .col07 {background-position:0 -640px;}
.commentlist .col08 {background-position:-320px -640px;}
.commentlist .col09 {background-position:100% -640px;}
.commentlist .col10 {background-position:0 100%;}
.commentlist .col11 {background-position:-320px 100%;}
.commentlist .col12 {background-position:100% 100%;}
.commentlist .col .no, .commentlist .col .id, .commentlist .col .msg {font-family:'Verdana', 'Dotum'; font-size:11px;}
.commentlist .col .no {margin-bottom:13px; color:#333;}
.commentlist .col .msg {color:#666; font-family:'Dotum'; line-height:15px;}
.commentlist .col .id {margin-top:20px; color:#999;}
.commentlist .col .mobile {padding-left:5px;}
.commentlist .col .btndelete {position:absolute; top:36px; right:36px; width:35px; height:16px; background-color:transparent; vertical-align:top;}

.pageWrapV15 {width:1140px; margin:0 auto; padding-top:20px; border-top:1px solid #eee;}
.pageWrapV15 .pageMove {display:none;}

/* tiny scrollbar */
.scrollbarwrap {width:245px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:235px; height:165px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#eee;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#eee;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#7c7c7c; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}
</style>
<script type="text/javascript">
function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){      //코멘트 입력
	<% If IsUserLoginOK() Then %>
		<% If Now() > #10/26/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If left(now(), 10)>="2015-10-10" and left(now(), 10) < "2015-10-27" Then %>
				<% if commentcount >= 3 then %>
					alert("감사합니다!\n축하 코멘트는 세번까지만\n작성할 수 있습니다. :)");
					return;				
				<% else %>

					if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 600 || frm.txtcomm.value == '텐바이텐의 14번째 생일을 축하해주세요!'){
						alert("텐바이텐의 14번째 생일을 축하해주세요!");
						frm.txtcomm.focus();
						return false;
					}
				   frm.action = "/event/lib/comment_process.asp";
				   frm.submit();
				<% end if %>
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>				
		<% End If %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
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
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	}

	if (frmcom.txtcomm.value == '텐바이텐의 14번째 생일을 축하해주세요!'){
		frmcom.txtcomm.value = '';
	}
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">

						<%'  [66517] 다함께 코스터!%>
						<div class="anniversary14th">
							<!-- 14th common : header & nav -->
							<!-- #include virtual="/event/14th/header.asp" -->

							<div class="topic">
								<div class="hgroup">
									<p class="welove">
										<span class="letter1">BRAND</span>
										<span class="letter2">WE</span>
										<span class="letter3">L</span>
										<span class="letter4 pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/ico_heart.png" alt="O" /></span>
										<span class="letter5">V</span>
										<span class="letter6">E</span>
									</p>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/tit_coaster_v1.png" alt="다함께 코스터!" /></h3>
								</div>
								<p class="meet"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/txt_meet_v2.png" alt="12개의 브랜드와 함께 만드는 콜라보레이션! 예쁜 코스터 속에 담긴 재미있는 디자인을 만나보세요." /></p>
								<a href="#commentForm" class="btncomment"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/btn_comment.gif" alt="코멘트 남기러 가기"/ ></a>
							</div>

							<div class="brand">
								<div id="slider" class="slider-horizontal">
								<%
								dim rlroop(11)
								dim index , rnd1, rnd2 , temp
								dim divcls, brdlink, imgnum, overtxt

								for i = 0 to 11 
									rlroop(i) = (i + 1)
								next
								
								Randomize  

								for i = 0 to 11
								  rnd1 = int  ((( 11 - 0 + 1) * Rnd + 0))
								  rnd2 = int  ((( 11 - 0 + 1) * Rnd + 0))

								  temp  =  rlroop(rnd1)
								  rlroop(rnd1) = rlroop(rnd2)
								  rlroop(rnd2) = temp
								next
								
								for i = 0 to 11
									Select Case (rlroop(i))
										Case "1"
											divcls	=	"circusboyband"
											brdlink	=	"circusboyband"
											imgnum	=	"01"
											overtxt	=	"서커스보이밴드 브랜드 보러가기"
										Case "2"
											divcls	=	"thankyou"
											brdlink	=	"thankyoucase"
											imgnum	=	"02"
											overtxt	=	"땡큐스튜디오 브랜드 보러가기"
										Case "3"
											divcls	=	"jam"
											brdlink	=	"jam"
											imgnum	=	"03"
											overtxt	=	"잼스튜디오 브랜드 보러가기"
										Case "4"
											divcls	=	"dailylike"
											brdlink	=	"dailylike"
											imgnum	=	"04"
											overtxt	=	"데일리라이크 브랜드 보러가기"
										Case "5"
											divcls	=	"iconic"
											brdlink	=	"iconic"
											imgnum	=	"05"
											overtxt	=	"아이코닉 브랜드 보러가기"
										Case "6"
											divcls	=	"ban8"
											brdlink	=	"ban8"
											imgnum	=	"06"
											overtxt	=	"반8 브랜드 보러가기"
										Case "7"
											divcls	=	"tium"
											brdlink	=	"sandollkawangsoo"
											imgnum	=	"07"
											overtxt	=	"티움 브랜드 보러가기"
										Case "8"
											divcls	=	"livework"
											brdlink	=	"livework"
											imgnum	=	"08"
											overtxt	=	"라이브워크 브랜드 보러가기"
										Case "9"
											divcls	=	"limpalimpa"
											brdlink	=	"limpalimpa"
											imgnum	=	"09"
											overtxt	=	"림파림파 브랜드 보러가기"
										Case "10"
											divcls	=	"thence"
											brdlink	=	"thence"
											imgnum	=	"10"
											overtxt	=	"덴스 브랜드 보러가기"
										Case "11"
											divcls	=	"monopoly"
											brdlink	=	"monopoly1"
											imgnum	=	"11"
											overtxt	=	"모노폴리 브랜드 보러가기"
										Case "12"
											divcls	=	"design7321"
											brdlink	=	"7321"
											imgnum	=	"12"
											overtxt	=	"7321디자인 브랜드 보러가기"
									End Select
									''response.write rlroop(i) & "//"
								%>
									<div class="slide-img <%= divcls %>">
										<a href="/street/street_brand_sub06.asp?makerid=<%=brdlink%>">
											<img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/img_brand_<%= imgnum %>.png" alt="" />
											<span class="over"><%= overtxt %></span>
										</a>
									</div>
								<%
								next
								%>
								</div>
							</div>

							<div class="slidewrap">
								<div id="slide" class="slide">
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/img_slide_01.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/img_slide_02.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/img_slide_03.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/img_slide_04.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/img_slide_05.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/img_slide_06.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/img_slide_07.jpg" alt="" /></div>
								</div>
								<p class="howto">
									<img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/txt_how_to_get_v1.png" alt="코스터를 받으려면" usemap="#howto" />
									<map name="howto" id="howto">
										<area shape="rect" coords="290,26,530,95" href="/event/eventmain.asp?eventid=66572" title="제가 바로 텐바이텐 배송 입니다. 이벤트 페이지로 이동" alt="텐바이텐 배송상품을 포함해서 쇼핑 하기" />
										<area shape="rect" coords="544,27,762,95" href="#commentForm" alt="텐바이텐 생일 축하 코멘트를 달기" class="btngo" />
										<area shape="rect" coords="793,28,1069,95" href="/offshop/shopinfo.asp?shopid=streetshop011&amp;tabidx=1" title="텐바이텐 오프라인 홈페이지로 이동" target="_blank" alt="텐바이텐 대학로, 김포, 명동 매장에서 쇼핑하기" />
									</map>
								</p>
							</div>

							<div id="commentForm" class="commentForm">
								<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
								<input type="hidden" name="eventid" value="<%=eCode%>">
								<input type="hidden" name="com_egC" value="<%=com_egCode%>">
								<input type="hidden" name="bidx" value="<%=bidx%>">
								<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
								<input type="hidden" name="iCTot" value="">
								<input type="hidden" name="mode" value="add">
								<input type="hidden" name="spoint" value="0">
								<input type="hidden" name="isMC" value="<%=isMyComm%>">
								<input type="hidden" name="hookcode" value="#cmtlist">
									<fieldset>
									<legend>텐바이텐의 14번째 생일을 축하해주세요!</legend>
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/txt_congratulation.png" alt="텐바이텐의 14번째 생일을 축하해주세요! 총 100분을 뽑아 랜덤 5개 코스터를 선물로 보내드립니다. 이벤트 기간은 2015년 10월 10일부터 10월 26일까지며, 당첨자 발표는 2015년 10월 31일입니다." /></p>
										<div class="field">
											<textarea name="txtcomm" cols="60" rows="5" title="텐바이텐의 14번째 생일 축하글 쓰기"  id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>텐바이텐의 14번째 생일을 축하해주세요!<%END IF%></textarea>
											<div class="btnsubmit"><input type="image" onclick="jsSubmitComment(frmcom); return false;" src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/btn_submit.png" alt="축하글 남기기" /></div>
										</div>
									</fieldset>
								</form>
							</div>

							<% IF isArray(arrCList) THEN %>
								<div class="commentlistWrap" id="commentlistwrap">
									<div class="commentlist" id="commentlist">
									<%
									For intCLoop = 0 To UBound(arrCList,2)
									%>
										<div class="col" id="cmtlist">
											<div class="no">no. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></div>
											<div class="scrollbarwrap">
												<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
												<div class="viewport">
													<div class="overview">
														<!-- for dev msg : 축하글 부분 요기에 넣어주세요 -->
														<div class="msg">
															<%=replace(db2html(arrCList(1,intCLoop)),"<!","")%>
														</div>
													</div>
												</div>
											</div>

											<div class="id"><%=printUserId(arrCList(2,intCLoop),2,"*")%> / <%=Mid(arrCList(4,intCLoop), 6, 2)&"."&Mid(arrCList(4,intCLoop), 9, 2)%> <% if arrCList(8,intCLoop)<>"W" then %><span class="mobile"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/ico_mobile.png" alt="모바일에서 작성된 글" /></span><% end if %></div>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
												<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;" class="btndelete"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66517/btn_del.png" alt="내가 쓴 글 삭제하기" /></button>
											<% end if %>
										</div>
									<% next %>
	
									</div>
									<div class="pageWrapV15">
										<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
									</div>
								</div>
							<% end if %>

						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="com_egC" value="<%=com_egCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="Cidx" value="">
	<input type="hidden" name="mode" value="del">
	<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>">
	<input type="hidden" name="hookcode" value="#cmtlist">
</form>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});

$(function(){
	/* flowslider */
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		//position:0.0,
		startPosition:0.55
	});

	/* skip to comment */
	$(".btncomment, .howto .btngo").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
	});

	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"730",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	/* commentlist random bg */
	var randomList = ["col01", "col02", "col03", "col04", "col05", "col06", "col07", "col08", "col09", "col10", "col11", "col12"];
	var listSort = randomList.sort(function(){
		return Math.random() - Math.random();
	});
	$("#commentlist .col").each( function(index,item){
		$(this).addClass(listSort[index]);
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 150 ) {
			titleAnimation();
		}
	});

	$(".topic .welove span").css({"top":"5px", "opacity":"0"});
	function titleAnimation() {
		$(".topic .welove .letter1").delay(100).animate({"top":"0", "opacity":"1"},400);
		$(".topic .welove .letter2").delay(400).animate({"top":"0", "opacity":"1"},400);
		$(".topic .welove .letter3").delay(700).animate({"top":"0", "opacity":"1"},400);
		$(".topic .welove .letter4").delay(1500).animate({"top":"0", "opacity":"1"},400);
		$(".topic .welove .letter5").delay(1000).animate({"top":"0", "opacity":"1"},400);
		$(".topic .welove .letter6").delay(1200).animate({"top":"0", "opacity":"1"},400);
	}
<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	var val = $('#cmtlist').offset();
	window.$('html,body').animate({scrollTop:val.top},100);
<% end if %>
});
</script>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->