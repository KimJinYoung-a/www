<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 에코백 시리즈 11월
' History : 2017-10-31 김송이 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<style type="text/css">
.finish-event {display:none;}
.ecoBag {width:1140px; margin:0 auto; background-color:#fff;}
.ecoBag h2 {padding:78px 0 74px;}
.ecoBag iframe {width:1140px; height:74px; vertical-align:top;}
.topic {position:relative; padding-top:47px;}
.topic a {display:block; position:absolute; bottom:0; right:0;}
.intro {padding:85px 0 73px; }

.itemInfo {position:relative; display:table; width:100%; height:570px; margin-bottom:40px; text-align:left;}
.itemInfo a {display:inline-block; text-decoration:none;}
.itemInfo .slide {position:relative; width:570px; height:570px; margin:0 auto;}
.itemInfo .thumbnail {position:absolute; top:0;}
.itemInfo .thumbnail span {position:absolute; left:0; top:0; z-index:30; opacity:0; transition:all .4s;}
.itemInfo .desc {display:table-cell; height:570px; padding-left:38px; vertical-align:middle;}
.itemInfo .desc h3 {padding:22px 0 38px;}
.itemInfo .desc .price {color:#df4b4b; font-size:18px; font-family:arial; font-weight:bold;}
.itemInfo .desc .price s {padding-right:15px; font-size:16px; color:#868686; font-weight:normal;}
.itemInfo .desc .price span {position:relative; padding-left:6px;}

.itemInfo.type1 {padding-left:570px;}
.itemInfo.type1 .thumbnail {left:0;}
.itemInfo.type2 .thumbnail {right:0;}
.itemInfo.type2 .desc {padding-left:50px;}
.itemInfo .viewMore {padding-top:40px; line-height:11px;}

.brandStory {margin-top:160px;}
.brandStory ul {overflow:hidden; margin:0 -6px; padding:14px 0;}
.brandStory ul li{float:left; position:relative; margin:0 6px; cursor:pointer;}
.brandStory ul li span {opacity:0; position:absolute; top:0; left:0;  transition:all 0.6s;}
.brandStory ul li:hover span {opacity:1;}

.collabo {padding:75px 0;}
.gallery .rolling .slideWrap {position:relative;}
.gallery .rolling .swiper-container {overflow:hidden; width:1140px; height:640px;}
.gallery .rolling .btnNav {display:block; position:absolute; bottom:175px; right:24px; width:14px; height:20px; text-indent:-9999em; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2017/79244/btn_nav.png) no-repeat 0 0;}
.gallery .rolling .btnNext {bottom:25px; background-position:100% 100%}
.gallery .rolling .pagination {position:absolute; bottom:36px; right:25px; z-index:50; }
.gallery .rolling .pagination span {display:block; width:8px; height:8px; margin:20px 0; border:2px solid #252525; border-radius:50%;background-color:transparent; cursor:pointer;}
.gallery .rolling .pagination .swiper-active-switch {background-color:#252525;}

.interview h3 {padding:135px 0 128px;}
.interview {padding-bottom:85px;}
</style>
</head>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	fnApplyItemInfoList({
		items:"1841012,1856182,1841011", //상품코드
		target:"lyrItemList",
		fields:["price","sale"],
		unit:"ew",
		saleBracket:true
	});

	/* gallery */
	var mySwiper = new Swiper('#rolling .swiper-container',{
		mode:'vertical',
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:'#rolling .pagination',
		paginationClickable:true,
		speed:1200,
		autoplay:2000
	});
	$('#rolling .btnPrev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});
	$('#rolling .btnNext').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});

	/* item */
	$('.itemInfo .slide1').slidesjs({
		width:570,
		height:671,
		play:{active: true,interval:2500, effect:'fade', auto:true},
		effect:{fade: {speed:900, crossfade:true}
		}
	});
	$('.itemInfo .slide2').slidesjs({
		width:570,
		height:671,
		play:{active: true,interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:900, crossfade:true}
		}
	});
	$('.itemInfo .slide3').slidesjs({
		width:570,
		height:671,
		play:{active: true,interval:3600, effect:'fade', auto:true},
		effect:{fade: {speed:900, crossfade:true}
		}
	});
});
</script>
<div class="evt82985 ecoBag">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/tit_ecobag.png" alt="월간 에코백" /></h2>
	<iframe id="iframe_ecobag" src="/event/etc/group/iframe_ecobag.asp?eventid=82985" width="1140" height="74" frameborder="0" scrolling="no" title="월간 에코백 메뉴"></iframe>

	<div class="topic">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/tit_ecobag.jpg" alt="#12월호 uncommon things : 베이직한 느낌이 좋다. (common things) 하지만, 특별하고 싶다. (uncommon thi" />
		<a href="#groupBar3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/btn_comment.png" alt="코멘트 남기러가기" /></a>
	</div>

	<div class="intro">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_intro.png" alt="이번 텐바이텐 월간 에코백은 언커먼띵스와 함께 했습니다. 어디에 매치해도 잘 어울리는 디자인.겨울과 어울리는 따뜻한 느낌을 주는 은은한 색감과 포근한 원단 올겨울을 따스하게 지켜줄 언커먼띵스 에코백을 소개 합니다." />
	</div>
	<!-- item -->
	<ul id="lyrItemList">
		<li class="itemInfo type1 lyr-item1841012">
			<a href="/shopping/category_prd.asp?itemid=1841012&pEtr=82985">
				<div class="slide slide1 thumbnail">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_1_1.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_1_2.jpg" alt="" /></div>
				</div>
				<div class="desc">
					<% if date() < "2017-12-28" then %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_sale.png" alt="12.14 ~ 12.27  단 2주간 단독 특가" /></p>
					<% end if %>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_item_1.png" alt="[텐바이텐 단독] 우븐 스트라이프 에코백_브라운" /></h3>
					<p class="price">
						<s>38,000</s>30,400won<span>[10%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" / ></p>
				</div>
			</a>
		</li>
		<li class="itemInfo type2 lyr-item1856182">
			<a href="/shopping/category_prd.asp?itemid=1856182&pEtr=82985">
				<div class="slide slide2 thumbnail">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_2_1.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_2_2.jpg" alt="" /></div>
				</div>
				<div class="desc">
					<% if date() < "2017-12-28" then %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_sale.png" alt="12.14 ~ 12.27  단 2주간 단독 특가" /></p>
					<% end if %>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_item_2.png" alt="[단독 선런칭 & 할인] 우븐 스트라이프 에코백_그레이" /></h3>
					<p class="price">
						<s>38,000</s>30,400won<span>[10%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
				</div>
			</a>
		</li>
		<li class="itemInfo type1 lyr-item1841011">
			<a href="/shopping/category_prd.asp?itemid=1841011&pEtr=82985">
				<div class="slide slide3 thumbnail">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_3_1.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_3_2.jpg" alt="" /></div>
				</div>
				<div class="desc">
					<% if date() < "2017-12-28" then %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_sale.png" alt="12.14 ~ 12.27  단 2주간 단독 특가" /></p>
					<% end if %>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_item_3.png" alt="[단독 선런칭 & 할인] 우븐 스트라이프 에코백_블랙" /></h3>
					<p class="price">
						<s>38,000</s>30,400won<span>[10%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
				</div>
			</a>
		</li>
	</ul>

	<div class="brandStory">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_story.jpg" alt="BRAND STORY 'common things but uncommon things' 흔하지만 흔하지 않은 것. uncommon things가 바라보는 흔하거나 흔하지 않은 세상을 많은 사람들에게 공유하고자 언커먼띵스가 느끼는 감성과 생각을 제품으로 표현하며 수작업으로 진행하고 공감할 수 있도록 노력합니다." /></div>
		<ul>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_brand_01.jpg" alt="#WARM" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_brand_01_on.jpg" alt="#WARM" /></span>
			</li>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_brand_02.jpg" alt="#KNIT" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_brand_02_on.jpg" alt="#KNIT" /></span>
			</li>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_brand_03.jpg" alt="#DAILY" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_brand_03_on.jpg" alt="#DAILY" /></span>
			</li>
		</ul>
	</div>

	<p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_collabo.png" alt="tenbyten 콜라보 uncommon things"/></p>
	<div class="gallery">
		<div id="rolling" class="rolling">
			<div class="slideWrap">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_4_1.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_4_2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_4_3.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_slide_4_4.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
				</div>
				<button type="button" class="btnNav btnPrev">이전</button>
				<button type="button" class="btnNav btnNext">다음</button>
			</div>
		</div>
	</div>

	<div class="interview">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/tit_interview.png" alt="12월의 에코백, 언커먼띵스" /></h3>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/txt_interview.jpg" alt="Q. 언커먼띵스만의 매력 흔한 것 같지만 흔하지 않은 디자인으로 심플하면서도 제품마다 포인트가 있어 끌리게 되는 매력 아닐까요? Q. 이번 월간 에코백의 포인트 역시나, 깔끔하지만 유용하게 활용할 수 있는 디자인과 컬러감인 것 같아요. Q. 이번 상품에 대해 소개해주세요 양쪽을 접었다가 폈다가 두 가지 디자인으로 활용을 할 수 있고 복잡하지 않은 깔끔한 디자인과 컬러감이 포인트 Q. 우븐 스트라이프 에코백을 구매하시는 분들에게 한마디 모직 울 혼방 소재로 따듯하고 포근한 느낌" /></p>
	</div>

	<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82985/img_thumb.jpg" alt="" /></div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->