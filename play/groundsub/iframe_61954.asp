<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #19 세상에 하나뿐인 스티커
' 2015-04-24 유태욱 작성
'########################################################
Dim eCode, userid, vQuery
IF application("Svr_Info") = "Dev" THEN
	eCode   =  61763
Else
	eCode   =  61954
End If

userid = getloginuserid()

Dim strSql, enterCnt, sakuraCnt, overseasCnt

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		enterCnt = rsget(0)
	End IF
	rsget.close

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundHeadWrap {width:100%; background-image:url(http://webimage.10x10.co.kr/play/ground/20150427/bg_head.gif);}
.groundCont {background:#ffeeda !important;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:95px 20px 50px;}
.playGr20150427 {position:relative; overflow:hidden;}
.playGr20150427 img {vertical-align:top;}
.stickerCont {position:relative; width:1140px; margin:0 auto;}
.intro {height:1044px; background:url(http://webimage.10x10.co.kr/play/ground/20150427/bg_sketchbook.jpg) center top no-repeat; background-size:100% 1044px;}
.intro h2 {position:absolute; left:50%; top:390px; width:347px; height:179px; margin-left:-173px;}
.intro h2 span {display:none; position:absolute; left:0; top:0;}
.intro .limpa {position:absolute; left:50%; top:585px; margin-left:-198px;}
.brandStory {overflow:hidden; height:1083px;}
.brandStory h3 p {position:absolute; top:0px;  z-index:20;}
.brandStory h3 p.tit01 {left:110px;}
.brandStory h3 p.tit02 {left:630px;}
.brandStory .story {position:absolute; left:0; top:217px; z-index:30;}
.brandStory .goBtn {overflow:hidden; position:absolute; top:555px; height:44px; z-index:40;}
.brandStory .goBtn:hover img {margin-top:-44px;}
.brandStory .goBrand {left:618px;}
.brandStory .goHome {left:832px;}
#useSticker {height:530px;}
#useSticker .item .www_FlowSlider_com-branding {display:none;}
.viewSample {padding:165px 0 140px; background:#fff;}
.viewSample ul {overflow:hidden;}
.viewSample li {position:relative; float:left; width:222px; margin:0 3px 35px; cursor:pointer;}
.viewSample li p {display:none; position:absolute; left:0; top:0; width:222px; height:222px;}
.viewSample li p img {width:100%;}
.makeSticker {position:relative; height:1613px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150427/bg_line.gif) left top repeat-x;}
.makeSticker .stickerCont {position:absolute; left:50%; top:0; margin-left:-570px; z-index:70;}
.makeSticker h3 {padding:128px 0 60px;}
.makeSticker .goMake {display:inline-block; overflow:hidden; height:75px; margin-top:70px;}
.makeSticker .goMake:hover img {margin-top:-75px;}
.makeSticker .deco {display:inline-block; position:absolute; z-index:50;}
.makeSticker .d01 {left:-320px; top:235px;}
.makeSticker .d02 {right:-320px; top:90px;}
.slideWrap {width:975px; height:537px; padding:30px; margin:0 auto 60px; background:url(http://webimage.10x10.co.kr/play/ground/20150427/bg_frame.png) left top no-repeat;}
.slideWrap .slide {position:relative;}
.slideWrap .slide .slidesjs-navigation {position:absolute; top:50%; width:68px; height:67px; margin-top:-33px; z-index:30; text-indent:-9999px;}
.slideWrap .slide .slidesjs-previous {left:32px; background:url(http://webimage.10x10.co.kr/play/ground/20150427/btn_prev.png) left top no-repeat;}
.slideWrap .slide .slidesjs-next {right:32px; background:url(http://webimage.10x10.co.kr/play/ground/20150427/btn_next.png) left top no-repeat;}
.slideWrap .slide .slidesjs-pagination {position:absolute; bottom:22px; left:50%; overflow:hidden; width:110px; margin-left:-55px; z-index:30;}
.slideWrap .slide .slidesjs-pagination li {float:left; padding:0 8px;}
.slideWrap .slide .slidesjs-pagination li a {display:block; width:11px; height:11px; background:url(http://webimage.10x10.co.kr/play/ground/20150427/btn_pagination.png) left top no-repeat; text-indent:-9999px;}
.slideWrap .slide .slidesjs-pagination li a.active {background-position:-11px top;}
.applySticker {height:400px; background:#ff6969;}
.applySticker .stickerCont {overflow:hidden; width:1055px; padding-top:78px;}
.applySticker .total {display:inline-block; margin:35px 0 15px; background:#fff;}
.applySticker .total span {font-weight:bold; font-size:25px; line-height:38px; color:#000; font-family:tahoma;}

.viewSample li:hover p {-webkit-animation-duration:200ms; -webkit-animation-iteration-count:1; -webkit-animation-timing-function: linear; -moz-animation-duration:200ms; -moz-animation-iteration-count:1; -moz-animation-timing-function: linear; -ms-animation-duration:200ms; -ms-animation-iteration-count:1; -ms-animation-timing-function: linear; animation-duration:200ms; animation-iteration-count:1; animation-timing-function: linear; animation-name:spin; -webkit-animation-name:spin; -moz-animation-name: spin; -ms-animation-name: spin;}
@-ms-keyframes spin {from {-ms-transform: rotate(320deg);} to {-ms-transform: rotate(360deg);}}
@-moz-keyframes spin {from { -moz-transform: rotate(320deg);} to { -moz-transform: rotate(360deg);}}
@-webkit-keyframes spin {from { -webkit-transform: rotate(320deg);} to { -webkit-transform: rotate(360deg);}}
@keyframes spin {from {transform:rotate(-320deg);} to { transform:rotate(-360deg);}}
@media all and (max-width:1740px) {
	.intro {background-size:1740px 1044px;}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	$(".slide").slidesjs({
		width:"975", 
		height:"537",
		navigation:{effect:"fade"},
		pagination:{effect:"fade"},
		play: {interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$("#useSticker").FlowSlider({
		marginStart:0,
		marginEnd:0,
		position:0.0,
		startPosition:0
	});
	
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 420){
			$('.intro h2 .t01').delay(100).fadeIn(800);
			$('.intro h2 .t02').delay(600).fadeIn(800);
			$('.intro h2 .t03').delay(900).fadeIn(800);
			$('.intro h2 .t04').delay(300).fadeIn(800);
			$('.intro h2 .t05').delay(700).fadeIn(800);
		}
		if (scrollTop > 1650){
			$('.makeSticker .d01').animate({"left":"0"}, 800);
			$('.makeSticker .d02').delay(400).animate({"right":"0"}, 800);
		}
		if (scrollTop > 4750){
			$('.brandStory h3 p.tit01').animate({"top":"120px"}, 800);
			$('.brandStory h3 p.tit02').delay(600).animate({"top":"120px"}, 800);
		}
	});
	$(".goMake").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:5600}, 500);
	});
	$('.viewSample li').hover(function(){
		$(this).children('p').fadeIn(300);
	});
	$('.viewSample li').mouseleave(function(){
		$(this).children('p').fadeOut(300);
	});
});

function jsSubmit(){
	<% if Not(IsUserLoginOK) then %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
	var rstStr = $.ajax({
		type: "POST",
		url: "/play/groundsub/doEventSubscript61954.asp",
//		data: "",
		dataType: "text",
		async: false
	}).responseText;
	if (rstStr.substring(0,2) == "01"){
		var enterCnt;
		enterCnt = rstStr.substring(5,10);
		$("#entercnt").html(enterCnt);
		alert('응모 완료!');
		return false;

	}else if (rstStr == "02"){
		alert('5회 까지만 참여 가능 합니다.');
		return false;
	}else{
		alert('관리자에게 문의');
		return false;
	}
}
</script>
</head>
<body>

	<!-- 수작업 영역 시작 -->
	<div class="playGr20150427">
		<div class="intro">
			<div class="stickerCont">
				<h2>
					<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150427/tit_sticker01.png" alt="" /></span>
					<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150427/tit_sticker02.png" alt="" /></span>
					<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150427/tit_sticker03.png" alt="" /></span>
					<span class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20150427/tit_sticker04.png" alt="" /></span>
					<span class="t05"><img src="http://webimage.10x10.co.kr/play/ground/20150427/tit_sticker05.png" alt="" /></span>
				</h2>
				<p class="limpa"><img src="http://webimage.10x10.co.kr/play/ground/20150427/txt_limpalimpa.png" alt="" /></p>
			</div>
		</div>
		<div class="makeSticker">
			<div class="stickerCont">
				<h3><img src="http://webimage.10x10.co.kr/play/ground/20150427/txt_make_sticker.gif" alt="" /></h3>
				<div class="slideWrap">
					<div class="slide">
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_slide01.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_slide02.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_slide03.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_slide04.jpg" alt="" />
					</div>
				</div>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/txt_process.gif" alt="" /></p>
				<a href="#applySticker" class="goMake"><img src="http://webimage.10x10.co.kr/play/ground/20150427/btn_go_make.gif" alt="" /></a>
			</div>
			<span class="deco d01"><img src="http://webimage.10x10.co.kr/play/ground/20150427/bg_make_deco01.png" alt="" /></span>
			<span class="deco d02"><img src="http://webimage.10x10.co.kr/play/ground/20150427/bg_make_deco02.png" alt="" /></span>
		</div>
		<div class="viewSample">
			<div class="stickerCont">
				<ul>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample01.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample01_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample02.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample02_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample03.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample03_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample04.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample04_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample05.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample05_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample06.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample06_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample07.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample07_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample08.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample08_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample09.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample09_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample10.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample10_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample11.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample11_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample12.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample12_on.jpg" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample13.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample13_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample14.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample14_on.png" alt="" /></p>
					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample15.jpg" alt="" />
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_sticker_sample15_on.png" alt="" /></p>
					</li>
				</ul>
			</div>
		</div>
		<div id="useSticker" class="slider-horizontal">
			<div class="item"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_flow_sticker01.jpg" alt="" /></div>
			<div class="item"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_flow_sticker02.jpg" alt="" /></div>
			<div class="item"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_flow_sticker03.jpg" alt="" /></div>
			<div class="item"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_flow_sticker04.jpg" alt="" /></div>
			<div class="item"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_flow_sticker05.jpg" alt="" /></div>
			<div class="item"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_flow_sticker06.jpg" alt="" /></div>
			<div class="item"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_flow_sticker07.jpg" alt="" /></div>
			<div class="item"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_flow_sticker08.jpg" alt="" /></div>
		</div>
		<div class="brandStory">
			<div class="stickerCont">
				<h3>
					<p class="tit01"><img src="http://webimage.10x10.co.kr/play/ground/20150427/txt_brand.gif" alt="" /></p>
					<p class="tit02"><img src="http://webimage.10x10.co.kr/play/ground/20150427/txt_story.gif" alt="" /></p>
				</h3>
				<div class="story"><img src="http://webimage.10x10.co.kr/play/ground/20150427/img_brand_story.jpg" alt="" /></div>
				<a href="/street/street_brand_sub06.asp?makerid=limpalimpa" class="goBtn goBrand" target="_top"><img src="http://webimage.10x10.co.kr/play/ground/20150427/btn_go_brand.gif" alt="" /></a>
				<a href="http://limpalimpa.com" class="goBtn goHome" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20150427/btn_go_homepage.gif" alt="" /></a>
			</div>
		</div>
		<!-- 스티커 신청하기 -->
		<div id="applySticker" class="applySticker">
			<div class="stickerCont">
				<div class="ftLt">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20150427/tit_make_sticker.gif" alt="세상에 하나뿐인 스티커를 만들어 드립니다." /></h3>
					<p class="total">
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/txt_count01.gif" alt="지금까지 총" />
						<span id="entercnt"><%= enterCnt %></span>
						<img src="http://webimage.10x10.co.kr/play/ground/20150427/txt_count02.gif" alt="명이 하나뿐인 스티커를 신청하셨습니다." />
					</p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150427/txt_period.gif" alt="당첨되신 분에 한해 스티커로 제작하실 사진을 요청 드릴 예정입니다." /></p>
				</div>
				<div class="ftRt tPad25">
					<input type="image" onclick="jsSubmit();return false;" src="http://webimage.10x10.co.kr/play/ground/20150427/btn_apply.gif" alt="스티커 신청하기" />
				</div>
			</div>
		</div>
		<!--// 스티커 신청하기 -->
	<form name="frmcom" method="post" action="doEventSubscript61954.asp" style="margin:0px;">
		<input type="hidden" name="votetour">
	</form>
	</div>
	<!-- 수작업 영역 끝 -->
	
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->