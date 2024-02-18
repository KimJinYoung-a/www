<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 6월의 사은품
' History : 2019-06-21 최종원
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode = "90320"
Else
	eCode = "95524"
End If
%>
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"") & chkIIF(gaparam<>"","&gaparam=" & gaparam,"")
			REsponse.End
		end if
	end if
end if
%>
<%
'공유관련
'// 쇼셜서비스로 글보내기 
Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage, strPageKeyword
Dim strRecoPickMeta		'RecoPick환경변수
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[6월의 사은품] 텐바이텐 6월사은품")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/95524/m/img_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[6월의 사은품]"
strPageKeyword = "사은품"
strPageDesc = "[6월의 사은품] 선착순 700명에게만 드리는 레터링 유리컵 받아가세요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/95524/m/img_kakao.jpg"
%>
<style type="text/css">
.topic {position:relative;}
.topic .top-slide {position:absolute; top:0; left:407px; width:301px; height:553px;}
.topic .limited {position: absolute; top:120px; right:440px;}
.topic .limited:before {display:inline-block; position:absolute; top:-9px; right:-7px; z-index:5; width:68px; height:68px; background-color:#fb9885; border-radius:50%; content:''; animation:bounce 300 1s .25s;}
.topic .limited img {position:relative; z-index:10; animation:bounce 300 1s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-in;}
	50% {margin-top:15px; animation-timing-function:ease-out;}
}
.bnr-tenten {position:fixed; top:240px; left:50%; z-index:20; margin-left:430px;}

.vod-gallery #slider {overflow:hidden; background-color:#fffceb; text-align:left;}
.vod-gallery #slider .slide-img {position:relative; float:left; width:436px; height:600px; margin:0 22px;}
.vod-gallery #slider .slide-img:after {display:inline-block; position:absolute; top:0; right:0; z-index:5; width:436px; height:436px; background-color:rgba(54, 54, 54,.5); content:''; transition:all .5s; cursor:pointer;}
.vod-gallery #slider .slide-img:hover:after {background-color:rgba(54, 54, 54,0); transition:all .5s;}
.vod-gallery #slider .slide-img.slide-vod:after {display:none;}
.vod-gallery #slider .slide-img iframe {position:absolute; top:0; left:0; width:436px; height:436px;}
.vod-gallery #slider .www_FlowSlider_com-branding {display:none!important;}

.brand {position:relative;}
.brand .slide2 {position:absolute; top:85px; left:121px; width:518px; height:239px;}

.sns-share {position:relative;}
.sns-share ul {overflow:hidden; position:absolute; top:0; right:286px; height:100%;}
.sns-share ul li {float:left; width:100px; height:100%; margin:0 8px;}
.sns-share ul li a {display:inline-block; width:100%; height:100%; color:transparent;}

.noti {position:relative; background-color:#ffca63;}
.noti h3 {position:absolute; top:157px; left:185px;}
.noti ul {padding:43px 0 43px 330px; text-align:left;}
.noti ul li {padding:4px 0; font-size:13px; color:#281d15; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; word-break:keep-all;}
.noti ul li a {display:inline-block; height:26px; padding:0 5px; background-color:#ff4b4b; color:#fff; line-height:28px;}
.noti ul li a:hover {text-decoration:none;}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function(){
    $('.top-slide').slick({
        fade: true,
        infinite: true,
        speed: 1800,
        autoplay:true,
        autoplaySpeed: 500
    });
    $('.slide2').slick({
        fade: true,
        infinite: true,
        speed: 1800,
        autoplay:true,
        autoplaySpeed: 800
    });
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		startPosition:0.55
	});
});
</script>
<script type="text/javascript">
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');		
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');		
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}
</script>
	<div class="evt95524">
		<div class="topic">
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/tit_gift.png" alt="6월의 사은품 #유리컵"></h2>
			<span class="limited"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/txt_limited.png" alt="선착순 700명"></span>
			<div class="top-slide">
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_top_1.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_top_2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_top_3.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_top_4.jpg" alt=""></div>
			</div>
		</div>
		<a href="/event/eventmain.asp?eventid=89269" class="bnr-tenten" target="_blank"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/bnr_tenten_delievery.png" alt="텐바이텐 배송 상품 보러 가기"></a>
		<div class="intro"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/txt_intro.png" alt="시원한 커피 한잔이 당기는 계절, 예쁜 유리컵 하나면 홈카페를 즐길 수 있어요. 유리컵을 받게 되면 이렇게 세팅해보세요!"></div>
		<div class="vod-gallery">
			<div id="slider" class="slider-horizontal">
				<div class="slide-img"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_tag_1.jpg" alt="" /></div>
				<div class="slide-img slide-vod">
					<img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_tag_2.png" alt="#예쁘니까 더맛있는느낌! #어렵게 준비했어요 레터링 유리컵" />
					<iframe src="https://player.vimeo.com/video/343617553" width="640" height="564" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>
				</div>
				<div class="slide-img"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_tag_3.jpg?v=1.01" alt="" /></div>
			</div>
		</div>
		<div class="brand">
			<a href="/event/eventmain.asp?eventid=95488" target="_blank"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_brand.png" alt="레터링 유리컵을 만든 곳은 August8th(8월8일)이에요.'나를 위한 특별한 생일선물'이라는 컨셉으로 유니크한 상품들을 소개하는 라이프 스타일샵입니다. 홈카페를 좋아한다면 꼭 둘러보세요!"></a>
			<div class="slide2">
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_slide_1.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_slide_2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_slide_3.jpg" alt=""></div>
			</div>
		</div>
		<!-- sns 공유-->
		<div class="sns-share">
			<img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/img_sns_share.jpg" alt="친구들에게도 6월 사은품을 알려주세요!">
			<ul>
				<li><a href="" onclick="snschk('fb');return false;" target="_blank">페이스북공유</a></li>				
				<li><a href="" onclick="snschk('tw');return false;" target="_blank">트위터공유</a></li>
			</ul>
		</div>
		<div class="noti">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/tit_noti.png" alt="유의사항"></h3>
			<ul>
				<li>- 본 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 증정 불가)</li>
				<li>- 사은품은 텐바이텐 배송상품을 포함한 구매확정 금액이 6만원 이상이어야 선택이 가능합니다.  <a href="/event/eventmain.asp?eventid=89269" target="_blank">텐바이텐 배송상품 보러가기 &gt;</a></li>
				<li>- 구매확정 금액은 쿠폰, 할인카드 등을 적용한 최종 금액입니다. (마일리지/기프트카드/예치금 적용항목에서 제외입니다.)</li>
				<li>- 사은품은 텐바이텐 배송 상품과 함께 배송됩니다.</li>
				<li>- 환불이나 교환으로 인해 최종 구매 가격이 6만원 미만이 될 경우, 사은품도 함께 반품되어야 합니다.</li>
				<li>- 텐바이텐 기프트카드 상품을 구매하는 경우에는 사은품 증정 대상이 아닙니다.</li>
				<li>- 사은품이 모두 소진될 경우 이벤트는 조기 마감될 수 있습니다.  </li>
				<li>- 유리컵 레터링의 색상은 랜덤으로 증정됩니다.</li>
			</ul>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->