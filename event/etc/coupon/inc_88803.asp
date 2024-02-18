<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2018 서프라이즈 쿠폰
' History : 2018-08-24 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, couponcnt
dim getbonuscoupon1, getbonuscoupon2, getbonuscoupon3, couponcnt1
dim totalbonuscouponcountusingy1, totalbonuscouponcountusingy2, totalbonuscouponcountusingy3

IF application("Svr_Info") = "Dev" THEN
	eCode = 68542
	getbonuscoupon1 = 2824
	getbonuscoupon2 = 2825
'	getbonuscoupon3 = 2798
Else
	eCode = 88803
	getbonuscoupon1 = 1076	'3000/30000
	getbonuscoupon2 = 1077	'10000/60000
'	getbonuscoupon3 = 879
End If

userid = getencloginuserid()

couponcnt=0
totalbonuscouponcountusingy1=0
totalbonuscouponcountusingy2=0
'totalbonuscouponcountusingy3=0

couponcnt = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")

%>
<style>
.evt88803 {position:relative;}
.evtNoti {position:relative; padding:46px 0 42px 509px; text-align:left; background:#282f39;}
.evtNoti h3 {position:absolute; left:285px; top:40px;}
.evtNoti li {padding-bottom:12px; font-size:12px; line-height:1; color:#fff;}
.evtNoti li strong {font-weight:600; color:#ff6f6f;}
@keyframes bounce {
	from to {transform:translateY(5px); animation-timing-function:ease-out;}
	50% {transform:translateY(-7px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">

</script>
<div class="evt88803">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/88803/tit_suprise_coupon.png" alt="서프라이즈 쿠폰 - 지금 App에서 로그인 하고 보너스 쿠폰 받으세요!" /></h2>
	<div class="coupon"><img src="http://webimage.10x10.co.kr/eventIMG/2018/88803/img_suprise_coupon.png" alt="3만원 이상 구매 시 3천원, 6만원 이상 구매 시 1만원 할인쿠폰" /></div>
	<div class="qrcode"><img src="http://webimage.10x10.co.kr/eventIMG/2018/88803/img_suprise_qr_v1.png" alt="지금 QR코드로 텐바이텐 앱에서 쿠폰을 발급받으세요! 본 쿠폰은 텐바이텐 app에서 로그인 시 지급됩니다." /></div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/88803/tit_suprise_noti.png" alt="이벤트 유의사항 " /></h3>
		<ul>
			<li>- 본 이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
			<li>- <strong>지급된 쿠폰은 텐바이텐 APP에서만 사용 가능 합니다.</strong></li>
			<li>- 쿠폰은 8/28(화) 23시 59분 59초에 종료됩니다.</li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->