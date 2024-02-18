<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  2015오픈이벤트 덤&MOOMIN
' History : 2015.04.10 유태욱 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 사월의 꿀 맛 - 덤 &amp; MOOMIN"	'페이지 타이틀 (필수)
	strPageDesc = "당신의 달콤한 쇼핑 라이프를 위해! 사월의 꿀 맛. 무민과 함계 하는 아름다운 사은 이벤트 - 덤 &amp; MOOMIN"		'페이지 설명
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2015/60831/m/txt_gift.png"		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/event/2015openevent/gift.asp"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
 Dim userid : userid = GetLoginUserID()
%>
<style type="text/css">
/* 2015 open event common style */
#eventDetailV15 .gnbWrapV15 {height:38px;}
#eventDetailV15 #contentWrap {padding-top:0; padding-bottom:127px;}
.eventContV15 .tMar15 {margin-top:0;}
.aprilHoney {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_wave.png) repeat-x 50% 0;}
.honeyHead {position:relative; width:1140px; margin:0 auto; text-align:left;}
.honeyHead .hgroup {position:absolute; top:22px; left:0;}
.honeyHead .hgroup p {visibility:hidden; width:0; height:0;}
.honeyHead ul {overflow:hidden; width:656px; margin-left:484px;}
.honeyHead ul li {float:left; width:131px;}
.honeyHead ul li.nav5 {width:132px;}
.honeyHead ul li a {overflow:hidden; display:block; position:relative; height:191px; font-size:11px; line-height:191px; text-align:center;}
.honeyHead ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_nav_12pm.png) no-repeat 0 0;}
.honeyHead ul li.nav1 a:hover span {background-position:0 -191px;}
.honeyHead ul li.nav2 a span {background-position:-131px 0;}
.honeyHead ul li.nav2 a:hover span {background-position:-131px -191px;}
.honeyHead ul li.nav2 a.on span {background-position:-131px 100%;}
.honeyHead ul li.nav3 a span {background-position:-262px 0;}
.honeyHead ul li.nav3 a:hover span {background-position:-262px -191px;}
.honeyHead ul li.nav3 a.on span {background-position:-262px 100%;}
.honeyHead ul li.nav4 a span {background-position:-393px 0;}
.honeyHead ul li.nav4 a:hover span {background-position:-393px -191px;}
.honeyHead ul li.nav4 a.on span {background-position:-393px 100%;}
.honeyHead ul li.nav5 {position:relative;}
.honeyHead ul li.nav5 a span {background-position:100% 0;}
.honeyHead ul li.nav5 a:hover span {background-position:100% -191px;}
.honeyHead ul li.nav5 a.on span {background-position:100% 100%;}
.honeyHead ul li.nav5 .hTag {position:absolute; top:9px; left:77px;}
.honeyHead ul li.nav5:hover .hTag {-webkit-animation-name: bounce; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name: bounce; -moz-animation-iteration-count: infinite; -moz-animation-duration:0.5s; -ms-animation-name: bounce; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function: ease-out;}
	50% {margin-top:8px; -webkit-animation-timing-function: ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function: ease-out;}
	50% {margin-top:8px; animation-timing-function: ease-in;}
}

#eventDetailV15 #contentWrap {padding-bottom:0;}
.honeySection {padding-top:60px; background-color:#fff;}
/* 사은이벤트 */
.honeyGift {background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_belly.png) no-repeat 50% 365px;}
.honeyGift .topic {position:relative; width:1140px; margin:0 auto; padding-bottom:89px;}
.honeyGift .topic h3 {position:relative; z-index:10;}
.honeyGift .topic .dot {position:absolute; top:78px; left:122px; z-index:5;}
.giftarea {position:relative; padding-top:30px; padding-bottom:50px; background:#e2f5ff url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_blue_pattern.png) repeat 0 0;}
.giftarea .bg {position:absolute; width:100%; top:0; left:0; height:1336px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_illust_01.png) repeat-x 50% 0;}
.giftarea .navigator {position:relative; z-index:10; overflow:hidden; width:1140px; margin:0 auto;}
.giftarea .navigator li {float:left; width:372px;}
.giftarea .navigator li a {overflow:hidden; display:block; position:relative; height:474px; font-size:11px; line-height:474px; text-align:center;}
.giftarea .navigator li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_tab.png) no-repeat 0 0;}
.giftarea .navigator li a:hover span, .giftarea .navigator li a.on span {background-position:0 100%;}
.giftarea .navigator li.gift2 a span {background-position:-372px 0;}
.giftarea .navigator li.gift2 a:hover span, .giftarea .navigator li.gift2 a.on span {background-position:-372px 100%;}
.giftarea .navigator li.gift3 a span {background-position:100% 0;}
.giftarea .navigator li.gift3 a:hover span, .giftarea .navigator li.gift3 a.on span  {background-position:100% 100%;}
.giftarea .tabcon {position:relative; z-index:10; padding-bottom:98px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_box_btm.png) no-repeat 50% 100%;}
.giftarea .tabcon .inner {height:674px; padding:12px 19px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_box_top.png) no-repeat 50% 0;}
.giftarea #cont2 .inner {height:772px;}
.slide-wrap {position:relative; width:1080px; margin:0 auto;}
.slide {height:560px;}
.slide img {height:560px;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:54px; height:70px; margin-top:-35px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/btn_nav.png); background-repeat:no-repeat; text-indent:-999em;}
.slide .slidesjs-previous {left:0; background-position:0 0;}
.slide .slidesjs-next {right:0; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:-20px; left:50%; z-index:50; width:92px; margin-left:-46px;}
.slidesjs-pagination li {float:left; padding:0 6px;}
.slidesjs-pagination li a {display:block; width:11px; height:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:100% 0;}
.checkwrap {background:#f3fbff url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_sky_pattern.png) repeat 0 0;}
.check {background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_wave_pattern.png) repeat-x 50% 0;}
.check .inner {position:relative; z-index:10; width:1118px; height:248px; margin:0 auto; padding-top:56px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_box_blue.png) no-repeat 50% 0;}
.check .btnwrap {position:absolute; top:114px; left:601px;}
.check .btnwrap button {position:absolute; top:1px; left:0;background-color:transparent;}
.check .btnwrap .point {position:relative; width:159px; height:57px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_round_box.png) no-repeat 50% 50%; color:#000; font-size:14px; font-family:'Verdana', 'Dotum', '돋움'; font-weight:bold; line-height:57px; text-align:center;}
.check ul {margin-top:63px;}
.check ul li {margin-top:4px;}
.check ul li span {display:inline-block; *display:inline; *zoom:1; padding-left:15px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60830/blt_circle_yellow.png) no-repeat 0 6px; color:#fff; font-size:11px; line-height:1.75em;}

.noti {position:relative; padding-top:47px; padding-bottom:100px; background:#f3fbff url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_sky_pattern.png) repeat 0 0;}
.noti .inner {position:relative; z-index:5; width:1080px; margin:0 auto; text-align:left;}
.noti ul {overflow:hidden; padding-top:33px;}
.noti ul li {float:none; width:auto; margin-top:4px; padding-left:26px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60830/blt_circle_yellow.png) no-repeat 0 6px; color:#555; font-size:11px; line-height:1.75em;}
.noti .bg {position:absolute; width:1920px; top:-80px; left:50%; height:254px; margin-left:-960px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60831/bg_illust_02.png) no-repeat 50% 0;}

/* css3 animation */
.animated {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-fill-mode:both; animation-fill-mode:both;}
@-webkit-keyframes fadeIn {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes fadeIn {
	0% {opacity:0;}
	100% {opacity:1;}
}
.fadeIn {-webkit-animation-name:fadeIn; animation-name:fadeIn; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
</style>
<script type="text/javascript">
$(function(){
	function moveFlower () {
		$(".honeyHead .hgroup h2").animate({"margin-top":"0"},1000).animate({"margin-top":"3px"},1000, moveFlower);
	}
	//moveFlower();
});

function chkmypoint(){
	<% if Not(IsUserLoginOK) then %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% else %>
		$.ajax({
			url: "/event/2015openevent/mypoint_proc.asp",
			cache: false,
			success: function(message) {
				//팝업 호출
				$("#tempdiv").empty().append(message);
				$("#mypoint").empty()
				$("#mypoint").text($("strong#totmypoint").attr("value"));
			}
			,error: function(err) {
				alert(err.responseText);
			}
		});
	<% end if %>
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<!--
				<div class="evtHead snsArea">
					<dl class="evtSelect ftLt">
						<dt><span>이벤트 더보기</span></dt>
						<dd>
							<ul>
								<li><strong>엔조이 이벤트 전체 보기</strong></li>
								<li>나는 모은다 고로 존재한다</li>
								<li>일년 열두달 매고 싶은, 플래그쉽 플래그쉽</li>
								<li>시어버터 보습막을 입자</li>
								<li>전국민 블루투스 키보드</li>
								<li>데스크도 여름 정리가 필요해 필요해 필요해</li>
								<li>지금 놀이터 갈래요!</li>
								<li>ELLY FACTORY</li>
								<li>폴프랭크 카메라</li>
								<li>폴프랭크 카메라</li>
								<li>폴프랭크 카메라</li>
							</ul>
						</dd>
					</dl>
					<div class="ftRt">
						<a href="" class="ftLt btn btnS2 btnGrylight"><em class="gryArr01">브랜드 전상품 보기</em></a>
						<div class="sns lMar10">
							<ul>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
							</ul>
							<div class="favoriteAct myFavor"><strong>123</strong></div>
						</div>
					</div>
				</div> 
				-->
				<div class="eventContV15">
					<div class="contF contW tMar15">
						<!-- 2015 RENEWAL 사월의 꿀 맛 -->
						<div class="aprilHoney">
							<!-- for dev msg : 서브 공통 탑 영역 -->
							<!-- #include virtual="/event/2015openevent/inc_header.asp" --> 

							<!-- 사은이벤트 -->
							<div class="honeySection honeyGift">
								<div class="topic">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/tit_gift.png" alt="무민과 함께하는 아름다운 사은 이벤트 덤&amp;무민" /></h3>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/txt_date.png" alt="5만원 10만원 20만원 이상 구매 시 원하는 사은품을 선택할 수 있어요! 텐바이텐 배송상품 포함 주문시며, 기간은 4월 13일부터 소진시까지입니다." /></p>
									<span class="dot animated fadeIn"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_dot.png" alt="" /></span>
								</div>

								<div class="giftarea">
									<ul class="navigator">
										<li class="gift1"><a href="#cont1"><span></span>5만원 이상 구매시 무민 피규어<br /> 또는 2천 마일리지 선택</a></li>
										<li class="gift2"><a href="#cont2"><span></span>10만원 이상 구매시 무민 카드지갑 또는<br /> 5천 마일리지 선택</a></li>
										<li class="gift3"><a href="#cont3"><span></span>20만원 이상 구매시 무민 3단 도시락, 보존용기 세트<br /> 또는 만 마일리지 선택</a></li>
									</ul>

									<div class="tab-cont">
										<div id="cont1" class="tabcon">
											<div class="inner">
												<p><a href="/shopping/category_prd.asp?itemid=1229782"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/btn_more_01.jpg" alt="무민 피규어 6종 중 랜덤 발송 상세보러 가기" /></a></p>
												<div class="slide-wrap">
													<div id="slide1" class="slide">
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_01_01.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_01_02.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_01_03.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_01_04.jpg" alt="" />
													</div>
												</div>
											</div>
										</div>
										<div id="cont2" class="tabcon">
											<div class="inner">
												<p><a href="/shopping/category_prd.asp?itemid=1239727"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/btn_more_02.jpg" alt="무민 카드지갑 12종 중 랜던 발송 상세보러 가기" /></a></p>
												<div class="slide-wrap">
													<div id="slide2" class="slide">
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_02_01.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_02_02.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_02_03.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_02_04.jpg" alt="" />
													</div>
												</div>
											</div>
										</div>
										<div id="cont3" class="tabcon">
											<div class="inner">
												<p>
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/btn_more_03.jpg" alt="무민 3단 도시락, 보존용기 세트 상세보러 가기" usemap="#link" />
													<map name="link" id="link">
														<area shape="rect" coords="445,10,592,175" href="/shopping/category_prd.asp?itemid=1185799" alt="무민 원형3단 도시락" />
														<area shape="rect" coords="594,10,738,175" href="/shopping/category_prd.asp?itemid=1185800" alt="무민 보존용기 3종세트" />
														<area shape="rect" coords="740,10,890,175" href="/shopping/category_prd.asp?itemid=1185800" alt="무민 보존용기 3종세트" />
													</map>
												</p>
												<div class="slide-wrap">
													<div id="slide3" class="slide">
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_03_01.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_03_02.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_03_03.jpg" alt="" />
														<img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/img_slide_03_04.jpg" alt="" />
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="bg"></div>
								</div>

								<!-- for dev msg : 예상 적립 마일리지 확인하기 -->
								<div class="checkwrap">
									<div class="check">
										<div class="inner">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/txt_check.png" alt="예상 적립 마일리지 확인하기 4월 30일 지금 예정마일리지는" /></p>
											<div class="btnwrap">
												<!-- for dev msg : 확인 전
												<button type="button" id="mypoint" onclick="chkmypoint(); return false;"class="btncheck"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/btn_check.png" alt="확인하기" /></button>
												for dev msg : 확인 후 
												<strong>9,999,999</strong>-->
											
												<div class="point" id="mypoint">
													<button type="button" onclick="chkmypoint(); return false;" class="btncheck"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/btn_check.png" alt="확인하기" /></button>
												</div>
											</div>
											<ul>
												<li><span>고객단순변심에 의한 환불, 교환 시 마일리지는 취소 됩니다.</span></li>
												<li><span>시스템 상 실시간 반영이 되지 않아 최종 마일리지 지급액과 차이가 있을 수 있습니다.</span></li>
											</ul>
										</div>
									</div>
								</div>

								<div class="noti">
									<div class="inner">
										<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60831/tit_way.png" alt="구매금액별 사은품 받는 방법" /></h4>
										<ul>
											<li>텐바이텐 사은 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 증정 불가)</li>
											<li>사은품은 한정수량이므로, 수량이 소진되었을 경우에는 마일리지만 선택이 가능합니다.</li>
											<li>텐바이텐 배송상품을 구매하지 않을 경우, 마일리지받기만 선택 가능합니다.</li>
											<li>마일리지는 4월30일 일괄 지급됩니다. 이벤트 페이지 내의 지급예정마일리지를 참고하세요.</li>
											<li>상품쿠폰, 보너스쿠폰, 할인카드 등의 사용 후 구매확정금액이 5만원/10만원/20만원 이상이어야 합니다.</li>
											<li>마일리지, 예치금, 기프트카드를 사용하신 경우는 구매확정 금액에 포함되어 사은품을 받으 실 수 있습니다.</li>
											<li>한 주문건의 구매금액 기준 이상일 때 증정, 다른 주문에 대한 누적적용이 되지 않습니다.</li>
											<li>선택하신 사은품의 경우 구매하신 텐바이텐 배송 상품과 함께 배송됩니다.</li>
											<li>텐바이텐 기프트카드를 구매하신 경우는 사은품과 사은쿠폰이 증정되지 않습니다.</li>
											<li>환불이나 교환 시 최종 구매 가격이 사은품 수령 가능금액 미만이 될 경우, 사은품과 함께 반품해야 하며, 마일리지 또한 취소됩니다.</li>
										</ul>
									</div>
									<div class="bg"></div>
								</div>
							</div>
						<div id="tempdiv"></div>
						</div>
						<!--// 2015 RENEWAL 사월의 꿀 맛 -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	/* tab */
	$(".giftarea .navigator li a:first").addClass("on");
	$(".giftarea .tab-cont").find(".tabcon").hide();
	$(".giftarea .tab-cont").find(".tabcon:first").show();
	
	if ( $(".giftarea .navigator li.gift1 a").hasClass("on")) {
		rolling1();
	} else {
		$("#slide1").hide();
	}

	$(".giftarea .navigator li a").click(function(){
		$(".giftarea .navigator li a").removeClass("on");
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$(".giftarea .tab-cont").find(".tabcon").hide();
		$(".giftarea .tab-cont").find(thisCont).show();
		return false;
	});

	$(".navigator li.gift1 a").one("click",function(){
		rolling1();
	});
	$(".navigator li.gift2 a").one("click",function(){
		rolling2();
	});
	$(".navigator li.gift3 a").one("click",function(){
		rolling3();
	});

	/* slide js */
	function rolling1() {
		$('#slide1').slidesjs({
			width:"1080",
			height:"560",
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:3500, effect:"fade", auto:true},
			effect:{fade: {speed:1500, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('#slide1').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}

	function rolling2() {
		$('#slide2').slidesjs({
			width:"1080",
			height:"560",
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:3500, effect:"fade", auto:true},
			effect:{fade: {speed:1500, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('#slide2').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}

	function rolling3() {
		$('#slide3').slidesjs({
			width:"1080",
			height:"560",
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:3500, effect:"fade", auto:true},
			effect:{fade: {speed:1500, crossfade:true}
			},
			callback: {
				complete: function(number) {
					var pluginInstance = $('#slide3').data('plugin_slidesjs');
					setTimeout(function() {
						pluginInstance.play(true);
					}, pluginInstance.options.play.interval);
				}
			}
		});
	}
});

var scrollSpeed =22;
	var current = 0;
	var direction = 'h';
	function bgscroll(){
		current -= 1;
		$('.giftarea .bg').css("backgroundPosition", (direction == 'h') ? current+"px 0" : "0 " + current+"px");
	}
	setInterval("bgscroll()", scrollSpeed);
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->