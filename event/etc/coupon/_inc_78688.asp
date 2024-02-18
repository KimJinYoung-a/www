<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2017 선착순 쿠폰
' History : 2017-06-21 정태훈
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, couponcnt1, couponcnt2,  getbonuscoupon1, getbonuscoupon2, getbonuscoupon3

IF application("Svr_Info") = "Dev" THEN
	eCode = 66336
	getbonuscoupon1 = 2846
	getbonuscoupon2 = 2825
'	getbonuscoupon3 = 0000
Else
	eCode = 78688
	getbonuscoupon1 = 988	'10000/60000
	getbonuscoupon2 = 984	'15000/100000
'	getbonuscoupon3 = 000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", left(now(),10))
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style>
.evt78688 h2 {visibility:hidden; width:0; height:0;}
.coupon {position:relative;}
.coupon p {position:absolute;}
.coupon .download {left:50%; bottom:90px; z-index:10; margin-left:-190px; padding-right:0; background:none;}
.coupon .open {left:50%; bottom:90px; z-index:10; margin-left:-190px;}
.coupon .hurry {right:312px; top:348px;}
.coupon .soldout {left:50%; bottom:90px; z-index:10; margin-left:-190px;}
.coupon .lastday {right:284px; top:86px; animation:bounce 1s 20;}
.evtNoti {position:relative; padding:40px 0 40px 297px; text-align:left; background:#737374;}
.evtNoti h3 {position:absolute; left:110px; top:50%; margin-top:-10px;}
.evtNoti ul {padding:0 0 0 60px; border-left:1px solid #9d9d9e;}
.evtNoti li {padding:3px 0; color:#fff;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #06/23/2017 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			<% if GetLoginUserLevel()=7 then %>
				alert("Staff 사절.");
				return;
			<% else %>
				<% if couponcnt1 < 1000 then %>
					var str = $.ajax({
						type: "POST",
						url: "/event/etc/coupon/couponshop_process.asp",
						data: "mode=cpok&stype="+stype+"&idx="+idx,
						dataType: "text",
						async: false
					}).responseText;
					var str1 = str.split("||")
					if (str1[0] == "11"){
						alert('쿠폰이 발급되었습니다. 오늘 하루 app에서 사용하세요.');
						return false;
					}else if (str1[0] == "12"){
						alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
						return false;
					}else if (str1[0] == "13"){
						alert('이미 발급 받으셨습니다. 이벤트는 ID당 1회만 참여 할 수 있습니다.');
						return false;
					}else if (str1[0] == "02"){
						alert('로그인 후 쿠폰을 받을 수 있습니다!');
						return false;
					}else if (str1[0] == "01"){
						alert('잘못된 접속입니다.');
						return false;
					}else if (str1[0] == "00"){
						alert('정상적인 경로가 아닙니다.');
						return false;
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				<% else %>
					alert('쿠폰이 마감되었습니다. 다음에 다시 도전하세요!');
					return false;
				<% end if %>
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
<!-- 선착순 쿠폰 -->
<div class="evt78688">
	<h2>선착순 쿠폰 - 하루 1,000명에게 주어지는 APP 전용쿠폰에 도전하세요!</h2>
	<div class="coupon">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/img_coupon.png" alt="1만원 이상 구매 시 5천원 할인쿠폰 (앱전용)" /></div>
		<% If now() < #06/23/2017 23:59:59# then %>
			<% if couponcnt1 > 500 and couponcnt1 < 1000 then %>
			<!-- 마감임박 --><p class="hurry"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/txt_hurryup.png" alt="마감임박" /></p>
			<% End If %>
			<% if couponcnt1 >= 1000 then %>
			<!-- 마감 --><p class="soldout"><a href="" onclick="jsevtDownCoupon('evttosel,','<%= getbonuscoupon1 %>,'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/txt_finish.png" alt="쿠폰이 마감되었습니다. 다음에 다시 도전하세요!" /></a></p>
			<% Else %>
			<% If now() >= #06/22/2017 10:00:00# And now() <= #06/22/2017 23:59:59# then %>
			<!-- 쿠폰 다운로드 --><p class="download"><a href="" onclick="jsevtDownCoupon('evttosel,','<%= getbonuscoupon1 %>,'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/btn_download.png" alt="쿠폰 다운받기" /></a></p>
			<% ElseIf now() >= #06/23/2017 10:00:00# And now() <= #06/23/2017 23:59:59# then %>
			<!-- 쿠폰 다운로드 --><p class="download"><a href="" onclick="jsevtDownCoupon('evttosel,','<%= getbonuscoupon1 %>,'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/btn_download.png" alt="쿠폰 다운받기" /></a></p>
			<% Else %>
			<!-- 오전10시 오픈 --><p class="open"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/txt_open_10am.png" alt="오전 10시 오픈" /></p>
			<% End If %>
			<% End If %>
		<% Else %>
		<!-- 마감 --><p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/txt_finish.png" alt="쿠폰이 마감되었습니다. 다음에 다시 도전하세요!" /></p>
		<!-- 마지막날 --><p class="lastday"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/txt_last.png" alt="쿠폰이 마감되었습니다. 다음에 다시 도전하세요!" /></p>
		<% End If %>
	</div>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/img_qr.png" alt="이벤트 유의사항 " /></div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78688/tit_noti.png" alt="이벤트 유의사항 " /></h3>
		<ul>
			<li>- 이벤트는 ID당 1회만 참여할 수 있습니다.</li>
			<li>- 지급된 쿠폰은 텐바이텐에서 APP만 사용 가능 합니다.</li>
			<li>- 쿠폰은 발급 당일 자정까지 사용 가능합니다.</li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!--// 선착순 쿠폰 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->