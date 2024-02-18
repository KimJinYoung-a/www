<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : [2017 3월 신규가입이벤트] 작심삼월 쿠폰
' History : 2017.02.28 유태욱
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
	eCode = "66284"
Else
	eCode = "76495"
End If

vUserID = getEncLoginUserID
%>
<style>
.evt76495 {background:#fcf7ab;}
.coupon {position:relative;}
.coupon a {position:absolute; left:50%; top:268px; margin-left:-197px;}
.coupon .hurryup {position:absolute; left:50%; top:255px; margin-left:130px; animation:bounce 1s infinite;}
.coupon .soldout {position:absolute; left:50%; top:3px; margin-left:-411px;}
.evtNoti {position:relative; padding:35px 0 35px 310px; text-align:left; background:#fcd48d;}
.evtNoti h3 {position:absolute; left:140px; top:50%; margin-top:-30px;}
.evtNoti ul {padding-left:66px; border-left:2px solid #fadf8d;}
.evtNoti li {padding:5px 0; font-size:12px; line-height:13px; color:#776443;}
.evtNoti li:first-child {padding:15px 0 5px;}
.evtNoti li:first-child + li + li + li {padding:5px 0 15px;}
.evtNoti li a {text-decoration:underline; color:#776443;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
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
		url:"/event/etc/doeventsubscript/doEventSubscript76495.asp",
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
	<!-- 3월 쿠폰 -->
	<div class="evt76495">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/76495/tit_march_coupon.png" alt="작심삼월쿠폰" /></h2>
		<div class="coupon">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/76495/img_coupon.png" alt="6만원이상 구매시 1만원할인, 10만원이상 구매시 1만5천원할인" /></div>
			<%'' 쿠폰 다운로드 %>
			<a href="" onclick="fnCouponDownload(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76495/btn_download.png" alt="쿠폰 한번에 다운받기" /></a>
			<%'' <!-- 마감임박시<p class="hurryup"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76495/txt_hurryup.png" alt="마감임박" /></p>--> %>
			<%'' <!-- 솔드아웃 <p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76495/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다 다음 기회를 기다려주세요!" /></p>--> %>
		</div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/76495/tit_noti.png" alt="이벤트 유의사항 " /></h3>
			<ul>
				<li>- 3월 신규가입 고객에게만 발급되는 쿠폰입니다</li>
				<li>- 발급된 쿠폰은 <a href="/my10x10/couponbook.asp">MY TENBYTEN > 쿠폰/보너스쿠폰</a>에서 확인할 수 있습니다.</li>
				<li>- 발급 후 24시간 이내 미 사용시, 쿠폰은 소멸되며 재발급이 불가합니다.</li>
				<li>- 이벤트는 조기 종료될 수 있습니다.</li>
			</ul>
		</div>
	</div>
	<!--// 3월 쿠폰 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->