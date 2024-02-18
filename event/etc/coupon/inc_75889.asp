<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 설특집쿠폰 WWW
' History : 2017-01-26 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, couponcnt1, couponcnt2, getbonuscoupon1, getbonuscoupon2, getbonuscoupon3

IF application("Svr_Info") = "Dev" THEN
	eCode = 66271
	getbonuscoupon1 = 2834
	getbonuscoupon2 = 2835
Else
	eCode = 75889
	getbonuscoupon1 = 952	'10000/60000
	getbonuscoupon2 = 953	'30000/200000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style type="text/css">
.coupon {position:relative;}
.coupon a {position:absolute; left:50%; top:355px; margin-left:-215px;}
.coupon .hurryup {position:absolute; left:50%; top:330px; margin-left:130px; animation:bounce 1s infinite;}
.coupon .soldout {position:absolute; left:50%; top:25px; margin-left:-489px;}
.evtNoti {position:relative; padding:50px 0 40px 318px; text-align:left; background:#f5f5f5;}
.evtNoti h3 {position:absolute; left:146px; top:50%; margin-top:-34px;}
.evtNoti ul {padding-left:66px; border-left:2px solid #e9e9e8;}
.evtNoti li {padding:5px 0; font-size:12px; line-height:13px; color:#8a8381;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() >= #01/30/2017 00:00:00# And now() < #01/31/2017 23:59:59# then %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.텐바이텐에서 사용하세요! ');
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
			alert("이벤트 기간이 아닙니다.");
			return;
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	<% End IF %>
}
</script>
<div class="evt75889">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/75889/tit_newyear_coupon.png" alt="설특집쿠폰" /></h2>
	<div class="coupon">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/75889/img_coupon.png" alt="6만원이상 구매시 1만원할인, 20만원이상 구매시 3만원할인" /></div>

		<% if couponcnt1 < 30000 then %>
			<%' 쿠폰 다운로드 %>
			<a href="" <% if couponcnt1 < 30000 then %>onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2017/75889/btn_download.png" alt="쿠폰 한번에 다운받기" /></a>
		<% End If %>

		<% if couponcnt1 >= 25000 And couponcnt1 < 30000 then %>
			<%' 마감임박시 %>
			<p class="hurryup"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75889/txt_hurryup.png" alt="마감임박" /></p>
		<% End If %>

		<% if couponcnt1 >= 30000 then %>
			<%' 솔드아웃 %>
			<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75889/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다 다음 기회를 기다려주세요!" /></p>
		<% End If %>
	</div>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/75889/btn_go.png" alt="설특집쿠폰" usemap="#cuponMap" />
		<map name="cuponMap" id="cuponMap">
			<area shape="rect" coords="144,87,425,154" href="/event/appdown/" alt="텐바이텐 APP 다운받기" />
			<area shape="rect" coords="713,87,996,154" href="/member/join.asp" alt="텐바이텐에 처음 오셨나요?" />
		</map>
	</div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/75889/tit_noti.png" alt="이벤트 유의사항 " /></h3>
		<ul>
			<li>- 이벤트는 ID당 1회만 참여할 수 있습니다.</li>
			<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능합니다.</li>
			<li>- 쿠폰은 1/31(화) 23시 59분 59초에 종료됩니다.</li>
			<li>- 주문한 상품에 따라 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->