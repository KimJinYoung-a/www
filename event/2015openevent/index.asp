<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 사월의 꿀 맛"		'페이지 타이틀 (필수)
	strPageDesc = "당신의 달콤한 쇼핑 라이프를 위해! 사월의 꿀 맛."		'페이지 설명
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2015/60829/m/tit_april_honey.gif"		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/event/2015openevent/"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim vUserID : vUserID = GetLoginUserID()
%>
<style type="text/css">
.openEvent2015 .gnbWrapV15 {height:38px;}
.aprilHoney {background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_honey_body.gif) left top repeat;}
.aprilHoney img {vertical-align:top;}
.aprilHoney .item {position:relative; float:left; width:33.33333%; text-align:center;}
.aprilHoney .item a {display:block;}
.aprilHoney .hTag {position:absolute; left:0; top:0;}
.honeyHeadWrap {background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_honey_head.png) left top repeat;}
.honeyHead {position:relative; width:1140px; height:625px; margin:0 auto; padding-top:118px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_yellow.gif) left top no-repeat;}
.honeyHead .deco {overflow:hidden; position:absolute; left:50%; top:0; width:1467px; height:138px; margin-left:-734px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_leaf.png) left top repeat;}
.honeyHead .deco .leaf {display:block; position:absolute; top:-60px; background-repeat:no-repeat; background-position:left top;}
.honeyHead .deco .move01 {left:150px; width:137px; height:192px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/img_deco_leaf01.png);}
.honeyHead .deco .move02 {left:520px; top:-70px; width:116px; height:160px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/img_deco_leaf02.png);}
.honeyHead .deco .move03 {left:825px; top:-50px; width:124px; height:132px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/img_deco_leaf03.png);}
.honeyHead .deco .move04 {right:140px; width:137px; height:192px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/img_deco_leaf01.png);}
.honeyHead .title {position:relative; width:584px; margin:0 auto;}
.honeyHead .title .flower {display:inline-block; position:absolute;}
.honeyHead .title .f01 {left:-55px; top:79px;}
.honeyHead .title .f02 {right:-32px; top:147px;}
.honeyHead .date {padding:5px 0 60px;}
.honeyHead .honeyEvt {width:100%;}
.honeyHead .honeyEvt:after {visibility:hidden; display:block; clear:both; height:0; content:'';}
.honeyHead .honeyEvt .hTag {top:-20px;}
.honeyCont {width:1140px; margin:0 auto; padding:70px 0 80px;}
.honeyCont .onlyAppEvt {width:1010px; margin:0 auto; padding-bottom:70px;}
.honeyCont .onlyAppEvt:after {visibility:hidden; display:block; clear:both; height:0; content:'';}
.honeyCont .onlyAppEvt h3 {float:left; width:472px; padding-top:65px; text-align:left;}
.honeyCont .onlyAppEvt .item {width:266px; height:337px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_dash.gif) right top repeat-y;}
.honeyCont .onlyAppEvt .first:after {content:' '; position:absolute; left:0; top:0; width:1px; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_dash.gif) left top repeat-y;}
.honeyCont .onlyAppEvt .hTag {left:130px; top:-26px;}
.honeyCont .otherEvt {padding:0 52px 40px;}
.honeyCont .otherEvt:after {visibility:hidden; display:block; clear:both; height:0; content:'';}
.honeyCont .otherEvt .hTag {left:45px; top:-23px;}
.honeyCont div.refresh {position:relative; width:100%; float:none; margin-left:-10px;}
.honeyCont .refresh .hTag {left:320px; top:-3px;}

#layerThreeSweets { width:760px; height:830px;}
.sweetCont {position:fixed;  z-index:99999; width:760px; height:830px;}
.sweetCont .goAppDownload {position:absolute; left:50%; bottom:33px; margin-left:-225px; z-index:30;}

.moveTag .hTag {-webkit-animation-name: bounce; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name: bounce; -moz-animation-iteration-count: infinite; -moz-animation-duration:0.5s; -ms-animation-name: bounce; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function: ease-out;}
	50% {margin-top:8px; -webkit-animation-timing-function: ease-in;}
}
@-moz-keyframes bounce {
	from, to{margin-top:0; -moz-animation-timing-function: ease-out;}
	50% {margin-top:8px; -moz-animation-timing-function: ease-in;}
}
@-ms-keyframes bounce {
	from, to{margin-top:0; -ms-animation-timing-function: ease-out;}
	50% {margin-top:8px; -ms-animation-timing-function: ease-in;}
}

.honeyHead .deco .move01 {-webkit-animation: swinging 30s ease-in-out 0s infinite; -moz-animation: swinging 30s ease-in-out 0s infinite;  -ms-animation: swinging 30s ease-in-out 0s infinite;}
.honeyHead .deco .move02 {-webkit-animation: swinging 55s ease-in-out 0s infinite; -moz-animation: swinging 55s ease-in-out 0s infinite; -ms-animation: swinging 55s ease-in-out 0s infinite;}
.honeyHead .deco .move03 {-webkit-animation: swinging 40s ease-in-out 0s infinite; -moz-animation: swinging 40s ease-in-out 0s infinite; -ms-animation: swinging 40s ease-in-out 0s infinite;}
.honeyHead .deco .move04 {-webkit-animation: swinging 50s ease-in-out 0s infinite; -moz-animation: swinging 50s ease-in-out 0s infinite; -ms-animation: swinging 50s ease-in-out 0s infinite;}
@-webkit-keyframes swinging {
	0% { -webkit-transform: rotate(0); }
	10% { -webkit-transform: translate(10px,0px) rotate(-5deg); }
	15% { -webkit-transform: translate(-15px,0px) rotate(5deg); }
	20% { -webkit-transform: translate(15px,0px) rotate(-6deg); }
	30% { -webkit-transform: translate(15px,0px) rotate(-4deg); }
	40% { -webkit-transform: translate(5px,0px) rotate(-2deg); }
	100% { -webkit-transform: rotate(0); }
}
@-moz-keyframes swinging {
	0% { -moz-transform: rotate(0); }
	10% { -moz-transform: translate(10px,0px) rotate(-5deg); }
	15% { -moz-transform: translate(-15px,0px) rotate(5deg); }
	20% { -moz-transform: translate(15px,0px) rotate(-6deg); }
	30% { -moz-transform: translate(15px,0px) rotate(-4deg); }
	40% { -moz-transform: translate(5px,0px) rotate(-2deg); }
	70% { -moz-transform: translate(0px,0px) rotate(0); }
	100% { -moz-transform: rotate(0); }
}
@-ms-keyframes swinging {
	0% { -ms-transform: rotate(0); }
	10% { -ms-transform: translate(10px,0px) rotate(-5deg); }
	15% { -ms-transform: translate(-15px,0px) rotate(5deg); }
	20% { -ms-transform: translate(15px,0px) rotate(-6deg); }
	30% { -ms-transform: translate(15px,0px) rotate(-4deg); }
	40% { -ms-transform: translate(5px,0px) rotate(-2deg); }
	70% { -ms-transform: translate(0px,0px) rotate(0); }
	100% { -ms-transform: rotate(0); }
}
</style>
<script type="text/javascript">
$(function(){
	function moveFlower () {
		$(".title .f01").animate({"margin-top":"0"},1500).animate({"margin-top":"5px"},1500, moveFlower);
		$(".title .f02").animate({"margin-top":"0"},1100).animate({"margin-top":"7px"},1100, moveFlower);
	}
	moveFlower();

	$('.item').mouseover(function() {
		$(this).addClass('moveTag');
	});
	$('.item').mouseleave(function() {
		$(this).removeClass('moveTag');
	});
});

function jsDownCoupon(stype,idx){
<% IF IsUserLoginOK THEN %>
var frm;
	frm = document.frmC;
	frm.action = "/shoppingtoday/couponshop_process.asp";
	frm.stype.value = stype;	
	frm.idx.value = idx;	
	frm.submit();
<%ELSE%>
	if(confirm("로그인하시겠습니까?")) {
		parent.location="/login/loginpage.asp?backpath=/event/2015openevent/";
	}
<%END IF%>
}

var scrollSpeed =22;
var current = 0;
var direction = 'h';
function bgscroll(){
	current -= 1;
	$('.honeyHeadWrap').css("backgroundPosition", (direction == 'h') ? current+"px 0" : "0 " + current+"px");
}
setInterval("bgscroll()", scrollSpeed);
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap openEvent2015">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap" style="padding-top:0; padding-bottom:0;">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<div class="aprilHoney">
							<!-- 셋콤달콤 레이어(0410추가) -->
							<div id="layerThreeSweets" style="display:none">
								<div class="sweetCont">
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/img_three_sweets.gif" alt="셋콤 달콤" /></div>
									<p class="goAppDownload"><a href="/event/appdown/" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/btn_app_download.png" alt="텐바이텐 APP 다운로드" /></a></p>
									<p class="lyrClose" onclick="ClosePopLayer();"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/btn_layer_close.png" alt="닫기" /></p>
								</div>
							</div>
							<!--// 셋콤달콤 레이어 -->
							<div class="honeyHeadWrap">
								<div class="honeyHead">
									<div class="deco">
										<span class="leaf move01"></span>
										<span class="leaf move02"></span>
										<span class="leaf move03"></span>
										<span class="leaf move04"></span>
									</div>
									<div class="title">
										<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tit_april_honey.gif" alt="당신의 꿀맛같은 쇼핑을 위해! 사월의 꿀 맛" /></h2>
										<span class="flower f01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/img_deco_flower01.png" alt="" /></span>
										<span class="flower f02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/img_deco_flower02.png" alt="" /></span>
									</div>
									<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/txt_period.gif" alt="이벤트 기간:02.13~04.24(12days)" /></p>
									<div class="honeyEvt">
										<div class="item">
											<a href="" onclick="jsDownCoupon('prd,prd,prd,prd','10144,10147,10148,10149'); return false;">
												<span class="hTag" style="left:245px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_coupon.png" alt="쿠폰 받고" /></span>
												<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_coupon.png" alt="꿀 맛 쿠폰" />
											</a>
										</div>
										<div class="item">
											<a href="mileage.asp" target="_top">
												<span class="hTag" style="left:210px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_mileage.png" alt="마일리지 받고" /></span>
												<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_mileage.png" alt="삼시세번" />
											</a>
										</div>
										<div class="item">
											<a href="gift.asp" target="_top">
												<span class="hTag" style="left:180px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_gift.png" alt="사은품 받고" /></span>
												<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_gift.png" alt="덤&amp;무민" />
											</a>
										</div>
									</div>
								</div>
							</div>
							<div class="honeyCont">
								<div class="onlyAppEvt">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tit_mobile_honey.png" alt="손 안에서 만나는 모바일 꿀맛 - 텐바이텐 APP에서만 참여할 수 있는 특별한 이벤트를 둘러보세요!" /></h3>
									<div class="item first">
										<a href="get.asp" target="_top">
											<span class="hTag"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_app_only.png" alt="APP ONLY" /></span>
											<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_get_item_12pm.png" alt="쫄깃한 특템" />
										</a>
									</div>
									<div class="item">
										<a href="#" onclick="viewPoupLayer('modal',$('#layerThreeSweets').html());return false;" target="_top">
											<span class="hTag"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_app_only.png" alt="APP ONLY" /></span>
											<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_promotion.png" alt="셋콤달콤" />
										</a>
									</div>
								</div>
								<div class="otherEvt">
									<div class="item">
										<a href="daily.asp" target="_top">
											<span class="hTag"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_apply.png" alt="참여" /></span>
											<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_sticker.png" alt="꿀맛! 일상다반사" />
										</a>
									</div>
									<div class="item">
										<a href="vipgift.asp" target="_top">
											<span class="hTag"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_for_vip.png" alt="for VIP" /></span>
											<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_vip.png" alt="단지 널 사랑해" />
										</a>
									</div>
									<div class="item">
<% If Now() > #04/12/2015 00:00:00# AND Now() < #04/16/2015 23:59:59# Then %>
<a href="/culturestation/culturestation_event.asp?evt_code=2856" target="_top">
	<span class="hTag"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_apply.png" alt="참여" /></span>
	<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_culture01.png" alt="맛있는 컬쳐스테이션 - 뮤지컬 아가사" />
</a>
<% ElseIf Now() > #04/17/2015 00:00:00# AND Now() < #04/19/2015 23:59:59# Then %>
<a href="/culturestation/culturestation_event.asp?evt_code=2849" target="_top">
	<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_culture02.png" alt="맛있는 컬쳐스테이션 - 뮤지컬 로빈훗" />
</a>
<% ElseIf Now() > #04/20/2015 00:00:00# Then %>
<a href="/culturestation/culturestation_event.asp?evt_code=2857" target="_top">
	<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_culture03.png" alt="맛있는 컬쳐스테이션 - 뮤지컬 팬텀" />
</a>
<% End If %>
									</div>
								</div>
								<div class="refresh item">
									<a href="refresh.asp" target="_top">
										<span class="hTag"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tag_apply.png" alt="참여" /></span>
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/bnr_refresh.png" alt="텐바이텐 PC웹사이트 리뉴얼! 축하 코멘트 남기고 마일리지 받아요" />
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form name="frmC" method="get" action="/shoppingtoday/couponshop_process.asp" style="margin:0px;">
	<input type="hidden" name="stype" value="">
	<input type="hidden" name="idx" value="">
	</form>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->