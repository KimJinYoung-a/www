<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : [2017 신규가입이벤트] 쿠폰
' History : 2017.06.30 유태욱
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
	eCode = "66378"
Else
	eCode = "78784"
End If

vUserID = getEncLoginUserID
%>
<style>
.coupon {position:relative;}
.coupon .download {position:absolute; left:50%; bottom:70px; z-index:10; margin-left:-181px; padding-right:0; background:none; animation:bounce 1s 20;}
.evtNoti {position:relative; padding:55px 0 45px 350px; text-align:left; background:#efefef;}
.evtNoti h3 {position:absolute; left:152px; top:55px;}
.evtNoti li {padding-bottom:12px; font-size:11px; line-height:1; color:#666;}
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
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
	var reStr;
	var str = $.ajax({
		type: "GET",
		url:"/event/etc/doeventsubscript/doEventSubscript78784.asp",
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
	<div class="evt78784">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/78784/tit_welcome.png" alt="신규회원 웰컴쿠폰" /></h2>
		<div class="coupon">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78784/img_coupon_v3.png" alt="7만원 이상 구매 시 5천원, 15만원 이상 구매 시 1만원 할인쿠폰" /></div>
			<p class="download"><a href="" onclick="fnCouponDownload(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78784/btn_download.png" alt="쿠폰 다운받기" /></a></p>
		</div>
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78784/txt_benefit.png" alt="신규회원 가입 시 추가 혜택 - 5만원 이상 구매 시 2천원 할인, 2만원이상 구매 시 무료배송 쿠폰 증정" /></div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78784/tit_noti.png" alt="이벤트 유의사항 " /></h3>
			<ul>
				<li>- 텐바이텐 신규가입 고객에게만 발급되는 쿠폰입니다.</li>
				<li>- 쿠폰은 <a href="/my10x10/couponbook.asp">MY TENBYTEN > 쿠폰/보너스쿠폰</a> 에서 확인할 수 있습니다.</li>
				<li>- 발급 후 24시간 이내 미사용시 쿠폰은 소멸되며, 재발급이 불가합니다.</li>
				<li>- 이벤트는 조기 종료될 수 있습니다.</li>
			</ul>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->