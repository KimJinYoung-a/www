<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#########################################################
' Description :  14th coaster 이벤트
' History : 2015.10.06 유태욱 생성
'#########################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<style type="text/css">
/* 생일엔 선물 */
#contentWrap {padding-bottom:50px; background-color:#eee;}
.anniversary14th {background-color:#eee !important;}

.anniversary14th .topic {position:relative; z-index:5; height:1108px; background:#f5f5f5 url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/bg_visual_v2.jpg) no-repeat 50% 0;}
.anniversary14th .hgroup {padding-top:114px;}
.anniversary14th .hgroup p {visibility:hidden; width:0; height:0;}
.anniversary14th .asbeit, .anniversary14th .special {position:absolute; top:407px; left:50%; text-align:left;}
.anniversary14th .asbeit .line, .anniversary14th .special .line {position:absolute; top:0; width:1px; height:215px; background-color:#ccc;}
.anniversary14th .asbeit {margin-left:-432px; padding:12px 0 0 33px;}
.anniversary14th .asbeit .line {left:0;}
.anniversary14th .special {top:856px; margin-left:117px; padding:74px 38px 0 0;}
.anniversary14th .special .line {right:0; height:170px;}

.giftbox {padding:81px 0 74px; background-color:#fff;}

.gallery {overflow:hidden;}
.gallery img {width:100%;}
.gallery .left, .gallery .right {float:left; width:50%;}
.gallery ul {overflow:hidden;}
.gallery ul li {float:left; width:50%;}
.gallery ul li.full {width:100%;}

.ithinkso {height:171px; padding:70px 0; background-color:#333333;}
.ithinkso p {margin-bottom:30px;}

.noti {background-color:#eee;}
.noti .inner {position:relative; width:1060px; margin:0 auto; padding:75px 0; text-align:left;}
.noti h4 {margin-bottom:34px;}
.noti ul li {margin-top:5px; padding:0 0 0 13px; background:url(http://fiximage.10x10.co.kr/web2015/common/blt10.gif) 0 5px no-repeat; color:#666; font-size:11px; line-height:1.5em;}
.noti ul li span, .noti ul li strong {color:#d60c0c;}
.noti .link {color:#d60c0c; font-weight:bold; text-decoration:underline;}
.noti .btn {margin-top:-2px; vertical-align:middle;}
.noti .btn span {color:#fff;}
.noti .total {position:absolute; top:30px; right:-15px;}

.anniversary14th .brand {width:1080px; margin:0 auto; padding-bottom:30px;}
.anniversary14th .brand ul {overflow:hidden;}
.anniversary14th .brand ul li {float:left; margin:0 10px;}
.anniversary14th .brand ul li a {overflow:hidden; display:block; position:relative; width:520px; height:310px;}
.anniversary14th .brand ul li a span img {transition:transform 1.2s ease-in-out;}
.anniversary14th .brand ul li a:hover span img {transform:scale(1.1);}
.anniversary14th .brand ul li p {position:absolute; top:0; left:0;}
</style>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">

						<%' [66515] 생일엔 선물 - 구매사은 %>
						<div class="anniversary14th">
							<!-- 14th common : header & nav -->
							<!-- #include virtual="/event/14th/header.asp" -->

							<div class="topic">
								<div class="hgroup">
									<p>생일에는 선물도 쏠 줄 알아야 한다</p>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/tit_birthday_gift_v3.png" alt="생일엔 선물" /></h3>
									<p>14번째 생일을 맞이한 텐바이텐이 쇼핑을 즐긴 당신에게 선물을 드립니다.</p>
								</div>

								<div class="asbeit">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/txt_as_is_it.png" alt="텐바이텐의 정직함을 담은 Black 경쾌함을 닮은 Red 우리의 모습 그대로" /></p>
									<span class="line"></span>
								</div>
								<div class="special">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/txt_special_v2.png" alt="당모던함과 트렌디한 감성을 담아 바쁜 일상 속 휴식을 당신을 조금 더 향기롭게" /></p>
									<span class="line"></span>
								</div>
							</div>

							<div class="giftbox">
								<ul>
									<!-- 솔드아웃 img_gift_0*_soldout.jpg 붙이면 됨 -->
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_gift_01_soldout.jpg" alt="5만원 이상 구매시 14주년 에디션 머그컵 또는 텐바이텐 2천 마일리지" /></li>
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_gift_02_v2_soldout.jpg" alt="10만원 이상 구매시 드레스&amp;룸 퍼퓸스프레이 또는 텐바이텐 5천 마일리지" /></li>
								</ul>
							</div>

							<div id="gallery" class="gallery">
								<div class="left">
									<ul>
										<li class="full"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_gallery_01_v2.jpg" alt="" /></li>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_gallery_02.jpg" alt="" /></li>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_gallery_03_v2.jpg" alt="" /></li>
									</ul>
								</div>
								<div class="right">
									<ul>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_gallery_04.jpg" alt="" /></li>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_gallery_05_v2.jpg" alt="" /></li>
										<li class="full"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_gallery_06.jpg" alt="" /></li>
									</ul>
								</div>
							</div>

							<!--div class="ithinkso">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/txt_ithinkso.png" alt="텐바이텐 14주년 에디션 상품은 ithinkso와 함께합니다. 다양한 취향을 존중하여 기본에 충실하게 제작하는 라이프잡화 브랜드 ithinkso 합리적인 가격대와 실용적인 상품을 모두 국내에서 생산하고 실제 가방을 사용하면서 필요하다고 느끼는 부분을 모티브로 하는 아이띵소의 모든 제품에는 각각 고유의 이야기를 가지고 있습니다." /></p>
								<a href="http://www.10x10.co.kr/1363777" class="btnBrand"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/btn_brand.gif" alt="아이띵소 상품 더 보러가기" /></a>
							</div-->

							<div class="noti">
								<div class="inner">
									<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/tit_how_to_get.png" alt="14주년 사은품 이렇게 하면 받을 수 있어요!" /></h4>
									<ul>
										<li>텐바이텐 사은 이벤트는 <span>텐바이텐 회원</span>님을 위한 혜택입니다. (비회원 구매 시, 증정 불가)</li>
										<li>
											<a href="/event/eventmain.asp?eventid=66572" title="제가 바로 텐바이텐 배송 입니다." class="link">텐바이텐 배송상품</a>을 포함해야 사은품 선택이 가능합니다.
											<a href="/event/eventmain.asp?eventid=66572" title="제가 바로 텐바이텐 배송 입니다." class="btn btnS2 btnRed">
												<span class="fn whiteArr03">텐바이텐 배송상품 보러 가기</span>
											</a>
										</li>
										<li>업체배송 상품으로만 구매시 마일리지만 선택 가능합니다.</li>
										<li>상품 쿠폰, 보너스 쿠폰 등의 사용 후 <strong>구매 확정액이 5/10만원 이상</strong> 이상이어야 합니다.</li>
										<li>마일리지, 예치금, Gift카드를 사용하신 경우에는 구매 확정액에 포함되어 사은품을 받을 수 있습니다.</li>
										<li>텐바이텐 Gift카드를 구매하신 경우에는 사은품 증정이 되지 않습니다.</li>
										<li>마일리지는 차후 일괄 지급 이며, 1차 : 10월 23일 (~16일까지 주문내역 기준) / 2차 : 10월 30일 (10/17~26일까지 주문내역 기준) 지급됩니다.</li>
										<li>환불이나 교환 시, 최종 구매가격이 사은품 수령 가능금액 미만일 경우 사은품과 함께 반품해야 합니다.</li>
										<li>각 상품별 한정 수량이므로, 조기 소진될 수 있습니다.</li>
									</ul>
									<p class="total"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_total.png" alt="구매 확정액을 확인해주세요" /></p>
								</div>
							</div>

							<div class="brand">
								<ul>
									<li>
										<a href="/street/street_brand_sub06.asp?makerid=ithinkso" title="아이띵소 브랜드 더 보러가기">
											<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_brand_01.jpg" alt="14주년 에디션 머그컵 with ithinkso" /></span>
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/txt_brand_01.png" alt="다양한 취향을 존중하여 기본에 충실하게 제작하는 라이프 잡화 브랜드 아이띵소! 합리적인 가격대와 실용적인 상품을 모두 국내에서 생산하는 아이띵소의 모든 제품에는 각각 고유의 이야기를 갖고 있습니다." /></p>
										</a>
									</li>
									<li>
										<a href="/street/street_brand_sub06.asp?makerid=trendi" title="드레스&amp;룸 브랜드 더 보러가기">
											<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_brand_02.jpg" alt="드레스&amp;룸 퍼퓸 스프레이 with W.DRESSROOM" /></span>
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/txt_brand_02.png" alt="진한 풀 내음으로 시작되는 향, 당신에게 잠시나마 자연의 푸른 매력을 선물합니다. 텐바이텐과 더블유 드레스룸이 만나서 만드는 향기의 향연! 장미정원을 산책하는 기분을 즐겨 보세요." /></p>
										</a>
									</li>
								</ul>
							</div>

							<div class="bnr">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66515/img_bnr_kakao_pay.png" alt="지금 텐바이텐 모바일에서 카카오 페이로 첫 결제하면 3,000원 즉시 할인! 선착순 3천명! 3만원 이상 구매 시, 3천원 즉시 할인!" /></p>
							</div>

						</div>
						<!-- //[66515] 생일엔 선물 - 구매사은 -->

					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script type="text/javascript">
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 200 ) {
			giftAnimation();
		}
		if (scrollTop > 2000 ) {
			galleryAnimation();
		}
		/*if (scrollTop > 2900 ) {
			ithinksoAnimation();
		}*/
	});

	/* gift intro */
	$(".asbeit p, .special p").css({"opacity":"0"});
	$(".asbeit p").css({"margin-left":"7px"});
	$(".special p").css({"margin-top":"7px"});
	$(".asbeit span, .special span").css({"height":"0"});
	function giftAnimation() {
		$(".asbeit .line").delay(100).animate({"height":"215px"},400);
		$(".asbeit p").delay(400).animate({"margin-left":"0", "opacity":"1"},600);
		$(".special .line").delay(900).animate({"height":"170px"},400);
		$(".special p").delay(1200).animate({"margin-top":"0", "opacity":"1"},600);
	}

	/* gallery */
	$(".gallery ul li img").css({"opacity":"0"});
	function galleryAnimation() {
		$(".gallery .left ul li:nth-child(1) img").delay(100).animate({"opacity":"1"},600);
		$(".gallery .right ul li:nth-child(3) img").delay(300).animate({"opacity":"1"},600);
		$(".gallery .left ul li:nth-child(3) img").delay(600).animate({"opacity":"1"},600);
		$(".gallery .right ul li:nth-child(2) img").delay(900).animate({"opacity":"1"},600);
		$(".gallery .right ul li:nth-child(1) img").delay(1200).animate({"opacity":"1"},600);
		$(".gallery .left ul li:nth-child(2) img").delay(1500).animate({"opacity":"1"},600);
	}

	/*$(".ithinkso p").css({"height":"0", "opacity":"0"});
	$(".ithinkso a").css({"opacity":"0"});
	function ithinksoAnimation() {
		$(".ithinkso p").delay(500).animate({"height":"105px", "opacity":"1"},1000);
		$(".ithinkso a").delay(1500).animate({"opacity":"1"},1200);
	}*/

});
</script>
</body>
</html>