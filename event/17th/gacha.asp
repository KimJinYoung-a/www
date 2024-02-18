<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 17주년 100원으로 인생역전
' History : 2018-09-27 이종화
'###########################################################
%>
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
#contentWrap {padding:0;}
.evtHead {display:none;}
.ten-life .inner {position:relative; width:1140px; margin:0 auto;}
.ten-life button {background-color:transparent; vertical-align:top; outline:0;}
.lottery {background:#1f91d3 url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/bg_lottery.jpg) no-repeat 50% 31px;}
.lottery h2 {position:relative; padding-top:130px; z-index:2;}
.lottery h2 img {margin-left:127px;}
.lottery i {position:absolute; left:50%; top:142px; margin-left:-345px; animation:bounce .8s infinite; z-index:2;}
@keyframes bounce {from, to {transform:translateY(0); animation-timing-function:ease-out;} 50% {transform:translateY(8px); animation-timing-function:ease-in;}}
.lottery .cont-area {overflow:hidden; margin-top:66px; padding:0 133px 0 171px;}
.lottery .cont-area .ftLt {padding-top:81px;}
.lottery .cont-area .ftRt {overflow:hidden; position:relative; width:340px; height:558px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/bg_product.jpg) no-repeat 0 0;}
#slide1 {position:absolute; top:65px; left:0; width:340px; height:280px;}
.lottery .slideshow div {position:absolute; top:0; left:0; z-index:8; width:100%; opacity:0;}
.lottery .slideshow div.active {z-index:10; opacity:1;}
.lottery .slideshow div.last-active {z-index:9;}
.lottery .round {position:absolute; right:33px; top:114px; width:100px; height:100px;}
.lottery .round img {width:100%;}
.lottery .round span {display:block; position:absolute; left:0; top:0; width:100%; height:0; padding-top:100%; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88940/m/bg_line.png) 0 0 no-repeat; background-size:100%; animation:move1 1.2s infinite cubic-bezier(1,.1,.7,.46);}
@keyframes move1 {from {transform:rotate(0);} to {transform:rotate(360deg);}}
.lottery .btn-schedule {position:absolute; bottom:35px; right:59px; width:222px; height:73px; background-color:transparent; text-indent:-999px; z-index:10;}
.lottery .noti {padding:80px 0; background:#232341;}
.lottery .noti h3 {position:absolute; left:135px; top:50%; margin-top:-14px;}
.lottery .noti ul {padding-left:332px; text-align:left;}
.lottery .noti li {color:#fff; padding:18px 0 0 11px; line-height:16px; font-size:15px; text-indent:-11px; font-family:'malgunGothic', '맑은고딕', sans-serif; letter-spacing:-1px;}
.lottery .noti li:first-child {padding-top:0;}
.layer-popup {display:none; position:absolute; left:0; top:0; z-index:9997; width:100%; height:100%;}
.layer-popup .layer {overflow:hidden; position:fixed; top:0; z-index:99999;}
.layer-popup .layer .btn-close {position:absolute; background:transparent;}
.layer-popup .mask {display:block; position:absolute; left:0; top:0; z-index:9998; width:100%; height:100%; background:rgba(0,0,0,.7);}
#lyrSch .layer {top:50%; left:50%; width:864px; margin-left:-440px; margin-top:-353px; background:#afedff; border:8px solid #0db3e3; border-radius:44px;}
#lyrSch .layer h3 {padding:62px 0 47px;}
#lyrSch .layer .btn-close {top:12px; right:12px; width:70px;}
#lyrSch .layer .btn-close img {width:100%;}
</style>
<script>
function slideSwitch1() {
	var $active = $("#slide1 div.active");
	if ($active.length == 0) $active = $("#slide1 div:last");
	var $next = $active.next().length ? $active.next() : $("#slide1 div:first");
	$active.addClass("last-active");
	$next.css({opacity:0}).addClass("active").animate({opacity:1}, 0, function() {
		$active.removeClass("active last-active").animate({opacity:0}, 0);
	});
}
function slideSwitch2() {
	var $active = $("#slide2 div.active");
	if ($active.length == 0) $active = $("#slide2 div:last");
	var $next = $active.next().length ? $active.next() : $("#slide2 div:first");
	$active.addClass("last-active");
	$next.css({opacity:0}).addClass("active").animate({opacity:1}, 0, function() {
		$active.removeClass("active last-active").animate({opacity:0}, 0);
	});
}
$(function() {
	// amplitude init
	fnAmplitudeEventMultiPropertiesAction('view_17th_100win','','');
	// 이미지 gif
	setInterval(function() {
		slideSwitch1();
		slideSwitch2();
	}, 800);

	// 일정보기
	$('.btn-schedule').click(function(){
		fnAmplitudeEventMultiPropertiesAction('click_17th_100win_schedule','','');
		$('#lyrSch').fadeIn();
	});

	// 레이어닫기
	$('.layer-popup .btn-close').click(function(){
		$('.layer-popup').fadeOut();
	});
	$('.layer-popup .mask').click(function(){
		$('.layer-popup').fadeOut();
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
						<div class="evt89308 ten-life lottery">
							<!-- #include virtual="/event/17th/nav.asp" -->	
							<div class="inner">
								<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/tit_lottery.png" alt="100원으로 인생역전!" /></h2>
								<i><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_badge.png" alt="ONLY APP" /></i>
								<div class="cont-area">
									<p class="ftLt"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_app_download.png" alt="텐바이텐 APP 다운받기" /></p>
									<div class="ftRt">
										<div id="slide1" class="slideshow">
											<div class="active"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_item_1.png" alt="아이폰XS (5.8) 골드 256GB" /></div>
											<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_item_2.png" alt="애플 에어팟" /></div>
											<div><a href="/shopping/category_prd.asp?itemid=1796388&pEtr=89308"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_item_3.png" alt="다이슨 V8 카본 파이버" /></a></div>
											<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_item_4.png" alt="애플워치 시리즈4" /></div>
											<div><a href="/shopping/category_prd.asp?itemid=1865049&pEtr=89308"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_item_5.png" alt="닌텐도 스위치" /></a></div>
											<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_item_6.png" alt="아이패드 프로 256GB" /></div>
										</div>
										<div class="round">
											<div id="slide2" class="slideshow">
												<div class="active"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88940/m/txt_double_1016.png?v=1.0" alt="" /></div>
												<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88940/m/txt_double_1010.png?v=1.0" alt="" /></div>
												<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88940/m/txt_double_1023.png?v=1.0" alt="" /></div>
												<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88940/m/txt_double_1022.png?v=1.0" alt="" /></div>
												<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88940/m/txt_double_1015.png?v=1.0" alt="" /></div>
												<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88940/m/txt_double_1011.png?v=1.0" alt="" /></div>
											</div>
											<span></span>
										</div>
										<button class="btn-schedule">일정 보기</button>
									</div>
								</div>
							</div>

							<%'!-- 일정 보기 레이어 --%>
							<div id="lyrSch" class="layer-popup">
								<div class="layer">
									<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/tit_schedule.png" alt="100원으로 인생역전 상품 일정표" /></h3>
									<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/img_item_list.png?v=1.0" alt="" usemap="#sch" /></p>
									<map name="sch">
										<area shape="rect" coords="377,0,487,200" href="/shopping/category_prd.asp?itemid=1865049&pEtr=89308" target="_self" alt="닌텐도 스위치" />
										<area shape="rect" coords="637,0,747,200" href="/shopping/category_prd.asp?itemid=1804105&pEtr=89308" target="_self" alt="LG전자 시네빔" />
										<area shape="rect" coords="247,220,357,426" href="/shopping/category_prd.asp?itemid=1796388&pEtr=89308" target="_self" alt="다이슨 V8 카본 파이버" />
										<!-- <area shape="rect" coords="377,220,487,426" href="/shopping/category_prd.asp?itemid=2056598&pEtr=89308" target="_self" alt="치후 360 로봇 청소기" /> -->
										<area shape="rect" coords="507,220,617,426" href="/shopping/category_prd.asp?itemid=1596055&pEtr=89308" target="_self" alt="즉석카메라 인화기" />
										<area shape="rect" coords="637,220,747,426" href="/shopping/category_prd.asp?itemid=1555093&pEtr=89308" target="_self" alt="다이슨 헤어드라이어" />
									</map>
									<button type="button" title="닫기" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88940/m/btn_close.png" alt="닫기" /></button>
								</div>
								<div class="mask"></div>
							</div>

							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89308/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>- &lt;100원으로 인생역전&gt;은 매번 다른 상품으로 구성 됩니다. (총 10개)</li>
										<li>- 당첨자에게는 상품에 따라 세무신고에 필요한 개인정보를 요청할 수 있습니다. (제세공과금은 텐바이텐 부담입니다.)</li>
										<li>- 본 이벤트의 상품은 즉시 결제로만 구매할 수 있으며, 배송 후 반품/교환/구매취소가 불가합니다.</li>
										<li>- 본 이벤트는 ID당 하루에 최대 2회 응모 가능합니다.</li>
										<li>- 본 이벤트는 APP전용 이벤트 입니다.</li>
										<li>- <strong>아이폰XS 5.8형 골드(256GB), 애플워치 시리즈4(40mm)상품은 국내 출시 이후에 배송 될 예정입니다.</strong></li>
									</ul>
								</div>
							</div>
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