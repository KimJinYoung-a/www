<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
'########################################################
' 15주년 이벤트 사은품을 부탁해
' 2016-10-05 이종화
'########################################################

dim eCode 

IF application("Svr_Info") = "Dev" THEN
	eCode = "66214"
Else
	eCode = "73068"
End If

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

strPageTitle	= "[텐바이텐 15th] 사은품을 부탁해"
strPageUrl		= "http://www.10x10.co.kr/event/15th/gift.asp"
strPageImage	= "http://webimage.10x10.co.kr/eventIMG/2016/15th/73068/m/img_kakao.jpg"
strPageDesc = "[텐바이텐] 이벤트 - 구매금액별 사은품 군단을 소개합니다. 선착순증정! 서두르세요!"

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐 15th] 사은품을 부탁해")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/15th/gift.asp")
snpPre		= Server.URLEncode("10x10 15th 이벤트")

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}
.teN15th .tenHeader {position:relative; height:180px; text-align:left; background:#363c7b url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_head.gif) repeat 0 0; z-index:10;}
.teN15th .tenHeader .headCont {position:relative; width:1260px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_star.png) no-repeat 50% 0;}
.teN15th .tenHeader .headCont div {position:relative; width:1140px; height:180px; margin:0 auto;}
.teN15th .tenHeader h2 {padding:25px 0 0 27px;}
.teN15th .tenHeader .navigator {position:absolute; right:0; top:0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_line.gif) no-repeat 100% 50%;}
.teN15th .tenHeader .navigator:after {content:" "; display:block; clear:both;}
.teN15th .tenHeader .navigator li {float:left; width:120px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_line.gif) no-repeat 0 50%;}
.teN15th .tenHeader .navigator li a {display:block; height:180px; background-position:0 0; background-repeat:no-repeat; text-indent:-999em;}
.teN15th .tenHeader .navigator li.nav1 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_01.png);}
.teN15th .tenHeader .navigator li.nav2 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_02.png);}
.teN15th .tenHeader .navigator li.nav3 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_03.png);}
.teN15th .tenHeader .navigator li.nav4 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_04.png);}
.teN15th .tenHeader .navigator li.nav5 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_05.png);}
.teN15th .tenHeader .navigator li.nav6 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_06.png);}
.teN15th .tenHeader .navigator li a:hover {background-position:0 -180px;}
.teN15th .tenHeader .navigator li.current a {height:192px; background-position:0 100%;}
.teN15th .noti {padding:68px 0; text-align:left; border-top:4px solid #d5d5d5; background-color:#eee;}
.teN15th .noti div {position:relative; width:1140px; margin:0 auto;}
.teN15th .noti h4 {position:absolute; left:92px; top:50%; margin-top:-37px;}
.teN15th .noti ul {padding:0 50px 0 310px;}
.teN15th .noti li {color:#666; text-indent:-10px; padding:5px 0 0 10px; line-height:18px;}
.teN15th .shareSns {height:160px; text-align:left; background:#363c7b url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_share.png) repeat 0 0;}
.teN15th .shareSns div {position:relative; width:1140px; margin:0 auto;}
.teN15th .shareSns p {padding:70px 0 0 40px;}
.teN15th .shareSns ul {overflow:hidden; position:absolute; right:40px; top:50px;}
.teN15th .shareSns li {float:left; padding-left:40px;}
.giftMain {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/bg_dark_pink_v02.png) repeat-x 50% 0; height:472px;}
.giftMain {padding-top:34px;}
.giftItems {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/bg_light_pink_v02.png) repeat-x 50% 0; height:1278px; margin-top:-59px;}
.giftItems ul{overflow:hidden; width:1140px; margin:0 auto; padding:60px 0 0 40px;}
.giftItems ul li {float:left; margin:32px;}
.giftItems ul .thirdGift{margin-top:-10px;}
.giftGallery {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/bg_blue_v02.png) repeat-x 50% 0; height:820px; margin-top:-25px; }
.giftGallery .giftImages {padding-top:121px; height:700px;}
.slide {position:relative; width:1140px; margin:0 auto;}
.slide .slidesjs-navigation {position:absolute; top:262px;}
.slide .slidesjs-previous {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_pre.png) no-repeat 50% 0; width:28px; height:48px; text-indent:-999em; left:3%;}
.slide .slidesjs-next {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_next.png) no-repeat 50% 0; width:28px; height:48px; text-indent:-999em; right:3%;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:37px; top:617px; left:50%; z-index:50; width:155x; margin-left:-108px;}
.slidesjs-pagination li {float:left; padding:0 12px;}
.slidesjs-pagination li a {display:block; width:12px; height:12px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/btn_pagination.png) no-repeat 0 0; text-indent:-999em; transition:all 0.5s;}
.slidesjs-pagination li a.active {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/btn_pagination.png) no-repeat 0 0 #999ccb; border-radius:100%;}

</style>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"689",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});
});

function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="ka"){
		alert('잘못된 접속 입니다.');
		return false;
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
						<%' 15주년 이벤트 : sub guide %>
						<div class="teN15th">
							<div class="tenHeader">
								<div class="headCont">
									<div>
										<h2><a href="/event/15th/"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_ten_15th.png" alt="teN15th 텐바이텐의 다양한 이야기" /></a></h2>
										<ul class="navigator">
											<li class="nav1"><a href="/event/15th/">최대 40% 쿠폰 받기 [teN15th]</a></li>
											<li class="nav2"><a href="/event/15th/walkingman.asp">매일 매일 출석체크 [워킹맨]</a></li>
											<li class="nav3"><a href="/event/15th/discount.asp">할인에 도전하라 [비정상할인]</a></li>
											<li class="nav4 current"><a href="/event/15th/gift.asp">팡팡 터지는 구매사은품 [사은품을 부탁해]</a></li>
											<li class="nav5"><a href="/event/15th/sns.asp">영상을 공유하라 [전국 영상자랑]</a></li>
											<li class="nav6"><a href="/event/15th/tv.asp">일상을 담아라 [나의 리틀텔레비전]</a></li>
										</ul>
									</div>
								</div>
							</div>

							<div class="giftMain">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/tit_gift_v02.png" alt="사은품을 부탁해!" /></h3>
							</div>

							<div class="giftItems">
								<ul>
									<li class="firstGift">
										<!-- 상품 sold out시 img_gift_01_sold_out.png 로 이미지 대체  -->
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gift_01.png" alt="6만원 이상 구매시" />
									</li>
									<li>
										<!-- 상품 sold out시 img_gift_03_sold_out_v03.png 로 이미지 대체  -->
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gift_03_v03.png" alt="15만원 이상 구매시" />
									</li>
									<li class="thirdGift">
										<!-- 상품 sold out시 img_gift_02_sold_out_v03.png 로 이미지 대체  -->
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gift_02_sold_out_v03.png" alt="30만원 이상 구매시" />
									</li>
									<li>
										<!-- 상품 sold out시 img_gift_04_sold_out_vo2.png 로 이미지 대체  -->
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gift_04_sold_out_vo2.png" alt="100만원 이상 구매시" />
									</li>
								</ul>
							</div>

							<div class="giftGallery"> 
								<div class="giftImages">
									<div id="slide" class="slide">
										<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gallery_01.png" alt="" /></div>
										<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gallery_02.png" alt="" /></div>
										<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gallery_03.png" alt="" /></div>
										<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gallery_04.png" alt="" /></div>
										<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gallery_05.png" alt="" /></div>
										<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/img_gallery_06.png" alt="" /></div>
									</div>
								</div>
							</div>

							<!-- 이벤트 유의사항 -->
							<div class="noti">
								<div>
									<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_noti.png" alt="이벤트 유의사항" /></h4>
									<ul>
										<li>- 텐바이텐 사은 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 시, 증정 불가)</li>
										<li>- <span class="pruple">텐바이텐 배송상품</span>을 포함해야 사은품 선택이 가능합니다. <span><a href="http://www.10x10.co.kr/event/eventmain.asp?eventid=73440"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/gift/btn_delivery.png" alt="텐바이텐 배송상품 보러가기 >" /></a></span></li>
										<li>- 업체배송 상품으로만 구매시 마일리지만 선택 가능합니다.</li>
										<li>- 상품 쿠폰, 보너스 쿠폰 등의 사용 후 구매 확정액이 <span class="pruple">6/15/30/100만원</span> 이상이어야 합니다. (단일주문건 구매 확정액) 
</li>
										<li>- 마일리지, 예치금, Gift카드를 사용하신 경우에는 구매 확정액에 포함되어 사은품을 받을 수 있습니다.</li>
										<li>- 텐바이텐 Gift카드를 구매하신 경우에는 사은품 증정이 되지 않습니다.</li>
										<li>- 마일리지는 차후 일괄 지급 이며, 1차:10월 21일 (~14일까지 주문내역 기준) / 2차:10월 31일 (10/15~24일까지 주문내역 기준) 지급됩니다.</li>
										<li>- 환불이나 교환 시, 최종 구매가격이 사은품 수령 가능금액 미만일 경우 사은품과 함께 반품해야 합니다.</li>
										<li>- 각 상품별 한정 수량이므로, 조기 소진될 수 있습니다.</li>
									</ul>
								</div>
							</div>

							<%' sns 공유 %>
							<div class="shareSns">
								<div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/txt_share.png" alt="텐바이텐 15주년 이야기, 친구와 함께라면!" /></p>
									<ul>
										<li><a href="" onclick="snschk('fb');return false;" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_facebook.png" alt="텐바이텐 15주년 이야기 페이스북으로 공유" /></a></li>
										<li><a href="" onclick="snschk('tw');return false;" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_twitter.png" alt="텐바이텐 15주년 이야기 트위터로 공유" /></a></li>
									</ul>
								</div>
							</div>
						</div>
						<%' 15주년 이벤트 : sub guide %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>