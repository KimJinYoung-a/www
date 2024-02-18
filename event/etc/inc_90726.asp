<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 12월의구매사은품
' History : 2018-11-30 원승현 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<%
dim eCode

IF application("Svr_Info") = "Dev" THEN
	eCode = "90198"
Else
	eCode = "90726"
End If

Dim oOpenGift, openGiftStatus

Set oOpenGift = new CopenGift
oOpenGift.FRectGiftScope = "1"		'전체사은이벤트 범위 지정(1:전체,3:모바일,5:APP) - 2014.08.18; 허진원
oOpenGift.getGiftItemList(eCode)

If oOpenGift.FResultCount > 0 Then
	openGiftStatus = True
Else
	openGiftStatus = False
End if

%>
<style type="text/css">
.evt90726 {background-color:#ffc445; }
.evt90726 h2 {margin:0 auto 50px; padding-top:80px;}
.evt90726 .inner-wrap {position:relative; background:url('http://webimage.10x10.co.kr/fixevent/event/2018/90726/bg_img.png') center top no-repeat;}
.evt90726 .inner-wrap .bnr-top {position:absolute; top:0; right:210px;}
.evt90726 .inner-wrap .bnr-top p {position:absolute; right:24px; width:154px; height:251px; animation:watch 2.0s 0.8s both linear 12; transform-origin:50% top; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/90726/ico_order.png); text-indent:-9999px;}
.evt90726 .inner-wrap .bnr-top span {display:block; width:83px; height:128px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/90726/ico_order_sm.png); text-indent:-9999px;}
.evt90726 .inner-wrap .bnr-top.soldout p {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/90726/ico_order_off.png);}
.evt90726 .inner-wrap .bnr-top.soldout span {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/90726/ico_order_sm_off.png);}
.evt90726 .vod-area {margin-top:243px; padding-bottom:100px;}
.evt90726 .vod-area iframe {background-color:#000; box-shadow:0 20px 50px rgba(0, 0, 0, 0.5);}
.evt90726 .slide {position:relative;}
.evt90726 .slide ul.slidesjs-pagination {position:absolute; bottom:70px; right:150px; z-index:999;}
.evt90726 .slide li.slidesjs-pagination-item {display:inline-block; margin:0 7px;}
.evt90726 .slide li.slidesjs-pagination-item a {display:block; width:9px; height:9px; border-radius:9px; background-color:#ffe2a2; text-indent:-9999px;}
.evt90726 .slide li.slidesjs-pagination-item a.active {width:29px; background-color:#ffb921;}
.evt90726 .noti {position:relative; background-color:#262639; color:#cacadf; text-align:left; font-family:'AppleGothic', 'malgunGothic', '맑은고딕', sans-serif; padding:60px 0 50px;}
.evt90726 .noti h3 {position:absolute; top:135px; left:170px;}
.evt90726 .noti ul {display:inline-block; padding-left:315px;}
.evt90726 .noti li {position:relative; line-height:25px;}
.evt90726 .noti li:before {content:''; position:absolute; left:-14px; top:40%; width:3px; height:3px; border-radius:3px; background-color:#f47c64;}
.evt90726 .noti b {font-weight:bold; color:#e9c066;}
.evt90726 .noti a {background-color:#e9c066; color:#14141d; padding:1px 8px; margin-left:10px; text-decoration:none; font-weight:bold;}
@keyframes watch {
	from, 50%, to {transform:rotate(0);}
	25% {transform:rotate(10deg);}
	75% {transform:rotate(-10deg);}
}
</style>
<script type="text/javascript">
$(function() {
	/* slide js */
	$("#slide").slidesjs({
		pagination: {active:true, effect:"fade"},
		navigation:false,
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});
});
</script>
<%' 90726 12월의 구매사은품 %>
<div class="evt90726">
	<div class="inner-wrap">
		<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90726/tit_img.png" alt="12월의 구매사은품"></h2>
		<%' for dev msg : 선착순 끝나면 솔드아웃 처리 : bnr-top 옆에 soldout 클래스 추가해주세요 %>
		<div class="bnr-top <% If openGiftStatus Then %><% if (oOpenGift.FItemList(0).IsGiftItemSoldOut) then %>soldout<% End If %><% End If %>"> 
			<p>선착순 900개!</p>
			<span>선착순 900개!</span>
		</div>
		<a href="/shopping/category_prd.asp?itemid=2133684&pEtr=90726">
			<div id="slide" class="slide">
				<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90726/img_slide_01.png" alt="슬라이드 이미지" /></div>
				<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90726/img_slide_02.png" alt="슬라이드 이미지" /></div>
				<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90726/img_slide_03.png?v=1.01" alt="슬라이드 이미지" /></div>
				<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90726/img_slide_04.png" alt="슬라이드 이미지" /></div>
				<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90726/img_slide_05.png" alt="슬라이드 이미지" /></div>
				<div><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90726/img_slide_06.png" alt="슬라이드 이미지" /></div>
			</div>
		</a>
		<div class="vod-area">
			<p><iframe width="822" height="441" src="https://www.youtube.com/embed/QYR6-OD7P0I" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></p>
		</div>
		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90726/txt_notice.png" alt="유의사항" /></h3>
			<ul>
				<li>본 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 시, 증정 불가)</li>
				<li><b>텐바이텐 배송상품을 포함</b>하여야 사은품 선택이 가능합니다. <a href="/event/eventmain.asp?eventid=89269">텐바이텐 배송상품 보기 ></a></li> 
				<li>쿠폰, 할인카드 등을 적용한 후 <b>구매확정 금액이 5만원 이상</b>이어야 합니다. (단일주문건 구매 확정액)</li>
				<li>마일리지, 예치금, 기프트카드를 사용하신 경우, 사용하신 금액이 구매확정 금액에 포함되어 사은품을 받으실 수 있습니다.</li>
				<li>텐바이텐 기프트카드를 구매하신 경우는 사은품 증정이 되지 않습니다.</li>
				<li>환불이나 교환 시 최종 구매 가격이 사은품 수량 가능금액 미만이 될 경우, 사은품과 함께 반품해야 합니다.</li>
				<li>한정 수량이므로 조기에 소진될 수 있습니다.</li>
			</ul>
		</div>
	</div>
</div>
<%' // 90726 12월의 구매사은품 %>
<%
	Set oOpenGift = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->