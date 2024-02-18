<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID

IF application("Svr_Info") = "Dev" THEN
	eCode = "66176"
Else
	eCode = "72158"
End If

vUserID = getEncLoginUserID
%>
<style type="text/css">
img {vertical-align:top;}

.followCoupon .article {position:relative; height:654px; padding-top:360px; background:#131f44 url(http://webimage.10x10.co.kr/eventIMG/2016/72158/bg_space_v1.jpg) no-repeat 50% 0;}
.followCoupon .article h2 {position:absolute; top:123px; left:465px;}
.followCoupon .article .eight {position:absolute; top:95px; left:303px;}
.followCoupon .article .eight img {animation-name:flip; animation-duration:1s; animation-iteration-count:1; backface-visibility:visible;}
@keyframes flip {
	0% {transform:rotateZ(180deg); animation-timing-function:ease-out;}
	100% {transform:rotateZ(360deg); animation-timing-function:ease-in;}
}

.followCoupon .article .shootingstar {position:absolute; top:10px; left:365px; animation-delay:2s;}
.followCoupon .article .shootingstar2 {top:250px; left:67px; animation-delay:2.5s;}
.followCoupon .article .shootingstar3 {top:-30px; left:940px; animation-delay:3s;}
@keyframes meteor1 {
	0% {margin-top:0; margin-right:0; opacity:1;}
	8% {opacity:0;}
	10% {margin-top:150px; margin-left:-150px; opacity:0;}
	100% {opacity:0;}
}
.meteor1 {animation:meteor1 6s linear infinite;}
@keyframes meteor2 {
	0% {margin-top:0; margin-right:0; opacity:1;}
	8% {opacity:0;}
	10% {margin-top:100px; margin-left:-100px; opacity:0;}
	100% {opacity:0;}
}
.meteor2 {animation:meteor2 5s linear infinite;}

.followCoupon .article .btnDownload {position:absolute; bottom:78px; left:50%; margin-left:-220px; background:none;}
.followCoupon .article .btnDownload:hover img {animation-name:shake; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:2;}
@keyframes shake {
	0%, 100% {transform:translateX(0);}
	10%, 30%, 50%, 70%, 90% {transform:translateX(-10px);}
	20%, 40%, 60%, 80% {transform:translateX(10px);}
}
.shake {animation-name:shake;}

.guide {position:relative; padding:36px 0 34px; background-color:#e4e5e9; text-align:left;}
.guide h3 {position:absolute; top:50%; left:115px; margin-top:-33px;}
.guide ul {margin-left:271px; padding:0 0 2px 65px; border-left:1px solid #c0c3c9;}
.guide ul li {position:relative; margin-top:10px; padding-left:10px; color:#484848; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.guide ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#484848;}
.guide ul li a {color:#f72a2a; text-decoration:underline;}
</style>
<script type="text/javascript">
function fnCouponDownload() {
	<% If Now() > #08/05/2016 23:59:59# Then %>
		alert("이벤트가 종료되었습니다.");
		return;
	<% End If %>

	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여할 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
	var reStr;
	var str = $.ajax({
		type: "GET",
		url:"/event/etc/doeventsubscript/doEventSubscript72158.asp",
		data: "mode=down",
		dataType: "text",
		async: false
	}).responseText;
		reStr = str.split("|");
		if(reStr[0]=="OK"){
			if(reStr[1] == "dn") {
				alert('다운로드가 완료되었습니다.\n24시간안에 사용하세요!');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		}else{
			errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			document.location.reload();
			return false;
		}
	<% End If %>
}
</script>
<div class="eventContV15 tMar15">
	<div class="contF">
		<div class="evt72158 followCoupon">
			<div class="article">
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/72158/tit_follow_coupon.png" alt="신규회원 전용 이벤트 follow 쿠폰 8월 텐바이텐에 가입하는 모든 분들께 드립니다!" /></h2>
				<span class="eight"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72158/img_eight.png" alt="" /></span>
				<span class="shootingstar shootingstar1 meteor1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72158/img_shooting_star_01.png" alt="" /></span>
				<span class="shootingstar shootingstar2 meteor2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72158/img_shooting_star_02.png" alt="" /></span>
				<span class="shootingstar shootingstar3 meteor2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72158/img_shooting_star_03.png" alt="" /></span>

				<div class="coupon">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72158/img_coupon.png" alt="삼만원 이상 구매시 오천원 할인 쿠폰, 육만원 이상 구매시 만원 할인 쿠폰, 십만원 이상 구매 시 만오천원 할인 쿠폰을 드리며 사용 기간은 발급 후 24시간 이내입니다." /></p>
					<a href="#" onclick="fnCouponDownload(); return false;" class="btnDownload"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72158/btn_down.png" alt="쿠폰 다운받기" /></a>
				</div>
			</div>
			<div class="guide">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72158/tit_coupon_guide.png" alt="쿠폰 사용법" /></h3>
				<ul>
					<li><span></span>8월 신규가입  고객에게만 발급되는 쿠폰입니다.</li>
					<li><span></span>쿠폰은 <a href="/my10x10/couponbook.asp">MY TENBYTEN &gt; 쿠폰/보너스쿠폰</a> 에서 확인할 수 있습니다.</li>
					<li><span></span>발급 후 24시간  이내 미 사용시 쿠폰은 소멸되며, 재발급이 불가합니다.</li>
					<li><span></span>이벤트는 조기 종료 될 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->