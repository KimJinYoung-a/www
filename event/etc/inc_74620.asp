<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : [12월 신규가입이벤트] 1+1 Coupon!
' History : 2016.11.28 유태욱
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
	eCode = "66245"
Else
	eCode = "74620"
End If

vUserID = getEncLoginUserID
%>
<style type="text/css">
img {vertical-align:top;}
.evtNoti {padding-bottom:20px; background:#f8bb5b;}
.evtNoti .evtNotiConts {overflow:hidden; padding:40px 0 40px 115px; text-align:left; background:#d28e3f;}
.evtNoti h3 {float:left; width:186px; padding-top:45px;}
.evtNoti ul {float:left; width:705px; padding:13px 0 0 55px; color:#fff; border-left:1px solid #fff; font-size:11px;}
.evtNoti li {padding-bottom:13px; line-height:11px;}
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
		url:"/event/etc/doeventsubscript/doEventSubscript74620.asp",
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
	<div class="evt74620">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/74620/tit_happy.jpg" alt="해피두개더" /></h2>
		<div class="getCoupon">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/74620/img_coupons.jpg" alt="6만원 이상 구매 시 10,000원 10만원 이상 구매 시 15,000원 사용기간 : 발급후 24시간" /></div>
			<a href="" onclick="fnCouponDownload(); return false;" ><img src="http://webimage.10x10.co.kr/eventIMG/2016/74620/btn_coupons.jpg" alt="쿠폰 다운받기" /></a>
		</div>
		<div class="evtNoti">
			<div class="evtNotiConts">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74620/txt_event_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>- 12월 신규가입 고객에게만 발급되는 쿠폰입니다.</li>
					<li>- 쿠폰은 <a href="/my10x10/couponbook.asp">MY TENBYTEN &gt; 쿠폰/보너스쿠폰</a> 에서 확인할 수 있습니다.</li>
					<li>- 발급 후 24시간 이내 미 사용시 쿠폰은 소멸되며, 재발급이 불가합니다.</li>
					<li>- 이벤트는 조기 종료 될 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->