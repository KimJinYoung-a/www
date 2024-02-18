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
	eCode = "66223"
Else
	eCode = "73892"
End If

vUserID = getEncLoginUserID
%>
<style type="text/css">
img {vertical-align:top;}
.evt73892 {position:relative; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73892/bg_tit_v2.jpg) no-repeat 50% 0;}

.evt73892 .bgLeaves {position:absolute; top:106px; left:50%; margin-left:-570px; z-index:10;}
.evt73892 h2{position:absolute; left:50%; margin-left:-209.5px; padding-top:82px;}

.getCoupon {padding:408px 0 162px 0;}
.getCoupon div {position:relative; padding-bottom:30px;}
.getCoupon a {position:absolute; top: 675px; left:50%; margin-left:-200px; display:block; z-index:20;}

.evtNoti {overflow:hidden; padding:50px 0 50px 145px; text-align:left; background:#ebdbce;}
.evtNoti h3 {float:left; width:162px; padding-top:24px;}
.evtNoti ul {float:left; width:705px; padding:13px 0 0 45px; color:#a04e2e; border-left:1px solid #dcbfae;}
.evtNoti li {padding-bottom:13px; line-height:13px;}
.evtNoti li a {color:#ed3b3b; text-decoration:underline;}
</style>
<script type="text/javascript">
function fnCouponDownload() {
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
		url:"/event/etc/doeventsubscript/doEventSubscript73892.asp",
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
		<div class="evt73892">
			<div class="bgLeaves"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73892/bg_leaves.png" alt="" /></div>
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/73892/tit_coupon.png" alt="신규회원 전용 이벤트 1+1 coupon 11월 텐바이텐에 가입하는 모든 분들께 드립니다!" /></h2>
			<div class="getCoupon">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/73892/img_coupons.png" alt="6만원 이상 구매시 10,000원 발급 후 24시간 10만원 이상 구매시 15,000원 발급 후 24시간" /></div>
				<a href="#" onclick="fnCouponDownload(); return false;" class="btnJoin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73892/btn_go_coupon_v3.png" alt="쿠폰 다운받기" /></a>
			</div>
			<div class="evtNoti">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/73892/tit_noti.png" alt="쿠폰 사용법" /></h3>
				<ul>
					<li>- 11월 신규가입 고객에게만 발급되는 쿠폰입니다.</li>
					<li>- 쿠폰은 <a href="/my10x10/couponbook.asp">MY TENBYTEN &gt; 쿠폰/보너스쿠폰</a> 에서 확인할 수 있습니다.</li>
					<li>- 발급 후 24시간  이내 미 사용시 쿠폰은 소멸되며, 재발급이 불가합니다.</li>
					<li>- 이벤트는 조기 종료 될 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->