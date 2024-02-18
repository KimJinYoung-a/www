<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'########################################################
' PLAY FLOWER WEEK
' 2015-04-30 한용민 작성
'########################################################
%>
<%
Dim eCode, userid
IF application("Svr_Info") = "Dev" THEN
	eCode   =  61772
Else
	eCode   =  62188
End If

userid = getloginuserid()

dim currenttime
	currenttime =  now()
	'currenttime = #05/06/2015 09:00:00#
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundHeadWrap {width:100%; background:#f3ece7 url(http://webimage.10x10.co.kr/play/ground/20150504/bg_top.jpg) no-repeat 50% 0 !important; background-size:1920px 260px !important;}
.groundCont {background-color:#faf5ee;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:42px 20px 50px;}
img {vertical-align:top;}

/* iframe */
img {vertical-align:top;}
.playGr20150504 {}
.playGr20150504 .inner {width:1140px; margin:0 auto;}

.topic {overflow:hidden; position:relative; height:530px; background-color:#f3f2ef;}
.topic .inner {position:relative; height:530px;}
.topic h1 {position:absolute; top:127px; left:19px; z-index:5;}
.topic h1 span {display:block; width:680px; background:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_txt_topic.png) no-repeat 0 0; font-size:0;}
.topic h1 .letter1 {height:102px;}
.topic h1 .letter2 {height:102px; background-position:0 -102px;}
.topic p {position:absolute; top:332px; left:19px; z-index:5; width:680px; height:34px; background:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_txt_topic.png) no-repeat 0 -205px; font-size:0;}
.topic .bg {position:absolute; width:1920px; height:530px; top:0; left:50%; margin-left:-960px; background:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_flower_bunch_01.jpg) no-repeat 50% 0;}
.topic .blur {filter:blur(5px); -webkit-filter:blur(5px); -moz-filter: blur(5px); -o-filter:blur(5px); -ms-filter:blur(5px);}

.present {height:900px; background:#fbf7f3 url(http://webimage.10x10.co.kr/play/ground/20150504/bg_flower_bunch_02.jpg) no-repeat 50% 0;}
.present h2 {padding-top:122px; padding-left:56px;}
.present .desc {width:580px; margin-top:-10px; margin-left:520px; padding-top:24px; border-top:1px solid #cbcbcb;}
.present .desc p {margin-top:26px;}
.present .desc .delivery {margin-top:64px;}
.present .blur {filter:blur(3px); -webkit-filter:blur(3px); -moz-filter: blur(3px); -o-filter:blur(3px); -ms-filter:blur(3px);}

.meet {height:340px; background:#ff8d87 url(http://webimage.10x10.co.kr/play/ground/20150504/bg_pattern_pink.png) repeat-x 0 0;}
.meet .inner {position:relative; height:340px; background:#ff8d87 url(http://webimage.10x10.co.kr/play/ground/20150504/bg_pattern_pink_fix.png) no-repeat 50% 0; text-align:center;}
.meet .inner h2 {padding-top:70px;}
.meet .inner p {margin-top:26px;}
.meet .btnmove {margin-top:26px;}
.meet .mobile {position:absolute; top:93px; right:57px; width:124px;}
.meet .mobile .heart {position:absolute; top:15px; right:13px;}
.meet .mobile .down {position:absolute; top:66px; left:18px;}

.flower {background-image:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_shadow.png); background-repeat:repeat-x; background-position:50% 100%;}
.flower .inner {padding:110px 0 120px;}
.flower h2 {padding-left:9px;}
.flower .article {overflow:hidden; padding-top:60px;}
.flower .article .preview, .flower .article .desc {float:left;}
.flower .article .preview {overflow:hidden; width:618px; padding-left:36px;}
.flower .article .desc {width:486px;}
.flower .article .preview span:first-child {padding-right:26px;}
.flower .article .preview span {float:left;}
.flower .article .desc {padding-top:12px;}
.downlist {overflow:hidden; width:460px; margin-top:94px; padding:20px 0 8px; border-top:1px solid #f2e1da; border-bottom:1px solid #f2e1da;}
.downlist ul {float:left;}
.downlist ul.iphone {width:240px;}
.downlist ul.galaxy {width:220px;}
.downlist ul li {margin-bottom:12px;}
.downlist ul li a {overflow:hidden; display:block; position:relative; padding:0 45px 0 15px; background:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_btn_down_01.png) no-repeat 0 0; color:#fff; font-family:'Verdana', 'Dotum'; line-height:24px; -webkit-font-smoothing:none;}
.downlist ul.iphone li a {width:140px; height:24px;}
.downlist ul.iphone li a strong {width:85px;}
.downlist ul.iphone li em {width:55px;}
.downlist ul.galaxy li a {width:160px; height:24px; background-position:0 100%;}
.downlist ul.galaxy li a strong {width:95px;}
.downlist ul.galaxy li em {width:65px;}

.downlist ul li a:hover {text-decoration:none;}
.downlist ul li a strong {float:left;}
.downlist ul li a em {float:left; color:#fedcd4; font-size:10px; text-align:right;}
.downlist ul li a span {position:absolute; top:8px; right:15px; width:9px; height:9px; background:url(http://webimage.10x10.co.kr/play/ground/20150504/blt_down.png) no-repeat 50% 0;}
.downlist ul li a:hover span {-webkit-animation-fill-mode:both; animation-fill-mode:both; -webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:flash; animation-name:flash; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}

.byMobile {position:relative; height:36px; padding:13px 24px 0 0; text-align:right;}
.byMobile a {position:relative; line-height:36px; color:#f2836a; vertical-align:middle; text-decoration:none; cursor:pointer;}
.byMobile a em {*display:inline; zoom:1; padding-right:40px;}
.byMobile a span {position:absolute; top:3px; right:43px; width:25px; height:5px; background:url(http://webimage.10x10.co.kr/play/ground/20150504/blt_arrow_01.png) no-repeat 50% 0;}
.byMobile a span {*top:13px;}
.byMobile a span {-webkit-animation-fill-mode:both; animation-fill-mode:both; -webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:flash; animation-name:flash; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
.byMobile .qrcode {position:absolute; bottom:35px; right:3px;}

.monday {background-color:#fefaf8;}
.tueday {background-color:#fffef6;}
.tueday .article .preview {float:right; width:578px; padding-left:40px;}
.tueday .article .desc {width:486px; padding-left:36px;}
.tueday .byMobile a {color:#ff8a00;}
.tueday .downlist ul li a {background-image:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_btn_down_02.png);}
.tueday .downlist ul li a em {color:#ffeaac;}
.wednesday {background-color:#f8fcee;}
.wednesday .byMobile a {color:#87b904;}
.wednesday .byMobile a span {background-image:url(http://webimage.10x10.co.kr/play/ground/20150504/blt_arrow_03.png);}
.wednesday .downlist {border-color:#e5ecd2;}
.wednesday .downlist ul li a {background-image:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_btn_down_03.png);}
.wednesday .downlist ul li a em {color:#e4f9ae;}
.thursday {background-color:#fff9fa;}
.thursday .article .preview {float:right; width:578px; padding-left:40px;}
.thursday .article .desc {width:486px; padding-left:36px;}
.thursday .byMobile a {color:#f97393;}
.thursday .byMobile a span {background-image:url(http://webimage.10x10.co.kr/play/ground/20150504/blt_arrow_04.png);}
.thursday .downlist {border-color:#f2dade;}
.thursday .downlist ul li a {background-image:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_btn_down_04.png);}
.thursday .downlist ul li a em {color:#ffd9e2;}
.friday {background-color:#faf3fb;}
.friday .byMobile a {color:#b986c1;}
.friday .byMobile a span {background-image:url(http://webimage.10x10.co.kr/play/ground/20150504/blt_arrow_05.png);}
.friday .downlist {border-color:#f2dade;}
.friday .downlist ul li a {background-image:url(http://webimage.10x10.co.kr/play/ground/20150504/bg_btn_down_05.png);}
.friday .downlist ul li a em {color:#f5daf9;}

.coming ul li {text-align:center;}
.coming ul li.onTue {background-color:#fffef6;}
.coming ul li.onWed{background-color:#eff4e2;}
.coming ul li.onThu{background-color:#fff9fa;}
.coming ul li.onFri {background-color:#f8f3f9;}

.screensaver {padding:135px 0 55px ; border-top:6px solid #dcd1c6; background-color:#faf5ee;}
.screensaver .msg {position:relative; padding-bottom:200px; padding-left:80px;}
.screensaver .msg p {width:420px; margin-top:32px; padding-top:28px; padding-left:6px; border-top:1px solid #e4ddd2;}

.mycomputer {position:absolute; top:-25px; right:65px; width:508px; height:415px;}
.mycomputer .rolling {width:386px; height:362px; padding:14px 13px 0; background:url(http://webimage.10x10.co.kr/play/ground/20150504/img_mac.png) no-repeat 50% 0;}
.mycomputer .btndown {position:absolute; right:0; bottom:0; z-index:50;}

.screensaver .about {position:relative; text-align:center;}
.screensaver .about .btnbrand {position:absolute; top:60px; right:80px;}
.screensaver .about a:hover .btnbrand {-webkit-animation-name:updown; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name: updown; -moz-animation-iteration-count: infinite; -moz-animation-duration:0.5s; -ms-animation-name: updown; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes updown {
	from, to{margin-top:0; -webkit-animation-timing-function: ease-out;}
	50% {margin-top:8px; -webkit-animation-timing-function: ease-in;}
}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function: ease-out;}
	50% {margin-top:8px; animation-timing-function: ease-in;}
}

.animated {-webkit-animation-fill-mode:both; animation-fill-mode:both;}
/* Bounce animation */
@-webkit-keyframes bounce {
	0%, 20%, 50%, 80%, 100% {-webkit-transform: translateY(0);}
	40% {-webkit-transform: translateY(-10px);}
	60% {-webkit-transform: translateY(-5px);}
}
@keyframes bounce {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-10px);}
	60% {transform: translateY(-5px);}
}
.bounce {-webkit-animation-duration:5s; animation-duration:5s; -webkit-animation-name:bounce; animation-name:bounce; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
/* flash animation */
@-webkit-keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
.flash {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:flash; animation-name:flash; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
</style>
</head>
<body>

<!-- iframe -->
<div class="playGr20150504">
	<div class="topic">
		<div class="inner">
			<h1>
				<span class="letter1">꽃으로</span>
				<span class="letter2">더 행복해지는 일주일</span>
			</h1>
			<p>PLAY HITCHHIKER</p>
		</div>
		<div class="bg"></div>
	</div>

	<div class="present">
		<div class="inner">
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20150504/tit_present.png" alt="우리의 꽃을 받아주세요" /></h2>
			<div class="desc">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_present_01.png" alt="꽃을 눈으로 보고, 코로 향기를 맡고 손으로 만지는 것만으로도 스트레스가 완화되고, 심신의 안정을 되찾고 유지해주는 것을 플라워 테라피라고 해요.그만큼 꽃의 다채로운 빛깔, 아름다운 모양, 싱그러운 향기는 마음뿐만 아니라 몸에도 좋은 영향을 미친다는 뜻이겠죠?" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_present_02.png" alt="텐바이텐 플레이에서는 이러한 꽃을 매일 하나씩 일주일 동안 당신께 선물하려고 합니다! 비록 향기를 맡거나 손으로 직접 만질 수는 없지만, 당신과 늘 가까이 있는 휴대폰, 컴퓨터에 우리가 준비한 꽃을 받아 주세요." /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_present_03.png" alt="이 꽃으로 인해 당신의 일주일이 조금 더 행복해지기를 바랍니다. " /></p>
				<p class="delivery"><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_present_04.png" alt="선물을 드려요. 텐바이텐 PLAY가 드리는 월, 화, 수, 목, 금의 모바일 배경화면을 모두 다운받으신 분들 중 추첨을 통해 5분께는 꽃 바구니를 배달해 드립니다. 기간은 2015년 5월 4일부터 5월 10일까지며 당첨자 발표는 2015년 5월 12일입니다." /></p>
			</div>
		</div>
	</div>

	<div class="meet">
		<div class="inner">
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20150504/tit_meet.png" alt="우리가 준비한 꽃을 매일 만나보세요. 모바일 배경화면 + 친구에게 보내는 플라워 카드" /></h2>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_meet.png" alt="텐바이텐이 드리는 꽃 배경화면을 다운 받아 하나는 나의 휴대폰에 하나는 친구에게 응원의 메시지를 보내 보세요! 5일 동안 매일 하루에 하나씩 여러분을 위한 꽃 선물이 열립니다. " /></p>
			<div class="btnmove"><a href="#screensaver"><img src="http://webimage.10x10.co.kr/play/ground/20150504/btn_move_screensaver.png" alt="스크린세이버도 준비햇어요" /></a></div>
			<div class="mobile">
				<img src="http://webimage.10x10.co.kr/play/ground/20150504/img_mobile.png" alt="" />
				<span class="animated flash heart"><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_heart.png" alt="" /></span>
				<span class="animated bounce down"><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_down.png" alt="" /></span>
			</div>
		</div>
	</div>

	<% if left(currenttime,10)>="2015-05-08" then %>
		<div class="friday flower">
			<div class="inner">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150504/tit_flower_of_friday.png" alt="5월 8일 금요일의 꽃" /></h2>
				<div class="article">
					<div class="preview">
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_friday_01.png" alt="미스티블루" /></span>
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_friday_02.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_flower_of_friday.png" alt="고생한 당신에게 주어지는 소중한 시간. 오직 당신을 위한 일들로 주말을 보내세요. 즐거운 추억을 만들어 줄 금요일의 꽃 깜짝 놀랄 좋은 일이 당신에게 생기길!" /></p>
						<div class="downlist">
							<ul class="iphone">
								<li><a href="" onclick="fileDownload('3452'); return false;"><strong>iPhone 6</strong><em>750x1334</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3453'); return false;"><strong>iPhone 6+</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3454'); return false;"><strong>iPhone 5</strong><em>640x1136</em><span></span></a></li>
							</ul>
							<ul class="galaxy">
								<li><a href="" onclick="fileDownload('3455'); return false;"><strong>Galaxy S5</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3456'); return false;"><strong>Galaxy Edge</strong><em>2560x1440</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3457'); return false;"><strong>Galaxy Note3</strong><em>800x1280</em><span></span></a></li>
							</ul>
						</div>
						<div class="byMobile">
							<a href="http://m.10x10.co.kr/play/playGround.asp?idx=20&contentsidx=82" target="_blank"><em>스마트폰으로 다운받기</em><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150504/ico_mobile_05.png" alt="" /></a>
							<div class="qrcode"><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_qr.png" alt="QR코드" /></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<% end if %>

	<% if left(currenttime,10)>="2015-05-07" then %>
		<!-- 5/5 thu -->
		<div class="thursday flower">
			<div class="inner">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150504/tit_flower_of_thursday.png" alt="5월 7일 목요일의 꽃" /></h2>
				<div class="article">
					<div class="preview">
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_thursday_01.png" alt="작약" /></span>
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_thursday_02.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_flower_of_thursday.png" alt="피로 가득 오늘은 몸과 마음의 릴렉스가 필요한 날. 조용한 시간을 내어 한 주를 정리하세요. 향기로운 목요일의 꽃 당신에게 내 사랑을 가득 담아 보냅니다" /></p>
						<div class="downlist">
							<ul class="iphone">
								<li><a href="" onclick="fileDownload('3434'); return false;"><strong>iPhone 6</strong><em>750x1334</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3435'); return false;"><strong>iPhone 6+</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3436'); return false;"><strong>iPhone 5</strong><em>640x1136</em><span></span></a></li>
							</ul>
							<ul class="galaxy">
								<li><a href="" onclick="fileDownload('3437'); return false;"><strong>Galaxy S5</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3438'); return false;"><strong>Galaxy Edge</strong><em>2560x1440</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3439'); return false;"><strong>Galaxy Note3</strong><em>800x1280</em><span></span></a></li>
							</ul>
						</div>
						<div class="byMobile">
							<a href="http://m.10x10.co.kr/play/playGround.asp?idx=20&contentsidx=82" target="_blank"><em>스마트폰으로 다운받기</em><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150504/ico_mobile_04.png" alt="" /></a>
							<div class="qrcode"><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_qr.png" alt="QR코드" /></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<% end if %>

	<% if left(currenttime,10)>="2015-05-06" then %>
		<div class="wednesday flower">
			<div class="inner">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150504/tit_flower_of_wednesday.png" alt="5월 6일 수요일의 꽃" /></h2>
				<div class="article">
					<div class="preview">
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_wednesday_01.png" alt="퐁퐁소국" /></span>
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_wednesday_02.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_flower_of_wednesday.png" alt="남은 요일을 위해 충전이 필요한 날 내가 가장 좋아하는 일을 하세요. 행복의 기운 가득한 수요일의 꽃" /></p>
						<div class="downlist">
							<ul class="iphone">
								<li><a href="" onclick="fileDownload('3416'); return false;"><strong>iPhone 6</strong><em>750x1334</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3417'); return false;"><strong>iPhone 6+</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3418'); return false;"><strong>iPhone 5</strong><em>640x1136</em><span></span></a></li>
							</ul>
							<ul class="galaxy">
								<li><a href="" onclick="fileDownload('3419'); return false;"><strong>Galaxy S5</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3420'); return false;"><strong>Galaxy Edge</strong><em>2560x1440</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3421'); return false;"><strong>Galaxy Note3</strong><em>800x1280</em><span></span></a></li>
							</ul>
						</div>
						<div class="byMobile">
							<a href="http://m.10x10.co.kr/play/playGround.asp?idx=20&contentsidx=82" target="_blank"><em>스마트폰으로 다운받기</em><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150504/ico_mobile_03.png" alt="" /></a>
							<div class="qrcode"><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_qr.png" alt="QR코드" /></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<% end if %>

	<% if left(currenttime,10)>="2015-05-05" then %>
		<div class="tueday flower">
			<div class="inner">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150504/tit_flower_of_tueday.png" alt="5월 5일 화요일의 꽃" /></h2>
				<div class="article">
					<div class="preview">
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_tueday_01.png" alt="카라" /></span>
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_tueday_02.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_flower_of_tueday.png" alt="아주 잠깐이라도 시간을 내어 나만의 방식으로 여유를 느끼는 날이 되세요. 당신에게 생기를 불어넣어 줄 화요일의 꽃 잘하고 있어요! 그러니 기운내기!" /></p>
						<div class="downlist">
							<ul class="iphone">
								<li><a href="" onclick="fileDownload('3398'); return false;"><strong>iPhone 6</strong><em>750x1334</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3399'); return false;"><strong>iPhone 6+</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3400'); return false;"><strong>iPhone 5</strong><em>640x1136</em><span></span></a></li>
							</ul>
							<ul class="galaxy">
								<li><a href="" onclick="fileDownload('3401'); return false;"><strong>Galaxy S5</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3402'); return false;"><strong>Galaxy Edge</strong><em>2560x1440</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3403'); return false;"><strong>Galaxy Note3</strong><em>800x1280</em><span></span></a></li>
							</ul>
						</div>
						<div class="byMobile">
							<a href="http://m.10x10.co.kr/play/playGround.asp?idx=20&contentsidx=82" target="_blank"><em>스마트폰으로 다운받기</em><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150504/ico_mobile_02.png" alt="" /></a>
							<div class="qrcode"><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_qr.png" alt="QR코드" /></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<% end if %>

	<% if left(currenttime,10)>="2015-05-04" then %>
		<div class="monday flower">
			<div class="inner">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150504/tit_flower_of_monday.png" alt="5월 4일 월요일의 꽃" /></h2>
				<div class="article">
					<div class="preview">
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_monday_01.png" alt="" /></span>
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_flower_of_monday_02.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_flower_of_monday.png" alt="월요병으로 정신없고 고된 하루지만, 붉은 열정을 담아 응원합니다. 당신의 숨어 있는 에너지를 충전해 줄 월요일의 꽃 고마운 당신이 있기에 오늘도 힘이 납니다." /></p>
						<div class="downlist">
							<ul class="iphone">
								<li><a href="" onclick="fileDownload('3380'); return false;"><strong>iPhone 6</strong><em>750x1334</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3381'); return false;"><strong>iPhone 6+</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3382'); return false;"><strong>iPhone 5</strong><em>640x1136</em><span></span></a></li>
							</ul>
							<ul class="galaxy">
								<li><a href="" onclick="fileDownload('3383'); return false;"><strong>Galaxy S5</strong><em>1080x1920</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3384'); return false;"><strong>Galaxy Edge</strong><em>2560x1440</em><span></span></a></li>
								<li><a href="" onclick="fileDownload('3385'); return false;"><strong>Galaxy Note3</strong><em>800x1280</em><span></span></a></li>
							</ul>
						</div>
						<div class="byMobile">
							<a href="http://m.10x10.co.kr/play/playGround.asp?idx=20&contentsidx=82" target="_blank"><em>스마트폰으로 다운받기</em><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150504/ico_mobile_01.png" alt="" /></a>
							<div class="qrcode"><img src="http://webimage.10x10.co.kr/play/ground/20150504/img_qr.png" alt="QR코드" /></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<% end if %>

	<div class="coming">
		<ul>
			<% if left(currenttime,10)<"2015-05-05" then %>
				<li class="onTue"><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_coming_soon_tue.jpg" alt="화요일의 꽃 카라 5월 5일 comming soon" /></li>
			<% end if %>
			<% if left(currenttime,10)<"2015-05-06" then %>
				<li class="onWed"><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_coming_soon_wed.jpg" alt="수요일의 꽃 퐁퐁소국 5월 6일 comming soon" /></li>
			<% end if %>
			<% if left(currenttime,10)<"2015-05-07" then %>
				<li class="onThu"><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_coming_soon_thu2.jpg" alt="목요일의 꽃 작약 5월 7일 comming soon" /></li>
			<% end if %>
			<% if left(currenttime,10)<"2015-05-08" then %>
				<li class="onFri"><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_coming_soon_fri.jpg" alt="금요일의 꽃 미스티블루 5월 8일 comming soon" /></li>
			<% end if %>
		</ul>
	</div>

	<div id="screensaver" class="screensaver">
		<div class="inner">
			<div class="msg">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150504/tit_screen_saver.png" alt="당신의 컴퓨터에도 꽃을 심어 주세요!" /></h2>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_screen_saver.png" alt="텐바이텐 플레이와 히치하이커가 바탕화면 보호기를 준비했습니다. 꽃으로 느낄 수 있는 7가지의 좋은 기분들을 컴퓨터에 심어 두세요 : ) 바쁜 업무 속 잠깐 쉬는 시간, 우리가 준비한 꽃과 함께 향기로운 여유를 느낄 수 있기를 바랍니다." /></p>
				<div class="mycomputer">
					<div class="rolling">
						<div class="slide-wrap">
							<div id="slide1" class="slide">
								<img src="http://webimage.10x10.co.kr/play/ground/20150504/img_slide_01.jpg" alt="" />
								<img src="http://webimage.10x10.co.kr/play/ground/20150504/img_slide_02.jpg" alt="" />
								<img src="http://webimage.10x10.co.kr/play/ground/20150504/img_slide_03.jpg" alt="" />
								<img src="http://webimage.10x10.co.kr/play/ground/20150504/img_slide_04.jpg" alt="" />
								<img src="http://webimage.10x10.co.kr/play/ground/20150504/img_slide_05.jpg" alt="" />
							</div>
						</div>
					</div>
					<a href="http://file.10x10.co.kr/hitchhikerapp/hitchhiker/play/2015/05/2015_TENBYTEN_PLAY_FLOWER.zip" title="스크린 세이버 다운로드" class="btndown"><img src="http://webimage.10x10.co.kr/play/ground/20150504/btn_down.png" alt="다운로드" /></a>
				</div>
			</div>
			<div class="about">
				<a href="/street/street_brand_sub06.asp?makerid=hitchhiker" target="_top" title="히치하이커 브랜드 바로가기">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150504/txt_hitchhiker.png" alt="이야기로 힘을 얻고, 이야기에 힘이 되는 히치하이커 히치하이커는 텐바이텐의 감성매거진입니다. 격월간으로 발행되는 히치하이커는 지난 2006년부터 당신과 나, 우리의 이야기라 말할 수 있는 일상 속 메시지를 다양한 이미지와 함께 묶어내고 있습니다. 아주 가까운 곳에 있는 이야기를 불러 모아 조금 더 멀리에 있는 모두의 내일을 내다보겠습니다. 또한 그를 위한 응원을 아끼지 않으며 구독하시는 모든 분들의 이야기에 힘을 실어드릴 수 있도록 노력하겠습니다." /></p>
					<span class="btnbrand"><img src="http://webimage.10x10.co.kr/play/ground/20150504/btn_brand.png" alt="브랜드 바로가기" /></span>
				</a>
			</div>
		</div>
	</div>
</div>
<!-- //iframe -->

<!-- for dev msg : body 끝나기전에 js 넣어주세요 -->
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".topic .bg").addClass("blur");

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300 ) {
			animation2();
		}
		if (scrollTop > 500 ) {
			animation1();
		}
		if (scrollTop > 700 ) {
			animation3();
		}
	});

	function animation1 () {
		$(".topic .bg").removeClass("blur");
	}

	$(".topic h1 .letter1").css({"width":"0"});
	$(".topic h1 .letter2").css({"opacity":"0", "margin-top":"7px"});
	$(".topic p").css({"opacity": "0", "margin-top":"7px"});
	function animation2 () {
		$(".topic h1 .letter1").delay(1500).animate({"width":"260px"},800);
		$(".topic h1 .letter2").delay(600).animate({"opacity":"1", "margin-top":"0"},500);
		$(".topic p").delay(200).animate({"opacity":"1", "margin-top":"0"},500);
	}

	$(".present h2").css({"opacity": "0", "padding-top":"110px"});
	$(".present .desc").css({"opacity": "0", "margin-top":"7px"});
	function animation3 () {
		$(".present h2").delay(600).animate({"opacity":"1", "padding-top":"122px"},800);
		$(".present .desc").delay(1200).animate({"opacity":"1", "margin-top":"0"},800);
	}

	function moving () {
		$(".btndown img").animate({"margin-bottom":"0"},1500).animate({"margin-bottom":"10px"},1500, moving);
	}
	moving();

	$(".byMobile .qrcode").hide();
	$(".byMobile a").mouseenter(function(){
		$(this).next().show("slow");
	});
	$(".byMobile a").mouseleave(function(){
		$(".byMobile .qrcode").hide();
	});

//	$(".btnmove a").click(function(event){
//		event.preventDefault();
//		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 1000);
//	});

	/* slide */
	$('#slide1').slidesjs({
		width:"386",
		height:"238",
		pagination:false,
		navigation:false,
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

});
</script>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->