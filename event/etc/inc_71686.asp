<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : 도리를 찾아서 2 WWW
' History : 2016-07-05 유태욱 생성
'####################################################
Dim eCode, userid, pagereload, i
dim iCCurrpage, iCTotCnt, eCC, iCPageSize, iCTotalPage
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66165
Else
	eCode   =  71686
End If

iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	
IF iCCurrpage = "" THEN iCCurrpage = 1
IF iCTotCnt = "" THEN iCTotCnt = -1

eCC = requestCheckVar(Request("eCC"), 1)
pagereload	= requestCheckVar(request("pagereload"),2)
userid		= GetEncLoginUserID()

iCPageSize = 4		'한 페이지의 보여지는 열의 수

dim oinstagramevent
set oinstagramevent = new Cinstagrameventlist
	oinstagramevent.FPageSize	= iCPageSize
	oinstagramevent.FCurrPage	= iCCurrpage
	oinstagramevent.FTotalCount		= iCTotCnt  '전체 레코드 수
	oinstagramevent.FrectIsusing = "Y"
	oinstagramevent.FrectEcode = eCode
	oinstagramevent.fnGetinstagrameventList

	iCTotCnt = oinstagramevent.FTotalCount '리스트 총 갯수
	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

	'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
	Dim vTitle, vLink, vPre, vImg
	
	dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle = Server.URLEncode("[10x10] 텐바이텐에 온 도리")
	snpLink = Server.URLEncode("http://www.10x10.co.kr/event/" & ecode)
	snpPre = Server.URLEncode("텐바이텐")
	
	'기본 태그
	snpTag = Server.URLEncode("텐바이텐")
	snpTag2 = Server.URLEncode("#10x10")
%>
<style type="text/css">
img {vertical-align:top;}

.eventContV15 {margin-bottom:50px;}

.dory button {background-color:transparent;}

.dory .topic {overflow:hidden; position:relative; height:464px; background:#ffcc00 url(http://webimage.10x10.co.kr/eventIMG/2016/71686/bg_yellow.png) no-repeat 50% 0; text-align:center;}
.dory .topic .bg {position:absolute; bottom:0; left:0; z-index:10; width:100%; height:38px;background:url(http://webimage.10x10.co.kr/eventIMG/2016/71686/bg_pattern_wave_v1.png) repeat-x 0 100%;}
.dory .topic h2 {position:absolute; top:78px; left:50%; width:665px; height:192px; margin-left:-332px;}
.dory .topic h2 span {position:absolute;}
.dory .topic h2 .letter1 {top:0; left:50%; margin-left:-140px;}
.dory .topic h2 .letter2 {bottom:0; left:0;}
.dory .topic h2 .letter3 {top:93px; left:505px;}
.dory .topic .find {position:absolute; top:297px; left:50%; margin-left:-209px;}
.dory .icoDory {position:absolute; top:188px; left:50%; margin-left:279px;}
.dory .icoDory {animation-name:bounce; animation-duration:1.5s; animation-iteration-count:infinite; animation-fill-mode:both; animation-direction:alternate; animation-play-state:running;}
@keyframes bounce {
	0% {top:188px;}
	100% {top:200px;}
}

@keyframes flip {
	0% {transform:rotateY(0deg); animation-timing-function:ease-out;}
	100% {transform:rotateY(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:1.2s; animation-iteration-count:1; backface-visibility:visible;}

.dory .btnMore {position:absolute; top:273px; left:50%; z-index:5; margin-left:-579px;}
.dory .square {position:absolute; top:464px; left:50%; z-index:10; width:100px; height:100px; margin-left:-522px; background-color:#2160c1;}
.lyInfo {display:none; position:fixed; top:50%; left:50%; z-index:105; width:1070px; height:582px; margin-top:-291px; margin-left:-535px;}
.lyInfo .btnClose {position:absolute; top:0; right:0; width:92px; height:92px;background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_close.png) no-repeat 50% 50%; text-indent:-9999em;}
#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71111/bg_mask.png);}

.rolling {position:absolute; top:108px; left:68px; width:538px;}
.rolling .swiper {position:relative; padding-bottom:0;}
.rolling .swiper .swiper-container {position:relative; overflow:hidden; height:350px;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {float:left; width:100%;}
.rolling .swiper .pagination {position:absolute; bottom:0; left:50%; z-index:20; width:120px; margin-left:-60px;}
.rolling .swiper .pagination span {float:left; width:10px; height:10px; margin:0 7px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_pagination_yellow.png) no-repeat 0 100%; cursor:pointer; transition:all 0.5s ease;}
.rolling .swiper .pagination .swiper-active-switch {background-position:0 0;}
.rolling .btn-nav {display:block; position:absolute; top:132px; z-index:100; width:31px; height:45px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_nav_01.png) no-repeat 0 0; text-indent:-999em}
.rolling .btn-prev {left:10px;}
.rolling .btn-next {right:10px; background-position:100% 0;}

.dory .item {min-height:855px; padding-top:75px; background:#2160c1 url(http://webimage.10x10.co.kr/eventIMG/2016/71686/bg_sea.png) no-repeat 50% 100%; text-align:center;}
.slide {position:relative; width:1140px; margin:0 auto;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:42px; height:62px; margin-top:-31px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_nav_02.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:0;}
.slide .slidesjs-next {right:0; background-position:100% 0;}
.slide .slidesjs-pagination {overflow:hidden; position:absolute; bottom:70px; left:50%; z-index:20; width:75px; margin-left:-37px;}
.slide .slidesjs-pagination li {float:left; width:11px; height:11px; margin:0 7px;}
.slide .slidesjs-pagination li a {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_pagination_mint.png) no-repeat 0 0; text-indent:-999em; transition:background 0.5s ease;}
.slidesjs-pagination li a.active {background-position:0 100%;}

.slide .slidesjs-slide {position:relative;}
.slide .slidesjs-slide .itemList li {position:absolute; width:460px; height:330px; /*border:1px solid red;*/}
.slide .slidesjs-slide .itemList li img {width:100%; height:100%;}
.slide .slidesjs-slide-01 .itemList .item1 {top:50px; left:100px;}
.slide .slidesjs-slide-01 .itemList .item2 {top:60px; right:50px; width:500px; height:355px;}
.slide .slidesjs-slide-01 .itemList .item3 {top:420px; left:90px; width:750px; height:260px;}

.slide .slidesjs-slide-02 .itemList .item1 {top:80px; left:100px; width:830px; height:260px;}
.slide .slidesjs-slide-02 .itemList .item2 {top:180px; right:80px; width:120px; height:160px;}
.slide .slidesjs-slide-02 .itemList .item3 {top:400px; left:130px; width:850px; height:270px;}

.slide .slidesjs-slide-03 .itemList .item1 {top:100px; left:50px; width:430px; height:500px;}
.slide .slidesjs-slide-03 .itemList .item2 {top:250px; left:700px; width:230px; height:145px;}
.slide .slidesjs-slide-03 .itemList .item3 {top:250px; left:935px; width:120px; height:145px;}
.slide .slidesjs-slide-03 .itemList .item4 {top:400px; left:700px; width:120px; height:145px;}
.slide .slidesjs-slide-03 .itemList .item5 {top:400px; left:830px; width:220px; height:145px;}

.dory .delivery {padding-bottom:90px; background-color:#ffcc00;}
.dory .delivery .inner {position:relative; width:1140px; margin:0 auto;}
.dory .delivery h3 {position:absolute; top:94px; left:100px;}
.dory .delivery .btnDelivery {position:absolute; top:252px; left:100px;}
.dory .delivery .btnDelivery:hover img {animation-name:shake; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:2;}
.dory .icoNimo {position:absolute; top:-49px; left:50%; margin-left:283px;}
.dory .icoNimo {animation-name:move; animation-duration:1.5s; animation-delay:1s; animation-iteration-count:infinite; animation-fill-mode:both; animation-direction:alternate; animation-play-state:running;}
@keyframes move {
	0% {top:-49px; margin-left:283px; animation-timing-function:ease-out;}
	100% {top:-59px; margin-left:300px; animation-timing-function:ease-out;}
}

.tentenBox {width:976px; margin:0 auto;}
.tentenBox h4 {margin-bottom:-8px; margin-left:19px; text-align:left;}
.tentenBox ul {overflow:hidden;}
.tentenBox ul li {float:left; margin-top:30px; padding:0 19px;}

.pageWrapV15 {margin-top:40px;}
.pageWrapV15 .pageMove {display:none;}
.paging a,
.paging a:hover,
.paging a.arrow,
.paging a.current:hover,
.paging a.current {background-color:transparent;}
.paging a,
.paging a.arrow {border-color:#d7ac00;}

.dory .offline {position:relative; height:532px; background:#2160c1;}
.dory .offline h3 {position:absolute; top:94px; left:50%; z-index:5; margin-left:-470px;}
.dory .offline p {position:absolute; top:0; left:50%; margin-left:-960px;}
.dory .offline .btnOffline {position:absolute; top:319px; left:50%; margin-left:-470px;}
.dory .offline .btnOffline:hover img {animation-name:shake; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:2;}
@keyframes shake {
	0%, 100% {transform:translateY(0);}
	10%, 30%, 50%, 70%, 90% {transform:translateY(-3px);}
	20%, 40%, 60%, 80% {transform:translateY(3px);}
}
.shake {animation-name:shake;}

.dory .share {position:relative; background-color:#174da1; text-align:center;}
.dory .share ul {position:absolute; top:49px; left:50%; width:243px; margin-left:275px;}
.dory .share ul li {float:left; margin-right:16px;}
.dory .share ul li.instagram {position:relative; margin-right:0;}
.dory .share ul li.instagram p {display:none; position:absolute; top:46px; left:-42px; z-index:100;}
.dory .share ul li > a:hover img {animation-name:pulse; animation-duration:1s; -webkit-animation-name:pulse; -webkit-animation-duration:1s;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.9);}
	100% {transform:scale(1);}
}
</style>
<script type="text/javascript">
	$(function(){

	/* title animation */
	animation();
	$("#animation h2 span").css({"opacity":"0"});
	$("#animation .icoDory").css({"opacity":"0"});
	$("#animation h2 .letter2").css({"margin-bottom":"5px"});
	$("#animation h2 .letter3").css({"left":"450px"});
	function animation() {
		$("#animation h2 .letter1").delay(100).animate({"opacity":"1"},100);
		$("#animation h2 .letter1 img").addClass("flip");
		$("#animation h2 .letter2").delay(900).animate({"margin-bottom":"0", "opacity":"1"},600);
		$("#animation h2 .letter3").delay(1000).animate({"left":"505px", "opacity":"1"},1000);
		$("#animation .icoDory").delay(1500).animate({"opacity":"1"},1000);
	}

		/* layer popup */
	$.fn.layerOpen = function(options) {
		return this.each(function() {
			var $this = $(this);
			var $layer = $($this.attr("href") || null);
			$this.click(function() {
				$layer.attr("tabindex",0).show().focus();
				$("#dimmed").show();
				$layer.find(".btnClose").one("click",function () {
					$layer.hide();
					$this.focus();
					$("#dimmed").hide();
				});
			});
		});
	}
	$(".layer").layerOpen();

	$(".layer").one("click",function(){
		rolling();
	});
	

	/* swipe js */
	function rolling() {
		var mySwiper = new Swiper("#rolling .swiper-container",{
			loop:true,
			resizeReInit:true,
			calculateHeight:true,
			pagination:'#rolling .pagination',
			paginationClickable:true,
			speed:1200,
			autoplay:false,
			autoplayDisableOnInteraction:false,
			simulateTouch:false
		})

		$("#rolling .btn-prev").on("click", function(e){
			e.preventDefault()
			mySwiper.swipePrev()
		});

		$("#rolling .btn-next").on("click", function(e){
			e.preventDefault()
			mySwiper.swipeNext()
		});
	}

	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"808",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1500}}
	});

	/* sns instagram */
	$("#sns .instagram button" ).on("click", function() {
		$("#sns .instagram p").show();
	});
});

$(function(){
	<% if Request("eCC")<>"" then %>
		setTimeout("pagedown()",100);
	<% end if %>
});
function pagedown(){
	window.$('html,body').animate({scrollTop:$("#instagramlist").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
</script>
	<div class="evt71686 dory">
		<div id="animation" class="topic">
			<div class="bg"></div>
			<h2>
				<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/tit_collabo.png" alt="텐바이텐과 도리를 찾아서" /></span>
				<span class="letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/tit_dory.png" alt="텐바이텐에 온 도리" /></span>
				<span class="letter3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_fish.png" alt="" /></span>
			</h2>
			<p class="find"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/txt_find_dory.png" alt="긍정 매력의 모태건망증 도리, 깊은 바닷속을 헤매다 텐바이텐에 도착! 텐바이텐 곳곳에 쏙! 숨어있는 도리를 찾아 주세요" /></p>

			<span class="icoDory"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_dory.png" alt="" /></span>
		</div>

		<a href="#lyInfo" class="btnMore layer"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_more.png" alt="영화 도리를 찾아서 더보기" /></a>
		<span class="square"></span>

		<div id="lyInfo" class="lyInfo">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/txt_movie.jpg" alt="무엇을 상상하든 그 이상을 까먹는 도리의 어드벤쳐가 시작된다! 니모를 함께 찾으면서 베스트 프렌드가 된 도리와 말린은 우여곡절 끝에 다시 고향으로 돌아가 평화로운 일상을 보내고 있다. 모태 건망증 도리가 기억이라는 것을 하기 전까지! 도리는 깊은 기억 속에 숨어 있던 가족의 존재를 떠올리고 니모와 말린과 함께 가족을 찾아 대책 없는 어드벤쳐를 떠나게 되는데… 깊은 바다도 막을 수 없는 스펙터클한 어드벤쳐가 펼쳐진다!" /></p>
			<!-- rolling -->
			<div id="rolling" class="rolling">
				<div class="swiper">
					<div class="swiper-container swiper1">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<iframe src="http://serviceapi.rmcnmv.naver.com/flash/outKeyPlayer.nhn?vid=D567147FDDA7DDADED6733B78A0A9B260910&outKey=V12727c8482939b7c068adb72a5590d705f0f450805cde559a38bdb72a5590d705f0f&controlBarMovable=true&jsCallable=true&isAutoPlay=false&skinName=tvcast_white" width="538" height="310" frameborder="0" title="도리를 찾아서 예고편" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
							</div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_slide_movie_02.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_slide_movie_03.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_slide_movie_04.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_slide_movie_05.jpg" alt="" /></div>
						</div>
					</div>
					<div class="pagination"></div>
					<button type="button" class="btn-nav btn-prev">Previous</button>
					<button type="button" class="btn-nav btn-next">Next</button>
				</div>
			</div>
			<button type="button" class="btnClose">레이어팝업 닫기</button>
		</div>

		<div class="item">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/tit_item.png" alt="텐바이텐 도리 굿즈 런칭!" /></h3>
			<div id="slide" class="slide">
				<div class="slidesjs-slide-01">
					<ul class="itemList">
						<li class="item1"><a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Glass Cup" /></a></li>
						<li class="item2"><a href="/shopping/category_prd.asp?itemid=1523834&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Towel" /></a></li>
						<li class="item3"><a href="/shopping/category_prd.asp?itemid=1509356&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Coaster Set" /></a></li>
					</ul>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_slide_item_01.png" alt="" />
				</div>
				<div class="slidesjs-slide-02">
					<ul class="itemList">
						<li class="item1"><a href="/shopping/category_prd.asp?itemid=1520146&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Rug medium" /></a></li>
						<li class="item2"><a href="/shopping/category_prd.asp?itemid=1520147&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Rug Large" /></a></li>
						<li class="item3"><a href="/shopping/category_prd.asp?itemid=1523832&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Beach Towel" /></a></li>
					</ul>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_slide_item_02.png" alt="" />
				</div>
				<div class="slidesjs-slide-03">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_slide_item_03.png" alt="" />
					<ul class="itemList">
						<li class="item1"><a href="/shopping/category_prd.asp?itemid=1507612&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Playing Cards" /></a></li>
						<li class="item2"><a href="/shopping/category_prd.asp?itemid=1507606&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Stripe Dory 아이폰6, 6S 케이스" /></a></li>
						<li class="item3"><a href="/shopping/category_prd.asp?itemid=1507610&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Fantastic Dory 아이폰6, 6S 케이스 네이비 도리" /></a></li>
						<li class="item4"><a href="/shopping/category_prd.asp?itemid=1507610&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Fantastic Dory 아이폰6, 6S 케이스 블루 도리" /></a></li>
						<li class="item5"><a href="/shopping/category_prd.asp?itemid=1507611&amp;pEtr=71686"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_blank.png" alt="Pattern Dory 아이폰6, 6S 투명 케이스" /></a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="delivery">
			<div class="inner">
				<span class="icoNimo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/img_nimo.png" alt="" /></span>
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/tit_delivery_box.png" alt="배송박스를 찍어주세요!" /></h3>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/txt_delivery_box.jpg" alt="지금 텐바이텐 배송 상품을 주문하면 도리를 찾아서가 그려진 박스가 도착합니다. 도리의 사진을 찍어 인스타그램에 올려주세요! 100분에게는 시크릿 경품을 드립니다! 일부 상품 제외, 선착순 소진" /></p>
				<a href="/event/eventmain.asp?eventid=65618" title="텐텐 배송 나가신다 길을 비켜라 이벤트 페이지로 이동" class="btnDelivery"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_delivery_tenten.png" alt="텐텐배송 보러가기" /></a>
				<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
				<input type="hidden" name="iCTot" value=""/>
				<input type="hidden" name="eCC" value="1">
				</form>
				<% if oinstagramevent.fresultcount > 0 then %>
				<div class="tentenBox" id="instagramlist" >
					<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/tit_tenten_box.png" alt="방금 도착한 텐바이텐 박스" /></h4>
					<ul>
						<% for i = 0 to oinstagramevent.fresultcount-1 %>
							<li><a href="<%= oinstagramevent.FItemList(i).Flinkurl %>" target="_blank"><img src="<%= oinstagramevent.FItemList(i).Fimgurl %>" width="206" height="206" alt="" /></a></li>
						<% next %>
					</ul>

					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,10,"jsGoComPage") %>
					</div>
				</div>
			<% end if %>
			</div>
		</div>

		<div class="offline">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/tit_offline.png" alt="매장을 찍어주세요!" /></h3>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/txt_offline.jpg" alt="도리를 찾아서 친구들과 함께 사진을 찍고 인증을 해주시면 한화 아쿠아플라넷 당첨의 기회가!  대학로, 김포롯데, 신제주점 매장방문시 비치볼과 메모잇 선물 증정 예정이며, 일부 상품은 제외되며, 선착순 소진 될 수 있습니다." /></p>
			<a href="/offshop/shopinfo.asp?shopid=streetshop011" target="_blank" title="텐바이텐 오프라인 매장 안내 페이지로 이동 새창" class="btnOffline"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_offline.png" alt="매장 위치 보러가기" /></a>
		</div>

		<!-- for dev msg : sns -->
		<div id="sns" class="share">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/tit_sns.png" alt="텐바이텐과 영화 도리를 찾아서 친구에게도 알려주기" /></h3>
			<ul>
				<li class="facebook"><a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/ico_facebook.png" alt="페이스북으로 텐바이텐에 온 도리 이벤트 공유하기" /></a></li>
				<li class="twitter"><a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/ico_twitter.png" alt="트위터으로 텐바이텐에 온 도리 이벤트 공유하기" /></a></li>
				<li class="instagram">
					<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/ico_instagram.png" alt="인스타그램으로 텐바이텐에 온 도리 이벤트 공유하기" /></button>
					<p id="instagram"><a href="https://www.instagram.com/your10x10/" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71686/btn_instagram.png" alt="본 화면을 캡쳐해서 인스타그램 계정으로 알려주세요! 텐바이텐 공식 인스타그램 이동" /></a></p>
				</li>
			</ul>
		</div>

		<div id="dimmed"></div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->