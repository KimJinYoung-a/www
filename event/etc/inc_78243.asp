<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : [2017 6월 신규가입이벤트] 반가워육 쿠폰
' History : 2017.05.31 원승현
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
	eCode = "66333"
Else
	eCode = "78243"
End If

vUserID = getEncLoginUserID
%>
<style>
.evt78243 {background:#faf6b4;}
.coupon {position:relative;}
.coupon a {position:absolute; left:50%; top:270px; margin-left:-211px;}
.evtNoti {position:relative; padding:42px 0 42px 300px; text-align:left; background:#9f9e7d;}
.evtNoti h3 {position:absolute; left:111px; top:50%; margin-top:-10px;}
.evtNoti ul {padding:7px 0 7px 60px; border-left:1px solid #cfcfbe;}
.evtNoti li {padding:6px 0; font-size:11px; line-height:12px; color:#fff;}
.evtNoti li a {color:#fff494;}
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
		url:"/event/etc/doeventsubscript/doEventSubscript78243.asp",
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
<%' 반가워육 쿠폰 %>
<div class="evt78243">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/78243/tit_coupon.png" alt="반가워육!" /></h2>
	<div class="coupon">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78243/txt_coupon.png" alt="6만원이상 구매시 1만원할인, 10만원이상 구매시 1만5천원할인" /></div>
		<a href="" onclick="fnCouponDownload(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78243/btn_coupon.png" alt="쿠폰 다운받기" /></a>
	</div>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78243/txt_event_2.png" alt="신규회원 가입시 추가 혜택! 5만원 이상 구매 시 2천원 쿠폰 2만원 이상 구매 시 무료배송 쿠폰"/></div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77665/tit_noti.png" alt="이벤트 유의사항 " /></h3>
		<ul>
			<li>- 6월 신규가입  고객에게만 발급되는 쿠폰입니다.</li>
			<li>- 쿠폰은 <a href="/my10x10/couponbook.asp">MY TENBYTEN &gt; 쿠폰/보너스쿠폰</a> 에서 확인할 수 있습니다.</li>
			<li>- 발급 후 24시간 이내 미 사용시 쿠폰은 소멸되며, 재발급이 불가합니다.</li>
			<li>- 이벤트는 조기 종료될 수 있습니다.</li>
		</ul>
	</div>
</div>
<%'// 반가워육 쿠폰 %>

<!-- #include virtual="/lib/db/dbclose.asp" -->