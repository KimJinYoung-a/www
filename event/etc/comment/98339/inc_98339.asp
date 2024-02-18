<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 너와 나의 2020년을 응원해
' History : 2019-11-06
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim evtStartDate, evtEndDate, currentDate, presentDate
dim debugMode
debugMode = request("debugMode")

'test
'currentDate = Cdate("2019-12-31")

dim eCode, couponIdx, couponType
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90419
	couponIdx = "2903"
Else
	eCode   =  98339
	couponIdx = "1228"
End If

%>
<%
'공유관련
'// 쇼셜서비스로 글보내기
Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage, strPageKeyword
Dim strRecoPickMeta		'RecoPick환경변수
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("지금 텐바이텐에서 이벤트 참여하면 나와 내 친구들 모두에게 다이어리를 드려요!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("너와 나의 2020년을 응원해!")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/98339/m/bnr_share_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[너와 나의 2020년을 응원해!]"
strPageKeyword = "너와 나의 2020년을 응원해!"
strPageDesc = "지금 텐바이텐에서 이벤트 참여하면 나와 내 친구들 모두에게 다이어리를 드려요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/98339/m/bnr_share_kakao.jpg"
%>
<style>
.mEvt98339 {font-family:"malgun Gothic","맑은고딕", Dotum, "돋움",sans-serif;}
.mEvt98339 button {background-color:transparent;}
.mEvt98339 .inner {width:1094px; margin:0 auto;}
.mEvt98339 input::-ms-clear {display:none;}

.mEvt98339 .top {position:relative; height:760px; background:#fbdad9 url(//webimage.10x10.co.kr/fixevent/event/2019/98339/bg_top.jpg)no-repeat 50% 0;}
.mEvt98339 .top h2, .mEvt98339 .top p {position:absolute; top:143px; left:50%; margin-left:-570px; text-align:left;}
.mEvt98339 .top h2 span, .mEvt98339 .top p {display:block; opacity:0; transform:translateY(30px);}
.mEvt98339 .top h2 .t2 {margin:48px 0 24px; }
.mEvt98339 .top h2 .t3 {margin-bottom:30px;}
.mEvt98339 .top p {top:530px;}
.mEvt98339 .top.on h2 span, .mEvt98339 .top.on p {opacity:1; transform:translateY(0); transition:.5s .3s;}
.mEvt98339 .top.on h2 .t2 {transition-delay:.5s;}
.mEvt98339 .top.on h2 .t3 {transition-delay:.7s;}
.mEvt98339 .top.on h2 .t4 {transition-delay:.9s;}
.mEvt98339 .top.on p {transition-delay:1.1s;}

.brand-story {background:#fff url(//webimage.10x10.co.kr/fixevent/event/2019/98339/bg_conts.png)repeat-x 50% 0;}
.brand-story .girl-slide {position: relative; height:617px; z-index: 99;}
.brand-story .girl-slide:before, .brand-story .girl-slide:after {display:block; position:absolute; top:0; left:50%; z-index:10; margin-left:-1710px; width:1140px; height:100%; background-color:rgba(255, 255, 255, .4); content:'';}
.brand-story .girl-slide:after {margin-left:570px;}
.brand-story .girl-slide .slick-slide {position:relative; margin:0 16px;}
.brand-story .girl-slide .slick-arrow {display:inline-block; top:0; left:50%; width:17px; height:617px; margin-left:-525px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_nav.png); background-repeat:no-repeat; background-position:0 50%; transform:rotate(180deg);}
.brand-story .girl-slide .slick-arrow.slick-next {margin-left:512px; transform:rotate(0);}
.brand-story .girl-slide .slick-dots  {display:block; position:absolute; left:50%; bottom:35px; z-index:50; width:1140px; height:13px; margin-left:-525px; text-align:center;}
.brand-story .girl-slide .slick-dots  li {display:inline-block; width:11px; height:11px; margin:0 6px; text-indent:-999em; cursor:pointer; z-index:50; background:transparent; border:solid 2px #fff; border-radius:50%; vertical-align:top;}
.brand-story .girl-slide .slick-dots  li.slick-active {background-color:#fff;}
.brand-story .txt-preview {padding:20px 0 70px;}

.picked-item {background-color:#fff;}

.gift {position:relative; background-color:#f8d4d8;}
.gift .thumb {position:absolute; top:0; left:50%; margin-left:-235px;}
.gift .gift-slide {width:1090px; margin:0 auto;}

.related-bnr {padding-top:10px; background-color:#fff;}

.cmt-area {padding-bottom:64px; background-color:#fff;}
.cmt-area .cmt-write {position:relative; padding-top:78px; padding-bottom:69px; }
.cmt-area .cmt-write h3 {position:absolute; top:80px; left:50%; margin-left:-547px;}
.cmt-area .cmt-write .input-section {width:549px; margin-left:547px; font-weight:bold;}
.cmt-area .cmt-write .input-box {overflow:hidden; display:flex; align-items:center; width:100%; height:57px; margin:20px auto 0; padding-left:30px; background-color:#fff; border-radius:10px; box-sizing:border-box; border:solid 2px #9b9fd7;}
.cmt-area .cmt-write .input-box input {width:257px; height:100%; padding:0 34px; border:0; border-radius:0; color:#222; font-size:20px; font-family:"malgun Gothic","맑은고딕", Dotum, "돋움",sans-serif; font-weight:bold;}
.cmt-area .cmt-write .input-box input::-webkit-input-placeholder,.cmt-area .cmt-write .input-box textarea::-webkit-input-placeholder {color:#999; font-family:"malgun Gothic","맑은고딕", Dotum, "돋움",sans-serif;}
.cmt-area .cmt-write .input-box input::-moz-placeholder,.cmt-area .cmt-write .input-box textarea::-moz-placeholder {color:#999; font-family:"malgun Gothic","맑은고딕", Dotum, "돋움",sans-serif;}
.cmt-area .cmt-write .input-box input:-ms-input-placeholder,.cmt-area .cmt-write .input-box textarea:-ms-input-placeholder {color:#999; font-family:"malgun Gothic","맑은고딕", Dotum, "돋움",sans-serif;}
.cmt-area .cmt-write .input-box input:-moz-placeholderm,.cmt-area .cmt-write .input-box textarea:-moz-placeholder {color:#999; font-family:"malgun Gothic","맑은고딕", Dotum, "돋움",sans-serif;}
.cmt-area .cmt-write .input-box button {margin-left:auto;}
.cmt-area .cmt-write .input-grp {margin-top:0;}
.cmt-area .cmt-write .input-grp .btn-chck {width:140px;}
.cmt-area .cmt-write .input-num {color:#000; font-size:21px; font-weight:bold;}
.cmt-area .cmt-write .input-num span img {vertical-align:-3px;}
.cmt-area .cmt-write .input-num input {width:36px; padding-right:12px; text-align:right;}
.cmt-area .cmt-write .input-reason {position:relative; align-items:flex-start; height:174px; padding:18px 30px;}
.cmt-area .cmt-write .input-reason textarea {width:405px; padding:0; padding-left:50px; border:0; border-radius:0; font-size:21px; font-weight:bold;}
.cmt-area .cmt-write .input-reason .txt-num {position:absolute; bottom:19px; right:19px; color:#888; font-size:15px; font-family:"malgun Gothic","맑은고딕", Dotum, "돋움",sans-serif;}
.cmt-area .cmt-write .input-reason .txt-num i {font-style:normal;}
.cmt-area .cmt-write .btn-submit {margin-top:20px;}

.cmt-area .search-section {display:flex; align-items:center; position:relative; width:1140px; height:194px; margin:0 auto; background-color:#f8d4d8;}
.cmt-area .search-section .inner {display:flex; justify-content:space-between; align-items:center;}
.cmt-area .search-section .input-box {display:flex; justify-content:center; height:66px; border-radius:10px; background-color:#fff;}
.cmt-area .search-section .input-box input {width:386px; height:100%; padding:0 26px; border:0; border-radius:10px 0 0 10px; font-size:21px;}
.cmt-area .search-section .btn-search {width:110px; height:100%;}

.cmt-area .cmt-list ul {display:flex; flex-wrap:wrap; justify-content:space-between; width:1140px; margin:40px auto 0; text-align:left;}
.cmt-area .cmt-list ul li {position:relative; width:307px; height:339px; padding:24px; margin-top:40px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/bg_cmt1.png); background-repeat:no-repeat; background-size:100% 100%; font-weight:bold;}
.cmt-area .cmt-list ul li:nth-child(4n-2) {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/bg_cmt2.png);}
.cmt-area .cmt-list ul li:nth-child(4n-1) {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/bg_cmt3.png);}
.cmt-area .cmt-list ul li:nth-child(4n) {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/bg_cmt4.png);}
.cmt-area .cmt-list li > div span {color:#3740af;}
.cmt-area .cmt-list li .cmt-grp {margin-top:17px; font-size:19px; line-height:1.5; letter-spacing:-1px;}
.cmt-area .cmt-list li .cmt-grp .name {color:#eb0074;}
.cmt-area .cmt-list li .cmt-reason {overflow:hidden; height:160px; margin-top:29px; padding:15px 20px; background-color:#fff; font-size:15px; line-height:1.57; box-sizing:border-box;}
.cmt-area .cmt-list li .share {margin-top:27px;text-align:right;}
.cmt-area .cmt-list li .btn-share {display:inline-block; position:relative; width:227px; height:22px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_share.png); background-repeat:no-repeat; background-size:100%; text-indent:-999em;}
.cmt-area .cmt-list li .smile-wrap {position:absolute; top:20px; right:25px; font-size:17px; text-align:center; color:#e61587; font-weight:bold;}
.cmt-area .cmt-list li .smile-wrap .click {position:absolute; top:0; left:50%; margin-left:-15px; font-size:15px; animation:swing 1s infinite linear; transform-origin:50% 200%;}
.cmt-area .cmt-list li .smile-wrap .count {display:none; position:absolute; top:0; left:0; width:100%; font-size:15px; text-align:center; animation:countUp2 0.5s both;}
.cmt-area .cmt-list li .smile-wrap.is-touched .count {animation:countUp1 0.8s;}
.cmt-area .cmt-list li .smile-wrap .btn-smile i {display:block; width:53px; height:53px; margin-top:24px; margin-bottom:8px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/ico_smile.png); background-repeat:no-repeat; background-size:100%; text-indent:-999em;}
.cmt-area .cmt-list li .smile-wrap .btn-smile span {color:#000; font-size:17px; font-weight:bold;}
.cmt-area .cmt-list li .btn-delete {position:absolute; top:16px; right:16px; width:18px; height:18px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_delete.png); background-repeat:no-repeat; background-size:100%; text-indent:-999em;}
.cmt-area .pageWrapV15 {margin-top:55px;}
.cmt-area .pageWrapV15 .paging a, .pageWrapV15 .paging a:hover {height:28px; background-color: transparent; border: none;}
.cmt-area .pageWrapV15 .first, .pageWrapV15 .end {display: none;}
.cmt-area .paging a span {height:28px; padding:0 30px; font-size:25px; color:#ff8c69; font-family: 'Roboto','Noto Sans KR','malgun Gothic','맑은고딕',sans-serif; line-height: 28px; cursor:pointer;}
.cmt-area .paging a.current span {color: #3740af;}
.cmt-area .paging a.arrow span {width:12px; height:28px; padding:0 30px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_next.png)no-repeat 0 50%;}
.cmt-area .paging a.arrow.prev {transform: rotateY(180deg)}

.cmt-area .cmt-list ul .shared-cmt {width:590px; height:645px; padding:45px;}
.cmt-area .cmt-list ul .shared-cmt .cmt-grp {margin-left:14px; margin-top:23px; font-size:33px;}
.cmt-area .cmt-list ul .shared-cmt .cmt-reason {height:280px; padding:50px 28px; margin-top:70px; font-size:28px;}
.cmt-area .cmt-list ul .shared-cmt .share {margin-top:50px;}
.cmt-area .cmt-list ul .shared-cmt .btn-share {width:428px; height:40px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_share_big.png);}
.cmt-area .cmt-list ul .shared-cmt .smile-wrap {top:45px; right:80px;}
.cmt-area .cmt-list ul .shared-cmt .smile-wrap .count {font-size:28px;}
.cmt-area .cmt-list ul .shared-cmt .smile-wrap .click {top:5px; margin-left:-20px; font-size:20px;}
.cmt-area .cmt-list ul .shared-cmt .smile-wrap .btn-smile i {width:102px; height:102px; margin-top:45px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/ico_smile_big.png);}
.cmt-area .cmt-list ul .shared-cmt .smile-wrap .btn-smile span {font-size:32px;}
.cmt-area .cmt-list ul .shared-cmt .btn-delete {width:33px; height:33px; top:30px; right:30px; }
.cmt-area .btn-more {width:1140px; margin-top:35px; text-align:left;}

.lyr-share, .lyr-smile, .lyr-kit  {display:flex; align-items:center; justify-content:center; position:fixed; top:0; left:0; z-index:100000; width:100%; height:100%; background-color:rgba(0,0,0,.6);}
.lyr-share .inner {position:relative; width:663px; margin:0;}
.lyr-share .inner ul {display:flex; justify-content:space-between; position:absolute; top:61.37%; left:50%; width:262px; height:106px; margin-left:-131px;}
.lyr-share .inner ul li {width:50%;}
.lyr-share .inner ul li a {display:inline-block; width:100%; height:100%; text-indent:-999em;}
.lyr-share .btn-close {position:absolute; top:0; right:0; z-index:10; width:80px; height:80px; color:transparent;}
.lyr-share .btn-cp {position:relative; top:-7px;}

.lyr-smile .smile {display:inline-block; position:relative;}
.lyr-smile .smile > img {animation:wink 1s infinite linear; opacity:0;}
.lyr-smile .smile i {position:absolute; top:0; left:0; opacity:0; animation:wink 1s infinite; animation-direction:reverse;}
.lyr-smile .smile .dc {display:inline-block; position:absolute; top:-55px; left:50%; width:15px; height:38px; margin-left:26px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98339/img_spark.png)no-repeat 50% 50%/100%; animation:blink 1s infinite;}
.lyr-smile .smile .dc2 {top:-42px; margin-left:88px; transform:rotate(30deg); animation-delay:.3s;}
.lyr-smile .smile .dc3 {top:0; margin-left:132px; transform:rotate(60deg); animation-delay:.5s;}

@keyframes swing {
	0% {transform:rotate(0deg);}
	25% {transform:rotate(-30deg);}
	50% {transform:rotate(0deg);}
	75% {transform:rotate(30deg);}
	100% {transform:rotate(0);}
}
@keyframes wink {
	from {opacity:0;}
	49.999% {opacity:0;}
	50%{opacity:1;}
	99.999% {opacity:1;}
	to  {opacity:0;}
}
@keyframes blink {
	from {opacity:1;}
	50%  {opacity:0;}
	to {opacity:1;}
}
@keyframes countUp1 {
	0% {
		-webkit-transform:scaleX(0.9) translateY(50px);
		transform:scaleX(0.9) translateY(50px);
		opacity:0;
	}
	10%,100% {
		-webkit-transform:scaleX(1) translateY(0);
		transform:scaleX(1) translateY(0);
		opacity:1;
	}
}
@keyframes countUp2 {
	0% {
		-webkit-transform:translateY(0);
		transform:translateY(0);
		opacity:1;
	}
	100% {
		-webkit-transform:translateY(-50px);
		transform:translateY(-50px);
		opacity:0;
	}
}
</style>
<script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>
<script type="text/javascript">
var eventCode = '<%=eCode%>'
var couponIdx = '<%=couponIdx%>'
$(function() {
    $('.mEvt98339 .top').addClass('on');
	$(".mEvt98339 .btn-share").click(function(){
		$(".mEvt98339 .lyr-share").show()
	});
    $(".mEvt98339 .btn-close").click(function(){
		$(this).parent().parent().hide();
	});
	$('.girl-slide').slick({
		slidesToShow:3,
		slidesToScroll:1,
		speed:1000,
		arrow:true,
		centerMode:true,
		variableWidth:true,
		dots:true,
	});
});
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}
</script>

<!-- 98339 다이어리 -->
<div class="mEvt98339">
	<div class="top">
		<h2>
			<span class="t1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/tit_1_v2.png" alt="텐바이텐 다이어리 배달 프로젝트"></span>
			<span class="t2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/tit_2_v2.png" alt="너와 나의"></span>
			<span class="t3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/tit_3_v2.png" alt="2020년을"></span>
			<span class="t4"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/tit_4.png" alt="년을 응원해!"></span>
		</h2>
		<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/txt_sub_v2.png" alt="텐바이텐 X 오마이걸 다이어리 KIT 나와 친구들 모두에게 1천 개를 선물로 드립니다!"></p>
	</div>
	<div class="brand-story">
		<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/txt_prj_v2.png" alt="10X10 DIARY PROJECT"></div>
		<div class="behind-cut">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/tit_behind_cut.png?v=1.02" alt="텐바이텐 X 오마이걸 Behind Cut"></h3>
			<div class="girl-slide">
				<div><iframe src="https://www.youtube.com/embed/PpD3X1_txxA" width="1094" height="617" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_slide_girl8_v2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_slide_girl1_v2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_slide_girl2_v2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_slide_girl3_v2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_slide_girl4_v2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_slide_girl5_v2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_slide_girl6_v2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_slide_girl7_v2.jpg" alt=""></div>
			</div>
		</div>
	</div>
	<div class="picked-item">
		<img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_picked_items.jpg" alt="Oh my girl’s Pick" usemap="#items-map">
		<map name="items-map">
			<area alt="효정’s Pick" href="/shopping/category_prd.asp?itemid=2510594&pEtr=98339" coords="302,93,558,449" shape="rect" onfocus="this.blur();">
			<area alt="미미’s Pick" href="/shopping/category_prd.asp?itemid=2488134&pEtr=98339" coords="580,91,841,448" shape="rect" onfocus="this.blur();">
			<area alt="유아’s Pick" href="/shopping/category_prd.asp?itemid=2110036&pEtr=98339" coords="862,93,1121,450" shape="rect" onfocus="this.blur();">
			<area alt="승희’s Pick" href="/shopping/category_prd.asp?itemid=2512749&pEtr=98339" coords="22,498,280,867" shape="rect" onfocus="this.blur();">
			<area alt="지호’s Pick" href="/shopping/category_prd.asp?itemid=2209032&pEtr=98339" coords="302,498,555,869" shape="rect" onfocus="this.blur();">
			<area alt="비니’s Pick" href="/shopping/category_prd.asp?itemid=2542576&pEtr=98339" coords="579,499,840,869" shape="rect" onfocus="this.blur();">
			<area alt="아린’s Pick" href="/shopping/category_prd.asp?itemid=2523735&pEtr=98339" coords="861,498,1119,870" shape="rect" onfocus="this.blur();">
			<area target="_blank" alt="텐바이텐페이스북으로 이동" href="https://tenten.app.link/e/ItiIOmdzz1" coords="846,953,937,1039" shape="rect" onfocus="this.blur();">
			<area target="_blank" alt="텐바이텐인스타그램 으로 이동" href="https://tenten.app.link/bKLCGT1Cz1" coords="970,952,1059,1039" shape="rect" onfocus="this.blur();">
		</map>
	</div>
	<div class="gift">
		<img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/txt_gift.jpg" alt="텐바이텐 X 오마이걸  Special Gift">
		<span class="thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_gift.png" alt="6공 바인더 표지 4종 + 내지 3종 + 캘린더포스터 + 스티커 + 특별쿠폰"></span>
	</div>
	<div class="cmt-area">
		<div id="app"></div>
	</div>
	<div class="related-bnr">
		<img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_bnr.png" alt="" usemap="#evt-map">
		<map name="evt-map">
			<area target="_blank" alt="다이어리 스토리 " href="/diarystory2020/" onclick="fnAmplitudeEventMultiPropertiesAction('click_eventtop_banner','eventcode|etc','<%=ecode%>|1')" coords="2,3,563,125" shape="rect" onfocus="this.blur();">
			<area target="_blank" alt="텐바이텐은 처음이지? 기획전" href="/event/eventmain.asp?eventid=99222" onclick="fnAmplitudeEventMultiPropertiesAction('click_eventtop_banner','eventcode|etc','<%=ecode%>|2')" coords="576,1,1138,125" shape="rect" onfocus="this.blur();">
		</map>
	</div>
</div>
<!--// 98339 다이어리 -->
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<% IF application("Svr_Info") = "Dev" THEN %>
    <script src="/vue/vue_dev.js"></script>
<% Else %>
    <script src="/vue/2.5/vue.min.js"></script>
<% End If %>
<script src="/vue/common/util-components/like-icon.js?v=1.01"></script>
<script src="/event/etc/comment/98339/list-98339.js?v=1.01"></script>
<script src="/vue/event/comment/comment-container.js"></script>
<script src="/event/etc/comment/98339/index-98339.js?v=1.01"></script>