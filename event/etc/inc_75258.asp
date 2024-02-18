<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : [2017 1월 신규가입이벤트] 해피뉴이어 Coupon!
' History : 2016.12.30 유태욱
'###########################################################
%>
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
	eCode = "66261"
Else
	eCode = "75258"
End If

vUserID = getEncLoginUserID
%>
<style type="text/css">
img {vertical-align:top;}
.evt75258 {position:relative;}
.evt75258 h2 {visibility:hidden; display:block; font-size:0; content:''; clear:both; height:0;}
.evtNoti {overflow:hidden; padding:45px 100px; text-align:left; background:#5998bd;}
.evtNoti h3 {float:left;}
.evtNoti ul {float:left; width:700px; padding:13px 0 0 45px; color:#fff;}
.evtNoti li {padding-bottom:13px; line-height:13px;}
.evtNoti li a {color:#fff; text-decoration:underline;}
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
		url:"/event/etc/doeventsubscript/doEventSubscript75258.asp",
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
	<!-- 해피뉴이어 coupon -->
	<div class="evt75258">
		<h2>신규회원 전용 쿠폰 이벤트 해피뉴이어쿠폰 - 1월 텐바이텐에 가입하는 모든 분들께 드립니다!</h2>
		<div class="getCoupon">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/75258/img_coupon.png" alt="6만원 이상 구매시 10,000원 발급 후 24시간 10만원 이상 구매시 15,000원 발급 후 24시간" usemap="#cpMap" />
			<map name="cpMap">
				<area shape="rect" coords="347,605,794,710" href="#" onclick="fnCouponDownload(); return false;" alt="쿠폰 다운받기" />
			</map>
		</div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75258/txt_coupon_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>- 1월 신규가입 고객에게만 발급되는 쿠폰입니다.</li>
				<li>- 쿠폰은 <a href="/my10x10/couponbook.asp">MY TENBYTEN &gt; 쿠폰/보너스쿠폰</a> 에서 확인할 수 있습니다.</li>
				<li>- 발급 후 24시간  이내 미 사용시 쿠폰은 소멸되며, 재발급이 불가합니다.</li>
				<li>- 이벤트는 조기 종료 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
	<!--// 해피뉴이어 coupon -->
<!-- #include virtual="/lib/db/dbclose.asp" -->