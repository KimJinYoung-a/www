<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.4.6/css/swiper.css"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.4.6/js/swiper.min.js"></script>
<style style="text/css">
.tamgu {background:#ff6050 url(//webimage.10x10.co.kr/fixevent/event/2019/92166/bg_tamgu.jpg) 0 0 no-repeat; font-family:"Roboto","Noto Sans KR","malgun Gothic","맑은고딕",sans-serif;}
.tamgu .topic {position:relative; height:384px;}
.tamgu .topic h2 {padding:113px 0 0 176px; text-align:left;}
.tamgu .topic .btn-yt {position:absolute; top:0; right:0;}
.tamgu .latest {position:relative; padding:26px 0 26px 116px; margin-bottom:80px; text-align:left;}
.tamgu .latest iframe {width:578px; height:404px; vertical-align:top;}
.tamgu .conts {overflow:hidden; position:absolute; display:inline-block; top:0; left:700px; width:350px; height:100%;}
.tamgu .conts a {display:block; padding:80px 44px 0 34px; text-decoration:none;}
.tamgu .conts .type {display:inline-block; margin-left:-10px; margin-bottom:15px; height:30px; padding:0 12px; font-size:14px; line-height:30px; color:#fff; border-radius:15px; background-color:#9c65ff;}
.tamgu .conts .tit {display:block; padding-bottom:20px; margin-bottom:16px; font-weight:bold; font-size:24px; line-height:1.3; color:#222; letter-spacing:-1px; border-bottom:1px solid #ebebeb; white-space:nowrap;}
.tamgu .conts p {font-size:14px; line-height:1.73; color:#666; word-break:keep-all; margin-bottom:22px;}
.tamgu .conts .tag {overflow:hidden; width:300px;}
.tamgu .conts .tag li {float:left; margin:0 6px 6px 0;}
.tamgu .conts .tag li span {display:block; height:26px; padding:0 10px 0 9px; font-weight:bold; font-size:14px; line-height:27px; color:#222; background-color:#ebebeb;}
.tamgu .vod-more {background-color:#372d68;}
.tamgu .vod-more h3 {padding:46px 0 30px; text-align:center;}
.tamgu .slider {position:relative; padding:0 175px;}
.tamgu .slider .swiper-container {width:790px; padding-bottom:75px;}
.tamgu .slider .swiper-slide {width:250px;}
.tamgu .slider button {top:64px; width:19px; height:32px; margin-top:0; outline:0; background-color:transparent; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/92166/ico_arrow.png); background-size:19px 32px; border:0;}
.tamgu .slider .swiper-button-prev {left:100px; -webkit-transform:scaleX(-1); transform:scaleX(-1);}
.tamgu .slider .swiper-button-next {right:100px;}
.tamgu .slider .swiper-button-disabled {opacity:0.2;}
.tamgu .slider .swiper-pagination {bottom:40px; font-size:0;}
.tamgu .slider .swiper-pagination-bullet {width:5px; height:5px; background:#fff; opacity:0.3;}
.tamgu .slider .swiper-pagination-bullet-active {opacity:1;}
.tamgu .slider .thumbnail {overflow:hidden;}
.tamgu .slider .thumbnail img {width:100%;}
.tamgu .slider .tit {display:block; height:40px; font-weight:normal; font-size:14px; color:#fff; background-color:#4c427e; line-height:40px;}
.tamgu .bnr-floationg {display:none; position:fixed; right:50%; bottom:234px; z-index:1001; width:180px; margin-right:-600px;}
.tamgu .bnr-floationg a {display:block;}
.tamgu .bnr-floationg button {display:block; margin:10px auto 0; background:transparent; outline:0;}
.tamgu .bnr-floationg img {vertical-align:top;}
</style>
<script>
$(function(){
	var swiper = new Swiper('.slider .swiper-container', {
		width: 790,
		slidesPerView: 3,
		spaceBetween: 20,
		slidesPerGroup: 3,
		navigation: {
			nextEl: '.slider .swiper-button-next',
			prevEl: '.slider .swiper-button-prev'
		},
		pagination: {
			el: '.slider .swiper-pagination',
		}
	});
});
$(window).scroll(function(){
	var nowSt = $(this).scrollTop();
	var lastSt = $('.evtPdtListWrapV15:first').offset().top;
	if ( lastSt < nowSt ) {
		$(".bnr-floationg").show();
	} else {
		$(".bnr-floationg").hide();
	}
});
function setCookieTempBanner(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays*24*60*60*1000));
	var expires = "expires="+d.toUTCString();
	document.cookie = cname + "=" + cvalue + "; " + expires;
}
function bnrDispCtr(){
	$(window).unbind("scroll");
}
</script>
<!-- MKT 텐텐탐구생활 -->
<div class="evt92166 tamgu">
	<div class="topic">
		<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/92166/tit_tamgu.png" alt="텐텐 탐구생활"></h2>
		<a href="https://www.youtube.com/user/10x10x2010" target="_blank" class="btn-yt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92166/btn_yt.png" alt="10X10 채널 바로가기"></a>
	</div>
	<div class="latest">
		<iframe width="578" height="404" src="https://www.youtube.com/embed/LaYWrdtmVqg?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe>
		<div class="conts">
			<a href="https://www.youtube.com/watch?v=LaYWrdtmVqg&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=14" target="_blank">
				<span class="type">직장인 탐구</span>
				<strong class="tit">텐바이텐 직원 책상 구경하기</strong>
				<p>텐바이텐 직원들 책상은 어떨까?<br>대체 뭐가 이렇게 많을까?<br>너무 궁금해서 카메라를 들고 습격했다!</p>
				<ul class="tag">
					<li><span>#회사브이로그</span></li>
					<li><span>#책상습격</span></li>
					<li><span>#직원아이템</span></li>
				</ul>
			</a>
		</div>
	</div>
	<div class="vod-more">
		<h3><a href="https://www.youtube.com/user/10x10x2010" target="_blank"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92166/tit_vod_list.png" alt="텐텐, 조금 더 탐구해보기" title="텐텐, 조금 더 탐구해보기"></a></h3>
		<div class="slider">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=hGe_-4lIhlc&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=13" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/hGe_-4lIhlc/mqdefault.jpg" alt="여름 학교 시작"></div>
							<strong class="tit">여름 학교 시작</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=XWBu7oWf8SI&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=12" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/XWBu7oWf8SI/mqdefault.jpg" alt="두번째 클래스 후기"></div>
							<strong class="tit">두번째 클래스 후기</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=C2WEG8MuqpY&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=10" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/C2WEG8MuqpY/mqdefault.jpg" alt="여행 짐 싸기"></div>
							<strong class="tit">여행 짐 싸기</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=OGjALNIxtn4&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=9" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/OGjALNIxtn4/mqdefault.jpg" alt="가방 리뷰 2탄"></div>
							<strong class="tit">가방 리뷰 2탄</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=wINfjNzUoMU&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=8" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/wINfjNzUoMU/mqdefault.jpg" alt="어른이 장난감"></div>
							<strong class="tit">어른이 장난감</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=h5nRf0rsNU4&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=7" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/h5nRf0rsNU4/mqdefault.jpg" alt="에어프라이어 완전정복"></div>
							<strong class="tit">에어프라이어 완전정복</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=Mc1RYu_AUQM&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=6" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/Mc1RYu_AUQM/mqdefault.jpg" alt="텐바이텐 X 뉴트로"></div>
							<strong class="tit">텐바이텐 X 뉴트로</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=QlEB5ln1UPA&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=5" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/QlEB5ln1UPA/mqdefault.jpg" alt="원데이 클래스 후기"></div>
							<strong class="tit">원데이 클래스 후기</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=qW2iN7m4E1M&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=4" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/qW2iN7m4E1M/mqdefault.jpg" alt="신학기 데일리백 리뷰"></div>
							<strong class="tit">신학기 데일리백 리뷰</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=YGWHo2pJPQA&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=3" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/YGWHo2pJPQA/mqdefault.jpg" alt="텐텐문방구 브이로그"></div>
							<strong class="tit">텐텐문방구 브이로그</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=mpkIHjayfjc&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=2" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/mpkIHjayfjc/mqdefault.jpg" alt="텐텐문방구 스페셜"></div>
							<strong class="tit">텐텐문방구 스페셜 Q&amp;A</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=mjsyOMhqheg&list=PLape2ZVL06OIHyazmJC1FadHBkbFN7V-N&index=1&t=4s" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/mjsyOMhqheg/mqdefault.jpg" alt="다꾸캐슬"></div>
							<strong class="tit">다꾸캐슬</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/watch?v=soeHMUWHzCk&list=PLape2ZVL06OIppFZhLYSsTpB0D02sqGpd" target="_blank">
							<div class="thumbnail"><img src="https://i.ytimg.com/vi/soeHMUWHzCk/mqdefault.jpg" alt="막장의 품격"></div>
							<strong class="tit">막장의 품격</strong>
						</a>
					</div>
					<div class="swiper-slide">
						<a href="https://www.youtube.com/user/10x10x2010" target="_blank">
							<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92166/img_more.png" alt="콘텐츠 더보기"></div>
						</a>
					</div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
			<button class="swiper-button-prev"></button>
			<button class="swiper-button-next"></button>
		</div>	
	</div>
	<div class="bnr-yt">
		<a href="https://www.youtube.com/user/10x10x2010" target="_blank"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92166/bnr_yt.jpg" alt="텐바이텐 공식 유튜브 구독하고 더욱 다양한 콘텐츠를 확인해보세요!"></a>
	</div>
<% If Trim(request.Cookies("closeEvtBnr92166"))="" Then %>
	<div class="bnr-floationg" id="EvtBnr92166">
		<a href="https://www.youtube.com/user/10x10x2010" target="_blank"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92166/bnr_floating.png" alt="텐바이텐 공식 유튜브 구독하러 가기"></a>
		<button type="button" onclick="bnrDispCtr(); setCookieTempBanner('closeEvtBnr92166','Y',3);$('#EvtBnr92166').hide();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/92166/btn_anymore.png" alt="오늘 그만보기"></a>
	</div>
<% End If %>
</div>
<!-- // MKT 텐텐탐구생활 -->