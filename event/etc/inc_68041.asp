<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 핫쿠폰 팩키지
' History : 2015-12-02 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
Dim eCode , userid, i
Dim iCCurrpage , iCPageSize , iCTotCnt , iCTotalPage
Dim iCPerCnt , arrCList , intCLoop
dim cEComment , pagereload

	pagereload	= requestCheckVar(request("pagereload"),2)

dim currenttime
	currenttime =  now()

IF application("Svr_Info") = "Dev" THEN
	eCode   =  65988
Else
	eCode   =  68041
End If

userid = GetEncLoginUserID()

dim commentcount
commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		
iCPageSize = 8		

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	
	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg

dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("[텐바이텐xTvN] 응답하라 1988 공식 굿즈 그랜드 오픈")
snpLink = Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre = Server.URLEncode("10x10 이벤트")
snpImg = Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2015/68041/m/bnr_kakao.jpg")

'기본 태그
snpTag = Server.URLEncode("텐바이텐")
snpTag2 = Server.URLEncode("#10x10")
%>
<style type="text/css">
img {vertical-align:top;}
.evt68041 {background-color:#fff;}

.reply1988 .replyCont {position:relative; width:1140px; margin:0 auto;}
.reply1988 .section {height:700px; background-position:50% 0; background-repeat:no-repeat;}
.reply1988 .intro {height:970px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_intro.jpg); background-color:#f1c746;}
.reply1988 .section01 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_cont_01.png); background-color:#565225;}
.reply1988 .section02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_cont_02.png); background-color:#7b1f2a;}
.reply1988 .section03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_cont_03.png); background-color:#3c4b7b;}
.reply1988 .section04 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_cont_04.png); background-color:#72562b;}
.reply1988 .section05 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_cont_05.png); background-color:#287372;}
.reply1988 .section06 {height:800px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_cont_06.png); background-color:#684a68;}
.reply1988 .section07 {height:94px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_cont_07.png); background-color:#835d21;}
.reply1988 .item {overflow:hidden;}
.reply1988 .item div {width:50%; text-align:center;}
.reply1988 .item .ftLt a {padding-left:46px}
.reply1988 .soldout {position:absolute; top:42px; left:0;}
.reply1988 .character div {position:absolute;}
.reply1988 .swiper {position:relative; margin:0 auto;}
.reply1988 .swiper .swiper-container {overflow:hidden; width:100%;}
.reply1988 .swiper .pagination {position:absolute; bottom:0; left:0; width:100%; height:9px; z-index:100; text-align:center;}
.reply1988 .swiper .pagination span {display:inline-block; width:12px; height:9px; margin:0 11px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_pagination.png) 0 0 no-repeat; cursor:pointer;}
.reply1988 .swiper .pagination .swiper-active-switch {background-position:100% 0;}
.reply1988 .swiper button {position:absolute; top:162px; z-index:150; background:transparent;}
.reply1988 .info {padding-top:40px;}

.reply1988 .intro .only {position:absolute; right:25px; top:27px;}
.reply1988 .intro .title .with {position:absolute; left:50%; top:59px; margin-left:-110px;}
.reply1988 .intro .title h2 {position:absolute; left:204px; top:5px;}
.reply1988 .intro .title .open {position:absolute; left:310px; top:317px;}

.section01 .replyCont {height:610px; padding-top:90px;}
.section01 .monthly {width:453px; height:371px; padding:17px 0 0 9px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_calendar_monthly.png) 50% 0 no-repeat;}
.section01 .monthly .swiper1 {width:445px; height:288px;}
.section01 .monthly .prev {left:-65px;}
.section01 .monthly .next {right:-65px;}
.section01 .c01 {left:98px; bottom:0;}
.section01 .c02 {right:25px; bottom:0;}

.section02 .replyCont {height:625px; padding-top:75px;}
.section02 .sticker {width:323px; height:432px;}
.section02 .sticker .swiper2 {width:323px; height:398px; margin:0 auto;}
.section02 .sticker .swiper2 .swiper-slide {float:left;}
.section02 .sticker .prev {left:-70px;}
.section02 .sticker .next {right:-70px;}
.section02 .c03 {left:-64px; bottom:25px;}
.section02 .c04 {right:78px; bottom:21px;}

.section03 .replyCont {height:700px;}
.section03 .item {padding-top:95px;}
.section03 .c05 {right:-225px; bottom:0;}

.section04 .replyCont {height:700px;}
.section04 .item {padding-top:115px;}
.section04 .replyCont .item .ftRt {padding-top:57px;}
.section04 .replyCont .item .ftRt img {margin-left:50px;}
.section04 .c06 {left:-298px; bottom:0;}

.section05 .replyCont {height:700px;}
.section05 .item {padding-top:115px;}
.section05 .item div {float:none !important; text-align:left;}
.section05 .item div a {padding-left:0 !important;}
.section05 .item .ftRt {position:static;}
.section05 .item .puzzle {position:absolute; top:141px; left:25px; width:289px;}
.section05 .item .daily {position:absolute; top:123px; left:396px; width:367px;}
.section05 .item .case {position:absolute; top:112px; right:0; width:323px;}
.section05 .item .case .soldout {top:57px; left:-10px;}
.section05 .c07 {right:-250px; bottom:-60px;}

.section06 .replyCont {height:690px; padding-top:110px;}
.section06 .television {width:880px; height:578px; padding:47px 0 0 103px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_tv.png) 50% 0 no-repeat;}
.section06 .television .movie {width:760px; height:428px; margin-top:9px; margin-left:9px;}
.section06 .c08 {left:-383px; bottom:0;}

.section07 .replyCont {overflow:hidden; width:1100px; padding-top:20px;}
.section07 .replyCont .ftLt {padding-top:15px;}
.section08 .replyCont {width:1060px; padding-top:81px;}
.section08 .commentWrite {height:440px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_comment.png) 0 0 no-repeat;}
.section08 .commentWrite h3 {padding:71px 0 40px; }
.section08 .commentWrite .writeCont {overflow:hidden; width:905px; margin:0 auto; padding-top:4px;}
.section08 .commentWrite .writeCont textarea {float:left; width:710px; height:70px; padding:20px; color:#6d6d6d; font-size:11px; line-height:18px; border:1px solid #e4ab29;}
.section08 .commentWrite .writeCont .btnSubmit {float:right; margin-top:-4px;}

.section08 .commentList {overflow:hidden;}
.section08 .commentList ul {overflow:hidden; width:1096px; margin-right:-33px; padding-top:60px;}
.section08 .commentList li {position:relative; float:left; width:240px; height:240px; margin:0 33px 55px 0; font-size:11px; line-height:12px; color:#fff; text-align:center; background-position:0 0; background-repeat:no-repeat;}
.section08 .commentList li.type01 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_comment_01.png);}
.section08 .commentList li.type02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_comment_02.png);}
.section08 .commentList li.type03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_comment_03.png);}
.section08 .commentList li.type04 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/68041/bg_comment_04.png);}
.section08 .commentList li .num {padding:45px 0 20px; font-weight:bold;}
.section08 .commentList li .num .bar {font-weight:normal;}
.section08 .commentList li .writer {padding-top:18px;}
.section08 .commentList li .delete {position:absolute; right:22px; top:27px;}
/* tiny scrollbar */
.scrollbarwrap {width:164px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position:relative; width:152px; height:90px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%; text-align:left; line-height:18px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#ededed;}
.scrollbarwrap .track {position: relative; width:2px; height:100%; background-color:#ededed;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#393939; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
</style>
<script>
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
		<% If not( left(currenttime,10) >= "2015-12-18" and left(currenttime,10) <= "2016-01-10" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 400){
					alert("코맨트는 400자 까지만 작성이 가능합니다. 코맨트를 남겨주세요.");
					frm.txtcomm.focus();
					return false;
				}
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
}

</script>
<div class="evt68041 reply1988">
	<div class="section intro">
		<div class="replyCont">
			<p class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/tag_only.png" alt="10X10 ONLY" /></p>
			<div id="titleAnimation" class="title">
				<p class="with"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_with.png" alt="텐바이텐과 TVN의 만남" /></p>
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/tit_reply_1988.png" alt="응답하라 1988" /></h2>
				<p class="open"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_grand_open.png" alt="공식 굿즈 그랜드 오픈" /></p>
			</div>
		</div>
	</div>
	<div class="section section01">
		<div class="replyCont">
			<div class="swiper monthly">
				<div class="swiper-container swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1401873&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_monthly_01.jpg" alt="" /></a></div>
						<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1401873&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_monthly_02.jpg" alt="" /></a></div>
						<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1401873&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_monthly_03.jpg" alt="" /></a></div>
						<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1401873&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_monthly_04.jpg" alt="" /></a></div>
					</div>
				</div>
				<div class="pagination"></div>
				<button type="button" class="prev"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_prev_v1.png" alt="이전" /></button>
				<button type="button" class="next"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_next_v1.png" alt="다음" /></button>
			</div>
			<p class="info"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_monthly_calendar_v1.png" alt="2016 탁상 달력" /></p>
			<div class="character">
				<div class="c01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_actor_01.png" alt="" /></div>
				<div class="c02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_actor_02.png" alt="" /></div>
			</div>
		</div>
	</div>
	<div class="section section02">
		<div class="replyCont">
			<div class="swiper sticker">
				<div class="swiper-container swiper2">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1401875&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_sticker_01_v1.png" alt="" /></a></div>
						<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1401875&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_sticker_02_v1.png" alt="" /></a></div>
						<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1401875&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_sticker_03_v1.png" alt="" /></a></div>
					</div>
				</div>
				<div class="pagination"></div>
				<button type="button" class="prev"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_prev_v1.png" alt="이전" /></button>
				<button type="button" class="next"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_next_v1.png" alt="다음" /></button>
			</div>
			<p class="info"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_sticker.png" alt="딱지 스티커" /></p>
			<div class="character">
				<div class="c03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_actor_03.png" alt="" /></div>
				<div class="c04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_actor_04.png" alt="" /></div>
			</div>
		</div>
	</div>
	<div class="section section03">
		<div class="replyCont">
			<div class="item">
				<div class="ftLt"><a href="/shopping/category_prd.asp?itemid=1401877&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_note_v1.png" alt="청춘시대 노트" /></a></div>
				<div class="ftRt"><a href="/shopping/category_prd.asp?itemid=1401881&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_stamp_v1.png" alt="영원우표" /></a></div>
			</div>
			<div class="character">
				<div class="c05"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_actor_05.png" alt="" /></div>
			</div>
		</div>
	</div>
	<div class="section section04">
		<div class="replyCont">
			<div class="item">
				<div class="ftLt"><a href="/shopping/category_prd.asp?itemid=1401879&amp;pEtr=68041"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_postcard_v1.png" alt="포토 엽서 세트" /></a></div>
				<div class="ftRt">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_bus_card_v1.png" alt="" usemap="#map01" /></div>
					<map name="map01" id="map01">
						<area shape="poly" coords="279,121,263,54,247,47,42,105,35,114,73,250,236,209,276,138" href="/shopping/category_prd.asp?itemid=1401882&amp;pEtr=68041" alt="티머니 버스카드 카드형" onfocus="this.blur();" />
						<area shape="poly" coords="283,137,251,200,227,277,252,294,301,307,344,146,350,15,322,7" href="/shopping/category_prd.asp?itemid=1401883&amp;pEtr=68041" alt="티머니 버스카드 회수권형" onfocus="this.blur();" />
					</map>
				</div>
			</div>
			<div class="character">
				<div class="c06"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_actor_06.png" alt="" /></div>
			</div>
		</div>
	</div>
	<div class="section section05">
		<div class="replyCont">
			<div class="item">
				<div class="ftLt puzzle">
					<a href="/shopping/category_prd.asp?itemid=1401880&amp;pEtr=68041">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_puzzle.png" alt="퍼즐 엽서" />
					</a>
				</div>
				<div class="ftLt daily">
					<!--a href="/shopping/category_prd.asp?itemid=1401874&amp;pEtr=68041"-->
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_daily.png" alt="2016 벽걸이 일력" />
						<span class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_soldout.png" alt="솔드아웃" /></span>
					<!--/a-->
				</div>
				<div class="ftLt case">
					<a href="/shopping/category_prd.asp?itemid=1401878&amp;pEtr=68041">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_case.png" alt="스마트폰 케이스" />
						<!--<span class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_soldout.png" alt="솔드아웃" /></span>-->
					</a>
				</div>
			</div>
			<div class="character">
				<div class="c07"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_actor_07.png" alt="" /></div>
			</div>
		</div>
	</div>
	<div class="section section06">
		<div class="replyCont">
			<div class="television">
				<div class="movie">
					<iframe src="https://www.youtube.com/embed/wjZEql74IcM" width="760" height="428" frameborder="0" title="응답하라 1988 하이 아이템 탄생" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
				</div>
			</div>
			<p class="donate"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_donate.png" alt="원가 및 유통 마진을 제외한 tvN 수익금은 사회공헌 분야에 기부됩니다." /></p>
			<div class="character">
				<div class="c08"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/img_actor_08.png" alt="" /></div>
			</div>
		</div>
	</div>
	<div class="section section07">
		<div class="replyCont">
			<p class="ftLt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_noti.png" alt="응팔앓이 친구들에게도 얼른 이 소식을 알려주세요!" /></p>
			<div class="ftRt">
				<a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_facebook.png" alt="페이스북" /></a>
				<a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_twitter.png" alt="트위터" /></a>
				<a href="" onclick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>');return false;""><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_pinterest.png" alt="핀터레스트" /></a>
			</div>
		</div>
	</div>
<!--
	<div class="section08">
		<div class="replyCont">
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="spoint" value="0">
			<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
			<% Else %>
				<input type="hidden" name="hookcode" value="&ecc=1">
			<% End If %>
			<div class="commentWrite">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/txt_comment_event_v2.png" alt="응답하라 기대평! 코멘트 이벤트" /></h3>
				<div class="writeCont">
					<textarea cols="80" rows="5" name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
					<input type="image" onclick="jsSubmitComment(document.frmcom); return false;" src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_submit.png" alt="기대평 남기기" class="btnSubmit" />
				</div>
			</div>
			</form>
			<form name="frmactNew" method="post" action="/event/lib/doEventComment.asp" style="margin:0px;">
			<input type="hidden" name="mode" value="del">
			<input type="hidden" name="pagereload" value="ON">
			<input type="hidden" name="Cidx" value="">
			<input type="hidden" name="eventid" value="<%= eCode %>">
			<input type="hidden" name="linkevt" value="<%= eCode %>">
			<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
			<% Else %>
				<input type="hidden" name="hookcode" value="&ecc=1">
			<% End If %>
			</form>

			<% IF isArray(arrCList) THEN %>
			<div class="commentList" id="commentlist">
				<ul>
					<% For intCLoop = 0 To UBound(arrCList,2) %>
					<li>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
						<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="delete"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/btn_delete.png" alt="삭제" /></a>
						<% end if %>
						<div class="num">
							<span>No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
							<span class="bar">|</span>
							<span><%=Formatdate(arrCList(4,intCLoop),"M/D")%></span>
						</div>
						<div class="scrollbarwrap">
							<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
							<div class="viewport">
								<div class="overview">
									<%=db2html(arrCList(1,intCLoop))%>
								</div>
							</div>
						</div>
						<p class="writer"><% If arrCList(8,i) <> "W" Then %><img src="http://webimage.10x10.co.kr/eventIMG/2015/68041/ico_mobile.png" alt="모바일에서 작성" /><% End If %> <%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
					</li>
					<% Next %>
				</ul>
				<div class="pageWrapV15 tMar20">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			</div>
			<% End If %>
		</div>
	</div>
//-->
</div>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});
$(function(){
	mySwiper1 = new Swiper('.swiper1',{
		mode :'vertical',
		loop:true,
		resizeReInit:true,
		autoplay:3000,
		speed:800,
		pagination:'.monthly .pagination',
		paginationClickable:true,
		autoplayDisableOnInteraction:false
	});
	$('.monthly .prev').on('click', function(e){
		e.preventDefault()
		mySwiper1.swipePrev()
	});
	$('.monthly .next').on('click', function(e){
		e.preventDefault()
		mySwiper1.swipeNext()
	});

	mySwiper2 = new Swiper('.swiper2',{
		mode :'horizontal',
		loop:true,
		resizeReInit:true,
		autoplay:3000,
		speed:800,
		pagination:'.sticker .pagination',
		paginationClickable:true,
		autoplayDisableOnInteraction:false
	});
	$('.sticker .prev').on('click', function(e){
		e.preventDefault()
		mySwiper2.swipePrev()
	});
	$('.sticker .next').on('click', function(e){
		e.preventDefault()
		mySwiper2.swipeNext()
	});

	// comment list
	var classes = ["type01", "type02", "type03", "type04"];
	$(".commentList li").each(function(){
		$(this).addClass(classes[~~(Math.random()*classes.length)]);
	});

	/* title animation */
	$("#titleAnimation .open").css({"top":"337px", "width":"300px", "opacity":"0"});
	function titleAnimation() {
		$("#titleAnimation h2").delay(100).effect("bounce", {times:5},800);
		$("#titleAnimation .open").delay(600).animate({"top":"317px", "width":"561px", "opacity":"1"},1700);
	}
	titleAnimation();
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->
