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
.ecoBag {width:1140px; margin:0 auto; background-color:#fff;}
.ecoBag h2 {padding:78px 0 74px;}
.ecoBag iframe {width:1140px; height:74px; vertical-align:top;}
.topic {position:relative; padding-top:47px;}
.topic a {display:block; position:absolute; bottom:0; right:0;}
.intro {padding:85px 0 73px; }

.itemInfo {position:relative; display:table; width:100%; height:670px; margin-bottom:30px; text-align:left;}
.itemInfo a {display:inline-block; text-decoration:none;}
.itemInfo .slide {position:relative; width:570px; height:671px; margin:0 auto;}
.itemInfo .thumbnail {position:absolute; top:0;}
.itemInfo .thumbnail span {position:absolute; left:0; top:0; z-index:30; opacity:0; transition:all .4s;}
.itemInfo .desc {display:table-cell; height:671px; padding-left:108px; vertical-align:middle;}
.itemInfo .desc h3 {padding:22px 0 20px;}
.itemInfo .desc .price {color:#df4b4b; font-size:18px; font-family:arial; font-weight:bold;} 
.itemInfo .desc .price s {padding-right:15px; font-size:16px; color:#868686; font-weight:normal;}
.itemInfo .desc .price span {position:relative; padding-left:6px;}

.itemInfo.type1 {padding-left:570px;}
.itemInfo.type1 .thumbnail {left:0;}
.itemInfo.type2 .thumbnail {right:0;}
.itemInfo.type2 .desc {padding-left:50px;}
.itemInfo .viewMore {padding-top:45px; line-height:11px;}

.brandStory {margin-top:180px;}
.brandStory ul {overflow:hidden; margin:0 -6px; padding:14px 0;}
.brandStory ul li{float:left; position:relative; margin:0 6px; cursor:pointer;}
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

.tip {width:800px; margin:163px auto 0; border:solid 1px #dcdcdc;}
.tip p {margin:75px 0;}

.interview h3 {padding:164px 0 79px;}
.interview {padding-bottom:90px;}
</style>
</head>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	fnApplyItemInfoList({
		items:"1809640,1809635,1811511", //상품코드
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
<div class="evt81543 ecoBag">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/tit_ecobag.png" alt="월간 에코백" /></h2>
	<iframe id="iframe_ecobag" src="/event/etc/group/iframe_ecobag.asp?eventid=81543" width="1140" height="74" frameborder="0" scrolling="no" title="월간 에코백 메뉴"></iframe>

	<div class="topic">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/tit_lveb.jpg" alt="#11월호 LVEB : 인생을 더 아름답게, 라비에벨" />
		<a href="#groupBar5"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/btn_comment.png" alt="코멘트 남기러가기" /></a>
	</div>

	<div class="intro">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_intro.png" alt="이번 텐바이텐 월간 에코백은 라비에벨과 함께 했습니다.쌀쌀한 날씨에 어울리는 재질과, 색감사랑스러운 리본으로 포인트를 주고추운 날씨에도 편안하게 함께 할 사랑스러운 에코백을 준비했어요!코듀로이와 스웨이드로 따스하게 찾아온리본 스트랩 에코백을 소개합니다!" />
	</div>
	<!-- item -->
	<ul id="lyrItemList">
		<li class="itemInfo type1 lyr-item1809640">
			<a href="/shopping/category_prd.asp?itemid=1809640&pEtr=81543">
				<div class="slide slide1 thumbnail">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_1_1.jpg" alt="[텐바이텐 단독 제품] LVEB 리본스트랩 - 코듀로이" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_1_2.jpg" alt="[텐바이텐 단독 제품] LVEB 리본스트랩 - 코듀로이" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_1_3.jpg" alt="[텐바이텐 단독 제품] LVEB 리본스트랩 - 코듀로이" /></div>
				</div>
				<div class="desc">
					<% if date() < "2017-11-15" then %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_sale.png" alt="11.01 ~ 11.14  단 2주간 단독 특가" /></p>
					<% end if %>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_item_1.png" alt="[텐바이텐 단독 제품] LVEB 리본스트랩 - 코듀로이" /></h3>
					<p class="price">
						<s>38,000</s>30,400won<span>[10%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
				</div>
			</a>
		</li>
		<li class="itemInfo type2 lyr-item1809635">
			<a href="/shopping/category_prd.asp?itemid=1809635&pEtr=81543">
				<div class="slide slide2 thumbnail">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_2_1.jpg" alt="[텐바이텐 단독 제품]LVEB 리본스트랩 - 스웨이드" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_2_2.jpg" alt="[텐바이텐 단독 제품]LVEB 리본스트랩 - 스웨이드" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_2_3.jpg" alt="[텐바이텐 단독 제품]LVEB 리본스트랩 - 스웨이드" /></div>
				</div>
				<div class="desc">
					<% if date() < "2017-11-15" then %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_sale.png" alt="11.01 ~ 11.14  단 2주간 단독 특가" /></p>
					<% end if %>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_item_2.png" alt="[텐바이텐 단독 제품]LVEB 리본스트랩 - 스웨이드" /></h3>
					<p class="price">
						<s>38,000</s>30,400won<span>[10%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
				</div>
			</a>
		</li>
		<li class="itemInfo type1 lyr-item1811511">
			<a href="/shopping/category_prd.asp?itemid=1811511&pEtr=81543">
				<div class="slide slide3 thumbnail">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_3_1.jpg" alt="[텐바이텐 단독 특가] LVEB 리본스트랩 - 텐셀" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_3_2.jpg" alt="[텐바이텐 단독 특가] LVEB 리본스트랩 - 텐셀" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_3_3.jpg" alt="[텐바이텐 단독 특가] LVEB 리본스트랩 - 텐셀" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_3_4.jpg" alt="[텐바이텐 단독 특가] LVEB 리본스트랩 - 텐셀" /></div>
				</div>
				<div class="desc">
					<% if date() < "2017-11-15" then %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_sale.png" alt="11.01 ~ 11.14  단 2주간 단독 특가" /></p>
					<% end if %>
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_item_3.png" alt="[텐바이텐 단독 특가] LVEB 리본스트랩 - 텐셀" /></h3>
					<p class="price">
						<s>38,000</s>30,400won<span>[10%]</span>
					</p>
					<p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
				</div>
			</a>
		</li>
	</ul>

	<div class="brandStory">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_story.jpg" alt="BRAND STORY 라비에벨은 여성 패션잡화 브랜드로 '인생은 아릅답다(la vie est belle)'라는 뜻을 담고 있습니다. 여자의 인생에서 빠질 수 없는 아름다움을 라비에벨과 함께하세요." /></div>
		<ul>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_brand_01.jpg" alt="#warm" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_brand_01_on.jpg" alt="#warm" /></span>
			</li>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_brand_02.jpg" alt="#point" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_brand_02_on.jpg" alt="#point" /></span>
			</li>
			<li>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_brand_03.jpg" alt="#DAILY" />
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_brand_03_on.jpg" alt="#DAILY" /></span>
			</li>
		</ul>
	</div>

	<p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_collabo.png" alt="tenbyten 콜라보 LVEB"/></p>
	<div class="gallery">
		<div id="rolling" class="rolling">
			<div class="slideWrap">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_4_1.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_4_2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_4_3.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_slide_4_4.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
				</div>
				<button type="button" class="btnNav btnPrev">이전</button>
				<button type="button" class="btnNav btnNext">다음</button>
			</div>
		</div>
	</div>

	<div class="tip">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/img_tip.gif" alt="" />
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_tip.png" alt=" 리본 예쁘게 묶기 TIP 1. 끈을 잡고 평소 묶던 방식으로 한번 묶어주세요 + 1번 묶기 전 위쪽으로 올라오는 끈을 꼭 기억해주세요. 2. 1번에서 위쪽으로 올라왔던 끈을 다시 위쪽으로 오게끔 다시 묶어주세요. + 마지막으로 잡아당길 때는 앞부분이 예쁘게 보이도록 한 후 잡아당겨주세요." /></p>
	</div>

	<div class="interview">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/tit_interview.png" alt="“라비에벨과 이야기를 나누고 싶어요”" /></h3>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81543/txt_interview.jpg" alt="Q. 라비에벨의 시작 우리가 갖고싶은 물건을 만들어 보자로 시작하게 되었습니다. Q. 리본 스트랩 에코백의 매력 가방 이름 그대로 스트랩이 가장 큰 매력인것 같아요.  Q. 디자인을 할 때 중요하게 생각하는 부분 평범한 20-30대 여성을 생각합니다. '어떤날은 청바지를, 어떤날은 스커트를 입어도 고민하지 않고 손쉽게 매치할 수 있는 아이템을 만들자'가 가장 큰 기준입니다. Q. 라비에벨을 좋아하는 고객들에게 예쁘고 합리적인 여성 잡화 아이템" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->