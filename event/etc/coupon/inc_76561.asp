<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2017 봄맞이 쿠폰
' History : 2017-03-03 유태욱
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
	eCode = 66286
	getbonuscoupon1 = 2824
	getbonuscoupon2 = 2825
'	getbonuscoupon3 = 0000
Else
	eCode = 76561
	getbonuscoupon1 = 962	'10000/60000
	getbonuscoupon2 = 963	'30000/200000
'	getbonuscoupon3 = 000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")

%>
<style>
.evt76561 {background:#ffe6e5;}
.coupon {position:relative;}
.coupon a {position:absolute; left:50%; top:268px; margin-left:-197px;}
.coupon .hurryup {position:absolute; left:50%; top:250px; margin-left:130px; animation:bounce 1s infinite;}
.coupon .soldout {position:absolute; left:50%; top:0; margin-left:-406px;}
.evtNoti {position:relative; padding:35px 0 35px 310px; text-align:left; background:#f5f5f5;}
.evtNoti h3 {position:absolute; left:145px; top:50%; margin-top:-31px;}
.evtNoti ul {padding-left:60px; border-left:2px solid #e9e9e8;}
.evtNoti li {padding:5px 0; font-size:11px; line-height:12px; color:#7c7c7c;}
.evtNoti li a {text-decoration:underline; color:#776443;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #03/07/2017 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			<% if couponcnt1 < 30000 then %>
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/coupon/couponshop_process.asp",
					data: "mode=cpok&stype="+stype+"&idx="+idx,
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str.split("||")
				if (str1[0] == "11"){
					alert('쿠폰이 발급 되었습니다.\n3월7일 자정까지 사용하세요.');
					return false;
				}else if (str1[0] == "12"){
					alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
					return false;
				}else if (str1[0] == "13"){
					alert('이미 다운로드 받으셨습니다.');
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
				alert('쿠폰이 모두 소진되었습니다.');
				return false;
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
	<div class="evt76561">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/76561/tit_spring.png" alt="살랑살랑봄쿠폰" /></h2>
		<div class="coupon">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/76561/img_coupon.png" alt="6만원이상 구매시 1만원할인, 20만원이상 구매시 3만할인" /></div>
			<%'' 쿠폰 다운로드 %>
			<a href="" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76561/btn_download.png" alt="쿠폰 한번에 다운받기" /></a>

			<%'' 마감임박시 %>
			<% if couponcnt1 >= 25000 and couponcnt1 < 30000 then %>
				<p class="hurryup"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76561/txt_hurry_up.png" alt="마감임박" /></p>
			<% end if %>

			<% if couponcnt1 >= 30000 then %>
				<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76561/txt_sold_out.png" alt="쿠폰이 모두 소진되었습니다 다음 기회를 기다려주세요!" /></p>
			<% end if %>
		</div>
		<div>
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/76561/img_down.png" alt="" usemap="#downMap"/>
			<map name="downMap">
				<area shape="rect" coords="142,71,445,151" href="/event/appdown/" alt="텐바이텐 APP 다운받기">
				<area shape="rect" coords="709,71,1012,150" href="/member/join.asp" alt="회원가입하러 가기">
			</map>
		</div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/76561/tit_noti.png" alt="이벤트 유의사항 " /></h3>
			<ul>
				<li>- 이벤트는 ID당 1회만 참여할 수 있습니다</li>
				<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능합니다</li>
				<li>- 쿠폰은 3/7(화) 23시 59분 59초에 종료됩니다</li>
				<li>- 주문한 상품에 따라 배송비용은 추가로 발생할 수 있습니다</li>
				<li>- 이벤트는 조기 마감될 수 있습니다</li>
			</ul>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->