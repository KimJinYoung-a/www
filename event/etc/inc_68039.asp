<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : [tvN X 텐바이텐] 응답하라1988 공식 굿즈 pre-open
' History : 2015-12-11 이종화
'####################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<%
Dim eCode 

IF application("Svr_Info") = "Dev" THEN
	eCode   =  65982
Else
	eCode   =  68039
End If

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg

dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("[텐바이텐xTvN] 응답하라 1988 공식 굿즈 사전 판매!")
snpLink = Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre = Server.URLEncode("10x10 이벤트")
snpImg = Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2015/68039/m/img_bnr_kakao.jpg")

'기본 태그
snpTag = Server.URLEncode("텐바이텐")
snpTag2 = Server.URLEncode("#10x10")
%>
<style type="text/css">
#contentWrap {padding-bottom:0;}
img {vertical-align:top;}

.evt68039 {min-height:2737px; background:#f0e8d0 url(http://webimage.10x10.co.kr/eventIMG/2015/68039/bg_1988_v1.jpg) no-repeat 50% 0;}

.topic {position:relative; height:650px;}
.topic .collabo {position:absolute; top:72px; left:50%; margin-left:-110px;}
.topic h2 {position:absolute; top:130px; left:50%; width:671px; height:375px; margin-left:-335px;}
.topic h2 .letter1 {position:absolute; top:0; left:50%; margin-left:-277px;}
.topic h2 .letter2 {position:absolute; bottom:0; left:0;}
.topic .date {position:absolute; top:541px; left:50%; margin-left:-263px;}
.topic .only {position:absolute; top:25px; left:50%; margin-left:456px;}

.item {position:relative; width:1096px; height:1193px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68039/bg_paper_v2.png) no-repeat 50% 0;}
.item ul li {position:absolute;}
.item ul li a {position:relative; display:block;}
.item ul li .over {position:absolute; top:0; left:0; height:0; transition:opacity 0.5s ease-out; opacity:0; filter: alpha(opacity=0);}
.item ul li .off {opacity:1; transition:0.5s;}
.item ul li a:hover .over {height:100%; opacity:1; filter:alpha(opacity=100);}
.item ul li a:hover .off {height:100%; opacity:0; filter:alpha(opacity=0);}
.item ul li.item01 {top:241px; left:109px; width:247px;}
.item ul li.item02 {top:183px; left:462px; width:206px;}
.item ul li.item03 {top:183px; left:779px; width:229px;}
.item ul li.item04 {top:673px; left:141px; width:178px;}
.item ul li.item05 {top:632px; left:459px; width:181px;}
.item ul li.item06 {top:664px; left:759px; width:220px;}
.item ul li.item06 .type1 {position:absolute; top:35px; left:0;}
.item ul li.item06 .type2 {position:absolute; top:0; left:132px;}

.item .donation {position:absolute; bottom:55px; left:50%; margin-left:-185px;}

.intro {height:815px;}
.intro .inner {position:relative; width:437px; margin:0 auto; padding-top:140px; padding-left:703px;}
.intro .btnHomepage {position:absolute; top:45px; right:45px;}
.intro .btnHomepage {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.7s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.intro .video {position:relative;width:364px; height:256px; margin-bottom:42px; padding:41px 0 0 33px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68039/bg_tv.png) no-repeat 50% 0; text-align:left;}
.video .btnMore {overflow:hidden; display:block; position:absolute; bottom:9px; left:20px; width:138px; height:34px; color:#a06c2f; font-size:11px; line-height:100px; text-align:center;}
.video .btnMore span {display:block; position:absolute; top:0; left:0; width:100%; height:100%;}

.snsShare {position:relative; height:94px; background:#7b5d3b url(http://webimage.10x10.co.kr/eventIMG/2015/68039/bg_brown.png) repeat-x 50% 0;}
.snsShare ul {overflow:hidden; position:absolute; top:21px; left:50%; margin-left:82px;}
.snsShare ul li {float:left; width:142px; height:54px; margin-right:10px;}
.snsShare ul li a {overflow:hidden; display:block; position:relative; width:100%; height:54px; color:#43496d; font-size:11px; line-height:100px; text-align:center;}
.snsShare ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%;}
.snsShare ul li.twitter {width:128px;}
.snsShare ul li.twitter a {color:#36827f;}
.snsShare ul li.pinterest {width:160px;}
.snsShare ul li.pinterest a {color:#851413;}
</style>
<div class="evt68039">
	<div id="titleAnimation" class="topic">
		<span class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_logo_v1.png" alt="텐바이텐과 tvN" /></span>
		<h2>
			<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/tit_1988.png" alt="응답하라 1988" /></span>
			<span class="letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/tit_pre_order.png" alt="공식 굿즈 사전 판매!" /></span>
		</h2>
		<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/txt_date.png" alt="오직 텐바이텐에서만 만날 수 있는 응답하라 공식 굿즈! 사전 판매 기념 10% 할인! 사전 판매 기간은  2015년 12월 14일 월요일 부터 12월 22일 화요일 까지며, 상품 배송 기간은 2015년 12월 23일 수요일부터 순차적으로 배송됩니다." /></p>
		<div class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/ico_only.png" alt="" /></div>
	</div>
	<div class="item">
		<ul>
			<li class="item01">
				<a href="/shopping/category_prd.asp?itemid=1401873&amp;pEtr=68060">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_01_v1.png" alt="2016 탁상 달력" /></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_01_v1_over.png" alt="" /></span>
				</a>
			</li>
			<li class="item02">
				<a href="/shopping/category_prd.asp?itemid=1401874&amp;pEtr=68060">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_02_v2.png" alt="2016 벽걸이 일력" /></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_02_v1_over.png" alt="" /></span>
				</a>
			</li>
			<li class="item03">
				<a href="/shopping/category_prd.asp?itemid=1401875&amp;pEtr=68060">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_03.png" alt="딱지 스티커" /></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_03_over.png" alt="" /></span>
				</a>
			</li>
			<li class="item04">
				<a href="/shopping/category_prd.asp?itemid=1401878&amp;pEtr=68060">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_04.png" alt="청춘시대 노트" /></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_04.png" alt="" /></span>
				</a>
			</li>
			<li class="item05">
				<a href="/shopping/category_prd.asp?itemid=1401877&amp;pEtr=68060">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_05.png" alt="스마트폰 케이스" /></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_05_over.png" alt="" /></span>
				</a>
			</li>
			<li class="item06">
				<a href="/shopping/category_prd.asp?itemid=1401882&amp;pEtr=68060" class="type1">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_06_01.png" alt="티머니 버스카드 카드형" /></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_06_01_over.png" alt="" /></span>
				</a>
				<a href="/shopping/category_prd.asp?itemid=1401883&amp;pEtr=68060" class="type2">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_06_02.png" alt="티머니 버스카드 고리형" /></span>
					<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_06_02_over.png" alt="" /></span>
				</a>
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/img_item_1988_06_name_v1.png" alt="티머니 버스카드" />
			</li>
		</ul>

		<p class="donation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/txt_donation_v2.png" alt="원가 및 유통 마진을 제외한 tvN 수익금은 사회공헌 분야에 기부됩니다." /></p>
	</div>

	<div class="intro">
		<div class="inner">
			<div class="video">
				<iframe src="http://vodplayer.interest.me/embed/cjpromotion/watch?idpath=87780" width="330" height="186" frameborder="0" title="응답하라 1988" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
				<a href="http://program.interest.me/tvn/reply1988/6/Vod/List" target="_blank" title="새창" class="btnMore"><span></span>영상더보기</a>
			</div>
			<a href="http://program.interest.me/tvn/reply1988" target="_blank" title="새창" class="btnHomepage"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/btn_homepage.png" alt="공식 홈페이지 바로가기" /></a>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/txt_intro.png" alt="매주 금, 토 저녁 7시 50분! tvN 코믹가족극 응답하라 1988은 우리가 보낸 시간에 관한 이야기이며 그 시절 청춘을 보낸, 그리고 지금의 청춘들에 보내는 위로와 격려다. 현재를 살아가고, 견디며, 잘 지내고 있는 모든 이들에게 보내는 연가, 계절의 봄처럼 짧았고 청춘처럼 찰나로 지나간 그 시절로의 여행을 떠날 것이다." /></p>
		</div>
	</div>
	<div class="snsShare">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68039/tit_sns.png" alt="응팔앓이 친구들에게도 얼른 이 소식을 알려주세요!" /></h3>
		<ul>
			<li class="facebook"><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><span></span>페이스북</a></li>
			<li class="twitter"><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;"><span></span>트위터</a></li>
			<li class="pinterest"><a href="" onclick="popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>');return false;""><span></span>핀터레스트</a></li>
		</ul>
	</div>
</div>
<script type="text/javascript">
$(function(){
	/* title animation */
	$("#titleAnimation h2 .letter2").css({"bottom":"20px", "width":"400px", "opacity":"0"});
	function titleAnimation() {
		$("#titleAnimation h2 .letter1").delay(100).effect("bounce", {direction:"center", times:5, easing:"easeInOutCubic"},800);
		$("#titleAnimation h2 .letter2").delay(600).animate({"bottom":"0", "width":"671px", "opacity":"1"},1700);
	}
	titleAnimation();
});
</script>