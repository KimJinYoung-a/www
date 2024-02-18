<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2017 개강 맞이 쿠폰 쿠폰
' History : 2017-02-16 유태욱
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
	eCode = 66279
	getbonuscoupon1 = 2824
	getbonuscoupon2 = 2825
'	getbonuscoupon3 = 0000
Else
	eCode = 76271
	getbonuscoupon1 = 956	'10000/60000
	getbonuscoupon2 = 957	'30000/200000
'	getbonuscoupon3 = 000
End If

couponcnt1=0
couponcnt2=0

couponcnt1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
couponcnt2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")

%>
<style type="text/css">
.couponEvent button {background-color:transparent;}

.couponEvent .topic {position:relative; height:496px; background:#cbfaf0 url(http://webimage.10x10.co.kr/eventIMG/2017/76271/bg_hill.jpg) no-repeat 50% 0;}
.couponEvent .topic h2 {padding-top:138px;}
.couponEvent .topic p {margin-top:-12px;}

.couponEvent .coupon {position:relative; background-color:#78ccaf;}
.couponEvent .coupon .soldout {position:absolute; top:-36px; left:50%; margin-left:-442px;}
.couponEvent .coupon .btnArea {position:absolute; bottom:62px; left:50%; width:394px; margin-left:-197px;}
.couponEvent .coupon .btnArea img {margin:0;}
.couponEvent .coupon .close {position:absolute; top:-13px; right:12px;}
.couponEvent .coupon .close {animation:flash 1.5s infinite;}
@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}

.noti {position:relative; padding:35px 0; background-color:#f5f5f5; text-align:left;}
.noti h3 {position:absolute; top:50%; left:140px; margin-top:-31px;}
.noti ul {margin-left:331px; padding-left:60px; border-left:1px solid #e9e9e8;}
.noti ul li {position:relative; margin-top:7px; padding-left:13px; color:#7c7c7c; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#7c7c7c;}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #02/21/2017 23:59:59# then %>
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
					alert('쿠폰이 발급 되었습니다.\n2월21일 자정까지 사용하세요.');
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
	<!-- [W] 76271 쿠폰 이벤트 - 개강맞이 쿠폰 -->
	<div class="evt76271 couponEvent">
		<div class="topic">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/76271/tit_coupon.png" alt="개강맞이 쿠폰" /></h2>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/76271/txt_subcopy.png" alt="개강이 코앞으로 다가왔다! 여러분의 개강 준비를 도와줄 할인쿠폰을 만나보세요" /></p>
		</div>

		<div class="coupon">
			<%'' for dev msg : 쿠폰 소진 시 보여주세요  %>
			<% if couponcnt1 >= 30000 then %>
				<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76271/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다 다음 기회를 기다려주세요!" /></p>
			<% end if %>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/76271/img_coupon.jpg" alt="육만원 이상 구매시 만원 할인 쿠폰, 이십만원 이상 구매시 삼만원 할인 쿠폰 사용기간은 2017년 2월 20일부터 2월 21일 2일간 입니다." /></p>
			<div class="btnArea">
				<%'' for dev msg : 쿠폰 소진 시 쿠폰 다운 받기 버튼 클릭할 경우 alert 으로 쿠폰이 모두 소진되었다고 알려주세요! %>
				<button type="button" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;" class="btnDownloadAll"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76271/btn_download_all.png" alt="쿠폰 한번에 다운받기" /></button>

				<%' for dev msg : 쿠폰이 얼마 남아있지 않을때 보여주시고 솔드아웃 되면 숨겨주세요 %>
				<% if couponcnt1 >= 25000 and couponcnt1 < 30000 then %>
					<em class="close"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76271/ico_close.png" alt="마감임박" /></em>
				<% end if %>
			</div>
		</div>

		<div class="appdownJoin">
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/76271/txt_app_join.png" alt="" usemap="#link" />
			<map name="link" id="link">
				<area shape="rect" coords="92,28,485,156" href="/event/appdown/" alt="텐바이텐 앱 설치 아직이신가요? 텐바이텐 앱 다운" />
				<area shape="rect" coords="649,28,1061,158" href="/member/join.asp" alt="텐바이텐에 처음오셨나요? 회원가입하고 구매하러 가기!" />
			</map>
		</div>

		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/76271/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>이벤트는 ID당 1회만 참여할 수 있습니다.</li>
				<li><span></span>지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
				<li><span></span>쿠폰은 2/21(화) 23시 59분 59초에 종료됩니다.</li>
				<li><span></span>주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
				<li><span></span>이벤트는 조기 마감 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
	<!-- // 76271 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->