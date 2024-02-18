<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 2015 14주년이벤트 - 인트로
' History : 2015-10-07 이종화
'####################################################
%>
<style type="text/css">
/* 14th anniversary common */
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

.anniversary14th {background:#f3f3f3 url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/bg_gray.png) repeat 50% 0;}
.anniversary14th .growMap {position:relative; padding-top:97px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/bg_sky_wave.png) repeat-x 50% 0;}
.anniversary14th .growMap .date {position:absolute; top:24px; left:50%; margin-left:422px;}
.anniversary14th .growMap .leaf01 {position:absolute; top:457px; left:50%; margin-left:520px; animation:swing01 5s ease-in-out 0s infinite; transform-origin:0% 100%;}
.anniversary14th .growMap .leaf02 {position:absolute; top:1351px; left:50%; margin-left:-645px; animation:swing02 4s ease-in-out 0s infinite; transform-origin:100% 100%}
.anniversary14th .growMap .cloud01 {position:absolute; top:109px; left:50%; margin-left:-797px;}
.anniversary14th .growMap .cloud02 {position:absolute; top:222px; left:50%; margin-left:-504px;}
.anniversary14th .growMap .cloud03 {position:absolute; top:72px; left:50%; margin-left:364px;}
.anniversary14th .growMap .cloud04 {position:absolute; top:289px; left:50%; margin-left:631px;}
.anniversary14th .growMap .circle01 {position:absolute; top:391px; left:50%; margin-left:-335px;}
.anniversary14th .growMap .circle02 {position:absolute; top:524px; left:50%; margin-left:-630px;}
.anniversary14th .growMap .circle03 {position:absolute; top:739px; left:50%; margin-left:530px;}
.anniversary14th .growMap .circle04 {position:absolute; top:1136px; left:50%; margin-left:488px;}

@keyframes swing01 {
	0% {transform:rotate(0);}
	50% {transform:rotate(-15deg);}
	100% {transform:rotate(0);}
}
@keyframes swing02 {
	0% {transform:rotate(0);}
	50% {transform:rotate(10deg);}
	100% {transform:rotate(0);}
}

.navigatorMap {position:relative; width:1140px; height:1960px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/bg_tree.png) no-repeat 50% 100%;}
.navigatorMap button, .navigatorMap a {display:block; position:absolute;}
.navigatorMap .cpnBtn {left:85px; top:106px; background-color:transparent;}
.navigatorMap .nav1 {right:186px; top:11px;}
.navigatorMap .nav1 em {display:inline-block; position:absolute; right:30px; top:170px;}
.navigatorMap .nav2 {right:34px; top:392px;}
.navigatorMap .nav3 {left:17px; top:492px;}
.navigatorMap .nav4 {right:198px; top:751px;}
.navigatorMap .nav5 {left:133px; top:899px;}
.navigatorMap .nav6 {right:-3px; top:871px;}

.history {position:absolute; left:50%; bottom:100px; margin-left:-15px;}
.history li {text-align:left; padding-top:17px;}

.prsnlArea {position:absolute; left:50%; bottom:87px; width:404px; margin-left:-540px; text-align:left;}
.prsnlArea dt {padding:0 0 30px 8px; font-size:20px; line-height:22px; color:#000; font-family:verdana, tahoma, sans-serif !important;}
.prsnlArea dd {padding:0 8px; font-size:11px; color:#666; font-family:verdana, tahoma, dotum, '돋움', sans-serif;}
.prsnlTxt {background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/txt_line.png) repeat 50% 0; line-height:30px;}
.prsnlTxt p {padding-bottom:30px;}
.prsnlTxt strong, .prsnlTxt a {color:#d50c0c;}
</style>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script>
function jsDownCoupon(stype,idx){
	<% if Not(IsUserLoginOK) then %>
		if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% else %>
		if(confirm('쿠폰을 받으시겠습니까?')) {
			var frm;
			frm = document.frmC;
			frm.stype.value = stype;
			frm.idx.value = idx;
			frm.submit();
		}
	<% end if %>
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<div class="anniversary14th">
							<div class="growMap">
								<h2><a href="/event/14th/"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/tit_14th.png" alt="14th anniversary 잘한다 잘한다 자란다" /></a></h2>
								<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/txt_date.png" alt="열네번째 생일을 맞는 텐바이텐의 성장 프로젝트 이벤트는 2015년 10월 10일부터 26일까지 진행합니다." /></p>
								<span class="cloud01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_cloud01.png" alt="" /></span>
								<span class="cloud02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_cloud02.png" alt="" /></span>
								<span class="cloud03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_cloud03.png" alt="" /></span>
								<span class="cloud04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_cloud04.png" alt="" /></span>
								<span class="leaf01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_leaf01.png" alt="" /></span>
								<span class="leaf02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_leaf02.png" alt="" /></span>
								<span class="circle01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_circle01.png" alt="" /></span>
								<span class="circle02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_circle02.png" alt="" /></span>
								<span class="circle03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_circle03.png" alt="" /></span>
								<span class="circle04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/img_circle04.png" alt="" /></span>
								<div class="navigatorMap">
									<button class="cpnBtn" onclick="javascript:jsDownCoupon('prd,prd,prd','11100,11101,11102');"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/coupon.png" alt="14주년 맞이 SALE 30%~ - 쿠폰 모두 다운받기" /></button>
									<a href="/event/14th/gift.asp" class="nav1"><!--<em><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/ico_soldout.gif" alt="품절임박" /></em>--><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/topic01_v2.png" alt="생일&amp; 선물 - 선물을 받을 권리가 있다. 우리 생일이니까!" /></a>
									<a href="/event/14th/coaster.asp#commentForm" class="nav2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/topic02.png" alt="생일을 축하해주세요 - 여러분의 코멘트를 기다릴게요!" /></a>
									<a href="/event/14th/coaster.asp" class="nav3"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/topic03.png" alt="다함께 코스터 - 12가지 브랜드와의 콜라보레이션! 코스터를 선물로 드립니다." /></a>
									<a href="/event/14th/shop.asp" class="nav4"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/topic04.png" alt="습격자들 - 5분안에 백만원으로 텐바이텐 매장을 털어라!" /></a>
									<a href="/event/14th/shoppingstyle.asp" class="nav5"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/topic05.png" alt="그것이 알고싶다  - 나만의 쇼핑스타일을 확인하고 Gift카드 받자!" /></a>
									<a href="/event/appdown/" class="nav6"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/topic06.png" alt="APP 다운로드" /></a>
								</div>
								<ul class="history">
									<li><a href="/event/appdown/"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_01.png" alt="텐바이텐 app 다운로드 200만 돌파" /></a></li>
									<li><a href="/event/eventmain.asp?eventid=56976"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_02.png" alt="웹어워드 코리아 대상수상 (디자인쇼핑몰 부문) 8년 연속!" /></a></li>
									<li style="margin-top:8px;"><a href="/play/playtEpisodeFont.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_03.png" alt="텐바이텐 전용서체 출시" /></a></li>
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_04.png" alt="JYP, YG, SM 굿즈 콜라보레이션 작업" /></li>
									<li><a href="/shopping/category_prd.asp?itemid=131267"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_05.png" alt="무한도전 달력 최초 독점판매" /></a></li>
									<li><a href="http://www.10x10.co.kr/hitchhiker/"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_06.png" alt="감성매거진 히치하이커 발간" /></a></li>
									<li style="margin-top:8px;"><a href="http://www.thefingers.co.kr/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_07.png" alt="핑거스 아카데미 런칭" /></a></li>
									<li style="margin-top:8px;"><a href="http://www.10x10.co.kr/offshop/shopinfo.asp?shopid=streetshop011" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_08.png" alt="대학로 매장 오픈" /></a></li>
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_09.png" alt="디자인 전문쇼핑몰 업계 1위, 계~속!" /></li>
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/history_10.png" alt="디자인 전문쇼핑몰 텐바이텐 시작" /></li>
								</ul>
								<% '### 우리들의 이야기 %>
								<!-- #include file="./inc_ourstory.asp" -->
							</div>
							<% '출석 체크 %>
							<% server.Execute("/event/14th/inc_attendance.asp") %>
						</div>
						<form name="frmC" method="get" action="/shoppingtoday/couponshop_process.asp">
						<input type="hidden" name="stype" value="">
						<input type="hidden" name="idx" value="">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script type="text/javascript">
$(function(){
	/* cloud move */
	function cloud() {
		$(".cloud01").animate({"margin-left":"-797px"},1500).animate({"margin-left":"-780px"},1500, cloud);
		$(".cloud02").animate({"margin-left":"-504px"},2000).animate({"margin-left":"-515px"},2000, cloud);
		$(".cloud03").animate({"margin-left":"364px"},2100).animate({"margin-left":"380px"},2100, cloud);
		$(".cloud04").animate({"margin-left":"631px"},2300).animate({"margin-left":"620px"},2300, cloud);
	}
	cloud();
});
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->