<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
'########################################################
' 15주년 이벤트 나의 리틀 텔레비전
' 2016-10-05 이종화
'########################################################
dim eCode 

IF application("Svr_Info") = "Dev" THEN
	eCode = "66213"
Else
	eCode = "73067"
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

strPageTitle	= "[텐바이텐 15th] 나의 리틀 텔레비전"
strPageUrl		= "http://www.10x10.co.kr/event/15th/tv.asp"
strPageImage	= "http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/m/img_kakao.png"

	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐 15th] 나의 리틀 텔레비전"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/15th/tv.asp"" />" & vbCrLf
	
	strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/m/img_kakao.png"" />" & vbCrLf &_
												"<link rel=""image_src"" href=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/m/img_kakao.png"" />" & vbCrLf
	
	strPageDesc = "[텐바이텐] 이벤트 - 소소한 일상을 담은 나만의 방송"

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐 15th] 나의 리틀 텔레비전")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/15th/tv.asp")
snpPre		= Server.URLEncode("10x10 15th 이벤트")
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* 15th common */
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
.teN15th .noti h3 {position:absolute; left:92px; top:50%; margin-top:-37px;}
.teN15th .noti ul {padding:0 50px 0 310px;}
.teN15th .noti li {color:#666; text-indent:-10px; padding:5px 0 0 10px; line-height:18px;}
.teN15th .shareSns {height:160px; text-align:left; background:#363c7b url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_share.png) repeat 0 0;}
.teN15th .shareSns div {position:relative; width:1140px; margin:0 auto;}
.teN15th .shareSns p {padding:70px 0 0 40px;}
.teN15th .shareSns ul {overflow:hidden; position:absolute; right:40px; top:50px;}
.teN15th .shareSns li {float:left; padding-left:40px;}

/* my little television */
.myLitteTv .topic {height:1235px; background:#fbf1d9 url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/bg_light.jpg) no-repeat 50% 0;}
.myLitteTv .topic .desc {position:relative; height:431px; padding-top:105px;}
.myLitteTv .topic h3 {position:relative; width:553px; height:288px; margin:0 auto;}
.myLitteTv .topic h3 span {display:block; position:absolute; width:447px; height:61px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/tit_my_little_televisioin.png) no-repeat -56px 0; text-indent:-9999em;}
.myLitteTv .topic h3 .letter1 {top:0; left:56px;}
.myLitteTv .topic h3 .letter2 {right:0; bottom:0; width:279px; height:176px; background-position:100% -98px;}
.myLitteTv .topic .desc p {margin-top:37px;}
.myLitteTv .topic .desc .deco {position:absolute; top:89px; left:50%; margin-left:-453px;}
.bounceThis {position:absolute !important; top:171px; left:50%; margin-left:-280px}
.myLitteTv .topic .desc .tv {display:block; width:231px; height:222px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/tit_my_little_televisioin.png) no-repeat 0 100%;}

.myLitteTv .rolling {width:1097px; height:633px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/bg_tv.png) no-repeat 50% 0;}
.myLitteTv .rolling .slide {overflow:visible !important; position:relative; text-align:left;}
.myLitteTv .rolling .slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:40px; height:76px; margin-top:-38px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.myLitteTv .rolling .slide .slidesjs-previous {left:-39px;}
.myLitteTv .rolling .slide .slidesjs-next {right:0; background-position:100% 0;}

.myLitteTv .event {height:310px; background-color:#f8df7d;}

.myLitteTv .gallery {padding:58px 0 82px; background:#c9f0fa url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/bg_cloud.png) no-repeat 50% 315px;}
.myLitteTv .gallery h4 img {margin-left:-25px;}
.myLitteTv .gallery ul {overflow:hidden; width:1164px; margin:53px auto 0;}
.myLitteTv .gallery ul li {float:left;  padding:7px; margin:12px; background-color:#fff;}
.myLitteTv .gallery ul li a {overflow:hidden; display:block; width:253px; height:253px;}
.myLitteTv .gallery ul li img {transition:transform 0.8s ease-in-out;}
.myLitteTv .gallery ul li a:hover img {transform:scale(1.1);}
.myLitteTv .gallery .btnLink {margin-top:60px;}

.gallery .slide {overflow:visible !important; position:relative; width:1060px; height:630px;}
.gallery .slide .slidesjs-container {height:630px; text-align:center;}
.gallery .slide .slidesjs-slide {position:relative; text-align:center;}
.gallery .slide .slidesjs-slide .slidesjs-control {width:auto !important; height:auto !important; text-align:center;}
.gallery .slide .slidesjs-navigation {position:absolute; top:50%; z-index:50; width:30px; height:58px; margin-top:-29px; text-indent:-999em; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66871/btn_nav.png) no-repeat 0 0;}
.gallery .slide .slidesjs-previous {left:0;}
.gallery .slide .slidesjs-next {right:0; background-position:100% 0;}
.viewSlide {display:none; position:fixed; left:50%; top:50%; z-index:200; width:1060px; height:600px; margin-top:-300px; margin-left:-530px;}
.viewSlide .close {position:absolute;top:0; right:0; width:24px; height:24px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71918/btn_close.png) no-repeat 0 0; text-indent:-9999em;}
#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71918/bg_mask.png) repeat 0 0;}

.teN15th .noti ul li b {color:#5e3aa8;}
</style>
<script type="text/javascript">
	/*
	Bounce(this) v1.0.0
	by Todd Motto: http://www.toddmotto.com
	Latest version: https://github.com/toddmotto/bounceThis
	
	Copyright 2013 Todd Motto
	Licensed under the MIT license
	http://www.opensource.org/licenses/mit-license.php

	BounceThis jQuery Plugin, super simple bouncing headers.
*/
;(function(e){e.fn.bounceThis=function(t){var n={bounceHeight:"20px",dropDownSpeed:300,delay:400};if(t){e.extend(n,t)}return this.each(function(){var t=e(this),r=t.outerHeight(true);t.wrap('<div class="bounceThis" />');e(".bounceThis").css({height:r,position:"relative"});t.hide();t.animate({top:"-"+r},function(){e(this).css({position:"relative"}).show()});t.delay(n.delay).animate({top:n.bounceHeight},n.dropDownSpeed,function(){t.animate({top:0})})})}})(jQuery);

$(function(){
	$(document).unbind("dblclick").dblclick(function (e) {});

	/* title animation */
	$("#titleAnimation .letter1").css({"margin-top":"10px", "width":"200px", "opacity":"0"});
	function titleAnimation() {
		$("#titleAnimation .letter1").delay(1000).animate({"margin-top":"0", "width":"447px", "opacity":"1"},1200);
	}
	titleAnimation();

	$('#bounce').bounceThis({
		bounceHeight:"50px",
		dropDownSpeed:500,
		delay:100
	});

	/* slide js */
	$("#slide00").slidesjs({
		width:"1058",
		height:"633",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});

	/* content area height */
	var wrapHeight = $(document).height();

	$(".gallery ul li a").click(function(e){
		e.preventDefault();
		var sNum = parseInt($(this).attr("id"))+1;

		/* 슬라이드 내용 구성 */
		$("#lyView").empty().html($("#lySlide").html());
		$("#lyView .slide").slidesjs({
			height:"600px",
			navigation: {effect: "fade"},
			pagination: {active:false},
			play: {interval:1000, effect:"fade"},
			start:sNum
		});

		/* modal창 띄움 */
		$("#dimmed").show();
		$("#dimmed").css("height",wrapHeight);
		$("#lyView").show();

		/* modal 닫기 */
		$("#lyView .close, #dimmed").one("click",function(){
			$("#dimmed").hide();
			$("#lyView").hide();
		});
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
											<li class="nav4"><a href="/event/15th/gift.asp">팡팡 터지는 구매사은품 [사은품을 부탁해]</a></li>
											<li class="nav5"><a href="/event/15th/sns.asp">영상을 공유하라 [전국 영상자랑]</a></li>
											<li class="nav6 current"><a href="/event/15th/tv.asp">일상을 담아라 [나의 리틀텔레비전]</a></li>
										</ul>
									</div>
								</div>
							</div>

							<div class="myLitteTv">
								<div class="topic">
									<div class="desc">
										<h3 id="titleAnimation">
											<span class="letter letter1">소소한 일상을 담은 나만의 방송!</span>
											<span class="letter letter2">나의 리틀 텔레비전</span>
										</h3>

										<span class="tv" id="bounce"></span>

										<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/txt_take_photo.png" alt="여러분의 일상을 TV 화면에 담아 인증샷을 올려주세요. 50분에게 텐바이텐 Gift 카드 1만원권을 선물해드려요!" /></p>
										<span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_deco.png" alt="" /></span>
									</div>

									<div class="rolling">
										<div id="slide00" class="slide">
											<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_slide_01.png" alt="" /></div>
											<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_slide_02.png" alt="" /></div>
											<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_slide_03.png" alt="" /></div>
										</div>
									</div>
								</div>

								<div class="event">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/txt_event.png" alt="이벤트 참여 방법은 텐텐 배송상품을 쇼핑하면 배송상자 속 리플렛 확인 후 나의 리틀텔레비전으로 인증샷 찍고 인스타그램에 인증샷을 업로드해주세요. 필수 포함 해시태그는 #텐바이텐 #텐바이텐티비입니다." usemap="#itemLink" /></p>
									<map name="itemLink" id="itemLink">
										<area shape="rect" coords="261,49,410,262" href="/event/eventmain.asp?eventid=73440" alt="제가 바로 텐바이텐 배송입니다! 기획전으로 이동" />
									</map>
								</div>

								<div class="gallery">
									<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/tit_gallery.png" alt="이렇게 참여해 보세요" /></h4>
									<ul>
										<li><a href="#slide01" id="0"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_01.jpg" alt="" /></a></li>
										<li><a href="#slide02" id="1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_02.jpg" alt="" /></a></li>
										<li><a href="#slide03" id="2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_03.jpg" alt="" /></a></li>
										<li><a href="#slide04" id="3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_04.jpg" alt="" /></a></li>
										<li><a href="#slide05" id="4"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_05.jpg" alt="" /></a></li>
										<li><a href="#slide06" id="5"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_06.jpg" alt="" /></a></li>
										<li><a href="#slide07" id="6"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_07.jpg" alt="" /></a></li>
										<li><a href="#slide08" id="7"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_08.jpg" alt="" /></a></li>
									</ul>

									<div class="btnLink"><a href="https://www.instagram.com/explore/tags/%ED%85%90%EB%B0%94%EC%9D%B4%ED%85%90%ED%8B%B0%EB%B9%84/" target="_blank" title="#텐바이텐티비 인스타그램으로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/btn_link.png" alt="고객 참여모습 보러 가기" /></a></div>

									<div id="lyView" class="viewSlide"></div>
									<div id="lySlide" style="display:none;">
										<div class="slide">
											<div id="slide01">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_big_01.jpg" alt="" />
												<button type="button" class="close">닫기</button>
											</div>
											<div id="slide02">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_big_02.jpg" alt="" />
												<button type="button" class="close">닫기</button>
											</div>
											<div id="slide03">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_big_03.jpg" alt="" />
												<button type="button" class="close">닫기</button>
											</div>
											<div id="slide04">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_big_04.jpg" alt="" />
												<button type="button" class="close">닫기</button>
											</div>
											<div id="slide05">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_big_05.jpg" alt="" />
												<button type="button" class="close">닫기</button>
											</div>
											<div id="slide06">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_big_06.jpg" alt="" />
												<button type="button" class="close">닫기</button>
											</div>
											<div id="slide07">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_big_07.jpg" alt="" />
												<button type="button" class="close">닫기</button>
											</div>
											<div id="slide08">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/img_gallery_big_08.jpg" alt="" />
												<button type="button" class="close">닫기</button>
											</div>
										</div>
									</div>
								</div>
							</div>

							<%' 이벤트 유의사항 %>
							<div class="noti">
								<div>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>- 나의 리틀 텔레비전은 <b>텐바이텐 배송상품</b>과 함께 배송됩니다. <a href="/event/eventmain.asp?eventid=73440" title="제가 바로 텐바이텐 배송입니다! 기획전으로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73067/btn_tenten_delivery.png" alt="텐바이텐 배송상품 보러가기" /></a></li>
										<li>- 선착순 한정수량으로 발송되며, 소진 시 미포함될 수 있습니다.</li>
										<li>- 인스타그램 계정이 비공개일 경우 이벤트 참여에서 제외됩니다.</li>
										<li>-당첨자발표는 10월 28일 금요일 공지사항을 통해 발표합니다.</li>
									</ul>
								</div>
							</div>
							<div class="shareSns">
								<div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/txt_share.png" alt="텐바이텐 15주년 이야기, 친구와 함께라면!" /></p>
									<ul>
										<li><a href="" onclick="snschk('fb');return false;" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_facebook.png" alt="텐바이텐 15주년 나의 리틀 텔레비전 페이스북으로 공유" /></a></li>
										<li><a href="" onclick="snschk('tw');return false;" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_twitter.png" alt="텐바이텐 15주년 나의 리틀 텔레비전 트위터로 공유" /></a></li>
									</ul>
								</div>
							</div>
							<div id="dimmed"></div>
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