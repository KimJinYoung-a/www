<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2016 GIFT 페이지
' History : 2015.10.02 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2016/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2016/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/diary2016.css" />
<script type="text/javascript">
$(function(){
	/* main swipe */
	var mySwiper = new Swiper('.swiper-container',{
		loop: true,
		speed:1500,
		autoplay:false,
		pagination: '.pagination',
		paginationClickable:true
	});
	/* gift */
	$(".price01 .slide").slidesjs({
		width:"1140",
		height:"600",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.price01 .slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$(".price02 .slide").slidesjs({
		width:"1140",
		height:"600",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3300, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.price02 .slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$(".price03 .slide").slidesjs({
		width:"1140",
		height:"600",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.price03 .slide').data('plugin_slidesjs');
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
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diarystory2016">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2016/inc/head.asp" -->
			<div class="diaryContent">
				<!-- 상단 메인 롤링 -->
				<div class="giftRolling">
					<div class="swiper">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="swiper-slide slide01"><div class="mainPic">롤링이미지1</div></div>
								<div class="swiper-slide slide02"><div class="mainPic">롤링이미지2</div></div>
								<div class="swiper-slide slide03"><div class="mainPic">롤링이미지3</div></div>
							</div>
						</div>
						<div class="arrow"></div>
					</div>
					<div class="pagination"></div>
					<p class="free"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tag_free_deliver.png" alt="다이어리 스토리 전 상품 무료배송" /></p>
				</div>
				<!--// 상단 메인 롤링 -->
				<div class="giftTerms">
					<div class="price01">
						<div class="terms">
							<p><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_holder.png" alt="1만원 이상 구매시 베이비 홀더" /></p>
							<strong class="soldout"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_soldout_gift.png" alt="솔드아웃" /></strong>
							<div class="slide">
								<a href="/shopping/category_prd.asp?itemid=1381261"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_holder01.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1381261"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_holder02.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1381261"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_holder03.jpg" alt="" /></a>
							</div>
						</div>
					</div>
					<div class="price02">
						<div class="terms">
							<p><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_pocket.png" alt="2만원 이상 구매시 미니 포켓북" /></p>
							<strong class="soldout"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_soldout_gift.png" alt="솔드아웃" /></strong>
							<div class="slide">
								<a href="/shopping/category_prd.asp?itemid=1381262"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_pocket01.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1381262"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_pocket02.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1381262"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_pocket03.jpg" alt="" /></a>
							</div>
						</div>
					</div>
					<div class="price03">
						<div class="terms">
							<p><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_ecobag.png" alt="4만원 이상 구매시 리사이클 에코백" /></p>
							<div class="slide">
								<a href="/shopping/category_prd.asp?itemid=1381263"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_ecobag01.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1381263"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_ecobag02.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1381263"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/img_gift_ecobag03.jpg" alt="" /></a>
							</div>
						</div>
					</div>
				</div>
				<div class="giftGuide">
					<div class="giftCont">
						<div><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_gift_guide.gif" alt="다이어리 사은품, 저도 받을 수 있나요?" /></div>
						<a href="/event/eventmain.asp?eventid=66572" class="tenDelivery"><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/btn_ten_deliver.gif" alt="텐바이텐 배송상품 보러가기" /></a>
					</div>
				</div>
				<div class="giftCont giftNoti">
					<h3><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_noti.gif" alt="사은품 유의사항" /></h3>
					<ul>
						<li>사은품 증정기간은 2015.10.05 ~ 2015.12.31입니다. (한정수량으로 조기품절 될 수 있습니다.)</li>
						<li>2016 DIARY STORY 다이어리 포함 텐바이텐 배송상품 1/2/4만원 이상 구매시 증정됩니다. (쿠폰, 할인카드 등 사용 후 구매확정금액 기준)</li>
						<li>환불 및 교환으로 기준 금액 미만이 될 경우 사은품은 반품해 주셔야 합니다.</li>
						<li>모든 사은품의 옵션은 랜덤 증정 됩니다.</li>
						<li>다이어리 구매 개수에 관계없이 총 구매금액이 조건 충족 시 사은품이 증정됩니다.</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->