<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : PLAY 27 기억을 닮다, 향기를 담다.W
' History : 2016.02.17 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->

<%
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66033
Else
	eCode   =  69279
End If

dim userid, i, vreload
	userid = getloginuserid()
	vreload	= requestCheckVar(Request("reload"),2)

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt, sqlstr
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 8	'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 8	'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'// sns데이터 총 카운팅 가져옴
sqlstr = "select count(*) "
sqlstr = sqlstr & " from [db_Appwish].[dbo].[tbl_snsSelectData]"
sqlstr = sqlstr & " Where evt_code="& eCode &""

'response.write sqlstr & "<br>"
rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
	iCTotCnt = rsCTget(0)
rsCTget.close

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:700,400);
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

.groundWrap {width:100%; background:#e4c9b5 url(http://webimage.10x10.co.kr/play/ground/20160222/bg_head.jpg) no-repeat 50% 0; background-size:100% 262px;}
.groundCont {position:relative; padding-bottom:0; background-color:#efe4dd;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:28px 20px 60px; border-top:1px solid #e0d6cf;}

img {vertical-align:top;}

.hidden {visibility:hidden; width:0; height:0;}

.playGr20160222 {background:#cb9c8b url(http://webimage.10x10.co.kr/play/ground/20160222/bg_nightview_v1.jpg) no-repeat 50% 0;}

.topic {overflow:hidden; position:relative; height:859px;}
.topic h3 {overflow:hidden; position:absolute; top:143px; left:50%; width:614px; height:161px; margin-left:-520px;}
.topic h3 span {position:absolute; height:61px; background:url(http://webimage.10x10.co.kr/play/ground/20160222/tit_memory.png) no-repeat 0 0; text-indent:-9999em;}
.topic h3 .letter1 {top:0; left:0; width:187px;}
.topic h3 .letter2 {top:0; right:0; width:142px; background-position:-469px 0;}
.topic h3 .letter3 {top:28px; left:237px; width:184px; height:4px; background-position:-237px -28px; transition:all 2s ease 0s; transform:scaleX(0);}
.topic h3 .letter4 {top:100px; left:0; width:186px; background-position:0 -100px;}
.topic h3 .letter5 {top:100px; left:233px; width:189px; background-position:-233px -100px;}
.topic h3 .letter6 {top:100px; right:0; width:189px; background-position:100% -100px;}
.topic h3 .visible {transform:scaleX(1); opacity:1;}
.topic p {position:absolute; top:419px; left:50%; margin-left:-520px;}
.topic .hand {position:absolute; bottom:0; left:50%; margin-left:170px;}

.collabo {height:300px; background-color:#97cec2; text-align:center;}

.contents {}
.navigator {height:160px; background:url(http://webimage.10x10.co.kr/play/ground/20160222/bg_mask.png) repeat-x 0 0;}
.navigator ul {overflow:hidden; width:1138px; margin:0 auto;}
.navigator ul li {float:left; width:284px; height:138px; margin-top:39px;}
.navigator ul li a {display:block; width:100%; height:100%;}
.navigator ul li a {overflow:hidden; display:block; position:relative; height:138px; color:#fff; font-size:11px; line-height:138px; text-align:center; text-indent:-999em;}
.navigator ul li a:hover {animation-iteration-count:infinite; animation-duration:0.6s; animation-name:bounce;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}
.navigator ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20160222/bg_navigator.png) no-repeat 0 0;}
.navigator ul li a:hover span {background-position:0 100%;}
.navigator ul li.nav2 a span {background-position:-280px 0;}
.navigator ul li.nav2 a:hover span {background-position:-280px 100%;}
.navigator ul li.nav3 a span {background-position:-560px 0;}
.navigator ul li.nav3 a:hover span {background-position:-560px 100%;}
.navigator ul li.nav4 a span {background-position:100% 0;}
.navigator ul li.nav4 a:hover span {background-position:100% 100%;}

.contents .scent {position:relative; height:880px;}

.contents .scent h4 {position:absolute; top:147px; left:50%; margin-left:-29px;}
.contents .scent h4 .title {position:absolute; top:0; left:0; z-index:5;}
.contents .scent h4 .blur {display:none; position:absolute; top:0; left:0; -webkit-filter:blur(20px);}
.contents .scent .bottle {position:absolute; top:405px; left:50%; z-index:10; margin-left:200px;}
.contents .scent .brush {position:absolute; top:370px; left:50%; width:271px; height:253px; margin-left:245px; background:url(http://webimage.10x10.co.kr/play/ground/20160222/img_brush_01.png) no-repeat 50% 50%;}
.contents .scent .brush2 {top:576px; margin-left:144px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_brush_02.png);}
.contents .scent .item li {position:absolute; top:370px; left:50%; z-index:10; margin-left:350px;}
.contents .scent .item li.item02 {top:733px; margin-left:66px;}

.painting {animation-name:painting; animation-duration:5s; animation-fill-mode:both; animation-iteration-count:1;}
@keyframes painting {
	0% {background-size:10% 10%;}
	100% {background-size:100% 100%;}
}
.painting1 {animation-delay:0.5s; animation-duration:6s;}
@keyframes painting1 {
	0% {background-size:10% 10%;}
	100% {background-size:100% 100%;}
}

.scent01 {background:#f2edeb url(http://webimage.10x10.co.kr/play/ground/20160222/bg_scent_01.jpg) no-repeat 50% 0;}

.scent02 {background:#f0e8e0 url(http://webimage.10x10.co.kr/play/ground/20160222/bg_scent_02.jpg) no-repeat 50% 0;}
.contents .scent02 h4 {top:160px; margin-left:-508px;}
.contents .scent02 .bottle {top:483px; margin-left:-360px;}
.contents .scent02 .brush {top:363px; margin-left:-333px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_brush_03.png);}
.contents .scent02 .brush2 {top:470px; margin-left:-454px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_brush_04.png);}
.contents .scent02 .item li {top:379px; margin-left:-164px;}
.contents .scent02 .item li.item02 {top:663px; margin-left:-535px;}

.painting {animation-name:painting; animation-duration:5s; animation-fill-mode:both; animation-iteration-count:infinite;}
@keyframes painting {
	0% {opacity:0; background-size:10% 10%;}
	30%, 90% {opacity:1; background-size:100% 100%;}
	100% {animation-delay:1s; background-size:100% 100%;}
}
.painting1 {animation-delay:0.4s;}
.painting2 {animation-delay:0.6s;}
.painting3 {animation-delay:0.8s;}

.scent03 {background:#b3ccde url(http://webimage.10x10.co.kr/play/ground/20160222/bg_scent_03.jpg) no-repeat 50% 0;}
.contents .scent03 h4 {top:152px; margin-left:-356px;}
.contents .scent03 .bottle {top:239px; margin-left:162px;}
.contents .scent03 .brush {top:210px; margin-left:123px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_brush_05.png);}
.contents .scent03 .brush2 {top:348px; margin-left:62px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_brush_06.png);}
.contents .scent03 .item li {top:237px; margin-left:293px;}
.contents .scent03 .item li.item02 {top:517px; margin-left:50px;}

.scent04 {background:#f5f5f3 url(http://webimage.10x10.co.kr/play/ground/20160222/bg_scent_04.jpg) no-repeat 50% 0;}
.contents .scent04 h4 {top:167px; margin-left:-198px;}
.contents .scent04 .bottle {top:259px; margin-left:215px;}
.contents .scent04 .brush {top:210px; margin-left:220px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_brush_07.png);}
.contents .scent04 .brush2 {top:350px; margin-left:65px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_brush_08.png);}
.contents .scent04 .item li {top:220px; margin-left:361px;}
.contents .scent04 .item li.item02 {top:538px; margin-left:93px;}

.rollingWrap {position:relative; padding:155px 0 205px; background:#f7f4f1 url(http://webimage.10x10.co.kr/play/ground/20160222/bg_paper.jpg) repeat-x 50% 0;}
.rollingWrap h4 {position:absolute; bottom:110px; left:50%; margin-left:-240px;}
.rolling {position:relative; width:1140px; height:492px; margin:0 auto;}
.rolling .swiper {overflow:hidden; position:relative; height:492px; padding:0 40px 0 15px;}
.rolling .swiper-container {overflow:hidden;}
.rolling .swiper-wrapper {position:relative;}
.rolling .swiper-slide {float:left; position:relative; z-index:50; text-align:center;}
.rolling .swiper-slide span {display:block; height:423px; position:relative; z-index:50;}
.rolling .swiper-slide .off img {padding-top:215px;}
.rolling .btn-nav {position:absolute; top:50%; width:31px; height:59px; margin-left:-30px; background:url(http://webimage.10x10.co.kr/play/ground/20160222/btn_nav.png) no-repeat 0 50%; text-indent:-9999em;}
.rolling .btn-prev {left:0;}
.rolling .btn-next {right:0; background-position:100% 50%;}

.swiper .pagination {position:absolute; top:0; left:450px; z-index:5; width:214px; height:22px;}
.swiper .pagination span {display:block; float:left; width:9px; height:8px; margin:8px 8px 0;}
.swiper .pagination span em {position:absolute; top:0; left:0; z-index:15; width:214px; height:423px; background-repeat:no-repeat; background-position:50% 0;}
.swiper .pagination span em a {display:block; width:100%; height:100%; text-indent:-9999em;}
.swiper .pagination span .desc1 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_slide_01_v1_on.png);}
.swiper .pagination span .desc2 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_slide_02_v1_on.png);}
.swiper .pagination span .desc3 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_slide_03_v1_on.png);}
.swiper .pagination span .desc4 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_slide_04_v1_on.png);}
.swiper .pagination span .desc5 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_slide_05_v1_on.png);}
.swiper .pagination span .desc6 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_slide_06_v1_on.png);}
.swiper .pagination span .desc7 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_slide_07_v1_on.png);}
.swiper .pagination span .desc8 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160222/img_slide_08_v1_on.png);}
.rolling .shadow {position:absolute; top:420px; left:460px; z-index:10;}

.event {padding:70px 0 55px; border-bottom:6px solid #e6cec9; background:#f9d8d3 url(http://webimage.10x10.co.kr/play/ground/20160222/bg_deco.png) no-repeat 50% 0; text-align:center;}
.event .upload {position:relative; width:1040px; height:246px; margin:85px auto 0; text-align:left;}
.event .upload .mobile {position:absolute; top:0; left:44px;}
@keyframes shake {
	0% {transform:translateX(0);}
	50% {transform:translateX(20px);}
	100% {transform:translateX(0);}
}
.shake {animation-name:shake; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:infinite;}

.event .upload p {padding:7px 0 0 293px;}

.instagram {padding:70px 0 62px; background-color:#efe4dd;}
.instagram .hgroup {position:relative; width:1140px; margin:0 auto; padding-top:30px; padding-bottom:30px; border-bottom:1px solid #cfc0b7; text-align:left;}
.instagram .hgroup .btnInstagram {position:absolute; top:42px; right:11px;}

.instagramList {overflow:hidden; width:1172px; margin:0 auto;}
.instagramList li {float:left; width:227px; height:302px; margin:42px 13px 0; padding:20px; background:url(http://webimage.10x10.co.kr/play/ground/20160222/bg_photo_frame.png) no-repeat 50% 0;}
.instagramList li a {display:block;}
.instagramList li a img {transition:transform 1s ease-in-out;}
.instagramList li a:hover {text-decoration:none;}
.instagramList li a:hover img {transform:scale(1.1);}
.instagramList li .article {margin-top:17px; color:#404040; font-size:13px; font-family:'Roboto', 'Noto Sans KR', sans-serif;}
.instagramList li .article p {display:inline;}
.instagramList li .figure {overflow:hidden; width:228px; height:228px;}
.instagramList li .id {color:#396991; font-weight:bold;}

.instagramList li:nth-of-type(2) {animation-delay:0.2s;}
.instagramList li:nth-of-type(3) {animation-delay:0.3s;}
.instagramList li:nth-of-type(4) {animation-delay:0.4s;}
.instagramList li:nth-of-type(5) {animation-delay:0.5s;}
.instagramList li:nth-of-type(6) {animation-delay:0.2s;}
.instagramList li:nth-of-type(7) {animation-delay:0.4s;}
.instagramList li:nth-of-type(8) {animation-delay:0.5s;}
@keyframes fadeInSlideUp {
	0% {opacity:0; transform: translateY(50px);}
	100% {opacity:1;}
}
.fadeInSlideUp{opacity: 0; animation: fadeInSlideUp 1s cubic-bezier(0.2, 0.3, 0.25, 0.9) forwards;}

.pageWrapV15 {margin-top:46px;}
.pageWrapV15 .pageMove {display:none;}
.paging a.arrow, .paging a, .paging a.current {background-color:transparent;}
</style>
<script type="text/javascript">
$(function(){
	<% if vreload<>"" then %>
		$('html,body').animate({scrollTop: $("#instagram").offset().top},0);
	<% end if %>
});

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
</script>
<div class="groundCont">
	<div class="grArea">

		<div class="playGr20160222">
			<div id="titleAnimation" class="topic">
				<h3>
					<span class="letter1">기억을</span>
					<span class="letter2">닮다.</span>
					<span class="letter3"></span>
					<span class="letter4">기억의</span>
					<span class="letter5">향기를</span>
					<span class="letter6">담다.</span>
				</h3>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160222/txt_memory.png" alt="길을 걷다가 낯설지 않은 향기에 돌아본 찰나 잔뜩 가라앉은 비 냄새를 맞고 하늘을 올려다 본 아침 어느 집 된장찌개 냄새를 맡고 엄마 생각난 순간 향기는 우리가 모르게 기억을 담게 됩니다. 기억을 닮은 향기, 그 날의 감성을 텐바이텐이 선물합니다." /></p>
				<div class="hand"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_hand.png" alt="" /></div>
			</div>

			<div class="contents">
				<div id="navigator" class="navigator">
					<ul>
						<li class="nav1"><a href="#scent01"><span></span>따뜻한 향기</a></li>
						<li class="nav2"><a href="#scent02"><span></span>고백의 향기</a></li>
						<li class="nav3"><a href="#scent03"><span></span>겨울 바다 향기</a></li>
						<li class="nav4"><a href="#scent04"><span></span>파릇파릇 향기</a></li>
					</ul>
				</div>

				<div id="scent01" class="scent scent01">
					<h4><span class="title"><img src="http://webimage.10x10.co.kr/play/ground/20160222/tit_scent_01.png" alt="잠이 솔솔 엄마의 따뜻한 향기" /></span></h4>
					<div class="bottle"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_perfume_bottle_01.png" alt="" /></div>
					<span class="brush brush1"></span>
					<span class="brush brush2"></span>
					<ul class="item">
						<li class="item01"><a href="/shopping/category_prd.asp?itemid=1235472&amp;pEtr=69279"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_item_01_01.png" alt="Precious Baby 어린 시절 엄마에게 안기던 따스하고 포근한 기억" /></a></li>
						<li class="item02"><a href="/shopping/category_prd.asp?itemid=189621&amp;pEtr=69279"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_item_01_02.png" alt="Laundromat 엄마가 날 기다리는 따뜻하고 푸근한 집의 기억" /></a></li>
					</ul>
				</div>

				<div id="scent02" class="scent scent02">
					<h4><span class="title"><img src="http://webimage.10x10.co.kr/play/ground/20160222/tit_scent_02.png" alt="두근 두근 설렘 가득한 고백의 향기" /></span></h4>
					<div class="bottle"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_perfume_bottle_02.png" alt="" /></div>
					<span class="brush brush1 painting painting4"></span>
					<span class="brush brush2 painting painting4"></span>
					<ul class="item">
						<li class="item01"><a href="/shopping/category_prd.asp?itemid=247001&amp;pEtr=69279"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_item_02_01_v1.png" alt="Juicy shampoo 수줍은 고백의 기억" /></a></li>
						<li class="item02"><a href="/shopping/category_prd.asp?itemid=741201&amp;pEtr=69279"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_item_02_02_v1.png" alt="Fuzzy Navel 달콤한 향기로 가득했던 첫사랑의 기억" /></a></li>
					</ul>
				</div>

				<div id="scent03" class="scent scent03">
					<h4><span class="title"><img src="http://webimage.10x10.co.kr/play/ground/20160222/tit_scent_03.png" alt="코 끝이 얼어도 좋아 겨울 바다 향기" /></span></h4>
					<div class="bottle"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_perfume_bottle_03.png" alt="" /></div>
					<span class="brush brush1 painting painting2"></span>
					<span class="brush brush2 painting painting2"></span>
					<ul class="item">
						<li class="item01"><a href="/shopping/category_prd.asp?itemid=922838&amp;pEtr=69279"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_item_03_01.png" alt="Ocean breeze 시원한 바다의 기억" /></a></li>
						<li class="item02"><a href="/shopping/category_prd.asp?itemid=189630&amp;pEtr=69279"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_item_03_02.png" alt="Snow 눈 오는 날의 기억" /></a></li>
					</ul>
				</div>

				<div id="scent04" class="scent scent04">
					<h4><span class="title"><img src="http://webimage.10x10.co.kr/play/ground/20160222/tit_scent_04.png" alt="아침 산책길에 나선 파릇파릇 향기" /></span></h4>
					<div class="bottle"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_perfume_bottle_04.png" alt="" /></div>
					<span class="brush brush1 painting painting3"></span>
					<span class="brush brush2 painting painting3"></span>
					<ul class="item">
						<li class="item01"><a href="/shopping/category_prd.asp?itemid=436141&amp;pEtr=69279"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_item_04_01.png" alt="Wet garden 새벽 숲 산책 길에 나선 기억" /></a></li>
						<li class="item02"><a href="/shopping/category_prd.asp?itemid=672041&amp;pEtr=69279"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_item_04_02.png" alt="Daisy 햇살 가득 품은 초록 잔디밭의 기억" /></a></li>
					</ul>
				</div>
			</div>

			<div class="collabo">
				<p><a href="/street/street_brand_sub06.asp?makerid=demeter" title="데메테르 브랜드 바로가기"><img src="http://webimage.10x10.co.kr/play/ground/20160222/txt_collabo.png" alt="텐바이텐 플레이 27번째 주제 Scent와 기억속 향기 안내자 데메테르가 사람들의 기억속에 있던 추억을 꺼내 향기를 만드는 프로젝트를 통해 기억의 향기를 만들었습니다. 생각하지 못한, 하지만 항상 당신의 기억속에 있던 그 향기를 안내하는, 기억의 안내자 데메테르입니다. 350여가지 이상의 기억을 담고 있는 향기도서관이라는 뜻의 데메테르는 언제어디서나 향기를 만나게 하는 기억향수입니다." /></a></p>
			</div>

			<div class="rollingWrap">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20160222/tit_like_v1.png" alt="당신이 간직하고 싶은 기억을 담아주세요 응모하신 사진으로 향수병의 라벨로 만들어 드립니다." /></h4>
				<div class="rolling">
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide swiper-slide-01">
									<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_slide_01_off.png" alt="" /></span>
								</div>
								<div class="swiper-slide swiper-slide-02">
									<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_slide_02_off.png" alt="" /></span>
								</div>
								<div class="swiper-slide swiper-slide-03">
									<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_slide_03_off.png" alt="" /></span>
								</div>
								<div class="swiper-slide swiper-slide-04">
									<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_slide_04_off.png" alt="" /></span>
								</div>
								<div class="swiper-slide swiper-slide-05">
									<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_slide_05_off.png" alt="" /></span>
								</div>
								<div class="swiper-slide swiper-slide-06">
									<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_slide_06_off.png" alt="" /></span>
								</div>
								<div class="swiper-slide swiper-slide-07">
									<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_slide_07_off.png" alt="" /></span>
								</div>
								<div class="swiper-slide swiper-slide-08">
									<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_slide_08_off.png" alt="" /></span>
								</div>
							</div>
						</div>
						<div class="pagination"></div>
					</div>
					<button type="button" class="btn-nav btn-prev">Previous</button>
					<button type="button" class="btn-nav btn-next">Next</button>
					<span class="shadow"><img src="http://webimage.10x10.co.kr/play/ground/20160222/bg_shadow.png" alt="" /></span>
				</div>
			</div>

			<div class="event">
				<h4 class="hidden">나만의 향기 만들기 이벤트 참여 방법</h4>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160222/txt_event_v2.png" alt="응모하신 분들 중 추첨을 통해 20분에게 나만의 기억을 담은 향기를 만들 수 있는 데메테르 향기 만들기 체험권을 드립니다 응모기간은 2016년 2월 22일부터 3월 6일까지며 당첨자 발표는 2016년 3월 8일입니다." /></p>
				<div class="upload">
					<span class="mobile shake"><img src="http://webimage.10x10.co.kr/play/ground/20160222/img_mobile.png" alt="" /></span>
					<p><a href="https://www.instagram.com/your10x10/" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160222/txt_upload.png" alt="향수로 남기고 싶은 기억의 사진을 인스타그램에 #텐바이텐향기 해시태그와 함께 업로드 해주세요! 사진과 함께 짧은 이유를 남겨주시면 더 좋아요! 텐바이텐 인스타그램 계정 @your10x10을 팔로우하면 당첨확률이 UP! 인스타그램 계정이 비공개인 경우 집계가 되지 않습니다. #텐바이텐향기 해시태그를 남긴 사진은 이벤트 참여를 의미하며, 플레이 페이지에 자동 노출될 수 있습니다." /></a></p>
				</div>
				<p><a href="www.10x10.co.kr/1143776" title="데메테르 퍼퓸 스튜디오 이용 방법 더 자세히 보기"><img src="http://webimage.10x10.co.kr/play/ground/20160222/txt_way_v2.png" alt="이벤트 당첨이 되면 향수공병과 티켓이 배송됩니다. 향수공병과 티켓을 가지고 청담에 위치한 데메테르 매장을 방문합니다. 나의 스타일과 기억을 담아 시트지를 작성합니다. 조향사와 함께 나만의 기억을 담은 향기를 만들어 기억을 간직하세요!" /></a></p>
			</div>

			<div class="instagram">
				<div id="instagram" class="hgroup">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20160222/tit_instagram_v1.png" alt="기억의 향기를 담은 사진" /></h4>
					<a href="https://www.instagram.com/your10x10/" target="_blank" title="새창" class="btnInstagram"><img src="http://webimage.10x10.co.kr/play/ground/20160222/btn_instagram_tenten.gif" alt="텐바이텐 인스타그램" /></a>
				</div>

				<%
				sqlstr = "Select * From "
				sqlstr = sqlstr & " ( "
				sqlstr = sqlstr & " 	Select row_Number() over (order by idx desc) as rownum, snsid, link, img_low, img_thum, img_stand, text, snsuserid, snsusername, regdate "
				sqlstr = sqlstr & " 	From db_AppWish.dbo.tbl_snsSelectData "
				sqlstr = sqlstr & " 	Where evt_code="& eCode &""
				sqlstr = sqlstr & " ) as T "
				sqlstr = sqlstr & " Where RowNum between "&(iCCurrpage*iCPageSize)-7&" And "&iCCurrpage*iCPageSize&" "
	
				'response.write sqlstr & "<br>"
				rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
				If Not(rsCTget.bof Or rsCTget.eof) Then
				%>
				<ul class="instagramList">
					<%
					Do Until rsCTget.eof
					%>
					<% '8개 뿌리기 %>
					<li>
						<a href="<%=rsCTget("link")%>">
							<div class="figure"><img src="<%=rsCTget("img_stand")%>" onerror="this.src='http://webimage.10x10.co.kr/play/ground/20160222/img_not_found.jpg'" width="228" height="228" alt="" /></div>
							<div class="article"><span class="id"><%= printUserId(rsCTget("snsusername"),2,"*") %></span> <p><%=chrbyte(stripHTML(rsCTget("text")),37,"Y")%></p></div>
						</a>
					</li>
					<%
					rsCTget.movenext
					Loop
					%>
				</ul>

				<div class="pageWrapV15">
					<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
				<%
				End If
				rsCTget.close
				%>
			</div>
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
				<input type="hidden" name="iCC" value="1">
				<input type="hidden" name="reload" value="ON">
				<input type="hidden" name="iCTot" value="<%= iCTotCnt %>">
			</form>
		</div>

<script type="text/javascript">
$(function(){
	/* skip to contents */
	$("#navigator ul li a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
	});

	/* swiper js */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:5,
		speed:1500,
		autoplay:800,
		loop:true,
		pagination: '.pagination',
		simulateTouch:false,
		onSlideChangeStart: function(){
			$('.swiper-slide').find('.off').delay(0).animate({"opacity":"1"},100);
			$('.swiper-slide-active').find('.off').animate({"opacity":"0"});
		}
	});
	$('.btn-prev').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('.btn-next').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$('.pagination span:nth-child(1)').append('<em class="desc1"></em>');
	$('.pagination span:nth-child(2)').append('<em class="desc2"></em>');
	$('.pagination span:nth-child(3)').append('<em class="desc3"></em>');
	$('.pagination span:nth-child(4)').append('<em class="desc4"></em>');
	$('.pagination span:nth-child(5)').append('<em class="desc5"></em>');
	$('.pagination span:nth-child(6)').append('<em class="desc6"></em>');
	$('.pagination span:nth-child(7)').append('<em class="desc7"></em>');
	$('.pagination span:nth-child(8)').append('<em class="desc8"></em>');

	$('.pagination span em').hide();
	$('.pagination .swiper-active-switch em').show();

	setInterval(function() {
		$('.pagination span em').hide();
		$('.pagination .swiper-active-switch em').show();
	}, 500);

	$('.pagination span, .btn-nav').click(function(){
		$('.pagination span em').hide();
		$('.pagination .swiper-active-switch em').show();
	});

	/* animation effect */
	$("#titleAnimation h3 span").css({"opacity":"0"});
	$("#titleAnimation .letter1").css({"margin-left":"10px"});
	$("#titleAnimation .letter2").css({"margin-right":"10px"});
	$("#titleAnimation .letter4, #titleAnimation .letter6").css({"margin-top":"20px", "opacity":"0"});
	$("#titleAnimation .letter5").css({"margin-top":"-20px", "opacity":"0"});
	$("#titleAnimation .hand").css({"bottom":"-150px", "opacity":"0"});
	function titleAnimation() {
		$("#titleAnimation .letter4").delay(100).animate({"margin-top":"0", "opacity":"1"},800);
		$("#titleAnimation .letter5").delay(100).animate({"margin-top":"0", "opacity":"1"},800);
		$("#titleAnimation .letter6").delay(100).animate({"margin-top":"0", "opacity":"1"},800);
		$("#titleAnimation .letter1").delay(700).animate({"margin-left":"0", "opacity":"1"},900);
		$("#titleAnimation .letter2").delay(700).animate({"margin-right":"0", "opacity":"1"},900);
		$("#titleAnimation .letter3").delay(100).animate({"opacity":"1"},200);
		$("#titleAnimation .letter3").delay(500).addClass("visible");
		$("#titleAnimation .hand").delay(1200).animate({"bottom":"0", "opacity":"1"},2500);
	}

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 100) {
			titleAnimation();
		}
		if (scrollTop > 1300) {
			animation1();
		}
		if (scrollTop > 2000) {
			animation2();
		}
		if (scrollTop > 3000) {
			animation3();
		}
		if (scrollTop > 3900) {
			animation4();
		}
		if (scrollTop > 6200) {
			slideUpAnimation();
		}
	});

	$(".contents h4 .title").css({"left":"10px", "opacity":"0"});
	function animation1() {
		$(".contents .scent01 h4 .title").delay(100).animate({"left":"0", "opacity":"1"},900);
		$(".contents .brush").addClass("painting");
	}
	function animation2() {
		$(".contents .scent02 h4 .title").delay(100).animate({"left":"0", "opacity":"1"},900);
	}
	function animation3() {
		$(".contents .scent03 h4 .title").delay(100).animate({"left":"0", "opacity":"1"},900);
	}
	function animation4() {
		$(".contents .scent04 h4 .title").delay(100).animate({"left":"0", "opacity":"1"},900);
	}

	/* slideUp animation */
	function slideUpAnimation () {
		$(".instagramList li").addClass("fadeInSlideUp");
	}
});
</script>
<!--[if lte IE 9]>
	<script type="text/javascript">
		$(function(){
			$(".instagramList li").css({"opacity":"1"});
		});
	</script>
<![endif]-->
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbCTclose.asp" -->