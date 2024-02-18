<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : [SNS] #자랑스타그램
' History : 2017-11-23 정태훈
'####################################################
Dim eCode, userid, pagereload, i
dim iCCurrpage, iCTotCnt, eCC, iCPageSize, iCTotalPage
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67464
Else
	eCode   =  82223
End If

iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	
IF iCCurrpage = "" THEN iCCurrpage = 1
IF iCTotCnt = "" THEN iCTotCnt = -1

eCC = requestCheckVar(Request("eCC"), 1)
pagereload	= requestCheckVar(request("pagereload"),2)
userid		= GetEncLoginUserID()

iCPageSize = 8		'한 페이지의 보여지는 열의 수

dim oinstagramevent
set oinstagramevent = new Cinstagrameventlist
	oinstagramevent.FPageSize	= iCPageSize
	oinstagramevent.FCurrPage	= iCCurrpage
	oinstagramevent.FTotalCount		= iCTotCnt  '전체 레코드 수
	oinstagramevent.FrectIsusing = "Y"
	oinstagramevent.FrectEcode = eCode
	oinstagramevent.fnGetinstagrameventList

	iCTotCnt = oinstagramevent.FTotalCount '리스트 총 갯수
	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>
<style type="text/css">
.evt82223 {background:url(http://webimage.10x10.co.kr/eventIMG/2017/82223/bg_boastagram.png) repeat-x 0 0;}
.evt82223 .inner {width:1140px; margin:0 auto;}
.evt82223 .topic {height:725px; padding-top:112px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/82223/img_boastagram.jpg) no-repeat 50% 0;}
.evt82223 .topic a {position:absolute; left:50%; top:609px; margin-left:175px; animation:bounce 10 1.4s; -webkit-animation:bounce 10 1.4s;}
.evt82223 .action {padding:75px 0 125px 0;}
.evt82223 .giftInfo {padding:75px 0 105px 0;}

.instagram {position:relative; padding:122px 0 65px; background-color:#fff;}
.btnInstagram {position:absolute; top:184px; left:50%; margin-left:369px;}
.instagram ul {overflow:hidden; width:1168px; margin:0 auto; padding-top:60px;}
.instagram ul li {overflow:hidden; float:left; width:262px; margin:15px;}
.instagram ul li img {width:auto; height:262px; transition:transform 1s;}
.instagram ul li .id {overflow:hidden; display:block; height:20px; margin-top:10px; padding:0 10px; color:#767676; font-weight:bold;}
.instagram ul li .id span {color:#f93e75;}
.instagram ul li:hover img {transform:scale(0.97);}

.pageWrapV15 {margin-top:35px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {width:29px; height:29px; margin:0; border:0;}
.paging a span {height:29px; padding:0; color:#898888; line-height:29px;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging .first, .paging .end {display:none;}
.paging a.arrow span {background:none;}
.paging a.current span {color:#f93e75; font-weight:bold;}
.paging .prev, 
.paging .next {background:url(http://webimage.10x10.co.kr/eventIMG/2017/82223/btn_pagination_nav.png) 0 0 no-repeat;}
.paging .prev {margin-right:5px;}
.paging .next {background-position:100% 0;}
.paging .next {margin-left:10px;}

.evtNoti .inner {position:relative; width:820px; margin:0 auto;}
.evtNoti h3 {position:absolute; left:0; top:50%; margin-top:-14px;}
.evtNoti ul {padding:50px 0 45px 180px;}
.evtNoti li {line-height:19px; padding:0 0 4px 15px; color:#505050; text-align:left;}
@keyframes bounce {
	from, to{transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-8px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
$(function(){
	<% if Request("eCC")<>"" then %>
		window.$('html,body').animate({scrollTop:$("#instagramlist").offset().top}, 0);
//		setTimeout("pagedown()",100);
	<% end if %>
});

$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"870",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});
});

//function pagedown(){
//	window.$('html,body').animate({scrollTop:$("#instagramlist").offset().top}, 0);
//}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
</script>
						<div class="evt82223">
							<div class="topic">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/tit_boastagram.png"  alt="인스타그램 인증샷 이벤트 #자랑스타그램" /></h2>
								<a href="https://www.instagram.com/your10x10/" title="텐바이텐  공식 인스타그램으로 이동" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/deco_instargram.png"  alt="텐바이텐 공식 인스타그램 @your10x10 으로 이동" /></a>
							</div>
							<div class="action inner">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/txt_boastagram_item.png"  alt="2018 다이어리 사은품을 인스타그램에 자랑해주세요! 추첨을 통해 모나미 플러스펜 24색 세트를 20분께 드립니다." usemap="#giftMap" /></p>
								<map name="giftMap">
									<area shape="rect" coords="541,0,954,242" href="/shopping/category_prd.asp?itemid=1812564&pEtr=82223" target="_blank" alt="모나미 플러스펜 24색 세트" />
								</map>
								<p class="tPad30"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/img_boastagram_howto.png"  alt="이벤트 참여방법 : 텐텐에서 다이어리구매하기 - [2018 다이어리 스토리] 사으품 사진찍기 - 필수 해시태그 포함하여 인스타그램에 업로드하기" usemap="#diaryMap" /></p>
								<map name="diaryMap">
									<area shape="rect" coords="271,13,457,268" href="http://www.10x10.co.kr/diarystory2018/?pEtr=82223" target="_blank" alt="텐바이텐에서 다이어리 구매하기" />
								</map>
							</div>
							<div class="giftInfo inner">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/txt_boastagram_gift.png"  alt="텐바이텐 X 문라잇 펀치 로맨스 2018 Diary Story 구매사은품" /></h3>
								<p class="tMar50"><a href="http://www.10x10.co.kr/diarystory2018/gift.asp?pEtr=82223" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/img_boastagram_gift.png"  alt="마스킹테이프 / 홀로그램 파일 / 메모판 + 자석" /></a><p>
								<p class="tMar50"><a href="http://www.10x10.co.kr/diarystory2018/gift.asp?pEtr=82223" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/btn_boastagram_gift.png"  alt="사은품 안내 바로가기" /></a><p>
							</div>

							<!-- instagram -->
							<div class="instagram" id="instagramlist">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/tit_boastagram_totenten.png" alt="텐바이텐에 도착한 #자랑스타그램" /></h3>
								<div class="btnInstagram"><a href="https://www.instagram.com/your10x10/" title="텐바이텐 공식 인스타그램으로 이동" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/btn_go_instargram.png" alt="텐바이텐 인스타그램 바로가기" /></a></div>
								<% if oinstagramevent.fresultcount > 0 then %>
								<ul>
									<% for i = 0 to oinstagramevent.fresultcount-1 %>
									<li>
										<img src="<%= oinstagramevent.FItemList(i).Fimgurl %>" width="262" height="262" />
										<!-- for dev msg : 아이디 ** 처리해주세요  -->
										<span class="id"><span><%=printUserId(left(oinstagramevent.FItemList(i).Fuserid,10),2,"*")%></span>님의 자랑스타그램</span>
									</li>
									<% next %>
								</ul>
								<% end if %>
								<!-- pagination -->
								<div class="pageWrapV15">
									<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,10,"jsGoComPage") %>
								</div>
							</div>
							<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
							<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
							<input type="hidden" name="iCTot" value=""/>
							<input type="hidden" name="eCC" value="1">
							</form>
							<div class="evtNoti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82223/tit_boastagram_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>- 인스타그램 계정이 비공개 일 경우 이벤트 참여에 제외됩니다.</li>
										<li>- 이벤트에 참여한 인증샷은 고객 동의 없이 이벤트 페이지 내에 노출될 수 있습니다.</li>
										<li>- 이벤트 페이지 내에 노출되는 SNS인증샷은 실시간 적용되지 않습니다.</li>
										<li>- SNS 이벤트에 참여하였더라도 이벤트 페이지 내에 노출되지 않을 수 있습니다.</li>
										<li>- 이벤트 페이지 내에 SNS인증샷 노출여부는 이벤트 당첨 여부와 무관합니다.</li>
										<li>- 이벤트 일정 및 당첨 상품 등은 당사 사정에 따라 부득이하게 변경 될 수 있습니다.</li>
									</ul>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->