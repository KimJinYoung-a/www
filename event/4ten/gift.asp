<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [2016 정기세일] 사은품
' History : 2016.04.15 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim evt_code

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66107
Else
	evt_code   =  70033
End If

%>
<style type="text/css">
/* 4ten common */
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

.pangpangWrap {background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/bg_gift.png) repeat 0 0;}
div.navigator {border-bottom: 10px solid #77e1cb;}

.pangCont {position:relative; height:2256px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/bg_gift_cloud.jpg) no-repeat 50% 0; z-index:2;}
.pangCont .boomb {position:absolute; left:50%; top:0; width:2200px; height:2256px; margin-left:-1100px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/bg_gift_bomb_02.png) no-repeat 50% 0; z-index:3; animation-name:twinkle; animation-duration:3s; animation-iteration-count:3;}
@keyframes twinkle {
	0% {opacity:0;}
	30% {opacity:0.5;}
	50% {opacity:1;}
	70% {opacity:0.5;}
	100% {opacity:0.8;}
}

.contInner {position:relative; width:1140px; height:662px; margin:0 auto; padding-top:1594px; z-index:4;}
.contInner h1 {position:absolute; left:50%; top:93px; margin-left:-278px;}
.pangGift li {position:absolute;}
.gift1 {left:0; top:336px;}
.gift2 {right:0; top:517px;}
.gift3 {left:124px; top:1000px;}

.giftSlide {position:relative; width:1040px; height:617px; margin:0 auto;}
.giftSlide .swiper-wrapper {height:617px;}
.giftSlide .swiper-slide {float:left;}
.giftSlide .slidesjs-navigation {overflow:hidden; position:absolute; top:50%; width:40px; height:80px; margin-top:-40px; background-repeat:no-repeat; background-color:transparent; text-indent:-999em; outline:none; z-index:10;}
.giftSlide .slidesjs-previous {left:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/btn_rolling_prev.png); background-position:100% 50%; }
.giftSlide .slidesjs-next {right:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/btn_rolling_next.png); background-position:0 50%; }
.giftSlide .slidesjs-pagination {margin-top:20px;}
.giftSlide .slidesjs-pagination li {overflow:hidden; display:inline-block; height:11px; margin:0 5px;}
.giftSlide .slidesjs-pagination li a {overflow:hidden; display:block; width:11px; height:11px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/nav_rolling.png) no-repeat 100% 50%; text-indent:-999em;}
.giftSlide .slidesjs-pagination li a.active {width:30px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/nav_rolling.png) no-repeat 0 50%;}
.giftSlide .cloud1 {position:absolute; left:-147px; top:58px; width:185px; height:118px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/deco_gift_cloud1.png) no-repeat 50% 0; z-index:10; animation:cloud 7s ease-in-out infinite;}
@keyframes cloud {
	0% {margin-left:0;}
	50% {margin-left:50px;}
	100% {margin-left:0;}
}
@keyframes cloud2 {
	0% {margin-right:510px;}
	50% {margin-right:530px;}
	100% {margin-right:510px;}
}

@keyframes balloon1 {
	0% {margin-top:0;}
	50% {margin-top:30px;}
	100% {margin-top:0;}
}
.balloon1 {position:absolute; left:50%; top:1120px; width:169px; height:224px; margin-left:561px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/deco_gift_balloon2.png) no-repeat 0 0; z-index:1; animation:balloon1 5s ease-in-out infinite;}
.cloud2 {position:absolute; right:50%; top:550px; width:190px; height:158px; margin-right:510px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/deco_gift_cloud2.png) no-repeat 0 0; z-index:1; animation:cloud2 4s ease-in-out infinite;}

.noti {background-color:#80eac6; text-align:left;}
.noti .inner {position:relative; width:1140px; margin:0 auto; padding:40px 0;}
.noti .inner h3 {position:absolute; top:50%; left:160px; margin-top:-12px;}
.noti .inner ul {padding-left:340px; color:#1a835f;}
.noti .inner ul li {margin-bottom:2px; padding-left:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/blt_dot.png) no-repeat 0 6px; color:#1a835f; font-family:'Dotum', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti .inner ul li span {color:#ff4f4f;}

.fourtenSns {position:relative; background-color:#d4fff0;}
.fourtenSns button {overflow:hidden; position:absolute; top:40px; left:50%; width:225px; height:70px; background-color:transparent;}
.fourtenSns .ktShare {margin-left:90px;}
.fourtenSns .fbShare {margin-left:325px;}
</style>
<script>
$(function(){
	// full slide
	$('.giftSlide .swiper-wrapper').slidesjs({
		width:1040,
		height:582,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.giftSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});
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

						<%'' 수작업 영역 %>
						<%'' [W] 70033 신난다 팡팡 %>
						<div class="pangpangWrap">
							<!-- #include virtual="/event/4ten/nav.asp" -->
							<div class="pangCont">
								<div class="contInner">
									<h1><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/tit_gift.png" alt="신난다 팡팡" /></h1>
									<ul class="pangGift">
										<li class="gift1"><a href="/shopping/category_prd.asp?itemid=1100763"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/img_gift1.png" alt="4만원 이상 구매 시 미니/미키마우스 얼굴물총 or 1500마일리지" /></a></li>
										<li class="gift2"><a href="/shopping/category_prd.asp?itemid=1371483"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/img_gift2.png" alt="10만원 이상 구매 시 홀리데이 보냉 파우치 or 5000마일리지" /></a></li>
										<li class="gift3"><a href="/shopping/category_prd.asp?itemid=1306357"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/img_gift3.png" alt="40만원 이상 구매 시 이모타니 윙 캐리 큐브 or 2000마일리지" /></a></li>
									</ul>

									<div class="giftSlide">
										<div class="swiper-wrapper">
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/img_gift_rolling1.jpg" alt="" /></div>
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/img_gift_rolling2.jpg" alt="" /></div>
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/img_gift_rolling3.jpg" alt="" /></div>
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/img_gift_rolling4.jpg" alt="" /></div>
										</div>
										<span class="cloud1"></span>
									</div>
								</div>
								<span class="cloud2"></span>
								<span class="balloon1"></span>
								<div class="boomb"></div>
							</div>

							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>텐바이텐 사은 이벤트는 <span>텐바이텐 회원</span>님을 위한 혜택입니다. (비회원 구매 증정 불가)</li>
										<li>텐바이텐 배송상품을 포함해야 사은품 선택이 가능합니다. <a href="/event/eventmain.asp?eventid=68802"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/btn_tenten_delivery.png" alt="텐바이텐 배송상품 보러가기" /></a></li>
										<li>업체배송 상품으로만 구매시 마일리지만 선택 할 수 있습니다.</li>
										<li>상품쿠폰, 보너스쿠폰, 할인카드 등의 사용 후 <span>구매 확정액이 4/10/40만원 이상</span> 이어야 합니다.</li>
										<li>마일리지, 예치금, 기프트카드를 사용하신 경우는 구매확정액에 포함되어 사은품을 받을 수 있습니다.</li>
										<li>텐바이텐 기프트카드를 구매하신 경우는 사은품 증정이 되지 않습니다.</li>
										<li><span>마일리지는 차후 일괄 지급 이며, 1차 : 4/29 (~22일 결제내역 기준) / 2차 : 5/4 (4/23-27일 결제내역 기준) 지급됩니다.</span></li>
										<li>사은품은 텐바이텐 배송 상품과 함께 배송됩니다.</li>
										<li>환불, 교환 시 최종 구매 가격이 사은품 수령 가능 금액 미만일 경우, 사은품과 함께 반품해야 합니다.</li>
										<li>각 상품별 한정 수량으로, 조기 소진 될 수 있습니다.</li>
									</ul>
								</div>
							</div>

							<%
							'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
							Dim vTitle, vLink, vPre, vImg
							
							dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
							snpTitle = Server.URLEncode("[텐바이텐] 터져라 포텐!")
							snpLink = Server.URLEncode("http://www.10x10.co.kr/event/4ten/")
							snpPre = Server.URLEncode("10x10 이벤트")
							
							'기본 태그
							snpTag = Server.URLEncode("텐바이텐")
							snpTag2 = Server.URLEncode("#10x10")
							%>

							<div class="fourtenSns">
								<div class="ftContent">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70033/bnr_fourten_sns.png" alt="친구와 함께 4월의 텐바이텐을 즐기면 기쁜 두배!" /></p>
									<button type="button" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;" class="ktShare"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/btn_white.png" alt="트위터 공유" /></button>
									<button type="button" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;" class="fbShare"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/btn_white.png" alt="페이스북 공유" /></button>
								</div>
							</div>

						</div>

					</div>
					<%'' //event area(이미지만 등록될때 / 수작업일때) %>
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->