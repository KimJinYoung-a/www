<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  아리따움10주년이벤트
' History : 2018-08-30 최종원 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<style type="text/css">
.topic {height:994px; padding-top: 94px; background:#ff77a7 url(http://webimage.10x10.co.kr/fixevent/event/2018/88637/bg_top.jpg)no-repeat 50% 0;}
.rolling {position:relative; z-index:10; width:1039px; height:660px; margin:95px auto 0; background-color:#fff;}
.rolling .slidesjs-container,
.rolling .slidesjs-control,
.rolling .swiper-slide {height:660px !important;}
.rolling .swiper-wrapper, 
.rolling .swiper-container {overflow:visible !important;}
.rolling .slidesjs-navigation {position:absolute; top:50%; left:50%; z-index:20; width:35px; height:94px; margin-top:-47px; text-indent:-999em;}
.rolling .slidesjs-previous {margin-left:520px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88637/btn_next.png);}
.rolling .slidesjs-next {margin-left:-554px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88637/btn_prev.png);}
.special-item {position:relative; padding:88px 0 106px; background-color:#ffe0e7;}
.special-item:before {position:absolute; top:-389px; left:0; height:389px; width:100%; background-color:#ffe0e7; content:' ';}
.special-item h3 {margin-bottom:83px;}
.special-item a {display:inline-block; position:absolute; top:55px; left:50%; margin-left:325px;  animation:bounce .8s 100; }
.way {height:553px; padding-top:120px; background:#c592f5 url(http://webimage.10x10.co.kr/fixevent/event/2018/88637/bg_way.jpg) no-repeat 50% 0;}
.way h3 {margin-bottom:60px;}
.noti {position:relative; padding:90px 0 66px; background-color:#522c74;}
.noti h4 {position:absolute; top:149px; left:50%; margin-left:-350px;}
.noti ul {width:780px; margin:0 auto; padding-left:360px;}
.noti ul li {color:#fff; font-size:14px; line-height:2.13; font-family:"malgun Gothic","맑은고딕", Dotum, "돋움", sans-serif; text-align:left; }
.noti ul li em {color:#ff99b1;}
@keyframes bounce {
	from to {transform:translateY(12px); animation-timing-function:ease-out;}
	50% {transform:translateY(-12px); animation-timing-function:ease-in;}
}
</style>
<script>
$(function() {
	$('.rolling .swiper-wrapper').slidesjs({
		width:930,
		height:575,
		pagination:false,
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:false},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.rolling .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});
</script>
<div class="evt88637">
                        <div class="topic">
                            <h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/tit_aritaum.png" alt="아리따움 10주년 기념 천원의 행복" /></h2>
                            <div class="rolling">
								<div class="swiper-container">
									<div class="swiper-wrapper">
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/img_slide_1.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/img_slide_2.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/img_slide_3.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/img_slide_4.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/img_slide_5.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/img_slide_6.jpg" alt="" /></div>
									</div>
								</div>
							</div>
                        </div>
                        <div class="special-item">
                            <h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/tit_special_item.png" alt="아리따움 스페셜 에디션 구매하면 프로모션 상품이 1,000원!"></h3>
                            <img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/img_spcial_item.jpg" alt="" usemap="#map-gift">
							<map name="map-gift" id="map-gift">
								<area  alt="파우치" href="/shopping/category_prd.asp?itemid=2074432&pEtr=88637" shape="rect" coords="10,0,235,291" onfocus="this.blur();" target="_blank" />
								<area  alt="티슈케이스" href="/shopping/category_prd.asp?itemid=2074445&pEtr=88637" shape="rect" coords="276,2,497,291" onfocus="this.blur();" target="_blank" />
								<area  alt="노트3종 키트" href="/shopping/category_prd.asp?itemid=2074465&pEtr=88637" shape="rect" coords="540,0,760,291" onfocus="this.blur();" target="_blank" />
								<area  alt="하드케이스 노트" href="/shopping/category_prd.asp?itemid=2074453&pEtr=88637" shape="rect" coords="803,0,1026,291" onfocus="this.blur();" target="_blank" />
							</map>
                            <a href="#groupBar1"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/btn_go.png" alt="스페셜 에디션 구경하기"></a>
                        </div>
                        <div class="way">
                            <h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/tit_way.png" alt="프로모션 상품 1,000원에 구매하는 방법 "></h3>
                            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/txt_way.png" alt="아리따움 스페셜 에디션 구매 / 구매 완료 후 쿠폰 발급 팝업 확인 / 쿠폰 적용 후 1,000원으로 구매! "></p>
                        </div>
                        <div class="noti">
                            <h4><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/txt_noti.png" alt="유의사항"></h4>
							<ul>
								<li>· 본 이벤트는 로그인 후에 참여할 수 있습니다.</li>
								<li>· 아리따움 10주년 스페셜 에디션을 구매하신 분에 한하여, 프로모션 상품 할인 쿠폰이 지급됩니다.</li>
								<li>· 프로모션 상품은 할인 쿠폰을 사용하여 1,000원에 구매할 수 있습니다.</li>
								<li>· 프로모션 상품은 할인 쿠폰 없이 5,000원에 구매 가능합니다.</li>
								<li><em>· 이벤트는 상품 품절 시 조기 마감될 수 있습니다.</em></li>
							</ul>
                        </div>
                    </div>						
<!-- #include virtual="/lib/db/dbclose.asp" -->