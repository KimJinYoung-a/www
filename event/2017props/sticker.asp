<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : 반짝반짝 내친구
' History : 2017-03-31 유태욱
'####################################################
Dim eCode, userid, pagereload, i
dim iCCurrpage, iCTotCnt, eCC, iCPageSize, iCTotalPage
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66295
Else
	eCode   =  77064
End If

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=77064" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

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
<!-- #include virtual="/event/2017props/sns.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:700,400);
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

.sticker .topic {position:relative; height:870px;}
.sticker .hgroup {position:absolute; top:106px; left:50%; z-index:20; width:528px; margin-left:-264px;}
.sticker .hgroup p {margin-top:40px;}
.sticker .twinkle {position:absolute; top:104px; left:50%; z-index:20; margin-left:-299px; animation:twinkle infinite 4s;  animation-delay:2s;}
.sticker .twinkle2 {top:193px; margin-left:-186px; animation:twinkle2 infinite 3s;}
.sticker .twinkle3 {top:138px; margin-left:19px; animation:twinkle3 infinite 3s;}
@keyframes twinkle {
	0% {opacity:0.1;}
	50% {opacity:1;}
	100% {opacity:0.1;}
}
@keyframes twinkle2 {
	0% {opacity:1;}
	50% {opacity:0.1;}
	100% {opacity:2;}
}
@keyframes twinkle3 {
	0% {opacity:0;}
	50% {opacity:1;}
	100% {opacity:0;}
}

.slide {overflow:hidden; position:relative; height:870px; background:#d2a3ef url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/bg_pattern_zigzag_purple.gif) 0 0 repeat;}
.slide .slidesjs-container, .slide .slidesjs-control {overflow:hidden; height:870px !important;}
.slide .slidesjs-slide {height:870px; !important; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/img_slide_01.jpg) no-repeat 50% 0;}
.slide .slidesjs-slide-02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/img_slide_02.jpg);}
.slide .slidesjs-slide-03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/img_slide_03.jpg);}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:51px; left:50%; z-index:50; width:84px; margin-left:-42px;}
.slidesjs-pagination li {float:left; padding:0 9px;}
.slidesjs-pagination li a {display:block; width:10px; height:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/btn_pagination.png) no-repeat 0 0; text-indent:-999em; transition:all 0.5s;}
.slidesjs-pagination li a.active {background-position:0 100%;}

.sticker .event {position:relative; z-index:25; margin-top:-28px; padding-top:28px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/bg_wave.png) 0 0 repeat-x;}
.sticker .event .inner {padding:59px 0 73px; background:#ffe684 url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/bg_pattern_zigzag_light_yellow.gif) 0 0 repeat;}

.instagram {position:relative; padding:68px 0 65px;}
.btnInstagram {position:absolute; top:99px; left:50%; margin-left:472px;}
.instagram ul {overflow:hidden; width:1168px; margin:0 auto; padding-top:35px;}
.instagram ul li {overflow:hidden; float:left; width:262px; margin:15px;}
.instagram ul li img {width:auto; height:262px; transition:transform 1.5s;}
.instagram ul li .id {overflow:hidden; display:block; height:20px; margin-top:10px; padding:0 10px; color:#999; font-family:'Roboto', 'Noto Sans KR', sans-serif; font-size:13px;}
.instagram ul li .id span {color:#954fc2;}
.instagram ul li a:hover img {transform:scale(1.1);}

.pageWrapV15 {margin-top:35px;}
.pageWrapV15 .pageMove {display:none;}
/*.paging a {width:29px; height:29px; margin:0; border:0;}*/
/*.paging a span {height:29px; padding:0; color:#c6c6c6; font-family:Dotum, '돋움', Verdana; line-height:29px;}*/
/*.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}*/
/*.paging .first, .paging .end {display:none;}*/
/*.paging a.arrow span {background:none;}*/
/*.paging a.current span {color:#954fc2; font-weight:bold;}*/
/*.paging .prev, */
/*.paging .next {background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/btn_pagination_nav.png) 0 0 no-repeat;}*/
/*.paging .prev {margin-right:5px;}*/
/*.paging .next {background-position:100% 0;}*/
/*.paging .next {margin-left:10px;}*/

.evtNoti {background:#f8de77 url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/bg_pattern_zigzag_yellow.gif) 0 0 repeat;}
.evtNoti b {color:#ea2626;}
.evtNoti .btn {padding-top:3px; line-height:14px; vertical-align:top;}
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
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<div class="sopum sticker">
							<!-- #include virtual="/event/2017props/head.asp" -->
							<div class="topic">
								<div class="hgroup">
									<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/tit_sticker.png" alt="반짝반짝 스티커" /></h2>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/txt_sticker.png" alt="여러분의 일상소품에 반짝반짝 눈을 붙여 인증샷을 올려주세요! 추첨을 통해 텐바이텐 GIFT카드 1만원을 선물해드립니다! 당첨자 총 50명, 발표 4월 25일" /></p>
								</div>
								<span class="twinkle twinkle1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/img_twinkle_01.png" alt="" /></span>
								<span class="twinkle twinkle2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/img_twinkle_02.png" alt="" /></span>
								<span class="twinkle twinkle3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/img_twinkle_03.png" alt="" /></span>

								<div id="slide" class="slide">
									<div class="slidesjs-slide-01"></div>
									<div class="slidesjs-slide-02"></div>
									<div class="slidesjs-slide-03"></div>
								</div>
							</div>

							<div class="event">
								<div class="inner">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/txt_guide.png" alt="인증샷 이벤트 참여 방법 텐텐 배송 쇼핑하고 반짝반짝 눈 스티커 일상 소품에 붙인 후 필수 해시태그 붙여 인스타그램에 업로드! 필수 해시태그 #텐바이텐 #텐바이텐소품전" usemap="#link" /></p>
									<map name="link" id="link">
										<area shape="rect" coords="334,16,478,218" href="/event/eventmain.asp?eventid=65618" title="빛보다 빠른 텐텐 배송 기획전으로 이동" alt="쇼핑하기" />
									</map>
								</div>
							</div>

							<div class="instagram" id="instagramlist">
								<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
								<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
								<input type="hidden" name="iCTot" value=""/>
								<input type="hidden" name="eCC" value="1">
								</form>
								
								<% if oinstagramevent.fresultcount > 0 then %>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/tit_instagram.png" alt="고객님의 반짝반짝 인증샷" /></h3>
									<div class="btnInstagram"><a href="https://www.instagram.com/your10x10/" title="텐바이텐 공식 인스타그램으로 이동" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77064/btn_instagram.png" alt="텐바이텐 인스타그램 바로가기" /></a></div>
									<ul>
										<% for i = 0 to oinstagramevent.fresultcount-1 %>
											<li>
												<img src="<%= oinstagramevent.FItemList(i).Fimgurl %>" alt="" />
												<span class="id"><span><%=printUserId(left(oinstagramevent.FItemList(i).Fuserid,10),2,"*")%></span>님의 반짝반짝</span>
											</li>
										<% next %>
									</ul>
								<% end if %>

								<div class="pageWrapV15">
									<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,10,"jsGoComPage") %>
								</div>
							</div>

							<div class="evtNoti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>반짝반짝 눈 스티커는 <b>텐바이텐 배송상품</b>과 함께 배송됩니다. <a href="/event/eventmain.asp?eventid=65618" title="빛보다 빠른 텐텐 배송 기획전으로 이동" class="btn btnS3 btnRed lMar05"><span class="whiteArr01 fn">텐바이텐 배송상품 보러가기</span></a></li>
										<li>선착순 한정수량으로 발송되며, 소진 시 미포함될 수 있습니다.</li>
										<li>인스타그램 계정이 비공개 일 경우 이벤트 참여에 제외됩니다.</li>
										<li>이벤트에 참여한 인증샷은 고객 동의 없이 이벤트 페이지 내에 노출될 수 있습니다.</li>
										<li>이벤트 페이지 내에 노출되는 SNS인증샷은 실시간 적용되지 않습니다.</li>
										<li>SNS 이벤트에 참여하였더라도 이벤트 페이지 내에 노출되지 않을 수 있습니다.</li>
										<li>이벤트 페이지 내에 SNS인증샷 노출여부는 이벤트 당첨 여부와 관합니다.</li>
									</ul>
								</div>
							</div>
							<%'!-- sns --%>
							<div class="sns"><%=snsHtml%></div>
							<%'!-- sns --%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->