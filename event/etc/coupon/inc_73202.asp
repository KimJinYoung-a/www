<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 쿠폰왕
' History : 2016-09-23 유태욱
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
	eCode = 66208
	getbonuscoupon1 = 2816
	getbonuscoupon2 = 2817
'	getbonuscoupon3 = 0000
Else
	eCode = 73202
	getbonuscoupon1 = 907	'10000/60000
	getbonuscoupon2 = 908	'30000/200000
'	getbonuscoupon3 = 000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")
%>
<style type="text/css">
img {vertical-align:top;}

.evt73202 {position:relative;}
.evt73202 .iconFlash{position:absolute; top: 17%; right: 27%; }
.iconFlash {
	animation-name:iconFlash; animation-duration:1.5s; animation-iteration-count:infinite; animation-fill-mode:both;
	-webkit-animation-name:iconFlash; -webkit-animation-duration:1.5s; -webkit-animation-iteration-count:infinite; -webkit-animation-fill-mode:both;
}
@keyframes iconFlash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}
@-webkit-keyframes iconFlash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}

.evt73202 .coupon{overflow:hidden;}
.evt73202 .coupon div {float:left;}

.eventNotice {overflow: hidden;}
.eventNotice img, .eventNotice .notiContents {float:left;}
.eventNotice .notiContents {background-color:#eeeeee; width:824px; height:200px;}
.eventNotice ul {position:relative; margin-top: 38px; }
.eventNotice ul li{font-size:12px; text-align: left; padding-top:5px;}

</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #09/27/2016 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n9월27일 자정까지 사용하세요.');
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
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			//var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			//winLogin.focus();
			//return false;
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>

	<!-- [W] 73202 -->
	<div class="evt73202">
		<h2>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/73202/txt_title.png" alt="9월 할인의 최강자를 가린다! 쿠폰왕" />
			<% if couponcnt1 >= 25000 and couponcnt1 < 30000 then %>
				<%' for dev msg : 쿠폰 어느것이라도 30000개중 5000개 이하로 남았을때, 마감 임박 이미지 icon_sold_out.png 보여주세요. %>
				<img class="iconFlash" src="http://webimage.10x10.co.kr/eventIMG/2016/73202/icon_sold_out.png" alt="마감임박"/>
			<% end if %>
		</h2>

		<div class="coupon">
			<% if couponcnt1 >= 30000 then %>
				<%' for dev msg : 쿠폰1 솔드아웃시 %>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/73202/txt_coupon_01_sold_out.png" alt="sold out" /></div>
			<% else %>
				<div>
					<a href="" onclick="jsevtDownCoupon('evtsel','<%= getbonuscoupon1 %>'); return false;">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/73202/txt_coupon_01.png" alt="6만원 이상 구매시 10,000원 쿠폰받기" />
					</a>
				</div>
			<% end if %>

			<% if couponcnt2 >= 30000 then %>
				<%' for dev msg : 쿠폰2 솔드아웃시 %>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/73202/txt_coupon_02_sold_out.png" alt="sold out" /></div>
			<% else %>
				<div>
					<a href="" onclick="jsevtDownCoupon('evtsel','<%= getbonuscoupon2 %>'); return false;">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/73202/txt_coupon_02.png" alt="20만원 이상 구매시 30,000원 쿠폰받기" />
					</a>
				</div>			
			<% end if %>
		</div>

		<div>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/73202/btn_app_download.png" alt="" usemap="#Map" />
			<map name="Map">
				<area shape="rect" coords="100,23,482,181" href="/event/appdown/" alt="텐바이텐 APP 다운" />
				<area shape="rect" coords="653,21,1052,178" href="/member/join.asp" alt="회원가입하고 구매하러 GO!" />
			</map>
		</div>
		<div class="eventNotice">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/73202/img_event_notice.png" alt="이벤트 유의사항"/>
			<div class="notiContents">
				<ul>
					<li>- 이벤트는 ID 당 1회만 참여할 수 있습니다. </li>
					<li>- 지급된 쿠폰은 텐바이텐에서만 사용 가능합니다.</li>
					<li>- 쿠폰은 9/27(화) 23시59분59초 종료됩니다.</li>
					<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
					<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
