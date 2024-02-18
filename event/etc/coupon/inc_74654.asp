<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 연말정산쿠폰 WWW
' History : 2016-12-01 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, couponcnt, getbonuscoupon1, getbonuscoupon2, getbonuscoupon3

IF application("Svr_Info") = "Dev" THEN
	eCode = 66248
	getbonuscoupon1 = 2830
	getbonuscoupon2 = 2831
Else
	eCode = 74654
	getbonuscoupon1 = 937	'10000/60000
	getbonuscoupon2 = 938	'30000/200000
End If

couponcnt=0
couponcnt = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
%>
<style type="text/css">
img {vertical-align:top;}

.evt74654 {position:relative;}
.evt74654 .iconFlash{position:absolute; top: 17%; right: 27%; }

.couponDownload {position:relative;}
.couponDownload .soldOutIcon {position:absolute; top:240px; left:720px;animation:bounce 1s infinite;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
.couponDownload .soldOut {position:absolute; top:-13px; left:150px;}
.evt74654 .coupon{overflow:hidden;}
.evt74654 .coupon div {float:left;}

.eventNotice {height:200px; background:#d0d0d0;}
.eventNotice img, .eventNotice .notiContents {float:left;}
.eventNotice img {margin:82px 0 0 110px;}
.eventNotice ul {position:relative; margin:40px 0 0 70px; padding-left:60px; border-left: #a6a6a6 1px solid;}
.eventNotice ul li{color:#6c6c6c; font-size:12px; line-height:12px; text-align: left; padding:6.5px 0;}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() >= #12/05/2016 00:00:00# And now() < #12/06/2016 23:59:59# then %>
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

<div class="evt74654">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/74654/tit_coupon.jpg" alt="연말정산쿠폰" /></h2>
	<div class="couponDownload">
		<% if couponcnt >= 25000 then %>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/74654/img_coupons _v2.jpg" alt="6만원 이상 구매 시 10000원 20만원 이상 구매 시 30000원 사용 기간 : 12/5 ~ 6까지 (2일간)" />
		<% Else %>
			<a href="" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74654/img_coupons _v2.jpg" alt="6만원 이상 구매 시 10000원 20만원 이상 구매 시 30000원 사용 기간 : 12/5 ~ 6까지 (2일간)" /></a>
		<% End If %>
		<%' for dev msg : 쿠폰이 얼마 안남았을때, <p class="soldOutIcon">~</p> 노출 %>
		<% if couponcnt >= 15000 then %>
			<p class="soldOutIcon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74654/icon_sold_out.png" alt="마감임박" /></p>
		<% End If %>
		<%' for dev msg : 솔드아웃시, <p class="soldOut">~</p> 노출%>
		<% if couponcnt >= 25000 then %>
			<p class="soldOut"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74654/img_sold_out.png" alt="쿠폰이 모두 소진되었습니다. 다음기회를 기다려주세요." /></p>
		<% End If %>
	</div>
	<div class="appJoin">
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/74654/btn_go_v2.jpg" alt="" usemap="#Map"/>
			<map name="Map">
				<area shape="rect" coords="98,73,474,161" href="/event/appdown/">
				<area shape="rect" coords="675,72,1040,163" href="/member/join.asp">
			</map>
	</div>
	<div class="eventNotice">
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/74654/txt_noti.png" alt="이벤트 유의사항"/>
		<div class="notiContents">
			<ul>
				<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
				<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
				<li>- 쿠폰은 12/6(화) 23시 59분 59초에 종료됩니다.</li>
				<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
				<li>- 이벤트는 조기 마감될 수 있습니다.</li>
			</ul>
		</div>
	</div>
</div>

<!-- #include virtual="/lib/db/dbclose.asp" -->