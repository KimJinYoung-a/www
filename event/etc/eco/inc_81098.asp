<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 에코백 시리즈 10월
' History : 2017-10-10 김송이 생성
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
.ecoBag {width:1140px; margin:0 auto; background-color:#fff;}
.ecoBag h2 {padding:78px 0 74px;}
.ecoBag iframe {width:1140px; height:74px; vertical-align:top;}
.topic {position:relative; padding-top:47px;}
.topic a {display:block; position:absolute; bottom:0; right:0;}
.intro {padding:85px 0 73px; }

.itemInfo {position:relative; display:table; width:100%; margin-bottom:40px; text-align:left;}
.itemInfo a {display:inline-block; text-decoration:none;}
.itemInfo .thumbnail {position:absolute; top:0;}
.itemInfo .thumbnail span {position:absolute; left:0; top:0; z-index:30; opacity:0; transition:all .4s;}
.itemInfo .thumbnail .discount {position:absolute; left:50%; top:228px; z-index:40; width:60px; height:60px; margin-left:55px; font:bold 18px/60px arial; letter-spacing:1px; text-align:center; color:#fff; background-color:#d50c0c; border-radius:50%;}
.itemInfo .prdImg:hover span {opacity:1;}
.itemInfo .desc {display:table-cell; height:570px; padding-left:80px; vertical-align:middle;}
.itemInfo .desc h3 {padding:22px 0 44px;}
.itemInfo .desc .price {color:#df4b4b; font-size:18px; font-family:arial; font-weight:bold;} 
.itemInfo .desc .price s {padding-right:15px; font-size:16px; color:#868686; font-weight:normal;}
.itemInfo .desc .price span {position:relative; padding-left:6px;}

.itemInfo.type1 {padding-left:520px;}
.itemInfo.type1 .thumbnail {top:0;left:0;}
.itemInfo.type2 .thumbnail {right:0;}
.itemInfo.type2 .desc {padding-left:50px;}
.itemInfo .viewMore {padding-top:48px; line-height:11px;}

.brandStory {margin-top:180px;}
.brandStory ul {overflow:hidden; margin:0 -6px; padding:14px 0;}
.brandStory ul li{float:left; position:relative; margin:0 6px;}
.brandStory ul li span {opacity:0; position:absolute; top:0; left:0;  transition:all 0.6s;}
.brandStory ul li:hover span {opacity:1;}

.collabo {padding:90px 0;}
.gallery .rolling .slideWrap {position:relative;}
.gallery .rolling .swiper-container {overflow:hidden; width:1140px; height:640px;}
.gallery .rolling .btnNav {display:block; position:absolute; bottom:175px; right:24px; width:14px; height:20px; text-indent:-9999em; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2017/79244/btn_nav.png) no-repeat 0 0;}
.gallery .rolling .btnNext {bottom:25px; background-position:100% 100%}
.gallery .rolling .pagination {position:absolute; bottom:36px; right:25px; z-index:50; }
.gallery .rolling .pagination span {display:block; width:8px; height:8px; margin:20px 0; border:2px solid #252525; border-radius:50%;background-color:transparent; cursor:pointer;}
.gallery .rolling .pagination .swiper-active-switch {background-color:#252525;}

.interview h3 {padding:123px 0 98px;}
.interview {padding-bottom:90px;}
</style>
</head>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	fnApplyItemInfoEach({
			items:"1781924,1781925",  // 상품코드
			target:"pdt",
			fields:["sale","price"],
			unit:"hw",
			saleBracket:true
	});
	/* swiper */
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
});
</script>
<div class="evt81098 ecoBag">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/tit_ecobag.png" alt="월간 에코백" /></h2>
	<iframe id="iframe_ecobag" src="/event/etc/group/iframe_ecobag.asp?eventid=81098" width="1140" height="74" frameborder="0" scrolling="no" title="월간 에코백 메뉴"></iframe>

	<div class="topic">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/tit_ithinkso.jpg" alt="#10월호 ithinkso : 아이띵소 두번째 에코백 이야기" />
		<a href="#groupBar4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/btn_comment.png" alt="코멘트 남기러가기" /></a>
	</div>

	<div class="intro">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_intro.png" alt="이번 텐바이텐 월간 에코백은 아이띵소와 함께 했습니다. 아이띵소만의 차분함으로 가을,겨울과 어울리는 데일리 에코백 입니다. 차분하면서 세련된 컬러감으로 4계절 내내 사용하실 수 있습니다. 언제나 함께할 담백한 가방 PUMPKIN SHOULDER BAG을 소개 합니다! " />
	</div>
	<!-- item -->
	<ul id="lyrItemList">
		<li class="itemInfo type1">
			<a href="/shopping/category_prd.asp?itemid=1803227&pEtr=81098">
				<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/img_item1.jpg" alt="[텐바이텐 단독 컬러] PUMPKIN SHOULDER_ brick Size : 26 x 29 X 16 (cm) Material : cotton" /></div>
				<div class="desc">
					<% if date() < "2017-10-26" then %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_sale.png" alt="10.11 ~ 10.25  단 2주간 특가" /></p>
					<% end if %>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_item_1.png" alt="[텐바이텐 단독 컬러] PUMPKIN SHOULDER_ brick" /></h3>
					<p class="price">
						<s>42,000won</s>33,600won<span>[20%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
				</div>
			</a>
		</li>
		<li class="itemInfo type2">
			<a href="/shopping/category_prd.asp?itemid=1803225&pEtr=81098">
				<div class="thumbnail">
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/img_item2.jpg" alt="[단독 선런칭 & 할인] PUMPKIN SHOULDER_ Charcoal " />
				</div>
				<div class="desc">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_sale.png" alt="10.11 ~ 10.25  단 2주간 특가" /></p>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_item_2.png" alt="[단독 선런칭 & 할인] PUMPKIN SHOULDER_ Charcoal" /></h3>
					<p class="price">
						<s>42,000won</s>33,600won<span>[20%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
				</div>
			</a>
		</li>
		<li class="itemInfo type1">
			<a href="/shopping/category_prd.asp?itemid=1803225&pEtr=81098">
				<div class="thumbnail">
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/img_item3.jpg" alt="[단독 선런칭 & 할인] PUMPKIN SHOULDER_  Redbrown" />
				</div>
				<div class="desc">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_sale.png" alt="10.11 ~ 10.25  단 2주간 특가" /></p>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_item_3.png" alt="[단독 선런칭 & 할인] PUMPKIN SHOULDER_ Redbrown" /></h3>
					<p class="price">
						<s>42,000won</s>33,600won<span>[20%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
				</div>
			</a>
		</li>
	</ul>

	<div class="brandStory">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_story.jpg" alt="ithinkso가장 아름다운 감성, 누군가와의 공감..ithinkso는 이야기를 함께 나눌 수 있는 곳이 되려합니다. 이야기의 크고 작음, 많고 적음 보다는 함께하는 공감을 소중하게 생각합니다. 또한 ithinkso가 판매하는 모든 상품은 누군가의 이야기를 담고 있습니다. 그 누군가가 당신이 되는 상상을 할 때, 우리는 가장 설렙니다. 당신의 소소한 일상에 즐거움과 편안함으로 살며시 젖어드는 스타일 브랜드 아이띵소 입니다." /></div>
		<ul>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_brand_01.jpg" alt="#BRICK" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_brand_01_on.jpg" alt="#BRICK" /></span>
			</li>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_brand_02.jpg" alt="#SIMPLE & CLEAN" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_brand_02_on.jpg" alt="#SIMPLE & CLEAN" /></span>
			</li>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_brand_03.jpg" alt="#DAILY" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_brand_03_on.jpg" alt="#DAILY" /></span>
			</li>
		</ul>
	</div>

	<p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_collabo.jpg" alt="tenbyten 콜라보 ithinkso" /></p>
	<div class="gallery">
		<div id="rolling" class="rolling">
			<div class="slideWrap">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/img_slide_1.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/img_slide_2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/img_slide_3.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/img_slide_4.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
				</div>
				<button type="button" class="btnNav btnPrev">이전</button>
				<button type="button" class="btnNav btnNext">다음</button>
			</div>
		</div>
	</div>

	<div class="interview">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/tit_interview.png" alt="“아이띵소 #2번째 이야기”" /></h3>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/txt_interview.jpg" alt="Q. 아이띵소만의 매력 아이띵소가 생각하는 심픔은 담백함이예요. Q. 이번 월간 에코백의 포인트 자신만의 스타일을 은은하게 드러내는 데일리 백이죠. Q. 이번 상품에 대해 소개해주세요 쉽게 흘러내리지 않도록 윗부분은 한번 더 마감 Q. 펌킨숄더를 구매하시는 분들에게 한마디 펌킨 숄더는 원피스부터 코트까지 어디에나 자유롭게 매치할 수 있어 편안하게 나만의 스타일을 드러낼 수 있다고 생각해요." /></p>
	</div>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81098/img_gallery.jpg" alt="" /></div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->