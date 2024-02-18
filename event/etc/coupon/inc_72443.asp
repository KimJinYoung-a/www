<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : W쿠폰 WWW
' History : 2016-08-11 유태욱
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
	eCode = 66181
	getbonuscoupon1 = 2805
	getbonuscoupon2 = 2806
'	getbonuscoupon3 = 2798
Else
	eCode = 72443
	getbonuscoupon1 = 894	'5000/30000
	getbonuscoupon2 = 895	'10000/60000
'	getbonuscoupon3 = 879	'30000/200000
End If

couponcnt=0
couponcnt = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")

%>
<style type="text/css">
img {vertical-align:top;}

.evt72443 {background:#40b3f9 url(http://webimage.10x10.co.kr/eventIMG/2016/72443/bg_sky.jpg) no-repeat 50% 0;}
.evt72443 button {background-color:transparent;}

.topic {position:relative; height:468px;}
.topic h2 {position:absolute; top:52px; left:346px;}
.topic h2 img {animation-name:pulse; animation-duration:1.2s;}
@keyframes pulse {
	0% {transform:scale(0.5);}
	100% {transform:scale(1);}
}

.topic p {position:absolute; top:99px; left:383px;}
.topic .close, .topic .soldout {position:absolute; top:258px; left:379px;}
.topic .close {animation-name:bounce; animation-duration:2.5s; animation-iteration-count:infinite; animation-fill-mode:both;}
@keyframes bounce {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-10px);}
	60% {transform: translateY(-5px);}
}
.topic .soldout {animation-name:flash; animation-duration:1.5s; animation-iteration-count:infinite; animation-fill-mode:both;}
@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}

.coupon {position:relative; height:460px;}
.coupon .btnDownloadAll,
.coupon .soldout {position:absolute; bottom:57px; left:50%; margin-left:-196px;}

.noti {position:relative; padding:45px 0 44px; background-color:#eee; text-align:left;}
.noti h3 {position:absolute; top:50%; left:100px; margin-top:-35px;}
.noti ul {margin-left:271px; padding-left:45px; border-left:1px solid #fff;}
.noti ul li {position:relative; margin-top:7px; padding-left:10px; color:#808290; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#808290;}
</style>
<script type="text/javascript">
$(function(){
		$("#animation").effect("pulsate", {times:3},600);
});

function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #08/17/2016 23:59:59# then %>
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
				alert('쿠폰이 발급 되었습니다.\n8월17일 자정까지 사용하세요.');
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
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}
</script>
<!-- [W] 72443 쿠폰 이벤트 - ￦쿠폰 -->
<div class="evt72443">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/tit_coupon.png" alt="￦쿠폰" /></h2>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/txt_coupon.png" alt="수요일 밤 12시 까지 무더운 여름, 차원이 다른 두 가지 할인쿠폰을 만나보세요!" /></p>
		<% if couponcnt >= 25000 and couponcnt < 30000 then %>
			<% '' for dev msg : 쿠폰이 얼마 남아있지 않을때 보여주세요 %>
			<strong class="close"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/ico_close.png" alt="마감임박" /></strong>
		<% end if %>

		<% if couponcnt >= 30000 then %>
			<% '' for dev msg : 쿠폰 모두 소진 시 보여주세요 %>
			<strong class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/txt_soldout_01.png" alt="솔드아웃" /></strong>
		<% end if %>
	</div>

	<div class="coupon">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/img_coupon.png" alt="삼만원 이상 구매시 오천원 할인 쿠폰, 육만원 이상 구매시 만원 할인 쿠폰 사용기간은 8월 16일부터 8월 17일 2일간 입니다." /></p>
		<% if couponcnt >= 30000 then %>
			<%'' for dev msg : 쿠폰 소진 시 보여주세요 %>
			<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/txt_soldout_02.png" alt="Sold Out 쿠폰이 모두 소진되었습니다" /></p>
		<% else %>
			<%''  for dev msg : 쿠폰 소진 시 숨겨주세요  %>
			<button type="button" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;" class="btnDownloadAll"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/btn_down.png" alt="쿠폰 한번에 다운받기" /></button>
		<% end if %>
	</div>

	<div class="appdownJoin">
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/txt_app_join.png" alt="" usemap="#link" />
		<map name="link" id="link">
			<area shape="rect" coords="92,28,485,156" href="/event/appdown/" alt="텐바이텐 앱 설치 아직이신가요? 텐바이텐 앱 다운" />
			<area shape="rect" coords="649,28,1061,158" href="/member/join.asp" alt="텐바이텐에 처음오셨나요? 회원가입하고 구매하러 가기!" />
		</map>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72443/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li><span></span>이벤트는 ID당 1회만 참여할 수 있습니다.</li>
			<li><span></span>지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
			<li><span></span>쿠폰은 8/17(수) 23시 59분 59초에 종료됩니다.</li>
			<li><span></span>주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
			<li><span></span>이벤트는 조기 마감 될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- //￦쿠폰 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->