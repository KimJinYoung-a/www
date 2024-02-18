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
' Description : PLAY #32-1
' History : 2016-07-01 김진영 생성
'####################################################
Dim eCode, userid, pagereload, i
dim iCCurrpage, iCTotCnt, eCC, iCPageSize, iCTotalPage
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66164
Else
	eCode   =  71707
End If

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("주얼리를 보는 색다른 시선! 반짝이는 상상!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/play/playGround.asp?gidx=32&gcidx=130")
snpPre		= Server.URLEncode("텐바이텐")
snpTag		= Server.URLEncode("텐바이텐")
snpTag2		= Server.URLEncode("#10x10")
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background-color:#ffda5a;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

img {vertical-align:top;}

.jewelry1 {background:url(http://webimage.10x10.co.kr/play/ground/20160704/bg_jewelry.png) repeat 50% 0;}
.jewelry1 .section {position:relative;}
.jewelry1 .section a {overflow:hidden; display:block; position:absolute; left:50%; text-indent:-999em; z-index:100; background-color:rgba(0,0,0,0);}
.jewelry1 a.item01 {top:245px; width:600px; height:405px; margin-left:-300px;}
.jewelry1 a.item02 {top:655px; width:850px; height:80px; margin-left:-385px;}
.jewelry1 a.item03 {top:790px; width:160px; height:160px; margin-left:70px;}
.jewelry1 a.item04 {top:950px; width:300px; height:260px; margin-left:-170px;}
.jewelry1 a.item05 {top:1130px; width:150px; height:150px; margin-left:220px;}
.jewelry1 a.item06 {top:50px; width:200px; height:350px; margin-left:-360px;}
.jewelry1 a.item07 {top:400px; width:250px; height:270px; margin-left:-430px;}
.jewelry1 a.item08 {top:250px; width:100px; height:370px;}
.jewelry1 a.item09 {top:720px; width:300px; height:350px; margin-left:-550px;}
.jewelry1 a.item10 {top:935px; width:250px; height:180px; margin-left:230px;}
.jewelry1 a.item11 {top:300px; width:120px; height:120px; margin-left:150px;}
.jewelry1 a.item12 {top:500px; width:150px; height:150px; margin-left:-240px;}
.jewelry1 a.item13 {top:560px; width:150px; height:150px; margin-left:270px;}

.titSect {height:700px; padding-top:137px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/bg_jewelry_header.png) no-repeat 50% 0; text-align:center; z-index:10;}
.titSect span {display:block; position:absolute; left:50%; top:100px; width:747px; height:518px; margin-left:-397px; background-position:50% 0; background-repeat:no-repeat;}
.titSect span.shooting1 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_shooting1.png); animation:1.5s shooting 5 ease-in-out alternate;}
.titSect span.shooting2 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_shooting2.png); animation:2.5s shooting 5 ease-in-out alternate;}
@keyframes shooting {
	0% {height:0; opacity:0;}
	100% {height:518px; opacity:1;}
}
.titSect em {display:block; position:absolute; left:50%; width:12px; height:15px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_star1.png) repeat 50% 0; animation-name:twinkle; animation-iteration-count:infinite; animation-timing-function:ease-out; animation-fill-mode:both;}
.titSect em.star1 {top:296px; margin-left:240px; animation-duration:1s;}
.titSect em.star2 {top:448px; margin-left:-345px; animation-duration:2s;}
.titSect em.star3 {top:590px; margin-left:-265px; animation-duration:1s;}
.titSect em.star4 {top:613px; margin-left:-317px; animation-duration:1.5s;}
@keyframes twinkle {
	0% {opacity:0;}
	50% {opacity:1;}
	100% {opacity:0;}
}

.itemCircus {height:1380px; margin-top:-80px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/img_jewelry_item1.jpg) no-repeat 50% 0;}
.itemCircus h3 {position:absolute; left:50%; top:570px; margin-left:-162px;}
.itemCircus h3.flip {animation-name:flip; animation-duration:1.2s; animation-iteration-count:2; backface-visibility:visible;}
.itemCircus span {display:block; position:absolute; left:50%; top:-105px; width:446px; height:539px; margin-left:130px; background-position:50% 0; background-repeat:no-repeat; z-index:50; animation-name:balloon; animation-iteration-count:infinite; animation-timing-function:ease-out; animation-direction:alternate; animation-fill-mode:both;}
.itemCircus span.balloon1 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_balloon1.png); animation-duration:2.5s;}
.itemCircus span.balloon2 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_balloon2.png); animation-duration:4s;}
.itemCircus span.balloon3 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_balloon3.png); animation-duration:2s;}
.itemCircus em {display:block; position:absolute; left:50%; top:150px; width:218px; height:219px; margin-left:-442px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_fire.png) no-repeat 50% 0; z-index:50; animation-name:rollIn; animation-duration:1.8s; animation-fill-mode:both; animation-iteration-count:2;}
@keyframes balloon {
	0% {margin-top:0;}
	50% {margin-top:-10px;}
	100% {margin-top:0;}
}
@keyframes rollIn {
	0% {transform:translateX(0) rotate(-120deg);}
	50% {transform:translateX(0) rotate(0deg);}
	100% {transform:translateX(0) rotate(-120deg);}
}
@keyframes flip {
	0% {transform:rotateY(180deg); animation-timing-function:ease-out;}
	100% {transform:rotateY(360deg); animation-timing-function:ease-in;}
}
.itemMusic {height:675px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/img_jewelry_item2.jpg) no-repeat 50% 0;}
.itemMusic span {overflow:hidden; display:block; position:absolute; left:50%; top:228px; width:349px; height:272px; margin-left:-125px;}
.itemMusic span img {position:absolute; left:0; bottom:272px;}
.itemMusic span.mask {animation:note1 linear 1s 5 alternate; animation-fill-mode:both;}
.itemMusic span.mask img {animation:note2 linear 1s 5 alternate; animation-fill-mode:both;}
@keyframes note1 {
  0% {top:500px;}
  100% {top:228px;}
}
@keyframes note2 {
  0% {bottom:272px;}
  100% {bottom:0;}
}

.itemSea {height:1200px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/img_jewelry_item3.jpg) no-repeat 50% 0;}
.itemSea h3 {position:absolute; left:50%; top:645px; margin-left:5px;}
.itemSea h3.bounce {animation:2.5s bounce1 5 ease-out alternate; animation-fill-mode:both;}
@keyframes bounce1 {
	0% {margin-top:0;}
	50% {margin-top:-20px;}
	100% {margin-top:0;}
}
.itemSea span {display:block; position:absolute; left:50%;}
.itemSea span.lalala {top:40px; width:154px; height:99px; margin-left:50px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_lalala.png) no-repeat 50% 0;}
.itemSea span.drop1 {top:570px; width:17px; height:24px; margin-left:-26px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_drop1.png) no-repeat 50% 0;}
.itemSea span.drop2 {top:520px; width:17px; height:24px; margin-left:100px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_drop2.png) no-repeat 50% 0;}
.itemSea span.drop3 {top:590px; width:43px; height:21px; margin-left:-68px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_drop3.png) no-repeat 50% 0;}
.itemSea span.drop4 {top:550px; width:50px; height:34px; margin-left:80px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_drop4.png) no-repeat 50% 0;}

.itemSpace {height:1092px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/img_jewelry_item4.jpg) no-repeat 50% 0;}
.itemSpace span {display:block; position:absolute; left:50%;}
.itemSpace span.shooting3 {top:65px; width:834px; height:364px; margin-left:-316px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_shooting3.png) no-repeat 50% 0;}
.itemSpace span.swimer {top:50px; width:251px; height:241px; margin-left:-139px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_swimer.png) no-repeat 50% 0;}
.itemSpace span.bounce {animation:5s bounce2 infinite ease-out alternate; animation-fill-mode:both;}
.itemSpace span.bubble {overflow:hidden; top:0; width:57px; height:114px; margin-left:42px;}
.itemSpace span.bubble img {position:absolute; left:0; bottom:114px;}
.itemSpace span.bubbleMask {animation:bubbleMask1 linear 1.5s infinite alternate; animation-fill-mode:none;}
.itemSpace span.bubbleMask img {animation:bubbleMask2 linear 1.5s infinite alternate; animation-fill-mode:none;}
.itemSpace em {display:block; position:absolute; left:50%; width:17px; height:18px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_star2.png) repeat 50% 0; animation-name:twinkle; animation-iteration-count:infinite; animation-timing-function:ease-out; animation-fill-mode:both;}
.itemSpace em.star5 {top:105px; margin-left:-232px; animation-duration:1s;}
.itemSpace em.star6 {top:70px; margin-left:300px; animation-duration:2s;}
.itemSpace em.star7 {top:130px; margin-left:237px; animation-duration:0.5s;}
.itemSpace em.star8 {top:351px; margin-left:267px; animation-duration:1.5s;}
@keyframes bounce2 {
	0% {margin-top:0;}
	50% {margin-top:-20px;}
	100% {margin-top:0;}
}
@keyframes bubbleMask1 {
  0% {top:114px;}
  100% {top:0;}
}
@keyframes bubbleMask2 {
  0% {bottom:114px;}
  100% {bottom:0;}
}

.jewelry1 .snsShare {margin-top:-30px; height:410px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/bg_jewelry_sns2.png) repeat-x 50% 100%;}
.jewelry1 .snsShare div {position:relative; height:410px; background:url(http://webimage.10x10.co.kr/play/ground/20160704/bg_jewelry_sns.png) no-repeat 50% 0;}
.jewelry1 .snsShare div p {position:absolute; left:50%; top:136px; margin-left:-487px;}
.jewelry1 .snsShare div a {display:block; position:absolute; left:50%; top:256px; margin-left:-487px; text-indent:0;}
</style>
<script>
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1500) {
			$(".itemCircus h3").addClass("flip");
		}
		if (scrollTop > 2650) {
			$(".itemMusic .note").addClass("mask");
		}
		if (scrollTop > 3400) {
			drop();
			$(".itemSea h3").addClass("bounce");
		}
		if (scrollTop > 3800) {
			$(".itemSpace .bubble").addClass("bubbleMask");
			$(".itemSpace .swimer").addClass("bounce");
		}
	});

	$(".itemSea .drop1, .itemSea .drop2, .itemSea .drop3, .itemSea .drop4").css({"opacity":"0"});
	function drop() {
		$(".itemSea .drop1").delay(50).animate({"opacity":"1"},500);
		$(".itemSea .drop2").delay(300).animate({"opacity":"1"},700);
		$(".itemSea .drop3").delay(500).animate({"opacity":"1"},400);
		$(".itemSea .drop4").delay(700).animate({"opacity":"1"},350);
	}
});
</script>
	<div class="groundCont">
		<div class="grArea">
			<div class="jewelry1">
				<div class="section titSect">
					<h2><img src="http://webimage.10x10.co.kr/play/ground/20160704/tit_jewelry.png" alt="주얼리를 보는 색다른 시선 - 반짝이는 상상" /></h2>
					<span class="shooting1"></span>
					<span class="shooting2"></span>
					<em class="star1"></em>
					<em class="star2"></em>
					<em class="star3"></em>
					<em class="star4"></em>
				</div>

				<div class="section itemCircus">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20160704/txt_jewelry_circus.png" alt="CIRCUS" /></h3>
					<a href="/shopping/category_prd.asp?itemid=1090309" class="item01"></a>
					<a href="/shopping/category_prd.asp?itemid=1233569" class="item02"></a>
					<a href="/shopping/category_prd.asp?itemid=1454512" class="item03"></a>
					<a href="/shopping/category_prd.asp?itemid=1411279" class="item04"></a>
					<a href="/shopping/category_prd.asp?itemid=1481401" class="item05"></a>
					<span class="balloon1"></span>
					<span class="balloon2"></span>
					<span class="balloon3"></span>
					<em class="fire"></em>
				</div>

				<div class="section itemMusic">
					<a href="/shopping/category_prd.asp?itemid=1333854" class="item06"></a>
					<a href="/shopping/category_prd.asp?itemid=1358613" class="item07"></a>
					<span class="note"><img src="http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_note.png" alt="" /></span>
				</div>

				<div class="section itemSea">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20160704/txt_jewelry_catch.png" alt="catch your dream" /></h3>
					<a href="/shopping/category_prd.asp?itemid=1440980" class="item08"></a>
					<a href="/shopping/category_prd.asp?itemid=1330871" class="item09"></a>
					<a href="/shopping/category_prd.asp?itemid=1264322" class="item10"></a>
					<span class="lalala"></span>
					<span class="drop1"></span>
					<span class="drop2"></span>
					<span class="drop3"></span>
					<span class="drop4"></span>
				</div>

				<div class="section itemSpace">
					<a href="/shopping/category_prd.asp?itemid=778282" class="item11"></a>
					<a href="/shopping/category_prd.asp?itemid=778284" class="item12"></a>
					<a href="/shopping/category_prd.asp?itemid=1408946" class="item13"></a>
					<span class="shooting3"></span>
					<span class="swimer"></span>
					<span class="bubble"><img src="http://webimage.10x10.co.kr/play/ground/20160704/deco_jewelry_bubble.png" alt="" /></span>
					<em class="star5"></em>
					<em class="star6"></em>
					<em class="star7"></em>
					<em class="star8"></em>
				</div>
				<div class="section snsShare">
					<div>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160704/txt_jewelry_sns.png" alt="보석의 색다른 변신 - 반짝이는 상상 친구에게도 알려주세요" /></p>
						<a href="" class="snsFb" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160704/btn_jewelry_fb.png" alt="FACEBOOK SHARE" /></a>
					</div>
				</div>
			</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->