<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim eCode 

IF application("Svr_Info") = "Dev" THEN
	eCode = "66194"
Else
	eCode = "72782"
End If

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 더핑거스를 응원해줘")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
%>
<style type="text/css">
img {vertical-align:top;}
.cheerUpFingers .cheerCont {position:relative; width:1140px; margin:0 auto;}
.cheerUpFingers .cheerHead {overflow:hidden; background:#f5fbfb; text-align:center;}
.cheerUpFingers .cheerHead .cheerCont {height:733px; }
.cheerUpFingers .cheerHead .open {position:relative; padding-top:94px;}
.cheerUpFingers .cheerHead .title h2 {position:relative; margin:-17px 0 0 -52px;}
.cheerUpFingers .cheerHead .title p {position:relative; padding-top:23px;}
.cheerUpFingers .cheerHead .title .heart {display:inline-block; position:absolute; right:202px; top:85px;}
.cheerUpFingers .cheerHead .device {position:absolute; left:0; bottom:0; width:100%; height:405px;}
.cheerUpFingers .cheerHead .device p {position:absolute; left:94px; top:136px;}
.cheerUpFingers .cheerHead .device .pc {position:absolute; top:86px; right:98px; z-index:20;}
.cheerUpFingers .cheerHead .device .mobile {position:absolute; bottom:0; left:495px; z-index:30;}
.cheerUpFingers .preview {padding:80px 0 120px; text-align:center; background:#fff;}
.cheerUpFingers .preview .only {padding-bottom:10px;}
.cheerUpFingers .preview .swiper-container {width:810px; height:493px; margin:0 auto;}
.cheerUpFingers .preview .swiper-slide {float:left;}
.cheerUpFingers .preview .frame .txt {padding-bottom:50px;}
.cheerUpFingers .preview .frame ul {overflow:hidden; width:810px; }
.cheerUpFingers .preview .frame li {float:left; padding:5px;}
.cheerUpFingers .preview .frame li a {display:block; position:relative;}
.cheerUpFingers .preview .frame li span {display:none; position:absolute; left:0; top:0;}
.cheerUpFingers .preview button {position:absolute; top:248px; background:transparent; cursor:pointer;}
.cheerUpFingers .preview .btnPrev {left:90px;}
.cheerUpFingers .preview .btnNext {right:90px;}
.cheerUpFingers .preview .pagination {position:absolute; left:0; bottom:-42px; width:100%; height:10px; text-align:center;}
.cheerUpFingers .preview .pagination span {display:inline-block; width:10px; height:10px; margin:0 7px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72782/btn_pagination.png) 0 0 no-repeat; vertical-align:top;}
.cheerUpFingers .preview .pagination span.swiper-active-switch {background-position:100% 0;}
.cheerUpFingers .fingersBenefit {text-align:center;}
.cheerUpFingers .fingersBenefit .b1 {padding:50px 0; background:#e9fac0;}
.cheerUpFingers .fingersBenefit .b2 {padding:65px 0 105px;; background:#fdfff5;}
.cheerUpFingers .thefingersEvent {padding:65px 0 95px; text-align:center; background:#fbffee;}
.cheerUpFingers .thefingersEvent ul {overflow:hidden; padding-bottom:70px;}
.cheerUpFingers .thefingersEvent li {float:left;}
.cheerUpFingers .shareFriends {background:#cee248;}
.cheerUpFingers .shareFriends a {position:absolute; top:25px;}
.cheerUpFingers .shareFriends a.btnFb {right:225px;}
.cheerUpFingers .shareFriends a.btnTw {right:144px;}
</style>
<script type="text/javascript">
$(function(){
	var mySwiper = new Swiper('.preview .swiper-container',{
		pagination:'.preview .pagination',
		loop:true,
		grabCursor: true,
		paginationClickable: true
	});
	$('.preview .btnPrev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});
	$('.preview .btnNext').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
	$('.preview .frame li a').mouseover(function(){
		$(this).children('span').fadeIn(300);
	});
	$('.preview .frame li a').mouseleave(function(){
		$(this).children('span').fadeOut(300);
	});

	/* title animation */
	titleAnimation()
	$(".title h2").css({"top":"-8px","opacity":"0"});
	$(".title p").css({"top":"5px","opacity":"0"});
	$(".title .heart").css({"opacity":"0"});
	function titleAnimation() {
		$(".title h2").delay(100).animate({"top":"5px", "opacity":"1"},500).animate({"top":"0"},500);
		$(".title p").delay(900).animate({"top":"0", "opacity":"1"},600);
		$('.open').delay(1600).effect("pulsate", {times:2},500 );
		$(".title .heart").delay(900).animate({"opacity":"1"},500);
	}
	function swing () {
		$(".title .heart").animate({"margin-top":"8px"},1000).animate({"margin-top":"0"},1000, swing);
	}
	swing();
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
<div class="evt72782 cheerUpFingers">
	<!-- title -->
	<div class="cheerHead">
		<div class="cheerCont">
			<p class="open"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_open.png" alt="9월 19일 정식 오픈!" /></p>
			<div class="title">
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/tit_cheerup.png" alt="더핑거스를 응원해줘!" /></h2>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_new.png" alt="핑거스 아카데미가 핸드메이드 전문 플랫폼 더핑거스로 새단장하였습니다. 응원 댓글 남기고, 특별한 선물 받아가세요!" /></p>
				<span class="heart"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_heart.png" alt="" /></span>
			</div>
			<div class="device">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_mobile.png" alt="언제 어디서나 핸드메이드 쇼핑하세요! 더핑거스 모바일웹 오픈" /></p>
				<div class="pc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_pc.png" alt="" /></div>
				<div class="mobile"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_phone.png" alt="" /></div>
			</div>
		</div>
	</div>
	<!--// title -->

	<!-- 더핑거스 소개 -->
	<div class="preview">
		<p class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_only.png" alt="오직 더핑거스에서만!" /></p>
		<div class="cheerCont">
			<button class="btnPrev" ><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/btn_prev.png" alt="이전" /></button>
			<button class="btnNext" ><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/btn_next.png" alt="다음" /></button>
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<div class="frame">
							<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_unique.png" alt="인스타에서 핫한, 유니크한 작품" /></p>
							<ul>
								<li>
									<a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6012" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_unique_1.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_unique_1_over.png" alt="홈/인테리어" /></span>
									</a>
								</li>
								<li>
									<a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=5983" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_unique_2.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_unique_2_over.png" alt="핸드메이드 주얼리" /></span>
									</a>
								</li>
								<li>
									<a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=5957" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_unique_3.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_unique_3_over.png" alt="수제푸드" /></span>
									</a>
								</li>
								<li class="last">
									<a href="http://www.thefingers.co.kr/diyshop/shop_list.asp?dispcate=101" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_unique_4.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_unique_4_over.png" alt="핸드메이드 작품 더 보러 가기" /></span>
									</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="frame">
							<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_handmade.png" alt="작가님께 배우는 핸드메이드 클래스" /></p>
							<ul>
								<li>
									<a href="http://www.thefingers.co.kr/lecture/lecturedetail.asp?lec_idx=14614" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_handmade_1.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_handmade_1_over.png" alt="나도 바리스타" /></span>
									</a>
								</li>
								<li>
									<a href="http://www.thefingers.co.kr/lecture/lecturedetail.asp?lec_idx=14597" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_handmade_2.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_handmade_2_over.png" alt="셀프 웨딩 화관만들기" /></span>
									</a>
								</li>
								<li>
									<a href="http://www.thefingers.co.kr/lecture/lecturedetail.asp?lec_idx=14515" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_handmade_3.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_handmade_3_over.png" alt="셀프워크샵 페이퍼액자 만들기" /></span>
									</a>
								</li>
								<li class="last">
									<a href="http://www.thefingers.co.kr/lecture/lecturelist.asp" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_handmade_4.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_handmade_4_over.png" alt="핸드메이드 클래스 더 보러 가기" /></span>
									</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="frame">
							<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_kit.png" alt="발손도 금손이 되는 DIY KIT" /></p>
							<ul>
								<li>
									<a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6081" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_kit_1.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_kit_1_over.png" alt="자수 액자 만들기" /></span>
									</a>
								</li>
								<li>
									<a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=5920" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_kit_2.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_kit_2_over.png" alt="리드 디퓨저 만들기" /></span>
									</a>
								</li>
								<li>
									<a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6077" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_kit_3.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_kit_3_over.png" alt="스트링 아트 만들기" /></span>
									</a>
								</li>
								<li class="last">
									<a href="http://www.thefingers.co.kr/diyshop/shop_list.asp?dispcate=111102" target="_blank">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_kit_4.jpg" alt="" />
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/img_kit_4_over.png" alt="DIY KIT 더 보러 가기" /></span>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="pagination"></div>
		</div>
	</div>
	<!--// 더핑거스 소개 -->
	<div class="thefingersEvent">
		<div class="cheerCont">
			<ul>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_event_1.png" alt="EVENT1:더 핑거스 고객님께 드리는 마일리지 찬스! - 이벤트 기간 동안 더핑거스에서 상품 구매 시, 적립 마일리지가 10배!" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_event_2.png" alt="EVENT2:더핑거스의 최고의 서비스는? - 더핑거스에게 응원메세지를 남겨주세요. 5분께 팝아트 초상화를 그려드립니다." /></li>
			</ul>
			<a href="http://www.thefingers.co.kr/event/openevent/ch01/?ta=10x10_PC" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/btn_go.gif" alt="이벤트 확인하러 가기" /></a>
		</div>
	</div>

	<%' for dev msg : sns %>
	<div class="shareFriends">
		<div class="cheerCont">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/txt_share.png" alt="핸드메이드 감성을 좋아하는 친구들에게 더핑거스 오픈 소식을 알려주세요!" /></p>
			<a href="" class="btnFb" target="_blank" onclick="snschk('fb');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/btn_fb.png" alt="페이스북으로 공유" /></a>
			<a href="" class="btnTw" target="_blank" onclick="snschk('tw');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72782/btn_twitter.png" alt="트위터로 공유" /></a>
		</div>
	</div>
</div>