<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 GIFT 페이지
' History : 2016.09.30 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2017/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/diary2017.css" />
<script type="text/javascript">
$(function(){
	$('.giftBox li .slide').slidesjs({
		width:312,
		height:295,
		pagination:false,
		navigation:false,
		play:{interval:2000, effect:'fade', auto:true},
		effect:{fade:{speed:600, crossfade:true}}
	});
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diarystory2017">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2017/inc/head.asp" -->
			<!-- 2017 다이어리 구매 금액별 사은품-->
			<div class="diaryGiftMain">
				<p class="goVideo"><a href="#lyrOld" onclick="viewPoupLayer('modal',$('#lyrOld').html());return false;"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/btn_play.png" alt="오롤리데이 동영상 보기" /></a></p>
				<div class="oh10x10Day">
					<div class="title">
						<h2><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_diary_gift.png" alt="2017 다이어리 구매 금액별 사은품 OH! TEN BY TEN DAY" /></h2>
						<span><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/icon_free_deli.png" alt="다이어리 스토리 전 상품 무료배송" /></span>
					</div>
					<div class="brandIntro">
						<div class="giftCont">
							<p><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_brand_info.png" alt="Oh, lolly day! 제품을 만나는 모든 사람이 oh,happy day! 하길 바라는 마음에서 만든 브랜드입니다. 디자인으로 멋을 부리기 보다는 쓰임새와 필요성에 대한 연구를 많이하며, 친근하고, 다정하고, 오래보아도 질리지 않는 따뜻한 제품을 만듭니다. 'Write/charge your life with good stationery/battery'라는 슬로건으로 텐바이텐과 함께 이번 프로젝트를 기획하게 되었으며, 여러분의 2017도 O,TD! 와 함께 2017년이 따뜻해지길 바랍니다." /></p>
							<a href="/street/street_brand_sub06.asp?makerid=ohlollyday" target="_blank"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/btn_brand.png" alt="오롤리데이 상품 전체보기" /></a>
						</div>
					</div>
					<div class="giftBox">
						<ul>
							<li>
								<span class="soldout"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_soldout.png" alt="SOLD OUT" /></span>
								<img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/img_gift_01.jpg" alt="1만원이상 구매시 - [O,TD!] 체크메모패드" />
							</li>
							<li>
								<span class="soldout"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_soldout.png" alt="SOLD OUT" /></span>
								<img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/img_gift_02.jpg" alt="2만원이상 구매시 - [O,TD!] 문구세트" />
							</li>
							<li>
								<span class="soldout"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_soldout.png" alt="SOLD OUT" /></span>
								<p><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/img_gift_03.jpg" alt="4만원이상 구매시 - [O,TD!] 보조배터리 2000mAh" /></p>
								<div class="slide">
									<div><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/img_gift_rolling_01.jpg" alt="" /></div>
									<div><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/img_gift_rolling_02.jpg" alt="" /></div>
									<div><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/img_gift_rolling_03.jpg" alt="" /></div>
								</div>
							</li>
						</ul>
						<p><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_tip.png" alt="※ DIARY STORY 다이어리를 포함한 텐바이텐 배송상품 구매 기준" /></p>
					</div>
				</div>
				<div class="gallery">
					<p><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_gift_cont.png" alt="Write Your Life With GOOD STATIONERY 텐바이텐과 인스타에서 핫한 오롤리데이가 만나 새롭게 제작한 콜라보 상품으로 오직 텐바이텐에서만 만나볼 수 있습니다. 오늘의 하루 나의 이야기를 할 수 있는 그 곳, 여러분들의 2017 새로운 이야기가 가득 채워 질 수 있길 바랍니다." /></p>
				</div>
 				<div class="giftTerms">
					<div class="giftCont">
						<h3><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_evnt.png" alt="다이어리 스토리 사은품, 저도 받을 수 있나요?" /></h3>
						<p class="tPad15"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_evnt_con_01.png" alt="2017 DIARY STORY 다이어리를 포함한 텐바이텐 배송상품 구매 시, 사은품 증정 조건에 해당됩니다. " /></p>
						<p class="price"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_price.png" alt="DIARY STORY 다이어리 + 텐바이텐 배송상품 = 1만원 이상 구매 시 : [O,TD!] 체크메모패드 증정 DIARY STORY 다이어리 + 텐바이텐 배송상품 = 2만원 이상 구매 시 :  [O,TD!] 문구세트 증정 DIARY STORY 다이어리 + 텐바이텐 배송상품 = 4만원 이상 구매 시 :  [O,TD!] 보조배터리 증정" /></p>
						<p class="bPad30"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/txt_evnt_con_03.png" alt="구매금액별 사은품 증정 예시 DIARY STORY 다이어리 (9,000원) + 텐바이텐 배송상품(1,000원) 구매 시 : [O,TD!] 체크" /></p>
						<a href="/event/eventmain.asp?eventid=73440" target="_blank"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/btn_go_prd.png" alt="텐바이텐 배송상품 보러가기" /></a>
						<div class="ex"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/img_ex.png" alt="" /></div>
					</div>
				</div>
				<div class="noti">
					<div class="giftCont">
						<h3><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_gift_noti.png" alt="사은품 유의사항" /></h3>
						<ul>
							<li>다이어리 스토리 사은 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 시, 증정 불가)</li>
							<li>사은품 증정기간은 2016.10.04 ~ 2016.12.31입니다 . (한정수량으로 조기품절 될 수 있습니다.)</li>
							<li>2017 DIARY STORY 다이어리 포함 텐바이텐 배송상품 1/2/4만원 이상 구매시 증정됩니다. (쿠폰, 할인카드 등 사용 후 구매확정금액 기준)</li>
							<li>환불 및 교환으로 기준 금액 미만이 될 경우 사은품은 반품해 주셔야 합니다.</li>
							<li>모든 사은품의 옵션은 랜덤 증정 됩니다.</li>
							<li>다이어리 구매 개수에 관계없이 총 구매금액이 조건 충족 시 사은품이 증정됩니다.</li>
							<li>사은품 불량으로 인한 교환은 불가능 합니다.</li>
						</ul>
					</div>
				</div>
			</div>
			<!--// 2017 다이어리 구매 금액별 사은품-->
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<!-- 동영상 보기 레이어 -->
<div id="lyrOld" style="display:none;">
	<div class="brandVideo">
		<p class="name">OH, LOLLY DAY!</p>
		<div class="video"><div><iframe src="https://player.vimeo.com/video/190516509" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div></div>
		<button class="close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/btn_close.png" alt="닫기" /></button>
	</div>
</div>
<!--// 동영상 보기 레이어 -->
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->