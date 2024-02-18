<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 월드비전 sns 공유
' History : 2016.12.02 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode

IF application("Svr_Info") = "Dev" THEN
	eCode = "66249"
Else
	eCode = "74753"
End If

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 월드비전과 함께하는 2017 캘린더!")
snpLink		= Server.URLEncode("http://10x10.co.kr/event/" & ecode)
snpPre		= Server.URLEncode("10x10")
%>
<style type="text/css">
img {vertical-align:top; text-align:center;}
.evt74753 {background:#f0f0ed;}
.happyTit{position:relative; height:365px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74753/bg_tit.jpg) 50% 0 no-repeat;}
.happyTit h2 {padding-top:124px;}
.happyTit p {position:absolute; top:34px; left:50%; margin-left:-570px;}
.item {padding:85px 0 75px;}
.item p{padding-top:22px;}
.hope {background:#7a6762 url(http://webimage.10x10.co.kr/eventIMG/2016/74753/bg_hope.jpg) 50% 0 no-repeat; padding:67px 0;}
.hope02 {position:relative; background:#7a6762 url(http://webimage.10x10.co.kr/eventIMG/2016/74753/bg_hope.jpg) 50% 0 no-repeat; padding:48px 0 76px;}
.hope02 a {position:absolute; left:50%; margin-left:-117px; bottom:40px;}
.benefits {padding:60px 0 100px; background:#ec6d2e;}
.snsShare {position:relative; height:150px; background:#a44718;}
.snsShare p {float:left; position:absolute; left:50%; margin-left:-502px; top:67px;}
.snsShare ul {overflow:hidden; width:393px; position:absolute; top:47px; left:50%; margin-left:63px;}
.snsShare ul li {float:left;}
.snsShare ul li.tw{padding-left:22px;}
</style>
<script>
$(function(){
	var evtSwiper = new Swiper('.wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:3500,
		simulateTouch:false,
		pagination:'.wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'.wideSwipe .btnNext',
		prevButton:'.wideSwipe .btnPrev'
	})
	$('.wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
});
</script>
	<div class="evt74753">
		<div class="happyTit">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/txt_tit.png" alt="HAPPY ANDING 월드비전과 함께하는 2017 캘린더 작은 기적을 함께 해주세요!" /></h2>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/txt_date.png" alt="이벤트기간:2016.12.05-12.31" /></p>
		</div>
		<div class="slideTemplateV15 wideSwipe">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/img_slide_01.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/img_slide_02.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/img_slide_03.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/img_slide_04.jpg" alt="" /></div>
				</div>
				<div class="pagination"></div>
				<button class="slideNav btnPrev">이전</button>
				<button class="slideNav btnNext">다음</button>
				<div class="mask left"></div>
				<div class="mask right"></div>
			</div>
		</div>
		<div class="item">
			<a href="/shopping/category_prd.asp?itemid=1612172&pEtr=74753"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/img_item_v3.png" alt="텐바이텐 X 월드비전 HAPPY ANDing 2017 달력 우리의 작은 나눔으로 이 세상 모든 어린이가 행복한 삶을 누릴 수 있어요 지구촌 모든 어린이가 불행한 끝을 맺지 않기를 바랍니다" /></a>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/txt_where_v2.png" alt="2017 캘린더 판매 수익금은 어디에 쓰이나요? 판매 수익금 중 일부는 13,262명의 캄보디아 프레비히아 지역 주민들에게 깨끗한 물과 새로운삶을 선물할 식수 위생 사업을 지원합니다." /></p>
		</div>

		<!-- <div class="hope"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/txt_hope.png" alt="끝이 아닌 함께 만드는 새로운 시작, 우리의 매일 매일이 진정한 해피앤딩이 되기를 바랍니다" /></div> -->
		<!-- <div class="hope02">~</div> 기획자 요청시 <div class="hope">~</div> 대신 노출   (12/06 예정)-->
		<div class="hope02">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/txt_hope_v2.png" alt="끝이 아닌 함께 만드는 새로운 시작, 우리의 매일 매일이 진정한 해피앤딩이 되기를 바랍니다" />
			<a href="https://goo.gl/H4fw3u"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/btn_go_campaign.png" alt="월드비전 해피엔딩 캠페인 바로 가기" /></a>
		</div>
		<div class="benefits"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/txt_benefits_v2.png" alt="월드비전과 함께하면 무엇을 도와줄 수 있나요? 건강 식수 교육 참여 정서" /></div>
		<div class="snsShare">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/txt_sns_share.png" alt="월드비전 2017 캠페인을 친구에게 소문 내 주세요" /></p>
			<ul>
				<li class="fb"><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','',''); return false;" ><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/img_fb.png" alt="페이스북 공유" /></a></li>
				<li class="tw"><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74753/img_tw.png" alt="트위터 공유" /></a></li>
			</ul>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->