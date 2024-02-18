<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'####################################################
' Description : 2017 완소품 개발 X
' History : 2017-03-31 이종화
'####################################################

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=77063" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

%>
<!-- #include virtual="/event/2017props/sns.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<style>
.giftContainer {background:#abf1d9 url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/bg.png) 50% 0 repeat-x;}
.giftContainer .inner {background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/bg_img.png) 50% 0 no-repeat;}
.titWrap {position:relative; padding-top:102px;}
.titWrap h2 {position:relative; margin-top:20px;}
.titWrap span {display:block; margin-top:25px;}
.titWrap i {display:block; position:absolute; left:50%; top:225px; margin-left:-225px; width:449px; height:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_deco.png) 50% 0 no-repeat; transform-origin:100% 100%;}
.itemWrap {position:relative; margin-top:81px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/bg_deco.png) 50% 108px no-repeat;}
.itemWrap h3 {animation:bounce 1.8s infinite;}
.itemWrap .item1 {margin-top:-10px;}
.itemWrap .item2 {margin-top:-40px;}
.itemWrap i {display:block; position:absolute; left:50%;}
.itemWrap i.leaf1 {top:105px; width:43px; height:33px; margin-left:-534px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_deco2.png) 0 0 no-repeat; animation:rotate 2s 1.5s 10 alternate; transform-origin:100% 100%;}
.itemWrap i.leaf2 {top:72px; width:58px; height:100px; margin-left:-419px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_deco3.png) 0 0 no-repeat;}
.itemWrap i.leaf3 {top:574px; width:29px; height:48px; margin-left:-185px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_deco4.png) 0 0 no-repeat;}
.itemWrap i.leaf4 {top:661px; width:34px; height:35px; margin-left:406px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_deco5.png) 0 0 no-repeat;}
.itemWrap i.leaf5 {top:634px; width:39px; height:38px; margin-left:446px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_deco6.png) 0 0 no-repeat; animation:rotate 1s 1s 10 alternate; transform-origin:0 100%;}

.itemSlide {padding:127px 0 70px 0;}
.fullSlide {overflow:visible !important; width:952px; padding-bottom:40px; margin:0 auto;}
.fullSlide .swiper-container {overflow:visible !important; width:926px; padding:13px; background-color:#fff;}
.fullSlide .swiper-wrapper {overflow:visible !important; width:926px;}
.slideTemplateV15 .slidesjs-pagination {bottom:-50px;}
.slideTemplateV15 .slidesjs-navigation {width:67px; height:74px;}
.slideTemplateV15 .slidesjs-previous {left:-40px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/btn_slide_prev.png) no-repeat 0 0;}
.slideTemplateV15 .slidesjs-previous:hover {background-position:0 0;}
.slideTemplateV15 .slidesjs-next {right:-40px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/btn_slide_next.png) no-repeat 0 0;}
.slideTemplateV15 .slidesjs-next:hover {background-position:0 0;}
.evtNoti {background-color:#97dec7;}
.evtNoti li strong {color:#ea2626;}
.evtNoti li .btnRed {background-color:#dc4545; border:1px solid #dc4545;}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(7px); animation-timing-function:ease-in;}
}
@keyframes rotate {
	from {transform:rotate(10deg); -webkit-transform:rotate(10deg); animation-timing-function:ease-out;}
	to {transform:rotate(0deg); -webkit-transform:rotate(0deg); animation-timing-function:ease-out;}
}
</style>
</head>
<script>
$(function(){
	// full slide
	$('.fullSlide .swiper-wrapper').slidesjs({
		width:926,
		height:575,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.fullSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	animation()
	$(".titWrap i").css({"height":"0"});
	function animation() {
		$(".titWrap i").delay(100).animate({"height":"80px"},900);
	}
});
</script>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<div class="sopum giftWrap">
							<!-- #include virtual="/event/2017props/head.asp" -->
							<div class="giftContainer">
								<div class="inner">
									<div class="titWrap">
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/tit_text1.png" alt="완전 소중한 사은품" /></p>
										<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/tit.png" alt="완소품" /></h2>
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/text_desp.png" alt="생활 속 꼭 필요한 아이템이 선물로! 쇼핑하고 선착순 한정수량 사은품도 받으세요!" /></span>
										<i></i>
									</div>

									<div class="itemWrap">
										<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/subtit01.png" alt="5만원 이상 구매 시" /></h3>
										<div class="item1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_gift1.png" alt="5만원 이상 구매 시 텐바이텐 자수 수건(2종 중 1종 랜덤 발송) 또는 2,000 마일리지 제공" /></div>
										<h3 style="margin-top:122px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/subtit02_v1.png" alt="30만원 이상 구매 시" /></h3>
										<div class="item2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_gift2_soldout.png" alt="30만원 이상 구매 시 브리오신 집들이 선물세트 또는 15,000 마일리지 제공" usemap="#itemlink" /></div>
										<map id="itemlink" name="itemlink">
											<area shape="rect" coords="2,2,397,420" href="/shopping/category_prd.asp?itemid=1378730&pEtr=77063" alt="브리오신 집들이 선물세트(선물 포장 박스 포함)" />
										</map>
										<i class="leaf1"></i>
										<i class="leaf2"></i>
										<i class="leaf3"></i>
										<i class="leaf4"></i>
										<i class="leaf5"></i>

										<div class="itemSlide">
											<div class="slideTemplateV15 fullSlide">
												<div class="swiper-container">
													<div class="swiper-wrapper">
														<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_slide1.jpg" alt="" /></div>
														<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_slide2.jpg" alt="" /></div>
														<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_slide3.jpg" alt="" /></div>
														<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77063/img_slide4.jpg" alt="" /></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="evtNoti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>텐바이텐 사은 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 시, 증정 불가)</li>
										<li>텐바이텐 배송상품을 포함해야 사은품 선택이 가능합니다. <a title="페이지 이동됩니다" class="btn btnS3 btnRed lMar05" href="/event/eventmain.asp?eventid=65618"><span class="whiteArr01 fn">텐바이텐 배송상품 보러가기</span></a></li>
										<li>업체배송 상품으로만 구매시 마일리지만 선택 가능합니다.</li>
										<li>상품 쿠폰, 보너스 쿠폰 등의 사용 후 구매 확정액이 <strong>5/30만원 이상</strong>이어야 합니다. (단일주문건 구매 확정액)</li>
										<li>마일리지, 예치금, Gift카드를 사용하신 경우에는 구매 확정액에 포함되어 사은품을 받을 수 있습니다.</li>
										<li>텐바이텐 Gift카드를 구매하신 경우에는 사은품 증정이 되지 않습니다.</li>
										<li>마일리지는 차후 일괄 지급 입니다.<br /><strong>1차 : 4월12일 수요일</strong> (~7일 자정까지 결제완료 기준) / <strong>2차 : 4월25일 화요일</strong> (4/8~17일까지 결제완료 기준)</li>
										<li>환불이나 교환 시, 최종 구매가격이 사은품 수령 가능금액 미만일 경우 사은품과 함께 반품해야 합니다.</li>
										<li>각 상품별 한정 수량이므로, 조기 소진될 수 있습니다.</li>
									</ul>
								</div>
							</div>
							<%'!-- sns -- include 파일 확인%>
							<div class="sns"><%=snsHtml%></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>