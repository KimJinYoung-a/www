<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim eCode 

IF application("Svr_Info") = "Dev" THEN
	
Else
	eCode = "73008"
End If

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 웰컴 투 더핑거스")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
%>
<style>
img {vertical-align:top;}
.welcomeFingers .welcomeCont {position:relative; width:1140px; margin:0 auto;}
.welcomeFingers .welcomeHead {position:relative; height:450px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73008/bg_title.png) 50% 0 no-repeat;}
.welcomeFingers .welcomeHead .bg {position:absolute; top:0; width:50%; height:100%;}
.welcomeFingers .welcomeHead .bg.left {left:0; margin-left:-570px; background:#a7e376;}
.welcomeFingers .welcomeHead .bg.right {right:0; margin-right:-570px; background:#dfd944;}
.welcomeFingers .welcomeHead .open {padding:82px 0 20px;}
.welcomeFingers .welcomeHead .desc {padding:18px 0 30px;}
.welcomeFingers .welcomeHead .icon {position:absolute; left:50%; top:0; width:1800px; height:100%; margin-left:-900px;  background:url(http://webimage.10x10.co.kr/eventIMG/2016/73008/bg_icon.png) 0 0 repeat-y;}
.welcomeFingers .hotItem {text-align:center; padding:0 0 80px; background:#ddf5f5;}
.welcomeFingers .hotItem .slider-horizontal {width:100%; margin:-80px auto 0; text-align:left;}
.welcomeFingers .hotItem .www_FlowSlider_com-branding {display:none !important;}
.welcomeFingers .hotItem li {width:160px; height:160px; margin:0 22px; text-align:center;}
.welcomeFingers .hotItem .process {padding:80px 0 70px;}
.welcomeFingers .shareSns {background:#65dace;}
.welcomeFingers .shareSns li {position:absolute; top:25px;}
.welcomeFingers .shareSns li.fb {right:200px;}
.welcomeFingers .shareSns li.tw {right:118px;}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function(){
	$("#itemSlider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		startPosition:0.55
	});
});
var scrollSpeed =15;
var current = 0;
var direction = 'v';
function bgscroll(){
	current -= 1;
	$('.welcomeHead .icon').css("backgroundPosition", (direction == 'v') ? "0 " + current+"px" : current+"px 0");
}
setInterval("bgscroll()", scrollSpeed);


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
<!-- 오픈 이벤트 : 웰컴 투 더핑거스 -->
<div class="evt73008 welcomeFingers">
	<!-- title -->
	<div class="welcomeHead">
		<p class="open"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/txt_grand_open.png" alt="핸드메이드 플랫폼, 더핑거스 오픈!" /></p>
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/tit_welcome.png" alt="웰컴 투 더핑거스" /></h2>
		<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/txt_invite.png" alt="더핑거스를 찾아주신 고객님께 선보이는 특별한 이벤트에 당신을 초대합니다." /></p>
		<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/txt_date.png" alt="이벤트 기간:9.19~10.3" /></p>
		<div class="bg left"></div>
		<div class="bg right"></div>
		<div class="icon"></div>
	</div>
	<!--// title -->
	<div class="hotItem">
		<ul id="itemSlider" class="slider-horizontal">
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6030"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6030.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6091"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6091.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6915"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6915.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6272"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6272.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=5963"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_5963.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=5957"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_5957.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6154"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6154.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6158"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6158.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6216"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6216.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=5973"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_5973.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6975"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6975.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6833"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6833.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6435"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6435.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6770"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6770.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6468"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6468.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6252"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6252.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6860"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6860.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6661"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6661.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=6505"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_6505.png" alt="" /></a></li>
			<li><a href="http://www.thefingers.co.kr/diyshop/shop_prd.asp?itemid=7035"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_7035.png" alt="" /></a></li>
		</ul>
		<div class="process"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/img_event.png" alt="EVENT1. 만나서 반가워요 웰컴쿠폰 / EVENT2. 갖고싶은 작품을 담아주세요!" /></div>
		<a href="http://www.thefingers.co.kr/event/openevent/welcome/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/btn_go.gif" alt="더핑거스로 가기" /></a>
	</div>
	<!-- SNS공유 -->
	<div class="shareSns">
		<div class="welcomeCont">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/73008/txt_share.png" alt="핸드메이드를 좋아하는 친구들에게 더핑거스 오픈 소식을 알려주세요!" /></div>
			<ul>
				<li class="fb"><a href="" target="_blank" onclick="snschk('fb');return false;"><img src="http://image.thefingers.co.kr/2016/event/20160905/btn_fb.png" alt="페이스북 으로 공유하기" /></a></li>
				<li class="tw"><a href="" target="_blank" onclick="snschk('tw');return false;"><img src="http://image.thefingers.co.kr/2016/event/20160905/btn_twitter.png" alt="트위터로 공유하기" /></a></li>
			</ul>
		</div>
	</div>
	<!--// SNS공유 -->
</div>
<!--// 오픈 이벤트 : 웰컴 투 더핑거스 -->
